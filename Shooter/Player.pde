class Player extends Sprite{
  Gun gun;
  float health; //changed to float
  float oldX, oldY;

  float healthMax; //added to have the bars start at the same length
  Player(int xArg, int yArg){
    x = xArg;
    y = yArg;
    gun = new Gun(); //defaults to a pistol when no arguments are passed in
    ani = new Animation("player", 4); //ANIMATION
    alive = true;
    immune = false;
    edgeMode = "collide";
    health = 100;
    healthMax = 100;
  }
  
  void draw(){
    super.draw();
    gun.draw();
    fatigue.draw();
    drawHealthBar(); //does what it says
    moderateSpeed();
    if(health <= 0){
      alive = false;
    }
    if(!alive){
      println("PLAYER DEAD");
      gm.tempLevel = gm.currentLevel;
      gm.currentLevel = new Level(-2);
      state = 5;
    }
    oldX = x;
    oldY = y;
  }
  
  void moderateSpeed(){ //Stops the player from shooting away when a button is held
    if(speedX >= 2){
      speedX = 2;
    }
    else if(speedX <= -2){
      speedX = -2;
    }
    if(speedY >= 2){
      speedY = 2;
    }
    else if(speedY <= -2){
      speedY = -2;
    }
  }
    void drawHealthBar(){ //draws a red bar in the top left for the player's health
    stroke(0,0,0);
    strokeWeight(2);
    fill(0,100,0);
    rect(5, 5, healthMax+2, 20);
    strokeWeight(0);
    fill(255,0,0);
    rect(7, 7, health/healthMax *100, 17);
  }
}