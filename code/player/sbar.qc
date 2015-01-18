void() h_sbar =
{

	local vector ang;
	local float f;
	
	if (self.menu)
		return;
		
	ang = normalize(self.cursor.origin - self.origin) * 2300;
	traceline(self.cursor.origin, self.cursor.origin + ang, FALSE, self);
	if (!trace_ent)
		if (!self.ptd)
			if (self.questlog == story)
				if (!self.sbarsub)
					if (!self.spell)
							return;


	if (trace_ent != self.sbarsub)
	{
		if (self.sbarsub)
			self.sbarsub.effects = self.sbarsub.effects - (self.sbarsub.effects & EF_FULLBRIGHT);
		self.sbarsub = trace_ent;
	}
	else if (self.m_refresh > time)
		return;
	self.m_refresh = time + 1;

	pstart();
	padlines(11);
	if (self.questlog != story)
	{
		p8('Q', 'u', 'e', 's', 't', ' ', 'U', 'p');
		p5('d', 'a', 't', 'e', 10);
	}
	if (self.ptd)
	{
		p8('N', 'e', 'w', ' ', 'S', 't', 'a', 't');
		p2('s', 10);

	}
	if (self.spell)
	{

		p7('S', 'p', 'e', 'l', 'l', ':', ' ');
		PrintSpellName(self.spell);
		newline();
	}
	
	if (trace_ent.classname == "item")
	{
		simplestat(trace_ent.items);
		PrintItemName();
		p1(0);
	}
	else if (trace_ent && trace_ent == boss)
	{	
		progressbar(boss.health/boss.max_health, 15);
		WriteString(MSG_ONE, trace_ent.owner.netname);
	}
	else if (trace_ent.classname == "monster" || trace_ent.ai & 8)
	{
		if (trace_ent.finalangle_x)
		{
			PrintMonsterName(trace_ent);
			newline();
			p7('H', 'e', 'a', 'l', 't', 'h', ':');
			pnum(trace_ent.health);
			p1('/');
			pnum(trace_ent.max_health);
			p1(0);
		}
		else
		{
			p7('H', 'e', 'a', 'l', 't', 'h', ':');
			pnum(trace_ent.health);
			p1('/');
			pnum(trace_ent.max_health);
			newline();
			WriteString(MSG_ONE, trace_ent.netname);
		}
	}
	else if (trace_ent.classname == "dummy")
	{
		WriteString(MSG_ONE, trace_ent.owner.netname);
	}

	else if (trace_ent.action)
	{
		WriteString(MSG_ONE, trace_ent.netname);
	}
	else 
		p1(0);
		
	if (!mplayer)
		if (trace_ent)
			trace_ent.effects = trace_ent.effects | EF_FULLBRIGHT;
			
};
