////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ACR Configuration File
//     Filename : acf_cr_onperception_tworcsc
//    $Revision:: 280        $ current version of the file
//        $Date:: 2023-04-10#$ date the file was created or modified
//       Author : Wynna
//
//    Var Prefix:
//  Dependencies:
//
//  Description
//  This script calls the ACR's OnPerception event handler for a twisted orc subchief's
//	script sequence. It is not updated in ACR updates.
//
//  Revision History
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#include "acr_creature_i"

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
void ActionCreateWynCreature(string sCreature, location lLocCreature)
{
    CreateObject(OBJECT_TYPE_CREATURE, sCreature, lLocCreature);
}
////////////////////////////////////////////////////////////////////////////////
// Function Definitions ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

void main()
{
    ACR_CreatureOnPerception();

    object oPerceived = GetLastPerceived();
	object oPhaedra = GetObjectByTag("003_cr_bane_bp_elthonds", 0);
	object oCrystal = GetObjectByTag("phalorm_crystal_green_dt1", 0);
	effect eBeamGreen = EffectBeam(VFX_BEAM_GREEN_DRAGON_ACID, oCrystal, BODY_NODE_CHEST, FALSE);
	effect eHowl = EffectVisualEffect(VFX_FNF_HOWL_MIND, FALSE);
	effect eSummonGreen = EffectVisualEffect(VFX_DUR_ENTANGLE, FALSE);
	   
	effect eFreeze = EffectCutsceneImmobilize();
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFreeze, OBJECT_SELF, 30.0);
	
	if(FindSubString(GetTag(oPerceived), "hu_orc_hiero", 0) != -1) {
		if((GetLocalInt(OBJECT_SELF, "Spoken") == 0) && ((GetIsPC(oPerceived)) || (GetIsDMPossessed(oPerceived)))) 
			{SetLocalInt(OBJECT_SELF, "Spoken", 1);
			 ClearAllActions(TRUE);
			 DelayCommand(4.0, ActionSpeakString("De-Khan Thar!", TALKVOLUME_TALK));
			 }
	}
 
	
	if(GetTag(OBJECT_SELF) == "003_cr_dragon_gold_vala") {
		if((GetLocalInt(OBJECT_SELF, "Spoken") == 0) && ((GetIsPC(oPerceived)) || (GetIsDMPossessed(oPerceived)))) 
			{SetLocalInt(OBJECT_SELF, "Spoken", 1);
			 ClearAllActions(TRUE);
			 DelayCommand(10.0, ClearAllActions(TRUE));
			 DelayCommand(10.0, ActionSpeakString("You are wrong. I have come out of...respect, for what was. *Head tilted on long neck, saurian eyes focused on the air", TALKVOLUME_TALK));
			 DelayCommand(25.0, ClearAllActions(TRUE));
			 DelayCommand(25.0, ActionSpeakString("We were younger, and my consort was amused by the novelty of your plight. He suffers now because of it!", TALKVOLUME_TALK));
			 DelayCommand(40.0, ClearAllActions(TRUE));
			 DelayCommand(40.0, ActionSpeakString("No! *Rumbles, wings bristling, then settling* The insult you have done ended such paths!", TALKVOLUME_TALK));
			 DelayCommand(55.0, ClearAllActions(TRUE));
			 DelayCommand(55.0, ActionSpeakString("Look at what you have become! You have won the battle for the lich you claimed to want vengeance upon!", TALKVOLUME_TALK));
			 DelayCommand(70.0, ClearAllActions(TRUE));
			 DelayCommand(70.0, ActionSpeakString("RELEASE HER!  *Roars, wings flaring in a backwash of wind", TALKVOLUME_TALK));
			 }
			}	    
}