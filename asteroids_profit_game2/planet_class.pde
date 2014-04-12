class Planet {
  PVector position = new PVector(0, 0);
  
  String name;
  color col;
  Orbit orbit;
  int size;
  PImage image;

  int playerNumber = 0;

  Planet( String name, Orbit orbit, color colI, int sizeI, PImage image) {
    this.name = name;
    this.orbit = orbit;
    col = colI;
    size = sizeI;
    this.image = image;
  }

  void setPlayerNumber(int pNumber) {
    playerNumber = pNumber;
  }

  void drawPlanetOnDayNumber(float dayNumber) {
    position = orbit.calculatePositionForDay(dayNumber);

    fill(col);
    //ellipse( width/2 + xv*solarSystemX, height/2 + yv*solarSystemY, size, size/2 );
    image ( image, position.x + offSetX - image.width/2, position.y + offSetY- image.height/2);
    if (name.equals("cargo")) {
      if ( playerNumber > 0 ) {
        noFill();
        stroke(255, 255, 255);
        int xe =  (int)(position.x + offSetX - cargoImage.width/2);
        int ye = (int)(position.y + offSetY- cargoImage.height/2);
        ellipse( xe, ye, 20, 40 );
        ellipse( xe, ye, 40, 20 );
      }
    }
    text( name.substring(0, 2), position.x  + offSetX, position.y  + offSetY);
  }
}


