class Ball extends Objects
{
  //int xPos;
  //int yPos;
  int xSpeed;
  int ySpeed;
  int diameter;
  
  Ball(int x, int y, int xSpeed1, int ySpeed1, int diameter) 
  {
    xPos = x;
    yPos = y;
    xSpeed = xSpeed1;
    ySpeed = ySpeed1;
    this.diameter = diameter;
  } 
  
  void render() 
  {
    fill(0);
    ellipse(xPos, yPos, diameter, diameter);
  }
  
   
  
  
}