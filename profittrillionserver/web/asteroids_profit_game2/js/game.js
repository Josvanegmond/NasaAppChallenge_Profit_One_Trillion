
pot.Game = function() {};

pot.Game.object = undefined;

pot.Game.getPJSObject = function()
{
	if(pot.Game.object === undefined)
	{
		pot.Game.object = Processing.getInstanceById("gameScreen");
	}
	
	return pot.Game.object;
};
