// THIS SCRIPT IS NOT A PART OF ACR

#include "acr_xp_i"
#include "acr_time_i"
#include "acr_db_persist_i"


void main(string plot, int gp, int xp, float reset_days, float cr)
{
	object oPC = GetPCSpeaker();
	string name = "i_rst_"+plot;
	string sQuest = "i_qst_"+plot;
	int val = ACR_GetGameDaysSinceStart();
	int nState = ACR_GetPersistentInt(oPC, sQuest);
	SendMessageToPC(oPC, sQuest + " = " + IntToString(nState));
	SendMessageToAllDMs(sQuest + " = " + IntToString(nState));
	SendMessageToPC(oPC, "fabs(cr) = " + FloatToString(fabs(cr)));
	SendMessageToPC(oPC, "EPSILON = " + FloatToString(EPSILON));
	SendMessageToPC(oPC, "acr_quest_simple_reward");
	SendMessageToAllDMs("acr_quest_simple_reward");
	
	if (fabs(cr) < EPSILON) {
		cr = 0.0;
	}


	// val = RL days, converted into game days (truncate)
	val = val+ FloatToInt(reset_days*ACR_GetGameToRealTimeRatio());
	SendMessageToPC(oPC, "val = " + IntToString(val));
	SendMessageToAllDMs("val = " + IntToString(val));
	
	ACR_AwardStaticQuestXP(oPC,plot,xp,cr); 
   
	// Prevent re-doing until n days
	ACR_SetPersistentInt(oPC, name, val);
	int nRestState = ACR_GetPersistentInt(oPC, name);
	SendMessageToPC(oPC, name + " = " + IntToString(nRestState));
	SendMessageToAllDMs(name + " = " + IntToString(nRestState));
	
	GiveGoldToCreature(oPC,gp);
	
}