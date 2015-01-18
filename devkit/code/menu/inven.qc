void (float it, float eq) inven =
{
	pstart();
	itemstat(it);
	PrintItemName();
	newline();
	line();
	
	self.weaponmodel = itemmodel(stat_it);
	self.weaponframe = 1;

	if (!stat_id)
	{
		red = RED_ON;
		p8('U', 'n', 'i', 'd', 'e', 'n', 't', 'i');
		p4('f', 'i', 'e', 'd');
		newline();
		line();
		return;
	}
	if ((stat_loc & (DURABILITY | STACKABLE)))
	{
		if (stat_dur == 0)
			red = 128;
		// stackable items have quantity
		if (stat_loc & STACKABLE)
		{
			p8 ('Q', 'u', 'a', 'n', 't', 'i', 't', 'y');
			p1(' ');
		}
		else
		{
			p8 ('D', 'u', 'r', 'a', 'b', 'i', 'l', 'i');
			p3 ('t', 'y', ' ');
		}
	
		pnum(stat_dur);
		p1('/');
		pnum(stat_max_dur);
		newline();
	}
	else if (stat_spec & INDESTRUCTIBLE)
	{
		p8('I', 'n', 'd', 'e', 's', 't', 'r', 'u');
		p6('c', 't', 'a', 'b', 'l', 'e');
		newline();
	}
	if ((stat_loc & TWO_HAND) == TWO_HAND)
	{
		p8('T', 'w', 'o', ' ', 'H', 'a', 'n', 'd');
		p2('e', 'd');
		newline();
	}
	if (eq && (stat_loc & EQUIPABLE))
	{
		p8('E', 'q', 'u', 'i', 'p', 'p', 'e', 'd');
		p2(':', ' ');
		if (eq == 1)
			p2('N', 'O');
		else
			p3('Y', 'E', 'S'); 
		newline();
	
	}
	if (stat_def)
	{
		p8('D', 'e', 'f', 'e', 'n', 's', 'e', ' ');
		pnum(stat_def);
		newline();
	}
	if (stat_daml)
	{
		pnum(stat_daml);
		if (stat_dama)
		{
			p4(' ', 't', 'o', ' ');
			pnum(stat_daml+stat_dama);
		}
		p7(' ', 'D', 'a', 'm', 'a', 'g', 'e');
		newline();
	}
	if (stat_tohit)
	{
		pnum(stat_tohit);
		p8('%', ' ', 'T', 'o', ' ', 'h', 'i', 't');
		newline();
	}
	if (stat_dodge)
	{
		pnum(stat_dodge);
		p7('%', ' ', 'D', 'o', 'd', 'g', 'e');
		newline();
	}
	if (stat_req_str)
	{

		if (self.str < stat_req_str)
			red = RED_ON;
		p8('R', 'e', 'q', 'u', 'i', 'r', 'e', 's');
		p1(' ');
		pnum(stat_req_str);
		p8(' ', 'S', 't', 'r', 'e', 'n', 'g', 't');
		p1('h');
		newline();
	}

	if (stat_req_dex)
	{
		if (self.dex < stat_req_dex)
			red = RED_ON;
		p8('R', 'e', 'q', 'u', 'i', 'r', 'e', 's');
		p1(' ');
		pnum(stat_req_dex);
		p8(' ', 'D', 'e', 'x', 't', 'e', 'r', 'i');
		p2('t', 'y');
		newline();
	}
	if (stat_req_mag)
	{
		if (self.mag < stat_req_mag)
			red = RED_ON;
		p8('R', 'e', 'q', 'u', 'i', 'r', 'e', 's');
		p1(' ');
		pnum(stat_req_mag);
		p8(' ', 'I', 'n', 't', 'e', 'l', 'l', 'i');
		p5('g', 'e', 'n', 'c', 'e');
		newline();
	}
	if (stat_req_vit)
	{
		if (self.vit < stat_req_vit)
			red = RED_ON;
		p8('R', 'e', 'q', 'u', 'i', 'r', 'e', 's');
		p1(' ');
		pnum(stat_req_vit);
		p8(' ', 'V', 'i', 't', 'a', 'l', 'i', 't');
		p1('y');
		newline();
	}
	if (stat_req_luck)
	{
		if (self.luck < stat_req_luck)
			red = RED_ON;
		p8('R', 'e', 'q', 'u', 'i', 'r', 'e', 's');
		p1(' ');
		pnum(stat_req_luck);
		p5(' ', 'L', 'u', 'c', 'k');
		newline();
	}
	if (stat_req_agil)
	{
		if (self.agil < stat_req_agil)
			red = RED_ON;
		p8('R', 'e', 'q', 'u', 'i', 'r', 'e', 's');
		p1(' ');
		pnum(stat_req_agil);
		p8(' ', 'A', 'g', 'i', 'l', 'i', 't', 'y');
		newline();
	}
	if (stat_req_lvl)
	{
		if (self.lvl < stat_req_lvl)
			red = RED_ON;
		p8('M', 'u', 's', 't', ' ', 'b', 'e', ' ');
		p6('L', 'e', 'v', 'e', 'l', ' ');
		pnum(stat_req_lvl);
		newline();
	}
	if (stat_toall)
	{
		p5('A', 'd', 'd', 's', ' ');
		pnum(stat_toall);
		p8(' ', 't', 'o', ' ', 'a', 'l', 'l', ' ');
		p8('a', 't', 't', 'r', 'i', 'b', 'u', 't');
		p2('e', 's');
		newline();
	}
	if (stat_str)
	{
		p5('A', 'd', 'd', 's', ' ');
		pnum(stat_str);
		p8(' ', 'S', 't', 'r', 'e', 'n', 'g', 't');
		p1('h');
		newline();
	}
	if (stat_dex)
	{
		p5('A', 'd', 'd', 's', ' ');
		pnum(stat_dex);
		p8(' ', 'D', 'e', 'x', 't', 'e', 'r', 'i');
		p2('t', 'y');
		newline();
	}
	if (stat_mag)
	{
		p5('A', 'd', 'd', 's', ' ');
		pnum(stat_mag);
		p8(' ', 'I', 'n', 't', 'e', 'l', 'l', 'i');
		p5('g', 'e', 'n', 'c', 'e');
		newline();
	}
	if (stat_vit)
	{
		p5('A', 'd', 'd', 's', ' ');
		pnum(stat_vit);
		p8(' ', 'V', 'i', 't', 'a', 'l', 'i', 't');
		p1('y');
		newline();
	}
	if (stat_luck)
	{
		p5('A', 'd', 'd', 's', ' ');
		pnum(stat_luck);
		p5(' ', 'L', 'u', 'c', 'k');
		newline();
	}
	if (stat_agil)
	{
		p5('A', 'd', 'd', 's', ' ');
		pnum(stat_agil);
		p8(' ', 'A', 'g', 'i', 'l', 'i', 't', 'y');
		newline();
	}
	if (stat_mana)
	{
		p5('A', 'd', 'd', 's', ' ');
		pnum(stat_mana);
		p8(' ', 't', 'o', ' ', 'm', 'a', 'n', 'a');
		newline();
	}
	if (stat_health)
	{
		p5('A', 'd', 'd', 's', ' ');
		pnum(stat_health);
		p8(' ', 't', 'o', ' ', 'h', 'e', 'a', 'l');
		p2('t', 'h');
		newline();
	}
	if (stat_fire)
	{
		p7('H', 'i', 't', ' ', 'A', 'd', 'd');
		p2('s', ' ');
		pnum(stat_fire/2);
		p1('-');
		pnum(stat_fire);
		
		p8(' ', 'f', 'i', 'r', 'e', ' ', 'd', 'a');
		p4('m', 'a', 'g', 'e');
		newline();
	
	}
	if (stat_poison)
	{
		p7('H', 'i', 't', ' ', 'A', 'd', 'd');
		p2('s', ' ');
		pnum(stat_poison);
		p8(' ', 'p', 'o', 'i', 's', 'o', 'n', ' ');
		p6('d', 'a', 'm', 'a', 'g', 'e');
		newline();
	}
	if (stat_lit)
	{
		p7('H', 'i', 't', ' ', 'A', 'd', 'd');
		p4('s', ' ', '1', '-');
		pnum(stat_lit);
		p8(' ', 'l', 'i', 'g', 'h', 't', 'i', 'n');
		p8('g', ' ', 'd', 'a', 'm', 'a', 'g', 'e');
		newline();
	}
	if (stat_spell)
	{
		if (GetSpellLevel(self, stat_spell) >= 7)
			red = RED_ON;
		if (stat_loc & SPELL)
		{
			p8('C', 'a', 's', 't', 's', ' ', 'l', 'e');
			p6('v', 'e', 'l', ' ', '7', ' ');
		}
		else
		{
			p8('A', 'd', 'd', 's', ' ', '1', ' ', 't');
			p2('o', ' ');
		}
		PrintSpellName(stat_spell);
		newline();
	}
	if (stat_spec)
	{
		if (stat_spec & SPEED)
		{
			p8('I', 'n', 'c', 'r', 'e', 'a', 's', 'e');
			p8('d', ' ', 'a', 't', 't', 'a', 'c', 'k');
			p6(' ', 's', 'p', 'e', 'e', 'd');
			newline();
		}
		if (stat_spec & STEAL_LIFE)
		{
			p8('H', 'i', 't', ' ', 's', 't', 'e', 'a');
			p7('l', 's', ' ', 'l', 'i', 'f', 'e');
			newline();
		}
		if (stat_spec & REGEN_LIFE)
		{
			p8('R', 'e', 'p', 'l', 'e', 'n', 'i', 's');
			p8('h', 'e', 's', ' ', 'L', 'i', 'f', 'e');
			newline();
		}
		if (stat_spec & STEAL_MANA)
		{
			p8('H', 'i', 't', ' ', 's', 't', 'e', 'a');
			p7('l', 's', ' ', 'M', 'a', 'n', 'a');
			newline();
		}
		if (stat_spec & KNOCKBACK)
		{
			p8('H', 'i', 't', ' ', 'k', 'n', 'o', 'c');
			p8('k', 's', ' ', 't', 'a', 'r', 'g', 'e');
			p6('t', ' ', 'b', 'a', 'c', 'k');
			newline();
		}
		if (stat_spec & DAMATTACKER)
		{
			p8('A', 't', 't', 'a', 'c', 'k', 'e', 'r');
			p8(' ', 't', 'a', 'k', 'e', 's', ' ', 'd');
			p5('a', 'm', 'a', 'g', 'e');
			newline();
		}
	}
	line();
};

