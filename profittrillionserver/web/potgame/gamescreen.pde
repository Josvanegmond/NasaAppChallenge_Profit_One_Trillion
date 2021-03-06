interface MoveChecker {
	void checkMove(int gameId, String name, String location, float mined, long profit);
}

Player miner;
Player opponent;
Planet earth;

Body proposedMove;

int gameId;

ArrayList<String> soundLocations = new ArrayList<String>();
ArrayList<Asteroid> asteroids = new ArrayList<Asteroid>();
ArrayList<Body> bodies = new ArrayList<Body>();
ArrayList<Drawable> hud = new ArrayList<Drawable>();

HashMap<String, color> colorMap = new HashMap<String, color>();

MineToggler mineToggler = new MineToggler();
MoveChecker moveChecker = null;

float zoomLevel = 60;
PVector referencePosition = new PVector( 0, 0 );

boolean playerView = false;
boolean mining = false;

float dayNumber = 0;

Audio audio;

String getPlayerLocation() {
	return miner != null ? miner.location.name : null;
}

void setPlayerData(String name, String colorHex) {
	miner.name = name;
	miner.playerColor = colorMap.get(colorHex);
}

void setGameId(int i) {
	gameId = i;
}

boolean playerLoaded() {
	return miner != null;
}

boolean setOpponent(String name, String location, String colorHex) {
	Asteroid opponentLocation = null;
	for (Asteroid asteroid : asteroids) {
		if (asteroid.name.equals(location)) {
			opponentLocation = asteroid;
		}
	}
	if (opponentLocation == null) {
		return false;
	}
	
	opponent = new Player(name, opponentLocation);
	opponent.playerColor = colorMap.get(colorHex);
	return true;
}

void setMoveChecker(MoveChecker checker) {
	moveChecker = checker;
}

boolean hasNoMoveChecker() {
	return moveChecker == null;
}

void handleOpponentMine(String asteroidName, float mined) {
	for (Asteroid asteroid : asteroids) {
		if (asteroid.name.equals(asteroidName)) {
			asteroid.mine(mined, true);
			return;
		}
	}
}

void updateState(boolean moveValid, boolean mineValid, String opponentLocation, long opponentProfit) {
	if (moveValid) {
		miner.setLocation(proposedMove);
		if (miner.isTrillionaire()) {
			// Sending extra bogus move to server to let it know about winnings.
			moveChecker.checkMove(gameId, miner.name, earth.name, 0, miner.profitLevel);
		}
		proposedMove == null;
	}
	for (Asteroid asteroid : asteroids) {
		if (asteroid.name.equals(opponentLocation)) {
			opponent.location = asteroid;
		}
	}
	for (Body body : bodies) {
		if (body.name.equals(opponentLocation)) {
			opponent.location = body;
		}		
	}
	opponent.profitLevel = opponentProfit;
}

class GameScreen extends Screen
{
	PImage backgroundImage = loadImage("/data/space.png");
	PImage foregroundImage = loadImage("/data/play_screen.png");
	
	PImage sunImage = loadImage("/data/sun.png");
	PImage earthImage = loadImage("/data/earth_small.png");
	PImage planetImage = loadImage("/data/planet.png");
	PImage cargoImage = loadImage("/data/cargo.png");
	PImage winnerImage = loadImage("/data/winner.jpg");
	PImage loserImage = loadImage("/data/loser.jpg");
	PImage asteroidImage = loadImage("/data/asteroid.png");

