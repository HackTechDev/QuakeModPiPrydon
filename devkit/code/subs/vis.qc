.float realmodelindex;

void(entity m) hide =
{
	if (m.modelindex != 0)
		m.realmodelindex = m.modelindex;
	m.modelindex = 0;
};

void(entity f) show =
{
	local vector mn, mx;
	
	if (f.realmodelindex)
	{
		f.modelindex = f.realmodelindex;
		
		if (f.model)
		{
			mn = f.mins;
			mx = f.maxs;
			setmodel(f, f.model);
			setsize(f, mn, mx);

		}

	}
};

void() dovis =
{
	local entity e, m, f;

	m = nextent(world);
	while(m)
	{
		if (m.solid != SOLID_NOT)
			hide(m);
		m = nextent(m);
	}
	e = find(world, classname, "dummy");
	while(e)
	{
		f = findradius(e.origin, 512);
		while(f)
		{
			show(f);
			f = f.chain;
		}
		e = find(e, classname, "dummy");
	}
};