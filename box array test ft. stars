import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

star[] stars = new star[3];
cube[] cubes = new cube[40];

Minim minim;
AudioPlayer player;
AudioBuffer buffer;

float totalScore;

void setup () 
{
  size(1024, 512, P3D);
  colorMode(HSB);
  frameRate = 60;

  for ( int i = 0; i < stars.length; i++)
  {

    stars[i]= new star(2);
  }
  
    for ( int i = 0; i < cubes.length; i++)
  {

    cubes[i]= new cube(5);
  }

  minim  = new Minim(this);
  player = minim.loadFile("Namine.mp3", width); 
  player.play ();
  buffer = player.mix;
}
void draw ()

{
  println(mouseX);
  println(mouseY);
  
  background(0);
  
  
    for ( int i = 0; i < cubes.length; i++ ) 
  {
    cubes[i].display();
    cubes[i].ascend();
    cubes[i].top();
  }

  for ( int i = 0; i < stars.length; i++ ) 
  {
    stars[i].display();
    stars[i].ascend();
    stars[i].top();
  } 
}

class cube 
{
  float cubeX = random(width);
  float cubeY = height;
  float cubeSize;
  float cubeSpeed;

  cube (float tempD)
  {
    cubeX = random(width);
    cubeY = height;
    cubeSize = tempD;
    cubeSpeed = random(0.5, 2);
  }

  void display() 
  {
    for (int i = 0; i < buffer.size(); i ++) 
    {
      pushMatrix();
      translate(cubeX, cubeY, 1);
      rotate(radians(cubeSpeed));
      float c = map(i, 0, buffer.size(), 0, 255); 
      stroke(c, 255, 0);
      fill(c, 255, 255);
      float sample = buffer.get(i) * (height / 2);
      box(cubeSize,10,cubeSize - sample);
      popMatrix();
    }
   }
  void ascend() 
  {
    cubeY = cubeY - cubeSpeed;
    cubeX = cubeX + random(-2, 2);
  }

  void top ()
  {
    if (cubeY < -cubeSize/2) { 
      cubeY = height+cubeSize/2;
    }
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
class star 
{

  float starX = random(width);
  float starY = height;
  float starSize ;
  float starSpeed;


  void display () 

  {
    for (int i = 0; i < buffer.size(); i ++) 
    {
      noStroke();
      float c = map(i, 0, buffer.size(), 0, 255); 
      stroke(c, 255, 255);
      noFill();
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



