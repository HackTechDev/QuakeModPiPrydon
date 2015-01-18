
//Starting stats


void() SetNewParms =
{
	// total running time is reset on new game ??????
	if (!mplayer)
		cvar_set("nomonsters", "0");
	
	parm1 = encode(32, 30, 2);
	parm2 = 0;
	parm3 = 0;
	parm4 = 0;
	parm5 = 0;
	parm6 = 0;
	parm7 = 0;
	parm8 = encode(0, 3, 0);
	parm9 =  393281; // Damaged Cloth, 6/6 dur
	parm10 = 573674; // Cheap club of fireball, 8/8 dur
	parm11 = 786464; // 12 gold
	parm12 = 0;
	parm13 = 0;
	parm14 = 0;
	parm15 = 0;
	parm16 = 0;
};

void() setruntime =
{
/*
	msg_entity = self;
	WriteChar(MSG_ONE, 9);
	p8('n', 'o', 'm', 'o', 'n', 's', 't', 'e');
	p3('r', 's',' ');
	pnum(runtime);
	WriteString(MSG_ONE, "\n");
*/
	localcmd("nomonsters ");
	localcmd(ftos(runtime + time));
	localcmd("\n");
};

void() SetChangeParms =
{
	local string h;
	local float f;
	
	// update the total running time
	setruntime();
	if (world.map != "" || mapname == "save")
		return;

	// remove all equipment so the player's stats will return to 'base'
	Unstat();

	parm1 = encode(self.health, self.max_health, self.mana);
	parm2 = self.exp;
	parm3 = encode(self.str, self.mag, self.dex);
	parm4 = encode(self.vit, self.agil, self.luck);
	parm5 = self.spells1;
	parm6 = self.spells2;
	parm7 = encode(self.spell, self.questlog, self.skill); 
	parm8 = encode(self.ptd, self.equip, self.lvl);
	parm9 = self.slot1;
	parm10 = self.slot2;
	parm11 = self.slot3;
	parm12 = self.slot4;
	parm13 = self.slot5;
	parm14 = self.slot6;
	parm15 = self.slot7;
	parm16 = self.slot8;
};

void() DecodeLevelParms = 
{

	if (world.map)
		return;
	if (!parm8)
	{
		dprint("No parms?!\n");
		SetNewParms();
	}
		
	self.health = decode(parm1, 1);
	self.max_health = decode(parm1, 2);
	self.mana = decode(parm1, 3);
	self.exp = parm2;
	self.str = decode(parm3, 1);
	self.mag = decode(parm3, 2);
	self.dex = decode(parm3, 3);
	self.vit = decode(parm4, 1);
	self.agil = decode(parm4, 2);
	self.luck = decode(parm4, 3);
	self.spells1 = parm5;
	self.spells2 = parm6;
	self.spell = decode(parm7, 1);
	self.questlog = decode(parm7, 2);
	self.skill = decode(parm7, 3);
	self.ptd = decode(parm8, 1);
	self.equip = decode(parm8, 2);
	self.lvl = decode(parm8, 3);
	if (!self.lvl)
	{
		self.sounds = 1; // a new guy
		self.lvl = 1;
	}
		
	self.slot1 = parm9;
	self.slot2 = parm10;
	self.slot3 = parm11;
	self.slot4 = parm12;
	self.slot5 = parm13;
	self.slot6 = parm14;
	self.slot7 = parm15;
	self.slot8 = parm16;
	// restore player's equip effects
	Restat();
};
