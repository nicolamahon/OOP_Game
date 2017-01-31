class Block {
  int xPos;
  int yPos;
  color c;
  int blockW;
  int blockH;
  
  // Constructor
  Block(int x, int y) 
  {
    xPos = x;
    yPos = y;
    c = color(random(255), random(255), random(255));
    blockW = 50;
    blockH = 20;
  }
  
  // draw drick
  void render() 
  {
    rectMode(CENTER);
    fill(c);
    rect(xPos, yPos, blockW, blockH);
  }
  
  // setup bricks
  void drawBlocks()
  {
    
  }
  
}