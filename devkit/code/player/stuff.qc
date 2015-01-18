void() h_stuff =
{
	if (self.fadetime < time)
	{
		if (self.fade > 0)
		{
			stuffcmd(self, "v_cshift 0 0 0 ");
			stuffcmd(self, ftos(self.fade));
			stuffcmd(self, "; volume ");
			stuffcmd(self, ftos(1 - (self.fade / 255)));
			stuffcmd(self, "\n");
			
			self.fade = self.fade - 10;
			self.fadetime = time + 0.1;
		}
		else if (self.fade < 0)
		{
			stuffcmd(self, "v_cshift 0 0 0 ");
			stuffcmd(self, ftos(self.fade + 245));
			stuffcmd(self, "; volume ");
			stuffcmd(self, ftos(self.fade / -255));

			stuffcmd(self, "\n");
			
			self.fade = self.fade + 10;
			self.fadetime = time + 0.1;
			if (self.fade == 0)
			{
				if (nextmap)
					changelevel(nextmap);
				else
					self.fade = 250; // fade back in

			}
		}
		else
		{
			self.fade = 0;
			self.fadetime = 0;
		}
	}
	if (self.gotstuff && self.gotstuff < time)
	{
		if (!nomusic)
			if (world.noise2)
				if (boss)
					sound(world, CHAN_VOICE, world.noise2, 1, ATTN_NONE);
		if (lastmap == 1)
			self.fade = 250;
		else
			stuffcmd(self, "v_cshift 0 0 0 0; volume 1\n");
		if (lastmap <= 1)
		stuffcmd(self, "exec prydon.cfg\n");
		self.gotstuff = 0;
		if (fileaccess)
		{
			if (self.sounds)
				if (mplayer)
					openmenu(self, m_load, self);
			self.skill = 0;
		}
	}
}