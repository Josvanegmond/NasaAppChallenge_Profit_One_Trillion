class Planet {
  float ma  ;
  float e  ;
  float a   ;
  float n  ;
  String name;
  color col;
  int size;
  PVector position;

  int playerNumber = 0;

  Planet( String nameI, float maI, float eI, float aI, float nI, color colI, int sizeI) {
    name = nameI;
    ma = maI; 
    e = eI; 
    a = aI; 
    n = nI;
    col = colI;
    size = sizeI;
    position = new PVector(0, 0);
  }

  void setPlayerNumber(int pNumber) {
    playerNumber = pNumber;
  }

  void drawPlanetOnDayNumber(float dayNumber, Sun sun) {
    float M = ma + n * dayNumber;
    float E0 = M + e*   sin(ma ) * ( 1.0 + e * cos(ma ));

    float E1 = E0 - ( E0 - e * sin(E0) - M ) / ( 1 - e* cos(E0) );

    while ( abs ( E1 - E0 ) > .05 ) {
      E0 = E1;
      E1 = E0 - ( E0 - e*  sin(E0 ) - M ) / ( 1 - e * cos(E0 ) );
    }

    float xv =  a * ( cos(E1 ) - e );
    float yv =  a * ( sqrt(1.0 - e*e) * sin(E1) );

    fill(col);
    //ellipse( width/2 + xv*solarSystemX, height/2 + yv*solarSystemY, size, size/2 );
    if ( !name.equals("cargo")) {
      image ( planetImage, width/2 + xv*solarSystemX + offSetX - planetImage.width/2, height/2 + yv*solarSystemY + offSetY- planetImage.height/2);
    }
    else
    {

      image ( cargoImage, width/2 + xv*solarSystemX + offSetX - cargoImage.width/2, height/2 + yv*solarSystemY + offSetY- cargoImage.height/2);

      if ( playerNumber > 0 ) {
        noFill();
        stroke(255, 255, 255);
        int xe =  (int)(width/2 + xv*solarSystemX + offSetX - cargoImage.width/2);
        int ye = (int)(height/2 + yv*solarSystemY + offSetY- cargoImage.height/2);
        ellipse( xe, ye, 20, 40 );
        ellipse( xe, ye, 40, 20 );
      }
    }
    text( name.substring(0, 2), width/2 + xv*solarSystemX  + offSetX, height/2 + yv*solarSystemY  + offSetY);
  }
}

class Sun { //actually the earth :-)
  //orbital elements of the Sun (=Earth)
  // float N = 0.0;
  //float i = 0.0;
  // float w = 282.9404 + 4.70935E-5 * d;
  float a = 1.000000 ;
  float e = 0.016709;
  float ma = 356.0470/180.0*PI ;
  float n = 0.9856002585/180.0*PI ;
  PVector position;
  Sun() {
    position = new PVector(0, 0);
  }
  float[] drawSunOnDayNumber(float d) {
    // N = 0.0;
    // i = 0.0;
    // w = 282.9404 + 4.70935E-5 * d;
    // a = 1.000000 ;
    // float M = (356.0470 + 0.9856002585 * d)/180*PI;

    float M = (ma + n * d);
    float E0 = M + e*   sin(ma ) * ( 1.0 + e * cos(ma ));

    float xv =  a * ( cos(E0 ) - e );
    float yv =  a * ( sqrt(1.0 - e*e) * sin(E0) );

    float[] sunCoordinates = {
      xv, yv
    };


    fill(255, 0, 0);

    // ellipse( width/2 + xv*solarSystemX + offSetX, height/2 + yv*solarSystemY + offSetY, 10, 10 );
    image ( earthImage, width/2 + xv*solarSystemX + offSetX - earthImage.width/2, height/2 + yv*solarSystemY + offSetY- earthImage.height/2);

    return sunCoordinates;
  }
}

