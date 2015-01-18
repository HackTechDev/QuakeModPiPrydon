float TE_SNOW = 14;

void(vector mincorner, vector maxcorner, vector vel, float howmany, float color) te_particlesnow = #410;
void() snow_drift =
{
	self.velocity_x = random() * 20 - 10;
	self.velocity_y = random() * 20 - 10;
	self.nextthink = time + 0.1 + random();
};
void () snow_think = 
{
	local entity e;
	local float f;
	local vector v;
	

   	self.nextthink = time + 0.1;
	if (!snowtype)
	{
		e = find(world, classname, "dummy");
		f = 0;
		while(e != world && !f)
		{
			if (e.origin_x > self.absmin_x)
				if (e.origin_x < self.absmax_x)
					if (e.origin_y > self.absmin_y)
						if (e.origin_y < self.absmax_y)
							f = 1;
			e = find(e, classname, "dummy");
		}
		if (!f)
			return;
	}

	if (snowtype == 1) // Tomaz / Cheap Hack, etc.
	{
		WriteByte  (MSG_BROADCAST, SVC_TEMPENTITY);
		WriteByte  (MSG_BROADCAST, TE_SNOW);
		WriteCoord (MSG_BROADCAST, self.absmin_x);
		WriteCoord (MSG_BROADCAST, self.absmin_y);
		WriteCoord (MSG_BROADCAST, self.absmin_z);
		WriteCoord (MSG_BROADCAST, self.absmax_x);
		WriteCoord (MSG_BROADCAST, self.absmax_y);
		WriteCoord (MSG_BROADCAST, self.absmax_z);
		WriteShort (MSG_BROADCAST, self.fade);
	}
	else if (snowtype == 2) // DP
	{
		te_particlesnow(self.absmin, self.absmax, '0 0 -200', self.fade, 12);
	}
	else
	{
		f = self.fade;
		while (f)
		{
			e = spawn();
			setmodel(e, "progs/s_snow.spr");
			e.solid = SOLID_TRIGGER;
			e.touch = SUB_Remove;
			e.think = snow_drift;
			e.nextthink = time + 0.1;
			e.movetype = MOVETYPE_FLY;
			e.velocity = '0 0 -50';
			e.velocity_x = random() * 20 - 10;
			e.velocity_y = random() * 20 - 10;
			setsize(e, '0 0 0', '0 0 0');
			v_x = self.absmin_x + ((self.absmax_x - self.absmin_x) * random());
			v_y = self.absmin_y + ((self.absmax_y - self.absmin_y) * random());
			v_z = self.absmax_z - 10;
			setorigin(e, v);
			f = f - 1;
		}
		self.nextthink = time + 0.2;

	}

};

void() snow =
{
	if (netplay)
	{
		remove(self);
		return;
	}
	
	if (!snowtype)
		precache_model("progs/s_snow.spr");
	
	self.angles = '0 0 0';
	self.solid = SOLID_NOT;
	setmodel (self, self.model);	// set size and link into world
	setorigin(self, self.origin);

	self.movetype = MOVETYPE_NONE;
	self.modelindex = 0;
	self.model = "";
	self.think = snow_think;
	self.nextthink = time + 0.1;
	
	if (!self.fade)
		self.fade = 1;
};