
float(float num) sqrt =
{
	local float bit, guess, f;
	
	bit = 65536;
	
	do
	{
		f = guess | bit;
		if ((f * f) <= num)
			guess = f;
		bit = bit * 0.5;
	}
	while (bit >= 1);
	return guess;
};


float(float num, float exponent) pow =
{
	local float r;
	r = 1;
	if (exponent < 0)
	{
		while(exponent)
		{
			exponent = exponent + 1;
			r = r / num;
		}
	}
	else
	{
		while(exponent)
		{
			exponent = exponent - 1;
			r = r  * num;
		}
	}
	return r;
};

float(float f) fixbyte =
{
	f = rint(f);
	if (f > 255)
		f = 255;
	else if (f < 0)
		f = 0;
	return f;
};

// no bit 24!! FIXME! For now use low values for 1st parm :)
float(float s1, float s2, float s3) encode =
{
	return fixbyte(s1) * 65536 + fixbyte(s2) * 256 + fixbyte(s3);
};
float(float parm, float which) decode =
{
	if (which == 1)
		return (parm / 65536) & 255;
	else if (which == 2)
		return (parm / 256) & 255;
	else
		return parm & 255;
};
float (float parm, float which, float set) recode =
{
	set = fixbyte(set);
	if (which == 1)
		return parm & 65535 | (set * 65536);
	else if (which == 2)
		return parm & 16711935 | (set * 256);
	else if (which == 3)
		return parm & 16776960 | set;
};

// handles powers of 2 from 0 to 7 (biased by +1)
// used for my bitflag functions (equip, randomdrops, etc)
// TODO: remove the +1 bias some day to make this more elegant
float(float f) pow2=
{
	if (f == 1)
		return 1;
	else if (f == 2)
		return 2;
	else if (f == 3)
		return 4;
	else if (f == 4)
		return 8;
	else if (f == 5)
		return 16;
	else if (f == 6)
		return 32;
	else if (f == 7)
		return 64;
	else if (f == 8)
		return 128;
	return 0;
};

float(float f) root2=
{
	if (f == 1)
		return 1;
	else if (f == 2)
		return 2;
	else if (f == 4)
		return 3;
	else if (f == 8)
		return 4;
	else if (f == 16)
		return 5;
	else if (f == 32)
		return 6;
	else if (f == 64)
		return 7;
	else if (f == 128)
		return 8;
	return 0;
};

// handles powers of 2 from -127 to 127
float(float f) pow2_fast =
{
	local float over1, m;
	
	if (f < 0)
	{
		f = 0 - f;
		over1 = 1;
	}
	
	m = 1;
	if (f & 1)
		m = 2;
	if (f & 2)
		m = m * 4;
	if (f & 4)
		m = m * 16;
	if (f & 8)
		m = m * 256;
	if (f & 16)
		m = m * 65536;
	if (f & 32)
		m = m * 4294967296;
	if (f & 64)
		m = m * 18446744073709552640;
	if (over1)
		return 1/m;
	else
		return m;
};

float(float f, float ex) encode4 =
{
	// f can be negative, so minor change
	var float sign = 1;
	if (f < 0)
	{
		f = 0-f;
		sign = -1;
	}
	return (1 + f / 8388608) * pow2_fast(ex - 125) * sign;
};

float(float f) decode4 =
{
	local float m, i;

	// f can be negative, so minor change
	if (f < 0)
		f = 0-f;
		
	i = 251;
	m = pow2_fast(126);
	while(m > f)
	{
		m = m / 2;
		i = i - 1;
	}
	return i;
};
float (float f, float key) unlock4 =
{

	// f can be negative, so minor change
	var float sign = 1;
	if (f < 0)
	{
		f = 0-f;
		sign = -1;
	}
	return ((f / pow2_fast(key - 125)) - 1) * 8388608 * sign;
};