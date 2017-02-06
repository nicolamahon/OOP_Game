class Block extends Objects 
{
  color c;
  
  // Constructor
  Block(int x, int y) 
  {
    xPos = x;
    yPos = y;
    c = color(random(255), random(255), random(255));
  }

  // draw a block
  void render() 
  {
       fill(c);
       rect(xPos, yPos, blockW, blockH); 
  }
  
  // check for ball hitting a block
  boolean hitBlock(Ball b)
  {
    if(b.xPos <= xPos + blockW/2   // if ball center point < block right most side
    && xPos - blockW/2 <= b.xPos  // AND if touching the neighbouring block (block +/- half block size)
    && yPos + blockH/2 > b.yPos - b.diameter/2)  // AND ball has touched the underneath of the block
    {
      return true;
    }
    else 
    {
      return false;
    }
  }
  
  
} // end class Block