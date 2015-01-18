void(entity e) boundstats =
{
	if (e.health > e.max_health)
		e.health = e.max_health;
	else if (e.health < 0)
		e.health = 0;
	if (e.mana > e.max_mana)
		e.mana = e.max_mana;
	else if (e.mana < 0)
		e.mana = 0;
	if (e.classname == "player")
		if (GetSpellLevel(e, e.spell) < 1)
			e.spell = 0;
};
void(float sign) GenStat =
{
	self.max_health = self.max_health + (2 * self.vit + 2 * self.lvl) * sign;
	self.max_mana = self.max_mana + (2 * self.mag + ceil(self.lvl * 0.8)) * sign;
	self.tohit = self.tohit + (50 + rint(self.dex / 3) + rint(self.luck / 3)) * sign;
	self.dodge = self.dodge + (50 + rint(self.agil/2)) * sign;
	self.ac = self.ac + (self.lvl * 2) * sign;
	self.daml = self.daml + (ceil(self.str * 0.2) + 1) * sign;
	self.dama = self.dama + 1 * sign;
};


void() Restat =
{
	float i;
	GenStat(1);
	for(i = 1; i <= TOTAL_SLOTS; i = i + 1)
	{
		if (self.equip & pow2(i))
		{
			itemstat(GetSlot(i));
			UseItem(1);
		}
	}
	
	boundstats(self);
};

void() Unstat =
{
	float i;
	for(i = 1; i <= TOTAL_SLOTS; i = i + 1)
	{
		if (self.equip & pow2(i))
		{
			itemstat(GetSlot(i));
			UseItem(-1);
		}
	}
	GenStat(-1);
};

