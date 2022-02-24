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

void ActionCreateCreature(string sCreature, location lLocPlace)
{
    CreateObject(OBJECT_TYPE_CREATURE, sCreature, lLocPlace, FALSE);
}

void main()
{
    ACR_TriggerOnEnter();

    // Custom code goes here.
	object oPC = GetEnteringObject();

 if((GetTag(OBJECT_SELF) == "tsm_trigger_onenter_pit_trap") && ((GetIsPC(oPC)) || (GetIsDMPossessed(oPC))))
		{string sMessage=GetLocalString(OBJECT_SELF, "ACR_SPAWN_MESSAGE");
		 string sSpeak=GetLocalString(OBJECT_SELF, "ACR_SPAWN_SPEAK");
		 string sJumpTo = GetLocalString(OBJECT_SELF, "ACR_WP_JUMP_TO");
		 object oJumpTo = GetWaypointByTag(sJumpTo);
		 int nDC = GetLocalInt(OBJECT_SELF, "ACR_REFLEX_DC");
		 float fFall = GetLocalFloat(OBJECT_SELF, "ACR_FALL_HEIGHT")/10;
		 int nFallRounded = FloatToInt(fFall);
		 effect eFallDmg = EffectDamage(d6(nFallRounded), DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_NORMAL, FALSE);  
		 string sPLCDestroy = GetLocalString(OBJECT_SELF, "ACR_DESTROY_PLC");
		 object oPLCDestroy = GetNearestObjectByTag(sPLCDestroy, OBJECT_SELF, 1);
		 string sGender = "her";
		 if(GetGender(oPC) == GENDER_MALE) {sGender = "him";}
		 float fDelaySpawnOne = GetLocalFloat(OBJECT_SELF, "ACR_SPAWN_DELAY");
		 float fDelayVFXOne = GetLocalFloat(OBJECT_SELF, "ACR_VFX_DELAY");
		 int nVFX = GetLocalInt(OBJECT_SELF, "ACR_SPAWN_VFX");
		 effect eOne = EffectVisualEffect(nVFX);
	     int nDurationType = GetLocalInt(OBJECT_SELF, "ACR_SPAWN_VFX_DUR_TYPE");
	     float fDurationLength = GetLocalFloat(OBJECT_SELF, "ACR_SPAWN_VFX_LENGTH");
		 
		 int nRunOnce = GetLocalInt(OBJECT_SELF, "RUN_ONCE");
	     
		 if(nRunOnce == 0) {
		 	 SetLocalInt(OBJECT_SELF, "RUN_ONCE", 1);
			 AssignCommand(oPLCDestroy, ActionSpeakString(sSpeak, TALKVOLUME_TALK));
			 SendMessageToPC(oPC, sMessage);
			 ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SCREEN_SHAKE), oPC);
             AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_BACK, 1.0, 5.0));
			 ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_SPELL_HIT_EARTHQUAKE), oPC, 5.0);
			 DestroyObject(oPLCDestroy, 2.0);
			 if(ReflexSave(oPC, nDC, SAVING_THROW_TYPE_TRAP, OBJECT_SELF) < 1) { 
		 		DelayCommand(3.0, SendMessageToPC(oPC, "You are falling!"));
				DelayCommand(3.1, AssignCommand(oPC, ActionSpeakString("*" + GetName(oPC) + " is unable to save " + sGender + "self from falling!", TALKVOLUME_TALK)));
			    DelayCommand(4.0, AssignCommand(oPC, ActionJumpToObject(oJumpTo, FALSE)));
				DelayCommand(4.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFallDmg, oPC)); 
				}
			else {DelayCommand(3.0, SendMessageToPC(oPC, "You stop yourself in time from falling."));
				  DelayCommand(3.1, AssignCommand(oPC, ActionSpeakString("*" + GetName(oPC) + " stops " + sGender + "self from falling.", TALKVOLUME_TALK)));
			     }
			 }  
		}
	   
}