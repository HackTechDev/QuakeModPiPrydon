void() invtest = {};

void() func_illusionary =

{
	self.angles = '0 0 0';
	self.movetype = MOVETYPE_NONE;
	self.solid = SOLID_NOT;
	setmodel (self, self.model);
        makestatic (self);
};
void() func_wall =
{
	if (CheckStory(self))
	{
		remove(self);
		return;
	}
	self.angles = '0 0 0';
	self.movetype = MOVETYPE_NONE;	// so it doesn't get pushed by anything
	self.solid = SOLID_BBOX;
	setmodel (self, self.model);
};

string nextmap;

void() dripland =
{
	local float r;
	
	r = ceil(random() * 3);
	if (r == 1)
		sound(self, CHAN_AUTO, "misc/drip1.wav", 1, ATTN_NORM);
	else if (r == 2)
		sound(self, CHAN_AUTO, "misc/drip2.wav", 1, ATTN_NORM);
	else if (r == 2)
		sound(self, CHAN_AUTO, "misc/drip3.wav", 1, ATTN_NORM);
	remove(self);
};
void() makedrip =
{
	local entity e;
	e = spawn();
	setmodel(e, "progs/drop.mdl");
	setorigin(e, self.origin);
	e.solid = SOLID_TRIGGER;
	e.movetype = MOVETYPE_BOUNCE;
	e.touch = dripland;
	e.flags = 0;
	setsize(e, '0 0 0', '0 0 0');
	
	self.nextthink = time + 10 * random();
};
void() drip =
{
	if (netplay)
	{
		remove(self);
		return;
	}
	precache_sound ("misc/drip1.wav");
	precache_sound ("misc/drip2.wav");
	precache_sound ("misc/drip3.wav");
	precache_model ("progs/drop.mdl");
	self.think = makedrip;
	self.nextthink = time + 10 * random();
};


void() deadguy =
{
	if (!self.model)
		self.model = "progs/human.mdl";
	precache_model(self.model);
	setmodel(self, self.model);
	self.frame = 18;
	setsize(self, VEC_HULL_MIN, VEC_HULL_MAX);
	self.solid = SOLID_BBOX;
	droptofloor();
	self.angles_y = random() * 360;
	makestatic(self);
};