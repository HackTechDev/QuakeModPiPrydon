void() m_dialog =
{
	local float r;
	local string s1, s2, s3;
	local entity t, o;
	
	t = self.m_subject._targ;
	o = self;
	self.m_subject.m_subject = self.player;
	
	if (t.message3)
		r = 3;
	else if (t.message2)
		r = 2;
	else if (t.message1)
		r = 1;
	else
		r = 0;
		
	if (r)
	{
		if (self.menu < 1)
			self.menu = 1;
		else if (self.menu > r)
			self.menu = r;
		
		if (self.button1)
		{
			self.button1 = 0;
			self = self.m_subject;
			Trigger(t, self, self, o.menu);
			self = o;
		
		}
	}
	else
		Trigger(t, self, self, 0);
	if (self.m_refresh > time)
		return;
	if (self.menu == 1)
		s1 = "\n\n\{141}\[\1\] ";
	else
		s1 = "\n\n \[\1\] ";
	if (self.menu == 2)
		s2 = "\n\{141}\[\2\] ";
	else
		s2 = "\n \[\2\] ";
	if (self.menu == 3)
		s3 = "\n\{141}\[\3\] ";
	else
		s3 = "\n \[\3\] ";
	if (!r)
		centerprint(self, t.message);
	else if (r==1)
		centerprint(self, t.message, s1, t.message1);
	else if (r == 2)
		centerprint(self, t.message, s1, t.message1, s2, t.message2);
	else if (r == 3)
		centerprint(self, t.message, s1, t.message1, s2, t.message2, s3, t.message3);

};
