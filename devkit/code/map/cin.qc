void() dialog = 
{
	if (CheckStory(self))
	{
		remove(self);
		return;
	}
	self.use = dialog;
	if (activator == world)
		return;
	activator._targ = self;
};
void() goalpoint =
{
	self.use = goalpoint;
	self.action = generictrigger;
	
	if (activator == world)
		return;
	activator.goalentity = self;
	activator.menu = self.spawnflags;
};

void() setai =
{
	self.use = setai;
	if (activator == world)
		return;
	dprint("setai");
	dprint(activator.classname);
	dprint("\n");
	
	activator.ai = self.ai;
};

void() setaction =
{
	self.use = setaction;
	if (activator == world)
		return;
	if (self.gotstuff)
		activator.gotstuff = self.gotstuff;
	if (self.spell)
		activator.spell = self.spell;
	if (self.target)
		activator.goalentity = find(world,targetname, self.target);
};

void() info_script_run =
{
	bprint("info_script_run\n");
	if (self.weapon == 0)
		Trigger(self, activator, self, 4);
	else
		Trigger(self, activator, self, self.weapon);

	if (self.weapon < 3)
	{
		self.weapon = self.weapon + 1;
		self.nextthink = time + GetSlot(self.weapon);
		self.think = info_script_run;
	}
	else // wait to be triggered again
		self.weapon = 0;
	
};

void() info_script =
{
	self.use = info_script_run;
};


void() setcamera =
{
	self.use = setcamera;
	if (other == world)
		return;


	if (activator.owner.camera)
	{
		if (self.spawnflags)
		{
			activator.owner.camera.goalentity = world;
			if (activator.owner.camera.mangle != '0 0 0')
			{
				activator.owner.rotang = activator.owner.camera.mangle;
				activator.owner.camera.mangle = '0 0 0';
			}
		}
		else
		{
			if (activator.owner.camera.mangle == '0 0 0')
				activator.owner.camera.mangle = activator.owner.rotang;
			activator.owner.camera.goalentity = self;
			
		}
	}
};


void() setplayer =
{
	self.use = setplayer;
	if (activator == world)
		return;
	
	activator.owner.player = find(world, targetname, self.target);
	activator.owner.player.owner = activator;
	activator = activator.owner.player;
};

void() storyup =
{
	if (CheckStory(self))
	{
		remove(self);
		return;
	}
	self.use = storyup;
	if (other == world)
		return;
	if (self.lip)
		story = story + self.lip;
	else
		story = story + 1;
	serverflags = recode(serverflags, 1, story);
	remove(self);
	
};

void() storyset =
{
	local float mask;
	if (CheckStory(self))
	{
		remove(self);
		return;
	}
	self.use = storyset;
	if (other == world)
		return;
	if (self.lip > 15)
		mask = 15;
	else
		mask = 240;
	if (self.spawnflags & 2)
		story = story & mask;
	else if (self.spawnflags & 1)
		story = self.lip;
	else
		story = story & mask + self.lip;
	serverflags = recode(serverflags, 1, story);
	remove(self);
};

void() takestuff =
{
	float i;
	entity o;
	if (CheckStory(self))
	{
		remove(self);
		return;
	}
	o = self;
	self.use = takestuff;
	if (other == world)
		return;
	itemstat(self.items);
	self = activator.m_subject.owner;
	bprint(other.netname);
	bprint("\n");
	
	if (stat_loc & STACKABLE)
	{
		if (o.spawnflags)
		{
			if (itemcount(stat_it) >= stat_dur)
				Trigger(o, activator, self, 1);
			else
				Trigger(o, activator, self, 2);
		}	
		else
		{
			if (takeamount(stat_it, stat_pref, stat_suf, stat_dur))
				Trigger(o, activator, self, 1);
			else
				Trigger(o, activator, self, 2);
		}
	}
	else
	{
	
		i = hasitem(stat_it, stat_pref, stat_suf, 1, 0);
		if (i)
		{
			if (!o.spawnflags)
			{
				Unequip(i, 1);
				SetSlot(i, 0);
			}
			Trigger(o, activator, self, 1);
		}
		else
			Trigger(o, activator, self, 2);
	}
};

void() dropstuff =
{
	float i;
	entity o;
	if (CheckStory(self))
	{
		remove(self);
		return;
	}
	o = self;
	self.use = dropstuff;
	if (!other)
		return;
	// hack
	call(dropallitems, activator);
	
}