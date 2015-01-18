void(string soundfile, float volume) doambient; // Definition from Ambient.qc

float START_OFF = 1;

void() light_setup;                  // Definition from Lights.qc

void() light =                       // Basic Light
{
	light_setup();                          // Setup Light
}; 

void() light_fluoro =                // Light with hum ambient
{
	light_setup();                          // Setup Light
	doambient("ambience/fl_hum1.wav", 0.5); // Spawn Ambient hum sound
	remove(self);
};

void() light_fluorospark =           // Light with buzz ambient
{
	light_setup();                          // Setup Light
	doambient("ambience/buzz1.wav", 0.5); // Spawn ambient buzz sound
	remove(self);
}; 

void() light_torchere =
{
	light_setup();                          // Setup Light
	Precache_Set("progs/candlabr.mdl"); 
	makestatic(self);                       // Static entity. Never changes.

};

void() light_globe =                 // Light with visible globe
{
	Precache_Set("progs/s_light.spr");      // Set model
	makestatic(self);                       // Static entity. Never changes.
};

void() light_torch_small_walltorch = // Light with visible wall torch
{
	doambient("ambience/fire1.wav", 0.5); // Spawn fire ambient sound
	Precache_Set("progs/flame.mdl");        // Set model
	makestatic(self);                       // Static entity. Never changes.

};
                                      
void() light_flame_small_yellow =    // Light with small flame & fire sound
{
	doambient("ambience/fire1.wav", 0.5); // Spawn fire ambient sound
	Precache_Set("progs/flame2.mdl");       // Set model
	makestatic(self);                       // Static entity. Never changes.

};

void() light_flame_large_yellow =    // Light with larger flame & fire sound
{
	Precache_Set("progs/flame2.mdl");       // Set model
	self.frame = 1;                         // Switch to second frame (large)
	doambient("ambience/fire1.wav", 0.5); // Spawn fire ambient sound
	makestatic(self);                       // Static entity. Never changes.

};

void() light_flame_small_white =     // Light with small flame & fire sound
{
	Precache_Set("progs/flame2.mdl");       // Set model
	doambient("ambience/fire1.wav", 0.5); // Spawn fire ambient sound
	makestatic(self);                       // Static entity. Never changes.

};
                       
void() light_setup =   // Set light on or off, as per spawnflags
{
	if (self.style < 32) {remove(self);return;} // Dont switch other styles.

	if (self.spawnflags & START_OFF)  
		lightstyle(self.style, "a");    // If light starts off, set it off.
	else
		lightstyle(self.style, "m");    // If light starts ON, turn in ON. Simple :)
};

void() LightStyles_setup =
{
	 // Setup light animation tables. 'a' is total darkness, 'z' is maxbright.
	
	lightstyle(0,"m");                                   // Style 0: Normal
	lightstyle(1,"mmnmmommommnonmmonqnmmo");             // Style 1: Flicker
	                                                     // Style 2: Slow Strong
	                                                     //          Pulse
	lightstyle(2,"abcdefghijklmnopqrstuvwxyzyxwvutsrqponmlkjihgfedcba");
	lightstyle(3,"mmmmmaaaaammmmmaaaaaabcdefgabcdefg");  // Style 3: Candle
	lightstyle(4,"mamamamamama");                        // Style 4: Fast Strobe
	lightstyle(5,"jklmnopqrstuvwxyzyxwvutsrqponmlkj");    // Style 5: Gentle Pulse
	lightstyle(6,"nmonqnmomnmomomno");                   // Style 6: Flicker 2
	lightstyle(7,"mmmaaaabcdefgmmmmaaaammmaamm");        // Style 7: Candle 2
	                                                     // Style 8: Candle 3
	lightstyle(8,"mmmaaammmaaammmabcdefaaaammmmabcdefmmmaaaa"); 
	lightstyle(9,"aaaaaaaazzzzzzzz");                    // Style 9: Slow Strobe
	lightstyle(10,"m");          // Style 10: Fluro
	                                                     // Style 11: Slow Pulse
	                                                     //           (no black)
	lightstyle(11,"abcdefghijklmnopqrrqponmlkjihgfedcba"); 
};