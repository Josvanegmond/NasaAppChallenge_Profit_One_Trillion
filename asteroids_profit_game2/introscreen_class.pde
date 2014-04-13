/* @pjs preload="data/mission1.png, data/mission2.png, data/mission3.png, data/mission4.png, data/mission5.png"; */

class IntroScreen extends Screen
{
	int screen = 1;
	
	PImage mission1;
	PImage mission2;
	PImage mission3;
	PImage mission4;
	PImage mission5;
	
	public IntroScreen()
	{
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
