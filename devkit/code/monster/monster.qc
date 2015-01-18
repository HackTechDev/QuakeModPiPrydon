void() monster =
{
	if (!self.lvl)
		self.lvl = 1;
	if (!self.ai)
		self.ai = 2;
	if (!self.team)
		self.team = 1;
	self.classname = "monster";
	self.flags = self.flags | FL_MONSTER;
	
	npc();
}
void() monster_randomize =
{
	local float r, pf, sf, mn;
	self.str = self.agil = self.vit = self.mag = self.dex = self.luck = (self.lvl * 2);
	self.max_health = 5 * self.lvl;

	self.max_mana = 10 * self.lvl;
	r = rint(self.lvl + (random() * (self.lvl / 2)) - (self.lvl / 4)) - self.value;
	if (random() < 0.5)
	{
		if (r < monsvalue)
		{
			// apply a good prefix/suffix to make the monster better
			if (random() < 0.2)
				pf = ceil(random() * 6) + 6; // # of bad prefixes
			if (random() < 0.2)
				sf = ceil(random() * 6) + 6; // # of bad suffixes
			r = r + ((pf - 6) * 2) - ((sf - 6) * 2);
		}
		if (r > monsvalue)
		{
			// avoid making monsters TOO bad
			if (random() < 0.2)
				pf = ceil(random() * 6); // # of bad prefixes
			if (random() < 0.2)
				sf = ceil(random() * 6); // # of bad suffixes
			r = r - (pf * 2) - (sf * 2);		
		}		
	}
	if (pf == 1)
	{
		self.str = self.str - 5;
		self.max_health = ceil(self.max_health * 0.5);
		self.tohit = self.tohit - 10;
	}
	else if (pf == 2)
	{
		self.str = self.str - 5;
		self.max_health = ceil(self.max_health * 0.25);
	}
	else if (pf == 3)
		self.max_health = ceil(self.max_health * 0.1);
	else if (pf == 4)
	{
		self.tohit = self.tohit - 60;
		self.dodge = self.dodge - 60;
	}
	else if (pf == 5)
	{
		self.agil = self.agil - 10;
		self.speed = self.speed * 0.5;
	}
	else if (pf == 6)
		self.dex = self.dex - 10;
		
	else if (pf == 7)
	{
		self.agil = self.agil + 10;
		self.speed = self.speed * 2;
		self.spec = self.spec | SPEED;
	}
	else if (pf == 8)
	{
		// muscular
		self.str = self.str + 25;
	}
	else if (pf == 9)
	{
		// superior
		self.tohit = self.tohit + 50;
		self.str = self.str + 10;
		self.max_health = self.max_health * 1.8;
		self.scale = 1.1;
	}
	else if (pf == 10)
	{
		self.max_health = self.max_health * 3;
	}
	else if (pf == 11)
		self.fire = self.fire + 5;
	else if (pf == 12)
		self.poidam = self.poidam + 5;
	if (sf == 1)
		self.tohit = self.tohit - 7;
	else if (sf == 2)
	{
		self.tohit = self.tohit - 10;
		self.dodge = self.dodge - 10;
	}
	else if (sf == 3)
	{
		self.dex = self.dex - 20;
	}
	else if (sf == 4)
	{
		self.mag = self.mag - 10;
		self.max_mana = 10;
	}
	else if (sf == 5)
	{
		self.str = self.str - 50;
	}
	else if (sf == 6)
	{
		self.speed = self.speed * 0.5;
	}
	else if (sf == 7)
		self.spec = self.spec | STEAL_LIFE;
	else if (sf == 8)
	{
		// superior
		self.tohit = self.tohit + 50;
		self.str = self.str + 10;
		self.max_health = self.max_health * 1.8;
	}
	else if (sf == 9)
	{
		// superior
		self.tohit = self.tohit + 50;
		self.str = self.str + 20;
		self.dex = self.dex + 10;
		self.max_health = self.max_health * 3;
		self.effects = self.effects | EF_DIMLIGHT;
	}
	else if (sf == 10)
	{
		if (random() < 0.5)
			self.spell = SP_ZAP;
		else
			self.spell = SP_FIREBALL; // for now
	}
	else if (sf == 11)
	{
		self.spell = SP_ZAP; // for now;
	}
	else if (sf == 12)
	{
		self.spell = SP_HEALOTHER; // for now
	}
	self.monnum = recode(self.monnum, 2, pf);
	self.monnum = recode(self.monnum, 3, sf);

	self.exp = floor(r * 4.25);
	if (self.exp < 1)
		self.exp = 1;
	r = floor(ceil(r / monsvalue) * random() + random());
	if ((r > 0) && (!self.slot1))
		self.droprandom = self.droprandom | 1;
	if ((r > 1) && (!self.slot2))
		self.droprandom = self.droprandom | 2;
	if ((r > 2) && (!self.slot3))
		self.droprandom = self.droprandom | 4;

	monster();
	self.max_health = ceil(self.max_health * 0.7);
	self.health = self.max_health;
	self.tohit = self.tohit - 15; // monsters take a 15% tohit penalty
	self.dodge = self.dodge - 20; // monsters take a 25% dodge penalty
};
