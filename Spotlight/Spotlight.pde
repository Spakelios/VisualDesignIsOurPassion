import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim;
AudioPlayer player;
AudioBuffer buffer;

Star[] Stars = new Star[60];

float smoothedSample;
float lerpedAverage = 0;
float[] lerpedBuffer;

void setup()
{
  size(512, 512 );
  colorMode(HSB);
  minim  = new Minim(this);
  player = minim.loadFile("Hong Kong.mp3", width); 
  player.play ();
  buffer = player.mix;

  lerpedBuffer = new float[buffer.size()];


  for ( int i = 0; i < Stars.length; i++) {
    Stars[i]= new Star (30);
  }
}


void draw()
{
  background(0);
  for (int i = 0; i < buffer.size(); i ++) 
  {
    float c = map(i, 0, buffer.size(), 0, 255); 
    stroke(c, 255, 255);
    float sample = buffer.get(i) * (height / 2);
    smoothedSample = lerp(smoothedSample, sample, 0.001);
    for (float x = 0; x <=width; x += 100)
    {
      stroke(c, 255, 255);
      line(x - sample, height, width / 2 - smoothedSample, height / 2 );
      c += 1.4;
    }
    stroke(c, 255, 255);
    line(0 - smoothedSample, height/ 2, width, height/ 2);
  }
  for ( int i = 0; i < Stars.length; i++ )
  {
    Stars[i].display();
  }
}
