// THIS SCRIPT IS NOT A PART OF ACR
// return persistent int shell

#include "acr_db_persist_i"

int StartingConditional(string plot)
{
	object oPC = GetPCSpeaker();
	string name = "i_qst_"+plot;
	SendMessageToPC(oPC, name + " = " + IntToString(ACR_GetPersistentInt(oPC, name)));
	
	if (ACR_GetPersistentInt(oPC, name) != 0)
		return TRUE;
		
	return FALSE;
}