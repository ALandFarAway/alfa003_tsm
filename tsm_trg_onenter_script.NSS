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
void ActionCreateWynEffect(string sEffect, location lLocEffect)
{
    CreateObject(OBJECT_TYPE_PLACED_EFFECT, sEffect, lLocEffect);
}
////////////////////////////////////////////////////////////////////////////////
// Function Definitions ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

void main()
{
    ACR_CreatureOnPerception();

    object oEntered = GetEnteringObject();
	object oPhaedra = GetObjectByTag("003_cr_bane_bp_elthonds", 0);
	object oCrystal = GetObjectByTag("phalorm_crystal_green_dt1", 0);
	effect eBeamGreen = EffectBeam(VFX_BEAM_GREEN_DRAGON_ACID, oCrystal, BODY_NODE_CHEST, FALSE);
	effect eHowl = EffectVisualEffect(VFX_FNF_HOWL_MIND, FALSE);
	effect eSummonGreen = EffectVisualEffect(VFX_DUR_ENTANGLE, FALSE);
	object oTworcAnkh = GetObjectByTag("abr_cr_hu_orc_hieroq", 0);	   
	object oTworcCobra = GetObjectByTag("abr_cr_hu_orc_hiero2", 0);	   
	object oTworcPriest = GetObjectByTag("abr_cr_hu_orc_hiero4", 0);	   
	object oTworcSphinx = GetObjectByTag("abr_cr_hu_orc_hieron", 0);	   
	object oSayen = GetObjectByTag("003_cr_slv_gyasisayen", 0);
	effect eFreeze = EffectCutsceneImmobilize();
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFreeze, oSayen, 30.0);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFreeze, oTworcAnkh, 30.0);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFreeze, oTworcCobra, 30.0);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFreeze, oTworcPriest, 30.0);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFreeze, oTworcSphinx, 30.0);
	SendMessageToAllDMs(GetName(oEntered) + " entered" + GetName(OBJECT_SELF));
	if((GetLocalInt(OBJECT_SELF, "Spoken") == 0) && ((GetIsPC(oEntered)) || (GetIsDMPossessed(oEntered)))) 
			{SendMessageToAllDMs(GetName(OBJECT_SELF) + " firing.");
			 SetLocalInt(OBJECT_SELF, "Spoken", 1);
			 AssignCommand(oSayen, ClearAllActions(TRUE));
			 AssignCommand(oTworcAnkh, ClearAllActions(TRUE));
			 AssignCommand(oTworcCobra, ClearAllActions(TRUE));
			 AssignCommand(oTworcPriest, ClearAllActions(TRUE));
			 AssignCommand(oTworcSphinx, ClearAllActions(TRUE));
			 DelayCommand(3.0, AssignCommand(oSayen, ActionSpeakString("Go, and return to me what is mine. While I occupy her, go!", TALKVOLUME_TALK)));
			 DelayCommand(6.0, AssignCommand(oTworcAnkh, ActionSpeakString("De-Khan Thar!", TALKVOLUME_TALK)));
			 DelayCommand(6.0, AssignCommand(oTworcPriest, ActionSpeakString("*Orcish* The Khan commands us!", TALKVOLUME_TALK)));
			 DelayCommand(7.0, AssignCommand(oTworcCobra, ActionSpeakString("De-Khan Thar!", TALKVOLUME_TALK)));
			 DelayCommand(7.0, AssignCommand(oTworcSphinx, ActionSpeakString("*Orcish* At your command, great lord Khan!", TALKVOLUME_TALK)));
			 DelayCommand(8.0, AssignCommand(oSayen, ActionCastFakeSpellAtLocation(SPELL_CREATE_GREATER_UNDEAD, GetLocation(oCrystal), PROJECTILE_PATH_TYPE_DEFAULT)));
			 DelayCommand(9.0, AssignCommand(oSayen, ClearAllActions(TRUE)));
			 DelayCommand(10.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamGreen, oTworcAnkh, 10.0));
			 DelayCommand(10.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamGreen, oTworcCobra, 10.0));
			 DelayCommand(10.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamGreen, oTworcPriest, 10.0));
			 DelayCommand(10.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamGreen, oTworcSphinx, 10.0));
			 DelayCommand(10.0, AssignCommand(oCrystal, ActionCastSpellAtLocation(SPELL_CIRCLE_OF_DEATH, GetLocation(oTworcAnkh), METAMAGIC_NONE, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
			 DelayCommand(15.0, AssignCommand(oSayen, ActionSpeakString("You are reborn in crystal. Into the portal! *A red light flares. There is a sound like a great fire suddenly alighting, and a wash of cool air that smells of stone and dust.", TALKVOLUME_TALK)));
			 DelayCommand(15.0, ActionCreateWynCreature("003_cr_ud_swwraith_orc", GetLocation(oTworcAnkh)));
			 DelayCommand(16.0, ActionCreateWynCreature("003_cr_ud_swwraith_orc", GetLocation(oTworcCobra)));
			 DelayCommand(17.0, ActionCreateWynCreature("003_cr_ud_swwraith_orc", GetLocation(oTworcPriest)));
			 DelayCommand(18.0, ActionCreateWynCreature("003_cr_ud_swwraith_orc", GetLocation(oTworcSphinx)));
			 DelayCommand(18.0, ActionCreateWynEffect("fx_demon_portal", GetLocation(oCrystal)));
			 
			 DestroyObject(oSayen, 20.0);
			 DestroyObject(oTworcAnkh, 20.0);
			 DestroyObject(oTworcCobra, 20.0);
			 DestroyObject(oTworcPriest, 20.0);
			 DestroyObject(oTworcSphinx, 20.0);
			 DelayCommand(21.0, AssignCommand(GetNearestObjectByTag("003_cr_ud_swwraith_orc", oCrystal, 1), ActionSpeakString("*Orcish* My...master....", TALKVOLUME_TALK)));
			 DelayCommand(22.0, AssignCommand(GetNearestObjectByTag("003_cr_ud_swwraith_orc", oCrystal, 2), ActionSpeakString("*Drifts into the portal.", TALKVOLUME_TALK)));
			 DelayCommand(23.0, AssignCommand(GetNearestObjectByTag("003_cr_ud_swwraith_orc", oCrystal, 3), ActionSpeakString("*Moans*", TALKVOLUME_TALK)));
			 DelayCommand(24.0, AssignCommand(GetNearestObjectByTag("003_cr_ud_swwraith_orc", oCrystal, 4), ActionSpeakString("*Floats toward the crystal.", TALKVOLUME_TALK)));
			 DestroyObject(GetObjectByTag("003_cr_ud_swwraith_orc", 1), 25.0);
			 DestroyObject(GetObjectByTag("003_cr_ud_swwraith_orc", 2), 26.0);
			 DestroyObject(GetObjectByTag("003_cr_ud_swwraith_orc", 3), 27.0);
			 DestroyObject(GetObjectByTag("003_cr_ud_swwraith_orc", 0), 28.0);
			 DelayCommand(30.0, DestroyObject(GetNearestObjectByTag("fx_demon_portal", oCrystal, 1)));
			 DelayCommand(30.0, DestroyObject(GetNearestObject(OBJECT_TYPE_PLACED_EFFECT, oCrystal, 1)));
			 
			 }
	    
}