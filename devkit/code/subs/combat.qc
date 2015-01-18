

void(entity attacker, entity targ, float dam, float magdam) T_Damage =
{
	local entity oself;
	local float r;
	oself = self;
	if (!targ.takedamage)
		return;
	targ = targ.owner;
	attacker = attacker.owner;
	r = 0;
	if (!magdam)
		r = targ.ac * 0.1;
	if (targ.shield_time > time)
		r = targ.ac * targ.shield_factor;

	if (!magdam)
	{
		if (random() < dam/r)
			DamageEquipment(targ, 0);
		if (attacker)
			if (random() < dam/r)
				DamageEquipment(attacker, 1);
	}
	dam = dam - r;
	
	if (dam < 1)
		dam = 1;
	targ.health = targ.health - dam;

	if (!magdam)
	{
		if (attacker.spec & STEAL_LIFE)
			attacker.health = attacker.health + dam / 2;
		if (targ.spec & DAMATTACKER)
			T_Damage(targ, attacker, dam / 2, 1);
		if (attacker.spec & STEAL_MANA)
			attacker.mana = attacker.mana + dam / 3;
		if (attacker.spec & KNOCKBACK)
		{
			targ.player.flags = targ.flags - (targ.flags & FL_ONGROUND);
			targ.player.velocity = targ.velocity + normalize(targ.player.origin - attacker.player.origin) * 300;
			targ.player.velocity_z = 212;
		}
	}
	if (attacker)
		boundstats(attacker);
	if (targ.health < 1)
	{
		self = targ;
		if (self.flags & FL_CLIENT)
			bprint(self.netname, " was killed by ", attacker.netname, "\n");
		self = self.player;
		if (self.die)
			self.die();
		if (attacker)
			GiveExp(attacker, targ);
	}
	else
	{
		targ = targ.player;
		if (targ.noise3)
			if (random() < 0.5)
				sound(targ, CHAN_VOICE, targ.noise3, 1, ATTN_NORM);
	}
	self = oself;
	
};

void() fire1 = [0, fire2] {setorigin(self, self.enemy.origin);};
void() fire2 = [1, fire3] {setorigin(self, self.enemy.origin);};
void() fire3 = [2, fire4] {setorigin(self, self.enemy.origin);};
void() fire4 = [3, fire5] {setorigin(self, self.enemy.origin);};
void() fire5 = [4, fire6] {setorigin(self, self.enemy.origin);};
void() fire6 = [5, fire7] {setorigin(self, self.enemy.origin);};
void() fire7 = [6, SUB_Remove] {};

void(entity attacker, entity targ, float dam) FireDamage = 
{
	local entity e;
	local float f;
	targ = targ.player;		
	e = spawn();
	setmodel(e, "progs/fire.spr");
	e.solid = SOLID_NOT;
	e.enemy = targ;
	e.think = fire1;
	e.nextthink = time;
	e.movetype = MOVETYPE_NONE;
	e.effects = EF_DIMLIGHT;
	
	f = (dam / 2) * random() + (dam / 2);
	sound(targ, CHAN_AUTO, "spells/fhit.wav", 1, ATTN_NORM);
	T_Damage(attacker, targ, f, 1);
};

void() poisonfollow =
{
	local float f;
	
	self.poidam = self.poidam - 2;
	if (self.poidam < 0)
		f = 0 - self.poidam;
	else
		f = 2;
	T_Damage(self.owner, self.enemy, f, 1);
	particle(self.enemy.origin, '0 0 0', 182, 5);
	if (self.poidam <= 0)
		remove(self);
	else
		self.nextthink = time + 0.25;
};
void(entity attacker, entity targ, float dam) PoisonDamage = 
{
	local entity e;
	targ = targ.player;
	e = spawn();
	e.solid = SOLID_NOT;
	e.enemy = targ;
	e.owner = attacker;
	e.think = poisonfollow;
	e.nextthink = time;
	e.movetype = MOVETYPE_NONE;
	e.poidam = dam;
	sound(e, CHAN_AUTO, "wizard/hit.wav", 1, ATTN_NORM);
	
};

