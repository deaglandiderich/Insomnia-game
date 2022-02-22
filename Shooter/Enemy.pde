/* Okay so the enemy system I've put through is pretty straight forward, at the bottom you'll see examples of possible enemies, in order to make an enemy that is considered separate
from the other enemy objects you have to create a new enemy passing in one of the example classes. ie: Enemy enemy = new enemy(RangedExample), dont forget the enemy must be 
added to the enemies arrayList
*/

class Enemy extends Sprite{
  Gun gun;
  float health,  oldX, oldY; //changed to float
  float healthMax; //added to keep the bars the same length
  int attackRange, worth;
  float speed;
  String followPattern; //So far all I have is "ranged" or "melee", the only thing this changes is that the ranged enemies stop moving when within range
  int ran = 0, fleeTimer = 0;
  
  
  Enemy(){
    immune = false;
    alive = true;
    edgeMode = "collide";
  }
  
  Enemy(Enemy enemy){
  health = enemy.health;
  healthMax = enemy.healthMax;
  gun = new Gun(enemy.gun);
  speed = enemy.speed;
  attackRange = enemy.attackRange;
  worth = enemy.worth;
  followPattern = enemy.followPattern;
  ani = enemy.ani;
  
  immune = false;
  alive = true;
  edgeMode = "collide";  
  ran = (int)random(4);
  switch(ran){
  case 0: x = 0; y = 100; break;
  case 1: x = 790; y = 0; break;
  case 2: x = 790; y = 590; break;
  case 3: x = 0; y = 590; break;
  default: x = 790; y = 590; break;
  }
}
  
  void draw(){
    super.draw();
    gun.draw();
    if (fleeTimer > 0)
      fleeTimer--;
    if(attackDecision()){
      gun.shoot(this);
    }
    movement();
    if(health <= 0){
      alive = false;
    }
    if(!alive){
      kill();
    }
      drawEnemyBar();
  }
  
  void kill(){ //gets rid of the enemy
    println("Enemy Killed");
    for(int i = 0; i < enemies.size(); i ++){
      if(enemies.get(i) == this){
        enemies.remove(i);
        drop();
      }
    }
  }
  
  void drop(){
    int r = (int)random(100);
    if (r > 90){
      numItems++; 
      items.add(new Item(this.x, this.y, numItems, items, 3));
    }
    else if (r > 75){
      numItems++; 
      items.add(new Item(this.x, this.y, numItems, items, 2));    
    }
      else if (r > 60){
      numItems++; 
      items.add(new Item(this.x, this.y, numItems, items, 1));
      }
  }
  
  void movement(){ //You'll simply have to make more else if's for more followPatterns if you want them
    PVector v0;
    float dst;

    oldX = x;
    oldY = y;
    
    for(int i = 0; i < enemies.size(); i ++){
     if(distanceTo(enemies.get(i)) < 20 && this != enemies.get(i)){
      if (fleeTimer <= 0){
       flee(speed, enemies.get(i));
       fleeTimer = 10;
       println("Meow");
      }
     }
    }
    if(fleeTimer<= 0){
    if(followPattern.equals("ranged")){
      if(distanceTo(player) > attackRange){
        follow(speed, player);
        stopAndTrack = false;
      }
    else if (distanceTo(player) < attackRange){
      flee(speed, player);
    }
    else{stopAndTrack(player);} //this stopandtrack thing makes the enemy stop moving and just shoot when it's within range
    }
    else if(followPattern.equals("melee")){
      follow(speed, player);
    }
    }
  
    if(evade){
      evadeTimer --;
      
      
//    for (int i = 0; i<objects.size(); i++){
      Obstacle a = closestObject();//(Obstacle)objects.get(i);
      
      dst=dist(x, y, a.x, a.y);
      v0= new PVector((a.x-x)/dst,(a.y-y)/dst); 
      v0.rotate(radians(45));

      if(evadeTimer <= 0){
        evade = false;
      }

      //v1=new PVector(cos(radians(90))*v0.x-sin(radians(90))*v0.y, sin(radians(90))*v0.x+cos(radians(90))*v0.y); 
      v0.normalize();
      speedX = v0.x*speed;
      speedY = v0.y*speed;
}
   } 
    
      
      /*{
        x = oldX;
        y = oldY;
        if(enemies.get(i).x > this.x){
          this.speedX = -1;
        }else{
          this.speedX = 1;
        }
        if(enemies.get(i).y > this.y){
          this.speedY = -1;
        }else{
          this.speedY = 1;
        }
      }*/

  
  int checkObjects(){
    int closest = 1000;
    for(int i = 0; i < objects.size(); i ++){
      if(distanceTo(objects.get(i)) < closest){
        closest = distanceTo(objects.get(i));
      }
    }
    return closest;
  }
    Obstacle closestObject(){
    int closest = 1000;
    Obstacle a = new Obstacle();
    for(int i = 0; i < objects.size(); i ++){
      if(distanceTo(objects.get(i)) < closest){
        closest = distanceTo(objects.get(i));
        a = objects.get(i);
      }
    }
    return a;
  }

  
  boolean attackDecision(){ //simply sees if the enemy should attack
    if(distanceTo(player) <= attackRange){
      return true;
    }
    return false;
  }
  
  void drawEnemyBar(){ //draws a small blue bar above the enemy's head
    stroke(0,0,255);
    fill(0,0,255); 
    rect(this.x-5, this.y + 25, health/healthMax*5, 5);
  }
}

      /*int biggest = 0;
      x += 10;
      biggest = checkObjects();
      speedX = 1;
      speedY = 0;
      x -= 20;
      if(checkObjects() > biggest){
        biggest = checkObjects();
        speedX = -1;
        speedY = 0;
      }
      x += 10;
      y += 10;
      if(checkObjects() > biggest){
        biggest = checkObjects();
        speedX = 0;
        speedY = 1;
      }
      y -= 20;
      if(checkObjects() > biggest){
        biggest = checkObjects();
        speedX = 0;
        speedY = -1;
      }
      y += 10;
    }*/