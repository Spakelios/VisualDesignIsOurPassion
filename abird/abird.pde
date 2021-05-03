import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Shape[] shapes = new Shape[30];

Minim minim;
AudioPlayer player;
AudioBuffer buffer;

float smoothedSample;
float lerpedAverage = 0;
float[] lerpedBuffer;


void setup() {
  size(1024, 512, P2D);
  background(0);
  colorMode(HSB);

  minim  = new Minim(this);
  player = minim.loadFile("Hong Kong.mp3", width); 
  player.play ();
  buffer = player.mix;
  lerpedBuffer = new float[buffer.size()];

  for (int i = 0; i < shapes.length; i++ ) {
    int r = int(random(2));
    if (r == 0) {
      shapes[i] = new Circle(320, 180, 32, color(random(255), 100));
    } else {
      shapes[i] = new Square(320, 180, 32);
    }
  }
}

void draw() {
  for (int i = 0; i < shapes.length; i++ ) {
    shapes[i].jiggle();
    shapes[i].display();
  }
}
