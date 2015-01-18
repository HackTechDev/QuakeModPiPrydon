void() mplayer_file_save =
{
	local float h;

	SetChangeParms();
	h = fopen(self.netname, FILE_WRITE);
	if (h < 0)
	{
		prompt(self, "A file error hath occurred", activator, 0);
		Restat();
		return;
	}
	write(h, ftos(parm1));write(h,"\n");
	write(h, ftos(parm2));write(h,"\n");
	write(h, ftos(parm3));write(h,"\n");
	write(h, ftos(parm4));write(h,"\n");
	write(h, ftos(parm5));write(h,"\n");
	write(h, ftos(parm6));write(h,"\n");
	write(h, ftos(parm7));write(h,"\n");
	write(h, ftos(parm8));write(h,"\n");
	write(h, ftos(parm9));write(h,"\n");
	write(h, ftos(parm10));write(h,"\n");
	write(h, ftos(parm11));write(h,"\n");
	write(h, ftos(parm12));write(h,"\n");
	write(h, ftos(parm13));write(h,"\n");
	write(h, ftos(parm14));write(h,"\n");
	write(h, ftos(parm15));write(h,"\n");
	fclose(h);
	bprint(self.netname, "'s character was saved\n");
	
	Restat();
};
void() cast1;

void() mplayer_file_load =
{
	local float h;

	h = fopen(self.netname, FILE_READ);
	if (!h)
	{
		prompt(self, "I could not find thy file", activator, 0);
		return;
	}
	Unstat();
	
	parm1 = stof(read(h));
	parm2 = stof(read(h));
	parm3 = stof(read(h));
	parm4 = stof(read(h));
	parm5 = stof(read(h));
	parm6 = stof(read(h));
	parm7 = stof(read(h));
	parm8 = stof(read(h));
	parm9 = stof(read(h));
	parm10 = stof(read(h));
	parm11 = stof(read(h));
	parm12 = stof(read(h));
	parm13 = stof(read(h));
	parm14 = stof(read(h));
	parm15 = stof(read(h));

	bprint(self.netname, "'s character was loaded\n");
	
	fclose(h);
	DecodeLevelParms();
};

void() m_load =
{
	if (self.menu < 1)
		self.menu = 2;
	else if (self.menu > 2)
		self.menu = 1;
	if (self.button1)
	{
		self.button1 = 0;
		if (self.menu == 1)
			mplayer_file_load();
		closemenu(self);
	}
	if (self.m_refresh > time)
		return;
	if (self.menu == 1)
		centerprint(self, "\{141}\[\1\] Load character\n \[\2\] Continue      \n");
	else
		centerprint(self, " \[\1\] Load character\n\{141}\[\2\] Continue      \n");
};

void() InnSave =
{
	local entity oself;
	oself = self;
	self = activator.m_subject.owner;
	if (mplayer)
	{
		// for now...
		if (!fileaccess)
			prompt(self, "Not available", activator, 0);
		else if (!takeamount(IT_GOLD, 0, 0, 5))
			prompt(self, "You don't have enough gold", activator, 0);
		else
		{
			self.health = self.max_health;
			self.mana = self.max_mana;
			mplayer_file_save();

			closemenu(self);
		}
	}
	else
	{
		if (!takeamount(IT_GOLD, 0, 0, 5))
			prompt(self, "You don't have enough gold", activator, 0);
		else
		{
			self.health = self.max_health;
			self.mana = self.max_mana;
			self.fade = -250;
			if (fileaccess)
				mplayer_file_save();
			closemenu(self);
			nextmap = activator.map;
		}
	}
	self = oself;
};