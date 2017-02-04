void setup()
{
  size(500, 500);
  cursor(CROSS);
  b.drawBlocks();
  paddle = new Paddle();
}

// global variables
ArrayList<Block> blocks = new ArrayList<Block>();
Block b = new Block(0,0);
Ball ball;
Paddle paddle;

int score;

void draw() 
{
    background(255);
    scoreboard();
    
    // create ball and update position
    ballUpdate();
    
    // create paddle
    paddle.render();
  
    // check for impacts of ball with paddle
    checkImpactPaddle();
    
    // check for impacts of ball with block
    checkImpactBlock();
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

// draw scoreboard
void scoreboard()
{
  fill(0, 0, 0);
  rect(width/20, height*0.6, width/100, height/25);
  fill(255);
  text("Score: "+score, 1, 305);
}