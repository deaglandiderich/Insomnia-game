public abstract class Piece{
  float x, y;
  int id, timer;
  PImage im;
  ArrayList extras;
  
  Piece() {  x = 0;  y = 0;  id = 0; timer = 0; extras = new ArrayList(null); im = null;}
  
  Piece(float xin, float yin, int idin, ArrayList oin) {  x = xin;  y = yin;  id = idin;  extras = oin;} //constructor for an object with many copies
  Piece(float xin, float yin, String imIn) {  x = xin;  y = yin;  im = loadImage(imIn+".png");} //constructor for a single object  with a single image
  Piece(float xin, float yin) {  x = xin;  y = yin;} //constructor for a single object with no image
  
  public abstract void update();
  public abstract void display();
  
   int distanceTo(Sprite object){ //distance to another Sprite
    float distance = sqrt( sq(object.x - this.x) + sq(object.y - this.y) );  
    //return int(sqrt(((object.x - this.x)*(object.x - this.x)) + ((object.y - this.y)*(object.y - this.y))));
    return (int)distance;
  }
  
  public float getX()     {  return this.x;}
  public float getY()     {  return this.y;}
  public float getTimer() {  return this.timer;}
}
