void() m_sell;

void() shopitem;

void(float it) dropshopitem =
{
	local entity oself;
	oself = self;
	self = find(world, netname, self.m_subject.wad);
	while(self)
	{
		if (self.classname == "item")
		{
			if (self.items == 0)
			{
				self.items = it;
				shopitem();
				self = oself;
				return;
			}
		}
		self = find(self, netname, self.m_subject.netname);
	}
	self = oself;
			
};
void() m_sell_confirm =
{
	local float it;
	
	it = GetSlot(root2(self.weapon));
	
	if (self.menu < 1)
		self.menu = 2;
	else if (self.menu > 2)
		self.menu = 1;

	if (self.button1)
	{
		self.button1 = 0;
		if (self.menu == 1)
		{
			itemstat(it);
			dropshopitem(it);
			it = ceil(stat_price * 0.5);
			Unequip(root2(self.weapon), 1);
			SetSlot(root2(self.weapon), 0);
			givegold(it);				
			openmenu(self, m_sell, self.m_subject);
			return;				
		}
		else if (self.menu == 2)
		{
			closemenu(self);
			return;
		}

	}
	if (self.m_refresh < time)
	{
		inven(it, fabs(self.equip & self.weapon) + 1);

		p8('S', 'e', 'l', 'l', 's', ' ', 'f', 'o');
		p2('r', ' ');
		pnum(ceil(stat_price * 0.5));
		p5(' ', 'G', 'o', 'l', 'd');
		newline();

		line();
	
		if (self.menu == 1)
			WriteString(MSG_ONE, "Sell this item?\n\{141}\[\1\] Yes\n \[\2\] No \n");
		else
			WriteString(MSG_ONE, "Sell this item?\n \[\1\] Yes\n\{141}\[\2\] No \n");
	
	}
}

void() m_sell =
{
	
	local float i, f;
	if (self.menu < 1)
		self.menu = 9;
	else if (self.menu > 9)
		self.menu = 1;

	if (self.button1)
	{
		self.button1 = 0;
		if (self.menu == 9)
		{
			closemenu(self);
			return;
		}
		itemstat(GetSlot(self.menu));
		if (stat_it && stat_it != IT_GOLD)
		{	
			self.weapon = pow2(self.menu);
			openmenu(self, m_sell_confirm, self.m_subject);			
			return;
		}
	}
	if (self.m_refresh >= time)
		return;
	pstart();	
	p4('S', 'e', 'l', 'l');
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
		if (stat_it && stat_it != IT_GOLD)
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
			pad(33);

			pnum(ceil(stat_price * 0.5));
			p2('G', 'P');
			pad(40);
	
			newline();
		}
		else
		{
			if (self.menu == i)
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
	}
	line();
	
	if(self.menu == 9)
		p1(141);
	else
		p1(' ');
	
	p8(16, 27, 17, ' ', 'E', 'x', 'i', 't');
	pad(40);
	newline();
	p1(0);
};