import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Star[] Stars = new Star[60];
cube[] cubes = new cube[20];


SpinSpots spots;
SpinArm arm;

PGraphics pg;
float smoothedSample;
boolean drawing;
boolean musicvibe;
boolean Spinner;
boolean rainbow;
Minim minim;
AudioPlayer player;
AudioBuffer buffer;
AudioPlayer hongkong;

float lerpedAverage = 0;

float[] lerpedBuffer;

  boolean hongkongp;
boolean Heart;
int seconds1;
float HeartSize = 15;
int seconds;

void setup() {
  size(512, 512);
  background(0);
  colorMode(HSB);

  minim  = new Minim(this);
  player = minim.loadFile("cocaine jesuse.mp3", width); 
  hongkong = minim.loadFile("Hong Kong.mp3", width);
  player.play ();
  buffer = player.mix;
  lerpedBuffer = new float[buffer.size()];

  arm = new SpinArm(width/2, height/2, 0.01);
  spots = new SpinSpots(width/2, height/2, -0.02, 90.0);
  


  for ( int i = 0; i < cubes.length; i++) {
    cubes[i]= new cube (random(15));
  }

  for ( int i = 0; i < Stars.length; i++) {
    Stars[i]= new Star (10);
  }

  bruh();
  musicvibe = false;
}

void bruh()
{
  for (int i = 0; i < numStar; i ++)
  {
    sx[i] = random(0, width);
    sy[i] = random(0, height);
    sSize[i] = 2;
  }
}
int numStar = 250;
float[] sx = new float[numStar];
float[] sy = new float[numStar];
float[] sSize = new float[numStar];


void draw() 
{
  seconds1 ++;
  drawNow();



  if (keyPressed)
  {
    if (key == '1')
    {
      if (hongkongp == true)
      {
         hongkong.pause();
        hongkong.rewind();
          player.play();
          hongkongp = false;
      }
      
      background(0);
      musicvibe = true;
      drawing = false;
      Heart = false;
      rainbow = false;
      Spinner = false;
    }

    if (key == '2')
    {
     if (hongkongp == true)
      {
         hongkong.pause();
        hongkong.rewind();
          player.play();
          hongkongp = false;
      }
      
      background(0);
      drawing = true;
      musicvibe= false;
      Heart = false;
      rainbow = false;
      Spinner = false;
    }

    if (key == '3')
    {
      if (hongkongp == true)
      {
         hongkong.pause();
        hongkong.rewind();
          player.play();
          hongkongp = false;
      }
      
      background(0);
      drawing = false;
      musicvibe = false;
      Heart = true;
      rainbow = false;
      Spinner = false;
    }
  }

  if (key == '4')
  {
    
    player.pause();
    player.rewind();
    hongkong.play();
    
    hongkongp = true;
    
    background(0);
    drawing = false;
    musicvibe = false;
    Heart = false;
    rainbow = true;
    Spinner = false;
  }
  
  if (key == '5')
  {
     if (hongkongp == true)
      {
         hongkong.pause();
        hongkong.rewind();
          player.play();
          hongkongp = false;
      }
      
    background(0);
    drawing = false;
    musicvibe = false;
    Heart = false;
    rainbow = false;
    Spinner = true;
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


  if (drawing == true && mousePressed == true) 
  {
    stroke(#ffffff);
    strokeWeight(6);  
    line(mouseX, mouseY, pmouseX, pmouseY);
    seconds++;
  }

  if (Heart == true)
  {
    for (int i = 0; i < numStar; i ++)
    {
      float c1 = random(0, 255);
      strokeWeight(1);
      stroke(c1, 255, 255);
      line(sx[i] - sSize[i], sy[i], sx[i] + sSize[i], sy[i]);
      line(sx[i], sy[i] - sSize[i], sx[i], sy[i]+ sSize[i]);
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

  if (rainbow == true)

  {
    for (int i = 0; i < hongkong.bufferSize(); i ++) 
    { 
      pushMatrix();
      float c = map(i, 0, hongkong.bufferSize(), 0, 255); 
      stroke(c, 255, 255);
      float sample = (hongkong.left.get(i) * (height / 2)) + (hongkong.right.get(i) * (height / 2));
      smoothedSample = lerp(smoothedSample, sample, 0.001);
      for (float x = 0; x <=width; x += 100)
      {
        stroke(c, 255, 255);
        line(x - sample, height, width / 2 - smoothedSample, height / 2 );
        c += 1.4;
      }
      stroke(c, 255, 255);
      line(0 - smoothedSample, height/ 2, width, height/ 2);
      popMatrix();
    }
    
    
    for ( int i = 0; i < Stars.length; i++ )
    {
      
      Stars[i].display();
    }
  }

  if (Spinner == true)
  {
    for ( int i = 0; i < cubes.length; i++ )
    {
      cubes[i].ascend();
      cubes[i].display();
      cubes[i].top();
    }

    arm.update();
    arm.display();
    spots.update();
    spots.display();
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
      fill(c, 255, 255);
      float sample = buffer.get(i) * (height / 2);
      text(s, width/2 / sample, height/2);
    }
  }
}
