class Block {
  int xPos;
  int yPos;
  color c;
  int blockW;
  int blockH;
  int numRows;
  
  // Constructor
  Block(int x, int y) 
  {
    xPos = x;
    yPos = y;
    c = color(random(255), random(255), random(255));
    blockW = 50;
    blockH = 20;
    numRows = 10;
  }

  Block()
  {

//    c = color(random(255), random(255), random(255));
    blockW = 50;
    blockH = 20;
    numRows = 10;
  }

  // draw block
  void render(int xPos, int yPos) 
  {
    //rectMode(CENTER);
    fill(c);
    rect(xPos, yPos, blockW, blockH);
  } // end render() Block
  
   // create the blocks
  void createBlocks()
  {
    int offset = blockW/2;
    println("in function createBlocks");
    for (int i=0; i<numRows; i++)
    {
      println("in OUTER FOR - createBlocks");
      for (int j=0; j<width; j++)
      {
        if(i%2 == 0)
        {
          //b.xPos = j*blockW;
          //b.yPos = i*blockH;
          Block b = new Block(j*blockW, i*blockH);
          //println(j*blockW);
          //println(i*blockH);
          blocks.add(b);
          println(b.xPos, b.yPos);
          //b.render(j*blockW, i*blockH);
          b.render(b.xPos, b.yPos);
        }
        else
        {
          //b.xPos = (j*blockW)-offset;
          //b.yPos = i*blockH;
          Block b = new Block((j*blockW)-offset, i*blockH);
          blocks.add(b);
          println(xPos, yPos);
          //b.render((j*blockW)-offset, i*blockH);
          b.render(b.xPos, b.yPos);
        }
      }
    }
  } // end createBlocks()
  
  // setup blocks
  void drawBlocks()
  {
    for (int i=0; i<blocks.size(); i++)
    {
      Block b = blocks.get(i);
      b.render(b.xPos, b.yPos);
    }
  } // end drawBlocks()
  
  /*
  boolean hitBlock(Ball b)
  {
    if(  xPos - blockW/2 <= b.xPos &&
         b.xPos <= xPos + blockW/2 &&
         yPos + blockH/2 > b.yPos - diameter/2)
         
  }
  */
  
} // end class Block