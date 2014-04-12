class Body {
  final String name;
  private final Orbit orbit;
  private final PImage bodyImage;
  
  PVector position = new PVector(0, 0);

  Body(String name, Orbit orbit, PImage bodyImage) {
    this.name = name;
    this.orbit = orbit;
    this.bodyImage = bodyImage;
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
  }
  
  protected void isTouched() {
	  // Overwrite for hover functionality.
  }
}
