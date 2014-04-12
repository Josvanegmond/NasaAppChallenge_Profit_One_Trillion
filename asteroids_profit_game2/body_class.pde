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
    
    if(isUnderMouse()) {
    	onTouch();
    }

    image(bodyImage, position.x - bodyImage.height/2, position.y - bodyImage.width/2);
  }
  
  protected void onTouch() {
	  // Overwrite for hover functionality.
  }
  
  boolean isUnderMouse() {
    float hWidth = bodyImage.width/2;
    float hHeight = bodyImage.height/2;
   	return mouseX > position.x - hWidth && mouseX < position.x + hWidth &&
   	  mouseY > position.y - hHeight && mouseY < position.y + hHeight;
  }
}
