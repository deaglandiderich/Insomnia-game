public class BouncingLetter extends Piece{ //This is the bouncing letter object
  int state;
  float speed, acc;
  PImage letterImage;
  
  BouncingLetter() { super();}  
  
  BouncingLetter(float xin, float yin, String imIn){
    super(xin, yin, imIn);
    state = 0;
    speed = 3;
    acc = .015; //you can mess around with these variables a bit more if you aren't satisfied with the bounce
  }
  
  void update(){
    if(state == 0 || state == 3){
      y += speed;
      speed += speed * acc;
      x += 1;
    }
    else if(state == 1){
     y -= speed;
     speed -= speed * acc;
     x += 1;
    }
    if(y >= 300 && state == 0){
      state = 1;
      speed = 2;
    }
    else if(y <= 250 && state == 1){
      state = 3;
    }
    else if( y >= 300 && state == 3){
      state = 4;
    }
    display();
  }
  void display(){  image(im, x, y);}
}
