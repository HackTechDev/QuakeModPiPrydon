void (float it) dropitem =
{
	local entity new, oself;
	if (!it)
		return;

	oself = self;
	new = spawn();
	if (self.player)
		self = self.player;
	setorigin(new, self.origin);
	makevectors(self.angles + self.lip * '0 1 0');
	self.lip = self.lip + 45;
	new.velocity = v_up * 150 + v_forward * 100;
	new.items = it;
	new.avelocity =random() *  '0 300 0' + '0 0 600';
	sound(new, CHAN_BODY, "items/flip.wav", 1, ATTN_NORM);
	self = new;
	item();
	self = oself;
};
 

void() dropallitems =
{
	local float i, it;
	local entity oself;
	oself = self;
	if (self.owner)
		self = self.owner;
	for (i=1; i < TOTAL_SLOTS; i = i + 1)
	{
		if (self.droprandom & pow2(i))
		{
			if (random() > 0.6)
				dropitem(randitem(GetSlot(i), itemvalue + self.value, FALSE));
		}
		else
		{
			it = GetSlot(i);
			if (it)
			{
				Unequip(i, 0);
				dropitem(GetSlot(i));
			}
			SetSlot(i, 0);
		}
	}
	self = oself;
};