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
//  This script calls the ACR's onenter event handler for a 
//	script sequence. It is not updated in ACR updates.
//
//  Revision History
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#include "acr_trigger_i"

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
void ActionCreateWynPlaceable(string sPlaceable, location lLocPlaceable)
{
    CreateObject(OBJECT_TYPE_PLACEABLE, sPlaceable, lLocPlaceable);
}
////////////////////////////////////////////////////////////////////////////////
// Function Definitions ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

void main()
{
    ACR_TriggerOnEnter();

    object oEntered = GetEnteringObject();
	object oPhaedra = GetObjectByTag("003_cr_bane_bp_elthonds", 0);
	object oCrystal = GetObjectByTag("rr_crystal_green_door", 0);
	effect eBeamGreen = EffectBeam(VFX_BEAM_GREEN_DRAGON_ACID, oCrystal, BODY_NODE_CHEST, FALSE);
	effect eHowl = EffectVisualEffect(VFX_FNF_HOWL_MIND, FALSE);
	effect eQuake = EffectVisualEffect(VFX_SPELL_HIT_EARTHQUAKE, FALSE);
	effect eShake = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE, FALSE);
	effect eSummonGreen = EffectVisualEffect(VFX_DUR_ENTANGLE, FALSE);
	object oOrc = GetWaypointByTag("rr_ext_orc_spawn");
	object oTworcAnkh = CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_hu_orc_hieroq", GetLocation(oOrc));	   
	object oTworcCobra = CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_hu_orc_hiero2",  GetLocation(oOrc));	   
	object oTworcPriest = CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_hu_orc_hiero4",  GetLocation(oOrc));	   
	object oTworcSphinx = CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_hu_orc_hieron",  GetLocation(oOrc));	   
	object oSayen = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_slv_gaysisayen", GetLocation(oOrc));
	effect eFreeze = EffectCutsceneImmobilize();
	effect eKnockdown = EffectKnockdown();
	effect eDeath = EffectDeath(TRUE, TRUE, TRUE, TRUE);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFreeze, oSayen, 30.0);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFreeze, oTworcAnkh, 10.0);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFreeze, oTworcCobra, 10.0);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFreeze, oTworcPriest, 10.0);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFreeze, oTworcSphinx, 10.0);
	
	
	SendMessageToAllDMs(GetName(oEntered) + " entered" + GetName(OBJECT_SELF));
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eShake, oEntered, 20.0);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eQuake, oEntered, 20.0);
	if(ReflexSave(oEntered, 20, SAVING_THROW_TYPE_DIVINE, oSayen) == 0) {
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnockdown, oEntered, 20.0);
		}		 
	
	if((GetLocalInt(OBJECT_SELF, "Fired") == 0) && ((GetIsPC(oEntered)) || (GetIsDMPossessed(oEntered)))) 
			{SendMessageToAllDMs(GetName(OBJECT_SELF) + " firing.");
			 SetLocalInt(OBJECT_SELF, "Fired", 1);
			 AssignCommand(oSayen, ClearAllActions(TRUE));
			 AssignCommand(oTworcAnkh, ClearAllActions(TRUE));
			 AssignCommand(oTworcCobra, ClearAllActions(TRUE));
			 AssignCommand(oTworcPriest, ClearAllActions(TRUE));
			 AssignCommand(oTworcSphinx, ClearAllActions(TRUE));
			 DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamGreen, oTworcAnkh, 20.0));
			 DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamGreen, oTworcCobra, 20.0));
			 DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamGreen, oTworcPriest, 20.0));
			 DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamGreen, oTworcSphinx, 20.0));
			 DelayCommand(3.0, AssignCommand(oSayen, ActionSpeakString("I WAS GYASI SAYEN. ALL...ALL IS LOST. ALL IS DEATH.", TALKVOLUME_TALK)));
			 DelayCommand(6.0, AssignCommand(oTworcAnkh, ActionSpeakString("De-Khan Thar!", TALKVOLUME_TALK)));
			 DelayCommand(6.0, AssignCommand(oTworcPriest, ActionSpeakString("*Orcish* The Khan commands us!", TALKVOLUME_TALK)));
			 DelayCommand(7.0, AssignCommand(oTworcCobra, ActionSpeakString("De-Khan Thar!", TALKVOLUME_TALK)));
			 DelayCommand(7.0, AssignCommand(oTworcSphinx, ActionSpeakString("*Orcish* We die for you, great lord Khan!", TALKVOLUME_TALK)));
			 DelayCommand(8.0, AssignCommand(oSayen, ActionCastSpellAtLocation(SPELL_MASS_INFLICT_CRITICAL_WOUNDS, GetLocation(oTworcAnkh), METAMAGIC_NONE, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
			 DelayCommand(9.0, AssignCommand(oSayen, ClearAllActions(TRUE)));
			 DelayCommand(10.0, AssignCommand(oCrystal, ActionCastSpellAtLocation(SPELL_CIRCLE_OF_DEATH, GetLocation(oTworcAnkh), METAMAGIC_NONE, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
			 DelayCommand(15.0, AssignCommand(oSayen, ActionSpeakString("You are reborn in crystal. I will have what is mine. The rest belongs to SET!", TALKVOLUME_TALK)));
			 DelayCommand(15.0, AssignCommand(oCrystal, ActionSpeakString("*A green light flares then gradually fades, darkening, darkening, until it is sucking light from the surroundings instead of illuminating.", TALKVOLUME_TALK)));
			 DelayCommand(15.0, ActionCreateWynCreature("003_cr_ud_swwraith_orc", GetLocation(oTworcAnkh)));
			 DelayCommand(15.0, ActionCreateWynEffect("tsm_afx_ajoc_black_cloud_big", GetLocation(oCrystal)));
			 DelayCommand(16.0, ActionCreateWynCreature("003_cr_ud_swwraith_orc", GetLocation(oTworcCobra)));
			 DelayCommand(17.0, ActionCreateWynCreature("003_cr_ud_swwraith_orc", GetLocation(oTworcPriest)));
			 DelayCommand(18.0, ActionCreateWynCreature("003_cr_ud_swwraith_orc", GetLocation(oTworcSphinx)));
			 DelayCommand(18.0, ActionCreateWynPlaceable("abr_plc_crystal_dm_blc", GetLocation(oCrystal)));
			 
			 DestroyObject(oSayen, 20.0);
			 
			 DelayCommand(20.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oTworcAnkh));
			 DelayCommand(20.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oTworcCobra));
			 DelayCommand(20.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oTworcPriest));
			 DelayCommand(20.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oTworcSphinx));
			 DelayCommand(21.0, AssignCommand(GetNearestObjectByTag("003_cr_ud_swwraith_orc", oCrystal, 1), ActionSpeakString("*Orcish* My...master....", TALKVOLUME_TALK)));
			 DelayCommand(22.0, AssignCommand(GetNearestObjectByTag("003_cr_ud_swwraith_orc", oCrystal, 2), ActionSpeakString("*Screams a horrible shriek of realization", TALKVOLUME_TALK)));
			 DelayCommand(23.0, AssignCommand(GetNearestObjectByTag("003_cr_ud_swwraith_orc", oCrystal, 3), ActionSpeakString("*Moans*", TALKVOLUME_TALK)));
			 DelayCommand(24.0, AssignCommand(GetNearestObjectByTag("003_cr_ud_swwraith_orc", oCrystal, 4), ActionSpeakString("*Orcish* What has...been done...to....", TALKVOLUME_TALK)));
			 
			 }
	    
}