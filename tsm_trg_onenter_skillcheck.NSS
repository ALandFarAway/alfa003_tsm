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
#include "acr_trigger_i"
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
    ACR_TriggerOnEnter();

    // Custom code goes here.
	object oPC = GetEnteringObject();
    int nSkillDC = GetLocalInt(OBJECT_SELF, "SKILL_DC_INT");
	string sMessageSuccess=GetLocalString(OBJECT_SELF, "MESSAGE_SUCCESS_STRING");
	string sMessageFail=GetLocalString(OBJECT_SELF, "MESSAGE_FAIL_STRING");
	string sSkillName = GetLocalString(OBJECT_SELF, "SKILL_NAME_STRING");
	int	nSkillName;
	if(sSkillName == "CLIMB")
		{nSkillName = SKILL_CLIMB;}
	else if(sSkillName == "BALANCE")
		{nSkillName = SKILL_BALANCE;}
		
	string sWPSuccess=GetLocalString(OBJECT_SELF, "WP_SUCCESS_STRING");
	string sWPFail=GetLocalString(OBJECT_SELF, "WP_FAIL_STRING");
	object oWPSuccess = GetNearestObjectByTag(sWPSuccess, OBJECT_SELF, 1);
	object oWPFail = GetNearestObjectByTag(sWPFail, OBJECT_SELF, 1);
	int nKnockdown = GetLocalInt(OBJECT_SELF, "KNOCKDOWN");
	effect eKnockdown = EffectKnockdown();
	float fKDTime = GetLocalFloat(OBJECT_SELF, "KDTIME");
	int nFallDistance = GetLocalInt(OBJECT_SELF, "FAIL_DISTANCE");	
	int nTumbleDamage = Random(6*nFallDistance/10) + (nFallDistance/10);
	int nFallDamage = nTumbleDamage*2;
	effect eDamage = EffectDamage(nFallDamage, DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_NORMAL, FALSE);
	effect eTumbleDmg = EffectDamage(nTumbleDamage, DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_NORMAL, FALSE);
	effect eFeatherFall = GetFirstEffect(oPC);
	
	while(GetIsEffectValid(eFeatherFall)) {
		int nFeatherFall = FALSE;
		int nEffectType = GetEffectType(eFeatherFall);
		int nEffectSubType = GetEffectSubType(eFeatherFall);
		SendMessageToPC(oPC, IntToString(nEffectType) + " = Type. " + IntToString(nEffectSubType) + " = SubType.");
		eFeatherFall = GetNextEffect(oPC);
	}
	
	object oRope = GetFirstItemInInventory(oPC); 
	string sRope = GetTag(oRope);
	while (oRope != OBJECT_INVALID) {
	if(FindSubString(sRope, "Rope", 0)!= -1) {
		nSkillDC = nSkillDC - 10;
		SendMessageToPC(oPC, "The rope you carry surely comes in handy in situations like this.");
		break;
		}
	 oRope = GetNextItemInInventory(oPC);
	}
	
	
 if(GetTag(OBJECT_SELF) == "003_tr_skillcheck")
		{ if(GetIsSkillSuccessful(oPC, nSkillName, nSkillDC, TRUE))
		 	{SendMessageToPC(oPC, sMessageSuccess);
			 
		 	}
		}
 if(GetTag(OBJECT_SELF) == "003_trg_skillmove")
		{if(GetIsSkillSuccessful(oPC, nSkillName, nSkillDC, TRUE))
		 	{SendMessageToPC(oPC, sMessageSuccess);
			 AssignCommand(oPC, ActionJumpToLocation(GetLocation(oWPSuccess)));
		 	 AssignCommand(oPC, ActionSpeakString("*Climbs safely*", TALKVOLUME_TALK));
			 }
		 else if(GetHasSpellEffect(SPELL_FEATHER_FALL, oPC)) {
		 	 SendMessageToPC(oPC, "Falls...but a Feather Fall spell makes you float safely down.");
			 AssignCommand(oPC, ActionJumpToLocation(GetLocation(oWPSuccess)));
		 	 AssignCommand(oPC, ActionSpeakString("*Falls...and floats down safely.*", TALKVOLUME_TALK));
			 
		 	}
	 	 else {SendMessageToPC(oPC, sMessageFail);
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
			 	{ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oPC);
			     if(nKnockdown == 1) { 
					 ApplyEffectToObject(DURATION_TYPE_INSTANT, eTumbleDmg, oPC);
			         DelayCommand(2.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnockdown, oPC, fKDTime));
					 SendMessageToPC(oPC, sMessageFail);
			         SendMessageToPC(oPC, "You fail to tumble to a safe landing and hurt yourself!");
			 	     }
				}
			 }
		}
	  
			   
}