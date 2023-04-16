//
//     Filename : tsm_cr_sayen_onspawn
//      Version : 0.1
//         Date : 7/18/22
//       Author : Wynna
//
//  Description
//  This script handles onspawn functions for a high level necromancer.
//	It is not updated in ACR updates.
//
//  Revision History
////////////////////////////////////////////////////////////////////////////////

//	Wynna - 7/8/2022

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////

#include "acr_spawn_i"

void ActionCreateWynCreature(string sCreature, location lLocCreature)
{
    CreateObject(OBJECT_TYPE_CREATURE, sCreature, lLocCreature);
}

void main() {

	object oCrystal = GetObjectByTag("rr_crystal_green_door", 0);
	effect eBeamGreen = EffectBeam(VFX_BEAM_GREEN_DRAGON_ACID, oCrystal, BODY_NODE_CHEST, FALSE);
	effect eFreeze = EffectCutsceneParalyze();
	effect eDeath = EffectDeath(TRUE, TRUE, TRUE, TRUE);
	object oTrigger = GetObjectByTag("rr_trg_onenter_script", 0);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFreeze, OBJECT_SELF, 20.0);
	AssignCommand(OBJECT_SELF, ClearAllActions(TRUE));
	DelayCommand(5.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamGreen, OBJECT_SELF, 20.0));
	if(GetTag(OBJECT_SELF) == "abr_cr_hu_orc_hieroq") {DelayCommand(6.0, ActionSpeakString("De-Khan Thar!", TALKVOLUME_TALK));}
	if(GetTag(OBJECT_SELF) == "abr_cr_hu_orc_hieron") {DelayCommand(8.0, ActionSpeakString("*Orcish* The Khan commands us!", TALKVOLUME_TALK));}
	if(GetTag(OBJECT_SELF) == "abr_cr_hu_orc_hiero2") {DelayCommand(10.0, ActionSpeakString("De-Khan Thar!", TALKVOLUME_TALK));}
	if(GetTag(OBJECT_SELF) == "abr_cr_hu_orc_hiero4") {DelayCommand(12.0, ActionSpeakString("*Orcish* We die for you, great lord Khan!", TALKVOLUME_TALK));}
	DelayCommand(25.0, AssignCommand(oTrigger, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, OBJECT_SELF)));
			 
	
		 		 		 		 
}