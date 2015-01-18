void(string gibmodel) spawngib =
{
	local entity e;
	e = spawn();
	setmodel(e, gibmodel);
	e.think = SUB_Remove;
	e.nextthink = time + 1 + random() * 5;
	
	setorigin(e, self.origin);
	setsize(e, '0 0 0', '0 0 0');
	e.movetype = MOVETYPE_BOUNCE;
	e.solid = SOLID_NOT;
	e.avelocity_x = random() * 600 - 300;
	e.avelocity_y = random() * 600 - 300;
	e.avelocity_z = random() * 600 - 300;
	e.velocity_x = random() * 300 - 150;
	e.velocity_y = random() * 300 - 150;
	e.velocity_z = random() * 80 + 100;
};

void() barrel_die =
{
	float i;
	dropallitems();
	for(i = 0; i < 3; i = i +1)
		spawngib("progs/shrap.mdl");
	sound(self, CHAN_AUTO, self.noise4, 1, ATTN_NORM);
	remove(self);
};

void() barrel =
{
	if (CheckStory(self))
	{
		remove(self);
		return;
	}
	if (!self.model)
		self.model = "progs/barrel.mdl";
	precache_model(self.model);
	if (!self.noise4)
		self.noise4 = "misc/barrel.wav";
	precache_sound(self.noise4);
	
	precache_model("progs/shrap.mdl");
	setmodel(self, self.model);
	setsize(self, VEC_HULL_MIN, VEC_HULL_MAX);
	
	self.classname	= "barrel";
	if (!self.netname)
		self.netname = "barrel";
	self.health = 1;
	self.max_health = 1;
	self.owner = self;
	self.player = self;
	self.movetype	= MOVETYPE_TOSS;
	self.solid	= SOLID_BBOX;
	self.team = 1;
	self.takedamage = DAMAGE_YES;
	self.flags = 0;
	self.die = barrel_die;
	self.dodge = 1;
};
