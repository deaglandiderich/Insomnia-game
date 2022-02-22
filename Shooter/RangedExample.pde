class RangedExample extends Enemy{ //So you can make as many of these classes as you want, you'll just have to set each specific parameter as below
  RangedExample(){
    health = 20;
    healthMax = 20;
    attackRange = 150; //in pixels
    speed = 0.5;
    worth = 1; //See the explanation of the level system in GM, this is the cost to the level to make this enemy
    gun = new Gun(10, 5, 200); //damage, then reload respectively
    gun.bulletImage = loadImage("bullet.png");

    ani = new Animation("archer", 2);
    followPattern = "ranged";
  }
  
  void draw(){
    super.draw();
  }
}