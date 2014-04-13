/* @pjs preload="data/space.png, data/sun.png, data/earth_small.png, data/planet.png, data/cargo.png, data/play_screen.png, data/winner.jpg"; */

boolean started = false;

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

GameScreen screen;

void setup()
{
	size(600, 600);
	screen = new GameScreen();
}
	  
void start()
{
	started = true;
}

void draw()
{
	screen.draw();
}

void mouseClicked()
{
	screen.mouseClicked();
}

void mousePressed()
{
	screen.mousePressed();
}

void keyPressed()
{
	screen.keyPressed();
}
