class Player
{
  final String name;
  
  Body location;
  
  float fuelLevel = 100;
  int metalLevel = 0;
  int profitLevel = 0;
  
  PVector targetLocation;
  
  Player( String name, Body startLocation) {
    this.name = name;
    this.location = startLocation;
  }
  
  void draw() {
	  noFill();
	  strokeWeight(2);
	  stroke(255, 255, 255);
	  float xv = location.position.x;
	  float yv = location.position.y;
	  ellipse( xv, yv, 20, 40 );
	  ellipse( xv, yv, 40, 20 );
	  
	  noStroke();
	  fill(0, 200, 255, 70);
	  ellipse( xv, yv, int(fuelLevel * 1.2), int(fuelLevel * 1.2)  );
  }
  
  boolean isWithinReach(Body body) {
   	float fuelRange = fuelLevel * 0.6;
   	float xDifference = abs(body.position.x - location.position.x); 
   	float yDifference = abs(body.position.y - location.position.y);
    return xDifference < fuelRange && yDifference < fuelRange && sqrt(xDifference*xDifference + yDifference*yDifference) < fuelRange;
  }
  
  void addMetal(float change) {
    metalLevel += change;
  }
  
  void setLocation(Body location) {
    this.location = location;
  } 
  
  public void setMoveTarget( PVector targetLocation ) {
  	this.targetLocation = targetLocation;
  }
  
  public boolean canMove() {
  	return (this.fuelLevel > 0);
  }
}
