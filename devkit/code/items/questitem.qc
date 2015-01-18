entity(float num) get_questitem =
{
	local entity e;
	
	e = find(world, classname, "questitem");
	while (e)
	{
		if (e.items == num)
			return e;
		e = find(e, classname, "questitem");
	}

	return world;

};