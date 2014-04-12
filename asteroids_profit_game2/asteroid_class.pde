class Asteroid extends Body {  
  private float minableProfit; 
 
  Asteroid(String name, Orbit orbit, float minableProfit) {
    super(name, orbit, asteroidImage);
    this.minableProfit = minableProfit;
  }
  
  void mine() {
     if ( hasPlayer() ) {
       presentPlayer.addMetal(minableProfit);    
       minableProfit = 0.0;
     }
  }
  
  boolean isMined() {
    return minableProfit < 1;
  }
  
  public void hasPlayer()
  {
  	return (presentplayer != null);
  }
  
  
  protected void isTouched() {
	stroke(200, 100, 50);
	strokeWeight(5);
  	ellipse( position.x + offSetX, position.y + offSetY, asteroidImage.width, asteroidImage.height );
	fill( 150, 150, 150 );
	text( "Name: " + this.name + "\nProfit: " + this.minableProfit + " billion" , position.x + asteroidImage.width, position.y );
  }
}