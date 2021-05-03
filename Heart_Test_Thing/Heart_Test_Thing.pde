import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim; // Minim Library
AudioPlayer player; // Playing audio
AudioBuffer buffer; // Gives access to the samples
float HeartSize = 15;


void setup()
{
  size(512, 512);

  minim = new Minim(this);
  player = minim.loadFile("Hong Kong.mp3", width);
  player.play();
  buffer = player.mix;
  lerpedBuffer = new float[buffer.size()]; 
  colorMode(HSB);
  
    for (int i = 0; i < numStar; i ++)
  {
    sx[i] = random(0, width);
    sy[i] = random(0, height);
    sSize[i] = 2;
}
}

float lerpedAverage = 0;
float[] lerpedBuffer;
float smoothedSample;

  int numStar = 250;
float[] sx = new float[numStar];
float[] sy = new float[numStar];
float[] sSize = new float[numStar];


void draw()
{
  background(0);
  
 for (int i = 0; i < numStar; i ++)
  {
    float c1 = random(0, 255);
    strokeWeight(1);
    stroke(c1, 255, 255);
    line(sx[i] - sSize[i] , sy[i], sx[i] + sSize[i], sy[i]);
    line(sx[i], sy[i] - sSize[i], sx[i],  sy[i]+ sSize[i]);
  }
  pushMatrix();
    strokeWeight(6); 
  translate(256, 256);

  for (int i = 0; i < buffer.size(); i ++)
  {
    float c = map(i, 0, buffer.size(), 0, 255);
    stroke(c, 255, 255);
    float sample = buffer.get(i);
    smoothedSample = lerp(smoothedSample, sample, 0.1f);
    float J = i * smoothedSample;
    point((-16*HeartSize*pow(sin(J ), 3)), (-(13*HeartSize*cos(J)-5*HeartSize*cos(2*J)-2*HeartSize*cos(3*J)-cos(4*J))));
  }
  popMatrix();
  
  //don't mind this it's a lil easter egg from when we worked on this
    textSize(3);
    text("Patrick", 250, 256);
}
