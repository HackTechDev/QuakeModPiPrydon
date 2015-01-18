void() m_repair;
float() repaircost =
{
	local float m;
	m = ceil(((stat_max_dur - stat_dur) / stat_max_dur) * stat_price * 0.65);
	
	if (m <= 1)
		m = 1;
	return m;
};
void() m_repair_confirm =
{
	local float it, slot, cost, howm;
	slot = root2(self.weapon);
	
	it = GetSlot(slot);
	itemstat(it);
	cost = repaircost();
	
	if (self.menu < 1)
		self.menu = 2;
	else if (self.menu > 2)
		self.menu = 1;

	if (self.button1)
	{
		self.button1 = 0;
		if (self.menu == 1)
		{
			if(!takeamount(IT_GOLD, 0, 0, cost))
				prompt(self, "You don't have enough gold for this", self, 2);
			else
			{
				itemstat(it);
				stat_dur = stat_max_dur;
				SetSlot(slot, setstat());
				openmenu(self, m_repair, self.m_subject);
				self.weapon = 0;
				return;
			}	
		}
		else if (self.menu == 2)
		{
			closemenu(self);
			return;
		}
	}
	if (self.m_refresh < time)
	{
		howm = itemcount(IT_GOLD);
		inven(it, fabs(self.equip & self.weapon) + 1);
		if (howm < cost)
			red = RED_ON;
		p6('C', 'o', 's', 't', 's', ' ');
		pnum(cost);
		p5(' ', 'G', 'o', 'l', 'd');
		newline();
		p8('Y', 'o', 'u', ' ', 'H', 'a', 'v', 'e');
		p1(' ');
		pnum(howm);
		p5(' ', 'G', 'o', 'l', 'd');
		newline();
		line();
	
		if (self.menu == 1)
			WriteString(MSG_ONE, "Repair this item?\n\{141}\[\1\] Yes\n \[\2\] No \n");
		else
			WriteString(MSG_ONE, "Repair this item?\n \[\1\] Yes\n\{141}\[\2\] No \n");
	
	}
}

void() m_repair =
{
	
	local float i, f;
	if (self.menu < 1)
		self.menu = 9;
	else if (self.menu > 9)
		self.menu = 1;
		
	
	if (self.button1)
	{
		self.button1 = 0;
		itemstat(GetSlot(self.menu));
		if (self.menu == 9)
		{
			closemenu(self);
			return;
		}
		if (((stat_loc & DURABILITY) || stat_dur >= stat_max_dur ))
		{
			self.weapon = pow2(self.menu);
			openmenu(self, m_repair_confirm, self.m_subject);			
			return;
		}
	}
		
	if (self.m_refresh >= time)
		return;
	pstart();	
	p6('R', 'e', 'p', 'a', 'i', 'r');
	newline();
	p8('Y', 'o', 'u', ' ', 'H', 'a', 'v', 'e');
	p1(' ');
	pnum(itemcount(IT_GOLD));
	p5(' ', 'G', 'o', 'l', 'd');
	newline();
	line();
	for (i=1; i <= TOTAL_SLOTS; i = i + 1)
	{
		f = GetSlot(i);
		itemstat(f);

		if ((stat_dur < stat_max_dur) && (stat_loc & DURABILITY))
		{
			if (self.menu == i)
				p2(141, 16);
			else 
				p2(' ', 16);
			red = -30;
			pnum(i);
			red = 0;
			p2(17, ' ');
			
			PrintItemName();
			pad(30);
			newline();
			pad(5);
			p8('D', 'u', 'r', 'a', 'b', 'i', 'l', 'i');
			p3('t', 'y', ' ');
			pnum(stat_dur);
			p1('/');
			pnum(stat_max_dur);
			pad(23);
			p5('C', 'o', 's', 't', ' ');
			pnum(repaircost());
			pad(30);
			newline();
		}
		else if (self.menu == i)
		{
			if (self.impulse == -1)
			{
				self.menu = self.menu - 1;
				self.m_refresh = 0; // refresh the menu because we've already print that line
				if (self.menu < 1)
					self.menu = 9;
			}
			else	
				self.menu = self.menu + 1;
		}
	}
	newline();
	line();
	
	if(self.menu == 9)
		p1(141);
	else
		p1(' ');
	
	p8(16, 27, 17, ' ', 'E', 'x', 'i', 't');
	pad(30);
	newline();
	p1(0);
};