# Block Breaker OOP_Game_C15755031
DT228/2 Object Oriented Programming <br>
Processing in Java - Game Assignment

<hr><b>CONCEPT</b><br>
The concept for my OOP assignment this semester was to make a game, any game, Processing. 
The video below give a basic demonstration of the functionality of the program and the expected user interactions. 

Click image below to play video:

[![Video](http://img.youtube.com/vi/NytrvnN8dhk/0.jpg)](http://www.youtube.com/watch?v=NytrvnN8dhk)

<hr><b>CONTROLS</b><br><ul>
<li>MOUSE CLICK to release a ball</li>
<li>MOUSE LEFT and MOUSE RIGHT to move the paddle</li>
<li>ESC to exit the game at any stage</li></ul>


<hr><b>BASIC FUNCTIONALITY</b><br>
User is presented with a wall of coloured bricks and a floating paddle.
Mouse Click releases a ball. There are a maximum of 3 balls available for each game.
Ball travels around the screen, bouncing off walls.
Player must use the paddle to prevent the ball from 'falling' off the bottom of the screen.  
When the ball hits one of the coloured blocks, the block disappears.
For every block that disappears, the player's score increases. 
If the player fails to keep the ball from falling off the screen, the ball is lost. 
If the ball is lost, the player's score resets.

As the player's score increases, the difficulty is increased. 
Once all 3 balls have been lost, the game is over. 
Alternatively, if the player successfully removes all the blocks the game displays a win message. 
The player's highest score from all 3 ball-plays is displayed. 
The user can then add their name to the leader board. 
Finally the current leader board is printed to the display with the option to exit the program. 

Now you know the basic functionality, let's see how it looks....

<hr><b>BLOCK BREAKER</b><br>
The user is initially shown a splash screen to welcome them to the game.
This image is actual game footage. It gives the player an idea of what to expect.  
This screen displays for a few seconds using a frameCount check, then disappears. 

![Splash](/screenshots/splash.JPG?raw=true "Splash")

After the main splash screen has been wiped, the player is presented with the game screen.
The game begins when the player clicks the mouse to release a new ball. 

Mouse X positions dictate the position of the paddle, which the Player must use to keep the ball in motion.
The direction and speed of the ball can be affected by the speed the player moves the paddle. 
This allows for changes in direction, in order to reach all the blocks with the ball. 

![First Break](/screenshots/break.JPG?raw=true "First Break")

<hr><b>GAMEPLAY</b><br>
As the player's score increases, there are a number of 'level-ups' which increase difficulty. 
<ul><li>PADDLE RESIZE to change the paddle's surface area, making targeting the ball more difficult</li>
<li>SPEED UPDATES to speed up or slow down the velocity at which the ball is travelling</li></ul>

![Level Up](/screenshots/levelup.JPG?raw=true "Level Up - Increase Difficulty")


<hr><b>WINNING</b><br>
The game is won by removing all the blocks on the screen. 
High Scores are taken as the highest score achieved on a single ball during the game. 
So if you scored 36 with your first ball, 15 with the second and 28 with the third, 
then your high score would be 46. 
Once the game has ended for the player, either by breaking all the blocks or losing all 3 balls,
they can add their name and score to the leader board.

![Winner](/screenshots/winner.JPG?raw=true "Winner")

![Save Score](/screenshots/savename.JPG?raw=true "Save Score")

<hr><b>LEADER BOARD</b><br>
The leader board is read from a CSV file, containing all the previous player's names and scores. 
The CSV file contents are read into an arrayList of class objects. The player is asked to enter their name
to be on the leader board. The program takes input from the keyboard, including 
allowing for deletion of any erroneous keyboard inputs and displays the name in 'real time'. 
Once the player presses ENTER, the program saves their name and score and writes it back to the CSV file as part of the 
leader board. The Top 10 players on the leader board are then displayed back to the user. 
This section could use a sorting method to print the scores in DESC order. 

![Leader Board](/screenshots/leaderboard.JPG?raw=true "Leader Board")


<hr><b>TERMINATING THE PROGRAM</b><br>
The game is terminated by pressing the ESC key at any stage. 


<b>ITEMS I'M PROUD OF:</b>
- writing successfully to the CSV file
- implemeting reading input from the keyboard and displaying it in real time, including any deletions
- implementing the Level Up options; changing an object's 'DNA' and therefore how it behaved in the game
- other small things like; being able to instantiate all the blocks, they were very tricky
- the uniformity and clarity of my display screens, overall pleasing appearance
- terminating the program at the user's request rather than self-terminating

That's it, I hope you enjoy playing around with it.