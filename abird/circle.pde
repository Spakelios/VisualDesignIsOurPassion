class Circle extends Shape {

  color c;

  Circle(float x_, float y_, float r_, color c_) {
    super(x_, y_, r_); 
    c = c_;
  }

  void jiggle() {
    super.jiggle();

    r += random(-1, 1); 
    r = constrain(r, 0, 100);
  }

  void display() {
    for (int i = 0; i < buffer.size(); i ++) 
    {
      float c = map(i, 0, buffer.size(), 0, 255); 
      stroke(c, 255, 255);
      float sample = buffer.get(i) * (height / 2);  // buffer[i]
      smoothedSample = lerp(smoothedSample, sample, 0.001);
      //ellipseMode(CENTER);
      fill(c,255,255);
      ellipse(x - smoothedSample / sample, y, r, r);
    }
  }
}
