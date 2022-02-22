//basically this whole class is used only by the gun class so you shouldn't have to worry about it
class Bullet extends Sprite{
  int bulletSpeed, damage, penetration, lifeSpan; //penetration is the collisions the bullet can have with Sprites
  Sprite owner; //Who shot the bullet
  PVector mDir; //the vector that points from bullet to the mouse
  
  Bullet(float xDir, float yDir, PImage imageArg, Sprite object, int damageArg, int penetrationArg, int lSpan){
    image = imageArg;
    if(xDir == 0 && yDir == 0){
      xDir = 1;
    } 
    this.hit();
    bulletSpeed = 2;
    x = object.x;
    y = object.y;
    owner = object;
    damage = damageArg;
    penetration = penetrationArg;
    edgeMode = "destroy";
    mDir = null;
    speedX = xDir;
    speedY = yDir;
    lifeSpan = lSpan;
  }

   void draw(){
    this.x += speedX;
    this.y += speedY;
    this.lifeSpan--;
    if(alive){
      image(image, x, y);
    }
    if(!stopAndTrack){ //The Enemy class has a stopandtrack mode that would be messed if the updateDirection function happened
      updateDirection();
    }
    if(immune){ //Set immune to true and immuneTimer to seconds*60 to make the mob immune for this time
      immuneTimer --;
      if(immuneTimer <= 0){
        immune = false;
      }
    }
    edges();
    checkForHit();
    if(!alive){
      kill();
    }
    if (lifeSpan <= 0)
    kill();
  }
    
  void checkForHit(){ //based on the owner sees if anything has been hit
    if(owner == player){
      for(int i = 0; i < enemies.size(); i ++){
        Enemy enemy = enemies.get(i);
        if(distanceTo(enemy) < 20){
          enemy.health -= damage;
          println("Enemy Hit");
          enemy.hit();
          penetration --;
          if(penetration == 0){
            alive = false;
          }
        }
      }
    }
    else{
      if(distanceTo(player) < 20){
        player.health -= damage;
        kill();
      }
    }
  }
  
  void kill(){
    println("Bullet Killed");
    for(int i = 0; i < bullets.size(); i ++){
      if(bullets.get(i) == this){
        bullets.remove(i);
      }
    }
  }
}