$(document).ready(function() {
	$("#create").click(function() {
		var playerName = $("#name").val();
		var playerColor = $("#colorPicker").val();
		if (playerName != null && playerColor != null) {
			console.log("Requesting new game from server.");
			var location = pot.Game.getPJSObject().getPlayerLocation();
			$.ajax({
				url: "/start",
				type: "POST",
				contentType: "json",
				dataType: "json",
				data: JSON.stringify({
					name: playerName,
					color: playerColor,
					location: pot.Game.getPJSObject().getPlayerLocation(),
					profit: 0 }),
				success: function(data) {
					console.log("created game with id " + data.gameId);
					pot.Game.getPJSObject().setGameId(data.gameId);
					pollForOpponent(data.gameId);
				},
				error: function(msg, status) {
					console.log(msg);
					console.log(status);
				}
			});
		}
	});
});

var pollForOpponent = function(gameId) {
	console.log("starting poll for game " + gameId);
	var intervalId = setInterval(function() {
		$.ajax({
			url: "/start",
			type: "GET",
			data: { gameId: gameId },
			contentType: "json",
			dataType: "json",
			success: function(data) {
				if (data.started) {
					console.log("Game started!");
					clearInterval(intervalId);
					pot.Game.getPJSObject().setOpponent(data.opponent);
					pot.Game.getPJSObject().start();
				}
				else {
					console.log("Found no opponent, game hasn't started yet.");
					if (data.gameLost) {
						console.log("Server timed out game, stopping poll");
						clearInterval(intervalId);
					}
				}
			},
			error: function(e, msg) {
				console.log(msg);
			}
		});
	}, 3000);
};