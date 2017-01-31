void setup()
{
  size(500, 500);
  cursor(CROSS);
}


ArrayList<Block> blocks = new ArrayList<Block>();
Block d = new Block();

void draw() 
{
    d.createBlocks();
    
   // printBlocks();
    
    
   // b.drawBlocks();
}

void printBlocks()
{
 for(int i=0; i<blocks.size(); i++)
  {
     Block x = blocks.get(i);
     println(x.xPos, x.yPos);
  } 
}