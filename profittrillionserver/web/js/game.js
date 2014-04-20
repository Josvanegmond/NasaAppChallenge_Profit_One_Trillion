pot.Game = function() {};

pot.Game.object = undefined;

pot.Game.getPJSObject = function() {
	if (pot.Game.object === undefined) {
		pot.Game.object = Processing.getInstanceById("gameScreen");
	}
	
	return pot.Game.object;
};

pot.Game.reportError = function(msg, status) {
	console.log("Request to server failed.");
	console.log(msg);
	console.log(status);	
};

pot.Game.create = function(playerName, playerColor) {
	console.log("Requesting new game from server.");
	var location = pot.Game.getPJSObject().getPlayerLocation();
	pot.Game.getPJSObject().setPlayerData(playerName, playerColor);
	
	function setIdAndStartPolling(data) {
		console.log("created game with id " + data.gameId);
		pot.Game.getPJSObject().setGameId(data.gameId);
		pot.Game.pollForOpponent(data.gameId);		
	};
	
	$.ajax({
		url: "/game/start",
		type: "POST",
		contentType: "json",
		dataType: "json",
		data: JSON.stringify({
			name: playerName,
			color: playerColor,
			location: pot.Game.getPJSObject().getPlayerLocation(),
			profit: 0 }),
		success: setIdAndStartPolling,
		error: pot.Game.reportError
	});
};

pot.Game.pollForOpponent = function(gameId) {
	console.log("starting poll for game " + gameId);
	var intervalId;
	
	function handlePollResult(data) {
		if (data.started) {
			console.log("Found opponent: [" + data.opponent.name + ", @" + data.opponent.location + ", #" + data.opponent.color + "]");
			clearInterval(intervalId);
			pot.Game.getPJSObject().setOpponent(data.opponent.name, data.opponent.location, data.opponent.color);
			pot.Game.getPJSObject().start();
			console.log("Game started!");
			$("#polling").hide();
		}
		else {
			console.log("Found no opponent, game hasn't started yet.");
			if (data.gameLost) {
				console.log("Server timed out game, stopping poll");
				clearInterval(intervalId);
				$("#polling").hide();
				$("#lobby").show();
			}
		}
	};
	
	intervalId = setInterval(function() {
		$.ajax({
			url: "/game/start",
			type: "GET",
			data: { gameId: gameId },
			contentType: "json",
			dataType: "json",
			success: handlePollResult,
			error: pot.Game.reportError
		});
	}, 3000);
};

pot.Game.checkMove = function(i, player, body, minedOnPrevious, totalProfit) {
	$.ajax({
		url: "/game/move",
		type: "POST",
		data: JSON.stringify({ 
			gameId: i,
			name: player,
			target: body,
			mined: minedOnPrevious,
			profit: totalProfit
		}),
		contentType: "json",
		dataType: "json",
		success: function(game) {
			console.log("Gamestate returned: [" + game.moveAllowed + ", " + game.mineAllowed + ", " + game.opponentLocation + ", " + game.opponentProfit +"]");
			var pjs = pot.Game.getPJSObject();
			for (var asteroid in game.opponentHistory) {
				if (game.opponentHistory.hasOwnProperty(asteroid)) {
					console.log("Opponent mined " + game.opponentHistory[asteroid] + " from " + asteroid);
					pjs.handleOpponentMine(asteroid, game.opponentHistory[asteroid]);
				}
			}
			pjs.updateState(game.moveAllowed, game.mineAllowed, game.opponentLocation, game.opponentProfit);
		},
		error: pot.Game.reportError
	});	
}

pot.Game.join = function(gameId, playerName, playerColor) {
	pot.Game.getPJSObject().setPlayerData(playerName, playerColor);
	$.ajax({
		url: "/game/join",
		type: "POST",
		data: JSON.stringify(
			{ 
				gameId: gameId,
				player: {
					name: playerName,
					color: playerColor,
					location: pot.Game.getPJSObject().getPlayerLocation(),
					profit: 0
				}
			}),
		contentType: "json",
		dataType: "json",
		success: function(game) {
			console.log("Joined game with id: " + game.gameId);
			console.log("Opponent: [" + game.opponent.name + ", @" + game.opponent.location + ", #" + game.opponent.color + "]");
			pot.Game.getPJSObject().setGameId(game.gameId)
			pot.Game.getPJSObject().setOpponent(game.opponent.name, game.opponent.location, game.opponent.color);
			if (game.started) {
				pot.Game.getPJSObject().start();
				$("#lobby").hide();
			}
		},
		error: pot.Game.reportError
	});	
}

pot.Game.list = function(listProcessor) {
	$.ajax({
		url: "/game/join",
		type: "GET",
		contentType: "json",
		dataType: "json",
		success: listProcessor,
		error: pot.Game.reportError
	});	
}