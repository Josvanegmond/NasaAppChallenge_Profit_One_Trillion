/* @pjs preload="data/asteroid.png"; */

class Asteroid extends Body {  
  float minableProfit; 
  Asteroid(String name, Orbit orbit, float minableProfit, PImage asteroidImage ) {
    super(name, orbit, asteroidImage );
    this.minableProfit = minableProfit;
  }
  
  void mine(float minedProfit) {
     minableProfit -= minedProfit;
  }
  
  boolean isMined() {
    return minableProfit < 1;
  }
 
  void drawOnDayNumber(float dayNumber) {
	  if (isMined()) {
		  tint(255, 0, 0);
	  }
	  super.drawOnDayNumber(dayNumber);
	  noTint();
  }
  
  protected void onTouch()
  {
   	stroke(200, 100, 50);
   	strokeWeight(5);
   	ellipse( position.x, position.y, bodyImage.width, bodyImage.height );
   	this.showData();
  }
   
  protected void showData()
  {
  	fill( 150, 255, 150 );
   	text( "Name: " + this.name + "\nProfit: " + this.minableProfit + " billion" , position.x + bodyImage.width, position.y );
  }
}
