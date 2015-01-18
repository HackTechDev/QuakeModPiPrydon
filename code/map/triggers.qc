

void() trigger_touch =
{
	if (other.classname == "npc")
		if (self.spawnflags & 1)
			generictrigger();
	if (other.classname == "dummy")
		if (self.spawnflags & 2)
			generictrigger();
};

void() trigger_other =
{
	InitTrigger();
	self.use = generictrigger;
	self.touch = trigger_touch;
};