public class Flower extends Piece{
  WaveAnimation ani;
  int speed, delay, type;
  
  public Flower(){  super();}
  
  public Flower(float xin, float yin, int t, int spd, int dly){ //creates a flower
    super(xin, yin);
    type = t;
    speed = spd;
    delay = dly;
    
    switch (type){ //declare the animation types here, to avoid declaring them in main
      case 0:  ani = new WaveAnimation("bFlower", 9);  break;
      case 1:  ani = new WaveAnimation("dFlower", 9); break;
    }//end typeSwitch
  } //end FlowerConstructor
  
  public void update(){  
    display();
  }
  
  public void display(){  
    switch (type){
      case 0: ani.progWavePlay(x, y, speed, delay, 10, 1000); 
      case 1: ani.progWavePlay(x, y, speed, delay, 10, 1000); 
      default: break;
    }
  }
  public void setType(int t){  type = t;}
}