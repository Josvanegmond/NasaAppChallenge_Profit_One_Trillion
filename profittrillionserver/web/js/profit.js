$(document).ready(function() {
	pot.Page.registerClickListeners();
	
	$("#lobby").hide();
	$("#multilobby").hide();
	
	// This is hacky and wrong, should be done betterer.
	var enabledMoveChecker = false;
	$("#gameScreen").click(function () {
		var pjs = pot.Game.getPJSObject();
		if (pjs.playerLoaded() && !pjs.hasStarted() && !enabledMoveChecker) {
			console.log("Registering move checker and showing menu");
			$("#lobby").show();
			pjs.setMoveChecker(pot.Game);
			enabledMoveChecker = true;
		}
	});
	
	var nameField = $("#name");
	nameField.keyup(pot.Page.validateJoin);
	nameField.keyup(pot.Page.validateCreate);
	
	pot.Page.validateJoin();
	pot.Page.validateCreate();
});

pot.Page = function() {};

pot.Page.registerClickListeners = function() {
	$("#single").click(pot.Page.clickSingle);
	$("#multi").click(pot.Page.clickMulti);
	$("#create").click(pot.Page.clickCreate);
	$("#join").click(pot.Page.clickJoin);
};

pot.Page.clickSingle = function() {
	pot.Game.getPJSObject().start();
	$("#lobby").hide();
};

pot.Page.clickMulti = function() {
	pot.Game.list(pot.Page.refreshGameList);
	$("#gameselection").hide();
	$("#multilobby").show();
};

pot.Page.clickCreate = function() {
	var playerName = $("#name").val();
	var playerColor = $("#colorPicker").val();
	if (playerName != null && playerName != "") {
		pot.Game.create(playerName, playerColor);
		$("#lobby").hide();
	}
};

pot.Page.clickJoin = function() {
	var playerName = $("#name").val();
	var playerColor = $("#colorPicker").val();
	var selectedGameId = $(".game[data-selected]").attr("data-game-id");
	if (playerName != null && playerName != "" && selectedGameId) {
		pot.Game.join(selectedGameId, playerName, playerColor);
	}
};

pot.Page.refreshGameList = function(data) {
	var gameList = $("#gamelist");
	gameList.empty();
	if (data.length == 0) {
		gameList.append("No games available to join, why not create one?")
	}
	
	data.forEach(function(info) {
		// Info is a list of structure: [gameId, playerName, playerColor]
		var colorBlock = $("<div></div>")
			.addClass("colorBlock")
			.css("background-color", "#" + info[2]);
		
		var gameRow = $("<div></div>")
			.addClass("line")
			.addClass("game")
			.attr("data-game-id", info[0])
			.append(info[1])
			.append(colorBlock)
			.click(function () {
				var wasSelected = $(".game[data-game-id='" + info[0] +"']").attr("data-selected");
				$(".game").attr("data-selected", null);
				if (!wasSelected) {
					$(".game[data-game-id='" + info[0] +"']").attr("data-selected", "true");
				}
				
				pot.Page.validateJoin();
			});
		gameList.append(gameRow);
	});
};

pot.Page.validateJoin = function() {
	var gameSelected = $(".game[data-selected]").length;
	var namePresent = $("#name").val() != "";
	var join = $("#join");
	
	join.attr("disabled", namePresent && gameSelected ? null : "true");
	join.attr("title", namePresent ?
			gameSelected ? null : "Select game to join" :
			"Fill in player name first")
};

pot.Page.validateCreate = function() {
	var namePresent = $("#name").val() != "";
	var create = $("#create");
	create.attr("disabled", namePresent ? null : "true");
	create.attr("title" , namePresent ? null : "Fill in player name first");
};