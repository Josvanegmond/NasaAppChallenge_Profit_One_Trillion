$(document).ready(function() {
	$("#create").click(pot.Page.clickCreate);
});

pot.Page = function() {};

pot.Page.clickCreate = function() {
	var playerName = $("#name").val();
	var playerColor = $("#colorPicker").val();
	if (playerName != null && playerColor != null) {
		pot.Game.create(playerName, playerColor);
	}	
}