void() m_invenlst =
{
	local float i;
	if (self.menu < 1)
		self.menu = 9;
	else if (self.menu > 9)
		self.menu = 1;
	
	
	if (self.button1)
	{
		self.button1 = 0;
		if (self.menu == 9)
			closemenu(self);
		else
		{
			self.weapon = pow2(self.menu);
			openmenu(self, m_inven, self);
			return;
		}
	}
		
	if (self.m_refresh >= time)
		return;
	pstart();	

	for (i=1; i <= TOTAL_SLOTS; i = i + 1)
	{
		if (self.menu == i)
			p2(141, 16);
		else 
			p2(' ', 16);
		red = -30;
		pnum(i);
		red = 0;
		p2(17, ' ');
		simplestat(GetSlot(i));
		PrintItemName();
		pad(39);
		newline();
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