
// Namespace
var pot = {};

(function()
{
	// Scripts
	addScript("js/processing.js");
	addScript("js/game.js");
	addScript("js/profit.js");
	
	function addScript(url)
	{
		document.write("<script type='text/javascript' src='" + url + "?seed=" + Math.random() + "'></script>");
	}
})();
