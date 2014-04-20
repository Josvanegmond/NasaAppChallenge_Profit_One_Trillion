$(document).ready(function() {
	var single = $("#single");
	var multi = $("#multi");
	var create = $("#create");
	var join = $("#join");
	var lobby = $("#lobby");
	var multilobby = $("#multilobby");
	single.click(function() {
		pot.Game.getPJSObject().start();
		lobby.hide();
	});
	multi.click(function() {
		$("#gameselection").hide();
		multilobby.show();
	});
	
	create.click(pot.Page.clickCreate);
	join.click(pot.Page.clickJoin);
	lobby.hide();
	multilobby.hide();
	$("#polling").hide();
	
	var enabledMoveChecker = false;
	$("#gameScreen").click(function () {
		var pjs = pot.Game.getPJSObject();
		if (pjs.playerLoaded() && !pjs.hasStarted() && !enabledMoveChecker) {
			console.log("Registering move checker and showing menu");
			lobby.show();
			pjs.setMoveChecker(pot.Game);
			enabledMoveChecker = true;
		}
	});
});

pot.Page = function() {};

pot.Page.clickCreate = function() {
	var playerName = $("#name").val();
	var playerColor = $("#colorPicker").val();
	if (playerName != null && playerName != "") {
		pot.Game.create(playerName, playerColor);
		$("#lobby").hide();
		$("#polling").show();
	}	
}

pot.Page.clickJoin = function() {
	var playerName = $("#name").val();
	var playerColor = $("#colorPicker").val();
	if (playerName != null && playerName != "") {
		pot.Game.list(function(data) {
			if (data.length > 0) {
				var gameId = data[0][0];
				pot.Game.join(gameId, playerName, playerColor);
			}
		});
	}	
}