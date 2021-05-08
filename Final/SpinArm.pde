class SpinArm extends Spin {
  SpinArm(float x, float y, float s) 
  {
    super(x, y, s);
  }
  void display() 
  {
    {
      for (int i = 0; i < buffer.size(); i ++) 
      {
        pushMatrix();
        translate(x, y);
        float c = map(i, 0, buffer.size(), 0, 255); 
        stroke(c, 255, 255);
        float sample = buffer.get(i) * (height / 2); 
        smoothedSample = lerp(smoothedSample, sample, 0.001);
        angle += speed;
        rotate(angle);
        line(0 - smoothedSample, 0, 165, 0);
        popMatrix();
      }
    }
  }
}
