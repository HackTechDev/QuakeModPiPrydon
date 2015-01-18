
void() opendialog = 
{
	if (!self._targ)
		npc_gettopic(self);
		
	if (CheckStory(self))
		return;

	if (self.m_subject && self.m_subject != other.player)
		prompt(other, "This character is busy", self, 0);
	else
		openmenu(other, m_dialog, self);
};
void(entity e) npc_gettopic =
{
	// lame hack
	
	if (e.message == "talk") 
	{
		e._targ = find(world, targetname, e.target);
		while(e._targ)
		{
			if (!CheckStory(e._targ))
				return;
			e._targ = find(e._targ, targetname, e.target);
		}	
		
	}
	else
		e._targ = e;
};
void() npc =
{
	if (!self.model)
		self.model = "progs/human.mdl";
	if (!self.noise)
		self.noise = "player/swing.wav";

	if (self.spawnflags & 1)
		boss = self;
	if (cache)
	{
		precache_model(self.model);
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
	}
	setmodel(self, self.model);
	setsize(self, VEC_HULL_MIN, VEC_HULL_MAX);

	if (!self.netname)
		self.netname = "**NPC**";
	if (!self.ai)
		self.ai = 1;
	if (CheckStory(self) || (self.worldtype && (self.worldtype != lastmap)) )
	{
		
		// revert the music to ambient sound if we're leaving
		if (boss == self)
		{
			if (world.noise2)
			{
			       	ambientsound ('-4095 -4095 -4095', world.noise2, 1.00, ATTN_NONE);
       				ambientsound ('4095 4095 4095', world.noise2, 1.00, ATTN_NONE);
       			}
       			boss = world;
       		}
		remove(self);
		return;
	}
	self.owner = self;
	self.player = self;
	if (!self.max_health)
		self.max_health = 5;
	GenStat(1);
	self.health = self.max_health;
	if (netplay)
		self.ai = self.ai - (self.ai & 1); // no wandering in netplay
	self.spec = self.spec | REGEN_MANA; // always!
			
	self.movetype	= MOVETYPE_STEP;
	self.solid	= SOLID_SLIDEBOX;
	self.takedamage	= DAMAGE_AIM;
	self.oldorigin	= self.origin;
	AnimatePlayer();
	if (self.message)
	{
		// lame hack
		npc_gettopic(self);
		self.action = opendialog;
	}

	if (!self.speed)
		self.speed = 1;
	self.die = PlayerDie;
	self.use = playertrigger;
	self.mana = self.max_mana;
	if (!self.gotstuff)
		self.gotstuff = SP_FIGHT_MELEE;
};

