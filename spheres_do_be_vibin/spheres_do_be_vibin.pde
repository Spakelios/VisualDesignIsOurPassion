import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim;
AudioPlayer player;
AudioBuffer buffer;

void setup () 
{
  size(1024, 512, P3D);
  colorMode(HSB);

  minim  = new Minim(this);
  player = minim.loadFile("cocaine jesuse", width); 
  player.play ();
  buffer = player.mix;
}

void draw () 

{
  background(0);
  for (int i = 0; i < buffer.size(); i ++) 
  {
    pushMatrix();
    translate(random(height),random(width), 1);
    rotate(radians(0));
    float c = map(i, 0, buffer.size(), 0, 255); 
    stroke(c, 255, 255);
    //fill(c, 255, 255);
    float sample = buffer.get(i) * (height / 2);
    sphere(10 - sample);
    popMatrix();
  }
}
