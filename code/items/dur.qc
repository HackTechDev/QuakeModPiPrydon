float(float it) itemcount =
{
	float g, i;
	
	for(i=1; i<9; i = i + 1)
	{
		simplestat(GetSlot(i));
		if (stat_it == it)
			g = g + stat_dur;

	}
	return g;
};


float(float it, float pref, float suf, float howmuch) takeamount =
{
	float g, i;
	
	if (howmuch < 0)
		return FALSE;
	else if (howmuch == 0)
		return TRUE;
		
	g = itemcount(it);
	
	if (howmuch > g)
		return FALSE; // not enough
	
	for (i=8; i > 0; i = i - 1)
	{
		simplestat(GetSlot(i));
		if (stat_it == it && stat_pref == pref && stat_suf == suf)
		{
			g = stat_dur;
			stat_dur = stat_dur - howmuch;
			if (stat_dur <= 0)
			{
				SetSlot(i, 0);
				howmuch = howmuch - g;
			}
			SetSlot(i, setstat());
			if (howmuch <= 0)
				break;
		}
	}
	return TRUE;
};


void(float howmuch) givegold =
{
	local float l;
	if (howmuch <= 0)
		return;
	while(howmuch)
	{
		stat_dur = howmuch;
		if (stat_dur > 10000)
			stat_dur = 10000;
		howmuch = howmuch - stat_dur;
		stat_pref = stat_suf = 0;
		stat_it = IT_GOLD; // gold
		l = pickupitem(setstat());
		if (l)
			dropitem(l);
	}
};

float(float it) takeammo =
{
	// first find the slot of the arrows / scroll
	local float i;
	local entity e;
	e = self;
	self = self.owner;
	
	for(i=1; i<9; i = i + 1)
	{
		if (self.equip & pow2(i))
		{
			simplestat(GetSlot(i));
			if (stat_it == it)
			{
				
				stat_dur = stat_dur - 1;
				self.armorvalue = stat_dur;
				if (stat_dur <= 0)
				{
					msg_entity = self;
					WriteByte(MSG_ONE, 8);
					PrintItemName();
					WriteString(MSG_ONE, " has run out\n");
					Unequip(i, 1);
					SetSlot(i, 0);
					// TEST
					AutoEquip(hasitem(it, 0, 0, 0, 0));
				}
				else
					SetSlot(i, setstat());
				self = e;
				return TRUE;
			}
		}
	}
	self = e;
	return FALSE;		
};

void(entity who, float weps) DamageEquipment =
{
	float i;
	// this is okay because T_Damage restores the original self anyway
	self = who;
	if (random() < 0.8)
		return;
		
	for(i = 1; i <= TOTAL_SLOTS; i = i + 1)
	{
		if (self.equip & pow2(i))
		{
			itemstat(GetSlot(i));
			
			if (stat_loc & DURABILITY)
			{
				if ((weps && stat_daml) || (!weps && stat_def))
				{
					if (random() < 0.1)
					{
						stat_dur = stat_dur - 1;
						if (stat_dur <= 0)
						{
							stat_dur = 0;
							SetSlot(i, setstat());
							msg_entity = self;
							WriteByte(MSG_ONE, 8);
							PrintItemName();
							WriteString(MSG_ONE, " has broken\n");
							Unequip(i, 1);
							sound(self, CHAN_BODY, "player/break.wav", 1, ATTN_NORM);
						}
						else
						{
							if (stat_dur == ceil(stat_max_dur  * 0.15))
							{
								msg_entity = self;
								WriteByte(MSG_ONE, 8);
								PrintItemName();
								WriteString(MSG_ONE, " is about to break\n");	
							}
							SetSlot(i, setstat());
						}
					}
				}
			}
		}
	}

};
