class Asteroid {
  private final PVector position = new PVector(0, 0);
  private final Orbit orbit;
  private final String name;
  
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
     presentPlayer.addProfit(minableProfit);    
     minableProfit = 0.0;
  }
  
  boolean isMined() {
    return minableProfit < 1;
  }

  void drawOrbitOnDayNumber(float dayNumber, Sun sun) {
    float M = orbit.ma + orbit.n * dayNumber;
    float E0 = M + orbit.e*   sin(orbit.ma ) * ( 1.0 + orbit.e * cos(orbit.ma ));

    float E1 = E0 - ( E0 - orbit.e * sin(E0) - M ) / ( 1 - orbit.e* cos(E0) );

    while ( abs ( E1 - E0 ) > .0005 ) {
      E0 = E1;
      E1 = E0 - ( E0 - orbit.e*  sin(E0 ) - M ) / ( 1 - orbit.e * cos(E0 ) );
    }

    float xv =  orbit.a * ( cos(E1 ) - orbit.e );
    float yv =  orbit.a * ( sqrt(1.0 - orbit.e*orbit.e) * sin(E1) );

    position.x = width/2 + xv*solarSystemX;
    position.y = height/2 + yv*solarSystemY;

    if (isMined()) fill(255, 0, 0); 
    else fill( 0, 255, 0);

    ellipse( position.x + offSetX, position.y + offSetY, minableProfit/30, minableProfit/30 );

    if ( presentPlayer != null) {
      noFill();
      stroke(255, 255, 255);
      ellipse( position.x + offSetX, position.y + offSetY, 20, 40 );
      ellipse( position.x + offSetX, position.y + offSetY, 40, 20 );
      
    }
  }
}
