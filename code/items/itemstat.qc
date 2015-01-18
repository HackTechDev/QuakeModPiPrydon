float() setstat =
{
	float id;
	if (stat_id)
		id = 1;
	else
		id = -1;
	if (stat_it == IT_GOLD)
		return IT_GOLD | ((stat_dur & 255) * 65536) | ((stat_dur & 16128) * 4);
	else if (stat_it > 31)
	{
		if (stat_it < 64)
			return ((stat_it - 31) * 32) | (stat_suf * 1024) | (stat_dur * 65536) * id;
		else
			return ((stat_it - 63) * 1024) | (stat_dur * 65536) * id;
	}
	return (stat_it | (stat_pref * 32) | (stat_suf * 1024) | (stat_dur * 65536)) * id;
};
nosave var float last_it = 64544; // invalid item number (16128 gold)

void(float it) simplestat =
{
	last_it = 64544;
	if (it < 0)
	{
		stat_id = 0;
		it = 0 - it;
	}
	else
		stat_id = 1;
	stat_it = it & 31;
	stat_pref = floor(it / 32) & 31;
	stat_suf = floor (it / 1024) & 63;
	stat_dur = floor (it / 65536) & 255;
	if (!stat_it && it)
	{
		if (stat_pref)
		{
			stat_it = stat_pref + 31;
			stat_pref = 0;
			if (stat_it == IT_GOLD)
			{
				stat_dur = stat_dur + stat_suf * 256;
				stat_suf = 0;
			}
		}
		else
		{
			// quest items?
			stat_it = stat_suf + 63;
			stat_suf = 0;
		}
	}
};


string(float it) itemmodel =
{
	local entity q;
	if (it == IT_CLOTH)
		return "progs/leath.mdl";
	else if (it == IT_AKETON)
		return "progs/leath.mdl";
	else if (it == IT_CHAIN_MAIL)
		return "progs/mail.mdl";
	else if (it == IT_BREAST_PLATE)
		return "progs/mail.mdl";
	else if (it == IT_KNIFE)
		return "progs/knife.mdl";
	else if (it == IT_DAGGER)
		return "progs/dagger.mdl";
	else if (it == IT_SABRE)
		return "progs/sword.mdl";
	else if (it == IT_RAPIER)
		return "progs/sword.mdl";
	else if (it == IT_BROADSWORD)
		return "progs/sword.mdl";
	else if (it == IT_CLUB)
		return "progs/club.mdl";
	else if (it == IT_MACE)
		return "progs/club.mdl";
	else if (it == IT_STAFF)
		return "progs/staff.mdl";
	else if (it == IT_SCEPTER)
		return "progs/staff.mdl";
	else if (it == IT_HATCHET)
		return "progs/axe.mdl";
	else if (it == IT_AXE)
		return "progs/axe.mdl";
	else if (it == IT_WAR_AXE)
		return "progs/axe.mdl";
	else if (it == IT_SHORT_BOW)
		return "progs/bow.mdl";
	else if (it == IT_LONG_BOW)
		return "progs/bow.mdl";
	else if (it == IT_WAR_BOW)
		return "progs/bow.mdl";
	else if (it == IT_THROWKNIFE)
		return "progs/knife.mdl";
	else if (it == IT_BUCKLER)
		return "progs/shield.mdl";
	else if (it == IT_SHIELD)
		return "progs/ashield.mdl";
	else if (it == IT_AEGIS)
		return "progs/aegis.mdl";
	else if (it == IT_SKULL_CAP)
		return "progs/helm.mdl";
	else if (it == IT_HELM)
		return "progs/helm.mdl";
	else if (it == IT_GREAT_HELM)
		return "progs/helm.mdl";
	else if (it == IT_BOOTS)
		return "progs/boots.mdl";
	else if (it == IT_GREAVES)
		return "progs/greaves.mdl";
	else if (it == IT_AMULET)
		return "progs/amulet.mdl";
	else if (it == IT_ARROWS)
		return "progs/quiver.mdl";
	else if (it == IT_SPEARS)
		return "progs/spear.mdl";
	else if (it == IT_GOLD)
		return "progs/money.mdl";
	else if (it == IT_LESSER_HEAL)
		return "progs/hpot.mdl";
	else if (it == IT_HEAL_POTION)
		return "progs/hpot.mdl";
	else if (it == IT_GREATER_HEAL)
		return "progs/hpot.mdl";
	else if (it == IT_LESSER_MANA)
		return "progs/mpot.mdl";
	else if (it == IT_MANA_POTION)
		return "progs/mpot.mdl";
	else if (it == IT_GREATER_MANA)
		return "progs/mpot.mdl";
	else if (it == IT_ELIXIR)
		return "progs/elixir.mdl";
	else if (it == IT_BOOK)
		return "progs/book.mdl";
	else if (it == IT_SCROLL)
		return "progs/scroll.mdl";
	else if (it == IT_IDSCROLL)
		return "progs/scroll.mdl";
	else
	{
		q = get_questitem(it);
		if (q)
			return q.model;
		else
			return "";
		
	}
};

