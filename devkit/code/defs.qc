.void()         die;

nosave float story;
nosave float itemvalue;
nosave float monsvalue;
nosave entity activator;
nosave string string_null;    // null string, nothing should be held here
nosave var void() nullfunc;
nosave float mplayer;
nosave float netplay;
nosave float active_inv;

nosave entity boss;

.float story_min, story_max;

.void() think1;
.string map, message;
.float worldtype, delay, wait, lip, light_lev, speed, style, skill;
.vector finalangle;

.string wad;
.string killtarget;
.vector pos1, pos2, mangle, dest1;

// ----------
// game variables
.entity camera, player;
.float attack_finished, pausetime;
.entity _targ, drawonlytoclient, spellprop;

// npcs
.float ai;

// stats
//#define mana currentammo

nosave var .float mana = currentammo;

.float max_health, max_mana;
.float ac, tohit, dodge, dama, daml;
.float exp, spells1, spells2;
.float spell, spec;
.string bkup_model;

.float lit, fire, poidam;
.float rightarm, leftarm;

.float str, dex,vit, mag;
.float luck, agil, ptd;

// menu stuff
.float menu, m_refresh, m_expire;
.entity m_subject;
.void() m_func, use, action;

// print stuff
nosave float red, chars, lines; 
float RED_ON = 128;
float RED_OFF = 0;
float WIDTH = 30;


// inventory
.float slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8;
.float equip, droprandom;

nosave var .float lvl = frags;

nosave var .float obs_angle = light_lev;
nosave var .float obs_count = lip;

// item statistics --->
// basic
nosave float stat_price, stat_dur, stat_loc, stat_pref, stat_suf, stat_it;
nosave float stat_max_dur;
// requirements
nosave float stat_req_str, stat_req_mag, stat_req_dex, stat_req_vit, stat_req_luck;
nosave float stat_req_agil, stat_req_lvl;
// granted stats
nosave float stat_str, stat_mag, stat_dex, stat_vit, stat_luck, stat_agil;
nosave float stat_toall;

// weapon damage..l = low end, a = amount of variation
nosave float stat_daml, stat_dama;
// modifiers for generated stats ...?
nosave float stat_tohit, stat_dodge, stat_mana, stat_health;
// armor defense & spell stuff
nosave float stat_def, stat_spell;
// magic damage
nosave float stat_fire, stat_poison, stat_lit, stat_spec;
// is it identified? action when equipped
nosave float stat_id, stat_action;

.float slow_factor, slow_time, shield_time, shield_factor;
.float summon_count;

.float regen_time;


float EQUIPABLE = 1;
float STACKABLE = 2;
float USABLE = 4;
float DURABILITY = 8;

float LOC = 2032;
float BODY = 16;
float HEAD = 32;
float RIGHTARM = 64;
float LEFTARM = 128;
float TWO_HAND = 192;
float NECK = 256;
float SPELL = 512;
float FEET = 1024;
float USE_ON_ITEM = 2048;

float SPEED = 1;
float STEAL_LIFE = 2;
float REGEN_LIFE = 4;
float STEAL_MANA = 8;
float KNOCKBACK = 16;
float INDESTRUCTIBLE = 32;
float DAMATTACKER = 64;
float REGEN_MANA = 128;

// sloppy cursor crap
// tidy up
.vector cursorpos;
.vector rotang;
.vector testorg;
.entity cursor, wayp, sbarsub;
.float gotstuff;
.float dbltime;
.float scale;

.string target1, target2, target3, target4;
.string message1, message2, message3;
.string noise4;
.float value;

.float fade, fadetime;
.float monnum;
.float questlog;
float lastmap;
nosave string nextmap;
float runtime;
.float fallz;

nosave var float gameload = 1;
nosave var float numplayers;
nosave var float averagelvl;
nosave var float cache = 1;
nosave var float nomusic;


float BIG_DISTANCE = 1200;
