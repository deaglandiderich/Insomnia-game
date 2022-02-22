class Level{
  PImage bg;
  int enemyPower, state, guns;
  float spawn, spawnTimer;
  ArrayList<Enemy> enemyList = new ArrayList<Enemy>(); //this list is the possible enemies that could show up on that level
  ArrayList<Enemy> enemies = new ArrayList<Enemy>();
  Level(int stage){
    enemyPower = 0;
    bg = null;
    state = stage;
    initialize(state);
  }
  
  void draw(){
    image(bg, 0, 0);
    if (enemyPower > 0){
    if(state != 0){
      enemyTimer();
    }
    }
    else if(enemies.size() == 0 && state > 0){
      state = 5;
      initialize(-3);
    }
    if(!player.alive && this.state != -2 && this.state != -1){
      initialize(-2);  //GAME OVER CODE HERE
    }
  }
  
  void enemyTimer(){ //this handles enemy spawning, they all spawn in the top left corner right now but this can be easily changed
    spawnTimer --;
    if(spawnTimer <= 0){
      enemies.add(chooseEnemy());
      spawnTimer = spawn;
    }
  }
  
  Enemy chooseEnemy(){ //Upon spawning of an enemy, a type of enemy from the list for this level is chosen to spawn
    Enemy chosen;
    do{
      chosen = enemyList.get(int(random(0,enemyList.size())));
    }while(chosen.worth > enemyPower);
    enemyPower -= chosen.worth;
    return new Enemy(chosen);
  }
  void initialize(int stageArg){ //This is where all the levels/screens are created
    state = stageArg;
    
    if(state == 10){
      //access the title screen here
    }

     else if(state == -1){
      bg = loadImage("pause.png"); //replace
    }
    else if(state == -2){
      bg = loadImage("gameover.png");
    }
    else if(state == -3){
      bg = loadImage("win.png");
    }
    else if(state == 1){ //You will have to do all of the following for every level you make
      bg = loadImage("lvl1Bg.png"); //set background
      enemyPower = 20; //set the total powerLevel of enemies that will spawn
      spawn = time(3); //sets how fast a new enemy will spawn in seconds
      spawnTimer = spawn; //you need this
      enemyList = new ArrayList<Enemy>(); //recreate this list each time, add the type of enemies that you want the level to spawn (one instance of each)
      enemyList.add(new MeleeExample());
      enemyList.add(new RangedExample());
      guns = 4;
    }
    
    //When a stage is completed, the stage number is increased and the level at that number is initialized, so if there is an end game screen, you will want it to have the stage number after the last stage
  }
}