string(float it) itemsound =
{
	local entity q;
	
	if (it == IT_CLOTH)
		return "items/cloth.wav";
	else if (it == IT_AKETON)
		return "items/cloth.wav";
	else if (it == IT_CHAIN_MAIL)
		return "items/armor1.wav";
	else if (it == IT_BREAST_PLATE)
		return "items/armor1.wav";
	else if (it == IT_KNIFE)
		return "items/sword.wav";
	else if (it == IT_DAGGER)
		return "items/sword.wav";
	else if (it == IT_SABRE)
		return "items/sword.wav";
	else if (it == IT_RAPIER)
		return "items/sword.wav";
	else if (it == IT_BROADSWORD)
		return "items/sword.wav";
	else if (it == IT_CLUB)
		return "items/club.wav";
	else if (it == IT_MACE)
		return "items/club.wav";
	else if (it == IT_STAFF)
		return "items/club.wav";
	else if (it == IT_SCEPTER)
		return "items/club.wav";
	else if (it == IT_HATCHET)
		return "player/axhit2.wav";
	else if (it == IT_AXE)
		return "player/axhit2.wav";
	else if (it == IT_WAR_AXE)
		return "player/axhit2.wav";
	else if (it == IT_SHORT_BOW)
		return "items/bow.wav";
	else if (it == IT_LONG_BOW)
		return "items/bow.wav";
	else if (it == IT_WAR_BOW)
		return "items/bow.wav";
	else if (it == IT_THROWKNIFE)
		return "items/sword.wav";
	else if (it == IT_BUCKLER)
		return "items/shield.wav";
	else if (it == IT_SHIELD)
		return "items/shield.wav";
	else if (it == IT_AEGIS)
		return "items/shield.wav";
	else if (it == IT_SKULL_CAP)
		return "items/helm.wav";
	else if (it == IT_HELM)
		return "items/helm.wav";
	else if (it == IT_GREAT_HELM)
		return "items/helm.wav";
	else if (it == IT_BOOTS)
		return "items/booties.wav";
	else if (it == IT_GREAVES)
		return "items/helm.wav";
	else if (it == IT_AMULET)
		return "items/amulet.wav";
	else if (it == IT_SPEARS)
		return "items/arrows.wav";
	else if (it == IT_ARROWS)
		return "items/arrows.wav";
	else if (it == IT_GOLD)
		return "items/gold.wav";
	else if (it == IT_LESSER_HEAL)
		return "items/potion.wav";
	else if (it == IT_HEAL_POTION)
		return "items/potion.wav";
	else if (it == IT_GREATER_HEAL)
		return "items/potion.wav";
	else if (it == IT_LESSER_MANA)
		return "items/potion.wav";
	else if (it == IT_MANA_POTION)
		return "items/potion.wav";
	else if (it == IT_GREATER_MANA)
		return "items/potion.wav";
	else if (it == IT_ELIXIR)
		return "items/potion.wav";
	else if (it == IT_BOOK)
		return "items/scroll.wav";
	else if (it == IT_SCROLL)
		return "items/scroll.wav";
	else if (it == IT_IDSCROLL)
		return "items/scroll.wav";
	else
	{
		q = get_questitem(it);
		if (q)
			return q.noise;
		else
			return "";
		
	}
};


