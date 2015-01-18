
void() SUB_Null = {};
void() SUB_Null2 = {};

void() SUB_Remove = {remove(self);};

void(string modelname) Precache_Set =
{
	precache_model(modelname);
	setmodel(self, modelname);
};

void(void() func, entity e) call =
{
	local entity oself;
	oself = self;
	self = e;
	func();
	self = oself;
};

float(float slot) GetSlot =
{
	if (slot == 1)
		return self.slot1;
	else if (slot == 2)
		return self.slot2;
	else if (slot == 3)
		return self.slot3;
	else if (slot == 4)
		return self.slot4;
	else if (slot == 5)
		return self.slot5;
	else if (slot == 6)
		return self.slot6;
	else if (slot == 7)
		return self.slot7;
	else if (slot == 8)
		return self.slot8;
	return 0;
};

void(float slot, float it) SetSlot =
{
	if (slot == 1)
		self.slot1 = it;
	else if (slot == 2)
		self.slot2 = it;
	else if (slot == 3)
		self.slot3 = it;
	else if (slot == 4)
		self.slot4 = it;
	else if (slot == 5)
		self.slot5 = it;
	else if (slot == 6)
		self.slot6 = it;
	else if (slot == 7)
		self.slot7 = it;
	else if (slot == 8)
		self.slot8 = it;

};

float(float it, float pref, float suf, float start, float check) hasitem =
{
	local float i;
	
	for (i=start; i <= 8; i = i + 1)
	{
		simplestat(GetSlot(i));

		if (it == stat_it)
		{
			if (check)
			{
				if (pref != stat_pref)
					continue;
			
				if (suf != stat_suf)
					continue;
			}
			return i;
		}
	}
	return FALSE;

};

void(float a, float z) CycleFrames = 
{
	self.frame = self.frame + 1;
	if (self.frame < a || self.frame > z)
		self.frame = a;
};



void(string h) menutrigger =
{

	if (h == "m_sell")
		openmenu(activator.m_subject.owner, m_sell, activator);
	else if (h == "m_repair")
		openmenu(activator.m_subject.owner, m_repair, activator);
	else if (h == "m_exit")
		closemenu(activator.m_subject.owner);
	else if (h == "m_reset")
		activator._targ = activator;
	else if (h == "m_save")
		InnSave();
	else if (h == "m_identify")
		openmenu(activator.m_subject.owner, m_identify, activator);
};
// story values above 15 are treated as flags
// 0 if it works
// -1 if we're below minimum / not done
// 1 if we're above max / done

float(entity e) CheckStory =
{
	local float mask;

	if (e.story_min > 15)
		mask = 240;
	else
		mask = 15;
	if (e.story_min > (story & mask))
		return -1;
	if (e.story_max)
	{
		if (e.story_max > 15)
			mask = 240;
		else
			mask = 15;	
		if (e.story_max <= (story & mask))
			return 1;
	}
	return 0;
};
void(entity who, entity whodunit, entity whofrom, float num) Trigger =
{
	local entity  e;
	
	activator = whodunit;
	e = world;
	other = whofrom;
	if (!num || num == 4)
	if (who.target)
	{
		do
		{
			e = find(e, targetname, who.target);
			if (e.use)
				if (!CheckStory(e))
					call(e.use, e);
		} while(e);
		menutrigger(who.target);
	}
	if (!num || num == 1)
	if (who.target1)
	{
		e = world;
		do
		{
			e = find(e, targetname, who.target1);
			if (e.use)
				call(e.use, e);
		} while(e);
		menutrigger(who.target1);

	}
	if (!num || num == 2)
	if (who.target2)
	{
		e = world;
		do
		{
			e = find(e, targetname, who.target2);
			if (e.use)
				call(e.use, e);
		} while(e);
		menutrigger(who.target2);

	}
	if (!num || num == 3)
	if (who.target3)
	{
		e = world;
		do
		{
			e = find(e, targetname, who.target3);
			if (e.use)
				call(e.use, e);
		} while(e);
		menutrigger(who.target3);
	}

};

void() generictrigger = 
{
	Trigger(self, other, self, 0);
};

void() playertrigger=
{
	local entity e;
	e = self.m_subject;
	if (self.classname == "dummy")
		self.m_subject = self;
		
	Trigger(self, self, other, 4);
	if (self.m_subject == self)
		self.m_subject = e;
};

void() InitTrigger =
{
	self.solid = SOLID_TRIGGER;
	setmodel (self, self.model);	// set size and link into world
	self.movetype = MOVETYPE_NONE;
	self.modelindex = 0;
	self.model = "";
};
float(entity e) visible =
{
	traceline(self.origin, (e.absmin + e.absmax) * 0.5, FALSE, self);
	if (trace_fraction == 1)
		return TRUE;
	else if (trace_ent == e)
		return TRUE;
	else
		return FALSE;
};
entity(float ofs, float sped, string mdel) launch_projectile =
{
	local entity e;
	makevectors(self.angles);
	e = spawn();
	e.owner = self;
	e.velocity = normalize(self.enemy.origin - self.origin) * sped;

	e.angles = vectoangles(e.velocity);
	if (ofs)
	{
		e.angles_y = e.angles_y + ofs;
		makevectors(e.angles);
		e.velocity = v_forward * sped;
	}
	e.dest1 = e.velocity;
	e.movetype = MOVETYPE_FLY;
	e.solid = SOLID_BBOX;
	setmodel(e, mdel);
	setorigin(e, self.origin + v_up * 16 + v_forward * 8);
	e.enemy = self;
	e.think = SUB_Remove;
	e.nextthink = time + 5;
	setsize(e, '0 0 0', '0 0 0');
	return e;

};



entity() find_spot =
{
	local vector org;
	local float dist, dir, runaway;
	local entity e, oself;
	
	oself = self;
	self = spawn();
	setsize(self, VEC_HULL_MIN, VEC_HULL_MAX);
	self.movetype = MOVETYPE_STEP;
	dist = 34;
	makevectors(self.angles);
	if (oself.enemy)
		org = oself.enemy.origin;
	else
		org = oself.origin;
	org = org + '0 0 48';
	//self.flags = FL_FLY;
	self.solid = SOLID_BBOX;
	do 
	{
		if (dir == 0)
			setorigin(self, org + v_forward * dist);
		else if (dir == 1)
			setorigin(self, org + v_forward * -1 * dist);
		else if (dir == 2)
			setorigin(self, org + v_right * dist);
		else if (dir == 3)
			setorigin(self, org + v_right * -1 * dist);
		else if (dir == 4)
		{
			dir = -1;
			dist = dist + 16;
		}
		droptofloor();
		dir = dir + 1;
		if (self != findradius(self.origin, 50))
			continue;
		if (runaway > 20)
			break;
		runaway = runaway + 1;			
	}
	while(!walkmove(0, 0));
	self.flags = 0;
	e = self;
	self = oself;
	return e;
};