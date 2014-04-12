class Planet extends Body {
  color col;
  int size;

  Planet( String name, Orbit orbit, color col, int size, PImage planetImage) {
    super(name, orbit, planetImage);
    this.col = col;
    this.size = size;
  }

  void drawOnDayNumber(float dayNumber) {
    super.drawOnDayNumber(dayNumber);
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


