
/*
=============
SUB_CalcAngleMove

calculate self.avelocity and self.nextthink to reach destangle from
self.angles rotating 

The calling function should make sure self.think is valid
===============

*/


void() SUB_CalcAngleMoveDone;


void(vector destangle, float tspeed, void() func) SUB_CalcAngleMove =
{
local vector	destdelta;
local float		len, traveltime;

	if (!tspeed)
		objerror("No speed is defined!");
		
// set destdelta to the vector needed to move
	destdelta = destangle - self.angles;
	
// calculate length of vector
	len = vlen (destdelta);
	
// divide by speed to get time to reach dest
	traveltime = len / tspeed;

// set nextthink to trigger a think when dest is reached
	self.nextthink = self.ltime + traveltime;

// scale the destdelta vector by the time spent traveling to get velocity
	self.avelocity = destdelta * (1 / traveltime);
	
	self.think1 = func;
	self.finalangle = destangle;
	self.think = SUB_CalcAngleMoveDone;
};

/*
============
After rotating, set angle to exact final angle
============
*/
void() SUB_CalcAngleMoveDone =
{
	self.angles = self.finalangle;
	self.avelocity = '0 0 0';
	self.nextthink = -1;
	if (self.think1)
		self.think1();
};

void() door2_closed =
{
	self.enemy.style = STATE_TOP;
	self.enemy.solid = SOLID_BBOX;
	sound(self, CHAN_BODY, self.noise2, 1, ATTN_NORM);
	setorigin(self.enemy, self.enemy.origin);
};

void() door2_close =
{
	if (self.style != STATE_BOTTOM)
		return;
	self.style = STATE_UP;
	self = self.owner;
	self.ltime = time;
	sound(self, CHAN_BODY, self.noise1, 1, ATTN_NORM);
	SUB_CalcAngleMove(self.dest1, self.speed, door2_closed);
};

void() door2_opened =
{
	self.enemy.style = STATE_BOTTOM;
	self.enemy.solid = SOLID_TRIGGER;
	setorigin(self.enemy, self.enemy.origin);
	self.enemy.think = door2_close;
	sound(self, CHAN_BODY, self.noise2, 1, ATTN_NORM);
	self.enemy.nextthink = time + self.wait;
};

void() door2_open =
{
	self = self.enemy;
	if (self.style != STATE_TOP)
		return;
	if (CheckStory(self))
	{
		if (self.attack_finished < time)
		{
			sound(self, CHAN_AUTO, "misc/locked.wav", 1, ATTN_NORM);
			sprint(other.owner, "locked\n");
			self.attack_finished = time + 1;
		}
		return;
	}
	self.style = STATE_DOWN;
	self = self.owner;
	self.ltime = time;
	sound(self, CHAN_BODY, self.noise1, 1, ATTN_NORM);
	SUB_CalcAngleMove(self.mangle, self.speed, door2_opened);

};


void() door2_touch =
{

// hmmm?
	if (CheckStory(self))
		if (other.classname == "npc")
			door2_open();

};

void() door2_init =
{
	local entity t;
	t = find(world, target, self.targetname);
	self.enemy = t;
	t.owner = self;
};

void() func_door2 =
{
	if (!self.noise1)
		self.noise1 = "doors/door1.wav";
	if (!self.noise2)
		self.noise2 = "doors/close1.wav";
	precache_sound(self.noise1);
	precache_sound(self.noise2);
	self.angles = '0 0 0'; // test?
	self.classname = "func_door2";
	self.solid = SOLID_NOT;
	self.movetype = MOVETYPE_FLY;
	setmodel (self,self.model);
	setsize(self, self.mins, self.maxs);
	if (!self.speed)
		self.speed = 80;
	if (self.mangle == '0 0 0')
		self.mangle_y = 90;
	if (!self.wait)
		self.wait = 5;
	self.use = door2_open;
	self.dest1 = self.angles;
	self.think = door2_init;
	self.nextthink = time;
};



void() rotate_object =
{
	func_door2();
};
void() func_blockwall =
{
	if(self.story_min || self.story_max)
		precache_sound ("misc/locked.wav");
	self.enemy = self;
	self.angles = '0 0 0';
	self.movetype = MOVETYPE_NONE;	// so it doesn't get pushed by anything
	self.solid = SOLID_BBOX;
	setmodel (self, self.model);
	self.modelindex = 0;
	if (self.targetname)
		self.use = door2_open;
	else
	{
		self.action = door2_open;
		self.touch = door2_touch;
	}
	
	if (!self.netname)
		self.netname = "door";
};