class Player extends Drawable {
  float cargoHold = 4000.0;
  final String name;
  
  Body location;
  
  float fuelLevel = 100;
  float metalLevel = 0;
  long profitLevel = 0;
  
  PVector targetLocation;
  
  Player( String name, Body startLocation) {
    this.name = name;
    this.location = startLocation;
  }
  
  void drawOnDayNumber(float dayNumber) {
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
  
  float addMetal(float change) {
	if (metalLevel + change < cargoHold) {
		metalLevel += change;
		return change;
	} else {
		float minedAmount = cargoHold - metalLevel;
		metalLevel = cargoHold;
		return minedAmount;
	}
  }
  
  void setLocation(Body location) {
	if (location == earth) {
		sellMetal();
	}
    this.location = location;
  }
  
  void sellMetal() {
	  profitLevel += 100000*metalLevel;
	  metalLevel = 0.0;
	  fuelLevel = 100;
  }
  
  Body getLocation() {
    return location;
  }
  
  public void setMoveTarget( PVector targetLocation ) {
  	this.targetLocation = targetLocation;
  }
  
  public boolean canMove() {
  	return (this.fuelLevel > 0);
  }
}
