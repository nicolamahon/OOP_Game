void setup()
{
  size(500, 500);
  cursor(CROSS);
  b.drawBlocks();
}


ArrayList<Block> blocks = new ArrayList<Block>();
Block b = new Block(0,0);

void draw() 
{
    
    
}

void printBlocks()
{
 for(int i=0; i<blocks.size(); i++)
  {
     Block x = blocks.get(i);
     println(x.xPos, x.yPos);
  } 
}

// draw blocks
void blockDraw()
{
  for (int i=0; i < blocks.size(); i++) 
  {
    if (blocks.get(i) != null) 
    {
      b = blocks.get(i);
      b.render(b.xPos, b.yPos);
    }
  }
}