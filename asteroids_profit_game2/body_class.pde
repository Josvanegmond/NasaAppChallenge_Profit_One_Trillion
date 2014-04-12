class Body {
  final String name;
  private final Orbit orbit;
  private final PImage bodyImage;
  
  PVector position = new PVector(0, 0);
  protected Player presentPlayer;

  Body(String name, Orbit orbit, PImage bodyImage) {
    this.name = name;
    this.orbit = orbit;
    this.bodyImage = bodyImage;
  }    
   
  void setPlayer(Player player) {
    this.presentPlayer = player;
  }

  void drawOnDayNumber(float dayNumber) {
    position = orbit.calculatePositionForDay(dayNumber);

    image(bodyImage, position.x + offSetX - bodyImage.height/2, position.y + offSetY - bodyImage.width/2);

    if ( presentPlayer != null) {
      noFill();
      stroke(255, 255, 255);
      ellipse( position.x + offSetX, position.y + offSetY, 20, 40 );
      ellipse( position.x + offSetX, position.y + offSetY, 40, 20 );
    }
  }
}
