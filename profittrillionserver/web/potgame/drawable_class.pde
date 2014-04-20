/* @pjs preload="/data/go-mining.jpg, /data/go-mining-disabled.jpg, /data/asteroid.working.jpg" */

class Drawable {
	void drawOnDayNumber(float dayNumber) {
		// For overwriting.
	}
}

class PlayerStatusDrawable extends Drawable {
	private Player player;
	
	protected PlayerStatusDrawable(Player player) {
		this.player = player;
	}
	
	void drawOnDayNumber(float dayNumber) {
		drawWithComputedValue(computeValue(player));
	}
	
	protected float computeValue(Player player) {
		return 0.0;// For overwriting.
	}
	
	protected void drawWithComputedValue(float value) {
		// For overwriting.
	}
}

class PlayerStatusBar extends PlayerStatusDrawable {
	private String label;
	private int xv;
	
	PlayerStatusBar(String label, int xv, Player player) {
		super(player);
		this.label = label;
		this.xv = xv;
	}
	
	void drawWithComputedValue(float levelFull) {
		int rectHeight = 60;
		int rectWidth = 20;
		int yv = 74;
		noStroke();
		fill(255, 0, 0);
		int redBarHeight = int(60*(1.0-levelFull));
		rect(xv, yv, rectWidth, redBarHeight);
		fill(0, 255, 0);
		rect(xv, yv + redBarHeight, rectWidth, 60*levelFull);
		
		noFill();
		stroke(255, 255, 255);
		strokeWeight(2);
		rect(xv, yv, rectWidth, rectHeight);
		fill(255, 255, 255);
		text(label, xv+7, 148);
	}
	
	protected float computeValue(Player player) {
		if (label.equals("F")) {
			return player.fuelLevel / 100;
		}
		return player.metalLevel / miner.cargoHold;
  }
}

class PlayerProfitBar extends PlayerStatusDrawable {
	PlayerProfitBar(Player player) {
		super(player);
	}
	
	protected float computeValue(Player player) {
		return player.getProfitInBillions();
	}
	
	protected void drawWithComputedValue(float profit) {
		stroke(255, 255, 255);
		fill(0, 0, 0);
		strokeWeight(2);
		rect(34, 32, 200, 38);
		textSize(30);
		fill(255, 255, 255);
		text("$ " + profit + "B", 38, 60);
		textSize(12);
	}
}

class MineToggler extends Drawable {
	private PImage goMining;
	private PImage goMiningDisabled;
	private PImage working;
	
	MineToggler() {
		goMining = loadImage("/data/go-mining.jpg");
		goMiningDisabled = loadImage("/data/go-mining-disabled.jpg");
		working = loadImage("/data/working.jpg");
	}
	
	void drawOnDayNumber(float dayNumber) {
		stroke(255, 255, 255);
		noFill();
		strokeWeight(2);
		rect(99, height - 79, 102, 42);
		PImage goMiningButton = canGoMining() ? goMining : goMiningDisabled;
		PImage buttonImage = mining ? working : goMiningButton;
		image(buttonImage, 99, height - 79);
	}
	
	void checkAndHandle() {
		int xRelative = mouseX - 99;
		int yRelative = mouseY - (height - 79);
		if (xRelative < 102 && xRelative >= 0 && yRelative < 42 && yRelative >= 0 && canGoMining()) {
			mining = !mining;
		}
	}
	
	private boolean canGoMining() {
		return miner.isOnAsteroid() && miner.hasRoom() && !((Asteroid)miner.location).isMined();
	}
}
