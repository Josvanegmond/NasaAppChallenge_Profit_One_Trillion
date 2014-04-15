$(document).ready(function() {
	var single = $("#single");
	var multi = $("#multi");
	var create = $("#create");
	var join = $("#join");
	var login = $("#login");
	single.click(function() {
		pot.Game.getPJSObject().start();
		login.hide();
	});
	multi.click(function() {
		single.hide();
		multi.hide();
		create.show();
		join.show();
	});
	
	create.click(pot.Page.clickCreate);
	create.hide();
	join.click(pot.Page.clickJoin);
	join.hide();
	$("#polling").hide();
});

pot.Page = function() {};

pot.Page.clickCreate = function() {
	var playerName = $("#name").val();
	var playerColor = $("#colorPicker").val();
	if (playerName != null && playerName != "") {
		pot.Game.create(playerName, playerColor);
		$("#login").hide();
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