

void() main = {};


void() StartFrame = 
{
	if (time < 3)
		runtime = cvar("nomonsters");
	cache = 0;
	if (world.map)
	{
		total_monsters = rint(monsvalue);
		killed_monsters = floor((runtime+time)/60);
	}
	else
	{
		serverflags = recode(serverflags, 2, rint(averagelvl));
		dovis();
	}

};

