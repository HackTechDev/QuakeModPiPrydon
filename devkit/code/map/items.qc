
void() item_touch =
{
	if (other == world)
	{
		simplestat(self.items);

		sound(self, CHAN_BODY, itemsound(stat_it), 1, ATTN_NORM);
		self.avelocity = '0 0 0';
		self.angles_z = self.angles_x = 0;
		self.touch = SUB_Null;
		if (self.menu)
			self.action = openitembuy;
		else
			self.action = action_pickup;
	}
	else if (self.flags & FL_ONGROUND)
	{
		if (self.menu)
			self.action = openitembuy;
		else
			self.action = action_pickup;
	}
};

void() item =
{
	self.classname = "item";
	if (self.droprandom)
	{
		self.items = randitem(self.items, itemvalue, 0);
		self.droprandom = 0;
	}
	simplestat(self.items);
	if (!stat_it)
	{
		remove(self);
		return;
	}
	setmodel(self, itemmodel(stat_it));
	self.frame = 0;
	setsize (self, '-16 -16 0', '16 16 5');
	self.flags = FL_ITEM;		// make extra wide
	self.solid = SOLID_TRIGGER;
	self.movetype = MOVETYPE_TOSS;
	self.touch = item_touch;
};

void() shopitem =
{
	if (self.droprandom)
	{
		self.items = randitem(self.items, itemvalue, 0);
		self.droprandom = 0;
	}
	itemstat(self.items);
	self.menu = stat_price; // fixme
	item();
};
void() armoryitem =
{
	self.items = randitem(self.items, itemvalue, 1);
	if (!self.netname)
		self.netname = "wepshop";
	shopitem();
};
void() magicitem =
{
	self.items = randitem(self.items, itemvalue, 2);
	if (!self.netname)
		self.netname = "magshop";
	shopitem();
};

void() questitem =
{
	precache_model(self.model);
	precache_sound(self.noise);
	simplestat(self.items);
	self.items = stat_it;
	
	if(CheckStory(self))
		remove(self);
};