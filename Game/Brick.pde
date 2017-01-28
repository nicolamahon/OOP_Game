class Brick {
  int xPos;
  int yPos;
  color c;
  
  // Constructor
  Brick(int x, int y) {
    xPos = x;
    yPos = y;
    c = color(random(255), random(255), random(255));
  }
  
}