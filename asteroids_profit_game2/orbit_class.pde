class Orbit {
  float ma  ;
  float e  ;
  float a   ;
  float n  ;
  
  Orbit( String[] info )
  {
   	this( float(info[1]), float(info[2]), float(info[3]), float(info[4]) );
  }
  
  Orbit( float maI, float eI, float aI, float nI) {
    ma = maI; 
    e = eI; 
    a = aI; 
    n = nI;
  }
}

