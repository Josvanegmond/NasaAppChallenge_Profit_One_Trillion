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
    fill(col);
    text( name.substring(0, 2), position.x, position.y);
  }
}
