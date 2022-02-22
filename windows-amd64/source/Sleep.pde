class Sleep{
  float sleepValue; //amount of stamina
  float sleepMaxTotal = 5000; //starting amount of stamina
  float sleepAttackDamage = 600; //damage done by a stamina based attack
  float sleepPickup = 500; //stamina picked up by an item
  
  Sleep(){
    this.sleepValue = sleepMaxTotal;
  }
  
  void draw(){
    if (sleepValue > 0 )
    loseSleep();
    if (sleepValue > sleepMaxTotal)
    sleepValue = sleepMaxTotal;
    if(sleepValue <= 0){
      player.health = 0;
      player.alive = false;
    }
    drawSleepBar();
  }
  
  void loseSleep(){ //loses one stamina point per frame
    sleepValue--;
  }
  
  float getSleepValue(){ //returns current stamina, could be used for on-screen effects
    return sleepValue;
  }
  
  void sleepDamage(){ //stamina damage
    sleepValue -= sleepAttackDamage;
  }
  
    public void smallPickup(){ //small stamina pickup
    sleepValue += sleepPickup;
  }
    public void mediumPickup(){ //small stamina pickup
    sleepValue += (sleepPickup*2);
  }
  
  public void largePickup(){ //large stamin pickup
    sleepValue += (sleepPickup * 3);
  }
  
  void resetSleepValue(){ //start of a level, can give back all stamina, or for very large pickup item
    sleepValue = sleepMaxTotal;
  }
  
  void sleepUpgrade(){ //end of level total stamna upgrade
    sleepMaxTotal += 600;
  }
  
  void drawSleepBar(){ //draws a green stamina bar in the top left of the screen.
  /*  stroke(0,255,0);
    rect(5, 30, sleepValue/sleepMaxTotal * 100, 10);
    */
    stroke(0,0,0);
    strokeWeight(2);
    fill(106, 78, 0);
    rect(5, 30, sleepMaxTotal/50+2, 20);
    strokeWeight(0);
    fill(206,178,35);
    rect(7, 32, sleepValue/sleepMaxTotal * 100, 17);
  }
  
}
