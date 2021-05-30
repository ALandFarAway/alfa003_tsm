// THIS SCRIPT IS NOT A PART OF ACR
// return persistent int shell

#include "acr_db_persist_i"

int StartingConditional(string sName)
{
	object oPC = GetPCSpeaker();
	SendMessageToPC(oPC, "Wynna PC identified.");
	
	if (FindSubString(GetName(oPC),"Wynna",0) != -1)
		return TRUE;
		
	return FALSE;
}