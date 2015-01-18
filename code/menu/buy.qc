


void() m_itembuy =
{
	local float r, howm;
	
	if (self.menu != 1)
		self.menu = 1;
	if (self.button1)
	{

		self.button1 = 0;	
		if(!takeamount(IT_GOLD, 0, 0, self.m_subject.menu))
		{
			prompt(self, "You don't have enough gold for this", self, 2);
			return;
		}
		r = pickupitem(self.m_subject.items);
		simplestat(self.m_subject.items);
		if (!r)
		{
			sound(self.m_subject, CHAN_BODY, itemsound(stat_it), 1, ATTN_NORM);
			if (self.m_subject.spawnflags & 1)
			{
				// infinite
				closemenu(self);
				return;
			}
			else if (self.m_subject.netname)
			{
				// shopitem
				setmodel(self.m_subject, "");
				self.m_subject.items = 0;
			}
			else
				remove(self.m_subject);
			closemenu(self);
			return;
		}
		else
		{
			itemstat(r);
			givegold(stat_price);
			prompt(self, "You don't have enough room\nin your inventory", self, 2);
		}
		return;
	}
	if (self.m_refresh < time)
	{
		inven(self.m_subject.items, 0);

		howm = itemcount(IT_GOLD);
		if (howm < self.m_subject.menu)
			red = RED_ON;
		p6('C', 'o', 's', 't', 's', ' ');
		pnum(self.m_subject.menu);
		p5(' ', 'G', 'o', 'l', 'd');
		newline();
		p8('Y', 'o', 'u', ' ', 'H', 'a', 'v', 'e');
		p1(' ');
		pnum(howm);
		p5(' ', 'G', 'o', 'l', 'd');
		newline();
		line();
		WriteString(MSG_ONE, "\n\{141}\[\1\] Buy    ");

	}
};
