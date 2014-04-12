/* @pjs preload="data/sun.png, data/earth.png, data/planet.png, data/cargo.png, data/asteroid.png"; */

int numberOfAsteroids = 500;
float profitLimit = 350.0;
float distanceForConnection = 40.0 ;

int playerNumber = 0;

int linesOn = 1;

String totalStringAll = "";
String totalString = "";

ArrayList<Asteroid> asteroids = new ArrayList<Asteroid>();
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
PImage asteroidImage;

void setup() {

  size(600, 600);

  sunImage = loadImage("data/sun.png");
  earthImage = loadImage("data/earth_small.png");
  planetImage = loadImage("data/planet.png");
  cargoImage = loadImage("data/cargo.png");
  asteroidImage = loadImage("data/asteroid.png");

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

  for (String line : lines) {
  	String asteroidInfo[] = split( line, ",");
  	asteroids.add(new Asteroid(asteroidInfo[0], new Orbit( asteroidInfo ), float(asteroidInfo[5])));
  }

  println( "added number of asteroids " + asteroids.size());

  fill( (255), (255), (255));
}


void draw()
{
  background(0);
  image ( sunImage, width/2+ offSetX - sunImage.width/2, height/2 + offSetY- sunImage.height/2);
  text ( "added number of asteroids " + asteroids.size(), 10, 10);
  text ( "Total Profit Player " + str(beam.getProfit()), 10, 30);

  if ( playerNumber < 1 ) text ( "key p to add player", 10, 50);
  text ( "key m to mine (if on green asteroid)", 10, 70);
  text ( "key c to rocket to connected asteroid", 10, 90);

  dayNumber += .5;

  if ( playerView == 1)
  {
    Asteroid b = asteroids.get(playerNumber);
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

  for (Asteroid asteroid : asteroids) {
    asteroid.drawOrbitOnDayNumber(dayNumber, sun);
  }

  if ( linesOn == 1 ) {
    strokeWeight(2);
    fill(150);
    stroke(200, 100, 50);
    for (int i1 = asteroids.size()-1; i1 >= 0; i1--) {
      Asteroid a = asteroids.get(i1);
      float dt = 100000000;
      for (int i2 = asteroids.size()-1; i2 >= 0; i2--) {
        if ( i1 != i2 ) {

          Asteroid b = asteroids.get(i2);
          float dd = Utils.distance ( a.position, b.position );
          
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
      playerNumber = (int)random(  (asteroids.size()/2-1));
      Asteroid b = asteroids.get(playerNumber);
      b.setPlayer(beam);
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
    playerNumber = (int)random(  (asteroids.size()/2-1));
    Asteroid b = asteroids.get(playerNumber);
    b.setPlayer(beam);
  }

  if ( key == 'm' ) {
    Asteroid b = asteroids.get(playerNumber);
    if (!b.isMined()) {
      b.mine();
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
  Asteroid a = asteroids.get(playerNumber);
  Planet t;

  for (int i1 = planets.size()-1; i1 >= 0; i1--) {
    Planet b = planets.get(i1);
    if ( b.name.equals("cargo"))
    {
      float dd = Utils.distance ( a.position, b.position );
      println ( dd );
      if ( dd < distanceForConnection*10 )
      {
        println("jump");
        a.setPlayer(null);
        b.setPlayerNumber(1);
        //playerNumber = 0;
        break;
      }
    }
  }
}

void jumpToAsteroid() {
  Asteroid location = asteroids.get(playerNumber);
  //look for connections

  float maxJumpDistance = 100000000;
  Asteroid backUpMinedAsteroid = null;
  for (int i2 = asteroids.size()-1; i2 >= 0; i2--) {
    if ( playerNumber != i2 ) {

      Asteroid target = asteroids.get(i2);
      float dd = Utils.distance( location.position, target.position );

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

void doJump(Asteroid source, Asteroid target) {
  playerNumber = asteroids.indexOf(target);
  target.setPlayer(beam);
  source.setPlayer(null);
}
