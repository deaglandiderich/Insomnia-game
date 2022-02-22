/* 
 COMP 1501 Project Demo
 GROUP MEMBERS: Declan Diderich, Hunter McCulloch
 DATE: April 4th, 2016
 */
Animation sky, blink;

PImage bg; //the background, I figured there might be some practicality to making it global
ArrayList <Bullet> bullets = new ArrayList<Bullet>(); //this has all the bullets
ArrayList<Enemy> enemies;
ArrayList <Item> items = new ArrayList<Item>(); //This has all the enemies
ArrayList<Obstacle> objects;

Player player; //The player
GM gm;

PImage dTitleLet[]; 
PImage cliff, dCliff, dSky;

int t;
int credits = 0;
int pro = 0;
int numEyes = 180;
int numTLetters = 8;
ArrayList flowers, dFlowers, titleLetters, eyes;
int state = 0; 
int numItems = 0;
int time;
int numFlowers = 20;
int numFlowersT = numFlowers* numFlowers;
Sun titleSun;
Sleep fatigue = new Sleep();

void setup() {
  size(800, 600); //creates screen size 800 pixels by 600 pixels
  frameRate(60); 
  gm = new GM();
  enemies = gm.currentLevel.enemies;
  player = new Player(400,300);
  t = 1;
  dTitleLet = new PImage[8];
  cliff = loadImage("cliff1.png"); //loads the cliff image
  dCliff = loadImage("dCliff1.png"); //loads the dark cliff image
  //Obstacle obstacle1 = new Obstacle(145,655,125,150);
  Obstacle obstacle2 = new Obstacle(145,170,195,470);
  Obstacle obstacle3 = new Obstacle(220,570,470,495);
  Obstacle obstacle4 = new Obstacle(630,655,200,495);
  objects = new ArrayList();
  //objects.add(obstacle1);
  objects.add(obstacle2);
  objects.add(obstacle3);
  objects.add(obstacle4);

  titleSun = new Sun(500, 25, "sun1"); //loads the sun's image

  sky = new Animation("sky", 10); //makes a new animation for the sky
  blink = new Animation("blink", 7); //makes a new animation for blinking

  flowers = new ArrayList(numFlowersT); //makes an array of flowers
  dFlowers = new ArrayList(numFlowersT); //makes an array of dark flowers
  eyes = new ArrayList(numEyes); //makes an array of backgorund numbers
  titleLetters = new ArrayList(8); //makes an array of title letters
    items = new ArrayList(numItems); //makes an array of title letters

  for (int i = 0; i< 8; i++)
    dTitleLet[i] = loadImage("dTitleLet" + (i+1) + ".png");

  for (int i = 0; i < numFlowers; i++) // displays rows and columns of flowers to prevent farther flowers from overlapping closer flowers
    for (int j = 0; j < numFlowers; j++)
      flowers.add(new Flower(i*50 + random(40), 345 + j*20 + random(10), 0, 200, 3000));
  
  for (int i = 0; i < numFlowers; i++) // displays rows and columns of flowers to prevent farther flowers from overlapping closer flowers
    for (int j = 0; j < numFlowers; j++)
      dFlowers.add(new Flower(i*50 + random(40), 345 + j*20 + random(10), 1, 200, 3000));

  for (int i = 0; i<numEyes; i++)  
    eyes.add(new Eye((i*40)%920, (i*30)%500, 100));

  for (int i = 0; i < 8; i++)
    titleLetters.add(new BouncingLetter(i*75, 0, ("titleLet" + (i + 1))));
}

void drawCredits() {
  background(0);
  textSize(32);
  textAlign(CENTER);
  fill(255);

  if (credits == 0)
    text("Hunter McCulloch", width/2, height/2);

  else if (credits == 1)
    text("Declan Diderich", width/2, height/2);

  else if (credits >= 2)
    state = 1;
}

void drawMenuA() {
  t++;
  sky.play(0, 0, (40000/(t*0.001)));

  titleSun.update(); //updates the sun's position

  image(cliff, 0, 345);

  for (int i = 0; i < numFlowersT; i++) { //draws each flower individually
    Piece a = (Piece)flowers.get(i);
    a.update();
  }

  ((Piece)titleLetters.get(0)).update();
  for (int i = 1; i < numTLetters; i++) {
    Piece a = (Piece)titleLetters.get(i);
    Piece b = (Piece)titleLetters.get(i-1);
    if (b.getY() >= 150) {
      a.update();
    }
  }

  if ((t > 500)&& ((t % 100)<50)) {
    textSize(32);
    textAlign(CENTER);
    fill(255);
    text("PRESS ENTER", width/2, height/2 + 100);
  }
  if (t>1400)
    blink.play(0, 0, 120);  
  if (t>1480)
    state = 2;
}

