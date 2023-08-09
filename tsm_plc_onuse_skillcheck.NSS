////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ACR Configuration File
//     Filename : acf_trg_onenter.nss
//    $Revision:: 236        $ current version of the file
//        $Date:: 2007-01-21#$ date the file was created or modified
//       Author : Cipher
//
//    Var Prefix:
//  Dependencies:
//
//  Description
//  This script calls the ACR's OnEnter code for triggers, and any
//  custom code a server may need. It is not updated in ACR updates.
//
//  Revision History
//  2007/01/20  Cipher  Inception
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#include "acr_placeable_i"
#include "acr_quest_i"
#include "acr_spawn_i"



////////////////////////////////////////////////////////////////////////////////
// Constants ///////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Structures //////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Global Variables ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Function Prototypes /////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Function Definitions ////////////////////////////////////////////////////////

void ACR_ApplyNLDDamageToCreature(object oTarget, int nSubdualDamage)
{
    int nNLDTotal = _GetNLDTotal(oTarget);
    int nHPMax = GetMaxHitPoints(oTarget);
    int nCap = nHPMax + 10;
    nNLDTotal = ((nNLDTotal + nSubdualDamage) > nCap) ? nCap :
            nNLDTotal + nSubdualDamage;
    _SetNLDTotal(oTarget, nNLDTotal);
    ACR_ApplyNLDEffects(oTarget, nNLDTotal);
}



////////////////////////////////////////////////////////////////////////////////


void main()
{
    ACR_PlaceableOnUsed();

    // Custom code goes here.
	object oPC = GetLastUsedBy();
    int nSkillDC = GetLocalInt(OBJECT_SELF, "SKILL_DC_INT");
	string sSkillName = GetLocalString(OBJECT_SELF, "SKILL_NAME_STRING");
	int nSkillName = SKILL_BALANCE;
	if(sSkillName == "CLIMB")
		{nSkillName = SKILL_CLIMB;
		 object oRope = GetFirstItemInInventory(oPC); 
		 string sRope = GetTag(oRope);
		 while (oRope != OBJECT_INVALID) {
		 if(FindSubString(sRope, "Rope", 0)!=-1) {
			nSkillDC = nSkillDC - 10;
			SendMessageToPC(oPC, "The rope you carry comes in handy in situations like this. It makes the climb significantly easier.");
			break;
			}
		 oRope = GetNextItemInInventory(oPC);
		}
	}
	if(sSkillName == "JUMP")
		{nSkillName = SKILL_JUMP;}
	if(sSkillName == "SWIM")
		{nSkillName = SKILL_SWIM;}
	if(sSkillName == "SURVIVAL")
		{nSkillName = SKILL_SURVIVAL;}
	int nPCRoll = d20(1);
	int nPCRank = GetSkillRank(nSkillName, oPC, FALSE);
	int nPCTotal = nPCRoll + nPCRank;
	string sMessageSuccess=GetLocalString(OBJECT_SELF, "MESSAGE_SUCCESS_STRING");
	string sMessageFail=GetLocalString(OBJECT_SELF, "MESSAGE_FAIL_STRING");
	string sSpeakFail=GetLocalString(OBJECT_SELF, "SPEAKSTRING_FAIL");
	string sSpeakSuccess=GetLocalString(OBJECT_SELF, "SPEAKSTRING_SUCCESS");
	string sWPSuccess=GetLocalString(OBJECT_SELF, "WP_SUCCESS_STRING");
	string sWPSuccessFurther=GetLocalString(OBJECT_SELF, "WP_SUCCESS_STRING_FURTHER");
	string sWPFail=GetLocalString(OBJECT_SELF, "WP_FAIL_STRING");
	string sWPFailFurther=GetLocalString(OBJECT_SELF, "WP_FAIL_STRING_FURTHER");
	object oWPSuccess = GetNearestObjectByTag(sWPSuccess);
	object oWPSuccessFurther = GetNearestObjectByTag(sWPSuccessFurther);
	object oWPFail = GetNearestObjectByTag(sWPFail);
	object oWPFailFurther = GetNearestObjectByTag(sWPFailFurther);
	int nKnockdown = GetLocalInt(OBJECT_SELF, "KNOCKDOWN");
	effect eKnockdown = EffectKnockdown();
	float fKDTime = GetLocalFloat(OBJECT_SELF, "KDTIME");
	int nFallDistance = GetLocalInt(OBJECT_SELF, "FAIL_DISTANCE");	
	int nFallDamage = Random(6*nFallDistance/10) + (nFallDistance/10);
	int nTumbleDmg = nFallDamage - Random(6) - Random(6);
	effect eDamage = EffectDamage(nFallDamage, DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_NORMAL, FALSE);
	effect eTumbleDmg = EffectDamage(nTumbleDmg, DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_NORMAL, FALSE);
	
	SendMessageToPC(oPC,  "<color=cyan>" + GetName(oPC) + ":</color> <color=lightblue>SKILL: " + sSkillName + ": " + IntToString(nPCRoll) + " + " + IntToString(nPCRank) + " = " + IntToString(nPCTotal) + " vs DC" + IntToString(nSkillDC) + "</color>");
			
	float fStage = 1.0;
			 
 		
		if(nPCTotal >= nSkillDC)
		 	{DelayCommand(fStage, AssignCommand(oPC, ActionJumpToLocation(GetLocation(oWPSuccess))));
		 	 DelayCommand(fStage, SendMessageToPC(oPC, sMessageSuccess));
			 DelayCommand(fStage, AssignCommand(oPC, ActionSpeakString(sSpeakSuccess)));
			 
			 if((oWPSuccessFurther != OBJECT_INVALID) && (sWPSuccessFurther != "")) {
				DelayCommand(fStage *2, AssignCommand(oPC, ActionJumpToLocation(GetLocation(oWPSuccessFurther))));
		 	 	}
				
			 }
			 
	 	else {
			 SendMessageToPC(oPC, sMessageFail);
			 DelayCommand(fStage, AssignCommand(oPC, ActionJumpToLocation(GetLocation(oWPFail))));
		 	 if(GetIsSkillSuccessful(oPC, SKILL_TUMBLE, nSkillDC, TRUE))
			 	{SendMessageToPC(oPC, "Your ability to tumble keeps your on your feet and saves you from hurting yourself *too* badly.");
			 	 ApplyEffectToObject(DURATION_TYPE_INSTANT, eTumbleDmg, oPC);
			     ACR_ApplyNLDDamageToCreature(oPC, d6());
				 DelayCommand(1.0, ACR_NLD_ReportTotal(oPC, oPC, 0));
				}
			 else   
			 	{ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oPC);
			     if(nKnockdown == 1) { 
					 ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnockdown, oPC, fKDTime);
					 SendMessageToPC(oPC, "You are knocked flat!");
			 	     }
					 
				 if((nPCTotal <= 1) && (oWPFailFurther != OBJECT_INVALID)  && (sWPFailFurther != "")) {
					DelayCommand(fStage *2 , SendMessageToPC(oPC, "You hit hard, and bounce."));
				 	DelayCommand(fStage *2, AssignCommand(oPC, ActionJumpToLocation(GetLocation(oWPFailFurther))));
			 	 	DelayCommand(fStage *2, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oPC));
			     	}		
				}
			 }   
}