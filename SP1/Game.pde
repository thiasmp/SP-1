import java.util.Random;

class Game
{
  private Random rnd;
  private int width;
  private int height;
  private int[][] board;
  private Keys keys;
  private Keys2 keys2;
  private int playerLife;
  private int player2Life;
  private Dot player;
  private Dot player2;
  private Dot[] enemies;
  private Dot[] food;


  Game(int width, int height, int numberOfEnemies, int numberOfFood)
  {
    if (width < 10 || height < 10)
    {
      throw new IllegalArgumentException("Width and height must be at least 10");
    }
    if (numberOfEnemies < 0)
    {
      throw new IllegalArgumentException("Number of enemies must be positive");
    } 
    if (numberOfFood < 0)
    {
      throw new IllegalArgumentException("Number of Food must be positive");
    }


    this.rnd = new Random();
    this.board = new int[width][height];
    this.width = width;
    this.height = height;
    keys = new Keys();
    keys2 = new Keys2();
    player = new Dot(0, 0, width-1, height-1);
    player2 = new Dot(24, 0, width-1, height-1);
    food = new Dot[numberOfFood];
    enemies = new Dot[numberOfEnemies];
    for (int i = 0; i < numberOfEnemies; ++i)
    {
      enemies[i] = new Dot(width-1, height-1, width-1, height-1);
    }
    for (int y = 0; y < numberOfFood; y++)
    {
      food[y] = new Dot((int)random(24),(int)random(24) , width-1, height-1);
    }

    this.playerLife = 100;
    this.player2Life = 100;
  }

  public int getWidth()
  {
    return width;
  }

  public int getHeight()
  {
    return height;
  }

  public int getPlayerLife()
  {
    return playerLife;
  }

  public int getPlayer2Life()
  { 
    return player2Life;
  }

  public void onKeyPressed(char ch)
  {
    keys.onKeyPressed(ch);
  }

  public void onKeyReleased(char ch)
  {
    keys.onKeyReleased(ch);
  }

  public void sOnKeyPressed(char ch2)
  {
    keys2.sOnKeyPressed();
  }

  public void sOnKeyReleased(char ch2)
  {
    keys2.sOnKeyReleased();
  }



  public void update()
  {
    updatePlayer();
    updatePlayer2();
    updateEnemies();
    updateFood();
    checkForCollisions();
    clearBoard();
    populateBoard();
    gameOver();
  }



  public int[][] getBoard()
  {
    //ToDo: Defensive copy?
    return board;
  }

  private void clearBoard()
  {
    for (int y = 0; y < height; ++y)
    {
      for (int x = 0; x < width; ++x)
      {
        board[x][y]=0;
      }
    }
  }

  private void updatePlayer()
  {
    //Update player
    if (keys.wDown() && !keys.sDown())
    {
      player.moveUp();
    }
    if (keys.aDown() && !keys.dDown())
    {
      player.moveLeft();
    }
    if (keys.sDown() && !keys.wDown())
    {
      player.moveDown();
    }
    if (keys.dDown() && !keys.aDown())
    {
      player.moveRight();
    }
  }

  private void updatePlayer2()
  {
    if (keys2.awDown() && !keys2.asDown())
    {
      player2.moveUp();
    }
    if (keys2.aaDown() && !keys2.adDown())
    {
      player2.moveLeft();
    }
    if (keys2.asDown() && !keys2.awDown())
    {
      player2.moveDown();
    }
    if (keys2.adDown() && !keys2.aaDown())
    {
      player2.moveRight();
    }
  }



