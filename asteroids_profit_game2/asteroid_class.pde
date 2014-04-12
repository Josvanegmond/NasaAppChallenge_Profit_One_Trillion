class Asteroid extends Body {  
  private float minableProfit; 
 
  Asteroid(String name, Orbit orbit, float minableProfit) {
    super(name, orbit, asteroidImage);
    this.minableProfit = minableProfit;
  }
  
  void mine(Player player) {
     float minedProfit = player.addMetal(minableProfit);    
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
  
  protected void onTouch() {
   	stroke(200, 100, 50);
   	strokeWeight(5);
   	ellipse( position.x, position.y, asteroidImage.width, asteroidImage.height );
   	fill( 150, 150, 150 );
   	text( "Name: " + this.name + "\nProfit: " + this.minableProfit + " billion" , position.x + asteroidImage.width, position.y );
  }
}
