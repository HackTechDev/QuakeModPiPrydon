void(entity e) PrintMonsterName =
{
	local float pf, sf;
	pf = decode(e.monnum, 2);
	sf = decode(e.monnum, 3);
	if (pf)
	{
		if (pf == 1)
		{
			p8('I', 'n', 'f', 'e', 'r', 'i', 'o', 'r');
			p1(' '); // damage 50%, health 40%, tohit 50%
		
		}
		else if (pf == 2)
			p5('W', 'e', 'a', 'k', ' '); // health 66%, damage 50%
		else if (pf == 3)
			p5('S', 'i', 'c', 'k', ' '); // health 80%, dodge 50%
	
		else if (pf == 4)
		{
			p8('C', 'r', 'i', 'p', 'p', 'l', 'e', 'd');
			p1(' ');
			// tohit 20% dodge 10%
		}
		else if (pf == 5)
			p8('E', 'l', 'd', 'e', 'r', 'l', 'y', ' '); // speed = 60%
		else if (pf == 6)
			p7('C', 'l', 'u', 'm', 's', 'y', ' '); // to hit -%50
		else if (pf ==7)
			p5('F', 'a', 's', 't', ' '); // agil +5
		else if (pf == 8)
		{
			p8('M', 'u', 's', 'c', 'u', 'l', 'a', 'r'); // str +5
			p1(' ');
		}
		else if (pf == 9)
		{
			p8('S', 'u', 'p', 'e', 'r', 'i', 'o', 'r'); // tohit +50% str +5 dex +5
			p1(' ');
		}
		else if (pf == 10)
			p8('H', 'e', 'a', 'l', 't', 'h', 'y', ' '); // vit +5 (?)
		else if (pf == 11)
			p6('F', 'i', 'e', 'r', 'y', ' ');
		else if (pf == 12)
			p5('V', 'i', 'l', 'e', ' '); // poidam + 5
	}
	
	pvstr(e.finalangle);
	
	if (sf)
	{
		if (sf == 1)
			p6(' ', 'p', 'u', 'p', 'i', 'l');
		else if (sf == 2)
			p4(' ', 'O', 'a', 'f');
		else if (sf == 3)
			p7(' ', 'L', 'u', 'm', 'm', 'o', 'x');
		else if (sf == 4)
		{
			p8(' ', 'I', 'm', 'b', 'e', 'c', 'i', 'l');
			p1('e');
		}
		else if (sf == 5)
		{
			p8(' ', 'W', 'e', 'a', 'k', 'l', 'i', 'n');
			p1('g');
		}
		else if (sf == 6)
			p8(' ', 'D', 'a', 'w', 'd', 'l', 'e', 'r');
		
		// pupil tohit -7%
		// oaf dex -5
		// lummox dex -5 tohit -5
		// imbecile int -10
		// weakling vit -10;
		// dawdler agil -5
		else if (sf == 7)
			p8(' ', 'V', 'a', 'm', 'p', 'i', 'r', 'e');
		else if (sf == 8)
			p7(' ', 'M', 'a', 's', 't', 'e', 'r');
		else if (sf == 9)
		{
			p8(' ', 'C', 'h', 'a', 'm', 'p', 'i', 'o');
			p1('n');
		}
		else if (sf == 10)
			p7(' ', 'W', 'i', 'z', 'a', 'r', 'd');
		else if (sf == 11)
			p5(' ', 'M', 'a', 'g', 'e');
		else if (sf == 12)
			p7(' ', 'C', 'l', 'e', 'r', 'i', 'c');
		// savant
		// master
		// champion
		// wizard
		// mage
		// cleric
	}
};
