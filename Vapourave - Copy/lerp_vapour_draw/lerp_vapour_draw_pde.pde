import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

PGraphics pg;
float smoothedSample;
boolean drawing;
boolean musicvibe;
Minim minim;
AudioPlayer player;
AudioBuffer buffer;

float lerpedAverage = 0;

float[] lerpedBuffer;

int seconds1;

int seconds;

void setup() {
  size(640, 360);
  background(0);
  colorMode(HSB);

  minim  = new Minim(this);
  player = minim.loadFile("cocaine jesuse.mp3", width); 
  player.play ();
  buffer = player.mix;
  lerpedBuffer = new float[buffer.size()];
  
  musicvibe = false;
  
}

void draw() 
{
   seconds1 ++;
   drawNow();
   
  if (keyPressed)
  {
    if (key == '1')
    {
      background(0);
      musicvibe = true;
      drawing = false;
    }
    
    if (key == '2')
    {
      background(0);
      drawing = true;
      musicvibe= false;
    }
  }
  
  if (musicvibe == true)
  {
     
    background(0);
  float halfH = height / 2;
    strokeWeight(1);
    for (int i = 0; i < buffer.size(); i ++)
    {
    
    stroke(map(i, 0, buffer.size(), 0, 255), 255, 255);
    lerpedBuffer[i] = lerp(lerpedBuffer[i], buffer.get(i), 0.1f);
    float sample = lerpedBuffer[i] * width * 2;    
    stroke(map(i, 0, buffer.size(), 0, 255), 255, 255);
    line(i, height / 2 - sample, i, height/2 + sample); 
  }
  
  float sum = 0;
  for (int i = 0; i < buffer.size(); i ++)
  {
    sum += abs(buffer.get(i));
  }

  noStroke();
  float average = sum / buffer.size();
  lerpedAverage = lerp(lerpedAverage, average, 0.1f);
  }

  for (int i = 0; i < buffer.size(); i ++)
  {
    if (drawing == true && mousePressed == true) 
    {
    float c = map(i, 0, buffer.size(), 0, 255); 
    stroke(c, 255, 255);
    float sample = buffer.get(i) * (height / 2);  // buffer[i]
    smoothedSample = lerp(smoothedSample, sample, 0.001);
    //stroke(#ffffff);
    strokeWeight(6);  
    line(mouseX, mouseY- sample, pmouseX + smoothedSample, pmouseY);
    seconds++;
    
    }
    }
}


void mouseReleased()
{
  if (drawing == true)
  {
    if (seconds > 20)
    {
    background(0);
    seconds = 0;
    }
  }
  
 
}
  void drawNow()
{
  if (seconds1 < 10)
  {
    for (int i = 0; i < buffer.size(); i ++) 
    {
    fill(255);
    PFont f = createFont("georgia", 50);
    String s = "PRESS THE NUMBER KEYS";
    textSize(30);
    textFont(f);
    float c = map(i, 0, buffer.size(), 0, 255); 
    stroke(c, 255, 255);
    fill(c, c, c);
    float sample = buffer.get(i) * (height / 2);
    text(s, width/2 / sample, height/2);
    }
  }
}
