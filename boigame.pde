/**
 * BoiGame
 * @author Yeppii
 * @description A very simple game made as a test project
 * LICENSE: MIT License (See LICENSE file)
 */

import websockets.*;

// Players 
Player player;
Player player2;

// Entities
Entity enemy1;
Entity creeper;

// Websocet for multiplayer
WebsocketClient wsClient;

// Player properties
int playerSpeed = 10;
int playerScore = 0;

// Game state variables
boolean mouseMode = false;
boolean gameOver = false;
boolean chatMode = false;

// Status text that will be shown in bottom
String statusText = "Click and move mouse to move player, you can also use WASD to move player";

// Chat text
String chatText = "";

/* Clears the screen with white color */
void clearScreen() {
  background(255, 255, 255);
}

void settings() {
  // Set size to 600x600
  size(600, 600);
}

void setup() {
  // Initialize entities
  player = new Player();
  player.setTexture("player.png");
  player.move(100, 100);

  player2 = new Player();
  player2.setTexture("player.png");
  player2.move(100, 100);

  enemy1 = new Entity();
  enemy1.setTexture("enemy1.png");
  enemy1.screenWidth = width;
  enemy1.screenHeight = height;
  enemy1.enableAI();
  enemy1.centerOnScreen();

  creeper = new Entity();
  creeper.setTexture("creeper.png");
  creeper.screenWidth = width;
  creeper.screenHeight = height;
  creeper.enableAI();
  creeper.centerOnScreen();

  // Start multiplayer client
  //wsClient = new WebsocketClient(this, "ws://localhost:8880/");

  // Set text properties
  textAlign(LEFT, CENTER);
}

void draw() {
  // Catch any exceptions
  try {
    // Check if game is not over
    if (!gameOver) {
      // set status text to default
      statusText = "Click and move mouse to move player, you can also use WASD to move player";

      // send player coords
      //wsClient.sendMessage(player.posX + " " + player.posY);

      // check if player collided an enemy
      if (player.posX == enemy1.posX) {
        color(255, 10, 10);
        statusText = "Game over! Press space to continue";
        gameOver = true;
        playerScore = 0;
        //wsClient.sendMessage("gameOver");
      }

      // Increase score by random number if the random number is 40
      float randomNum = floor(random(100));
      if (randomNum == 40) playerScore++;

      // Clear screen with white color
      clearScreen();

      // Draw the status text
      fill(gameOver ? 200 : 0, 10, 10);
      text(statusText, 10, height - 15);

      // Draw the score
      fill(200, 10, 10);
      text("Score: " + playerScore, 10, 10);
      
      // Draw the chat text
      fill(100, 100, 100);
      text(chatText, 10, 20);
      
      // Check if mouse mode is activated
      if (mouseMode) {
        // move player to mouse coords
        player.move(mouseX, mouseY);
      }

      // Constrain player into screen
      player.posX = constrain(player.posX, 0, width);
      player.posY = constrain(player.posY, 25, height);

      // Draw the players
      player.draw();
      player2.draw();

      // Draw the entities
      enemy1.draw();
      creeper.draw();
    }
  }     
  catch (Exception e) {
    // Print exception stacktrace
    println("------- Exception ---------");
    e.printStackTrace();
  }
}

void keyPressed() {
  // Move player according to the keys
  if (!chatMode && key == 'w') {
    player.moveUp(playerSpeed);
  } else if (!chatMode && key == 'a') {
    player.moveLeft(playerSpeed);
  } else if (!chatMode && key == 's') {
    player.moveDown(playerSpeed);
  } else if (!chatMode && key == 'd') {
    player.moveRight(playerSpeed);
  } else if (!chatMode && key == ' ') {
    // Resume game if SPACE key pressed
    gameOver = false;
  } else if(!chatMode && key == 't') {
    chatMode = true;
  }
  
  if(chatMode) {

  }
}

void mousePressed() {
  // Activate mouse mode when mouse button is pressed
  mouseMode = true;
}

void mouseReleased() {
  // Deactivate mouse mode when mouse button is released 
  mouseMode = false;
}

//void webSocketEvent(String msg) {
//  // Print messages from server
//  println(msg);
//    if (msg.startsWith("P") || msg.startsWith("")) {
//    return;
//  } else {
//    String[] slicedMessage = msg.split(" ");
//    player2.posX = Integer.parseInt(slicedMessage[0]);
//    player2.posY = Integer.parseInt(slicedMessage[1]);
//  }
//}
