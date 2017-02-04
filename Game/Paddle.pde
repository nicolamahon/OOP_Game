class Paddle extends Objects 
{
  int xPrev;
  int padH;
  int padW;
  
  Paddle()
  {
    xPos = mouseX;
    yPos = height - 30;
    padH = 10;
    padW = 80;
  }

  // draw the paddle
  void render() 
  {
    
    fill(0,255, 0);
    xPrev = xPos;
    xPos = mouseX;
    rect(xPos, yPos, padW, padH);
  } //end render() - Paddle
  
  // check for ball hitting the paddle
  boolean hitPaddle(Ball b)
  {
    if(b.xPos <= xPos + padW/2
    && yPos - padH/2 < b.yPos + b.diameter/2
    && xPos - padW/2 <= b.xPos)
    {
      return true;  
    }
    else
    {
      return false;
    }
  } // end hitPaddle()
  
  // to change the velocity of the ball depending on paddle interaction
  void Velocity(Ball b)
  {
    int Vector = xPos - xPrev;
    b.xSpeed = b.xSpeed + Vector;
  }
  
} // end class Paddle