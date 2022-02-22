public class Sun extends Piece{

  public Sun(){  super();}
  
  public Sun(float xin, float yin, String imIn){super(xin, yin,imIn);}
  
  public void update(){
     timer++;
     x-=0.1;
     y+=(sq(timer/500)/500);
     display();
  }
  
  public void display(){
    image(im, x, y);
  }
}
