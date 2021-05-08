class SpinSpots extends Spin
{
 float xPos;
  float dim;
  SpinSpots(float x, float y, float s, float d) {
    super(x, y, s);
    dim = d;
  }
  void display() 
  {
    {
      for (int i = 0; i < buffer.size(); i ++) 
      {

        pushMatrix();
        float c = map(i, 0, buffer.size(), 0, 255); 
        stroke(c, 255, 255);
        float sample = buffer.get(i) * (height / 2); 
        smoothedSample = lerp(smoothedSample, sample, 0.001);
        angle += speed;
        rotate(angle);
        ellipse(xPos- smoothedSample, sample, dim, dim);
        ellipse(xPos, 0, dim, dim);
        xPos++;
        popMatrix();
      }
    }
  }
}
