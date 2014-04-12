class Player
{
  final String name;
  
  Body location;
  
  int fuelLevel = 100;
  int metalLevel = 0;
  int profitLevel = 0;
  
  PVector targetLocation;
  
  public Player( String name, Body startLocation)
  {
    	this.name = name;
     this.location = startLocation;
  }
  
  public void draw() {
	  noFill();
	  strokeWeight(2);
	  stroke(255, 255, 255);
	  float xv = location.position.x + offSetX;
	  float yv = location.position.y + offSetY;
	  ellipse( xv, yv, 20, 40 );
	  ellipse( xv, yv, 40, 20 );
	  
	  noStroke();
	  fill(0, 200, 255, 70);
	  ellipse( xv, yv, int(fuelLevel * 1.2), int(fuelLevel * 1.2)  );
  }
  
  public void addMetal(float change)
  {
    metalLevel += change;
  }
  
  void setLocation(Body location) {
    this.location = location;
  }
  
  private float getProfit()
  {
    return profitLevel;
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
