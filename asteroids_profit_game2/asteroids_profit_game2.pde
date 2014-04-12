
int numberOfAsteroids = 500;
float profitLimit = 350.0;
float distanceForConnection = 40.0 ;

int playerNumber = 0;

int linesOn = 1;

String totalStringAll = "";
String totalString = "";

ArrayList<Orbit> orbits = new ArrayList<Orbit>();
ArrayList<Planet> planets = new ArrayList<Planet>(); 

Sun sun;

int solarSystemX = 50;
int solarSystemY = 50;
int offSetX = 0;
int offSetY = 0;
int playerView = 0;

float dayNumber = 0;

Player beam = new Player ( "Beam" );

PImage sunImage;
PImage earthImage;
PImage planetImage;
PImage cargoImage;

void setup() {

  size(600, 600);

  sunImage = loadImage("sun.png");
  earthImage = loadImage("earth.png");
  planetImage = loadImage("planet.png");
  cargoImage = loadImage("cargo.png");

  sun = new Sun();

  // // planets.add ( new Planet ( name, ma, e, a, n, color, size ) );
  planets.add ( new Planet ( "Mercury", 168.6562/180.0*PI, 0.205635, 0.387098, 4.0923344368/180.0*PI, color(255, 100, 100), 5 ) );
  planets.add ( new Planet ( "Venus", 48.0052/180.0*PI, 0.006773, 0.723330, 1.6021302244/180.0*PI, color(255, 255, 100), 10 ));
  planets.add ( new Planet ( "Mars", 18.6021/180.0*PI, 0.093405, 1.523688, 0.5240207766/180.0*PI, color(255, 100, 255), 10 ));
  planets.add ( new Planet ( "Jupiter", 19.8950/180.0*PI, 0.048498, 5.20256, 0.0830853001/180.0*PI, color(255, 100, 255), 20));

  //cargo ship
  planets.add ( new Planet ( "cargo", 19.8950/180.0*PI, 0.9, 2.20256, 1.0/180.0*PI, color(255, 100, 255), 20));

  //Asteroids data loading
  String lines[] = loadStrings("./data/asteroids.dat");
// 
  for (int i = 0 ; i < lines.length; i++)
  {
  	String asteroidInfo[] = split( lines[i], "," );
  	orbits.add( new Orbit( asteroidInfo ) );
  }

  println( "added number of asteroids " + orbits.size());

  fill( (255), (255), (255));
}


float distance(PVector pos, PVector pos2) {
  return sqrt(((pos.x-pos2.x)*(pos.x-pos2.x))+((pos.y-pos2.y)*(pos.y-pos2.y)));
}

void draw()
{
  background(0);
  image ( sunImage, width/2+ offSetX - sunImage.width/2, height/2 + offSetY- sunImage.height/2);
  text ( "added number of asteroids " + orbits.size(), 10, 10);
  text ( "Total Profit Player " + str(beam.getProfit()), 10, 30);

  if ( playerNumber < 1 ) text ( "key p to add player", 10, 50);
  text ( "key m to mine (if on green asteroid)", 10, 70);
  text ( "key c to rocket to connected asteroid", 10, 90);

  dayNumber += .5;

  if ( playerView == 1)
  {
    Orbit b = orbits.get(playerNumber);
    offSetX = (int)-b.position.x+ width/2;
    offSetY = (int)-b.position.y+ height/2;

    text ( "PLAYER VIEW (toggle z)", 10, height - 10);
  }
  else
  {
    offSetX = 0;
    offSetY = 0;
    text ( "GLOBAL VIEW (toggle z)", 10, height - 10);
  }

  for (Planet planet : planets) {
    planet.drawPlanetOnDayNumber(dayNumber, sun);
  }

  sun.drawSunOnDayNumber(dayNumber);

  for (int i = orbits.size()-1; i >= 0; i--) {
    Orbit b = orbits.get(i);
    b.drawOrbitOnDayNumber(dayNumber, sun);
  }

  if ( linesOn == 1 ) {
    strokeWeight(2);
    fill(150);
    stroke(200, 100, 50);
    for (int i1 = orbits.size()-1; i1 >= 0; i1--) {
      Orbit a = orbits.get(i1);
      float dt = 100000000;
      for (int i2 = orbits.size()-1; i2 >= 0; i2--) {
        if ( i1 != i2 ) {
          Orbit b = orbits.get(i2);
          float dd = distance ( a.position, b.position );
          if ( dd < dt ) dt = dd;
          if ( dd < distanceForConnection )
            line ( a.position.x + offSetX, a.position.y + offSetY, b.position.x + offSetX, b.position.y + offSetY);
        }
      }
    }
  }
}

void mousePressed() {

  solarSystemX = (width/2 - mouseX);
  solarSystemY = (height/2 - mouseY);
}

void keyPressed() {

  if ( key == 'z' ) { //toggle overview and player view
    if (playerNumber == 0)
    {
      playerNumber = (int)random(  (orbits.size()/2-1));
      Orbit b = orbits.get(playerNumber);
      b.setPlayerNumber(1);
    }
    if ( playerView == 0 )
    {
      solarSystemX*=2;
      solarSystemY*=2;
      distanceForConnection*=2;
      playerView = 1;
    }
    else {
      playerView = 0;
      solarSystemX/=2;
      solarSystemY/=2;
      distanceForConnection/=2;
    }
  }


  if ( (key == 'p') && (playerNumber == 0 )) {
    playerNumber = (int)random(  (orbits.size()/2-1));
    Orbit b = orbits.get(playerNumber);
    b.setPlayerNumber(1);
  }

  if ( key == 'm' ) {
    Orbit b = orbits.get(playerNumber);
    if (!b.isMined()) {
      b.setMined();
      beam.addProfit(b.getProfit());    
    }
  }

  if ( key == 'j') {
    jumpToCargoShip();
  }

  if ( key == 'c' ) {
    jumpToAsteroid();
  }
}

void jumpToCargoShip() {
  Orbit a = orbits.get(playerNumber);
  Planet t;

  for (int i1 = planets.size()-1; i1 >= 0; i1--) {
    Planet b = planets.get(i1);
    if ( b.name.equals("cargo"))
    {
      float dd = distance ( a.position, b.position );
      println ( dd );
      if ( dd < distanceForConnection*5 )
      {
        println("jump");
        a.setPlayerNumber(0);
        b.setPlayerNumber(1);
        //playerNumber = 0;
        break;
      }
    }
  }
}

void jumpToAsteroid() {
  Orbit location = orbits.get(playerNumber);
  //look for connections

  float maxJumpDistance = 100000000;
  Orbit backUpMinedAsteroid = null;
  for (int i2 = orbits.size()-1; i2 >= 0; i2--) {
    if ( playerNumber != i2 ) {
      Orbit target = orbits.get(i2);
      float dd = distance( location.position, target.position );
      if ( dd < maxJumpDistance ) maxJumpDistance = dd;
      if ( dd < distanceForConnection ) {
        if (!target.isMined()) {
          doJump(location, target);
          return;
        }
        else {
          backUpMinedAsteroid = target;
        }
      }
    }
  }
  
  if (backUpMinedAsteroid != null) {
    doJump(location, backUpMinedAsteroid);   
  }
}

void doJump(Orbit source, Orbit target) {
  playerNumber = orbits.indexOf(target);
  target.setPlayerNumber(1);
  source.setPlayerNumber(0);
}
