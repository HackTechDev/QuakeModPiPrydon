

void() m_stats =
{
	var .float fld;
	
	if (self.menu < 1)
		self.menu = 7;
	else if (self.menu > 7)
		self.menu = 1;
	if (!self.ptd)
		self.menu = 7;
	if (self.button1)
	{
		self.m_refresh = 0;
		self.button1 = 0;
		if (self.menu == 7)
			closemenu(self);
		else if (self.ptd > 0)
		{
			GenStat(-1);
			if (self.menu == 1)
				fld = str;
			else if (self.menu == 2)
				fld = dex;
			else if (self.menu == 3)
				fld = mag;
			else if (self.menu == 4)
				fld = vit;
			else if (self.menu == 5)
				fld = luck;
			else if (self.menu == 6)
				fld = agil;
			else
			{
				GenStat(1);
				return;
			}
			if (self.fld < 255)
			{
				self.ptd = self.ptd - 1;
				self.fld = self.fld + 1;
			}
			GenStat(1);
		}	
	}
	
	if (self.m_refresh >= time)
		return;
	// show the player his stats and allows ptd
	pstart();

	p5('L', 'e', 'v', 'e', 'l');
	pad(8);
	pnum(self.lvl);
	pad(15);
	p7('P','e','a','s','a','n','t');
	pad(30);
	newline();
	
	p6('H', 'e', 'a', 'l', 't', 'h');
	pad(8);
	pnum(self.health);
	p1('/');
	pnum(self.max_health);
	pad(15);
	p4('M', 'a', 'n', 'a');
	pad(23);
	pnum(self.mana);
	p1('/');
	pnum(self.max_mana);
	pad(30);
	newline();
		
	p8('T', 'o', ' ', 'H', 'i', 't', ' ', '%');
	pad(8);
	pnum(self.tohit);
	pad(15);
	p5('D', 'o', 'd', 'g', 'e');
	pad(23);
	pnum(self.dodge);
	p1('%');
	pad(30);
	newline();
	
	p2('A', 'C');
	pad(8);
	pnum(self.ac);
	pad(15);
	p6('D', 'a', 'm', 'a', 'g', 'e');
	pad(23);
	pnum(self.daml);
	p1(45);
	pnum(self.dama + self.daml);
	pad(30);
	newline();
	
	p4('E', 'x', 'p', ' ');
	pad(8);
	pnum(self.exp);
	pad(15);
	p8('N', 'e', 'x', 't', ' ', 'L', 'v', 'l');
	pad(23);
	if (self.lvl < 50)
		pnum(ExpForLevel(self.lvl));
	else
		p3('N', '/', 'A');

	pad(30);
	newline();
	
	line();
	if (self.menu == 1)
		WriteChar(MSG_ONE, 141);
	else
		WriteChar(MSG_ONE, 32);
	p8(16, 19, 17, ' ', 'S', 't', 'r', 'e');
	p4('n', 'g', 't', 'h');
	pad(23);

	pnum(self.str);
	red = 0;
	pad(29);
	newline();
	if (self.menu == 2)
		WriteChar(MSG_ONE, 141);
	else
		WriteChar(MSG_ONE, 32);
	p8(16, 20, 17, ' ', 'D', 'e', 'x', 't');
	p5('e', 'r', 'i', 't', 'y');
	pad(23);

	pnum(self.dex);
	red = 0;
	pad(29);
	newline();
	if (self.menu == 3)
		WriteChar(MSG_ONE, 141);
	else
		WriteChar(MSG_ONE, 32);
	p8(16, 21, 17, ' ', 'I', 'n', 't', 'e');
	p8('l', 'l', 'i', 'g', 'e', 'n', 'c', 'e');
	pad(23);

	pnum(self.mag);
	red = 0;
	pad(29);
	newline();
	if (self.menu == 4)
		WriteChar(MSG_ONE, 141);
	else
		WriteChar(MSG_ONE, 32);	
	p8(16, 22, 17, ' ', 'V', 'i', 't', 'a');
	p4('l', 'i', 't', 'y');
	
	pad(23);

	pnum(self.vit);
	red = 0;
	pad(29);
	newline();
	if (self.menu == 5)
		WriteChar(MSG_ONE, 141);
	else
		WriteChar(MSG_ONE, 32);	
	p8(16, 23, 17, ' ', 'L', 'u', 'c', 'k');
	pad(23);
	pnum(self.luck);
	red = 0;
	pad(29);
	newline();
	if(self.menu == 6)
		WriteChar(MSG_ONE, 141);
	else
		WriteChar(MSG_ONE, 32);
	p8(16, 24, 17, ' ', 'A', 'g', 'i', 'l');
	p3('i', 't', 'y');
	pad(23);

	pnum(self.agil);
	pad(29);
	newline();
	
	if (self.ptd)
	{
		red = RED_ON;
		p8('P', 'o', 'i', 'n', 't', 's', ' ', 'l');
		p8('e', 'f', 't', ' ', 't', 'o', ' ', 'd');
		p8('i', 's', 't', 'r', 'i', 'b', 'u', 't');
		p2('e', ' ');
		pnum(self.ptd);
		pad(29);
	}
	
	newline();
	line();

	if(self.menu == 7)
		WriteChar(MSG_ONE, 141);
	else
		WriteChar(MSG_ONE, 32);
	p8(16, 25, 17, ' ', 'E', 'x', 'i', 't');
	pad(29);
	p1(0);
	
};

