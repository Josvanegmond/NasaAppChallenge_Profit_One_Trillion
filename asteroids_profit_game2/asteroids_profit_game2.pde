/* @pjs preload="data/space.png, data/sun.png, data/earth_small.png, data/planet.png, data/cargo.png, data/asteroid.png, data/play_screen.png"; */

int numberOfAsteroids = 500;
float profitLimit = 350.0;
float distanceForConnection = 40.0 ;

int playerNumber = 0;

String totalStringAll = "";
String totalString = "";

ArrayList<Asteroid> asteroids = new ArrayList<Asteroid>();
ArrayList<Body> bodies = new ArrayList<Body>(); 

int solarSystemX = 50;
int solarSystemY = 50;
int offSetX = 0;
int offSetY = 0;
int playerView = 0;

float dayNumber = 0;

Player beam;

PImage sunImage;
PImage earthImage;
PImage planetImage;
PImage cargoImage;
PImage asteroidImage;
PImage backgroundImage;
PImage foregroundImage;

void setup() {

  size(600, 600);
  
  backgroundImage = loadImage("data/space.png");
  foregroundImage = loadImage("data/play_screen.png");

  sunImage = loadImage("data/sun.png");
  earthImage = loadImage("data/earth_small.png");
  planetImage = loadImage("data/planet.png");
  cargoImage = loadImage("data/cargo.png");
  asteroidImage = loadImage("data/asteroid.png");

  // planets.add ( new Planet ( name, ma, e, a, n, color, size ) );
  bodies.add ( new Planet ( "Mercury", new Orbit(168.6562/180.0*PI, 0.205635, 0.387098, 4.0923344368/180.0*PI), color(255, 100, 100), 5, planetImage ) );
  bodies.add ( new Planet ( "Venus", new Orbit(48.0052/180.0*PI, 0.006773, 0.723330, 1.6021302244/180.0*PI), color(255, 255, 100), 10, planetImage ));
  bodies.add ( new Planet ( "Earth", new EarthOrbit(), color(0, 0, 255), 10, earthImage));
  bodies.add ( new Planet ( "Mars", new Orbit(18.6021/180.0*PI, 0.093405, 1.523688, 0.5240207766/180.0*PI), color(255, 100, 255), 10, planetImage ));
  bodies.add ( new Planet ( "Jupiter", new Orbit(19.8950/180.0*PI, 0.048498, 5.20256, 0.0830853001/180.0*PI), color(255, 100, 255), 20, planetImage ));

  //cargo ship
  bodies.add ( new Body ( "cargo", new Orbit(19.8950/180.0*PI, 0.9, 2.20256, 1.0/180.0*PI), cargoImage));

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
	
	fill(150,150,150,255);
	image( backgroundImage, 0, 0, backgroundImage.width, backgroundImage.height );
  
	strokeWeight(3);
	stroke(200, 100, 50);

	image ( sunImage, width/2+ offSetX - sunImage.width/2, height/2 + offSetY- sunImage.height/2);
	text ( "added number of asteroids " + asteroids.size(), 10, 10);
    if (beam != null) {
    	text ( "Total Profit Player " + str(beam.profitLevel), 10, 30);
    }
	
	if ( playerNumber < 1 ) { text ( "key p to add player", 10, 50); }
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
	
	for (Body body : bodies) {
		body.drawOnDayNumber(dayNumber);
	}
	
	for (Asteroid asteroid : asteroids) {
		asteroid.drawOnDayNumber(dayNumber);
	}
	
	if (beam != null) {
		beam.draw();
	}
	
	drawHud();
}

void drawHud() {
	noFill();
	stroke(255, 255, 255);
 strokeWeight(2);
	rect(width - 80, 74, 40, 100);

// stroke(0, 255, 255);
	
	fill(150,150,150,255);
	image( foregroundImage, 0, 0, 600, 600 );
}

void mousePressed() {
  if (beam == null) {
    return;
  }
  for (Asteroid asteroid : asteroids) {
	  if (travelToBodyIfWithinReach(asteroid)) {
		return;
	  }
  }
  for (Body body : bodies) {
	  if (travelToBodyIfWithinReach(body)) {
		  return;
	  }
  }
}

boolean travelToBodyIfWithinReach(Body body) {
  if (body.isUnderMouse() && beam.isWithinReach(body)) {
	  beam.setLocation(body);
	  return true;
  }
  return false;
}

void keyPressed() {
  if ( key == 'z' ) { //toggle overview and player view
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
    beam = new Player("Beam", asteroids.get(playerNumber));
  }
  
  if (beam == null) {
    return;
  }

  if ( key == 'm') {
    Asteroid b = asteroids.get(playerNumber);
    if (!b.isMined()) {
      b.mine(beam);
     }
  }
}

void doJump(Asteroid source, Asteroid target) {
  playerNumber = asteroids.indexOf(target);
  beam.setLocation(target);
}
