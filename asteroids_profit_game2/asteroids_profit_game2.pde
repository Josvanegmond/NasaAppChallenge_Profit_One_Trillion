/* @pjs preload="data/space.png, data/sun.png, data/earth_small.png, data/planet.png, data/cargo.png, data/asteroid.png, data/play_screen.png"; */

int numberOfAsteroids = 500;
float profitLimit = 350.0;
float distanceForConnection = 40.0 ;

String totalStringAll = "";
String totalString = "";

Player miner;
Planet earth;

ArrayList<Asteroid> asteroids = new ArrayList<Asteroid>();
ArrayList<Body> bodies = new ArrayList<Body>();
ArrayList<Drawable> hud = new ArrayList<Drawable>();

MineToggler mineToggler = new MineToggler();

float zoomLevel = 60;
PVector referencePosition = new PVector( 0, 0 );

boolean playerView = false;
boolean mining = false;

float dayNumber = 0;

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
  
  bodies.add ( new Body( "Sun", new SolarOrbit(), sunImage) );
  bodies.add ( new Planet ( "Mercury", new Orbit(168.6562/180.0*PI, 0.205635, 0.387098, 4.0923344368/180.0*PI), color(255, 100, 100), 5, planetImage ) );
  bodies.add ( new Planet ( "Venus", new Orbit(48.0052/180.0*PI, 0.006773, 0.723330, 1.6021302244/180.0*PI), color(255, 255, 100), 10, planetImage ) );
  earth = new Planet ( "Earth", new EarthOrbit(), color(0, 0, 255), 10, earthImage );
  bodies.add ( earth);
  bodies.add ( new Planet ( "Mars", new Orbit(18.6021/180.0*PI, 0.093405, 1.523688, 0.5240207766/180.0*PI), color(255, 100, 255), 10, planetImage ));
  bodies.add ( new Planet ( "Jupiter", new Orbit(19.8950/180.0*PI, 0.048498, 5.20256, 0.0830853001/180.0*PI), color(255, 100, 255), 20, planetImage ));

  //cargo ship
  bodies.add ( new Body ( "cargo", new Orbit(19.8950/180.0*PI, 0.9, 2.20256, 1.0/180.0*PI), cargoImage));

  //Asteroids data loading
  String lines[] = loadStrings("./data/asteroids.dat");
  for (String line : lines) {
	String[] asteroidInfo = split(line, ",");
  	asteroids.add(new Asteroid(asteroidInfo[0], new Orbit(asteroidInfo), float(asteroidInfo[5])));
  }
  
  miner = new Player("Beam", asteroids.get((int)random(  (asteroids.size()/2-1))));

  hud.add(new PlayerStatusBar("F", width - 85, miner));
  hud.add(new PlayerStatusBar("C", width - 60, miner));
  hud.add(new PlayerProfitBar(miner));
  hud.add(mineToggler);
  
  fill( (255), (255), (255));
}

void draw()
{
	miner.updateState();
	background(0);
	
	fill(150,150,150,255);
	image( backgroundImage, 0, 0, backgroundImage.width, backgroundImage.height );
  
	stroke(200, 100, 50);

	dayNumber += .5;
	
	for (Drawable body : bodies) {
		body.drawOnDayNumber(dayNumber);
	}
	
	for (Drawable asteroid : asteroids) {
		asteroid.drawOnDayNumber(dayNumber);
	}
	
	miner.drawOnDayNumber(dayNumber);

	drawHud(dayNumber);
}

void drawHud(float dayNumber) {
	image( foregroundImage, 0, 0, 600, 600 );

	for (Drawable drawable : hud) {
		drawable.drawOnDayNumber(dayNumber);
	}
}

void mousePressed() {
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
  
  mineToggler.checkAndHandle();
}

boolean travelToBodyIfWithinReach(Body body) {
  if (body.isUnderMouse() && miner.isWithinReach(body)) {
	  miner.setLocation(body);
	  return true;
  }
  return false;
}

void keyPressed() {
  if ( key == 'z')
  { //toggle overview and player view
    playerView = !playerView;
    zoomLevel *= playerView ? 2 : 0.5;
    if (playerView) {
      referencePosition = miner.getLocation().position;
    } else {
      referencePosition = new PVector(0, 0);
    }  
  }

  if (key == 'm' && miner.isOnAsteroid()) {
	  mining = !mining;
  }
}
