class Paddle extends Objects 
{
  int xPrev;
  color c;
  
  Paddle()
  {
    xPos = mouseX;
    yPos = height - 30;
    this.padH = padH;
    this.padW = padW;
    c = color(random(255), random(255), random(255));
  }

  // draw the paddle
  void render() 
  {
    fill(c);
    rect(xPos, yPos, padW, padH);
  } //end render() - Paddle
  
  void update()
  {
    fill(c);
    xPrev = xPos;
    xPos = mouseX;
    rect(xPos, yPos, padW, padH);
  }
  
  // check for ball hitting the paddle
  boolean hitPaddle(Ball b)
  {
    if(b.xPos <= xPos + padW // if ball centre x is <= middle of paddle x
    && yPos - padH/2 < b.yPos + b.diameter/2 // if middle of paddle y < bottom of ball y
    && xPos - padW/2 <= b.xPos)  //
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
    float Vector = xPos - xPrev;
    b.xSpeed = b.xSpeed + Vector;
  }
  
} // end class Paddle