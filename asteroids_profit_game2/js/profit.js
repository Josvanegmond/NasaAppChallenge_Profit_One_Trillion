$(document).ready(function() {
	$("#create").click(function() {
		var playerName = $("#name").val();
		var playerColor = $("#colorPicker").val();
		console.log("Clicking!");
		if (playerName != null && playerColor != null) {
			console.log("We're here!");
			var pjs = pot.Game.getPJSObject();
			pjs.start();
//			$.ajax({
//				url: "http://profittrillionserver.appspot.com/create",
//				type: "POST",
//				data: {
//					name: playerName,
//					color: playerColor,
//					location: pjs.getPlayerLocation(),
//					profit: 0}
//				done: function(data) {
//					pjs.setGameId(data.gameId)
//					pollForOpponent(data.gameId);
//				}
//			});
		}
	});
});

//pollForOpponent = function(gameId) {
//	setTimeout()
//}