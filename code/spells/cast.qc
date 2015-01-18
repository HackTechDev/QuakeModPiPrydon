void() ball_hit =
{
	if (other == self.owner)
		return;
	if (MagicHit(self.enemy, other))
	{
		if (self.noise)
			sound(self, CHAN_AUTO, self.noise, 1, ATTN_NORM);
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
void() homing =
{
	local vector v;
	v = normalize(self.goalentity.origin - self.origin);
	self.velocity = normalize(v * 5 + self.velocity) * 120;
	self.angles = vectoangles(self.velocity);
	self.nextthink = time + 0.01;
};

void() evile_5 = [4, SUB_Remove] {};
void() evile_4 = [3, evile_5] {};
void() evile_3 = [2, evile_4] {};
void() evile_2 = [1, evile_3] {};
void() evile_1 = [0, evile_2] {};

void() nova_9 = [8, SUB_Remove] {self.nextthink = time + 0.05;};
void() nova_8 = [7, nova_9] {self.nextthink = time + 0.05;};
void() nova_7 = [6, nova_8] {self.nextthink = time + 0.05;};
void() nova_6 = [5, nova_7] {self.nextthink = time + 0.05;};
void() nova_5 = [4, nova_6] {self.nextthink = time + 0.05;};
void() nova_4 = [3, nova_5] {self.nextthink = time + 0.05;};
void() nova_3 = [2, nova_4] {self.nextthink = time + 0.05;};
void() nova_2 = [1, nova_3] {self.nextthink = time + 0.05;};
void() nova_1 = [0, nova_2] {self.nextthink = time + 0.05;};


void() evile_go =
{
	local entity e;
	local vector v, org;
	
	v_y = random() * 360;
	makevectors(v);
	
	org = self.origin + v_forward * random() * self.summon_count;
	traceline(self.origin, org, TRUE, self);

	e = findradius(trace_endpos, 60);
	while(e)
	{
		if (e.takedamage && e.team != self.team)
			T_Damage(self.owner, e, self.dama, 1);
		e = e.chain;
	}
	e = spawn();
	setmodel(e, "progs/evile.spr");
	setorigin(e, trace_endpos);
	e.think = evile_1;
	e.nextthink = time;
	if (time > self.ltime)
	{
		sound(self, CHAN_VOICE, "misc/null.wav", 1, ATTN_NORM);
		remove(self);
	}
	else
		self.nextthink = time + 0.05;
	
};

void() twister_start = 
{
	local entity e;
	local float i;
	local vector v, r;
	
	if (self.frame < 23)
	{
		self.frame = self.frame + 1;
		self.nextthink = time + 0.05;
	}
	else if (time > self.ac)
	{
		if (self.frame < 48)
		{
			self.frame = self.frame + 1;
			self.nextthink = time + 0.05;
		}
		else
		{
			sound(self, CHAN_WEAPON, "misc/null.wav", 1, ATTN_NORM);
			
			remove(self);
		}
	}
	else
	{
		e = findradius(self.origin, 80);
		while (e)
		{
			if (e.team != self.team && e.takedamage)
			{
				e.flags = e.flags - (e.flags & FL_ONGROUND);
				v = normalize(e.origin - self.origin);
				v_z = 0;
				r_x = v_y;
				r_y = v_x * -1;
				r = r - v * 0.15;
				r = r * vlen(e.origin - self.origin) * 8;
				e.velocity = r + '0 0 31';
				if (random() < 0.3)
					T_Damage(self.owner, e, 1, 1);
			}
			e = e.chain;
		}
		makevectors(self.mangle);
		if (random() < 0.1)
			self.mangle_y = self.mangle_y + random() * 180 - 90;
		self.velocity = v_forward * 100;
		self.flags = self.flags - FL_ONGROUND;
		if (!netplay)
		{

			for (i = 0; i < 9; i = i + 1)
			{
				self.finalangle_y = self.finalangle_y + 10;
				makevectors(self.finalangle);
				particle(self.origin + v_up * (i * 6) + v_forward * (i * 5), v_right * (i * 10) + v_up * 5, 12, 3);
			}
		}		
		self.nextthink = time + 0.01;
	}
	
};
void(float lev) twister_go =
{
	local entity e;
	
	e = spawn();
	setorigin(e, self.enemy.origin - '0 0 20');
	e.frags = lev;
	setmodel(e, "progs/twister.mdl");
	sound(e, CHAN_WEAPON, "spells/twist.wav", 1, ATTN_NORM);
	e.mangle = self.angles;
	e.think = twister_start;
	e.owner = self;
	e.movetype = MOVETYPE_FLY;
	setsize(e, '0 0 0', '0 0 0');
	e.team = self.team;
	e.nextthink = time;
	e.ac = time + 1 + lev * lev * 1.5;
	e.effects = EF_ADDITIVE;
	e.alpha = 0.75;
}

void(float lev) fireball_go =
{
	local entity e;
	local float f, b, ofs, n;

	sound(self, CHAN_WEAPON, "spells/fball.wav", 1, ATTN_NORM);

	if (lev >= 6)
	{
		b = 5;
		ofs = -20;
		n = 10;
	}
	else if (lev > 4)
	{
		b = 3;
		ofs = -15;
		n = 15;
	}
	else
		b = 1;
	f = ceil(lev * lev * 1.1) + 9 / b;
	
	while(b > 0)
	{
		e = launch_projectile(ofs, 90 + lev * 5, "progs/fball.mdl");
		e.effects =  EF_ADDITIVE;
		e.touch = ball_hit;
		e.fire = f;
		e.enemy = self;
		e.owner = self;
		ofs = ofs + n;
		b = b - 1;
	}
};

void(float lev) zap_go =
{
	local entity e, laste;
	
	makevectors(self.angles);
	sound(self, CHAN_WEAPON, "spells/lit.wav", 1, ATTN_NORM);
	WriteByte(MSG_BROADCAST, SVC_TEMPENTITY);
	WriteByte(MSG_BROADCAST, TE_LIGHTNING1);
	WriteEntity(MSG_BROADCAST, self);
	WriteCoord(MSG_BROADCAST, self.origin_x + v_forward_x * 8);
	WriteCoord(MSG_BROADCAST, self.origin_y + v_forward_y * 8);
	WriteCoord(MSG_BROADCAST, self.origin_z + 16);
	WriteCoord(MSG_BROADCAST, self.enemy.origin_x);
	WriteCoord(MSG_BROADCAST, self.enemy.origin_y);
	WriteCoord(MSG_BROADCAST, self.enemy.origin_z);
	LightningDamage(self, self.enemy, 15 + ceil(lev * lev * 1.4));	
	lev = lev - 3;
	laste = self.enemy;
	
	while (lev > 0)
	{
		e = findradius(laste.origin, 80);
		while (e)
		{
		
			if (e.takedamage && e.team != self.team && e != laste)
			{
				WriteByte(MSG_BROADCAST, SVC_TEMPENTITY);
				WriteByte(MSG_BROADCAST, TE_LIGHTNING1);
				WriteEntity(MSG_BROADCAST, laste);
				WriteCoord(MSG_BROADCAST, laste.origin_x);
				WriteCoord(MSG_BROADCAST, laste.origin_y);
				WriteCoord(MSG_BROADCAST, laste.origin_z);
				WriteCoord(MSG_BROADCAST, e.origin_x);
				WriteCoord(MSG_BROADCAST, e.origin_y);
				WriteCoord(MSG_BROADCAST, e.origin_z);
				LightningDamage(self, e, 15 + ceil(lev * lev * 1.4));
			}
			e = e.chain;
		}
		lev = lev - 2;	
	}
}

void() meteor_hit =
{
	local entity e;
	local float n;
	n = 28.57 * self.frags;
	
	e = findradius(self.origin, n);
	while(e)
	{
		if (e.team != self.team && e.takedamage)
		{
			self.fire = n - vlen(e.origin - self.origin) * 0.9;
			MagicHit(self, e);
		}
		e = e.chain;
	}
	WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
	WriteByte (MSG_BROADCAST, TE_EXPLOSION);
	WriteCoord (MSG_BROADCAST, self.origin_x);
	WriteCoord (MSG_BROADCAST, self.origin_y);
	WriteCoord (MSG_BROADCAST, self.origin_z);
	remove(self);
}

void() meteor_go =
{
	setmodel(self, "progs/meteor.mdl");
	self.avelocity = (random() *  '3000 0 0' + random() * '0 3000 0' + random() * '0 0 3000') - '1500 1500 1500';
	setsize(self, '0 0 0', '0 0 0');
	self.velocity = self.finalangle;
	self.movetype = MOVETYPE_FLY;
	self.solid = SOLID_BBOX;
	self.touch = meteor_hit;
	self.think = meteor_hit;
	self.nextthink = self.ac;
	self.enemy = self.owner;
}

void(float sp) spell_fire =
{
	local entity e, m;
	local float lev, man;
	float runaway;
	local vector v;
	
	lev = GetSpellLevel(self.owner, sp);

	if (!cast_aground(sp))
		if (!self.enemy)
			return;
	man = mana_for_spell(sp, lev);
	if (sp & 32)
	{
		if (!takeammo(IT_SCROLL))
			return;
		lev = 7;
		man = 0;
		sp = sp & 31;
	}
 	else if (self.owner.mana < man)
 	{
 		if (self.owner.classname == "player")
			sprint(self.owner, "not enough mana\n");
		return;
	}
	self.owner.mana = self.owner.mana - man;

		
	if (sp == SP_FIREBALL)
		fireball_go(lev);
	else if (sp == SP_ZAP)
		zap_go(lev);
	else if (sp == SP_SLOW)
	{
		self.enemy.slow_time = time + lev * 5 + 5;
		self.enemy.slow_factor = self.enemy.slow_factor / 8;
		sound(self.enemy, CHAN_AUTO, "spells/slow.wav", 1, ATTN_NORM);
	}
	else if (sp == SP_WARP)
	{
		e = find_spawn();
		setorigin(self, e.origin);
		sound(e, CHAN_WEAPON, "spells/warp.wav", 1, ATTN_NORM);
	}
	else if (sp == SP_POISONBALL)
	{
		e = launch_projectile(0, 120, "progs/w_spike.mdl");
		e.touch = ball_hit;
		e.poidam = ceil(lev * lev * 1.5) + 20;
		e.think = homing;
		e.goalentity = self.enemy;
		e.enemy = self;
		e.owner = self;
		e.nextthink = time;
		sound(self, CHAN_WEAPON, "spells/pfire.wav", 1, ATTN_NORM);
	}
	else if (sp == SP_LEECH)
	{
		T_Damage(self, self.enemy, lev * 3 + 5, 1);
		sound(self, CHAN_WEAPON, "spells/leech.wav", 1, ATTN_NORM);
		
		e = self;
		if (e.owner)
			e = e.owner;
		e.health = e.health + lev * lev + 2;
		boundstats(e);
	}
	else if (sp == SP_HEAL)
	{
	
		if ((self.enemy.owner.health < self.enemy.owner.max_health) && (self.enemy.team == self.team))
		{
			e = self.enemy;
			if (e.owner)
				e = e.owner;
			runaway = (lev + 4) / 2;
			e.health = e.health + ceil(runaway * runaway) + 5;
			sound(self, CHAN_WEAPON, "spells/heal.wav", 1, ATTN_NORM);
			boundstats(e);
		}
		else
		{
			e = self;
			if (e.owner)
				e = e.owner;
			runaway = (lev + 4) / 2;
			e.health = e.health + ceil(runaway * runaway) + 5;
			sound(self, CHAN_WEAPON, "spells/heal.wav", 1, ATTN_NORM);
			boundstats(e);
		}
	}
	else if (sp == SP_SHIELD)
	{
		if (self.owner)
		{
			self.owner.shield_time = time + 10 + lev * 5;
			self.owner.shield_factor = (lev + 1) * 0.25;
			sound(self, CHAN_WEAPON, "spells/shield.wav", 1, ATTN_NORM);
			
		}
	}

	else if (sp == SP_TRANSMUTE)
	{
		itemstat(self.enemy.items);
		if (!(self.enemy.menu))
		if (stat_it < IT_GOLD)
		{
			sound(self.enemy, CHAN_AUTO, "spells/tranmute.wav", 1, ATTN_NORM);
			
			stat_it = IT_GOLD;
			stat_dur = ceil(stat_price * lev/10);
			if (stat_dur > 10000)
				stat_dur = 10000;
			self.enemy.items = setstat();
			call(item, self.enemy);
		}
	}
	else if (sp == SP_REPEL)
	{
		sound(self, CHAN_AUTO, "spells/repel.wav", 1, ATTN_NORM);
		
		e = findradius(self.origin, (5 + lev * lev * 0.2) * 10);
		while (e)
		{
		
			if (e.team != self.team)
			{
				if (e.takedamage)
				{
					e.flags = e.flags - (e.flags & FL_ONGROUND);
					e.velocity = e.velocity + normalize(e.origin - self.origin) * (200 + (lev * 30));
					e.velocity_z = 212;
					if (lev > 1)
					{
						e.slow_factor = 0.001;
						e.slow_time = time + lev * lev * 0.1;
						if (lev > 5)
							T_Damage(self, e, lev * 2, 0);
					}
				}
			}
			e = e.chain;
		}
	}
	else if (sp == SP_NOVA)
	{
		sound(self, CHAN_AUTO, "spells/nova.wav", 1, ATTN_NORM);
		m = spawn();
		setmodel(m, "progs/nova.mdl");
		setorigin(m, self.origin + '0 0 -20');
		m.think = nova_1;
		m.nextthink = time;
		e = findradius(self.origin, 128);
		while (e)
		{
			if (e.team != self.team)
				if (e.takedamage)
					LightningDamage(self, e,  10 + ceil(lev * lev * 1.8));
			e = e.chain;
		}			

	}
	else if (sp == SP_TELEPORT)
	{
		if (self.enemy == world)
			self.enemy = self.owner.wayp;
		e = find_spot();
		setorigin(self, e.origin);
		sound(self, CHAN_AUTO, "spells/warp.wav", 1, ATTN_NORM);
		remove(e);
	}
	else if (sp == SP_TWISTER)
		twister_go(lev);
	else if (sp == SP_SUMMON)
	{
		e = find_spot();
		//monster_scarite();
		if (lev < 3)
			call(monster_scarite, e);
		else if (lev < 5)
			call(monster_guanite,e);
		else if (lev < 7)
			call(monster_drak, e);
		else
			call(monster_horror, e);
			
		if (!self.team)
		{
			e.goalentity = world;
			e.enemy = world;
			e.classname = "helper";
			e.ai = 12;
			e.speed = 0.8;
			e.team = self.team;
			e.sbarsub = self; // bleh
			e.summon_count = self.summon_count;
			self.summon_count = self.summon_count + 1;
			if (self.summon_count > lev)
			{
				m = find(world, classname, "helper");
				while(m)
				{
					if (m.sbarsub == self)
					{
						if (m.summon_count == 0)
						{
							call(PlayerDie, m);
							break;	
						}
						else
							m.summon_count = m.summon_count - 1;
					}
					m = find(m, classname, "helper");
				}
			}				
				
		}
		e.droprandom = 0;
		WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
		WriteByte (MSG_BROADCAST, TE_TELEPORT);
		WriteCoord (MSG_BROADCAST, e.origin_x);
		WriteCoord (MSG_BROADCAST, e.origin_y);
		WriteCoord (MSG_BROADCAST, e.origin_z);
		sound(e, CHAN_WEAPON, "spells/warp.wav", 1, ATTN_NORM);
	}
	else if (sp == SP_METEOR)
	{
		v = '-80 0 0';
		v_y = random()* 360;
		makevectors(v);
		traceline(self.enemy.origin, self.enemy.origin + v_forward * 5000, TRUE, self);
		runaway = 5 - (vlen(self.enemy.origin - trace_endpos) / 1000);
		e = spawn();
		setorigin(e, trace_endpos);
		e.think = meteor_go;
		e.nextthink = time + runaway;
		e.finalangle = v_forward * -1000;
		e.ac = time + 5;
		e.owner = self;
		e.frags = lev;
		e.team = self.team;
		sound(e, CHAN_WEAPON, "spells/meteor1.wav", 1, ATTN_NORM);
		
	}
	else if (sp == SP_EVILE)
	{
		e = spawn();
		setorigin(e, self.enemy.origin);
		e.dama = ceil(lev * lev * 0.1) + 2;
		e.summon_count = (5 + lev * lev * 0.2) * 10;
		e.think = evile_go;
		e.nextthink = time;
		e.team = self.team;
		e.owner = self;
		e.ltime = time + 3;
		sound(e, CHAN_VOICE, "spells/evile.wav", 1, ATTN_NORM);

	}
	else if (sp == SP_HEALOTHER)
	{
		e = findradius(self.origin, 386);
		while(e)
		{
			m = e;

				
			if (e.team == self.team)
			{
				if (e.owner)
					e = e.owner;
				if (e.health >= 1)
				{
					if (e.health < e.max_health)
					{
						sound(self, CHAN_WEAPON, "spells/heal.wav", 1, ATTN_NORM);
						runaway = (lev + 4) / 2;
						e.health = e.health + ceil(runaway * runaway) + 5;
						self.m_subject = e;
						boundstats(e);
						break;
					}
				}
			}
			e = m.chain;
		}
	}
	else if (sp == SP_AWAKEMONSTERS)
	{
		e = findradius(self.origin, (5 + lev * lev * 0.2) * 10);
		while (e)
		{
		
			if (e.team != self.team)
			{
				if (e.takedamage && e.ai)
				{
					e.enemy = self;
					e.goalentity = world;
				}
			}
			e = e.chain;
		}
	}
};
void(entity towhom, float m) spell_cast =
{
	local entity e;
	self.enemy = towhom;
	e = self;
	if (m == SP_GOTO)
		return;
	else if (m == SP_FOLLOW)
		return;
	else if (m == SP_AWAKEMONSTERS)
	{
		self.frame = 0;
		spell_fire(m);
		return;
	}
	else if (m == SP_ACTIVATE)
	{
		other = self;
		self = towhom;
		if (self.action)
			self.action();
		self = e;
	}
	else if (m == SP_FIGHT_MELEE)
		attack1();
	else if (m == SP_FIGHT_BOW)
		bowattack1();
	else if (m == SP_THROW)
		throw1();
	else if (m & 32) // scrolls are always usable
		cast1();
	else if (self.owner.mana < mana_for_spell(m, GetSpellLevel(self.owner, m)))
	{
		if (self.owner.classname == "player")
			sprint(self.owner, "not enough mana\n");
	}
	else
		cast1();

};
