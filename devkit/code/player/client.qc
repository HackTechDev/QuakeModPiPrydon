
void() ClientKill = {};
void() ClientConnect = 
{	
	
	numplayers = numplayers + 1;
	bprint(self.netname);
	bprint(" joined to fight the tides of evil\n");
	gameload = 0;
};
void() ClientDisconnect = 
{
	numplayers = numplayers - 1;
	bprint(self.netname);
	bprint(" left this realm\n");
	
	if (self.camera)
		remove(self.camera);
	if (self.wayp)
		remove(self.wayp);
	if (self.player.spellprop)
		remove(self.player.spellprop);
	if (self.player.wayp)
		remove(self.player.wayp);
	if (self.player.camera)
		remove(self.player.camera);
	if (self.player)
		remove(self.player);
	if (self.cursor)
		remove(self.cursor);

};

void() PlayerPreThink = 
{
	local entity t;
	// savegame compatability hack
	if (mapname == "save")
		return;
		
	if (world.map)
		return;
	itemvalue = ((story * 8) + 5 + self.luck * 1.2) / 2.5;

	if (!self.flags & FL_CLIENT)
		return; // Quake runs extra player frames before you connect
	
	if (gameload)
	{
		if (!cvar("developer"))
		{
			prompt(self, "You must use the Inn to save", self, 0);
			stuffcmd(self, "v_cshift 0 0 0 255\n");
		}
		else
		{
			if (self.camera)
				remove(self.camera);
			self.gotstuff = time;
			self.camera = world;
			gameload = 0;
		}
	}
	h_stuff();

		
	if (self.player.ai)
	{
		h_camera();
		if (self.cursor)
			remove(self.cursor);
		self.cursor = world;
	}
	else
	{
		
		h_cursor();
		h_camera();
		t = find(world, classname, "item");
		while(t)
		{
			t.solid = SOLID_BBOX;
			setorigin(t, t.origin);
			t = find(t, classname, "item");
		}
		h_click();
		h_sbar();
		t = find(world, classname, "item");

		while(t)
		{
			t.solid = SOLID_TRIGGER;
			setorigin(t, t.origin);
			t = find(t, classname, "item");
		}
	}
};


entity() find_spawn =
{
	local entity spawn_spot, oself, e;
	float runaway;
	oself = self;
	spawn_spot = find (world, classname, "info_player_start");
	while(((spawn_spot.worldtype != lastmap) || (spawn_spot.attack_finished > time)) && runaway < 12)
	{
		spawn_spot = find (spawn_spot, classname, "info_player_start");
		runaway = runaway + 1;
	}
	if (spawn_spot)
	{
		spawn_spot.attack_finished = time + 5;
		if (spawn_spot.target)
			Trigger(spawn_spot, self, self, 0);
	}
	if (spawn_spot)
	{
		self = spawn_spot;
		e = find_spot();
		e.solid = SOLID_NOT;
		e.think = SUB_Remove;
		e.nextthink = time + 0.01;
		spawn_spot = e;
		self = oself;
	}
	if (!spawn_spot)
		error("\bNo valid starts. Coming from the correct map?\b\n");
	return spawn_spot;
};

void() PlayerPostThink = 
{

	if (mapname == "save")
	{
		if (time > 3)
			changelevel("curig2");
		return;
	}
	if (world.map)
	{
		if (time > 3)
			changelevel(world.map);
		return;
	}
	if (!self.flags & FL_CLIENT)
		return;
	self.button1 = 0;
	h_impulse();
	m_menu();

	setitems();
	if (self.player)
	{
		if (pointcontents(self.player.origin - '0 0 24') < -2)
		{
			self.player.noise1 = "player/wstep1.wav";
			self.player.noise2 = "player/wstep2.wav";
		}
		else
		{
			self.player.noise1 = "player/step1.wav";
			self.player.noise2 = "player/step2.wav";
		}
	}
	if (self.impulse > 0)
		self.impulse = 0;
};

void() DecodeLevelParms;
void() PlayerDie;

void() PutClientInServer = 
{
	local entity spawn_spot;

	if(world.map)
	{
		self.health = 100;
		localcmd("v_cshift 0 0 0 0\nmenu_save\n");
		return;
	}
	self.gotstuff = time + 0.1;
	spawn_spot = find_spawn();
	self.classname = "player";
	self.solid = SOLID_NOT;
	self.movetype = MOVETYPE_NOCLIP;
	self.flags = FL_CLIENT;
	setorigin(self, spawn_spot.origin);
	self.testorg = self.origin;
	setmodel (self, "progs/null.spr");
	self.weapon = 0;
	self.owner = self;
	self.weaponframe = 0;
	self.view_ofs = '0 0 0';
	self.velocity = '0 0 0';
	setsize(self, '0 0 0', '0 0 0');
	self.rotang = spawn_spot.angles;
	if (!self.rotang_x)
		self.rotang_x = 60;
	if (!self.rotang_z)
		self.rotang_z = 194;

	if (!self.player)
		self.player = spawn();
	self.player.angles = spawn_spot.angles;
	self.player.owner = self;
	setmodel(self.player, "progs/human.mdl");
	self.player.solid = SOLID_SLIDEBOX;
	self.player.movetype = MOVETYPE_STEP;
	setsize (self.player, VEC_HULL_MIN, VEC_HULL_MAX);
	self.player.classname = "dummy";
	self.player.think = AnimatePlayer;
	self.player.nextthink = time;
	self.player.use = playertrigger;
	self.player.targetname = "player";
	self.player.takedamage = DAMAGE_YES;
	self.takedamage = DAMAGE_YES;
	self.player.noise = "player/swing.wav";
	self.player.noise1 = "player/step1.wav";
	self.player.noise2 = "player/step2.wav";
	self.player.noise3 = "player/axhit1.wav";
	self.player.noise4 = "player/death1.wav";
	self.player.die = PlayerDie;
	self.player.speed = 1;
	self.player.player = self.player;
	setorigin(self.player, spawn_spot.origin + '0 0 1');

	if (mplayer)
		self.player.colormap = self.colormap;
	DecodeLevelParms();
	averagelvl = (averagelvl * (numplayers - 1) + self.lvl) / numplayers;
};