void() h_impulse =
{
	float i;
	
	if ((self.impulse >= 21) && (self.impulse <= 28))
	{
		i = self.impulse - 20;
			
		itemstat(GetSlot(i));
		if (stat_loc & EQUIPABLE)
		{
			if (self.equip & pow2(i))
				Unequip(i, 1);
			else if (!Equip(i))
				sprint(self, "Can't!\n");
		}
		if (stat_loc & USABLE)
			Use(i);
	}
	else if (self.impulse == 13)
	{
		if (!self.menu)
			openmenu(self, m_mainmenu, self);
	}
	else if (self.impulse == 14)
		self.button1 = 1;
	else if (self.impulse == 30)
	{
		i = hasitem(IT_GREATER_HEAL, 0, 0, 0, 0);
		if (i)
		{
			itemstat(GetSlot(i));
			Use(i);
		}
		i = hasitem(IT_HEAL_POTION, 0, 0, 0, 0);
		if (i)
		{
			itemstat(GetSlot(i));
			Use(i);
		}
		i = hasitem(IT_LESSER_HEAL, 0, 0, 0, 0);
		if (i)
		{
			itemstat(GetSlot(i));
			Use(i);
		}

	}
	else if (self.impulse == 31)
	{
		i = hasitem(IT_GREATER_MANA, 0, 0, 0, 0);
		if (i)
		{
			itemstat(GetSlot(i));
			Use(i);
		}
		i = hasitem(IT_MANA_POTION, 0, 0, 0, 0);
		if (i)
		{
			itemstat(GetSlot(i));
			Use(i);
		}
		i = hasitem(IT_LESSER_MANA, 0, 0, 0, 0);
		if (i)
		{
			itemstat(GetSlot(i));
			Use(i);
		}
	}
/*
	else if (self.impulse == 40 || self.impulse == 41)
	{
		float t;
		if (self.weapon)
		{
			i = root2(self.weapon);
			simplestat(GetSlot(i));
			if (self.impulse == 40)
				t = 1;
			else 
				t = -1;
			if (self.menu == 1)
				stat_it = stat_it + t;
			else if (self.menu == 2)
				stat_pref = stat_pref + t;
			else if (self.menu == 3)
				stat_suf = stat_suf + t;
			else if (self.menu == 4)
				stat_dur = stat_dur + t;

			SetSlot(i, setstat());
			self.m_refresh = 0;
		}
			
	}
	else if (self.impulse == 47)
	{
		dropitem(96512);
		dropitem(96512);
		dropitem(16772416);
	}
*/
	else if (self.impulse == 42)
		sprint(self, ftos(GetSlot(root2(self.weapon))));
	else if (self.impulse == 11)
	{
		if (self.menu)
			closemenu(self);
	}
};
