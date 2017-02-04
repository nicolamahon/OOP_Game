class Ball extends Objects
{
  //int xPos;
  //int yPos;
  int xSpeed;
  int ySpeed;
  int diameter;
  
  // constructor
  Ball(int x, int y, int xSpeed1, int ySpeed1, int diameter) 
  {
    xPos = x;
    yPos = y;
    xSpeed = xSpeed1;
    ySpeed = ySpeed1;
    this.diameter = diameter;
  } 
  
  Ball()
  {
  }
  
  // ball render
  void render() 
  {
    fill(0);
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