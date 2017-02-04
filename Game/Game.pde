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
    
    //check for new ball needed
    newBall();
}


// draw scoreboard
void scoreboard()
{
  fill(0, 0, 0);
  rect(width/20, height*0.6, width/100, height/25);
  fill(255);
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

// if ball lost, give new ball
void newBall()
{
  if(ball != null && ball.yPos > height)
  {
    ball = null;
    score = 0;
  }
}

boolean winState = false;

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

  