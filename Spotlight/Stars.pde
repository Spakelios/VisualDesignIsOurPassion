class Star
{
  float starX; 
  float starY;
  float starSize = 1;

  Star (float tempD)
  {
    starX = random(0, width);
    starY = random(0, height/2);
    starSize= random(2);
  }


  void display () 
  {

    for (int i = 0; i < buffer.size(); i ++) 
    {
      pushMatrix();

      float c = map(i, 0, Stars.length, 0, 255);
      stroke(c, 255, 255);
      float sample = buffer.get(i) * (height / 2);  // buffer[i]
      smoothedSample = lerp(smoothedSample, sample, 0.001);
      rect( starX,starY - smoothedSample,starSize + sample,starSize);
        popMatrix();
    }
  }
}
