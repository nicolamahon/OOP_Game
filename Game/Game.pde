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
  paddle = new Paddle(15, 80);
  ball = new Ball(paddle.xPos, paddle.yPos, 2, 2, 15);
  //ball = new Ball();
  ballUpdate();
  
  // create paddle
  paddle.render();
  
}

// global Class variables
ArrayList<Block> blocks = new ArrayList<Block>();
Ball ball;
Paddle paddle;

// global variables
int score;
int ballCount = 3;
boolean winState = false;

void draw() 
{
    // draw the blocks as they are in the arraylist  
    //drawAllBlocks();
    
    // create ball and update position
    //ballUpdate();
    if (ball != null)
    {
      background(125);
      drawAllBlocks();
      ball.render();
      ball.update();
      scoreboard();
    }
    
    // create paddle
    paddle.update();
  
    // check for impacts of ball with paddle
    checkImpactPaddle();
    
    // check for impacts of ball with block
    checkImpactBlock();
    
    // increase difficulty
    levelUp();
    
    //check for new ball needed
    checkLostBall();
    
    // check for winner
    winner();
    
}


// draw scoreboard
void scoreboard()
{
  fill(255);
  rect(0, height*0.73, width/6, height/20);
  fill(0);
  text("Score: "+score, 2, 307);
  
  // display number of balls left
  fill(255);
  rect(0, height*0.73+20, width/6, height/20);
  fill(0);
  text("Balls Left: "+ballCount, 2, 327);
}

// create and update ball location
void ballUpdate()
{
  background(125);
  
  if (ball != null)
    {
      //ball.render();
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
      ballCount--;
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
      // check if the player has used all their balls
      if(ballCount > 0)
      {
        ball = new Ball(paddle.xPos, height - paddle.padH - ball.diameter/2, 1, 1, 15);
        ball.render();
      }
    }
    
}

// to create the block X,Y positions and save them to the arraylist
void initialiseBlocks()
{
  for (int j=0; j < height/40; j++) // rows
  { 
    // location of each row  
    int y = height/100 + j * width/20;
    
    // set offset so that blocks are not aligned from row to row
    int offset = 0;
    
    if (j % 2 == 0) // if even numbered row, create an offset
    // offset allows for half a brick to display on the 
    // screen edge so that there are no gaps on alternating rows
    {
      offset = width/16;
    }
    // draw the row
    for (int i=0-offset; i < width+50/2.0; i += 50) 
    { 
      blocks.add(new Block(i,y));
      //println(i, y);
    }
  }
}

// display the blocks from the array list, based on pre-initialised X,Y positions
void drawAllBlocks()
{
  //int count = 0;
  for (int i=0; i<blocks.size()-1; i++)
  {
    Block b = blocks.get(i);
    b.render(b.xPos, b.yPos);
    //count++;
  }
  //println(count);
}

// add difficulty as player's score increases
void levelUp()
{
  if (score > 5)
  {
    //background(0);
    paddle.padW = 40;
    paddle.c = color(255, 0, 0);
    paddle.update();
  }
  if (score > 10)
  {
    //background(0);
    paddle.padW = 150;
    paddle.c = color(6, 200, 199);
    paddle.update();
  }
}