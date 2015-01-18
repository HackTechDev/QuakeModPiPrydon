
void() opensign =
{
	openmenu(other, m_bigprompt, self);
};
void() donothing =
{

};

void () sign_use =
{
	openmenu(activator.owner, m_bigprompt, self);
};
void() sign =
{
	if (CheckStory(self))
	{
		remove(self);
		return;
	}
	
	if (!self.netname)
		self.netname = "A Sign";
	setmodel(self, self.model);
	self.movetype = MOVETYPE_NONE;
	self.solid = SOLID_BBOX;
	self.use = sign_use;
	setorigin(self, self.origin);
	if (self.message)
		self.action = opensign;
	else
		self.action = donothing;
};


void() openbook =
{
	if (self.attack_finished > time)
		return;
	sound(self, CHAN_AUTO, "items/scroll.wav", 1, ATTN_NORM);
	openmenu(other, m_bigprompt, self);
	self.attack_finished = time + 1;
};

void() storybook =
{
	if (CheckStory(self))
	{
		remove(self);
		return;
	}

	if (!self.netname)
		self.netname = "A Book";
	if (!self.model)
		self.model = "progs/book.mdl";
	setmodel(self, self.model);
	self.frame = 0;
	setsize (self, '-16 -16 0', '16 16 5');
	self.flags = FL_ITEM;		// make extra wide
	self.solid = SOLID_BBOX;
	self.movetype = MOVETYPE_TOSS;
	self.action = openbook;
	
};
