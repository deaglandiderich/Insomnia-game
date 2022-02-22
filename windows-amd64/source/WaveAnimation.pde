public class WaveAnimation extends Animation{

  public WaveAnimation() {  super();}
  
  public WaveAnimation(String imName, int lenIn) {  super(imName, lenIn);}
  
  void progWavePlay(float x, float y, int speedIn, int delayIn, int freqIn, int limIn){ //plays the animation with a delay on the whole thing, as well as a wave from left to right
    speed = speedIn; 
    delay = delayIn;

    if (((this.frame % len) == 0)&&(x<= cXp)&&(millis()>timer+delay)) //if the object is standing still, and it needs to be updated, and its delay timer is up:
              frame = (frame+1) % len; //the frame is the remainder of the next frame divided by the total length; once last frame reached, it resets to zero
 
    else if (((this.frame % len) != 0)&&(millis()>timer+speed)){ //otherwise, if it's in motion, and its timer is up:
        frame = (frame+1) % len; //the frame is the remainder of the next frame divided by the total length; once last frame reached, it resets to zero
        timer = millis();
    } 
  
    if(millis()>(timer + delay))  cXp+=freqIn;
    if (cXp >limIn)  cXp = 0;

    image(aFrames[frame], x, y); //display current frame
  }
}
