

void() worldspawn = 
{
	if (mapname == "start")
		changelevel("curig2"); // DEMO CHANGE
	localcmd("host_framerate 0\n");
	
	lastmap = decode(serverflags, 3);
	story = decode(serverflags, 1);
	if (nextent(nextent(world)) != world)
		mplayer = 1;
	else
		mplayer = 0;
	if (cvar("temp1") & 1)
		netplay = 1;
	
	// for future tweaking
	monsvalue = decode(serverflags, 2);
	itemvalue = decode(serverflags, 2) * 8 + 5;

	serverflags = recode(serverflags, 3, self.impulse);
	nomusic = cvar("temp1") & 2;
	if (!nomusic)
	{
		if (self.noise)
		{
       			precache_sound (self.noise);
       		 	ambientsound ('-4095 -4095 -4095', self.noise, 1.00, ATTN_NONE);
			ambientsound ('4095 4095 4095', self.noise, 1.00, ATTN_NONE);
       		}
       		if (self.noise2)
		{
			precache_sound(self.noise2);
			precache_sound("music/boss.wav");
		}
	}
	
	LightStyles_setup();
	precaches();
	extend();
};