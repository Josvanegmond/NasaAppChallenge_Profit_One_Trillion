/* @pjs preload="data/asteroid.png"; */

class Asteroid extends Body {  
  float minableProfit;
  color tintColor;
  
  Asteroid(String name, Orbit orbit, float minableProfit, PImage asteroidImage ) {
    super(name, orbit, asteroidImage );
    this.minableProfit = minableProfit;
  }
  
  void mine(float minedProfit, color mineTint) {
     minableProfit -= minedProfit;
     tintColor = mineTint;
  }
  
  boolean isMined() {
    return minableProfit <= 0;
  }
 
  void drawOnDayNumber(float dayNumber) {
	  if (isMined()) {
		  tint(miner.playerColor);
	  }
	  super.drawOnDayNumber(dayNumber);
	  noTint();
  }
  
  protected void onTouch()
  {
   	stroke(200, 100, 50);
   	strokeWeight(5);
   	ellipse( position.x, position.y, bodyImage.width, bodyImage.height );
   	showData();
  }
   
  protected void showData()
  {
  	fill( 150, 255, 150 );
   	text( "Name: " + name + "\nProfit: " + minableProfit + " billion" , position.x + bodyImage.width, position.y );
  }
}
