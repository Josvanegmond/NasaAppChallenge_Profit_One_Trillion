class Player
{
  String name;
  
  int playerX = 0;
  int playerY = 0;
  
  int fuelLevel = 100;
  int metalLevel = 0;
  int profitLevel = 0;
  
  PVector targetLocation;
  
  public Player( String name )
  {
	this.name = name;
  }
  
  public void addMetal(float change)
  {
    metalLevel += change;
  }
  
  private float getProfit()
  {
    return profit;
  }
  
  
  public void updatePosition()
  {
  }
  
  
  public void setMoveTarget( PVector targetLocation )
  {
  	this.targetLocation = targetLocation;
  }
  
  public boolean canMove()
  {
  	return (this.fuelLevel > 0);
  }
  
  

}
