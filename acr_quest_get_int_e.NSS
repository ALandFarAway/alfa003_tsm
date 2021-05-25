// THIS SCRIPT IS NOT A PART OF ACR
// return persistent int shell

#include "acr_db_persist_i"

int StartingConditional(string plot, int value)
{
    object oPC = GetPCSpeaker();
	string name = plot;
	
	if (ACR_GetPersistentInt(oPC, name) == value)
		return TRUE;
		
	return FALSE;
}