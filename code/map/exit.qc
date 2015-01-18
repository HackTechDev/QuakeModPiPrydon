void() gochangelevel =
{
	if (CheckStory(self))
	{
		if (self.attack_finished < time)
		{
			sound(self, CHAN_AUTO, "misc/locked.wav", 1, ATTN_NORM);
			sprint(other.owner, "locked\n");
			self.attack_finished = time + 1;
		}
		return;
	}
	changelevel(self.message);
};


void() exit =
{
	if(self.story_min || self.story_max)
		precache_sound ("misc/locked.wav");
	if (!self.netname)
		self.netname = "Exit";
	setmodel(self, self.model);
	self.movetype = MOVETYPE_NONE;
	self.solid = SOLID_BBOX;
	setorigin(self, self.origin);
	if (self.spawnflags & 1)
	{
		self.modelindex = 0;
		self.model = "";
	}
	self.use = gochangelevel;
	
	if (self.message)
		self.action = gochangelevel;
	else
		self.action = donothing;

};




void() gowarp =
{
	if (CheckStory(self))
	{
		if (self.attack_finished < time)
		{
			sound(self, CHAN_AUTO, "misc/locked.wav", 1, ATTN_NORM);
			sprint(other.owner, "locked\n");
			self.attack_finished = time + 1;
		}
		return;
	}
	localcmd(self.message);
	localcmd("\n");
};


void() warp =
{
	if(self.story_min || self.story_max)
		precache_sound ("misc/locked.wav");
	if (!self.netname)
		self.netname = "Warp";
	setmodel(self, self.model);
	self.movetype = MOVETYPE_NONE;
	self.solid = SOLID_BBOX;
	setorigin(self, self.origin);
	if (self.spawnflags & 1)
	{
		self.modelindex = 0;
		self.model = "";
	}
	self.use = gowarp;
	
	if (self.message)
		self.action = gowarp;
	else
		self.action = donothing;

};


