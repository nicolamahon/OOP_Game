void setup()
{
  size(400, 400);
  background(0);
  loadData();
  p1 = new Player();
}

// class variables
ArrayList<Scores> scoreboard = new ArrayList<Scores>(); 
Player p1;
Table t;

// change state flags
boolean nameFlag = true; 

// global variables for scoreBoard
int name_index = 0;
String pName = "";


void draw()
{
  if(nameFlag)
  {
    // prints menu to display ask user for their name for leaderBoard
    addName();
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
      printScoreBoard();     // read the scoreboard from CSV file and print
    }
    if (key == BACKSPACE && name_index == 15)  // if deleting a char during keyboard input
    {
      delay(200);
      name_index--;
      pName = pName.substring(0, pName.length()-1);
    }
  } // end outer if
  
}

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

// print the score board table, details in CSV file
void printScoreBoard()
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
  
}

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