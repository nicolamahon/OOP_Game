void setup()
{
  size(400, 400);
    
  // change game cursor
  cursor(CROSS);
  
  // initial block values created and stored in arrayList
  smooth();
  initialiseBlocks();
  
  // class objects
  paddle = new Paddle();
   
}

// global Class variables
ArrayList<Block> blocks = new ArrayList<Block>();
Paddle paddle;
Ball ball;


// global variables
int score;
int ballCount = 3;

// for initializing the blocks arrayList
int numRows = 10;
int numCols = 10;
int blockW = 50;
int blockH = 20;
int padH = 20;
int padW = 80;
int diameter = 15;


void draw() 
{
    background(123);
    
    // draw scoreboard
    scoreboard();
    
    // draw the rows of blocks
    drawAllBlocks();
    
    //draw ball and update position
    if(ball != null)
    {
      createBall();
    }
    
    if (ballFlag)
    {
      if(ball.yPos > height)
      {
        background(0);
        ballFlag = false;
        score = 0;
        ballCount--;
        balls.remove(ball);
      }
      
      background(255); // to erase all the ball dragging animations
      //ballFlag = true;
      drawAllBlocks();
      ball.render();
      ball.update();
      scoreboard();
      paddle.render();
      paddle.update();
    }
    
   
    
    scoreboard();
    
    
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


/**** Begin game methods ****/

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
  
  //if (ball != null)
  if(ballFlag)
    {
      //ball.render();
      ball.update();
    }
}

// check for ball impact with paddle
void checkImpactPaddle()
{
  //if (ball != null && paddle.hitPaddle(ball))
  if (ballFlag == true && paddle.hitPaddle(ball)) 
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
  //if (ball != null)
  if (ballFlag)
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
//  if(ball != null && ball.yPos > height)
    if(ballFlag == true && ball.yPos > height)
    {
      ballFlag = false;
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
    // if the ball has gone out of bounds
    if (!ballFlag) 
    {
      // check if the player has used all their balls
      if(ballCount > 0)
      {
        //ball = new Ball(paddle.xPos, height - paddle.padH - ball.diameter/2, 1, 1, 15);
        ball.render();
        //ball.update();
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