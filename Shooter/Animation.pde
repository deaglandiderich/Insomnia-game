public class Animation{
  PImage aFrames[];
  String fullName;
  int len, frame, timer;
  float speed, delay, cXp;

  Animation(){  fullName = "";  len = 0;  frame = 0;  speed = 0;  delay = 0;  timer = 0;  cXp = 0;}
  
  Animation (String imName, int lenIn){
    len = lenIn; //number of frames in animation
    aFrames = new PImage[len]; //array which will contain all frames of animation
    
    for (int i = 0; i<len; i++){ //for every frame in the animation
      fullName = imName + (i+1) + ".png"; //make the image load the correct frame (all frames have the same initial name with the only difference of the number
      aFrames[i] = loadImage(fullName); //sets the current position of the array to the corresponding frame
    }
  }
  
  void play(float x, float y, float speedIn){ //plays the animation repeatedly
    speed = speedIn;
    if (millis() > timer + speed){
      frame = (frame+1) % len; //the frame is the remainder of the next frame divided by the total length; once last frame reached, it resets to zero
      timer = millis();
    }
    image(aFrames[frame], x, y); //display current frame   
  } 
  
  
}