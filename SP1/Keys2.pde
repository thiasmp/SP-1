class Keys2
{
  private boolean awDown = false;
  private boolean aaDown = false;
  private boolean asDown = false;
  private boolean adDown = false;

  public Keys2() {
  }

  public boolean awDown()
  {
    return awDown;
  }

  public boolean aaDown()  
  {
    return aaDown;
  }

  public boolean asDown()
  {
    return asDown;
  }

  public boolean adDown()
  {
    return adDown;
  }


  void sOnKeyPressed()
  {
    if (keyCode == UP) 
    {
      awDown = true;
    
  } else if (keyCode == LEFT) {

  aaDown = true;
} else if (keyCode == DOWN)
{
  asDown = true;
} else if (keyCode == RIGHT)
{
  adDown = true;
}
}


void sOnKeyReleased()
{
  {
    if (keyCode == UP) 
    {
      awDown = false;
    
  } else if (keyCode == LEFT) {

  aaDown = false;
} else if (keyCode == DOWN)
{
  asDown = false;
} else if (keyCode == RIGHT)
{
  adDown = false;
}
}
}
}
