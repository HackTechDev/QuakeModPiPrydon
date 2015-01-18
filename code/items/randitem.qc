/*


Item generator


*/

float (float base, float value, float shop) randitem =
{
	local float r, runawayloop;
	value = ceil(value + (random() * (value/2)) - (value/4));
	runawayloop = 0;

	:newitem
	runawayloop = runawayloop + 1;
	if (runawayloop > 10)
		return 0;
		
	// base item type first
	stat_dur = stat_pref = stat_suf = stat_it = 0;
	r = ceil(random() * BASEITEMS);
	if (base)
		stat_it = fabs(base);
	else
	{
		if (shop == 1)
		{
			stat_it = ceil(random() * 28);
			if (stat_it >= IT_STAFF)
				stat_it = stat_it + 2; // skip the 2 staves
			if (stat_it >= IT_AMULET)
				stat_it = stat_it + 1;
			value = 1.5 * value;
		}
		else if (shop == 2)
		{
			stat_it = floor(random() * 6) + IT_STAFF;
			if (stat_it > IT_SCEPTER) // skip the weapons
				stat_it = stat_it + 15;
			if (stat_it >= IT_ARROWS)
				stat_it = stat_it + 9;
			value = 1.5 * value;
		}
		else if (random() < 0.3) // these items are more common
		{
			r = ceil(random() * 4);
			if (r == 1)
				stat_it = IT_GOLD;
			else if (r == 2)
				stat_it = IT_LESSER_HEAL;
			else if (r == 3)
				stat_it = IT_LESSER_MANA;
			else if (r == 4)
				stat_it = IT_ARROWS;
		}
		else
			stat_it = r;
	}
	if (!stat_it)
		goto newitem;
	
	itemstat(setstat());
	
	// reject the item if it's too good
	if ((stat_price / 2) > value)
	{
		if (!base)
			if (runawayloop < 10)
				goto newitem;
	}

	:newprefsuf
	runawayloop = runawayloop + 1;
	if (runawayloop > 10)
		return 0;
	if (random() > 0.7)
	{
		if (stat_price > value && !shop)
			stat_pref = ceil(random() * 8); 
		else 
			stat_pref = ceil(random() * 22) + 8; // NUMBER OF GOOD + NUMBER OF BAD
	}
	if (random() > 0.7)
	{
		if (stat_price > value && !shop)
			stat_suf = ceil(random() * 9);
		else
			stat_suf = ceil(random() * 54) + 9; // NUMBER OF GOOD + NUMBER OF BAD
	}	
	// next check if these prefixes/suffixes are valid
	stat_dur = 1;
	itemstat(setstat());
	stat_dur = stat_max_dur;
	if (stat_it == IT_GOLD)
	{
		stat_pref = stat_suf = 0;
		stat_dur = value;
		if (stat_dur <= 0)
			stat_dur = 1;
		else if (stat_dur > stat_max_dur)
			stat_dur = stat_max_dur;
	}
	else if ((stat_it >= IT_LESSER_HEAL) && (stat_it <= IT_GREATER_MANA))
	{
		stat_dur = ceil((value / stat_price) * random());
		stat_pref = stat_suf = 0;
		itemstat(setstat());
	}
	else if (stat_it == IT_ELIXIR)
	{
		if (random() > 0.2)
			if (runawayloop < 10)
				goto newitem;
		r = ceil(random() * 8);
		stat_pref = 0;
		if (r == 1)
			stat_suf = SF_VITALITY; // vitality
		else if (r == 2)
			stat_suf = SF_LUCK; // luck
		else if (r == 3)
			stat_suf = SF_STRENGTH; // strength
		else if (r == 4)
			stat_suf = SF_AGILITY; // agil
		else if (r == 5)
			stat_suf = SF_DEXTERITY; // dex
		else if (r == 6)
			stat_suf = SF_INTELLIGENCE; // intelligence
		else if (r == 7)
			stat_suf = SF_HEALTH; // health
		else if (r == 8)
			stat_suf = SF_MANA; // mana
	}
	else if (stat_it == IT_AMULET)
	{
		// amulet
		if (!(stat_suf || stat_pref))
			goto newitem;
		if (stat_pref == PF_BROKEN)
			goto newitem;
		else if (stat_pref == PF_DAMAGED)
			goto newitem;
		else if ((stat_pref >= PF_USELESS) && (stat_pref <= PF_QUALITY))
			goto newitem;
		else if (stat_pref == PF_SUPERIOR)
			goto newitem;
		else if (stat_pref == PF_OVERPRICED)
			goto newitem;
		else if (stat_pref == PF_HEAVY)
			goto newitem;
		else if (stat_suf == SF_FRAGILITY)
			goto newitem;
		else if (stat_suf == SF_QUALITY)
			goto newitem;
		else if (stat_suf == SF_EASE)
			goto newitem;	
	}
	else if (stat_it == IT_SCROLL)
	{

		stat_spell = ceil((random() * 4) * (random() * 4));
		stat_dur = floor( value / (7 + 5 * stat_spell)) + 1;
		if (stat_dur > stat_max_dur)
			stat_dur = stat_max_dur;
		stat_pref = 0;
		if (stat_suf < 48)
			stat_suf = 48;
		stat_suf = 47 + stat_spell;
	}
	else if (stat_it == IT_BOOK)
	{
		if (random() < 0.4)
			if (runawayloop < 5)
				goto newitem;
		stat_pref = 0;
		stat_spell = ceil((random() * 4) * (random() * 4));
		stat_suf = 47 + stat_spell;
		if (stat_suf < 48)
			stat_suf = 48;
	}
	else if (stat_it == IT_IDSCROLL)
	{
		stat_pref = stat_suf =  0;
		stat_dur = ceil ( value / 50 );
		if (stat_dur > stat_max_dur)
			stat_dur = stat_max_dur;
	}
	else if ((stat_it == IT_ARROWS) || (stat_it == IT_SPEARS) || (stat_it == IT_THROWKNIFE))
	{
		// arrows
		// usually arrows are plain
		if (random() < 0.6)
			stat_pref = stat_suf = 0;
		itemstat(setstat());
		stat_dur = ceil(value / stat_price * random() + 5 + random() * stat_max_dur);
		if (stat_dur > stat_max_dur)
			stat_dur = stat_max_dur;
	}
	if (stat_def)
	{
		if (stat_pref == PF_SHARP) // sharp
			goto newprefsuf;
	}
	if (stat_loc & STACKABLE)
	{
		if (stat_suf == SF_AGES)
			goto newprefsuf;
	}
	stat_id = 1;
	if (!shop)
		if (stat_pref || stat_suf)
			if (stat_it < IT_GOLD)
				if (random () < 0.8)
					stat_id = 0;
	return setstat();
};