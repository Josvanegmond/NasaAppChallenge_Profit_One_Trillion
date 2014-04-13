$(document).ready(function() {
	$("#create").click(function() {
		var playerName = $("#name").val();
		var playerColor = $("#colorPicker").val();
		if (playerName != null && playerColor != null) {
			console.log("Requesting new game from server.");
			var location = pot.Game.getPJSObject().getPlayerLocation();
			console.log(location + " is OK!");
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
					console.log("created game with id " + data.id);
					pot.Game.getPJSObject().setGameId(data.id);
					pollForOpponent(data.id);
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
	console.log("starting poll");
	setTimeout(function() {
		$.ajax({
			url: "/start",
			type: "GET",
			data: JSON.stringify({gameId: gameId}),
			success: function(data) {
				if (data.started) {
					console.log("Game started!");
					pot.Game.getPJSObject().setOpponent(data.opponent);
					pot.Game.getPJSObject().start();
				}
			}
		});
	}, 3000);
};