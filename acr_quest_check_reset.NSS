// THIS SCRIPT IS NOT A PART OF ACR
// Is this valid/reset?
#include "acr_time_i"

int StartingConditional(string plot)
{
	object oPC = GetPCSpeaker();
	string name = "i_rst_"+plot;
	int days = ACR_GetPersistentInt(oPC, name);
	SendMessageToPC(oPC, "acr_quest_check_reset " + name);
	SendMessageToAllDMs("acr_quest_check_reset"  + name);
	SendMessageToPC(oPC, "days = " + IntToString(days));
	SendMessageToAllDMs("days = " + IntToString(days));
	SendMessageToPC(oPC, "Gamedays since start = " + IntToString(ACR_GetGameDaysSinceStart()));
	SendMessageToAllDMs("Gamedays since start = " + IntToString(ACR_GetGameDaysSinceStart()));
	
	return (ACR_GetGameDaysSinceStart() >= days);
}