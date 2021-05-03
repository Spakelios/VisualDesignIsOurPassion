
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim;
AudioPlayer player;
AudioBuffer buffer;

boolean checkKey(int k)
{
  if (keys.length >= k) 
  {
    return keys[k] || keys[Character.toUpperCase(k)];  
  }
  return false;
}
boolean[] keys = new boolean[526];

ArrayList<Bullet> bullets = new ArrayList<Bullet>();

void keyPressed()
{ 
  keys[keyCode] = true;
}

void keyReleased()
{
  keys[keyCode] = false; 
}

Player pp;
Player player1;

void setup()
{
  size(1024, 512, P3D);
  frameRate = 60;
  pp = new Player();
  player1 = new Player(100, 100);
  colorMode(HSB);

  minim  = new Minim(this);
  player = minim.loadFile("cocaine jesuse.mp3", width); 
  player.play ();
  buffer = player.mix;
}
void draw()
{
  background(0);
  stroke(255);
  pp.update();
  pp.render();

  player1.update();
  player1.render();

  for(int i = 0 ; i < bullets.size();  i ++)
  {
    Bullet b = bullets.get(i);
    b.render();
    b.move();
  }

  text("Bullets: " + bullets.size(), 20, 20);
  text("Framerate: " + frameRate, 20, 50);
}

//Bullet class
class Bullet
{
  float size = 50;
  float speed = 5;

  float x, y;
  float rotation;

  Bullet(float x, float y, float rotation)
  {
    this.x = x;
    this.y = y;
    this.rotation = rotation;
  }

  void render()
  {

    for (int i = 0; i < buffer.size(); i ++) 
    {
      pushMatrix();
      float c = map(i, 0, buffer.size(), 0, 255); 
      stroke(c, 255, 255);
      float sample = buffer.get(i) * (height / 2);
      translate(x, y);
      rotate(rotation);

      line(0, - (size / 2)- sample, 0, size / 2 + sample);
      popMatrix();
    }
  }

  void move()
  {
    float moveX = sin(rotation);
    float moveY = - cos(rotation);
    x += moveX * speed;
    y += moveY * speed;

    /*
    if(x > width || x < 0 || y > height || y < 0)
     {
     bullets.remove(this); //removes bullets from array list when they go off-screen
     }
     */
    if (x < 0)
    {
      x = width;
    }
    if (x > width)
    {
      x = 0;
    }
    if (y < 0)
    {
      y = height;
    }
    if (y > height)
    {
      y = 0;
    }
  }
}
