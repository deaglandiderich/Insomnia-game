// I usually make a GM class (game manager) to handle the actual game structure, this handles the levels, enemy spawning, etc..

class GM{
  Level currentLevel, tempLevel;
  int stage; //this is the actual level number, for the titles screen/credits/whatever else that isn't an actual level I would just use specific things like -1, -2, etc
  
  GM(){
    //imageMode(CENTER);
    frameRate(60);
    stage = 1;
    currentLevel = new Level(stage); //pass in the stage you want to make, is you wanted a store or pause screen or something you access in the middle of a stage you would have to have currentLevel as well as a tempLevel, so that you can revert back to the currentLevel when unpaused or whatever
  }
  
  void draw(){
    currentLevel.draw();
    //if(enemies.size() == 0 && currentLevel.enemyPower <= 0){ //If all enemies are killed a new level is initialized
      //bullets = new ArrayList<Bullet>();
      //stage ++;
      //currentLevel.initialize(stage);
      //player.x = 400; player.y = 300; //sets player to center of screen
    //}
  }
}
