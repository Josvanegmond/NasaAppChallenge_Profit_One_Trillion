class Planet {
  PVector position = new PVector(0, 0);
  
  String name;
  color col;
  Orbit orbit;
  int size;

  int playerNumber = 0;

  Planet( String name, Orbit orbit, color colI, int sizeI) {
    this.name = name;
    this.orbit = orbit;
    col = colI;
    size = sizeI;
  }

  void setPlayerNumber(int pNumber) {
    playerNumber = pNumber;
  }

  void drawPlanetOnDayNumber(float dayNumber, Sun sun) {
    position = orbit.calculatePositionForDay(dayNumber);

    fill(col);
    //ellipse( width/2 + xv*solarSystemX, height/2 + yv*solarSystemY, size, size/2 );
    if ( !name.equals("cargo")) {
      image ( planetImage, position.x + offSetX - planetImage.width/2, position.y + offSetY- planetImage.height/2);
    }
    else
    {

      image ( cargoImage, position.x + offSetX - cargoImage.width/2, position.y + offSetY- cargoImage.height/2);

      if ( playerNumber > 0 ) {
        noFill();
        stroke(255, 255, 255);
        int xe =  (int)(position.x + offSetX - cargoImage.width/2);
        int ye = (int)(position.y + offSetY- cargoImage.height/2);
        ellipse( xe, ye, 20, 40 );
        ellipse( xe, ye, 40, 20 );
      }
    }
    text( name.substring(0, 2), position.x  + offSetX, position.y  + offSetY);
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