void() setitems =
{
	local float g, i;
	g = 0;
	
	for(i = 1; i<9; i =i + 1)
	{
		if (GetSlot(i))
			g = g | pow2(i);
	}
	self.items = g;
};


void() m_inven =
{
	local float r, it, f;
	it = GetSlot(root2(self.weapon));

	if (self.menu < 1)
		self.menu = 5;
	else if (self.menu > 5)
		self.menu = 1;

	r = self.menu;

	if (self.button1)
	{
		self.button1 = 0;
		if (r == 1)
		{
			itemstat(it);
			if (stat_loc & EQUIPABLE)
			{
				if (self.equip & self.weapon)
					Unequip(root2(self.weapon), 1);
				else if (!Equip(root2(self.weapon)))
					sprint(self, "Can't!\n");
				// fixme
				// 	go errrn!
			}
			if (stat_loc & USABLE)
				Use(root2(self.weapon));
		}
		else if (r == 2)
		{
			f = root2(self.weapon);
			f = f + 1;
			if (f > 8)
				f = 1;
			self.weapon = pow2(f);
			it = GetSlot(f);
		}
		else if (r == 3)
		{
			f = root2(self.weapon);
			f = f - 1;
			if (f < 1)
				f = 8;
			self.weapon = pow2(f);
			it = GetSlot(f);
		}
		else if (r == 4)
		{
			f = root2(self.weapon);
			Unequip(f, 1); // if equipped
			dropitem(it);
			SetSlot(f, 0);
			it = 0;
		}
		else if (r == 5)
		{
			closemenu(self);
			return;
		}
	}
	if (self.m_refresh < time)
	{
		inven(it, fabs(self.equip & self.weapon) + 1);
		padlines(9);
		if (stat_loc & EQUIPABLE)
		{
			if (self.equip & self.weapon)
			{
				if (self.menu == 1)
					WriteString(MSG_ONE, "\n\{141}\[\1\] Unequip      \n \[\2\] Next Item    \n \[\3\] Previous Item\n \[\4\] Drop         \n \[\5\] Exit         \n");
				else if (self.menu == 2)
					WriteString(MSG_ONE, "\n \[\1\] Unequip      \n\{141}\[\2\] Next Item    \n \[\3\] Previous Item\n \[\4\] Drop         \n \[\5\] Exit         \n");
				else if (self.menu == 3)
					WriteString(MSG_ONE, "\n \[\1\] Unequip      \n \[\2\] Next Item    \n\{141}\[\3\] Previous Item\n \[\4\] Drop         \n \[\5\] Exit         \n");
				else if (self.menu == 4)
					WriteString(MSG_ONE, "\n \[\1\] Unequip      \n \[\2\] Next Item    \n \[\3\] Previous Item\n\{141}\[\4\] Drop         \n \[\5\] Exit         \n");
				else if (self.menu == 5)
					WriteString(MSG_ONE, "\n \[\1\] Unequip      \n \[\2\] Next Item    \n \[\3\] Previous Item\n \[\4\] Drop         \n\{141}\[\5\] Exit         \n");
			}
			else
			{
				if (self.menu == 1)
					WriteString(MSG_ONE, "\n\{141}\[\1\] Equip        \n \[\2\] Next Item    \n \[\3\] Previous Item\n \[\4\] Drop         \n \[\5\] Exit         \n");
				else if (self.menu == 2)
					WriteString(MSG_ONE, "\n \[\1\] Equip        \n\{141}\[\2\] Next Item    \n \[\3\] Previous Item\n \[\4\] Drop         \n \[\5\] Exit         \n");
				else if (self.menu == 3)
					WriteString(MSG_ONE, "\n \[\1\] Equip        \n \[\2\] Next Item    \n\{141}\[\3\] Previous Item\n \[\4\] Drop         \n \[\5\] Exit         \n");
				else if (self.menu == 4)
					WriteString(MSG_ONE, "\n \[\1\] Equip        \n \[\2\] Next Item    \n \[\3\] Previous Item\n\{141}\[\4\] Drop         \n \[\5\] Exit         \n");
				else if (self.menu == 5)
					WriteString(MSG_ONE, "\n \[\1\] Equip        \n \[\2\] Next Item    \n \[\3\] Previous Item\n \[\4\] Drop         \n\{141}\[\5\] Exit         \n");
			}			
		}
		else
		{
			if (self.menu == 1)
				WriteString(MSG_ONE, "\n\{141}\[\1\] Use          \n \[\2\] Next Item    \n \[\3\] Previous Item\n \[\4\] Drop         \n \[\5\] Exit         \n");
			else if (self.menu == 2)
				WriteString(MSG_ONE, "\n \[\1\] Use          \n\{141}\[\2\] Next Item    \n \[\3\] Previous Item\n \[\4\] Drop         \n \[\5\] Exit         \n");
			else if (self.menu == 3)
				WriteString(MSG_ONE, "\n \[\1\] Use          \n \[\2\] Next Item    \n\{141}\[\3\] Previous Item\n \[\4\] Drop         \n \[\5\] Exit         \n");
			else if (self.menu == 4)
				WriteString(MSG_ONE, "\n \[\1\] Use          \n \[\2\] Next Item    \n \[\3\] Previous Item\n\{141}\[\4\] Drop         \n \[\5\] Exit         \n");
			else if (self.menu == 5)
				WriteString(MSG_ONE, "\n \[\1\] Use          \n \[\2\] Next Item    \n \[\3\] Previous Item\n \[\4\] Drop         \n\{141}\[\5\] Exit         \n");
		}
	}
};

// \[\1\] Equip        \n \[\2\] Next Item    \n \[\3\] Previous Item\n \[\4\] Drop         \n \[\5\] Exit         \n
// \[\1\] Use          \n \[\2\] Next Item    \n \[\3\] Previous Item\n \[\4\] Drop         \n \[\5\] Exit         \n
// \[\1\] Next Item    \n \[\2\] Previous Item\n \[\3\] Drop         \n \[\4\] Exit         \n