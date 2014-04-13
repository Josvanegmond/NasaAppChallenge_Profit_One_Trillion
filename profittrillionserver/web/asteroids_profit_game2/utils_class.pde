static class Utils
{
	public static float distance(PVector pos, PVector pos2)
	{
		return sqrt(((pos.x-pos2.x)*(pos.x-pos2.x))+((pos.y-pos2.y)*(pos.y-pos2.y)));
	}
}
