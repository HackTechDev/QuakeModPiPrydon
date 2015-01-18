
//Starting stats


void() SetNewParms =
{

	// total running time is reset on new game ??????
	if (!mplayer)
		cvar_set("nomonsters", "0");
	// health, ptd, mana
	parm1 = 0;
	parm2 = encode(32, 32, 2);
	parm3 = encode4(0,0);
	parm4 = encode4(0,0);
	parm5 = 0;
	parm6 = 0;
	parm7 = 0;
	parm8 = 3; // for now...
	parm9 =  encode4(393281, 0); // Damaged Cloth, 6/6 dur
	parm10 = encode4(573674, 0); // Cheap club of fireball, 8/8 dur
	parm11 = encode4(786464, 0); // 12 gold
	parm12 = encode4(0,0);
	parm13 = encode4(0,0);
	parm14 = encode4(0,0);
	parm15 = encode4(0,0);
	parm16 = 0;
};

void() setruntime =
{
	localcmd("nomonsters ");
	localcmd(ftos(runtime + time));
	localcmd("\n");
};

void() SetChangeParms =
{
	local string h;
	local float f;
	
	setruntime();
	if (world.map)
		return;
	Unstat();

	if (self.questlog != story)
		parm1 = 0 - self.exp;
	else
		parm1 = self.exp;
	parm2 = encode(self.health, self.max_health, self.mana);
	parm3 = encode4(self.spells1, self.spell);
	parm4 = encode4(self.spells2, self.skill);
	parm5 = 0;
	parm6 = 0;
	parm7 = 0;
	parm8 = self.equip;
	parm9 = encode4(self.slot1, self.str);
	parm10 = encode4(self.slot2, self.mag);
	parm11 = encode4(self.slot3, self.dex);
	parm12 = encode4(self.slot4, self.vit);
	parm13 = encode4(self.slot5, self.agil);
	parm14 = encode4(self.slot6, self.luck);
	parm15 = encode4(self.slot7, self.ptd); 
	parm16 = self.slot8;
};

void() DecodeLevelParms = 
{

	self.health = decode(parm2, 1);
	self.max_health = decode(parm2, 2);
	self.mana = decode(parm2, 3);
	if (mapname == "save")
		return;
	if (parm2 < 0)
	{
		self.questlog = !story;
		self.exp = 0 - parm1;
		
	}
	else
	{
		self.questlog = story;
		self.exp = parm1;
	}
	self.lvl = LvlForExp(self.exp);
	if (!self.exp)
	{
		self.sounds = 1; // a new guy
		self.lvl = 1;
		self.exp = 1;
	}
	self.spell = decode4(parm3);
	self.spells1 = unlock4(parm3, self.spell);
	self.skill = decode4(parm4);
	self.spells2 = unlock4(parm4, self.skill);

	self.str = decode4(parm9);
	self.mag = decode4(parm10);
	self.dex = decode4(parm11);
	self.vit = decode4(parm12);
	self.agil = decode4(parm13);
	self.luck = decode4(parm14);
	self.ptd = decode4(parm15);
		
	self.slot1 = unlock4(parm9,self.str);
	self.slot2 = unlock4(parm10, self.mag);
	self.slot3 = unlock4(parm11, self.dex);
	self.slot4 = unlock4(parm12, self.vit);
	self.slot5 = unlock4(parm13, self.agil);
	self.slot6 = unlock4(parm14, self.luck);
	self.slot7 = unlock4(parm15, self.ptd);
	self.slot8 = parm16;
	self.equip = parm8;
	// restore player's equip effects
	Restat();
};