void(entity attacker, entity targ, float dam) LightningDamage = 
{
	local float f;
	local vector v, o;
	targ = targ.player;
	targ.effects = targ.effects | EF_MUZZLEFLASH;
	WriteByte(MSG_BROADCAST, SVC_TEMPENTITY);
	WriteByte(MSG_BROADCAST, TE_LIGHTNING2);
	WriteEntity(MSG_BROADCAST, targ);
	v = targ.maxs - targ.mins;
	o = targ.origin + targ.mins;
	WriteCoord(MSG_BROADCAST, o_x + (v_x * random()) );
	WriteCoord(MSG_BROADCAST, o_y + (v_y * random()) );
	WriteCoord(MSG_BROADCAST, o_z + v_z);
	WriteCoord(MSG_BROADCAST, o_x + (v_x * random()) );
	WriteCoord(MSG_BROADCAST, o_y + (v_y * random()) );
	WriteCoord(MSG_BROADCAST, o_z);
	f = ceil(random() * dam);
	if (!f)
		f = 1;
	sound(targ, CHAN_AUTO, "spells/lhit.wav", 1, ATTN_NORM);
	T_Damage(attacker, targ, f, 1);
};

float(entity attacker, entity targ) MagicHit = // projectiles (TODO: something)
{
	if (targ.team == attacker.team)
		return FALSE;
	if (!targ.takedamage)
		return FALSE;
	if (targ.ai)
	{
		targ.enemy = attacker;
		targ.goalentity = world;
	}
	targ = targ.owner;
	attacker = attacker.owner;

	if (self.fire)
		FireDamage(attacker, targ, self.fire);
	if (self.lit)
		LightningDamage(attacker, targ, self.lit);
	if (self.poidam)
		PoisonDamage(attacker, targ, self.poidam);
		
	return TRUE;	
};
float(entity attacker, entity targ) Hit =
{
	float a, b;
	entity realtarg;
	
	realtarg = targ;
	
	if (targ.team == attacker.team)
		return FALSE;
	if (!targ.takedamage)
		return FALSE;
	if (targ.ai)
	{
		targ.enemy = attacker;
		targ.goalentity = world;
	}
	targ = targ.owner;
	attacker = attacker.owner;
	
	a = attacker.tohit;
	b = targ.dodge;
	if (a < 1)
	{
		b = b + (1 - a);
		a = 1;
	}
	else if (b < 1)
	{
		a = a + (1 -  b);
		b = 1;
	}

	if ((a / b) * 0.3 < random())
			return FALSE;

	T_Damage(attacker, targ, attacker.daml + random() * attacker.dama, 0);
	if (attacker.fire)
		FireDamage(attacker, targ, attacker.fire);
	if (attacker.lit)
		LightningDamage(attacker, targ, attacker.lit);
	if (attacker.poidam)
		PoisonDamage(attacker, targ, attacker.poidam);
	return TRUE;	
};


void() fix_velocity = { self.velocity = self.dest1; self.think = SUB_Remove; self.nextthink = time + 5; };
void() arrow_touch =
{
	if (other == self.owner)
		return;
	if (Hit(self.enemy, other))
	{
		sound(self, CHAN_AUTO, "player/arrowhit.wav", 1, ATTN_NORM);
		remove(self);
	}
	else if (other == world)
	{
		remove(self);
	}
	else
	{
		self.owner = other;
		self.velocity = self.dest1;
		self.think = fix_velocity;
		self.nextthink = time;
	}
};
void() firearrow =
{
	local entity e;
	if (self.classname == "dummy")
	{
		if (!takeammo(IT_ARROWS)) // arrows
			return;
	}
	sound(self, CHAN_BODY, "player/arrowuse.wav", 1, ATTN_NORM);
	e = launch_projectile(0, 500, "progs/arrow.mdl");
	e.touch = arrow_touch;
};

void(float it) throwit =
{
	local entity e;
	if (self.classname == "dummy")
	{
		if (!takeammo(it))
			return;
	}
	sound(self, CHAN_BODY, self.noise, 1, ATTN_NORM);
	e = launch_projectile(0, 500, itemmodel(it));
	e.touch = arrow_touch;
};