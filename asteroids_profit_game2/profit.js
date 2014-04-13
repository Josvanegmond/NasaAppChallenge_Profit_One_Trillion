$(document).ready(function() {
	$("#create").click(function() {
		var pjs = Processing.getInstanceById("gameScreen");
		pjs.start();
	});
});