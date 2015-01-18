
float(float source, float it) canuseon =
{
	simplestat(it);
	if (source == IT_IDSCROLL)
	{
		if (!stat_id)
			return TRUE;
	}
	return FALSE;
	
};

void() m_useon =
{
	local float i, m, source;
	if (self.menu < 1)
		self.menu = 9;
	else if (self.menu > 9)
		self.menu = 1;
	
	m = self.menu;
	
	i = root2(self.weapon);
	simplestat(GetSlot(i));
	source = stat_it;
	
	if (self.button1)
	{
		self.button1 = 0;
		if (self.menu == 9)
			openmenu(self, m_inven, self);
		else
		{
			openmenu(self, m_inven, self);
			if (!canuseon(source, GetSlot(m)))
			{
				sprint(self, "Can't!\n");
				return;
			}
			if (source == IT_IDSCROLL)			
			{
				stat_id = 1;
				SetSlot(m, setstat());
			}
			sound(self, CHAN_AUTO, itemsound(source), 1, ATTN_NORM);	
			self.weapon = pow2(m);
			
			simplestat(GetSlot(i));
			stat_dur = stat_dur - 1;
			if (stat_dur > 0)
				SetSlot(i, setstat());
			else
				SetSlot(i, 0);
			return;
		}
	}
		
	if (self.m_refresh >= time)
		return;
	pstart();	
	p4('U', 's', 'e', ' ');
	PrintItemName();
	p4(' ', 'o', 'n', ':');
	newline();
	line();
	for (i=1; i <= TOTAL_SLOTS; i = i + 1)
	{
		m = GetSlot(i);
		if (canuseon(source, m))
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
			pad(39);
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
	newline();
	line();
	
	if(self.menu == 9)
		p1(141);
	else
		p1(' ');
	
	p8(16, 27, 17, ' ', 'E', 'x', 'i', 't');
	pad(39);
	newline();
	p1(0);
};