nosave var float monclasses;

void() info_class =
{
	monclasses = monclasses + 1;
	self.monnum = monclasses;
	if (self.model)
		precache_model(self.model);
	else
		remove(self);
	if (self.noise)
		precache_sound(self.noise);
	if (self.noise1)
		precache_sound(self.noise1);
	if (self.noise2)
		precache_sound(self.noise2);
	if (self.noise3)
		precache_sound(self.noise3);
	if (self.noise4)
		precache_sound(self.noise4);
};


void() monster_spawn_go =
{
	local float f;
	local entity e;
	
	f = ceil(monclasses * random());
	e = find(world, classname, "info_class");

	while(e)
	{
		if (e.monnum == f)
		{
			self.model = e.model;
			self.lvl = e.frags;
			self.monnum = e.monnum;
			self.speed = e.speed;
			self.netname = e.netname;
			self.noise = e.noise;
			self.noise1 = e.noise1;
			self.noise2 = e.noise2;
			self.noise3 = e.noise3;
			self.noise4 = e.noise4;
			self.droprandom = e.droprandom;
			self.slot1 = e.slot1;
			self.slot2 = e.slot2;
			self.slot3 = e.slot3;
			// an so on
			self.skin = e.skin;
			self.finalangle = e.finalangle;
			self.gotstuff = e.gotstuff;
			self.ai = e.ai;
			self.flags = e.flags;
			self.spell = e.spell;
			self.flags = e.flags;
			self.spec = e.spec;
			self.poidam = e.poidam;
			self.lit = e.lit;
			self.fire = e.fire;
			self.rightarm = e.rightarm;
			self.leftarm = e.leftarm;
			self.ac = e.ac;
			self.tohit = e.tohit;
			self.dodge = e.dodge;
			self.dama = e.dama;
			self.daml = e.daml;
			self.spells1 = e.spells1;
			self.spells2 = e.spells2;
			self.max_health = e.max_health;
			self.effects = e.effects;
			self.alpha = e.alpha;
			monster_randomize();
			return;
		}
		e = find(e, classname, "info_class");
	}
	dprint("no class\n");
	remove(self);
};

void() monster_spawn =
{
	if (self.targetname != "")
		self.use = monster_spawn_go;
	else
	{
		self.nextthink = 0.01;
		self.think = monster_spawn_go;
	}
};


void() monster_skuttler =
{
	self.monnum = encode(1, 0, 0);
	self.model = "progs/skuttler.mdl";
	self.lvl = 1;
	self.speed = 0.1; // slow
	if (!self.netname)
		self.netname = "a skuttler";
	self.noise = "skuttler/attack.wav";
	self.noise3 = "skuttler/hit.wav";
	self.noise4 = "skuttler/die.wav";
	self.finalangle_x = encode('S', 'k', 'u');
	self.finalangle_y = encode('t', 't', 'l');
	self.finalangle_z = encode('e', 'r', 0);
	monster_randomize();
	
};

void() monster_scarite =
{
	self.monnum = encode(2, 0, 0);
	self.model = "progs/skuttler.mdl";
	self.skin = 1;
	self.lvl = 2;
	self.speed = 0.15; // slow
	if (!self.netname)
		self.netname = "a scarite";
	self.noise = "skuttler/attack.wav";
	self.noise3 = "skuttler/hit.wav";
	self.noise4 = "skuttler/die.wav";
	self.finalangle_x = encode('S', 'c', 'a');
	self.finalangle_y = encode('r', 'i', 't');
	self.finalangle_z = encode('e', 0, 0);
	monster_randomize();
};

void() monster_guanite =
{
	self.monnum = encode(3, 0, 0);
	self.model = "progs/horror.mdl";
	self.lvl = 2;
	self.speed = 0.5;
	if (!self.netname)
		self.netname = "a guanite";
	self.spec = STEAL_LIFE;
	self.flags = FL_FLY;
	self.noise = "horror/attack.wav";
	self.noise3 = "horror/hit.wav";
	self.noise4 = "horror/die.wav";
	self.finalangle_x = encode('G', 'u', 'a');
	self.finalangle_y = encode('n', 'i', 't');
	self.finalangle_z = encode('e', 0, 0);
	monster_randomize();
};

void() monster_drak =
{
	self.monnum = encode(4, 0, 0);
	self.model = "progs/horror.mdl";
	self.skin = 1;
	self.lvl = 7;
	self.speed = 0.5;
	if (!self.netname)
		self.netname = "a drak";
	self.spec = STEAL_LIFE;
	self.flags = FL_FLY;
	self.noise = "horror/attack.wav";
	self.noise3 = "horror/hit.wav";
	self.noise4 = "horror/die.wav";
	self.finalangle_x = encode('D', 'r', 'a');
	self.finalangle_y = encode('k', 0, 0);
	self.finalangle_z = 0;
	monster_randomize();
};
void() monster_horror =
{
	self.monnum = encode(5, 0, 0);
	self.model = "progs/horror.mdl";
	self.skin = 2;
	self.lvl = 30;
	self.speed = 0.5;
	if (!self.netname)
		self.netname = "a horror";
	self.spec = STEAL_LIFE;
	self.flags = FL_FLY;
	self.noise = "horror/attack.wav";
	self.noise3 = "horror/hit.wav";
	self.noise4 = "horror/die.wav";
	self.finalangle_x = encode('H', 'o', 'r');
	self.finalangle_y = encode('r', 'o', 'r');
	self.finalangle_z = 0;
	monster_randomize();
};

void() sewer_monster =
{
	local float r;
	r = ceil(random() * 5);
	if (r == 1)
		monster_scarite();
	else if (r == 2)
		monster_guanite();
	else if (r < 5)
		monster_skuttler();
};