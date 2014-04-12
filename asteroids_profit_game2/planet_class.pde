class Planet {
  PVector position = new PVector(0, 0);
  
  String name;
  color col;
  Orbit orbit;
  int size;
  PImage planetImage;

  int playerNumber = 0;

  Planet( String name, Orbit orbit, color colI, int sizeI, PImage planetImage) {
    this.name = name;
    this.orbit = orbit;
    col = colI;
    size = sizeI;
    this.planetImage = planetImage;
  }

  void setPlayerNumber(int pNumber) {
    playerNumber = pNumber;
  }

  void drawPlanetOnDayNumber(float dayNumber) {
    position = orbit.calculatePositionForDay(dayNumber);

    fill(col);
    //ellipse( width/2 + xv*solarSystemX, height/2 + yv*solarSystemY, size, size/2 );
    image ( planetImage, position.x + offSetX - planetImage.width/2, position.y + offSetY- planetImage.height/2);
    if (name.equals("cargo")) {
      if ( playerNumber > 0 ) {
        noFill();
        stroke(255, 255, 255);
        int xe =  (int)(position.x + offSetX - planetImage.width/2);
        int ye = (int)(position.y + offSetY- planetImage.height/2);
        ellipse( xe, ye, 20, 40 );
        ellipse( xe, ye, 40, 20 );
      }
    }
    text( name.substring(0, 2), position.x  + offSetX, position.y  + offSetY);
  }
}


