/* @pjs preload="/data/space.png, /data/sun.png, /data/earth_small.png, /data/planet.png, /data/cargo.png, /data/play_screen.png, /data/winner.jpg, /data/loser.jpg"; */

boolean started = false;

Screen currentScreen;

void setup()
{
	size(600, 600);
	currentScreen = new IntroScreen();
}
	  
void start()
{
	started = true;
}

boolean hasStarted() {
	return started;
}

void draw()
{
	//if intro is done, load game
	if( currentScreen.isDone() ) { 
		currentScreen = new GameScreen();
	}
	
	currentScreen.draw();
}

void mouseClicked()
{
	currentScreen.mouseClicked();
}

void mousePressed()
{
	currentScreen.mousePressed();
}

void keyPressed()
{
	currentScreen.keyPressed();
}
