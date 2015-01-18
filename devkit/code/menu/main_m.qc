void() m_mainmenu =
{
	if (self.menu < 1)
		self.menu = 7;
	else if (self.menu > 7)
		self.menu = 1;

	if (self.button1)
	{
		self.button1 = 0;
		if (self.menu == 7)
		{
			closemenu(self);
			return;
		}
		else if (self.menu == 1)
		{
			openmenu(self, m_stats, self);
			return;
		}
		else if (self.menu == 2)
		{
			openmenu(self, m_invenlst, self);
			return;
		}
		else if (self.menu == 3)
		{
			openmenu(self, m_spells1, self);
		}
		else if (self.menu == 4)
		{
			openmenu(self, m_spells2, self);
		}
		else if (self.menu == 5)
		{
			openmenu(self, m_quest, self);
		}
		else if (self.menu == 6)
		{
			openmenu(self, m_console, self);
			self.menu = 97;
			return;
		}
	}
	
	if (self.m_refresh >= time)
		return;
		
	if (self.menu == 1)
		centerprint(self, "\{141}\[\1\] Stats    \n \[\2\] Inventory\n \[\3\] Spells 1 \n \[\4\] Spells 2 \n \[\5\] Quest Log\n \[\6\] Console  \n \[\7\] Exit     \n");
	else if (self.menu == 2)
		centerprint(self, " \[\1\] Stats    \n\{141}\[\2\] Inventory\n \[\3\] Spells 1 \n \[\4\] Spells 2 \n \[\5\] Quest Log\n \[\6\] Console  \n \[\7\] Exit     \n");
	else if (self.menu == 3)
		centerprint(self, " \[\1\] Stats    \n \[\2\] Inventory\n\{141}\[\3\] Spells 1 \n \[\4\] Spells 2 \n \[\5\] Quest Log\n \[\6\] Console  \n \[\7\] Exit     \n");
	else if (self.menu == 4)
		centerprint(self, " \[\1\] Stats    \n \[\2\] Inventory\n \[\3\] Spells 1 \n\{141}\[\4\] Spells 2 \n \[\5\] Quest Log\n \[\6\] Console  \n \[\7\] Exit     \n");
	else if (self.menu == 5)
		centerprint(self, " \[\1\] Stats    \n \[\2\] Inventory\n \[\3\] Spells 1 \n \[\4\] Spells 2 \n\{141}\[\5\] Quest Log\n \[\6\] Console  \n \[\7\] Exit     \n");
	else if (self.menu == 6)
		centerprint(self, " \[\1\] Stats    \n \[\2\] Inventory\n \[\3\] Spells 1 \n \[\4\] Spells 2 \n \[\5\] Quest Log\n\{141}\[\6\] Console  \n \[\7\] Exit     \n");
	else if (self.menu == 7)
		centerprint(self, " \[\1\] Stats    \n \[\2\] Inventory\n \[\3\] Spells 1 \n \[\4\] Spells 2 \n \[\5\] Quest Log\n \[\6\] Console  \n\{141}\[\7\] Exit     \n");

/*
 \[\1\] Stats    \n
 \[\2\] Inventory\n
 \[\3\] Spells 1 \n
 \[\4\] Spells 2 \n
 \[\5\] Quest Log\n
 \[\5\] Console  \n
 \[\6\] Exit     \n
*/

};