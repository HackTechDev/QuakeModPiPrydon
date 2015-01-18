// create an inventory spot
// we do this at -3900 z/x, hopefully the mapper won't build that high up.

void() dummy_sync =
{
	self.frame = self.goalentity.frame;
	self.nextthink = time + 0.1;
	self.angles_y = self.angles_y + self.gotstuff;
	if (self.angles_y <= 45)
		self.gotstuff = 1;
	else if (self.angles_y >  135)
		self.gotstuff = -1;
	else if (!self.gotstuff)
		self.gotstuff = 1; // BLAH
	
};

entity() getinvspot =
{
	local float i;
	local entity inv;
	local vector org;
	
	while(active_inv & pow2(i))
		i = i + 1;
	active_inv = active_inv | pow2(i);
	org_z = -3968;
	org_x = -3968;
	org_y = -3968 + i * 384;
	inv = spawn();
	setmodel(inv, "progs/b_inv.bsp");
	setorigin(inv, org);
	inv.solid = SOLID_BSP;
	inv.movetype = MOVETYPE_PUSH;
	inv.player = spawn();
	setmodel(inv.player, self.player.model);
	inv.player.skin = self.player.skin;
	setorigin(inv.player, inv.origin + '0 -96 32');
	inv.player.angles = '0 90 0';
	inv.player.think = dummy_sync;
	inv.player.nextthink = time + 0.1;
	inv.player.drawonlytoclient = self;
	inv.player.goalentity = self.player;
	
	return inv;
};