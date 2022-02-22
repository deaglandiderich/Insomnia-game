class Sprite{
  float x, y, dirX, dirY, speedX, speedY, immuneTimer;
  Animation ani; //The sprite
  int evadeTimer;
  PImage image;
  String edgeMode; //Change between "collide" and "destroy" to change what happens when the sprite hits the edge
  boolean stopAndTrack, alive, immune; //these are all state variables
  boolean right, evade; //Specifically for when the player has stopped
  Sprite(){
     stopAndTrack = false;
     immune = false;
     alive = true;
     evade = false;
  }
  Sprite(float x, float y){
    stopAndTrack = false;
    immune = false;
    alive = true;
    this.x = x;
    this.y = y;
    evade = false;
  }
  void draw(){
    x += speedX;
    y += speedY;
    if(alive){
      ani.play(x-10, y-10, 150); //PLAY ANIMATION (BULLET HAS AN IMAGE)
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
  }
  
  void edges(){ //Edge collision
    if(x > 790){
      if(edgeMode.equals("collide")){
        x = 790;
      }else if(edgeMode.equals("destroy")){
        this.alive = false;
      }
    }else if(x < 10){
      if(edgeMode.equals("collide")){
        x = 10;
      }else if(edgeMode.equals("destroy")){
        this.alive = false;
      }
    }
    if(y > 590){
      if(edgeMode.equals("collide")){
        y = 590;
      }else if(edgeMode.equals("destroy")){
        this.alive = false;
      }
    }else if(y < 10){
      if(edgeMode.equals("collide")){
        y = 10;
      }else if(edgeMode.equals("destroy")){
        this.alive = false;
      }
    }
  }
  
  void updateDirection(){ //Based on the speed of the sprite, the direction is changed appropriately
    if(speedX > 0){
      dirX = 1;
    }
    else if(speedX < 0){
      dirX = -1;
    }
    else if(this != player){
      dirX = 0;
    }
    else if(!right && speedY == 0){
      dirX = -1;
    }
    if(speedY > 0){
      dirY = 1;
    }
    else if(speedY < 0){
      dirY = -1;
    }
    else{
      dirY = 0;
    }
  }
  
  void follow(float speed, Sprite object){ //Pass in the speed you want to chase and the other Sprite that you want to chase
    if(object.x > x + 20){
      dirX = 1;
    }
    else if(object.x < x - 20){
      dirX = -1;
    }
    else{
      dirX = 0;
    }
    if(object.y > y + 18){
      dirY = 1;
    }
    else if(object.y < y - 18){
      dirY = -1;
    }
    else{
      dirY = 0;
    }
    speedX = dirX * speed;
    speedY = dirY * speed;
  }
  
  void flee(float speed, Sprite object){
    if(object.x > x){
      dirX = -1;
    }
    else if(object.x < x){
      dirX = 1;
    }
    else{
      dirX = 0;
    }
    if(object.y > y){
      dirY = -1;
    }
    else if(object.y < y){
      dirY = 1;
    }
    else{
      dirY = 0;
    }
    speedX = dirX * speed;
    speedY = dirY * speed;
  }
  void stopAndTrack(Sprite object){ //This is only used for the ranged enemy right now, the enemy still tracks the player to shoot at just without moving
    follow(0, object);
    stopAndTrack = true;
  }
  
  int distanceTo(Sprite object){ //distance to another Sprite
    float distance = sqrt( sq(object.x - this.x) + sq(object.y - this.y) );  
    //return int(sqrt(((object.x - this.x)*(object.x - this.x)) + ((object.y - this.y)*(object.y - this.y))));
    return (int)distance;
  }
  
  void hit(){ //When something is hit it becomes immune for a short period so that the bullet doesnt collide multiple times
    immune = true;
    immuneTimer = 30;
  }
}
