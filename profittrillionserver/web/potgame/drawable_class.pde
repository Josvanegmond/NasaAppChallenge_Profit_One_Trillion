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
	void drawOnDayNumber(float dayNumber) {
		stroke(255, 255, 255);
		fill(mining ? color(0, 0, 255) : color(255, 255, 0));
		strokeWeight(2);
		rect(100, height - 78, 100, 40);
		fill(0, 0, 0);
		textSize(20);
		text(mining ? "Mining..." : "Mine!", 118, height - 52);
		textSize(12);
	}
	
	void checkAndHandle() {
		if (mouseX - 100 < 100 && mouseY - (height - 78) < 40
				&& miner.isOnAsteroid() && miner.hasRoom()) {
			mining = !mining;
		}
	}
}
