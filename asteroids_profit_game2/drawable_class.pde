class Drawable {
	void drawOnDayNumber(float dayNumber) {
		
	}
}

class PlayerStatusBar extends Drawable {
	private String label;
	private Player player;
private int xv;
	
	PlayerStatusBar(String label, int xv, Player miner) {
		this.label = label;
		this.player = miner;
		this.xv = xv;
	}
	
	void drawOnDayNumber(float dayNumber) {
		drawBar(computeLevelFull(player));
	}
	
	void drawBar(float levelFull) {
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
	
	protected float computeLevelFull(Player player) {
		if (label.equals("F")) {
			return miner.fuelLevel / 100;
		}
		return miner.metalLevel / miner.cargoHold;
  }
}
