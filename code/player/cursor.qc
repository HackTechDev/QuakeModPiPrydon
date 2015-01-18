
void() h_cursor =
{
	local vector ang, view;
	local float len;

	if (!self.cursor)
	{
		self.cursor = spawn();
		self.cursor.drawonlytoclient = self;
		setmodel(self.cursor, "progs/cursor.spr"); // ugly temp model
	}
	view = self.rotang;
	view_z = 0;
	if (self.origin != self.testorg)
	{
		ang = vectoangles(self.origin - self.testorg) - view;
		len = vlen(self.origin - self.testorg);
		ang_x = ang_z = 0;
		len = len * -1;
		makevectors(ang);
		self.cursorpos_x = self.cursorpos_x - (v_forward_x * len);
		self.cursorpos_y = self.cursorpos_y + v_forward_y * len;
		//setorigin(self, self.testorg);
	}
	if (self.cursorpos_x > 96)
	{
		self.rotang_z = self.rotang_z + self.cursorpos_x - 96;
		if (self.rotang_z > 256)
			self.rotang_z = 256;
		//self.rotang_x = self.rotang_x + self.cursorpos_x - 96;
		self.cursorpos_x = 96;
	}
	else if (self.cursorpos_x < -96)
	{

		self.rotang_z = self.rotang_z + self.cursorpos_x + 96;
		if (self.rotang_z < 128)
			self.rotang_z = 128;
		//self.rotang_x = self.rotang_x + self.cursorpos_x + 96;
		self.cursorpos_x = -96;
	}
	if (self.cursorpos_y > 96)
	{
		self.rotang_y = self.rotang_y - (self.cursorpos_y - 96);
		self.cursorpos_y = 96;
	}
	else if (self.cursorpos_y < -96)
	{
		self.rotang_y = self.rotang_y - (self.cursorpos_y + 96);
		self.cursorpos_y = -96;
	}
	
};


// DP hack man
.vector movement;

void() SV_PlayerPhysics =
{
	setorigin(self, self.testorg);
	self.cursorpos_x = self.cursorpos_x + self.movement_x / 200;
	self.cursorpos_y = self.cursorpos_y + self.movement_y / 200;
	
	h_cursor();

};