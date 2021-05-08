class cube {
  PVector location;
  float diameter;
  PVector velocity;

  cube(float tempD)
  {
    location = new PVector (random(height), width);
    velocity = new PVector (random(0.5), random(2));
    diameter = tempD;
  }
  void ascend() 
  {
    location.y = location.y - velocity.y;
    location.x = location.x + random(-2, 2);
  }

  void display()
  { 
    for (int i = 0; i < buffer.size(); i ++) 
    {
      pushMatrix();
      float c = map(i, 0, buffer.size(), 0, 255); 
      stroke(c, 255, 255);
      fill(c, 255, 255);
      float sample = buffer.get(i) * (height / 2); 
      smoothedSample = lerp(smoothedSample, sample, 0.001);
      rotate(radians(0));
      ellipse(location.x + smoothedSample / sample, location.y /sample, diameter, diameter);
      popMatrix();
    }
  }
  void top ()
  {
    if (location.y < -diameter/2) { 
      location.y = width+diameter/2;
    }
  }
}
