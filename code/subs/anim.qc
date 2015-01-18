/*

frame stand1
0

walk
1,2,3,4,5,6

run
7,8,9,10,11,12

death
13,14,15,16,17,18

attack
19,20,21,22,23,24,25

pose
26,27,28,29,30,31

cast
32,33,34,35,36,37,38,39

jump
40,41,42,43,44,45

bowshot
46,47,48,49,50,51,52

throw
53,54,55,56
*/

.vector move, death, attack, pain, misc;

void() AnimatePlayer;
void() vwep_think =
{
	//if (self.owner.health <= 0)
	//	remove(self);
	setorigin(self, self.owner.origin);
	self.nextthink = time + 0.1;
};

void() updatevwep =
{
	if (!self.modelindex)
	{
		if (self.wayp)
		{
			remove(self.wayp);
			self.wayp = world;
		}
		if (self.camera)
		{
			remove(self.camera);
			self.camera = world;
		}
		if (self.spellprop)
		{
			remove(self.spellprop);
			self.spellprop = world;
		}
	}
	else
	{
		if (self.owner.rightarm)
		{
			if (!self.wayp)
			{
				self.wayp = spawn();
				self.wayp.owner = self;
			}
			
			setmodel(self.wayp, itemmodel(self.owner.rightarm));
			setorigin(self.wayp, self.origin);
			self.wayp.frame = self.frame + 2;
			self.wayp.angles = self.angles;
	
			
		}
		else
		{
			if (self.wayp)
			{
				remove(self.wayp);
				self.wayp = world;
			}
		}
		if (self.owner.leftarm)
		{
			if (!self.camera)
			{
				self.camera = spawn();
				self.camera.owner = self;
			}
			setmodel(self.camera, itemmodel(self.owner.leftarm));
			setorigin(self.camera, self.origin);
			self.camera.frame = self.frame + 2;
			self.camera.angles = self.angles;
		
		}
		else
		{
			if (self.camera)
			{
				remove(self.camera);
				self.camera = world;
			}
		}
		if (self.owner.shield_time > time)
		{
			if (!self.spellprop)
				self.spellprop = spawn();
			setmodel(self.spellprop, "progs/mshield.mdl");
			setorigin(self.spellprop, self.origin);
			self.spellprop.alpha = 0.2;
		}
		else
		{
			if (self.spellprop)
			{
				remove(self.spellprop);
					self.spellprop = world;
			}
		}
	}
	if (self.regen_time < time)
	{
		self.regen_time = time + 1;
		if (self.owner.spec & REGEN_LIFE)
		{
			self.owner.health = self.owner.health + 1;
			boundstats(self.owner);
		}
		if (self.owner.spec & REGEN_MANA)
		{
			self.owner.mana = self.owner.mana + 1;
			boundstats(self.owner);
		}
	}
};

void() face = 
{
	updatevwep();
	if (self.enemy && (self.enemy.owner.health > 0))
		self.angles_y = vectoyaw(self.enemy.origin - self.origin);
	if (self.owner.spec & SPEED)
		self.nextthink = (self.nextthink - time) * 0.5 + time;
	if (self.slow_time > time)
	{
		self.nextthink = (self.nextthink - time) * (1/self.slow_factor) + time;
		if (self.nextthink >  self.slow_time)
			self.nextthink = self.slow_time;
	}
	else
	{
		if (self.slow_factor != 1)
		{
			self.slow_factor = 1;
			self.pausetime = time;
		}
	}
};
void() cast1 = [32, cast2] {face();};
void() cast2 = [33, cast3] {face();};
void() cast3 = [34, cast4] {face();};
void() cast4 = [35, cast5] {face();spell_fire(self.gotstuff);create_fx(1, self.gotstuff);};
void() cast5 = [36, cast6] {face();create_fx(2, self.gotstuff);};
void() cast6 = [37, cast7] {face();create_fx(3, self.gotstuff);};
void() cast7 = [38, cast8] {face();create_fx(4, self.gotstuff);};
void() cast8 = [39, AnimatePlayer] {face();create_fx(5, self.gotstuff);};

