void setup()
{
  size(400, 400);
  
  // load the leaderBoard
  loadData();
  
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
int highscore;
int ballCount = 3;

// global variables for scoreBoard
int name_index = 0;
String pName = "";

// change state flags
boolean nameFlag = false; 
boolean gameFlag = true;
boolean leaderBoardFlag = false;
boolean winFlag = false;


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
      if(gameFlag)
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
            checkImpactPaddle();
        }
        
        // check for impacts of ball with block
        if(ball != null)
        {
          checkImpactBlock();
        }
        
        // bounce ball if hits top of screen
        if (ball != null && ball.yPos-20-diameter/2 < 0)
        {
          ball.bounce();
        }
        
        // if ball out of bounds i.e. lost
        if(ball != null && ball.yPos-diameter/2 > height)
        {
          ballLost();
        }
        
        if(ballCount == 0)
        { 
          gameFlag = false;
          nameFlag = true;
        }
        
        winGame();
      } // end if(gameFlag)
      
      
      /* check flags for change of states */
      if(nameFlag)
      {
        background(0);
        // prints menu to display ask user for their name for leaderBoard
        addName();
        // at this stage, key pressed it waiting for the user's input
        // pressing enter will set the leader board flag to true
      }
      
      if(leaderBoardFlag)
      {
         printLeaderBoard();     // read the scoreboard from CSV file and print
      }
         
    } // end else for running rest of code
    
} // end draw()


/******************** Begin game methods ********************/

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
  textSize(15);
  //fill(255);
  //rect(0, height*0.73, width/6, height/20);
  fill(255);
  text("HighScore: "+highscore, 10, 17);
  text("Score: "+score, 160, 17);

  text("Balls Left: "+ballCount, 275, 17);
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
  if (score > highscore)
  {
    highscore = score;
  }
  // reset the round score
  score = 0;
  
  // reduce number of balls
  ballCount--;
}


// provide a new ball
void mouseClicked() 
{
    // if the ball has gone out of bounds
    if (ball == null) 
    {
         ball = new Ball(paddle.xPos+(padW/2), height-padH-diameter, 2, -2);
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
      addScore();            // print menu to ask user to enter name on scoreboard
      background(0);         // update animation
      //printLeaderBoard();     // read the scoreboard from CSV file and print
      leaderBoardFlag = true;
      nameFlag = false;      // change state to update the animation
    }
    if (key == BACKSPACE && name_index > 0)  // if deleting a char during keyboard input
    {
      delay(200);
      name_index--;
      pName = pName.substring(0, pName.length()-1);
    }
  } // end outer if 
  else
  {
    if(key == BACKSPACE && name_index == 15)
    {
      delay(200);
      pName = "";
      addName(); 
    }
  } // end else()
} // end keypressed()

// print menu for adding your name to the scoreboard
void addName()
{
  fill(255);
  textSize(30);
  fill(255, 128, 0);
  text("Your HighScore: "+highscore, 55, 65);
  fill(255, 0, 127);
  text("Enter Your Name:", 70, 125); 
  fill(255);
  text("Press Enter to Save", 60, 300);
  textSize(50);
  fill(0, 255, 255);
  text(pName, 110, 190);
}

// file OUTPUT, write new user scores to the file
void addScore()
{
  TableRow newRow = t.addRow();
  newRow.setString("Name", pName);
  newRow.setInt("HighScore", highscore);
  
  saveTable(t, "data/leaderBoard.csv");
}

// print the score board table, details in CSV file
void printLeaderBoard()
{
  // read the *updated* data from the file into the table
  // file has been updated to include this user's score
  loadData();
  
  background(0);
  
  // variables for printing to the screen
  int x = 90;
  int y = 55;
  
  // print the headers for the score board
  fill(255, 0, 0);
  textSize(35);
  fill(0, 255, 0);
  text("Best Top 10", x, y);
  x = 60;
  y += 50;
  textSize(25);
  fill(0, 0, 255);
  text("Player", x, y);
  x += 200;
  text("Score", x, y);
  y += 25;
  
  // **** ADD: sort method to print the scores in DESC order
  // Create temp arrayList
  // Copy scores into temp
  // Find the largest score, print to screen and remove from temp
  
  int count = 0;
  // print the scores read from the file, row by row
  // *** only the top 10 is displayed on the screen, see file for all user scores
  for(int i=0; i<scoreboard.size(); i++)
  {
     if(count < 10)
     {
       x = 60;    // reset x for each new row being printed
       Scores us = scoreboard.get(i);
       //println(us);
       textSize(15);
       fill(random(0, 255), random(0, 255),random(0, 255)); 
       text(us.name, x, y);
       x += 200;
       text(us.topscore, x, y);
       y += 25;
       count++;
     }
  }  
} // end printLeaderBoard()

void splash()
{
  background(0);
  PImage mainLogo;
  mainLogo = loadImage("splash1.JPG");
  image(mainLogo, 0,0);
}


// check for winner
void winGame()
{
  //for(int i=0; i<blocks.size(); i++)
  //{
    //if(blocks.get(i) == null)
    //{
      winFlag = true;
      //break;
    //}
 // }
  if(winFlag == true)
  {
    fill(0);
    rect(50, 50, 300, 300);
    textSize(30);
    fill(255);
    text("Congratulations!!   \nYou are \na WINNER!!", 125, 175);
    //exit();
    if(frameCount % 240 == 0)
    { 
      delay(300);
      nameFlag = true;
    }
  }
}


//////////////////////////////////////////////////////////////////////////
/*



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