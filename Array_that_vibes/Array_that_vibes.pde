import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

star[] stars = new star[10];
line[] lines = new line[30];

Minim minim;
AudioPlayer player;
AudioBuffer buffer;

float smoothedSample;

void setup () 
{
  size(1024, 512, P2D);
  colorMode(HSB);

  for ( int i = 0; i < stars.length; i++)
  {

    stars[i]= new star(2);
  }

  for ( int i = 0; i < lines.length; i++)
  {

    lines[i]= new line(2);
  }

  minim  = new Minim(this);
  player = minim.loadFile("Kakusei.mp3", width); 
  player.play ();
  buffer = player.mix;
}
void draw ()

{
  background(0);
  for ( int i = 0; i < lines.length; i++ ) 
  {
    lines[i].display();
    lines[i].ascend();
    lines[i].top();
  }
  
  for ( int i = 0; i < stars.length; i++ ) 
  {
    stars[i].display();
    stars[i].ascend();
    stars[i].top();
  }
}

void star(float x, float y, float radius1, float radius2, int npoints) 
{
  float angle = TWO_PI / npoints;
  float halfAngle = angle/2.0;
  
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) 
  {
    
    float sx = x + cos(a) * radius2;
    float sy = y + sin(a) * radius2;
    vertex(sx, sy);
    sx = x + cos(a+halfAngle) * radius1;
    sy = y + sin(a+halfAngle) * radius1;
    vertex(sx, sy);
    
  }
  endShape(CLOSE);
}

class line 
{

  float lineX = random(width);
  float lineY = height;
  float lineSize;
  float lineSpeed;


  void display () 

  {
    for (int i = 0; i < buffer.size(); i ++) 
    {
      noStroke();
      float c = map(i, 0, buffer.size(), 0, 255); 
      stroke(c, 255, 255);
      fill(c, 255, 255);
      float sample = buffer.get(i) * (height / 2);
      //line(lineX, lineY, 30 , 7 + sample, 3);
      ellipse(lineX,lineY + sample,lineSize,lineSize);
    }
  }


  line (float tempD)
  {
    lineX = random(width);
    lineY = height;
    lineSize = tempD;
    lineSpeed = random(0.5, 2);
  }

  void ascend() 
  {
    lineY = lineY - lineSpeed;
    lineX = lineX + random(-2, 2);
  }

  void top ()
  {
    if (lineY < -lineSize/2) { 
      lineY = height+lineSize/2;
    }
  }
}

class star 
{

  float starX = random(width);
  float starY = height;
  float starSize;
  float starSpeed;


  void display () 

  {
    for (int i = 0; i < buffer.size(); i ++) 
    {
      noStroke();
      float c = map(i, 0, buffer.size(), 0, 255); 
      stroke(c, 255, 255);
      fill(c, 255, 255);
      float sample = buffer.get(i) * (height / 2);
      star(starX, starY, 7 , 7 + sample, 3);
    }
  }


  star (float tempD)
  {
    starX = random(width);
    starY = height;
    starSize = tempD;
    starSpeed = random(0.5, 2);
  }

  void ascend() 
  {
    starY = starY - starSpeed;
    starX = starX + random(-2, 2);
  }

  void top ()
  {
    if (starY < -starSize/2) { 
      starY = height+starSize/2;
    }
  }
}

