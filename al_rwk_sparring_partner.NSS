// Create a subdual sparring partner of appropriate level and class at RWK
#include "acr_creature_i"

void main()
{
	
	object oPC = GetPCSpeaker();
	object oSparringWP = GetWaypointByTag("rwk_bout_wp");   
	
	int nHitDice = GetHitDice(oPC);
	
	string sBarb = "003_cr_argent_spearman";
	string sFighter = "003_cr_argent_swordsman";
	string sRanger = "003_cr_argent_tracker";
	string sRogue = "003_cr_argent_sapper";
	string sFgtRg = "003_cr_argent_scout2";
	string sFgtRgB = "003_cr_argent_scout";
	string sRgrRg = "003_cr_argent_skirmisher";
	string sRgrRgB = "003_cr_argent_skirmisher2";
	string sSparringPartner;
	int nRandPartner = d6(1);
	if(nHitDice == 1) 	{
		nRandPartner = d4(1);
		if(nRandPartner == 1) {
			sSparringPartner = sBarb;
		}
		else if(nRandPartner == 2) {
			sSparringPartner = sFighter;
		}
		else if(nRandPartner == 3) {
			sSparringPartner = sRanger;
		}
		else if(nRandPartner == 4) {
			sSparringPartner = sRogue;
		}
		
	}
	if(nHitDice == 2) 	{
		if(nRandPartner == 1) {
			sSparringPartner = sBarb;
		}
		else if(nRandPartner == 2) {
			sSparringPartner = sFighter;
		}
		else if(nRandPartner == 3) {
			sSparringPartner = sRanger;
		}
		else if(nRandPartner == 4) {
			sSparringPartner = sRogue;
		}
		else if(nRandPartner == 5) {
			sSparringPartner = sFgtRg;
		}
		else if(nRandPartner == 6) {
			sSparringPartner = sRgrRg;
		}
	 }
	 	if(nHitDice > 2) 	{
		if(nRandPartner == 1) {
			sSparringPartner = sBarb;
		}
		else if(nRandPartner == 2) {
			sSparringPartner = sFighter;
		}
		else if(nRandPartner == 3) {
			sSparringPartner = sRanger;
		}
		else if(nRandPartner == 4) {
			sSparringPartner = sRogue;
		}
		else if(nRandPartner == 5) {
			sSparringPartner = sFgtRgB;
		}
		else if(nRandPartner == 6) {
			sSparringPartner = sRgrRgB;
		}
	}
		
	object oSparringPartner = CreateObject(OBJECT_TYPE_CREATURE, sSparringPartner, GetLocation(oSparringWP), FALSE, "003_cr_argent_rwk_sparring");
	
	if(nHitDice == 1) {
		ResetCreatureLevelForXP(oSparringPartner, 900, FALSE);	
	}
	
	else if(nHitDice == 2) {
		if(nRandPartner < 5) {
			ResetCreatureLevelForXP(oSparringPartner, 1500, FALSE);	
		}
	}
	
	else if(nHitDice > 2) {
		int nSparringXP;		
		if(nHitDice == 3) {nSparringXP = 4500;}
		if(nHitDice == 4) {nSparringXP = 8000;}
		if(nHitDice > 4) {nSparringXP = 12500;}
		if(nRandPartner < 5) {
			ResetCreatureLevelForXP(oSparringPartner, 1500, FALSE);	
		}
	}	
	
		if(_GetNLDMode(OBJECT_SELF) == FALSE) {
			ACR_ToggleNLDMode(oSparringPartner);
		}
		SetLocalObject(oSparringPartner, "oTargetChoice", oPC); 
		ActionSpeakString("sparring_partner is " + GetName(GetLocalObject(OBJECT_SELF, "oTargetChoice")), TALKVOLUME_TALK);
		DelayCommand(2.0, ActionSpeakString("2. sparring_partner is " + GetName(GetLocalObject(OBJECT_SELF, "oTargetChoice")), TALKVOLUME_TALK));
		
		
		}
	
