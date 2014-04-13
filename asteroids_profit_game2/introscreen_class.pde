/* @pjs preload="data/splash.png, data/mission1.jpg, data/mission2.jpg, data/mission3.jpg, data/mission4.jpg, data/mission5.jpg"; */

class IntroScreen extends Screen
{
	int screen = 0;
	
	PImage splash;
	PImage mission1;
	PImage mission2;
	PImage mission3;
	PImage mission4;
	PImage mission5;
	
	public IntroScreen()
	{
		splash = loadImage("./data/Splash.png");
		mission1 = loadImage("./data/mission1.jpg");
		mission2 = loadImage("./data/mission2.jpg");
		mission3 = loadImage("./data/mission3.jpg");
		mission4 = loadImage("./data/mission4.jpg");
		mission5 = loadImage("./data/mission5.jpg");
	}
	
	void draw()
	{
		background(0);
		
		fill(150,150,150,255);
		if( screen == 0 ) { image( splash, 0, 0, 600, 600 ); }
		if( screen == 1 ) { image( mission1, 0, 0, 600, 600 ); }
		if( screen == 2 ) { image( mission2, 0, 0, 600, 600 ); }
		if( screen == 3 ) { image( mission3, 0, 0, 600, 600 ); }
		if( screen == 4 ) { image( mission4, 0, 0, 600, 600 ); }
		if( screen == 5 ) { image( mission5, 0, 0, 600, 600 ); }
	}
	
	void mouseClicked()
	{
		screen++;
		if( screen > 5 ) { setDone( true ); }
	}
}
