
float(float slot) AutoEquip =
{
	local float d, i;
	itemstat(GetSlot(slot));
	
	if (stat_loc & EQUIPABLE)
	{
		// don't let scrolls equip themselves if you're using a spell
		if (stat_loc & SPELL)
			if (self.spell)
				return FALSE;
		// auto-equip
		d = stat_loc & LOC;
		for (i=1; i < TOTAL_SLOTS; i = i + 1)
		{
			if (self.equip & pow2(i))
			{
				itemstat(GetSlot(i));
				if (stat_loc & d)
					return FALSE;
			}
		}
		return Equip(slot);
	}
};

void() openitembuy =
{
	openmenu(other, m_itembuy, self);
};

void() action_pickup =
{
	local float r;
	local entity oself;
	oself = self;
	self = other.owner;
	r = pickupitem(oself.items);
	if (r)
	{
		dropitem(r);
		sprint(self, "Not enough room in your inventory\n");
	}
	remove(oself);
	self = oself;
};



float(float it) pickupitem =
{
	local float i,d, slot;
	
	// find stackables?
	itemstat(it);
	if (stat_id)
	if (stat_loc & STACKABLE)
	{
		d = stat_dur;
		
		i = 1;
		while(i < 9)
		{
			i = hasitem(stat_it, stat_pref, stat_suf, i, 1);
			if (!i)
				break;
			itemstat(GetSlot(i));
			stat_dur = stat_dur + d;
			d = stat_dur - stat_max_dur;
			if (d<0)
				d=0;
			stat_dur = stat_dur - d;

			SetSlot(i, setstat());
			if (!d)
				return FALSE;
			simplestat(it);
			stat_dur = d;
		
			it = setstat();
			i = i + 1;
		}

	}
	slot = hasitem(0, 0, 0, 1, 1);
	if (!slot)
		return it;
	SetSlot(slot, it);
	AutoEquip(slot);
		
	return FALSE;
};
