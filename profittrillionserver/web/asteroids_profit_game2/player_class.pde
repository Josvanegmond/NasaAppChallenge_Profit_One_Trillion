class Player extends Drawable {
  private float pixelsPerGallon = 0.6;
  private float shovelSize = 2.5;
  private float fuelLineDiameter = 0.1;
  
  final float cargoHold = 4000.0;
  final float fuelTank = 100.0;
		  
  String name;
  Body location;
  color playerColor;
  
  float fuelLevel = fuelTank;
  float metalLevel = 0;
  long profitLevel = 0;
  
  PVector targetLocation;
  
  Player( String name, Body startLocation) {
    this.name = name;
    this.location = startLocation;
  }
  
  void updateState() {
	  if (mining) {
		  Asteroid minee = (Asteroid) location; // otherwise mining shouldn't be true.
		  float removed = addMetal(min(shovelSize, minee.minableProfit));
		  minee.mine(removed);
		  mining = !minee.isMined();
	  } else if (fuelLevel < fuelTank){
		  fuelLevel += fuelLineDiameter;
	  }
  }
  
  void drawOnDayNumber(float dayNumber) {
	  boolean hasPlayerColor = playerColor != null && !playerColor.equals(0);
	  noFill();
	  strokeWeight(2);
	  color foreGroundColor = hasPlayerColor ? playerColor : color(255, 255, 255);
	  stroke(foreGroundColor);
	  float xv = location.position.x;
	  float yv = location.position.y;
	  ellipse( xv, yv, 20, 40 );
	  ellipse( xv, yv, 40, 20 );
	  
	  noStroke();
	  fill(hasPlayerColor ? playerColor : color(0, 200, 255), 70);
	  ellipse( xv, yv, int(fuelLevel * 1.2), int(fuelLevel * 1.2)  );
	  
	  fill(foreGroundColor);
	  if (name != null) {
		  text(name, xv - location.bodyImage.width/2 - 4 - textWidth(name), yv - 8);
	  }
	  this.location.showData();
  }
  
  boolean isWithinReach(Body body) {
   	float fuelRange = fuelLevel * pixelsPerGallon;
   	float xDifference = abs(body.position.x - location.position.x); 
   	float yDifference = abs(body.position.y - location.position.y);
    return xDifference < fuelRange && yDifference < fuelRange && sqrt(xDifference*xDifference + yDifference*yDifference) < fuelRange;
  }
  
  boolean isOnAsteroid() {
	  return location != null && location instanceof Asteroid;
  }
  
  private float addMetal(float change) {
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
	if (location == this.location) {
		return;
	}
	mining = false;
	if (location == earth) {
		sellMetal();
	}
	fuelLevel -= Utils.distance(this.location.position, location.position);
    this.location = location;
  }
  
  boolean hasRoom() {
	  return metalLevel < cargoHold;
  }
  
  void sellMetal() {
	  profitLevel += 100000*metalLevel;
	  metalLevel = 0.0;
	  fuelLevel = 100;
  }
  
  boolean isTrillionaire() {
	  return profitLevel / 1000000 > 1000;
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
