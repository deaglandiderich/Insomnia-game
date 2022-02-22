class Obstacle extends Sprite{
  int x1, x2, y1, y2; //x1, y1 is top left corner, x2, y2 is bottom right
  Obstacle(){
    super();
    image = loadImage("player1.png");
  }
  Obstacle(int x1, int x2, int y1, int y2){
    super();
    image = loadImage("player1.png");
    this.x1 = x1;
    this.x2 = x2;
    this.y1 = y1;
    this.y2 = y2;
  }
  void draw(){
    collision(player);
    for(int i = 0; i < enemies.size(); i ++){
      collision(enemies.get(i));
    }
    for(int i = 0; i < bullets.size(); i ++){
      collision(bullets.get(i));
    }

  }
  void collision(Bullet pew){
  if(pew.x > x1-5 && pew.x < x2+5 && pew.y > y1-5 && pew.y < y2+5)
    pew.kill();
  }
  
  void collision(Sprite object){
    PVector avg = new PVector(object.x+16, object.y+16);
    if(avg.x > x1-10 && avg.x < x2+10 && avg.y > y1-10 && avg.y < y2+10){
      if(avg.x < x1 + 5){
        if(object.speedX > 0)
          object.speedX = 0;
        
      }
      else if(avg.x > x2-5){
        if(object.speedX < 0)
          object.speedX = 0;
        
      }
      if(avg.y < y1+5){
        if(object.speedY > 0)
          object.speedY = 0;
        
      }
      else if(avg.y > y2 - 5){
        if(object.speedY < 0)
          object.speedY = 0;
        
      }
      if(object != player){ //TAKE THIS STATEMENT OUT TO STOP THE ENEMIES FROM DOING THAT WEIRD WALL THING
        object.evade = true;
        object.evadeTimer = 30;
      }
    }
  }
}
