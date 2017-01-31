class Block {
  int xPos;
  int yPos;
  color c;
  int blockW;
  int blockH;
  int numRows;
  
  // Constructor
  Block() 
  {
    xPos = x;
    yPos = y;
    c = color(random(255), random(255), random(255));
    blockW = 50;
    blockH = 20;
    numRows = 10;
  }
  
  // draw drick
  void render(int xPos, int yPos) 
  {
    rectMode(CENTER);
    fill(c);
    rect(xPos, yPos, blockW, blockH);
  }
  
  // setup bricks
  void drawBlocks()
  {
    for (int i=0; i<numRows; i++)
    {
      for (int j=0; j<width; j++)
      {
        b.render(j*blockW, i*blockH);
      }
    }
  }
}