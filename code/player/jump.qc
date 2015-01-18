void() player_jump =
{

	if (!(self.flags & FL_ONGROUND))
		return;

	self.flags = self.flags - FL_ONGROUND;	// don't stairwalk
	self.velocity_z = self.velocity_z + 270;
};

void() player_obstacles =
{
	local vector start, stop, ang;
	local float test, dist, hgt;

	if (!(self.flags & FL_ONGROUND))
		return;

	ang = normalize(self.velocity);
	ang_z = 0;
	start = self.origin + ang * 32; 
	start_z = self.origin_z + self.maxs_z;
	stop = start;
	stop_z = self.origin_z + self.mins_z;
	traceline(start, stop - '0 0 256', TRUE, self);
	if (trace_allsolid || trace_startsolid)
		return;
	hgt = trace_endpos_z - stop_z;

	if (hgt >= 0)
		return;
	start = stop - '0 0 8';
	stop = start + ang *  256;
	traceline(start, stop, TRUE, self);
	test = vlen(trace_endpos - start);
	if (test <= 20)
		return; // it's a walkable gap, do nothing
	ang_x = self.velocity_y * -1;
	ang_y = self.velocity_x;
	ang = normalize(ang);
	traceline(start - (ang * 10), start + (ang * 10), TRUE, self);
	if ((trace_fraction != 1) || trace_startsolid)
		return; // gap is only 20 wide, walkable	
	ang = self.velocity;
	ang_z = 0;
	dist = ((540 / 800) * vlen(ang));
	if (test > dist) // I can't make it
		return;
	else
	{
		ang = normalize(ang);
		//look for a ledge
		traceline(self.origin, self.origin + (ang * (test + 20)), TRUE, self); 
		if (trace_fraction != 1)
			return;
	}
	if (hgt < -18)
		player_jump();
};
