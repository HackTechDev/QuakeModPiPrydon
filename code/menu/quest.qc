nosave var string q_0 = "Find Ariana in Pendinas, South of\nCapel Curig, and bring her to safety.";
nosave var string q_1 = "Find Cornan in the sewers.";
nosave var string q_2 = "Find the source of the\ninfestation in the sewers and\neliminate it.";
nosave var string q_3 = "Find Ariana in Pendinas, South of\nCapel Curig, and bring her to safety.";
nosave var string q_4 = "Ask Sadoc about the strange barrier.";
nosave var string q_5 = "Locate the hermit Idris in the\nSnowdon mountains.";
nosave var string q_6 = "Find Idris's spell book in the\nmines and return it.";
nosave var string q_7 = "Find Ariana in Pendinas, South of\nCapel Curig, and bring her to safety.";
nosave var string q_8 = "Eliminate the troops occupying Pendinas.";
nosave var string q_9 = "Seek revenge on the Circle of Mages\nhiding in cryptes below the Pendinas chapel.";
nosave var string q_10 = "Journey to Castle Bere.";
nosave var string q_11 = "Kill the abomination that was\nonce your father.";
nosave var string q_12 = "Pass through the Prydon Gate.";
nosave var string q_13 = "Find Ariana's soul in Hades.";
nosave var string q_14 = "Destroy Thanatos.";
nosave var string q_15;


void() m_quest =
{
	local string s, s1;
	local float f;
	local entity e;
	s1 = "";
	
	if (self.menu != 1)
		self.menu = 1;
	self.questlog = story;
	f = story & 15;
	
	if (self.button1)
	{
		self.button1 = 0;
		closemenu(self);
		return;
	}
	if (self.m_refresh > time)
		return;
	if (f == 0)
		s = q_0;
	else if (f == 1)
		s = q_1;
	else if (f == 2)
		s = q_2;
	else if (f == 3)
		s = q_3;
	else if (f == 4)
		s = q_4;
	else if (f == 5)
		s = q_5;
	else if (f == 6)
		s = q_6;
	else if (f == 7)
		s = q_7;
	else if (f == 8)
		s = q_8;
	else if (f == 9)
		s = q_9;
	else if (f == 10)
		s = q_10;
	else if (f == 11)
		s = q_11;
	else if (f == 12)
		s = q_12;
	else if (f == 13)
		s = q_13;
	else if (f == 14)
		s = q_14;
	else if (f == 15)
		s = q_15;
	e = find(world,classname, "quest");
	while(e)
	{
		if ((e.impulse & 240) == (story & 240))
		{
			s1 = e.message;
			break;
		}
		e = find(e, classname, "quest");
	}
	centerprint(self,  "Quest Log\n\<\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\>\n", s, "\n", s1, "\n\<\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\>\n\n\{141}\[\1\] Exit");
};


void() quest =
{
	if (CheckStory(self))
	{
		remove(self);
		return;
	}
	// this simply provides a way for the mapper to override the quest strings
	if (self.impulse == 0)
		q_0 = self.message;
	else if (self.impulse == 1)
		q_1 = self.message;
	else if (self.impulse == 2)
		q_2 = self.message;
	else if (self.impulse == 3)
		q_3 = self.message;
	else if (self.impulse == 4)
		q_4 = self.message;
	else if (self.impulse == 5)
		q_5 = self.message;
	else if (self.impulse == 6)
		q_6 = self.message;
	else if (self.impulse == 7)
		q_7 = self.message;
	else if (self.impulse == 8)
		q_8 = self.message;
	else if (self.impulse == 9)
		q_9 = self.message;
	else if (self.impulse == 10)
		q_10 = self.message;
	else if (self.impulse == 11)
		q_11 = self.message;
	else if (self.impulse == 12)
		q_12 = self.message;
	else if (self.impulse == 13)
		q_13 = self.message;
	else if (self.impulse == 14)
		q_14 = self.message;
	else if (self.impulse == 15)
		q_15 = self.message;
	else
		return;
	remove(self);
	
};