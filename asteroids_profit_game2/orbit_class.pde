class Orbit {
  private float ma  ;
  private float e  ;
  private float a   ;
  private float n  ;
  float profit;
  PVector position;
  int playerNumber = 0;
  boolean mined = false;
  
  Orbit( String[] info )
  {
  	this( info[0], float(info[1]), float(info[2]), float(info[3]), float(info[4]), float(info[5]) );
  }
  
  Orbit( String name, float maI, float eI, float aI, float nI, float profitI) {
    ma = maI; 
    e = eI; 
    a = aI; 
    n = nI;
    profit = profitI;
    position = new PVector(0, 0);
    
    println("asteroid " + name + ": " + maI + ", " + profitI );
  }
  
  void setPlayerNumber(int pNumber) {
    playerNumber = pNumber;
  }
  
  void setMined() {
    mined = true;
  }
  
  boolean isMined() {
    return mined;
  }
  
  float getProfit() {
    return profit;
  }
}

