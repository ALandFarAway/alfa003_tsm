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
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFreeze, OBJECT_SELF, 8.0);
	
	if(GetTag(OBJECT_SELF) == "003_cr_slv_gyasisayen") {
		if((GetLocalInt(OBJECT_SELF, "Spoken") == 0) && (FindSubString(GetTag(oPerceived), "hu_orc_hiero", 0) != -1)) 
			{SetLocalInt(OBJECT_SELF, "Spoken", 1);
			 ClearAllActions(TRUE);
			 DelayCommand(3.0, ActionSpeakString("Go, and return to me what is mine.", TALKVOLUME_TALK));
			 DelayCommand(4.0, ActionCastSpellAtLocation(SPELL_CREATE_GREATER_UNDEAD, GetLocation(oPerceived), METAMAGIC_NONE, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
			 DelayCommand(9.0, ClearAllActions(TRUE));
			 DestroyObject(OBJECT_SELF, 20.0);
			 }
	}
	
	if(FindSubString(GetTag(oPerceived), "hu_orc_hiero", 0) != -1) {
		if((GetLocalInt(OBJECT_SELF, "Spoken") == 0) && (GetIsPC(oPerceived))) 
			{SetLocalInt(OBJECT_SELF, "Spoken", 1);
			 ClearAllActions(TRUE);
			 DelayCommand(4.0, ActionSpeakString("De-Khan Thar!", TALKVOLUME_TALK));
			 DelayCommand(5.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamGreen, OBJECT_SELF, 10.0));
			 DelayCommand(6.0, ActionCreateWynCreature("003_cr_ud_swwraith_orc", GetLocation(OBJECT_SELF)));
			 DelayCommand(7.0, AssignCommand(oCrystal, ActionCastSpellAtLocation(SPELL_CIRCLE_OF_DEATH, GetLocation(oPerceived), METAMAGIC_NONE, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
			 DestroyObject(OBJECT_SELF, 10.0);
			 }
	}
 
		    
}