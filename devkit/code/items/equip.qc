// false runaway loop error avoidance
void(float loc, float skip) EquipCheck =
{
	local float i, change, it;

	do
	{
		change = 0;
		for (i = 1; i < 9; i = i + 1)
		{
			if (i != skip)
			{
				
				it = GetSlot(i);
				if (!canuse(it))
				{
					if(Unequip(i, 0))
						change = 1;
				}
				else if (LOC & stat_loc & loc)
				{
					if(Unequip(i, 0))
						change = 1;
				}
			}
		}
		loc = 0;
	}
	while(change);
}



float(float slot) Equip =
{
	local float it, i, loc;
	it = GetSlot(slot);
	
	if (canuse(it) && (stat_loc & EQUIPABLE))
	{
		EquipCheck(stat_loc, slot);
		if (canuse(it))
		{
			sound(self, CHAN_AUTO, itemsound(stat_it), 1, ATTN_NORM);
			itemstat(it);
			if (UseItem(1))
			{
				self.equip = self.equip | pow2(slot);
				boundstats(self);
				return TRUE;
			}
		}
	}
	return FALSE;
};


float(float slot, float recheck) Unequip =
{
	local float f, i;
	f = pow2(slot);
	
	if (self.equip & f)
	{
		itemstat(GetSlot(slot));
		UseItem(-1);
		boundstats(self);
		self.equip = self.equip - f;
		if (recheck)
			EquipCheck(stat_loc, slot);
		return TRUE;
	}
	return FALSE;
	
};