void drawMenuB() {
  t++;

  textSize(32);
  textAlign(CENTER);
  fill(255);

  background(0);

  for (int i = 0; i<numEyes; i++) {
    Piece a = (Piece)eyes.get(i);
    a.update();
  }

  for (int i = 0; i<8; i++){
    Piece a = (Piece)titleLetters.get(i);
    image(dTitleLet[i], a.getX(), a.getY()); 
  }
  image(dCliff, 0, 345);

  for (int i = 0; i < numFlowersT; i++) { //draws each flower individually
    Flower a = (Flower)dFlowers.get(i);
    a.update();
  }
  if ((t > 1000)&& ((t % 10)<5)) {
    textSize(32);
    textAlign(CENTER);
    fill(0);
    text("HURRY!", width/2, height/2 + 100);
  }
  }

void drawPrologue() {
  background(0);
  textSize(14);
  textAlign(CENTER);
  fill(255);

  if (pro == 0)
    text("For months, a pandemic has been rapidly infecting and killing the entire population of the world.", width/2, height/2);
  else if (pro == 1)
    text("Living isolated in a countryside home, you have escaped catching the disease...", width/2, height/2);
  else if (pro == 2)
    text("Until now. Its effects: falling asleep will kill you.", width/2, height/2);
  else if (pro == 3)  
    text("Move with the WASD Keys\nAim with the mouse and shoot by clicking\nCollect caffeine to stay awake.", width/2, height/2);
  else if(pro == 4)
    text("Survive the hordes of enemies and make it to the hospital to find the cure!",  width/2, height/2);
  else if (pro > 4)
    state = 4;
}

void drawGame() {
  gm.draw();
  for (int count = 0; count < bullets.size(); count ++) {
    bullets.get(count).draw();
  }
  for (int i = 0; i<items.size(); i++) {
    items.get(i).update();
  }
  for (int i = 0; i<objects.size(); i++) {
    objects.get(i).draw();
  }
  player.draw();
  for (int count = 0; count < enemies.size(); count ++) {
    enemies.get(count).draw();
  }
  println("" + mouseX + "/n" + mouseY);
}

void draw() {
  if (state == 0) //This is where I check the game state is on the title splash, anything that you have in your draw method for the titleSplash you'll want inside this
    drawCredits();
  else if (state == 1) 
    drawMenuA();
  else if (state == 2)
    drawMenuB();
  else if (state == 3)  
    drawPrologue();
  else if (state == 4)
    drawGame();
  else{
    println("paused");
    gm.draw();
  }
}

void keyPressed() {
  if (state == 0)
    credits++;
  else if (state == 1 || state == 2)
    state = 3;
  else if (state == 3)
    pro++;
  else if (state == 4) {
    if (key == 'w') {
      player.speedY += -2;
    } else if (key == 's') {
      player.speedY += 2;
    }
    if (key == 'a') {
      player.speedX += -2;
    } else if (key == 'd') {
      player.speedX += 2;
    }
    }
    if(state == 4 || state == 5){
      if(key == ' '){
      
      if(gm.currentLevel.state == -2){
        state = 1;
      }
      else if(gm.currentLevel.state == -1){
        state = 4;
        gm.currentLevel = gm.tempLevel;
        gm.currentLevel.initialize(gm.currentLevel.state);
      }
      else if(gm.currentLevel.state == -3){
        state = 4;
        gm.currentLevel = new Level(gm.tempLevel.state + 1);
      }
      else{
        gm.tempLevel = gm.currentLevel;
        gm.currentLevel = new Level(-1);
        state = 5;
      }
      }
      

      if(key == '1'){
        player.gun.changeTo("pistol");
      }else if(key == '2'){
        player.gun.changeTo("machinegun");
      }else if(key == '3'){
        player.gun.changeTo("shotgun");
      }else if(key == '4'){
        player.gun.changeTo("railgun");
      }
    }
}

void mouseClicked(){
    if (state == 4){
      player.gun.shoot(player);
    }
    else if(state == 5){
      if(gm.currentLevel.state == -1){
        if(mouseX > 250 && mouseX < 420 && mouseY > 200 && mouseY < 250){
          gm.currentLevel = gm.tempLevel;
          state = 4;
        }
        else if(mouseX > 250 && mouseX < 420 && mouseY > 265 && mouseY < 330){
          gm.currentLevel = new Level(0); //TO THE TITLE SCREEN
          state = 1;
        }
        else if(mouseX > 250 && mouseX < 420 && mouseY > 345 && mouseY < 415){
          stop();
        }
      }
    }
}

void keyReleased() { //I should say that my whole movement system could be improved, I have it so that upon the key press speed is added and on the key released it takes it away, however this causes the odd problem when a frame is skipped or pressing like three at a time. If you guys can think of something better no offense taken

  if (state == 4) {
    if (key == 'w') {
      player.speedY = 0;
    } else if (key == 's') {
      player.speedY = 0;
    }
    if (key == 'a') {
      player.speedX = 0;
    } else if (key == 'd') {
      player.speedX = 0;
    }
  }
}

public float time(float i){
return (i * 60);
}
