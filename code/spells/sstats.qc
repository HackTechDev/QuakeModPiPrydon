float(float g) spell_range =
{
	local float m
	local float lev;
	
	lev = GetSpellLevel(self.owner, g);
	if (g & 32)
	{
		g = g & 31;
		lev = 7;
	}
	if (g == SP_FIREBALL)
		return 110 + lev * 2;
	else if (g == SP_ZAP)
		return 91 + lev * 5;
	else if (g == SP_SLOW)
		return 150;
	else if (g == SP_POISONBALL)
		return 110 + lev * 2;
	else if (g == SP_LEECH)
		return 90;
	else if (g == SP_REPEL)
		return 120;
	else if (g == SP_NOVA)
		return 70;
	else if (g == SP_GOTO)
		return 20;
	else if (g == SP_ACTIVATE)
		return 55;
	else if (g == SP_FIGHT_MELEE)
		return 59;
	else if (g == SP_FOLLOW)
		return 90;
	return BIG_DISTANCE;
};


float(float sp) cast_aground =
{
	sp = sp & 31;
	if (sp == SP_FIREBALL)
		return FALSE;
	else if (sp == SP_ZAP)
		return FALSE;
	else if (sp == SP_SLOW)
		return FALSE;
	else if (sp == SP_POISONBALL)
		return FALSE;
	else if (sp == SP_LEECH)
		return FALSE;
	else if (sp == SP_ACTIVATE)
		return FALSE;
	else if (sp == SP_FIGHT_MELEE)
		return FALSE;
	else if (sp == SP_FIGHT_BOW)
		return FALSE;
	else if (sp == SP_THROW)
		return FALSE;
	else if (sp == SP_AWAKEMONSTERS)
		return FALSE;
		
	return TRUE;
};

float (float sp, float lv) mana_for_spell =
{
	if (sp == SP_WARP)
		return 20 - lv * 2;
	else if (sp == SP_TELEPORT)
		return 60 - lv * 5;

	else if (sp <= 16)
		return ceil((sp + lv) * (1 - (1 / ((sp + 8) / 2)))) - 1;
	else
		return 0;
};