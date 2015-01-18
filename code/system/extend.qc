float(string name) checkextension 			= #99; 
float(string s) builtin_find = #100;

nosave float snowtype; // 0 = QuakeC sprites, 1 = TQ flavor, 2 = DP flavor
nosave float fileaccess;
nosave var float fadeinterval = 1;

float(string s) ebfs_stof = #81;
float(string filename, float mode) ebfs_fopen = #110;
void(float fhandle) ebfs_fclose = #111;
string(float fhandle) ebfs_fgets = #112;
void(float fhandle, string s) ebfs_fputs = #113;

// OLD - TODO: Remove me
float(string s) frik_stof = #84;
float(string filename, float mode) frik_open = #86;
void(float handle) frik_close = #87;
string(float handle) frik_read = #88;
void(float handle, string s) frik_write = #89;

nosave var float(string s) stof;
nosave var float(string filename, float mode) fopen;
nosave var void(float handle) fclose;
nosave var string(float handle) read;
nosave var void(float handle, string s) write;

.float alpha;
float FILE_READ = 0;
float FILE_APPEND = 1;
float FILE_WRITE = 2;
float   EF_FULLBRIGHT   = 512;

void() extend =
{
	snowtype = 0;

	if (cvar("pr_checkextension"))
	{
		if (checkextension("DP_TE_PARTICLESNOW"))
			snowtype = 2;
		if (checkextension("TQ_SNOW"))
			snowtype = 1;
		if (checkextension("FRIK_FILE"))
		{
			stof = ebfs_stof;
			fopen = ebfs_fopen;
			fclose = ebfs_fclose;
			read = ebfs_fgets;
			write = ebfs_fputs;
			fileaccess = 1;
		}
		if (checkextension("QSG_FILE"))
		{
			stof = frik_stof;
			fopen = frik_open;
			fclose = frik_close;
			read = frik_read;
			write = frik_read;
			fileaccess = 1;
		}
		if (checkextension("DP_ENT_ALPHA"))
			fadeinterval = 0.01;
	}
	if ( cvar("pr_builtin_find") == 100)
	{
		if (builtin_find("stof") == 81)
			stof = ebfs_stof;
		if (builtin_find("fopen") == 110)
			fopen = ebfs_fopen;
		if (builtin_find("fclose") == 111)
			fclose = ebfs_fclose;
		if (builtin_find("fgets") == 112)
			read = ebfs_fgets;
		if (builtin_find("fputs") == 113)
			write = ebfs_fputs;
		if ((float)stof && (float)fopen && (float)fclose && (float)read && (float)write)
			fileaccess = 1;
	}
};