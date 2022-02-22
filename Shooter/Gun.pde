class Gun{
  int damage, penetration, lifeSpan, drain; //reload you will set in seconds, reloadTimer takes care of itself, I should also mention that reload is just the time between shots not between magazines or anything like that
  float reload,reloadTimer;
  PImage bulletImage;
  /* Okay so my bullet system might be a little overcompliacted I'm not sure, but when you make a new gun, in order to change the bullet images, you must call the newBullet
  function and pass in (stay with me here) the name of the folder that these images are in. You'll notice in the data folder one called arrow, slash, and bullet. In these
  folders are 8 images, each representing a direction the bullet can go. These images must be .png, and labeled name0 through name7, name0 being the bullet pointing straight 
  up, name1 45 degrees clockwise of that, etc. If you've got the player rotating with the mouse and everything then it will probably be easier just to have one image that you 
  rotate based on the players rotation. I simply didn't get around to figuring out how to do this. */
  
  boolean canShoot;
  String name; //I used this so that you can have premade guns, please see the function called changeTo
  
  Gun(){ //3 constructors, this defaults the gun to the pistol
    changeTo("pistol");
    canShoot = true;
  }
   Gun(Gun other){
    this.bulletImage = other.bulletImage;
    this.damage = other.damage;
    this.reload = other.reload;
    this.reloadTimer = this.reload;
    this.penetration = other.penetration;
    canShoot = true;
    this.lifeSpan = other.lifeSpan;
  }
  Gun(int damage, float reload, int lSpan){ //pass in reload (in seconds) and damage
    this.damage = damage;
    this.reload = time(reload);
    reloadTimer = this.reload;
    penetration = 1;
    canShoot = true;
    lifeSpan = lSpan;
  }
  Gun(int damage, float reload, int penetration, int lSpan){ //also pass in penetration (otherwise will be 1)
    this.damage = damage;
    this.reload = time(reload);
    this.penetration = penetration;
    reloadTimer = this.reload;
    penetration = 1;
    canShoot = true;
    lifeSpan = lSpan;  
  }
  
  void draw(){
    timers();
  }
  
  void timers(){ //handles reload right now
    if(!canShoot){
      reloadTimer --;
      if(reloadTimer <= 0){
        canShoot = true;
        reloadTimer = reload;
      }
    }
  }
  
  void shoot(Sprite object){ //The gun shoots, pass in who shot it
    PVector dir;
    if (object == player)
      dir = new PVector(mouseX - object.x, mouseY-object.y);
    else
      dir = new PVector(player.x - object.x, player.y-object.y);

      dir.setMag(5);
    if(canShoot){
      fatigue.sleepValue -= drain;
      Bullet b = new Bullet(dir.x, dir.y, bulletImage, object, damage, penetration, lifeSpan);
      bullets.add(b);
      canShoot = false;
    }
  }
  
  void changeTo(String nameArg){ //This is where you can changeto preset weapons
    name = nameArg; 
    if(name.equals("pistol")){ //A pretty basic example, imitate with different specifics to create other weapons
      bulletImage = loadImage("bullet.png");
      damage = 10;
      reload = time(1);
      reloadTimer = reload;
      penetration = 1;
      drain = 100;
      lifeSpan = 70;
   }
      else if(name.equals("machinegun")){
     bulletImage = loadImage("MACHINEGUNBULLET.png");
     damage = 5;
     reload = time(0);
     reloadTimer = reload;
     penetration = 1;
     drain = 50;
     lifeSpan = 60;

   }
   else if(name.equals("shotgun")){
     bulletImage = loadImage("SHOTGUNBULLET.png");
     damage = 50;
     reload = time(3.5);
     reloadTimer = reload;
     penetration = 3;
     drain = 200;
     lifeSpan = 30;

   }
   else if(name.equals("railgun")){
     bulletImage = loadImage("RAILGUNSHOT.png");
     damage = 25;
     reload = time(2.75);
     reloadTimer = reload;
     penetration = 100;
     drain = 350;
     lifeSpan = 200;

   }
  }
} 