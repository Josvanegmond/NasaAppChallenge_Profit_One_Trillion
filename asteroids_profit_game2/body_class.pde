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
    
    float hWidth = bodyImage.width/2;
    float hHeight = bodyImage.height/2;
    if( mouseX > position.x - hWidth && mouseX < position.x + hWidth &&
    	mouseY > position.y - hHeight && mouseY < position.y + hHeight ) {
    	isTouched();
    }

    image(bodyImage, position.x + offSetX - bodyImage.height/2, position.y + offSetY - bodyImage.width/2);

    if ( presentPlayer != null) {
      noFill();
      strokeWeight(2);
      stroke(255, 255, 255);
      float xv = position.x + offSetX;
      float yv = position.y + offSetY;
      ellipse( xv, yv, 20, 40 );
      ellipse( xv, yv, 40, 20 );
      
      noStroke();
      fill(0, 200, 255, 70);
      ellipse( xv, yv, presentPlayer.fuelLevel + 20, presentPlayer.fuelLevel + 20  );
    }
  }
  
  protected void isTouched() {
	  // Overwrite for hover functionality.
  }
}
