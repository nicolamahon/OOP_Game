class Block extends Objects 
{
  //int xPos;
  //int yPos;
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
  
   // create the blocks
  void drawBlocks()
  {
    int countODD = 0;
    int countEVEN = 0;
    int offset = blockW/2;
    println("in function createBlocks");
    for (int i=0; i<numRows; i++)
    {
      println("in OUTER FOR - createBlocks");
      for (int j=0; j<(numCols+offset)/2; j++)
      {
        
        println("in INNER FOR - createBlocks");
        if(i%2 == 0)  // if even row
        {
          b.xPos = j*blockW;
          b.yPos = i*blockH;
          b.render(b.xPos, b.yPos);
          blocks.add(b);
          countODD++;
          //b.render(j*blockW, i*blockH);
        }
        else    // if odd row
        {
          b.xPos = (j*blockW)-offset;
          b.yPos = i*blockH;
          b.render(b.xPos, b.yPos);
          blocks.add(b);
          countEVEN++;
          //b.render((j*blockW)-offset, i*blockH);
        }
      }
    }
    println(countODD);
    println(countEVEN);
  } // end createBlocks()
  
  
  boolean hitBlock(Ball b)
  {
    if(  b.xPos <= xPos + blockW/2 
    && xPos - blockW/2 <= b.xPos
    && yPos + blockH/2 > b.yPos - b.diameter/2)
    return true;
  }
  
  
} // end class Block