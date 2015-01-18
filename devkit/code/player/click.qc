void() h_click =
{
	local vector ang;
	float runaway, ca;
	
	if (self.button0)
	{
		if (self.dbltime == 0)
			self.dbltime = time + 0.5;
		else if (self.dbltime < 0)
		{
			if ((0 - self.dbltime) >= time)
			{
				if (self.player)
					self.player.menu = TRUE; // set speed
			}
			else
				self.dbltime = time;
		}
		ang = normalize(self.cursor.origin - self.origin);
		traceline(self.cursor.origin, self.cursor.origin + ang * 2300, FALSE, self);
		while(trace_plane_normal_z < 0.7 && trace_ent == world)
		{
			traceline(trace_endpos + ang, trace_endpos + ang * 2300, FALSE, self);
			runaway = runaway + 1;
			if (runaway > 10)
				return; // oh, it's just a harmless lil' bunny innit?
		}
		if (self.player)
		{
			if (self.player.think != AnimatePlayer) // doing an attack??
				return; 
			if (trace_ent.team != self.player.team && trace_ent.takedamage)
			{
				if (self.rightarm)
				{
					itemstat(self.rightarm);
					self.player.gotstuff = stat_action;
				}
				else
					self.player.gotstuff = SP_FIGHT_MELEE;
				self.player.goalentity = trace_ent;
				closemenu(self);
			}
			else if (trace_ent.action)
			{
				self.player.gotstuff = SP_ACTIVATE;	
				self.player.goalentity = trace_ent;
			}
			else
			{
				if (!self.wayp)
					self.wayp = spawn();
				
				setorigin(self.wayp, trace_endpos + '0 0 16');
				self.player.goalentity = self.wayp;
				self.player.gotstuff = SP_GOTO;
			}
		}
	}
	else
	{
		if (self.dbltime > 0)
		{
			if (self.dbltime >= time)
				self.dbltime = 0 - (time + 0.5);
			else
				self.dbltime = 0;
		}
		else if (self.dbltime < 0)
		{
			if ((0 - self.dbltime) < time)
				self.dbltime = 0;
		}
	}
	if (self.button2)
	{
		if (self.flags & FL_JUMPRELEASED)
		{
			self.flags = self.flags - (self.flags & FL_JUMPRELEASED);
			if (self.spell)
			{
				ang = normalize(self.cursor.origin - self.origin);
				traceline(self.cursor.origin, self.cursor.origin + ang * 2300, FALSE, self);
				if (self.player)
				{
					if (self.player.think != AnimatePlayer) // doing an attack??
						return; 
					ca = cast_aground(self.spell);
					if (self.spell == SP_TRANSMUTE)
					{
						if (trace_ent.flags & FL_ITEM)
						{
							if (!trace_ent.menu)
							{	
								simplestat(trace_ent.items);
								if (stat_it < IT_GOLD)
								{
									self.player.gotstuff = self.spell;
									self.player.goalentity = trace_ent;
									closemenu(self);
								}
							}
						}
					}
					else if (trace_ent.team != self.player.team && trace_ent.takedamage && !ca)
					{
						self.player.gotstuff = self.spell;
						self.player.goalentity = trace_ent;
						closemenu(self);
					}
					else if (ca)
					{
						if (!self.wayp)
							self.wayp = spawn();
						setorigin(self.wayp, trace_endpos + '0 0 16');
						self.player.goalentity = self.wayp;
						self.player.gotstuff = self.spell;
					}
				}
			}
		}
	}
	else
		self.flags = self.flags | FL_JUMPRELEASED;
};