	public GameScreen()
	{
		audio = new Audio();
		soundLocations.add("/sounds/11023.mp3");
		soundLocations.add("/sounds/11025.mp3");
		soundLocations.add("/sounds/843.mp3");		
		soundLocations.add("/sounds/850.mp3");		
		soundLocations.add("/sounds/866.mp3");		
		soundLocations.add("/sounds/868.mp3");		
		soundLocations.add("/sounds/850.mp3");		
		soundLocations.add("/sounds/851.mp3");		
		soundLocations.add("/sounds/848.mp3");
		newSound();
		
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
		String lines[] = loadStrings("/data/asteroids.dat");
		for (String line : lines) {
			String[] asteroidInfo = split(line, ",");
			asteroids.add(new Asteroid(asteroidInfo[0], new Orbit(asteroidInfo), float(asteroidInfo[5]), asteroidImage));
		}
		
		miner = new Player(null, asteroids.get((int)random((asteroids.size()/2-1))));
			
		hud.add(new PlayerStatusBar("F", width - 85, miner));
		hud.add(new PlayerStatusBar("C", width - 60, miner));
		hud.add(new PlayerProfitBar(miner));
		hud.add(mineToggler);
		
		fill(255, 255, 255);
		
		// Temporary
		colorMap.put("FF0000", color(255, 0, 0));
		colorMap.put("00FF00", color(0, 255, 0));
		colorMap.put("0000FF", color(0, 0, 255));
		colorMap.put("FFFF00", color(255, 255, 0));
	}
	
	void draw()
	{
		background(0);
		
		fill(150,150,150,255);
		image( backgroundImage, 0, 0, backgroundImage.width, backgroundImage.height );
	  
		if (!started) {
			textSize(30);
			fill(255, 255, 255);
			text("WAITING FOR GAME", 150, 200);
			textSize(12);
			image( foregroundImage, 0, 0, 600, 600 );
			return;
		}
		
		miner.updateState();
		stroke(200, 100, 50);
	
		dayNumber += .5;
		for (Drawable body : bodies) {
			body.drawOnDayNumber(dayNumber);
		}
		
		for (Drawable asteroid : asteroids) {
			asteroid.drawOnDayNumber(dayNumber);
		}
		
		miner.drawOnDayNumber(dayNumber);
		if (opponent != null) {
			opponent.drawOnDayNumber(dayNumber);
		}
		
		//referencePosition.x = miner.getLocation().position.x;
		//referencePosition.y = miner.getLocation().position.y;
	
		drawHud(dayNumber);
		
		if (miner.isTrillionaire()) {
			showEndImage(winnerImage);
		}
		if (!miner.isTrillionaire() && opponent != null && opponent.isTrillionaire()) {
			showEndImage(loserImage);
		}
	}
	
	void drawHud(float dayNumber) {
		image( foregroundImage, 0, 0, 600, 600 );
	
		for (Drawable drawable : hud) {
			drawable.drawOnDayNumber(dayNumber);
		}
		
		if (miner.name != null) {
			textSize(30);
			fill(miner.playerColor);
			text(miner.name, 38, 28);
			textSize(12);
		}
		if (opponent != null) {
			fill(opponent.playerColor);
			text("Opponent: " + opponent.name + " - Profit: $ " + opponent.getProfitInBillions() + "B", 38, 82);
			textSize(12);
		}
	}
	
	boolean travelToBodyIfWithinReach(Body body) {
	  if (body.isUnderMouse() && miner.isWithinReach(body)) {
		  if (opponent == null) {
			  miner.setLocation(body);
		  } else {
			  proposedMove = body;
			  minedProfit = miner.isOnAsteroid() ? miner.profitOnEntry - miner.location.minableProfit : 0;
			  moveChecker.checkMove(gameId, miner.name, body.name, minedProfit, miner.profitLevel);
		  }
		  return true;
	  }
	  return false;
	}
	
	void showEndImage(endImage) {
		// Yay, you won!
		fill(0, 0, 0);
		stroke(255, 255, 255);
		strokeWeight(5);
		rect(95, 95, 410, 410);
		image(endImage, 100, 100, 400, 400);
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
	
	void keyPressed() {
	  if ( key == 'z') {
	    zoomLevel -= 10;
	  }
	  
	  if (key == 't') {
		  audio.muted = !audio.muted;
	  }
	
	  if (key == 'm' && miner.isOnAsteroid()) {
		  mining = !mining;
	  }
	}
	
	void newSound()
	{
		audio.setAttribute("src", soundLocations.get(int(Math.random() * 9)));
		audio.addEventListener("ended", newSound);
		audio.play();
	}
}