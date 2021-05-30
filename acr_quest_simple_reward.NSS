// THIS SCRIPT IS NOT A PART OF ACR

#include "acr_xp_i"
#include "acr_time_i"
#include "acr_db_persist_i"


void main(string plot, int gp, int xp, float reset_days, float cr)
{
	object oPC = GetPCSpeaker();
	string name = "i_rst_"+plot;
	string sQuest = "i_qst_"+plot;
	int nState = ACR_GetPersistentInt(oPC, sQuest);
	int val = ACR_GetGameDaysSinceStart();
	SendMessageToPC(oPC, "fabs(cr) = " + FloatToString(fabs(cr)));
	SendMessageToPC(oPC, "EPSILON = " + FloatToString(EPSILON));
	SendMessageToPC(oPC, sQuest + " = " + IntToString(nState));
	
	if (fabs(cr) < EPSILON) {
		cr = 0.0;
	}


	// val = RL days, converted into game days (truncate)
	val += FloatToInt(reset_days*ACR_GetGameToRealTimeRatio());
	SendMessageToPC(oPC, "val = " + IntToString(val));
	
	GiveGoldToCreature(oPC,gp);
	ACR_AwardStaticQuestXP(oPC,plot,xp,cr); 
   
	// Prevent re-doing until n days
	ACR_SetPersistentInt(oPC, name, val);
}