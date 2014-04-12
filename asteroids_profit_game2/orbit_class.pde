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
  
  PVector calculatePositionForDay(float day) {
    float M = ma + n * dayNumber;
    float E0 = M + e*sin(ma) * ( 1.0 + e * cos(ma ));

    float E1 = E0 - ( E0 - e * sin(E0) - M ) / ( 1 - e* cos(E0) );

    while ( abs ( E1 - E0 ) > .005 ) {
      E0 = E1;
      E1 = E0 - ( E0 - e*  sin(E0 ) - M ) / ( 1 - e * cos(E0 ) );
    }

    float xv = a * ( cos(E1 ) - e );
    float yv = a * ( sqrt(1.0 - e*e) * sin(E1) );
    
    return solarPosition(xv, yv);
  }
  
  PVector solarPosition(float xv, float yv) {
    return new PVector(
        width/2 + xv*solarSystemX,
        height/2 + yv*solarSystemY);
  }
}

class EarthOrbit extends Orbit {
  EarthOrbit() {
    super(356.0470/180.0*PI, 0.016709, 1.0, 0.9856002585/180.0*PI);
  }
  
  PVector calculatePositionForDay(float day) {
    float M = (ma + n * day);
    float E0 = M + e * sin(ma ) * ( 1.0 + e * cos(ma ));

    float xv = cos(E0 ) - e;
    float yv = sqrt(1.0 - e*e) * sin(E0);
    
    return new PVector(
        width/2 + xv*solarSystemX,
        height/2 + yv*solarSystemY);
  }  
}