  private void updateEnemies()
  {
    for (int i = 0; i < enemies.length; ++i)
    {
      //Should we follow or move randomly?
      //2 out of 3 we will follow..
      if (rnd.nextInt(3) < 2)
      {
        //We follow
        int dx = player.getX() - enemies[i].getX();
        int dy = player.getY() - enemies[i].getY();
        int nx = player2.getX() - enemies[i].getX();
        int ny = player2.getY() - enemies[i].getY();
        if (abs(dx) > abs(dy))
        {
          if (dx > 0 || nx > 0)
          {
            //Player is to the right
            enemies[i].moveRight();
          } else
          {
            //Player is to the left
            enemies[i].moveLeft();
          }
        } else if (dy > 0 || ny > 0)
        {
          //Player is down;
          enemies[i].moveDown();
        } else
        {//Player is up;
          enemies[i].moveUp();
        }
      } else
      {
        //We move randomly
        int move = rnd.nextInt(4);
        if (move == 0)
        {
          //Move right
          enemies[i].moveRight();
        } else if (move == 1)
        {
          //Move left
          enemies[i].moveLeft();
        } else if (move == 2)
        {
          //Move up
          enemies[i].moveUp();
        } else if (move == 3)
        {
          //Move down
          enemies[i].moveDown();
        }
      }
    }
  }


  private void updateFood()
  {
    for (int i = 0; i < food.length; ++i)
    {
      //Should we follow or move randomly?
      //2 out of 3 we will follow..
      if (rnd.nextInt(3) < 2)
      {
        //We follow
        int dx = player.getX() - food[i].getX();
        int dy = player.getY() - food[i].getY();
        int nx = player2.getX() - food[i].getX();
        int ny = player2.getY() - food[i].getY();
        if (abs(dx) > abs(dy))
        {
          if (dx > 0 || nx > 0)
          {
            //Player is to the right
            food[i].moveLeft();
          } else
          {
            //Player is to the left
            food[i].moveRight();
          }
        } else if (dy > 0 || ny > 0)
        {
          //Player is down;
          food[i].moveUp();
        } else
        {//Player is up;
          food[i].moveDown();
        }
      } else
      {
        //We move randomly
        int move = rnd.nextInt(4);
        if (move == 0)
        {
          //Move right
          food[i].moveRight();
        } else if (move == 1)
        {
          //Move left
          food[i].moveLeft();
        } else if (move == 2)
        {
          //Move up
          food[i].moveUp();
        } else if (move == 3)
        {
          //Move down
          food[i].moveDown();
        }
      }
    }
  }

  private void populateBoard()
  {
    //Insert players
    board[player.getX()][player.getY()] = 1;
    board[player2.getX()][player2.getY()] = 4;
    //Insert enemies
    for (int i = 0; i < enemies.length; ++i)
    {
      board[enemies[i].getX()][enemies[i].getY()] = 2;
    }
    for (int x =0; x< food.length; x++)
    {
      board[food[x].getX()][food[x].getY()] = 3;
      
    }
  }

  private void checkForCollisions()
  {
    //Check enemy collisions
    for (int i = 0; i < enemies.length; ++i)
    {
      if (enemies[i].getX() == player.getX() && enemies[i].getY() == player.getY())
      {
        //We have a collision
        --playerLife;
      }
    }
    //player2 collision
    for (int y = 0; y < enemies.length; y++)
    {
      if (enemies[y].getX() == player2.getX() && enemies[y].getY() == player2.getY())
      {
        --player2Life;
      }
    }
    //collision food player 1
    for (int x = 0; x < food.length; x++)
    {
      if (food[x].getX() == player.getX() && food[x].getY() == player.getY())
      {
        if(playerLife >= 100)
        {
          playerLife = 99; 
        }
      food[x] = new Dot((int)random(24),(int)random(24) , width-1, height-1);
        


        ++playerLife;
    
      }

      for (int z = 0; z < food.length; z++)
      {  
        if (food[z].getX() == player2.getX() && food[z].getY() == player2.getY())
        {
          if(player2Life >=100)
          {
            player2Life = 99;
          }
          food[z] = new Dot((int)random(24),(int)random(24) , width-1, height-1);
          ++player2Life;
        }
      }
    }
  }
    void gameOver() {
      if (playerLife <= 0)
      { 
        noLoop();
        clearBoard();
        print("player 2 wins");
      } else if (player2Life <= 0)
      {

        noLoop();
        clearBoard();
        print("player 1 wins");
      }
    }
  }
