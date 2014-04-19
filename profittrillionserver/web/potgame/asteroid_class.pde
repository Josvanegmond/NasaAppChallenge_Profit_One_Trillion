/* @pjs preload="data/asteroid.png"; */

class Asteroid extends Body {  
  float minableProfit;
  boolean opponentMined = false;
  
  Asteroid(String name, Orbit orbit, float minableProfit, PImage asteroidImage ) {
    super(name, orbit, asteroidImage );
    this.minableProfit = minableProfit;
  }
  
  void mine(float minedProfit, boolean opponentMined) {
     minableProfit -= minedProfit;
     this.opponentMined = opponentMined;
  }
  
  boolean isMined() {
    return minableProfit <= 0;
  }
 
  void drawOnDayNumber(float dayNumber) {
	  if (isMined()) {
//		  tint(opponentMined ? opponent.playerColor : miner.playerColor); // This works only partially, I suspect a bug in the tint code. Perhaps a bug report might be worth the effort.
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
