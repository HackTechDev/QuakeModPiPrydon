void() fadethink =
{
	local entity e;
	local float f;

	self.nextthink = time + 0.1;
	e = find(world, classname, "dummy");
	f = 0;
	while(e != world && !f)
	{
		if (e.origin_x > self.absmin_x)
			if (e.origin_x < self.absmax_x)
				if (e.origin_y > self.absmin_y)
					if (e.origin_y < self.absmax_y)
						if (e.origin_z < self.absmin_z)
							f = 1;
		e = find(e, classname, "dummy");
	}
	if (f)
	{
		if (self.alpha != 0)
		{

			self.alpha = self.alpha - fadeinterval;
			self.nextthink = time + 0.01;
			if (self.alpha <= 0)
			{
				self.alpha = 0;
				self.model = "";
				self.modelindex = self.str;
			}
		}
	}
	else
	{
		if (self.alpha != 1)
		{
			self.model = self.netname;
			self.modelindex = self.str;
			self.alpha = self.alpha + fadeinterval;
			self.nextthink = time + 0.01;
			if (self.alpha >= 1)
				self.alpha = 1;
		}
	}
};

void() func_fadewall =
{
	self.angles = '0 0 0';
	self.movetype = MOVETYPE_NONE;	// so it doesn't get pushed by anything
	self.solid = SOLID_NOT;
	setmodel (self, self.model);
	self.netname = self.model;
	self.str = self.modelindex;
	self.think = fadethink;
	self.alpha = 1;
	self.nextthink = time + 0.1;
};

