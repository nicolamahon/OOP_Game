class Ball extends Objects
{
  float xSpeed;
  float ySpeed;
  color c;
  
  // constructor
  Ball(int x, int y, float xSpeed1, float ySpeed1) 
  {
    xPos = x;
    yPos = y;
    xSpeed = xSpeed1;
    ySpeed = ySpeed1;
    c = color(0,0,255);
  } 
  
  // ball render
  void render() 
  {
    fill(c);
    ellipse(xPos, yPos, diameter, diameter);
  }
  
  // for updating position of the ball
  void update() 
   {
    // update position
    xPos += xSpeed;
    yPos += ySpeed;
    
    // bounce off of left and right sides of screen
    // top and bottom of screen interactions are different 
    //as ball will either go out of bounds or hit a block
    if (xPos < 0 || xPos > width) 
    {
      xSpeed *= -1;
    }
  }
  
 // when ball hits paddle or block it will bounce Up/Down
  void bounce() 
  {
    ySpeed *= -1;
  }
  
}