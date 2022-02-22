class MeleeExample extends Enemy{
  MeleeExample(){
    health = 50;
    healthMax = 10;
    attackRange = 50;
    speed = 1;
    worth = 1;
    gun = new Gun(20, 2, 3); //damage then reload respectively
    gun.bulletImage = loadImage("slash.png");
    ani = new Animation("melee", 2);
    followPattern = "melee";
  }
  
  void draw(){
    super.draw();
  }
}