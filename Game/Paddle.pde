class Paddle extends Objects 
{
  int xPrev;
  int padH;
  int padW;
  
  Paddle()
  {
    xPos = mouseX;
    yPos = height - 10;
    padH = 20;
    padW = 40;
  }

  void render() 
  {
    fill(0);
    xPrev = xPos;
    xPos = mouseX;
    rect(xPos, yPos, padW, padH);
  }
  
}