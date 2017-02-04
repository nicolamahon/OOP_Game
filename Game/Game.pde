void setup()
{
  size(400, 400);
  background(255);
  cursor(CROSS);
  initialiseBlocks();
  paddle = new Paddle();
  ball = new Ball();
  
}

// global variables
//Block[] blocks = new Block[0];
ArrayList<Block> blocks = new ArrayList<Block>();
Block b = new Block(0,0);
Ball ball;
Paddle paddle;

int score;
boolean winState = false;

void draw() 
{
    
    drawAllBlocks();
    //b.drawBlocks();
    scoreboard();
    
    // create ball and update position
    ballUpdate();
    
    // create paddle
    paddle.render();
  
    // check for impacts of ball with paddle
    checkImpactPaddle();
    
    // check for impacts of ball with block
    checkImpactBlock();
    
    //check for new ball needed
    checkLostBall();
    
    // check for winner
    winner();
    
}


// draw scoreboard
void scoreboard()
{
  fill(255, 0, 0);
  rect(0, height*0.6, width/10, height/25);
  fill(0);
  text("Score: "+score, 1, 305);
}

// create and update ball location
void ballUpdate()
{
  if (ball != null)
    {
      ball.render();
      ball.update();
    }
}

// check for ball impact with paddle
void checkImpactPaddle()
{
  if (ball != null && paddle.hitPaddle(ball)) 
  {
    // bounce 
    ball.bounce();
    // change ball velocity based on paddle
    paddle.Velocity(ball);
  }
} // end checkImpactPaddle()

// check for ball impact with block
void checkImpactBlock()
{
  if (ball != null)
  {
    for(int i=0; i<blocks.size(); i++)
    {
      Block a = blocks.get(i);
      if(a != null && a.hitBlock(ball) == true)
      {
        ball.bounce();
        blocks.remove(i);
        score++;
      }
    }
  }
} // end checkImpactBlock()

// if ball lost
void checkLostBall()
{
  if(ball != null && ball.yPos > height)
  {
    ball = null;
    score = 0;
  }
}


// check for winner
void winner()
{
  for(int i=0; i<blocks.size(); i++)
  {
    if(blocks.get(i) == null)
    {
      winState = true;
      break;
    }
  }
  if(winState == true)
  {
    println("WINNER");
    exit();
  }
}

// provide a new ball
void mouseClicked() 
{
    // create ball
    if (ball == null) 
    {
      ball = new Ball(paddle.xPos, height - paddle.padH - ball.diameter/2, 0, 0, -2);
    }
}

void initialiseBlocks()
{
  for (int j=0; j < b.numRows; j++) 
  { // rows
    // location of each row  
    int y = b.blockH / 2 + j * b.blockH;
    // set the row offset
    int offset = 0;
    
    if (j % 2 == 0) 
    {
      offset = b.blockW / 2;
    }
    // draw the row
    for (int i=offset; i < width+b.blockW/2.0; i += b.blockW) { // columns
      blocks.add(new Block(i,y));
    }
  }
}

void drawAllBlocks()
{
  int count = 0;
  for (int i=0; i<blocks.size()-1; i++)
  {
    Block b = blocks.get(i);
    b.render(b.xPos, b.yPos);
    count++;
  }
  println(count);
}

  