void() attack1 = [19, attack2] {face();self.dbltime = 1;};
void() attack2 = [20, attack3] 
{
	face();
	if (self.noise)
		sound(self, CHAN_VOICE, self.noise, 1, ATTN_NORM);
};
void() attack3 = [21, attack4] {face();};
void() attack4 = [22, attack5] {face();};
void() attack5 = [23, attack6]
{
	if(Hit(self, self.enemy))
		sound(self, CHAN_WEAPON, "player/hit.wav", 1, ATTN_NORM);
	face();

};
void() attack6 = [24, attack7] {face();};
void() attack7 = [25, AnimatePlayer] {face();};

void() death1 = [13, death2] {};
void() death2 = [14, death3] {};
void() death3 = [15, death4] {};
void() death4 = [16, death5] {};
void() death5 = [17, death6] {};
void() death6 = [18, SUB_Remove] {self.nextthink = time + 10;};

void() PlayerDie =
{
	dropallitems();
	if (self.classname == "helper")
	{
		self.sbarsub.summon_count = self.sbarsub.summon_count - 1;
	}
	self.health = 0;
	self.flags = 0;
	self.deadflag = 1;
	self.owner.health = 0;
	self.owner.player = world;
	self.player = self;
	self.takedamage = DAMAGE_NO;
	self.solid = SOLID_NOT;
	self.effects = 0;
	self.movetype = MOVETYPE_TOSS;
	death1();
	if (self.camera)
	{
		remove(self.camera);
		self.camera = world;
	}
	if (self.wayp)
	{
		remove(self.wayp);
		self.wayp = world;
	}
	if (self.spellprop)
	{
		remove(self.spellprop);
		self.spellprop = world;
	}
	
	if (self.noise4)
		sound(self, CHAN_VOICE, self.noise4, 1, ATTN_NORM);
	if (self.owner.classname == "player")
		openmenu(self.owner, m_dead, self.owner);
	if (self.spawnflags & 1)
	{
		boss = world;
		if (!nomusic)
			if (world.noise2)
				sound(world, CHAN_VOICE, world.noise2, 1, ATTN_NONE);
	}
	if (self.target)
	{
		other = self.enemy;
		generictrigger();
	}
	self.owner = self;	
};

void() bowattack1 = [46, bowattack2] {face();};
void() bowattack2 = [47, bowattack3] {face();};
void() bowattack3 = [48, bowattack4] {face();firearrow();};
void() bowattack4 = [49, bowattack5] {face();};
void() bowattack5 = [50, bowattack6] {face();};
void() bowattack6 = [51, bowattack7] {face();};
void() bowattack7 = [52, AnimatePlayer] {face();};

void() throw1 = [53, throw2] {face();};
void() throw2 = [54, throw3] {face();};
void() throw3 = [55, throw4] {face();};
void() throw4 = [56, AnimatePlayer] {throwit(self.owner.rightarm);face();}; 

float(float yaw, float run) moveit =
{
	local float runspeed;
	local float m;
	if (run)
		runspeed = (250 + sqrt(self.owner.agil) * 3) * frametime;
	else
		runspeed = 150 * frametime;
	runspeed = runspeed * self.speed * self.slow_factor;

	if (self.pausetime < time)
	{
		if (run)
			CycleFrames(7,12);
		else
			CycleFrames(1,6);
		if (self.noise1)
		{
			if (self.frame == 1)
				sound(self, CHAN_BODY, self.noise1, 1, ATTN_NORM);
			if (self.frame == 8)
				sound(self, CHAN_BODY, self.noise1, 1, ATTN_NORM);
			if (self.frame == 4)
				sound(self, CHAN_BODY, self.noise2, 1, ATTN_NORM);
			if (self.frame == 11)
				sound(self, CHAN_BODY, self.noise2, 1, ATTN_NORM);
		}
		self.pausetime = time + 0.1 * (1/self.slow_factor);

	}
	if (self.ai && self.goalentity != world)
	{
		self.yaw_speed = 20 * self.slow_factor * self.speed;	
		movetogoal(runspeed);
		return TRUE;
	}

		
	makevectors(self.angles);

	if (walkmove(yaw, runspeed))
	{
		self.angles_y = yaw;
		self.obs_angle = 0;
		return TRUE;
	}
	else if (self.obs_angle)
	{
		if (walkmove(self.obs_angle, runspeed))
		{
			self.angles_y = self.obs_angle;
			return TRUE;
		}
	}
	m = 0;
	while(m < 360)
	{
		if (!walkmove(yaw + m, runspeed))
		{
			if (!walkmove(yaw - m, runspeed))
			{
				m = m + 1;
			}
			else
			{
				m = 360 - m;
				break;
			}
		}
		else
			break;
	}
	self.obs_angle = yaw + m;
	self.angles_y = yaw + m;
	
	return TRUE;
};

