void setup()
{
  size(400, 400);
  background(0);
  loadData();
  //printScoreBoard();
  p1 = new Player();
}

ArrayList<Scores> scoreboard = new ArrayList<Scores>(); 
Player p1;
Table t;

boolean nameFlag = true; 
boolean boardFlag = false;
//boolean endScoreFlag = false;

int name_index = 0;
String pName = "";
String allow_chars = "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM";


void draw()
{
  if(nameFlag)
  {
   addName();
  }
  
  

  
}

void mouseClicked()
{
  // if gameoverFlag == true
    // if x, y, mouse position are over the add "score to leaderboard" button
  
  //addName();
  
  //background(0);
  //addScore();
  //printScoreBoard();
}

void keyPressed()
{
  if(keyPressed && (name_index < 15 || key == ENTER))
  {
    delay(200);
    if(key != BACKSPACE && key != ENTER) //&& allow_chars.indexOf(key) > 0)
    {
      pName += Character.toUpperCase(key);
      name_index++;
      
    }
    if(key == ENTER && name_index > 0)  // if enter is pressed, finish
    {
      nameFlag = false;
      addScore();
      background(0);
      printScoreBoard();
    }
    if (key == BACKSPACE && name_index == 15)  // if deleting a char during keyboard input
    {
      delay(200);
      name_index--;
      pName = pName.substring(0, pName.length()-1);
    }
  } // end outer if
  
}


void loadData()
{
  // clear arraylist of any random leftovers
  scoreboard.clear();

  // load table row by row
  t = loadTable("leaderBoard.csv", "header");
  
  // add each star to the scoreboard arrayList
  for (int i = 0; i < t.getRowCount(); i ++)
  {
    TableRow row = t.getRow(i);
    Scores userscore = new Scores(row);
    scoreboard.add(userscore);
  }
}

void printScoreBoard()
{
  background(0);
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
  
  
   
  // print the scores read from the file, row by row
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

void addScore()
{
  TableRow newRow = t.addRow();
  newRow.setString("Name", pName);
  newRow.setInt("HighScore", 100);
  
  saveTable(t, "data/leaderBoard.csv");
}