

void() h_camera =
{
	local vector view, org;
	local float dist;

	if (!self.camera)
	{	
		self.camera = spawn();
		self.camera.drawonlytoclient = self;
		self.drawonlytoclient = self;
		self.camera.solid = SOLID_NOT;
		self.camera.movetype = MOVETYPE_NOCLIP;
		setmodel(self.camera, "progs/null.spr");
		msg_entity = self;
		WriteByte(MSG_ONE, SVC_SETVIEW);
		WriteEntity(MSG_ONE, self.camera);
	}
	if (self.camera.enemy)
	{
		org = self.camera.enemy.origin + '0 64 0';
		view_y = 270;
		self.rotang_y = view_y;
		view_x = 0;	
	}
	else if (self.camera.goalentity)
	{
		org = self.camera.goalentity.origin;
		view = vectoangles(self.player.origin - org);
		self.rotang_y = view_y;
		view_x = view_x * -1;
	}
	else
	{
		view = self.rotang;
		view_z = 0;
		dist = self.rotang_z;
	}
	makevectors(view);
	if (self.camera.enemy)
	{
		setorigin(self, org);
		setorigin(self.camera, org);
		
	}
	else if (self.camera.goalentity)
	{
		setorigin(self.camera, org);
		setorigin(self, org);
	}	
	else if (self.player)
	{
		org = self.player.origin + v_forward * (0 - dist);

		if (pointcontents(org) != CONTENT_EMPTY)
		{
			traceline(self.player.origin, org, TRUE, self);
			trace_endpos = trace_endpos + v_forward + trace_plane_normal;
		}
		else
			trace_endpos = org;

		setorigin(self.camera, trace_endpos);
		setorigin(self, trace_endpos);
	}
	

	self.testorg = self.origin;
	msg_entity = self;
	WriteByte (MSG_ONE,10);
	WriteAngle (MSG_ONE,view_x);
	WriteAngle (MSG_ONE,view_y);
	WriteAngle (MSG_ONE,0);

	if (self.cursor)
	{
		view = (v_forward * 96) + (v_up * self.cursorpos_x) + (v_right * self.cursorpos_y);
		traceline(self.origin, self.origin + view, TRUE, self);
		setorigin(self.cursor, trace_endpos);
	}
}