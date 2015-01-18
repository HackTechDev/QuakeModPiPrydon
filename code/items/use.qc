
float (float it) canuse =
{
	// returns true/false
	itemstat(it);
	if ((stat_dur) <= 0 && (stat_loc & (DURABILITY | USABLE)))
		return FALSE;
	else if (stat_req_str && self.str < stat_req_str)
		return FALSE;
	else if (stat_req_mag && self.mag < stat_req_mag)
		return FALSE;
	else if (stat_req_dex && self.dex < stat_req_dex)
		return FALSE;
	else if (stat_req_lvl && self.lvl < stat_req_lvl)
		return FALSE;
	else if (!stat_id)
		return FALSE;
	if (stat_spell)
	{
		if (GetSpellLevel(self, stat_spell) >= 7)
			return FALSE;
	}
	if (stat_it == IT_ARROWS)
	{
		if (itemmodel(self.rightarm) != "progs/bow.mdl")
	/* This is the proper way to do it, but too many loops = crash
		for (i = 1; i <= MAX_SLOTS; i = i + 1)
		{
			if (self.equip & pow2(i))
			{
				itemstat(GetSlot(i));
				if (stat_action == SP_FIGHT_BOW)
					return TRUE;
			}
		}
	*/
		return FALSE;
	}
	return TRUE;
};

float(float sign) UseItem =
{
	// itemstat must be done!
	// (normally canuse will do it)
		
	GenStat(-1);	
	if (stat_health)
		self.max_health = self.max_health + (stat_health * sign);
	if (stat_str)
		self.str = self.str + (stat_str * sign);
	if (stat_dex)
		self.dex = self.dex + (stat_dex * sign);
	if (stat_mag)
		self.mag = self.mag + (stat_mag * sign);
	if (stat_agil)
		self.agil = self.agil + (stat_agil * sign);
	if (stat_vit)
		self.vit = self.vit + (stat_vit * sign);
	if (stat_luck)
		self.luck = self.luck + (stat_luck * sign);
	if (stat_toall)
	{
		self.luck = self.luck + (stat_toall * sign);
		self.vit = self.vit + (stat_toall * sign);
		self.agil = self.agil + (stat_toall * sign);
		self.str = self.str + (stat_toall * sign);
		self.dex = self.dex + (stat_toall * sign);
		self.mag = self.mag + (stat_toall * sign);
	}
	if (stat_def)
		self.ac = self.ac + (stat_def * sign);
	if (stat_tohit)
		self.tohit = self.tohit + (stat_tohit * sign);
	if (stat_dodge)
		self.dodge = self.dodge + (stat_dodge * sign);
	if (stat_mana)
		self.max_mana = self.max_mana + (stat_mana * sign);
	if (stat_daml)
	{
		self.dama = self.dama + (stat_dama * sign);
		self.daml = self.daml + (stat_daml * sign);
	}
	if (stat_spec) // special effects
	{
		if (sign > 0)
			self.spec = self.spec | stat_spec;
		else
			self.spec = self.spec - (self.spec & stat_spec);
	}
	if (stat_lit)
		self.lit = self.lit + stat_lit * sign;
	if (stat_fire)
		self.fire = self.fire + stat_fire * sign;
	if (stat_poison)
		self.poidam = self.poidam + stat_poison * sign;
		
	GenStat(1);
	if (stat_loc & BODY)
	{
		if (self.player)
		{
			if (sign == -1)
				self.player.skin = 0;
			else 
				self.player.skin = stat_action;
		}
	}
	else if (stat_it == IT_LESSER_HEAL)
	{
		// heal potion
		if (self.health >= self.max_health)
			return FALSE;
		self.health = self.health + 15;
		boundstats(self);
	}
	else if (stat_it == IT_HEAL_POTION)
	{
		// heal potion
		if (self.health >= self.max_health)
			return FALSE;
		self.health = self.health + 30;
		boundstats(self);
	}
	else if (stat_it == IT_GREATER_HEAL)
	{
		// heal potion
		if (self.health >= self.max_health)
			return FALSE;
		self.health = self.health + 60;
		boundstats(self);
	}
	else if (stat_it == IT_LESSER_MANA)
	{
		// mana potion
		if (self.mana >= self.max_mana)
			return FALSE;
		self.mana = self.mana + 10;
		boundstats(self);
	}
	else if (stat_it == IT_MANA_POTION)
	{
		// mana potion
		if (self.mana >= self.max_mana)
			return FALSE;
		self.mana = self.mana + 25;
		boundstats(self);
	}
	else if (stat_it == IT_GREATER_MANA)
	{
		// mana potion
		if (self.mana >= self.max_mana)
			return FALSE;
		self.mana = self.mana + 60;
		boundstats(self);
	}
	else if (stat_loc & RIGHTARM)
	{
		if (sign == -1)
			self.rightarm = 0;
		else
			self.rightarm = stat_it;
	}
	else if (stat_loc & LEFTARM)
	{
		if (stat_it != IT_ARROWS)
		{
			if (sign == -1)
				self.leftarm = 0;
			else
				self.leftarm = stat_it;
		}
	}
	else if (stat_action)
	{
		if (cast_aground(stat_action))
		{
			self = self.player;
			spell_fire(stat_action);
			self = self.owner;
		}
	}
	
	if (stat_loc & SPELL)
	{
		// scrolls
		if (sign == -1)
			self.spell = 0;
		else if (stat_it == IT_SCROLL)
			self.spell = stat_spell | 32;
		else
			self.spell = stat_spell;
		return TRUE;
	}
	if (stat_loc & (EQUIPABLE))
		if (stat_loc & STACKABLE)
			self.armorvalue = stat_dur;
	if (stat_spell)
		SetSpellLevel(self, stat_spell, sign);

	return TRUE;

};

float(float slot) Use =
{
	local float it
	it = GetSlot(slot);
	
	if (canuse(it))
	{
		if (stat_loc & USE_ON_ITEM)
		{
			self.weapon = pow2(slot);
			openmenu(self, m_useon, self);
		}
		else if (stat_loc & USABLE)
		{
			if (UseItem(1))
			{
				sound(self, CHAN_AUTO, itemsound(stat_it), 1, ATTN_NORM);	

				if (stat_loc & STACKABLE)
				{

					stat_dur = stat_dur - 1;
					if (stat_dur > 0)
						it = setstat();
					else
						it = 0;
	
					SetSlot(slot, it);

				}
				else
					SetSlot(slot, 0);
				boundstats(self);
			}
			return TRUE;
		}
	}
	return FALSE;
};