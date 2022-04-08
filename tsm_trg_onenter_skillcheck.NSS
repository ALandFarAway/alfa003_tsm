//Custom Skill Checks with Messages and Results
// Wynna 03/05/22

#include "acr_trigger_i"
#include "acr_traps_i"
#include "acr_quest_i"
#include "acr_spawn_i"
#include "acr_skills_i"
#include "acr_language_i"
#include "dmfi_inc_tool"
#include "dmfi_inc_english"
#include "acr_door_i"

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


void main()
{
    ACR_TriggerOnEnter();

    object oPC = GetEnteringObject();
	
	if((GetLocalInt(OBJECT_SELF, GetName(oPC)) != 1) || (GetIsDMPossessed(oPC))) {
	    SetLocalInt(OBJECT_SELF, GetName(oPC), 1);
	
	int nSkillDC = GetLocalInt(OBJECT_SELF, "SKILL_DC_INT");
	string sMessageSuccess=GetLocalString(OBJECT_SELF, "MESSAGE_SUCCESS_STRING");
	string sMessagePartial=GetLocalString(OBJECT_SELF, "MESSAGE_PARTIAL_STRING");
	string sMessageFail=GetLocalString(OBJECT_SELF, "MESSAGE_FAIL_STRING");
	int	nSkill = GetLocalInt(OBJECT_SELF, "2DA_SKILL_NUMBER");
	int nSkillRoll = d20() + GetSkillRank(nSkill, oPC, FALSE);
	string sMessage = sMessageFail;
	string sSucceed = "FAILS";
	if(nSkillRoll >= nSkillDC - 5) {sSucceed = "PARTIALLY succeeds"; sMessage= sMessagePartial;}
	if(nSkillRoll >= nSkillDC) {sSucceed = "SUCCEEDS"; sMessage= sMessageSuccess;}
	string sSkill = "";
	if(nSkill == 6) {sSkill = "Listen";}
	if(nSkill == 14) {sSkill = "Search";}
	if(nSkill == 30) {sSkill = "Balance";}
	if(nSkill == 31) {sSkill = "Climb";}
	if(nSkill == 39) {sSkill = "Jump";}
	
	
	
	SendMessageToAllDMs(GetName(oPC) + " rolls " + IntToString(nSkillRoll) + " against " + IntToString(nSkillDC) + " " + sSkill + " DC on " + GetName(OBJECT_SELF)); 
					
	//For language checks
	string sLanguage = GetLocalString(OBJECT_SELF, "LANGUAGE");
	int nUnderstands = 0;
	object oTool = DMFI_GetTool(oPC);
	int n;
	int nMax = GetLocalInt(oTool, "LanguageMAX");
	string sTest;
	// All languages stored in lower case strings.
	sLanguage = GetStringLowerCase(sLanguage);
	for (n=0; n<nMax; n++)
	{
		sTest = GetLocalString(oTool, "Language" + IntToString(n));
		SendMessageToAllDMs(sLanguage + " = " + sLanguage);
		if (sTest==sLanguage) {
		nUnderstands = 1;
		}
	}
 
	//For skills that involve potentially falling
	string sWPSuccess=GetLocalString(OBJECT_SELF, "WP_SUCCESS_STRING");
	string sWPFail=GetLocalString(OBJECT_SELF, "WP_FAIL_STRING");
	object oWPSuccess = GetNearestObjectByTag(sWPSuccess, OBJECT_SELF, 1);
	object oWPFail = GetNearestObjectByTag(sWPFail, OBJECT_SELF, 1);
	int nKnockdown = GetLocalInt(OBJECT_SELF, "KNOCKDOWN");
	effect eKnockdown = EffectKnockdown();
	float fKDTime = GetLocalFloat(OBJECT_SELF, "KDTIME");
	int nFallDistance = GetLocalInt(OBJECT_SELF, "FALL_DISTANCE");	
	int nFallDamage = d6(nFallDistance/10);
	int nTumbleDamage = nFallDamage/2;
	effect eDamage = EffectDamage(nFallDamage, DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_NORMAL, FALSE);
	effect eTumbleDmg = EffectDamage(nTumbleDamage, DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_NORMAL, FALSE);
	
	//Listen
		if(nSkill == 6) {
			if(nSkillRoll >= nSkillDC)
		 		{if(nUnderstands == 1) {sMessage= sMessageSuccess;}
			else if(nSkillRoll >= nSkillDC - 5) {sMessage = sMessagePartial;}
				}
		  	}
	
	//Search
		if(nSkill == 14) {
		
			//For secret doors
			string sDoorPlc = GetLocalString(OBJECT_SELF, "DOOR_PLC_TAG");
			object oDoorPlc = GetNearestObjectByTag(sDoorPlc, OBJECT_SELF, 1);
			string sDoor = GetLocalString(OBJECT_SELF, "DOOR_TAG");
			object oDoor = GetObjectByTag(sDoor, 0);
			string sDoorWP = GetLocalString(OBJECT_SELF, "DOOR_WP_TAG");
			object oDoorWP = GetWaypointByTag(sDoorWP);
			sMessageSuccess = GetLocalString(oDoor, "MESSAGE_SUCCESS_STRING");
			sMessagePartial = GetLocalString(oDoor, "MESSAGE_PARTIAL_STRING");
			
			if((oDoorPlc != OBJECT_INVALID) || (oDoor != OBJECT_INVALID)) {
				if(nSkillRoll >= nSkillDC) {
					sMessage= sMessageSuccess;
					DestroyObject(oDoorPlc);
					SetUseableFlag(oDoor, 1);
					SetTrapDetectable(oDoor, TRUE);
					SetTrapDetectDC(oDoor, 0);
				}
				else if(nSkillRoll >= nSkillDC - 5)
					{SetUseableFlag(oDoor, TRUE);
					 SetTrapDetectable(oDoor, TRUE);
					 sMessage= sMessagePartial;
					}
			}
			
			//For mechanical traps. Success reveals mechanical bypass and trap. Partial reveals trap.
			
			string sTrapPlc = GetLocalString(OBJECT_SELF, "TRAP_PLC_TAG");
			string sTrapTrg = GetLocalString(OBJECT_SELF, "TRAP_TRG_TAG");
			object oTrapPlc = GetNearestObjectByTag(sTrapPlc, OBJECT_SELF, 1);
			object oTrapTrg = GetNearestObjectByTag(sTrapTrg, OBJECT_SELF, 1);
			string sTrapDesc = GetLocalString(oTrapPlc, "TRAP_DESCRIPTION");
			object oTrap;
			if((oTrapPlc != OBJECT_INVALID) || (oTrapTrg != OBJECT_INVALID)) {
				if (sTrapDesc != "") {
					 oTrap = GetNearestTrapToObject(oPC, TRUE);
					}
				if(nSkillRoll >= nSkillDC)
				 	 {SetDescription(oTrap, sTrapDesc);
					  SetUseableFlag(oTrapPlc, TRUE);
					  SetTrapDetectable(oTrapPlc, TRUE);
					  SetTrapDetectDC(oTrapPlc, 0);
					  SetTrapDetectable(oTrapTrg, TRUE);
					  SetTrapDetectDC(oTrapTrg, 0);
					  DestroyObject(OBJECT_SELF, 6.0);
					  sMessage= sMessageSuccess;
					  }
				else if(nSkillRoll >= nSkillDC - 5)
					{SetUseableFlag(oTrapPlc, TRUE);
					 SetTrapDetectable(oTrapPlc, TRUE);
					 SetTrapDetectDC(oTrapPlc, 0);
					 sMessage= sMessagePartial;
					}
				}
		 }
		
				
	//Movement
		if((nSkill == 30) || (nSkill == 31) || (nSkill == 39)) {
			if(nSkillRoll >= nSkillDC)
		 	 	{AssignCommand(oPC, ActionJumpToLocation(GetLocation(oWPSuccess)));
			 	 AssignCommand(oPC, ActionSpeakString("*Arrives safely*", TALKVOLUME_TALK));
				 }
			 else if(GetHasSpellEffect(SPELL_FEATHER_FALL, oPC)) {
			 	 effect eFeatherFall = GetFirstEffect(oPC);
					while(GetIsEffectValid(eFeatherFall)) {
						int nFeatherFall = FALSE;
						int nEffectType = GetEffectType(eFeatherFall);
						int nEffectSubType = GetEffectSubType(eFeatherFall);
						SendMessageToAllDMs(GetName(oPC) + ": " + IntToString(nEffectType) + " = Type. " + IntToString(nEffectSubType) + " = SubType.");
						eFeatherFall = GetNextEffect(oPC);
					}
					
				 SendMessageToPC(oPC, "Falls...but a Feather Fall spell makes you float safely down.");
				 AssignCommand(oPC, ActionJumpToLocation(GetLocation(oWPSuccess)));
			 	 AssignCommand(oPC, ActionSpeakString("*Falls...and floats down safely.*", TALKVOLUME_TALK));
				 
			 	}
		 	 else {
				 AssignCommand(oPC, ActionSpeakString("*Falls!*", TALKVOLUME_TALK));
				 DelayCommand(1.0, AssignCommand(oPC, ActionJumpToLocation(GetLocation(oWPFail))));
			 	 if(GetIsSkillSuccessful(oPC, SKILL_TUMBLE, nSkillDC, TRUE))
				 	{SendMessageToPC(oPC, sMessageFail);
				     SendMessageToPC(oPC, "You land heavily, but your ability to tumble saves you from hurting yourself worse than you did.");
				 	 ApplyEffectToObject(DURATION_TYPE_INSTANT, eTumbleDmg, oPC);
				     ACR_ApplyNLDDamageToCreature(oPC, d6());
					 DelayCommand(1.0, ACR_NLD_ReportTotal(oPC, oPC, 0));
					}
				 else   
				 	{ApplyEffectToObject(DURATION_TYPE_INSTANT, eTumbleDmg, oPC);
				     if(nKnockdown == 1) { 
						 DelayCommand(2.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnockdown, oPC, fKDTime));
						 SendMessageToPC(oPC, sMessageFail);
				         SendMessageToPC(oPC, "You fail to tumble to a safe landing and hurt yourself!");
				 	     }
					}
				 }
			}
		
		SendMessageToPC(oPC, sMessage);
		SendMessageToAllDMs(sMessage);
		}
	  
	  
			
}		   