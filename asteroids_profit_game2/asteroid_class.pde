class Asteroid extends Body {  
  private float minableProfit; 
 
  Asteroid(String name, Orbit orbit, float minableProfit) {
    super(name, orbit, asteroidImage);
    this.minableProfit = minableProfit;
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
}
