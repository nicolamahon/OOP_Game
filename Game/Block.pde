class Block extends Objects 
{
  color c;
  int blockW;
  int blockH;
  float numRows;
  float numCols;
  
  // Constructor
  Block(int x, int y) 
  {
    xPos = x;
    yPos = y;
    c = color(random(255), random(255), random(255));
    blockW = 50;
    blockH = 20;
    numRows = 10.0;
    numCols = 10.0;
  }

  // draw block
  void render(int xPos, int yPos) 
  {
       fill(c);
       rect(xPos, yPos, blockW, blockH); 
  }
  
  // check for ball hitting a block
  boolean hitBlock(Ball b)
  {
    if(b.xPos <= xPos + blockW/2 
    && xPos - blockW/2 <= b.xPos
    && yPos + blockH/2 > b.yPos - b.diameter/2)
    {
      return true;
    }
    else 
    {
      return false;
    }
  }
  
  
} // end class Block