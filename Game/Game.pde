void setup()
{
  size(400, 400);
  background(125);
  
  // change game cursor
  cursor(CROSS);
  
  // initial block values created and stored in arrayList
  initialiseBlocks();
  // draw a scorebaord
  scoreboard();
  
  // class objects
  paddle = new Paddle();
  ball = new Ball(paddle.xPos, paddle.yPos, 1, 1, 15);
  
  ballUpdate();
  
}

// global Class variables
ArrayList<Block> blocks = new ArrayList<Block>();
Ball ball;
Paddle paddle;

// global variables
int score;
boolean winState = false;

void draw() 
{
    // draw the blocks as they are in the arraylist  
    drawAllBlocks();
    
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
void mousePressed() 
{
    // create ball
    if (ball == null) 
    {
      ball = new Ball(paddle.xPos, height - paddle.padH - ball.diameter/2, 0, 0, -2);
      ballUpdate();
  }
    
    
    // create ball and update position
    //ballUpdate();
}

void initialiseBlocks()
{
  for (int j=0; j < 10; j++) 
  { // rows
    // location of each row  
    int y = height/100 + j * width/20;
    
    // set the row offset
    int offset = 0;
    
    if (j % 2 == 0) // if even numbered row 
    {
      offset = width/16;
    }
    // draw the row
    for (int i=0-offset; i < width+50/2.0; i += 50) 
    { 
      blocks.add(new Block(i,y));
      println(i, y);
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

  