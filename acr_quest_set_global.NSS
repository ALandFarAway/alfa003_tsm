// THIS SCRIPT IS NOT A PART OF ACR
// set persistent int shell
#include "acr_db_persist_i"


void main(string plot, int val)
{
    object oPC = GetPCSpeaker();
	string name = "i_qst_"+plot;
	//SendMessageToPC(oPC, "acr_quest_set_global");
	SendMessageToAllDMs("acr_quest_set_global");
	
	ACR_SetPersistentInt(oPC, name, val);
	
	//SendMessageToPC(oPC, name + " = " + IntToString(ACR_GetPersistentInt(oPC, name)));
	SendMessageToAllDMs(name + " = " + IntToString(ACR_GetPersistentInt(oPC, name)));
	
}