void(float it) itemstat =
{
	local entity q;
	
	// fills stat_ with item specific info
	
	// if we're doing the same item again, we can save time and potential
	// runaway loop errors by double checking
	if (it == last_it)
		return;

		
	stat_price = stat_dur = stat_loc = 0;
	stat_max_dur = 255;
	stat_req_str = stat_req_mag = stat_req_dex = stat_req_lvl = 0;
	stat_str = stat_mag = stat_dex = stat_vit = stat_luck = stat_agil = 0;
	stat_daml = stat_dama = stat_tohit = stat_dodge = stat_mana =
	stat_health = stat_def = stat_spec = stat_toall = 0;
	stat_spell = stat_fire = stat_lit = stat_poison = 0;

	
	simplestat(it);
	if (!stat_it)
		return;
	last_it = it;
		
	if (stat_it == IT_CLOTH)
	{
		// Cloth
		stat_loc = BODY | DURABILITY | EQUIPABLE;
		stat_price = 40 + floor(stat_dur * 2.5);
		stat_def = 10;
		stat_max_dur = 8;
		stat_action = 1; // skin hack
	}
	else if (stat_it == IT_AKETON)
	{
		// aketon
		stat_loc = BODY | DURABILITY | EQUIPABLE;
		stat_price = 200 + floor(stat_dur * 3);
		stat_max_dur = 40;
		stat_def = 35;
		stat_req_str = 10;
		stat_action = 1; // skin hack
	}
	else if (stat_it == IT_CHAIN_MAIL)
	{
		// chain mail
		stat_loc = BODY | DURABILITY | EQUIPABLE;
		stat_price = 1000 + floor(stat_dur * 7.5);
		stat_max_dur = 100;
		stat_def = 60;
		stat_req_str = 40;
		stat_action = 2; // skin hack
	}
	else if (stat_it == IT_BREAST_PLATE)
	{
		// breastplate
		stat_loc = BODY | DURABILITY | EQUIPABLE;
		stat_price = 2000 + stat_dur * 10;
		stat_max_dur = 125;
		stat_def = 80;
		stat_req_str = 80;
		stat_action = 2; // skin hack
	}
	else if (stat_it == IT_KNIFE)
	{
		stat_loc = RIGHTARM | DURABILITY | EQUIPABLE;
		stat_max_dur = 10;
		stat_daml = 6;
		stat_dama = 1;
		stat_price = 80 + floor(stat_dur * 2);
		stat_action = SP_FIGHT_MELEE;
	}
	else if (stat_it == IT_DAGGER)
	{
		stat_loc = RIGHTARM | DURABILITY | EQUIPABLE;
		stat_max_dur = 30;
		stat_daml = 18;
		stat_dama = 6;
		stat_price = 400 + floor(stat_dur * 3);
		stat_req_dex = 10;
		stat_action = SP_FIGHT_MELEE;
	}
	else if (stat_it == IT_SABRE)
	{
		// sabre
		stat_loc = RIGHTARM | DURABILITY | EQUIPABLE;
		stat_max_dur = 12;
		stat_daml = 8;
		stat_dama = 2;
		stat_price = 150 + floor(stat_dur * 2);
		stat_req_dex = 1;
		stat_action = SP_FIGHT_MELEE;
	}
	else if (stat_it == IT_RAPIER)
	{
		// rapier
		stat_loc = RIGHTARM | DURABILITY | EQUIPABLE;
		stat_max_dur = 20;
		stat_daml = 12;
		stat_dama = 6;
		stat_price = 230 + floor(stat_dur * 2.5);
		stat_req_dex = 12;
		stat_req_str = 9;
		stat_action = SP_FIGHT_MELEE;
	}
	else if (stat_it == IT_BROADSWORD)
	{
		// broadsword
		stat_loc = RIGHTARM | DURABILITY | EQUIPABLE;
		stat_max_dur = 38;
		stat_daml = 30;
		stat_dama = 12;
		stat_price = 640 + floor(stat_dur * 5);
		stat_req_dex = 30;
		stat_req_str = 35;
		stat_action = SP_FIGHT_MELEE;
	}
	else if (stat_it == IT_CLUB)
	{
		// club
		stat_loc = RIGHTARM | DURABILITY | EQUIPABLE;
		stat_max_dur = 8;
		stat_daml = 4;
		stat_dama = 6;
		stat_price = 60 + floor(stat_dur * 2);
		stat_action = SP_FIGHT_MELEE;
	}

	else if (stat_it == IT_MACE)
	{
		// mace
		stat_loc = RIGHTARM | DURABILITY | EQUIPABLE;
		stat_max_dur = 50;
		stat_daml = 25;
		stat_dama = 18;
		stat_price = 500 + floor(stat_dur * 3);
		stat_req_str = 40;
		stat_action = SP_FIGHT_MELEE;
	}
	else if (stat_it == IT_STAFF)
	{
		// staff
		stat_loc = TWO_HAND | DURABILITY | EQUIPABLE;
		stat_max_dur = 13;
		stat_daml = 9;
		stat_dama = 5;
		stat_price = 180 + floor(stat_dur * 5);
		stat_req_mag = 5;
		stat_action = SP_FIGHT_MELEE;
	}
	else if (stat_it == IT_SCEPTER)
	{
		// scepter
		stat_loc = RIGHTARM | DURABILITY | EQUIPABLE;
		stat_max_dur = 30;
		stat_daml = 22;
		stat_dama = 7;
		stat_price = 400 + floor(stat_dur * 5);
		stat_req_mag = 20;
		stat_action = SP_FIGHT_MELEE;
	}
	else if (stat_it == IT_HATCHET)
	{
		// hatchet
		stat_loc = RIGHTARM | DURABILITY | EQUIPABLE;
		stat_max_dur = 13;
		stat_daml = 7;
		stat_dama = 3;
		stat_price = 160 + floor(stat_dur * 1);
		stat_req_str = 5;
		stat_action = SP_FIGHT_MELEE;
	}
	else if (stat_it == IT_AXE)
	{
		// axe
		stat_loc = TWO_HAND | DURABILITY | EQUIPABLE;
		stat_max_dur = 30;
		stat_daml = 10;
		stat_dama = 8;
		stat_price = 200 + floor(stat_dur * 1.5);
		stat_req_str = 25;
		stat_action = SP_FIGHT_MELEE;
	}
	else if (stat_it == IT_WAR_AXE)
	{
		// war axe
		stat_loc = TWO_HAND | DURABILITY | EQUIPABLE;
		stat_max_dur = 38;
		stat_daml = 30;
		stat_dama = 12;
		stat_price = 640 + floor(stat_dur * 5);
		stat_req_dex = 30;
		stat_req_str = 35;
		stat_action = SP_FIGHT_MELEE;
	}
	else if (stat_it == IT_SHORT_BOW)
	{
		// short bow
		stat_tohit = -15;
		stat_loc = RIGHTARM | EQUIPABLE;
		stat_daml = 1;
		stat_dama = 2;
		stat_price = 180;
		stat_req_dex = 5;
		stat_action = SP_FIGHT_BOW;
	}
	else if (stat_it == IT_LONG_BOW)
	{
		// long bow
		stat_tohit = -5;
		stat_loc = RIGHTARM | EQUIPABLE;
		stat_daml = 5;
		stat_dama = 4;
		stat_price = 350;
		stat_req_dex = 25;
		stat_action = SP_FIGHT_BOW;
	}
	else if (stat_it == IT_WAR_BOW)
	{
		// war bow
		stat_loc = RIGHTARM | EQUIPABLE;
		stat_daml = 18;
		stat_dama = 6;
		stat_price = 720;
		stat_req_str = 25;
		stat_req_dex = 45;
		stat_action = SP_FIGHT_BOW;
	}
	else if (stat_it == IT_THROWKNIFE)
	{
		// spears
		stat_daml = 5;
		stat_dama = 5;
		stat_tohit = -8;
		stat_req_dex = 5;
		stat_loc = EQUIPABLE | RIGHTARM | STACKABLE;
		stat_max_dur = 100;
		stat_price = ceil(stat_dur * 0.75);
		stat_action = SP_THROW;
	}
	else if (stat_it == IT_BUCKLER)
	{
		// buckler
		stat_loc = LEFTARM | EQUIPABLE | DURABILITY;
		stat_def = 5;
		stat_dodge = 2;
		stat_max_dur = 8;
		stat_price = 70 + floor(stat_dur * 5);
	}
	else if (stat_it == IT_SHIELD)
	{
		// shield
		stat_loc = LEFTARM | EQUIPABLE | DURABILITY;
		stat_def = 10;
		stat_dodge = 10;
		stat_max_dur = 18;
		stat_price = 160 + floor(stat_dur * 1.5);
		stat_req_str = 15;
	}
	else if (stat_it == IT_AEGIS)
	{
		// aegis
		stat_loc = LEFTARM | EQUIPABLE | DURABILITY;
		stat_def = 20;
		stat_dodge = 25;
		stat_max_dur = 45;
		stat_price = 350 + floor(stat_dur * 5);
		stat_req_str = 30;
	}
	else if (stat_it == IT_SKULL_CAP)
	{
		// skull cap
		stat_loc = HEAD | EQUIPABLE | DURABILITY;
		stat_def = 7;
		stat_max_dur = 10;
		stat_price = 80 + floor(stat_dur);
	}
	else if (stat_it == IT_HELM)
	{
		// helm
		stat_loc = HEAD | EQUIPABLE | DURABILITY;
		stat_def = 15;
		stat_max_dur = 22;
		stat_price = 600 + floor(stat_dur * 3);
		stat_req_str = 15;
	}
	else if (stat_it == IT_GREAT_HELM)
	{
		// great helm
		stat_loc = HEAD | EQUIPABLE | DURABILITY;
		stat_def = 24;
		stat_max_dur = 30;
		stat_price = 1100 + floor(stat_dur * 6);
		stat_req_str = 30;
	}
	else if (stat_it == IT_BOOTS)
	{
		// helm
		stat_loc = FEET | EQUIPABLE | DURABILITY;
		stat_def = 5;
		stat_max_dur = 12;
		stat_price = 50 + floor(stat_dur * 2);
	}
	else if (stat_it == IT_GREAVES)
	{
		// great helm
		stat_loc = FEET | EQUIPABLE | DURABILITY;
		stat_def = 16;
		stat_max_dur = 30;
		stat_price = 50 + floor(stat_dur * 4);
		stat_req_str = 18;
	}
	else if (stat_it == IT_AMULET)
	{
		// amulet
		stat_loc = EQUIPABLE | NECK;
		stat_price = 500;
	}
	else if (stat_it == IT_SPEARS)
	{
		// spears
		stat_daml = 10;
		stat_dama = 5;
		stat_tohit = -5;
		stat_req_dex = 14;
		stat_loc = EQUIPABLE | RIGHTARM | STACKABLE;
		stat_max_dur = 200;
		stat_price = ceil(stat_dur * 2);
		stat_action = SP_THROW;
	}
	else if (stat_it == IT_ARROWS)
	{
		// arrows
		stat_loc = EQUIPABLE | LEFTARM | STACKABLE;
		stat_max_dur = 200;
		stat_price = ceil(stat_dur * 0.5);
	}
	else if (stat_it == IT_GOLD)
	{
		// Gold
		stat_loc = STACKABLE;
		stat_max_dur = 10000;
		stat_price = stat_dur;
	}
	else if (stat_it == IT_LESSER_HEAL)
	{
		// health potion
		stat_loc = USABLE | STACKABLE;
		stat_price = 15 * stat_dur;
		stat_max_dur = 100;
	}
	else if (stat_it == IT_HEAL_POTION)
	{
		// health potion
		stat_loc = USABLE | STACKABLE;
		stat_price = 30 * stat_dur;
		stat_max_dur = 100;
	}
	else if (stat_it == IT_GREATER_HEAL)
	{
		// health potion
		stat_loc = USABLE | STACKABLE;
		stat_price = 50 * stat_dur;
		stat_max_dur = 100;
	}
	else if (stat_it == IT_LESSER_MANA)
	{
		// mana potion
		stat_loc = USABLE | STACKABLE;
		stat_price = 10 * stat_dur;
		stat_max_dur = 100;
	}
	else if (stat_it == IT_MANA_POTION)
	{
		// mana potion
		stat_loc = USABLE | STACKABLE;
		stat_price = 20 * stat_dur;
		stat_max_dur = 100;
	}
	else if (stat_it == IT_GREATER_MANA)
	{
		// mana potion
		stat_loc = USABLE | STACKABLE;
		stat_price = 35 * stat_dur;
		stat_max_dur = 100;
	}
	else if (stat_it == IT_ELIXIR)
	{
		// elixir potion
		stat_loc = USABLE;
		stat_price = 2200;
	}
	else if (stat_it == IT_BOOK)
	{
		// book
		stat_loc = USABLE;
	}
	else if (stat_it == IT_SCROLL)
	{
		// scroll
		stat_loc = EQUIPABLE | STACKABLE | SPELL;
	}
	else if (stat_it == IT_IDSCROLL)
	{
		// scroll
		stat_loc = USE_ON_ITEM | USABLE | STACKABLE;
		stat_price = 50 * stat_dur;
	}
	else
	{
		q = get_questitem(stat_it);
		if (!q)
			return;
		// nasty
		stat_max_dur = q.max_health;
		stat_loc = q.ai;
		stat_str = q.str;
		stat_dex = q.dex;
		stat_mag = q.mag;
		stat_vit = q.vit;
		stat_luck = q.luck;
		stat_agil = q.agil;
		stat_toall = q.ptd;
		stat_daml = q.daml;
		stat_dama = q.dama;
		stat_tohit = q.tohit;
		stat_mana = q.currentammo;
		stat_health = q.health;
		stat_def = q.ac;
		stat_spell = q.spell;
		stat_action = q.gotstuff;
		stat_fire = q.fire;
		stat_poison = q.poidam;
		stat_lit = q.lit;
		stat_spec = q.spec;
		
		// no stat_req_* except this
		stat_req_lvl = q.frags;
		
	}
	if (!stat_id)
		return;
//==========================================================================
	if (stat_pref)
	{
		if (stat_pref == PF_BROKEN)
		{
			// broken
			if (stat_daml)
			{
				stat_daml = ceil(stat_daml * 0.2);
				stat_dama = ceil(stat_dama * 0.2);
			}
			else if (stat_def)
				stat_def = ceil(stat_def * 0.2);
			stat_price = ceil(stat_price * 0.25);
		}
		else if (stat_pref == PF_DAMAGED)
		{
			// damaged
			if (stat_daml)
			{
				stat_daml = ceil(stat_daml * 0.5);
				stat_dama = ceil(stat_dama * 0.5);
			}
			else if (stat_def)
				stat_def = ceil(stat_def * 0.5);
			stat_max_dur = ceil(stat_max_dur * 0.75);
			stat_price = ceil(stat_price * 0.3);
		}
		else if (stat_pref == PF_CURSED)
		{
			// cursed
			stat_luck = stat_luck - 20;
			stat_price = ceil(stat_price * 0.5);
		}
		else if (stat_pref == PF_USELESS)
		{
			// uselss
			if (stat_daml)
			{
				stat_daml = 1;
				stat_dama = 0;
			}
			if (stat_def)
				stat_def = 1;
			stat_price = ceil(stat_price * 0.1);
		}
		else if (stat_pref == PF_RUSTED)
		{
			// rusted
			stat_max_dur = ceil(0.8 * stat_max_dur);
			if (stat_daml)
			{
				stat_daml = ceil(stat_daml * 0.6);
				stat_dama = ceil(stat_dama * 0.6);
			}
			else if (stat_def)
				stat_def = ceil(stat_def * 0.6);
			stat_price = ceil(stat_price * 0.3);
		}
		else if (stat_pref == PF_BRITTLE)
		{
			// brittle
			stat_max_dur = ceil(stat_max_dur * 0.1);
			stat_price = ceil(stat_price * 0.35);
		}
		else if (stat_pref == PF_CHEAP)
		{
			// cheap
			if (stat_daml)
			{
				stat_daml = ceil(stat_daml * 0.8);
				stat_dama = ceil(stat_dama * 0.8);
			}
			else if (stat_def)
				stat_def = ceil(stat_def * 0.8);
			stat_max_dur = ceil(stat_max_dur * 0.9);
			stat_price = ceil(stat_price * 0.5);
		}
		else if (stat_pref == PF_UNWIELDY)
		{
			// unwieldy
			if ((stat_loc & LOC) == RIGHTARM)
				stat_loc = stat_loc | LEFTARM;
			if (stat_daml)
				stat_tohit = stat_tohit - 5;
			else if (stat_def)
				stat_dodge = stat_dodge - 5;
			stat_req_dex = stat_req_dex + 10;
		}
		else if (stat_pref == PF_RUGGED)
		{
			// rugged
			stat_max_dur = ceil(stat_max_dur * 1.2);
			stat_price = ceil(stat_price * 1.1);
		}
		else if (stat_pref == PF_SHARP)
		{
			// sharp
			if (stat_daml)
			{
				stat_daml = ceil(stat_daml * 1.5);
				stat_dama = ceil(stat_dama * 0.5);
			}
			stat_price = ceil(stat_price * 1.3);
		}
		else if (stat_pref == PF_QUALITY)
		{
			// quality
			if (stat_daml)
			{
				stat_daml = ceil(stat_daml * 1.4);
				stat_dama = ceil(stat_dama * 1.4);
			}
			else if (stat_def)
				stat_def = ceil(stat_def * 1.8);
			stat_price = ceil(stat_price * 1.5);
		}
		else if (stat_pref == PF_LUCKY)
		{
			// lucky
			stat_luck = stat_luck + ceil(stat_max_dur * 0.25);
			if (!stat_luck)
				stat_luck = 5;
			else if (stat_luck > 15)
				stat_luck = 15;
			if (stat_daml)
				stat_tohit = stat_tohit + 20;
			if (stat_def)
				stat_dodge = stat_dodge + 20;
			stat_price = ceil(stat_price * 1.7);
		}
		else if (stat_pref == PF_SUPERIOR)
		{
			// superior
			if (stat_daml)
			{
				stat_daml = ceil(stat_daml * 1.8);
				stat_dama = ceil(stat_dama * 1.1);
			}
			else if (stat_def)
				stat_def = ceil(stat_def * 2.2);

			stat_price = ceil(stat_price * 1.8);
		}
		else if (stat_pref == PF_WIZARDS)
		{
			// Wizard's
			stat_req_mag = stat_req_mag + 20;
			if (stat_loc & DURABILITY)
				stat_mana = stat_mana + ceil(stat_max_dur * 0.25);
			else
				stat_mana = stat_mana + 15;
			stat_price = ceil(stat_price * 1.2);
		}
		else if (stat_pref == PF_ACCURATE)
		{
			// accurate
			if (stat_max_dur != 255)
				stat_dex = stat_dex + ceil(stat_max_dur * 0.1);
			else
				stat_dex = 5;
			stat_price = ceil(stat_price * 1.25);
		}
		else if (stat_pref == PF_DEADLY)
		{
			// deadly
			if (stat_daml)
			{
				stat_daml = ceil(stat_daml * 2.5);
			}
			else
				stat_poison = stat_poison + 15;
			stat_price = ceil(stat_price * 1.6);
		}
		else if (stat_pref == PF_WARRIORS)
		{
			// warrior's
			stat_req_str = stat_req_str + 20;
			if (stat_daml)
			{
				stat_daml = ceil(stat_daml * 2);
				stat_tohit = stat_tohit + 25;
			}
			else if (stat_def)
			{
				stat_def = ceil(stat_def * 2.4);
				stat_dodge = stat_dodge + 25;
			}
			else
				stat_tohit = stat_tohit + 25;
			stat_price = ceil(stat_price * 1.6);
		}
		else if (stat_pref == PF_ULTIMATE)
		{
			// ultimate
			stat_req_lvl = 30;
			if (stat_daml)
			{
				stat_daml = ceil(stat_daml * 3);
				stat_tohit = stat_tohit + 80;
			}
			else if (stat_def)
			{
				stat_def = ceil(stat_def * 3);
				stat_dodge = stat_dodge + 80;
			}
			else
			{
				stat_fire = stat_fire + 10;
				stat_lit = stat_lit + 10;
				stat_poison = stat_poison + 20;
			}
			stat_price = ceil(stat_price * 3.5);
		}
		else if (stat_pref == PF_SILVER)
		{
			// silver
			if (stat_daml)
			{
				stat_daml = ceil(stat_daml * 1.6);
				stat_dama = ceil(stat_dama * 1.6);
				stat_req_dex = stat_req_dex + 10;
			}
			else if (stat_def)
			{
				stat_def = ceil(stat_def * 1.8);
				stat_req_str = stat_req_str + 10;	
			}
			else
				stat_tohit = stat_tohit + 10;
			if (stat_max_dur <= 235)
				stat_max_dur = stat_max_dur + 10;
			stat_price = ceil(stat_price * 2);
		}
		else if (stat_pref == PF_VIGOROUS)
		{
			// vigorous
			if (stat_max_dur != 255)
				stat_health = floor(stat_max_dur * 0.2);
			else
				stat_health = 10;
			stat_vit = 10;
			stat_price = ceil(stat_price * 1.2);
		}
		else if (stat_pref == PF_HEAVY)
		{
			// heavy
			if (stat_daml)
			{
				stat_daml = ceil(stat_daml * 1.8);
				stat_dama = ceil(stat_dama * 1.8);
			}
			else if (stat_def)
				stat_def = ceil(stat_def * 1.4);
				
			stat_req_str = stat_req_str + 20;
			if (stat_max_dur <= 225)	
				stat_max_dur = stat_max_dur + 30;
			stat_price = ceil(stat_price * 1.8);
		}
		else if (stat_pref == PF_THIEFS)
		{
			// thief's
			stat_agil = stat_agil + 10;
			stat_req_dex = stat_req_dex + 5;
			stat_price = ceil(stat_price * 1.1);
		}
		else if (stat_pref == PF_BRUTAL)
		{
			// brutal
			if (stat_daml)
				stat_daml = ceil(stat_daml * 2);
			else
				stat_daml = 5;
			stat_price = ceil(stat_price * 1.3);
		}
		else if (stat_pref == PF_FIERY)
		{
			// fiery 
			stat_fire = stat_fire + 5;
			stat_price = ceil(stat_price * 1.4);
		}
		else if (stat_pref == PF_LIGHT)
		{
			// light
			// hmmm
			if (stat_req_str)
				stat_req_str = ceil(stat_req_str * 0.5);
			else if (stat_req_dex)
				stat_req_dex = ceil(stat_req_dex * 0.5);
			if (stat_loc & TWO_HAND == TWO_HAND)
				stat_loc = stat_loc - LEFTARM;
			stat_dodge = stat_dodge + 10;
			stat_price = ceil(stat_price * 1.2);
		
		}
		else if (stat_pref == PF_RAPID)
		{
			// rapid (special case)
			stat_spec = stat_spec | SPEED;
			stat_price = ceil(stat_price * 1.35);
		}
		else if (stat_pref == PF_OVERPRICED)
		{
			// overpriced
			stat_price = ceil(stat_price * 4);
		}
		else if (stat_pref == PF_GOLDEN)
		{
			// golden
			if (stat_daml)
			{
				stat_daml = ceil(stat_daml * 2.2);
				stat_dama = ceil(stat_dama * 0.5);
				stat_tohit = stat_tohit + 10;
			}
			else if (stat_def)
			{
				stat_def = ceil(stat_def * 1.7);
				stat_dodge = stat_dodge + 10;
			}
			else
				stat_dodge = stat_dodge + 10;
			stat_req_str = stat_req_str + 30;
			if (stat_max_dur <= 220)
				stat_max_dur = stat_max_dur + 35;
			stat_price = ceil(stat_price * 1.8);
		}
		else if (stat_pref == PF_THINKERS)
		{
			// thinker's
			stat_req_mag = stat_req_mag + 10;
			if (stat_max_dur != 255)
				stat_mana = stat_mana + ceil(stat_max_dur * 0.3);
			else
				stat_mana = stat_mana + 15;
			stat_mag = stat_mag + 5;
			stat_price = ceil(stat_price * 1.2);
		}
		else if (stat_pref == PF_TITANS)
		{
			// titan's
			if (stat_max_dur != 255)
				stat_health = stat_health + ceil(stat_max_dur * 0.2);
			else
				stat_health = stat_health + 15;
			stat_price = ceil(stat_price * 1.28);
		}
		else if (stat_pref == PF_VILE)
		{
			// vile
			stat_poison = stat_poison + 90;
			stat_price = ceil(stat_price * 1.6);
		}
	}
	if (stat_suf)
	{
		if (stat_suf == SF_FOOL)
		{
			// of the fool
			stat_mag = stat_mag - 5;
			stat_price = ceil(stat_price * 0.25);
			return;
		}
		else if (stat_suf == SF_WEAK)
		{
			// of the weak
			stat_str = stat_str - 5;
			stat_price = ceil(stat_price * 0.25);
			return;
		}
		else if (stat_suf == SF_CLUMSY)
		{
			// of the clumsy
			stat_dex = stat_dex - 5;
			stat_price = ceil(stat_price * 0.25);
			return;
		}
		else if (stat_suf == SF_SLOW)
		{
			// of the slow
			stat_agil = stat_agil - 5;
			stat_price = ceil(stat_price * 0.25);
			return;
		}
		else if (stat_suf == SF_MISFORTUNE)
		{
			// of misfortune
			stat_luck = stat_luck - 5;
			stat_price = ceil(stat_price * 0.25);
			return;
		}
		else if (stat_suf == SF_FRAGILITY)
		{
			// of fragility (-dur)
			stat_max_dur = ceil(stat_max_dur * 0.1);
			stat_price = ceil(stat_price * 0.1);
			return;
		}
		else if (stat_suf == SF_CORRUPTION)
		{
			// of corruption (-mana)
			stat_mana = stat_mana - ceil(stat_max_dur * 0.1);
			stat_price = ceil(stat_price * 0.3);
			return;
		}
		else if (stat_suf == SF_PIT)
		{
			// of the pit
			stat_toall = stat_toall - 5;
			stat_price = ceil(stat_price * 0.01);
			return;
		}
		else if (stat_suf == SF_ILLNESS)
		{
			// of illness
			stat_vit = stat_vit - 5;
			stat_price = ceil(stat_price * 0.25);
			return;
		}
		else if (stat_suf == SF_VITALITY)
		{
			// of vitality
			stat_vit = stat_vit + 1;
			stat_price = ceil(stat_price * 1.05);
			return;
		}
		else if (stat_suf == SF_VAMPIRE)
		{
			// vampire
			stat_spec = stat_spec | STEAL_LIFE;
			stat_price = ceil(stat_price * 2);
			return;
		}
		else if (stat_suf == SF_LUCK)
		{
			// of luck
			stat_luck = stat_luck + 1;
			stat_price = ceil(stat_price * 1.05);
			return;
		}
		else if (stat_suf == SF_STRENGTH)
		{
			// of strength
			stat_str = stat_str + 1;
			stat_price = ceil(stat_price * 1.05);
			return;
		}
		else if (stat_suf == SF_INTELLIGENCE)
		{
			// of intelligence
			stat_mag = stat_mag + 1;
			stat_price = ceil(stat_price * 1.05);
			return;
		}
		else if (stat_suf == SF_AGILITY)
		{
			// of agility
			stat_agil = stat_agil + 1;
			stat_price = ceil(stat_price * 1.05);
			return;
		}
		else if (stat_suf == SF_REGEN)
		{
			// of regen
			stat_spec = stat_spec | REGEN_LIFE;
			stat_price = ceil(stat_price * 1.8);
			return;
		}
		else if (stat_suf == SF_DEXTERITY)
		{
			// of dex
			stat_dex = stat_dex + 1;
			stat_price = ceil(stat_price * 1.05);
			return;
		}
		else if (stat_suf == SF_POISON)
		{
			// of poison
			stat_poison = stat_poison + 30;
			stat_price = ceil(stat_price * 1.65);
			return;
		}
		else if (stat_suf == SF_LEECH)
		{
			// of leech
			stat_spec = stat_spec | STEAL_MANA;
			stat_price = ceil(stat_price * 1.9);
			return;
		}
		else if (stat_suf == SF_PROTECTION)
		{
			// protection
			if (stat_def)
				stat_def = stat_def * 2;
			else
				stat_def = 10;
			stat_price = ceil(stat_price * 1.7);
			return;
		}
		else if (stat_suf == SF_HEALTH)
		{
			// of health
			stat_health = stat_health + 10;
			stat_price = ceil(stat_price * 1.2);
			return;
		}
		else if (stat_suf == SF_GIANTS)
		{
			// of Giants
			if (stat_max_dur == 255)
				stat_health = stat_health + 25;
			else 
				stat_health = stat_health + floor(stat_max_dur * 0.2);	
			stat_str = stat_str + 15;
			stat_req_lvl = stat_req_lvl + 20;
			stat_price = ceil(stat_price * 1.8);
			return;
		}
		else if (stat_suf == SF_HEAVENS)
		{
			// of heavens
			stat_toall = stat_toall + 5;
			stat_req_lvl = stat_req_lvl + 10;
			stat_price = ceil(stat_price * 1.7);
			return;
		}
		else if (stat_suf == SF_STARS)
		{
			// of stars
			stat_toall = stat_toall + 7;
			stat_req_lvl = stat_req_lvl + 20;
			stat_price = ceil(stat_price * 2);
			return;
		}
		else if (stat_suf == SF_MANA)
		{
			// of mana
			stat_mana = stat_mana + 10;
			stat_price = ceil(stat_price * 1.1);
			return;
		}
		else if (stat_suf == SF_SPEED)
		{
			// speed
			stat_spec = stat_spec | SPEED;
			stat_price = ceil(stat_price * 1.3);
			return;
		}
		else if (stat_suf == SF_FLAME)
		{
			// of flame
			stat_fire = stat_fire + 5;
			stat_price = ceil(stat_price * 1.2);
			return;
		}
		else if (stat_suf == SF_QUALITY)
		{
			// quality
			if (stat_daml)
			{
				stat_daml = ceil(stat_daml * 1.4);
				stat_dama = ceil(stat_dama * 1.4);
			}
			else if (stat_def)
				stat_def = ceil(stat_def * 1.8);
			stat_max_dur = ceil(stat_max_dur * 1.4);
			if (stat_max_dur >= 255)
				stat_max_dur = 255;
			stat_price = ceil(stat_price * 1.5);
			return;
		}
		else if (stat_suf == SF_BEAR)
		{
			// bear
			stat_spec = stat_spec | KNOCKBACK;
			stat_price = ceil(stat_price * 1.25);
			return;
		}
		else if (stat_suf == SF_WIZARDRY)
		{
			// wizardry
			stat_mag = stat_mag + 10;
			if (stat_max_dur != 255)
				stat_mana = stat_mana + ceil(stat_max_dur * 0.1);
			else
				stat_mana = stat_mana + 15;
			return;
		}
		else if (stat_suf == SF_BASHING)
		{
			// quality
			if (stat_daml)
			{
				stat_daml = ceil(stat_daml * 1.8);
				stat_dama = ceil(stat_dama * 1.2);
			}
			else 
				stat_daml = 5;
				
			stat_price = ceil(stat_price * 1.5);
			return;
		}
		else if (stat_suf == SF_HASTE)
		{
			// haste
			stat_agil = stat_agil + 12;
			stat_dodge = stat_dodge + 10;
			stat_price = ceil(stat_price * 1.5);
			return;
		}
		else if (stat_suf == SF_FIGHTING)
		{
			// fighting
			stat_str = stat_str + 5;
			stat_tohit = stat_tohit + 5;
			if (stat_daml)
			{
				stat_daml = ceil(stat_daml * 1.8);
				stat_dama = ceil(stat_dama * 1.2);
			}
			stat_price = ceil(stat_price * 2.1);
			return;
		}
		else if (stat_suf == SF_SLAUGHTER)
		{
			// slaughter
			if (stat_daml)
			{
				stat_daml = ceil(stat_daml * 2.2);
				stat_dama = ceil(stat_dama * 1.3);
			}

			stat_price = ceil(stat_price * 1.89);
			return;
		}
		else if (stat_suf == SF_VIM)
		{
			// vim
			stat_vit = stat_vit + 12;
			stat_health = stat_health + 10;
			stat_price = ceil(stat_price * 1.6);
			return;
		}
		else if (stat_suf == SF_ACCURACY)
		{
			// accuracy
			stat_dex = stat_dex + 11;
			stat_tohit = stat_tohit + 10;
			stat_price = ceil(stat_price * 1.45);
			return;
		}
		else if (stat_suf == SF_MAGI)
		{
			// the apprentice
			if (stat_max_dur != 255)
				stat_mana = stat_mana + ceil(stat_max_dur * 0.1);
			else
				stat_mana = 20;
			stat_price = ceil(stat_price * 1.4);
			return;
		}
		else if (stat_suf == SF_AGES)
		{
			// the ages
			stat_spec = stat_spec | INDESTRUCTIBLE;
			stat_loc = stat_loc - (stat_loc & DURABILITY);
			stat_price = ceil(stat_price * 2.2);	
			return;
		}
		else if (stat_suf == SF_THORNS)
		{
			// thorns
			stat_spec = stat_spec | DAMATTACKER;
			stat_price = ceil(stat_price * 1.55);
			return;
		}
		else if (stat_suf == SF_SPIKES)
		{
			// spikes
			stat_spec = stat_spec | DAMATTACKER;
			if (stat_def)
				stat_def = ceil(stat_def * 1.2);
			stat_price = ceil(stat_price * 1.7);
			return;
		}
		else if (stat_suf == SF_FIRE)
		{
			// of Fire
			stat_fire = stat_fire + 12;
			stat_price = ceil(stat_price * 1.5);
			return;
		}
		else if (stat_suf == SF_SHOCK)
		{
			// of Lightning
			stat_lit = stat_lit + 40;
			stat_price = ceil(stat_price * 1.36);
			return;
		}
		else if (stat_suf == SF_BOUNTY)
		{
			// bounty
			if (stat_max_dur != 255)
				stat_mana = stat_mana + ceil(stat_max_dur * 0.4);
			else
				stat_mana = 20;
			stat_price = ceil(stat_price * 1.87);
			return;
		}
		else if (stat_suf == SF_MIND)
		{
			// the mind
			stat_mag = stat_mag + 12;
			stat_price = ceil(stat_price * 1.77);
			return;
		}
		else if (stat_suf == SF_POWER)
		{
			// of power
			stat_str = stat_str + 10;
			stat_price = ceil(stat_price * 1.77);
			return;
		}
		else if (stat_suf == SF_KINGS)
		{
			// kings
			if (stat_daml)
			{
				stat_daml = ceil(stat_daml * 1.8);
				stat_dama = ceil(stat_dama * 1.6);
				stat_req_dex = stat_req_dex + 16;
			}
			else if (stat_def)
			{
				stat_def = ceil(stat_def * 1.8);
				stat_req_str = stat_req_str + 16;	
			}
			else
			{
				stat_tohit = stat_tohit + 15;
			}
			stat_req_lvl = stat_req_lvl + 15;
			if (stat_max_dur <= 240)
				stat_max_dur = stat_max_dur + 15;
			stat_price = ceil(stat_price * 2.3);
			return;
		}
		else if (stat_suf == SF_EASE)
		{
			// ease
			stat_req_lvl = ceil(stat_req_lvl * 0.5);
			stat_req_str = ceil(stat_req_str * 0.5);
			stat_req_dex = ceil(stat_req_dex * 0.5);
			stat_req_mag = ceil(stat_req_mag * 0.5);
			stat_price = ceil(stat_price * 1.6);
			if (stat_loc & TWO_HAND)
				stat_loc = stat_loc - LEFTARM;
			return;
		}
		else
		{
			stat_spell = stat_suf - 47;
			stat_price = ceil(stat_price * 1.5);
			if ((stat_it == IT_BOOK) || (stat_it == IT_SCROLL))
			{
				
				if (stat_it == IT_BOOK)
				{
					stat_price = 100 + stat_spell * 25;
					stat_req_mag = stat_req_mag + ceil(pow2(GetSpellLevel(self, stat_spell)) * 1.3) + 10;
				}
				else
				{
					stat_req_mag = floor((stat_spell + 8) / 2 * 1.25);
					stat_price = (7 + 5 * stat_spell) * stat_dur;
				}
			}
			return;
		}
	}
};