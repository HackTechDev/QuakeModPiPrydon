

void() m_dead =
{
	
	local float f;

	f = 2;
	
	if (mplayer)
		f = 1;
	if (self.menu < 1)
		self.menu = f;
	else if (self.menu > f)
		self.menu = 1;

	if (self.button1)
	{
		self.button1 = 0;
		if (self.menu == 2)
		{
			closemenu(self);
			self.health = self.max_health;
			// is this really neccasary?
			SetSlot(1, 0);
			SetSlot(2, 0);
			SetSlot(3, 0);
			SetSlot(4, 0);
			SetSlot(5, 0);
			SetSlot(6, 0);
			SetSlot(7, 0);
			SetSlot(8, 0);
			SetChangeParms();
			self.player = world;
			PutClientInServer();
			return;
		}
		else if (mplayer)
		{
			closemenu(self);
			self.health = self.max_health;
			// is this really neccasary?
			SetSlot(1, 0);
			SetSlot(2, 0);
			SetSlot(3, 0);
			SetSlot(4, 0);
			SetSlot(5, 0);
			SetSlot(6, 0);
			SetSlot(7, 0);
			SetSlot(8, 0);
			SetChangeParms();
			self.player = world;
			PutClientInServer();
			return;
		}
		else
		{
			localcmd("restart\n");
		}
	}
	
	if (self.m_refresh >= time)
		return;
	if (mplayer)
	{
		centerprint(self, "You have perished.\n\n\{141}\[\1\] Restart level ");
		
	}
	else
	{
		if (self.menu == 1)
			centerprint(self, "You have perished.\n\n\{141}\[\1\] Restart level\n \[\2\] Naked run    \n");
		else
			centerprint(self, "You have perished.\n\n \[\1\] Restart level\n\{141}\[\2\] Naked run    \n");
	}
};