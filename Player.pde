class Player extends Entity {
  // Player properties
  public int posX, posY;

  // Player texture
  private PImage sprite;

  public Player() {
    posX = posY = 0;
  }

  /* Helper functions */
  public void setTexture(String path) {
    sprite = loadImage(path);
  }

  public void draw() {    
    // Draw player texture
    image(sprite, posX, posY, 50, 50);
  }

  /* Moving functions */
  public void move(int x, int y) {
    posX = x;
    posY = y;
  }
  public void moveUp(int steps) {
    posY-=steps;
  }

  public void moveDown(int steps) {
    posY+=steps;
  }

  public void moveRight(int steps) {
    posX+=steps;
  }

  public void moveLeft(int steps) {
    posX-=steps;
  }
}
