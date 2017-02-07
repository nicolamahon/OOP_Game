void setup()
{
  size(400, 400);
  
  // load the leaderBoard
  loadData();
    
  // change game cursor
  cursor(CROSS);
  
  // initial block values created and stored in arrayList
  smooth();
  initialiseBlocks();
  
  // class objects
  paddle = new Paddle();
  
  // fonts imported
  font_main = createFont("FSEX300.ttf", 20);
   
}

// global Class variables
ArrayList<Block> blocks = new ArrayList<Block>();
ArrayList<Scores> scoreboard = new ArrayList<Scores>(); 
Table t;
Paddle paddle;
Ball ball;

// imported fonts
PFont font_main;

// global variables
int score;
int ballCount = 3;

// global variables for scoreBoard
int name_index = 0;
String pName = "";

// change state flags
boolean nameFlag = false; 

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
   if (frameCount < 120)
    {
      //display splash screen
      splash();
    }
    else // rest of code
    {
      background(123);
      
      // draw the rows of blocks
      drawAllBlocks();
      
      // draw scoreboard
      printStats();
             
      //draw ball and update position
      if(ball != null)
      {
        createBall();
      }
      
      // draw paddle and update pos
      paddle.render();
          
      // check for impacts of ball with paddle
      if(ball != null && paddle.hitPaddle(ball))
      {
          //checkImpactPaddle();
          ball.bounce();
          paddle.velocity(ball);
      }
      
      // check for impacts of ball with block
      if(ball != null)
      {
        checkImpactBlock();
      }
      
      // bounce ball if hits top of screen
      if (ball != null && ball.yPos-diameter/2 < 0)
      {
        ball.bounce();
      }
      
      // if ball out of bounds i.e. lost
      if(ball != null && ball.yPos-diameter/2 > height)
      {
        //ballLost();
        ball = null;
        score = 0;
        nameFlag = true;
      }
      
      if(nameFlag)
      {
        background(0);
        // prints menu to display ask user for their name for leaderBoard
        addName();
      }
    }
    
} // end draw()


/**** Begin game methods ****/

// load the scores from the "leaderBoard.csv" file
void loadData()
{
  // clear arraylist of any random leftovers
  scoreboard.clear();

  // load table row by row
  t = loadTable("leaderBoard.csv", "header");
  
  // add each user score to the scoreboard arrayList
  for (int i = 0; i < t.getRowCount(); i ++)
  {
    TableRow row = t.getRow(i);
    Scores userscore = new Scores(row);
    scoreboard.add(userscore);
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
  for (int i=0; i<blocks.size()-1; i++)
  {
    Block b = blocks.get(i);
    b.render();
  }
}


// draw scoreboard
void printStats()
{
  textFont(font_main);
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
void createBall()
{
  ball.render();
  ball.update();
}

// check for ball impact with paddle
void checkImpactPaddle()
{
     ball.bounce();
     paddle.velocity(ball);   
} 

// check for ball impact with block
void checkImpactBlock()
{
  for(int i=0; i<blocks.size(); i++)
  {
    Block b = blocks.get(i);
    if(b != null && b.hitBlock(ball) == true)
    { 
      ball.bounce();
      blocks.remove(i);
      score++;
    }
  }
} 

// if ball is lost, out of bounds
void ballLost()
{
  ball = null;
  score = 0;
}


// provide a new ball
void mouseClicked() 
{
    // if the ball has gone out of bounds
    if (ball == null) 
    {
         ball = new Ball(paddle.xPos+(padW/2), height-padH-diameter, 0, -2);
    }
    
}

// for taking user input 
void keyPressed()
{
  if(keyPressed && (name_index < 15 || key == ENTER))    // while key input is not delete or enter
  {
    delay(200);
    if(key != BACKSPACE && key != ENTER) //&& allow_chars.indexOf(key) > 0)
    {
      pName += Character.toUpperCase(key);      // add the pressed key to the playerName string
      name_index++;                             // increment the index
      
    }
      if(key == ENTER && name_index > 0)  // if at least 1 char entered and enter is pressed, input is finish
    {
      nameFlag = false;      // change state to update the animation
      addScore();            // print menu to ask user to enter name on scoreboard
      background(0);         // update animation
      printLeaderBoard();     // read the scoreboard from CSV file and print
    }
    if (key == BACKSPACE && name_index == 15)  // if deleting a char during keyboard input
    {
      delay(200);
      name_index--;
      pName = pName.substring(0, pName.length()-1);
    }
  } // end outer if 
} // end keypressed()

// print menu for adding your name to the scoreboard
void addName()
{
  fill(0, 255, 0);
  rect(50, 50, 100, 30);
  fill(255);
  text("Enter Your Name:", 55, 65); 
  
  text(pName, 55, 100);
  
  rect(50, 160, 100, 30);
  text("Save Name", 55, 165);
}

// file OUTPUT, write new user scores to the file
void addScore()
{
  TableRow newRow = t.addRow();
  newRow.setString("Name", pName);
  newRow.setInt("HighScore", 40);
  
  saveTable(t, "data/leaderBoard.csv");
}

// print the score board table, details in CSV file
void printLeaderBoard()
{
  // read the *updated* data from the file into the table
  // file has been updated to include this user's score
  loadData();
  
  // variables for printing to the screen
  int x = 90;
  int y = 55;
  
  // print the headers for the score board
  fill(255, 0, 0);
  textSize(35);
  text("Best Top 10", x, y);
  x = 60;
  y += 50;
  textSize(25);
  text("Player", x, y);
  x += 200;
  text("Score", x, y);
  y += 25;
  
  // **** ADD: sort method to print the scores in DESC order
  // Create temp arrayList
  // Copy scores into temp
  // Find the largest score, print to screen and remove from temp
  
  
  // print the scores read from the file, row by row
  // *** only the top 10 is displayed on the screen, see file for all user scores
  for(int i=0; i<10/*scoreboard.size()*/; i++)
  {
     x = 60;    // reset x for each new row being printed
     Scores us = scoreboard.get(i);
     println(us);
     textSize(15);
     text(us.name, x, y);
     x += 200;
     text(us.topscore, x, y);
     y += 25;
  }  
} // end printLeaderBoard()

void splash()
{
  background(0);
  PImage mainLogo;
  mainLogo = loadImage("splash1.JPG");
  image(mainLogo, 0,0);
}

//////////////////////////////////////////////////////////////////////////
/*

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


// add difficulty as player's score increases
void levelUp()
{
  if (score > 5)
  {
    paddle.padW = 40;
    paddle.c = color(255, 0, 0);
    paddle.update();
  }
  if (score > 10)
  {
    paddle.padW = 150;
    paddle.c = color(6, 200, 199);
    paddle.update();
  }
}

*/