void() AnimatePlayer =
{
	local float len;
	local vector org, old;
	local entity e, t;

	self.think = AnimatePlayer;
	self.nextthink = time;
	if (pointcontents(self.origin) == CONTENT_LAVA)
		PlayerDie();
	if (!self.flags & FL_ONGROUND)
		self.fallz = self.velocity_z;
	else if (self.fallz)
	{
		if (self.fallz < -500)
			PlayerDie();
		self.fallz = 0;
	}
	if (self.classname == "dummy" || self.classname == "helper")
	{
		t = find(world, classname, "helper");
		while(t)
		{
			t.solid = SOLID_TRIGGER;
			setorigin(t, t.origin);
			t = find(t, classname, "helper");
		}
	}
	if (self.slow_time < time)
	{
		if (self.slow_factor != 1)
		{
			self.slow_factor = 1;
			self.pausetime = time;
		}
	}

	if (self.goalentity)
	{
		e = self.goalentity;
		org = e.origin;
		if (org == '0 0 0')
		{
			org = (e.absmin + e.absmax) * 0.5;
			org_z = self.origin_z;
		}
		old = self.origin;
		org_z = (old_z + org_z * 3) * 0.25;
		if (self.goalentity.deadflag)
		{
			self.enemy = world;
			self.goalentity = world;
			self.frame = 0;
			return;
		}
		len = vlen(org - old);
		if (self.ai & 8)
		{
			if (self.goalentity != self.sbarsub)
			{
				if (vlen(self.sbarsub.origin - self.origin) > 256)
				{
					if (self.gotstuff != SP_FOLLOW)
						self.style = self.gotstuff;
					self.gotstuff = SP_FOLLOW;
					self.goalentity = self.sbarsub;
				}
			}
		}
		
		if (self.gotstuff == SP_FOLLOW)
		{

			if (len < 60)
			{
				self.goalentity = world;
				moveit(vectoyaw(self.origin - org), self.menu);
				self.goalentity = e;
			}
			else if (len < 80)
			{
				self.goalentity = world;
				self.menu = 0;
			}
			else
			{
				if (len > 256)
					self.menu = 1;
				if(!moveit(vectoyaw(org - self.origin), self.menu))
				{
					self.menu = 0;
					self.goalentity = world;
				}
				else
					self.dbltime = 0;
			}
		}
		else if (len < spell_range(self.gotstuff) && (visible(self.goalentity) || len < 60) )
		{
			spell_cast(self.goalentity, self.gotstuff);
			self.goalentity = world;
			self.menu = 0;
		}
		else
		{
			if(!moveit(vectoyaw(org - self.origin), self.menu))
			{
				self.menu = 0;
				self.goalentity = world;
			}
			else
				self.dbltime = 0;
		}

	}
	else if (self.m_subject)
	{
		self.frame = 0;
		self.angles_y = vectoyaw(self.m_subject.origin - self.origin);
	}
	else if (self.ai)
	{
		if (self.ai & 1)
		{
			if (self.attack_finished > time)
			{
				if (self.menu < time)
				{
					// look around
					self.angles_y = random() * 360;
					self.menu = time + 2 * random();
				}
				self.frame = 0;
			}
			else if(!moveit(self.angles_y, 0))
			{
				self.attack_finished = time + random() * 3;
				self.menu = 0;
			}
			else if (self.menu < time)
			{
				self.menu = 0;
				self.attack_finished = time + random() * 5;
			}
		}
		if (self.ai & 2)
		{
			if (!self.enemy)
			{
				e = find(world, classname, "dummy");
				while(e)
				{
					if (e.owner.health >= 1)
					if (vlen(e.origin - self.origin) < 256)
					{
						self.enemy = e;
						break;
					}
					e = find(e, classname, "dummy");
				}
				if (self.spawnflags & 1)
					if (!nomusic)
						if (self.enemy)
							if (world.noise2)
								sound(world, CHAN_VOICE, "music/boss.wav", 1, ATTN_NONE);
				self.goalentity = self.enemy;
			}
			else if (self.enemy.owner.health < 1)
				self.enemy = world;
			else
				self.goalentity = self.enemy; // go at 'im again
			if (self.enemy)
			if (self.spell)
			{
				if (self.owner.mana < mana_for_spell(self.gotstuff, GetSpellLevel(self.owner, self.gotstuff)))
				{
					len = self.gotstuff;
					self.gotstuff = self.spell;
					self.spell = len;
				}
				else if (cast_aground(self.gotstuff))
				{
					len = self.gotstuff;
					self.gotstuff = self.spell;
					self.spell = len;
				}
				else if (random() < 0.2)
				{
					len = self.gotstuff;
					self.gotstuff = self.spell;
					self.spell = len;
				}
			}
					
		}
		if (self.ai & 4)
		{
			if (self.gotstuff == SP_FOLLOW)
				self.gotstuff = self.style;
			if (self.enemy.health < 1)
			{
				self.frame = 0;
				self.enemy = world;
			}
			if (!self.enemy)
			{
				e = find(world, classname, "monster");
				while(e)
				{
					if (e.health >= 1 && e.team != self.team)
					if (vlen(e.origin - self.origin) < 256)
					{
						self.enemy = e;
						break;
					}
					e = find(e, classname, "monster");
				}
				self.goalentity = self.enemy;
			}
			else 
				self.goalentity = self.enemy; // go at 'im again
			if (self.spell)
			{
				if (self.owner.mana < mana_for_spell(self.gotstuff, GetSpellLevel(self.owner, self.gotstuff)))
				{
					len = self.gotstuff;
					self.gotstuff = self.spell;
					self.spell = len;
				}
				else if (cast_aground(self.gotstuff))
				{
					len = self.gotstuff;
					self.gotstuff = self.spell;
					self.spell = len;
				}
				else if (random() < 0.2)
				{
					len = self.gotstuff;
					self.gotstuff = self.spell;
					self.spell = len;
				}
			}
		}
		if (self.ai & 8)
		{
			if (!self.goalentity)
			{
				self.enemy = world;
				
				if (!self.sbarsub || self.sbarsub.health <= 0)
				{
					e = find(world, classname, "dummy");
					if (e)
					{
						if (self.gotstuff != SP_FOLLOW)
							self.style = self.gotstuff;
						self.gotstuff = SP_FOLLOW;
						self.goalentity = e;
						self.sbarsub = e;
					}
				}
				else
				{
					if (self.gotstuff != SP_FOLLOW)
						self.style = self.gotstuff;
					self.gotstuff = SP_FOLLOW;
					self.goalentity = self.sbarsub;
				}
			}
		}		
	}
	else if (self.dbltime)
	{
		if (self.pausetime < time)
		{
			CycleFrames(26, 31);
			self.pausetime = time + 0.1 * (1/self.slow_factor);
		}
	}
	else if (self.classname != "dummy")
	{
		// to lessen the load, standing monsters have have less frequent thinks
		// until they aren't standing :)
		self.nextthink = time + 0.5 + random();
		self.frame = 0;
	}
	else
		self.frame = 0;
	
	updatevwep();
	
	if (self.classname == "dummy" || self.classname == "helper")
	{
		t = find(world, classname, "helper");
		while(t)
		{
			t.solid = SOLID_BBOX;
			setorigin(t, t.origin);
			t = find(t, classname, "helper");
		}
	}
};