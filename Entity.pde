class Entity {
  // Entity properties
  public int posX, posY;

  // Entity texture
  private PImage sprite;

  // Used to calculate if entity is out of window bounds
  public int screenWidth, screenHeight;

  // If this entity has AI enabled
  public boolean hasAI;
  
  // Speed of entity AI
  public int aiSpeed = 2;
  
  public Entity() {
    posX = posY = 0;
  }

  /* Helper functions */
  public void setTexture(String path) {
    sprite = loadImage(path);
  }

  public void centerOnScreen() {
    posX = screenWidth / 2;
    posY = screenHeight / 2;
  }
  
  /* Enables entity AI */
  public void enableAI() {
    hasAI = true;
  }

  /* Disables entity AI */
  public void disableAI() {
    hasAI = false;
  }

  /* Draws the entity */
  public void draw() {
    // Draw the texture
    image(sprite, posX, posY, 50, 50);

    // Generate random numbers for AI
    double randomNum1 = Math.floor(Math.random() * aiSpeed);
    double randomNum2 = Math.floor(Math.random() * aiSpeed);

    // Do enemy logic actions if AI enabled
    if (hasAI && randomNum1 == randomNum2) entityLogic();
  }

  /* Moving functions */
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

  public boolean spriteXOutOfScreen() {
    return posX > width;
  }

  public boolean spriteYOutOfScreen() {
    return posY > height;
  }


  /* Define enemy logic here... */
  public void entityLogic() {
    // Random number for rotating enemy
    double randomNum = Math.floor(Math.random() * 71);

    if (posX >= screenWidth || posY >= screenHeight) {
      posX = posY = 0;
    } else {
      if (randomNum == 10)  moveUp(5);
      else if (randomNum == 30) moveDown(10);
      else if (randomNum == 50) moveLeft(5);
      else if (randomNum == 70) moveRight(10);
    }
  }
}
