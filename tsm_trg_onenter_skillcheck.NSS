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
////////////////////////////////////////////////////////////////////////////////


void main()
{
    ACR_TriggerOnEnter();

    // Custom code goes here.
	object oPC = GetEnteringObject();
    int nSkillName = GetLocalInt(OBJECT_SELF, "SKILL_NAME_INT");
	int nSkillDC = GetLocalInt(OBJECT_SELF, "SKILL_DC_INT");
	string sMessageSuccess=GetLocalString(OBJECT_SELF, "MESSAGE_SUCCESS_STRING");
	string sMessageFail=GetLocalString(OBJECT_SELF, "MESSAGE_FAIL_STRING");
	string sSkillName = GetLocalString(OBJECT_SELF, "SKILL_NAME_STRING");
	string sWPSuccess=GetLocalString(OBJECT_SELF, "WP_SUCCESS_STRING");
	string sWPFail=GetLocalString(OBJECT_SELF, "WP_FAIL_STRING");
	object oWPSuccess = GetNearestObjectByTag(sWPSuccess);
	object oWPFail = GetNearestObjectByTag(sWPFail);
	int nKnockdown = GetLocalInt(OBJECT_SELF, "KNOCKDOWN");
	effect eKnockdown = EffectKnockdown();
	float fKDTime = GetLocalFloat(OBJECT_SELF, "KDTIME");
	int nFallDistance = GetLocalInt(OBJECT_SELF, "FAIL_DISTANCE");	
	int nFallDamage = Random(6*nFallDistance/10) + (nFallDistance/10);
	effect eDamage = EffectDamage(nFallDamage, DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_NORMAL, FALSE);
	
 if(GetTag(OBJECT_SELF) == "003_tr_skillcheck")
		{ if(GetIsSkillSuccessful(oPC, nSkillName, nSkillDC, TRUE))
		 	{SendMessageToPC(oPC, sMessageSuccess);
			 
		 	}
		}
 if(GetTag(OBJECT_SELF) == "003_trg_skillmove")
		{nSkillName = StringToInt("SKILL_" + sSkillName);
		 if(GetIsSkillSuccessful(oPC, nSkillName, nSkillDC, TRUE))
		 	{SendMessageToPC(oPC, sMessageSuccess);
			 AssignCommand(oPC, ActionJumpToLocation(GetLocation(oWPSuccess)));
		 	 }
		 else{SendMessageToPC(oPC, sMessageFail);
			 AssignCommand(oPC, ActionJumpToLocation(GetLocation(oWPFail)));
		 	 if(nKnockdown == 1)
			 	{ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnockdown, oPC, fKDTime);
				 ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oPC);
				}
			 }
		}
	  
			   
}