
void(float c1) p1 =
{
	chars = chars + 1;
	WriteChar(MSG_ONE, c1 | red);
};

void(float c1, float c2) p2 =
{
	chars = chars + 2;
	WriteChar(MSG_ONE, c1 | red);
	WriteChar(MSG_ONE, c2 | red);
};

void(float c1, float c2, float c3) p3 =
{
	chars = chars + 3;
	WriteChar(MSG_ONE, c1 | red);
	WriteChar(MSG_ONE, c2 | red);
	WriteChar(MSG_ONE, c3 | red);
};
void(float c1, float c2, float c3, float c4) p4 =
{
	chars = chars + 4;
	WriteChar(MSG_ONE, c1 | red);
	WriteChar(MSG_ONE, c2 | red);
	WriteChar(MSG_ONE, c3 | red);
	WriteChar(MSG_ONE, c4 | red);
};
void(float c1, float c2, float c3, float c4, float c5) p5 =
{
	chars = chars + 5;
	WriteChar(MSG_ONE, c1 | red);
	WriteChar(MSG_ONE, c2 | red);
	WriteChar(MSG_ONE, c3 | red);
	WriteChar(MSG_ONE, c4 | red);
	WriteChar(MSG_ONE, c5 | red);
};
void(float c1, float c2, float c3, float c4, float c5, float c6) p6 =
{
	chars = chars + 6;
	WriteChar(MSG_ONE, c1 | red);
	WriteChar(MSG_ONE, c2 | red);
	WriteChar(MSG_ONE, c3 | red);
	WriteChar(MSG_ONE, c4 | red);
	WriteChar(MSG_ONE, c5 | red);
	WriteChar(MSG_ONE, c6 | red);
};
void(float c1, float c2, float c3, float c4, float c5, float c6, float c7) p7 =
{
	chars = chars + 7;
	WriteChar(MSG_ONE, c1 | red);
	WriteChar(MSG_ONE, c2 | red);
	WriteChar(MSG_ONE, c3 | red);
	WriteChar(MSG_ONE, c4 | red);
	WriteChar(MSG_ONE, c5 | red);
	WriteChar(MSG_ONE, c6 | red);
	WriteChar(MSG_ONE, c7 | red);
};

void(float c1, float c2, float c3, float c4, float c5, float c6, float c7, float c8) p8 =
{
	chars = chars + 8;
	WriteChar(MSG_ONE, c1 | red);
	WriteChar(MSG_ONE, c2 | red);
	WriteChar(MSG_ONE, c3 | red);
	WriteChar(MSG_ONE, c4 | red);
	WriteChar(MSG_ONE, c5 | red);
	WriteChar(MSG_ONE, c6 | red);
	WriteChar(MSG_ONE, c7 | red);
	WriteChar(MSG_ONE, c8 | red);
};

void(vector v) pvstr =
{
	// this is a special print function that
	// only prints non zero chars from a vector
	// which are used for monster names
	
	if (v_x >= 65536)
	{
		WriteChar(MSG_ONE, (v_x / 65536) & 255);
		chars = chars + 1;
	}
	if ((v_x / 256) & 255)
	{
		WriteChar(MSG_ONE, (v_x / 256) & 255);
		chars = chars + 1;
	}
	if (v_x & 255)
	{
		WriteChar(MSG_ONE, v_x & 255);
		chars = chars + 1;
	}
	if (v_y >= 65536)
	{
		WriteChar(MSG_ONE, (v_y / 65536) & 255);
		chars = chars + 1;
	}
	if ((v_y / 256) & 255)
	{
		WriteChar(MSG_ONE, (v_y / 256) & 255);
		chars = chars + 1;
	}
	if (v_y & 255)
	{
		WriteChar(MSG_ONE, v_y & 255);
		chars = chars + 1;
	}
	if (v_z >= 65536)
	{
		WriteChar(MSG_ONE, (v_z / 65536) & 255);
		chars = chars + 1;
	}
	if ((v_z / 256) & 255)
	{
		WriteChar(MSG_ONE, (v_z / 256) & 255);
		chars = chars + 1;
	}
	if (v_z & 255)
	{
		WriteChar(MSG_ONE, v_z & 255);
		chars = chars + 1;
	}
};

void(float num) pnum =
{
	local float f, char;
	if (num < 0)
	{
		WriteChar(MSG_ONE, red + 45);
		chars = chars + 1;
		num = 0 - num;
	}
	f = floor(num / 10);
	num = num - (f * 10);
	if (f)
		pnum(f);
		
	char = 48 + red;
	WriteChar(MSG_ONE, char + num);
	chars = chars + 1;
	return;

};

void(float spc) pad =
{
	while(chars < spc)
	{
		WriteChar(MSG_ONE, 32);
		chars = chars + 1;
	}
};

void() newline =
{
	WriteChar(MSG_ONE, 10);
	chars = 0;
	lines = lines + 1;
	red = 0;
};

void(float ln) padlines =
{
	while(lines < ln)
		newline();
};

void() line =
{
	if (!netplay)
	{
		WriteChar(MSG_ONE, 29);
		chars = 2;
		while(chars < WIDTH)
		{
			WriteChar(MSG_ONE, 30);
			chars = chars + 1;
		}
		WriteChar(MSG_ONE, 31);
	}
	newline();
};

void() pstart =
{
	msg_entity = self;
	WriteChar(MSG_ONE, SVC_CENTERPRINT);
	red = RED_OFF;
	lines = 0;
	chars = 0;
};

void(float percent, float width) progressbar =
{
	local float i, f;
	WriteChar(MSG_ONE, 128);
	i = 0;
	percent = floor(percent * width * 8);
	while(i < width)
	{
		f = percent - (i * 8);
		if (f > 7)
			WriteChar(MSG_ONE, 131);
		else if (f < 1)
			WriteByte (MSG_ONE, 129);
		else
			WriteByte (MSG_ONE, 139 - f);
		 i =i + 1;
	}
	WriteChar(MSG_ONE, 130);
	newline();
};