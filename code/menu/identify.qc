float IDENTIFY_COST = 35;
void() m_identify;

void() m_identify_confirm =
{
	local float it, slot, howm;
	slot = root2(self.weapon);
	
	it = GetSlot(slot);
	itemstat(it);
	
	if (self.menu < 1)
		self.menu = 2;
	else if (self.menu > 2)
		self.menu = 1;

	if (self.button1)
	{
		self.button1 = 0;
		if (self.menu == 1)
		{
			if(!takeamount(IT_GOLD, 0, 0, IDENTIFY_COST))
				prompt(self, "You don't have enough gold for this", self, 2);
			else
			{
				itemstat(it);
				stat_id = 1;
				SetSlot(slot, setstat());
				openmenu(self, m_inven, self);
				return;
			}	
		}
		else if (self.menu == 2)
		{
			openmenu(self, m_identify, self.m_subject);
			return;
		}
	}
	if (self.m_refresh < time)
	{
		inven(it, fabs(self.equip & self.weapon) + 1);
		howm = itemcount(IT_GOLD);
		if (howm < IDENTIFY_COST)
			red = RED_ON;
		p6('C', 'o', 's', 't', 's', ' ');
		pnum(IDENTIFY_COST);
		p5(' ', 'G', 'o', 'l', 'd');
		newline();
		p8('Y', 'o', 'u', ' ', 'H', 'a', 'v', 'e');
		p1(' ');
		pnum(howm);
		p5(' ', 'G', 'o', 'l', 'd');
		newline();
		line();
	
		if (self.menu == 1)
			WriteString(MSG_ONE, "Identify this item?\n\{141}\[\1\] Yes\n \[\2\] No \n");
		else
			WriteString(MSG_ONE, "Identify this item?\n \[\1\] Yes\n\{141}\[\2\] No \n");
	
	}
}

void() m_identify =
{
	
	local float i, f;
	if (self.menu < 1)
		self.menu = 9;
	else if (self.menu > 9)
		self.menu = 1;
		
	
	if (self.button1)
	{
		self.button1 = 0;
		simplestat(GetSlot(self.menu));
		if (self.menu == 9)
		{
			closemenu(self);
			return;
		}
		if (!stat_id)
		{
			self.weapon = pow2(self.menu);
			openmenu(self, m_identify_confirm, self.m_subject);			
			return;
		}
	}
		
	if (self.m_refresh >= time)
		return;
	pstart();	
	p8('I', 'd', 'e', 'n', 't', 'i', 'f', 'y');
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

		if (!stat_id)
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