// Menu
void (float it, float eq) inven; // menu.qc
void(entity who, void() menufunc, entity subj) openmenu;
void(entity who) closemenu;
void(entity who, string text, entity subj, float expire) prompt;
void() m_sell;
void() m_repair;
void() m_identify;

// Item stats
entity(float num) get_questitem;
float (float it) canuse;
string(float it) itemmodel;
string(float it) itemsound;
void(float it) simplestat;
void(float it) itemstat;
float(float it) itemcount;
float() setstat;

// Item control
float(float it) pickupitem;
void (float it) dropitem;
float(float sign) UseItem 
float(float slot, float recheck) Unequip;
float(float slot) Equip;
float(float slot) AutoEquip;
float(float slot) Use;
float(float it) takeammo;
void(entity who, float weps) DamageEquipment;

// Stats
void() Restat;
void() Unstat;
void(float sign) GenStat;
void(entity e) boundstats;
void(entity att, entity targ) GiveExp;

// Spells
float(entity e, float spell) GetSpellLevel;
void(entity e, float spell, float level) SetSpellLevel;
float (float sp, float lv) mana_for_spell;
float(float g) spell_range;
float(float sp) cast_aground;
void(float sp) spell_fire;

// Shops/Gold
float(float it, float pref, float suf, float howmuch) takeamount;
void(float howmuch) givegold;

// Shell
void() dovis;
void() precaches;
void() LightStyles_setup;
void() DecodeLevelParms;
string(string s) precache_model;
string(string s) precache_sound;

// Animation
float(float yaw, float run) moveit;

void() bowattack1;
void() attack1;
void() throw1;
void() PlayerDie;


// Generic
float(float s1, float s2, float s3) encode;
float(float parm, float which) decode;
float (float parm, float which, float set) recode;
entity() find_spawn;

// Spawn functions
void() monster_scarite;
void() monster_guanite;
void() monster_drak;
void() monster_horror;
void() item;

// Monsters/Npcs
void(entity e) npc_gettopic;



