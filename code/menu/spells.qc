void(float sp, float lev) display_effect =
{
	local float dm;
	// 10 chars only :|
	if (sp == SP_FIREBALL)
	{
		p4('D', 'a', 'm', ':');
		dm = ceil(lev * lev * 1.1) + 9;
		pnum(dm/2);
		p1('-');
		pnum(dm);
	}
	else if (sp == SP_ZAP)
	{
		p6('D', 'a', 'm', ':', '1', '-');
		pnum( 15 + ceil(lev * lev * 1.4));
	}
	else if (sp == SP_SLOW)
	{
		p4('D', 'u', 'r', ':');
		pnum(lev * 2 + 3);
		p4('s', 'e', 'c','s');
	}
	else if (sp == SP_POISONBALL)
	{
		p4('D', 'a', 'm', ':');
		pnum( ceil(lev * lev * 1.5) + 20);
	}
	else if (sp == SP_LEECH)
	{
		p4('D', 'a', 'm', ':');
		pnum(lev * 3 + 5);	
	}
	else if (sp == SP_HEAL)
	{
		p5('H', 'e', 'a', 'l', ' ');
		dm = (lev + 4) / 2;
		pnum(ceil(dm*dm) + 5);
	}
	else if (sp == SP_SHIELD)
	{
		p4('D', 'u', 'r', ':');
		pnum(10 + lev * 5);
		p4('s', 'e', 'c','s');
	}
	else if (sp == SP_TRANSMUTE)
	{
		p6('V', 'a', 'l', 'u', 'e', ':');
		pnum(lev*10);
		p1('%');
	}
	else if (sp == SP_TWISTER)
	{
		p4('D', 'u', 'r', ':');
		pnum( 1 + lev * lev * 1.5);
		p4('s', 'e', 'c', 's');
	}
	else if (sp == SP_NOVA)
	{
		p6('D', 'a', 'm', ':', '1', '-');
		pnum( 10 + ceil(lev * lev * 1.8));
	}
	else if (sp == SP_REPEL)
	{
		p5('A', 'r', 'e', 'a',':');
		pnum(floor(5 + lev * lev * 0.2));
	}
	else if (sp == SP_SUMMON)
	{
		pnum(lev);
		if (lev < 3)
			p8(' ', 'S', 'c', 'a', 'r', 'i','t', 'e');
		else if (lev < 5)
			p8(' ', 'G', 'u', 'a', 'n', 'i', 't', 'e');
		else if (lev < 7)
			p6(' ', 'D', 'r', 'a', 'k', 's');
		else
			p8(' ', 'H', 'o', 'r', 'r', 'o', 'r', 's');
	}
	else if (sp == SP_EVILE)
	{
		p5('A', 'r', 'e', 'a',':');
		pnum(floor(5 + lev * lev * 0.2));
	}
		
};

void(float off) m_spells =
{
	local float i, lv, rn;
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
		if (GetSpellLevel(self, self.menu + off))
		{
			for (i=1; i < 9; i = i + 1)
			{
				itemstat(GetSlot(i));
				if (SPELL & stat_loc)
					Unequip(i, 1);
			}
			self.spell = self.menu + off;
			closemenu(self);
			return;
		}
	}
		
	if (self.m_refresh >= time)
		return;
	pstart();	

	for (i=1; i < 9; i = i + 1)
	{
		lv = GetSpellLevel(self, i + off);
		if (lv)
		{
			if (self.menu == i)
				p2(141, 16);
			else 
				p2(' ', 16);
			red = -30;
			pnum(i);
			red = 0;
			p2(17, ' ');
			PrintSpellName(i + off);
			pad(20);
			p6('L', 'e', 'v', 'e', 'l', 32);
			pnum(lv);
			pad(30);
			newline();
			p6(32, 32 ,32, 'M', 'P', ':');
			pnum(mana_for_spell(i+off,lv));
			rn = spell_range(i+off);
			if (rn != BIG_DISTANCE)
			{
				pad(10);
				p6('R', 'a', 'n', 'g', 'e', ':');
				pnum(floor(rn/10));
			}
			pad(20);
			display_effect(i+off,lv);
			pad(30);
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
	pad(30);
	newline();
	p1(0);

};
void() m_spells1 =
{	
	m_spells(0);
};
void() m_spells2 =
{
	m_spells(8);

};