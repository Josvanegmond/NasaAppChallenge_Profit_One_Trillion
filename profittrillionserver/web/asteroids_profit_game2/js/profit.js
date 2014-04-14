$(document).ready(function() {
	$("#create").click(pot.Page.clickCreate);
	$("#join").click(pot.Page.clickJoin);
});

pot.Page = function() {};

pot.Page.clickCreate = function() {
	var playerName = $("#name").val();
	var playerColor = $("#colorPicker").val();
	if (playerName != null && playerName != "") {
		pot.Game.create(playerName, playerColor);
	}	
}

pot.Page.clickJoin = function() {
	var playerName = $("#name").val();
	var playerColor = $("#colorPicker").val();
	if (playerName != null && playerName != "") {
		pot.Game.list(function(data) {
			if (data.length > 0) {
				gameId = data[0][0];
			}
			pot.Game.join(gameId, playerName, playerColor);
		});
	}	
}