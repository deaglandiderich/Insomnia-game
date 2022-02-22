public class Eye extends Piece {
  Animation ani;
  int speed, delay;

  public Eye(float xin, float yin, int spd) { //creates a flower
    super(xin, yin);
    speed = spd;
    ani = new Animation("eye", 16);
  } //end FlowerConstructor

  public void update() {
    timer++;
    display();
  }

  public void display() {
    if (timer >= 500)
      ani.play(x, y, speed);
    }
  }
