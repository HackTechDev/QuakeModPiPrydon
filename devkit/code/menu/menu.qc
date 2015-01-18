/*
Menus

main menu (for DC users mostly)
- magic
- inventory slots
- stats
- exit
inventory slots 1-8
- drop
- equip / use / buy / pickup
- repair (in town)

magic menu
(list of spells, you select one then go back to the game)

stats
(list of stats, can increase some on level up)


*/

void(entity who, void() menufunc, entity subj) openmenu =
{
	if (who.owner)
		who = who.owner;
	if (who.classname != "player")
		return;
	who.m_subject = subj;
	who.menu = TRUE;
	who.m_refresh = 0;
	who.weaponmodel = "";
	who.m_func = menufunc;
	stuffcmd(who, "m_on\n");
};

void(entity who) closemenu =
{
	if (who.classname != "player")
		return;
	who.m_refresh = 0;
	who.m_func = SUB_Null;
	if (who.m_subject.m_subject == who.player)
	{
		// evil hack brought over from npc.qc
		npc_gettopic(who.m_subject);
		who.m_subject.m_subject = world;
	}
	who.m_subject = world;
	who.menu = 0;
	stuffcmd(who, "m_off\n");
	centerprint(who, "");
	who.weaponmodel = "";
	who.m_expire = 0;
};

void() m_prompt =
{
	if (self.m_refresh < time)
		centerprint(self, self.message);
};

void(entity who, string text, entity subj, float expire) prompt =
{
	openmenu(who, m_prompt, subj);
	if (expire)
		who.m_expire = time + expire;
	who.message = text;
};

string l_alis = "\
My Dearest Alis,                       \n\n\
It's probably a shock to get a letter  \n\
from me, as it must seem I died years  \n\
ago. Recently a gateway was created    \n\
that granted access to this world.     \n\
I must urge you to leave Capel Curig,  \n\
it will not be safe for much longer.   \n\
                                 Ramuka\n";

void() m_bigprompt =
{
	if (self.m_refresh < time)
	{
		// big ol hack
		if (self.m_subject.message == "l_alis")
			centerprint(self, l_alis);
		else
			centerprint(self, self.m_subject.message, self.m_subject.message1,
			self.m_subject.message2, self.m_subject.message3);
	}
};

void() m_menu =
{
	local vector v;
	if (!self.menu)
		return;
	// check menu dismissal conditions
	if (self.m_subject)
	{
		if (self.m_subject != self)
		{
			if (self.m_subject.origin != '0 0 0')
			{
				v = self.player.origin - self.m_subject.origin;
				v_z = 0;
				if (vlen(v) > 60)
					self.menu = 0;
			}
		}
	}
	else
		self.menu = 0;
	if (self.m_expire)
		if (self.m_expire < time)
			self.menu = 0;
	if (self.menu)
	{
		if (self.impulse == 10)
		{
			self.menu = self.menu - 1;
			self.m_refresh = 0;
			self.impulse = -1;
		}
		else if (self.impulse == 12)
		{
			self.menu = self.menu + 1;
			self.m_refresh = 0;
			self.impulse = 0;
		}
		else if ((self.impulse > 0) && (self.impulse < 10))
		{
			self.menu = self.impulse;
			self.m_refresh = 0;
			self.impulse = 0;
			self.button1 = 1;	
		}
		if (self.button1)
		{
			self.m_refresh = 0;
		}
		
		self.m_func();
		if (self.menu)
		{
			if (self.m_refresh)
			{
				
				if (self.m_refresh < time)
				{
					self.m_refresh = time + 49;

				}
			}
			else
				self.m_refresh = 1;
		}
		
	}
	
	if (!self.menu)
		closemenu(self);
};
