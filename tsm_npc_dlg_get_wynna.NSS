// THIS SCRIPT IS NOT A PART OF ACR
// return persistent int shell

#include "acr_db_persist_i"

int StartingConditional(string sName)
{
	object oPC = GetPCSpeaker();
	
	
	if (FindSubString(GetName(oPC),"Wynna",0) != -1) {
		SendMessageToPC(oPC, "Wynna PC identified.");	
		return TRUE;
		}
	return FALSE;
}