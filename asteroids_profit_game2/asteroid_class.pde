class Asteroid
{
  private final Orbit orbit;
  private final String name;
  
  private PVector position = new PVector(0, 0);
  private float minableProfit; 
  private Player presentPlayer;
 
  Asteroid(String name, Orbit orbit, float minableProfit)
  {
    this.name = name;
    this.orbit = orbit;
    this.minableProfit = minableProfit;

    println("asteroid " + name + ": " + orbit + ", " + minableProfit );
  }
   
  void setPlayer(Player player) {
    this.presentPlayer = player;
  }
  
  void mine() {
     if (presentPlayer != null) {
       presentPlayer.addMetal(minableProfit);    
       minableProfit = 0.0;
     }
  }
  
  boolean isMined() {
    return minableProfit < 1;
  }

  void drawOrbitOnDayNumber( float dayNumber )
  {
  	float hWidth = asteroidImage.width/2;
  	float hHeight = asteroidImage.height/2;
  	
    boolean touched = false;
    if( mouseX > position.x - hWidth && mouseX < position.x + hWidth &&
    	mouseY > position.y - hHeight && mouseY < position.y + hHeight )
    {
    	touched = true;
    }
    
   	position = orbit.calculatePositionForDay(dayNumber);
//    if (isMined()) fill(255, 0, 0); 
//    else fill( 0, 255, 0);

	if( touched == true )
	{
    	stroke(200, 100, 50);
    	strokeWeight(5);
	  	ellipse( position.x + offSetX, position.y + offSetY, asteroidImage.width, asteroidImage.height );
	}
	
    image(asteroidImage, position.x + offSetX - hHeight, position.y + offSetY - hWidth );

    if ( presentPlayer != null)
    {
      noFill();
      stroke(255, 255, 255);
      ellipse( position.x + offSetX, position.y + offSetY, 20, 40 );
      ellipse( position.x + offSetX, position.y + offSetY, 40, 20 );
    }
    
    if( touched == true )
    {
    	fill( 150, 150, 150 );
    	text( "Name: " + this.name + "\nProfit: " + this.minableProfit + " billion" , position.x + asteroidImage.width, position.y );
  	}
  }
}
