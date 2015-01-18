void(float sp) PrintSpellName =
{
	if (sp & 32)
	{
		p8('S', 'c', 'r', 'o', 'l', 'l', ' ', 'o');
		p2('f', ' ');
		sp = sp & 31;
	}
	if (sp == SP_FIREBALL)
		p8('F', 'i', 'r', 'e', 'b', 'a', 'l', 'l');
	else if (sp == SP_ZAP)
		p3('Z', 'a', 'p');
	else if (sp == SP_SLOW)
		p4('S', 'l', 'o', 'w');
	else if (sp == SP_WARP)
		p4('W', 'a', 'r', 'p');
	else if (sp == SP_POISONBALL)
	{
		p8('P', 'o', 'i', 's', 'o', 'n', 'b', 'a');
		p2('l', 'l');
	}
	else if (sp == SP_LEECH)
	{
		p8('L', 'e', 'e', 'c', 'h', ' ', 'L', 'i');
		p2('f', 'e');
	}
	else if (sp == SP_HEAL)
		p4('H', 'e', 'a', 'l');
	else if (sp == SP_SHIELD)
		p6('S', 'h', 'i', 'e', 'l', 'd');
	else if (sp == SP_TRANSMUTE)
	{
		p8('T', 'r', 'a', 'n', 's', 'm', 'u', 't');
		p1('e');
	}	
	else if (sp == SP_REPEL)
		p5('R', 'e', 'p', 'e', 'l');	
	else if (sp == SP_NOVA)
		p4('N', 'o', 'v', 'a');
	else if (sp == SP_TWISTER)
		p7('T', 'w', 'i', 's', 't', 'e', 'r');
	else if (sp == SP_TELEPORT)
		p8('T', 'e', 'l', 'e', 'p', 'o', 'r', 't');
	else if (sp == SP_SUMMON)
		p6('S', 'u', 'm', 'm', 'o', 'n');
	else if (sp == SP_METEOR)
		p6('M', 'e', 't', 'e', 'o', 'r');
	else if (sp == SP_EVILE)
		p5('E', 'v', 'i', 'l', 'e');
		
// delete these
	else if (sp == SP_GOTO)
		p4('G', 'o', 't', 'o');
	else if (sp == SP_ACTIVATE)
		p8('A', 'c', 't', 'i', 'v', 'a', 't', 'e');
	else if (sp == SP_FIGHT_MELEE)
		p5('F', 'i', 'g', 'h', 't');
	else if (sp == SP_FIGHT_BOW)
		p8('B', 'o', 'w', ' ', 'S', 'h', 'o', 't');
	else if (sp == SP_THROW)
		p5('T', 'h', 'r', 'o', 'w');
	else if (sp == SP_FOLLOW)
		p6('F', 'o', 'l', 'l', 'o', 'w');
	else if (sp == SP_HEALOTHER)
	{
		p8('H', 'e', 'a', 'l', ' ', 'O', 't', 'h');
		p2('e', 'r');
	}
};