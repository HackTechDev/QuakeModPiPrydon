// definitely not the most efficient methodology in the world!

float(entity e, float espell) GetSpellLevel =
{
	local float f;
	if (espell <= 8)
	{
		f = pow(2, (espell - 1) * 3);
		return floor((e.spells1 / f) & 7);
	}
	else if (espell <= 16)
	{
		f = pow(2, (espell - 9) * 3);
		return floor((e.spells2 / f) & 7);
	}
	return 1;
};


void(entity e, float espell, float level) SetSpellLevel =
{
	local float f, l;
	
	l = GetSpellLevel(e, espell);
	l = l + level;
	if (l < 0)
		l = 0;
	else if (l > 7)
		l = 7;

	if (espell > 8)
	{
		f = pow(2, (espell - 9) * 3);
		e.spells2 = (e.spells2 - (e.spells2 & (f * 7))) |  (f * l);
	}
	else
	{
		f = pow(2, (espell - 1) * 3);
		e.spells1 = (e.spells1 - (e.spells1 & (f * 7))) |  (f * l);
	}
};
