public class Item extends Piece{
  
int CBOOST1 = 1;
int CBOOST2 = 2;
int CBOOST3 = 3;
int type;

  public Item(float xin, float yin, int idin, ArrayList oin, int type){
      super(xin, yin, idin, oin);
      this.type = type;
      
      switch(type){
      case 1: im = loadImage("cBoost1.png");break;
      case 2: im = loadImage("cBoost2.png");break;
      case 3: im = loadImage("cBoost3.png");break;
      default: break;
    }
  }
  
  void update(){
    timer++;
  if ((timer % 40)<20) {
    y+=0.1;
  }
  else{
    y-=0.1;
  }
  if (timer <= 1000){
    pickUp();
    display();
  }
  else if(timer >1000 && timer <1500){
    if ((timer % 20)<10) {
       pickUp();
    display();
   
  }
  else
    pickUp();
  }
  else{
   for(int i = 0; i < items.size(); i ++){
        if(items.get(i) == this){
          items.remove(i);
    }
  }
  }
  }
  
  void display(){
    image(im, x, y);
  }
  
  void pickUp(){
    println(distanceTo(player));
    if (distanceTo(player) < 30){
      println("ITEM PICKUP");
      switch(type){
      case 1: fatigue.smallPickup(); break;
      case 2: fatigue.mediumPickup(); break;
      case 3: fatigue.largePickup(); break;
      default: break;
      }
      for(int i = 0; i < items.size(); i ++){
        if(items.get(i) == this){
          items.remove(i);
    }
  }
}
}
}