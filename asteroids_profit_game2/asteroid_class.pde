class Asteroid {
  private final Orbit orbit;
  private final String name;
  
  private PVector position = new PVector(0, 0);
  private float minableProfit; 
  private Player presentPlayer;
 
  Asteroid(String name, Orbit orbit, float minableProfit) {
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

  void drawOrbitOnDayNumber(float dayNumber) {
   	position = orbit.calculatePositionForDay(dayNumber);
//    if (isMined()) fill(255, 0, 0); 
//    else fill( 0, 255, 0);

    println("We're here: ");
    image(asteroidImage, position.x + offSetX - asteroidImage.height/2, position.y + offSetY - asteroidImage.width/2);

    if ( presentPlayer != null) {
      noFill();
      stroke(255, 255, 255);
      ellipse( position.x + offSetX, position.y + offSetY, 20, 40 );
      ellipse( position.x + offSetX, position.y + offSetY, 40, 20 );
    }
  }
}
