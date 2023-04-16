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
	object oGS = GetWaypointByTag("rr_ext_gs_spawn");
	object oXav = GetWaypointByTag("rr_ext_xav_spawn");
	effect eFreeze = EffectCutsceneParalyze();
	effect eKnockdown = EffectKnockdown();
	effect eDeath = EffectDeath(TRUE, TRUE, TRUE, TRUE);
	
	
	//SendMessageToAllDMs(GetName(oEntered) + " entered" + GetName(OBJECT_SELF));
	if ((GetIsPC(oEntered)) || (GetIsDMPossessed(oEntered))) {
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eShake, oEntered, 20.0);
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eQuake, oEntered, 20.0);
		if(ReflexSave(oEntered, 20, SAVING_THROW_TYPE_DIVINE, oCrystal) == 0) {
			ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnockdown, oEntered, 20.0);
			}
		 		 
		if(GetLocalInt(OBJECT_SELF, "Fired") == 0) {
			SendMessageToAllDMs(GetName(OBJECT_SELF) + " firing.");
			 SetLocalInt(OBJECT_SELF, "Fired", 1);
			 object oSayen = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_slv_gyasisayen", GetLocation(oGS));
			 ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFreeze, oSayen, 30.0);
			 SetFirstName(oCrystal, "Gyasi Sayen,");
			 SetLastName(oCrystal, "Lich");
			 DelayCommand(3.0, AssignCommand(oCrystal, ActionSpeakString("I WAS GYASI SAYEN. ALL...ALL IS LOST. ALL IS DEATH.", TALKVOLUME_TALK)));
			 DelayCommand(6.0, ActionCreateWynCreature("abr_cr_hu_orc_hieroq", GetLocation(oOrc)));	   
			 DelayCommand(7.0, ActionCreateWynCreature("abr_cr_hu_orc_hiero2",  GetLocation(oOrc)));	   
			 DelayCommand(7.0, ActionCreateWynCreature("abr_cr_hu_orc_twisted",  GetLocation(oOrc)));	   
			 DelayCommand(7.0, ActionCreateWynCreature("abr_cr_hu_orc_twisted",  GetLocation(oOrc)));	   
			 DelayCommand(6.0, SetFirstName(oCrystal, "Twisted Orc,"));
			 DelayCommand(6.0, SetLastName(oCrystal, "Subchief"));
			 DelayCommand(8.0, AssignCommand(oCrystal, ActionSpeakString("De-Khan Thar!", TALKVOLUME_TALK)));
			 DelayCommand(10.0, AssignCommand(oCrystal, ActionSpeakString("*Orcish* The Khan commands us!", TALKVOLUME_TALK)));
			 DelayCommand(12.0, AssignCommand(oCrystal, ActionSpeakString("*Orcish* We die for you, great lord Khan!", TALKVOLUME_TALK)));
			 DelayCommand(14.0, AssignCommand(oCrystal, ActionSpeakString("De-Khan Thar!", TALKVOLUME_TALK)));
			 DelayCommand(15.0, SetFirstName(oCrystal, "Gyasi Sayen,"));
			 DelayCommand(15.0, SetLastName(oCrystal, "Lich"));
			 
			 DelayCommand(16.0, AssignCommand(oCrystal, ActionSpeakString("You are reborn in crystal. I will have what is mine. The rest belongs to SET!", TALKVOLUME_TALK)));
			 DelayCommand(17.0, ActionCreateWynEffect("tsm_afx_black_fog_large", GetLocation(oCrystal)));
			 DelayCommand(24.0, AssignCommand(oCrystal, ActionSpeakString("*A green light flares then gradually fades, darkening, darkening, until it is sucking light from the surroundings instead of illuminating.", TALKVOLUME_TALK)));
			 DelayCommand(24.0, ActionCreateWynPlaceable("abr_plc_crystal_dm_blc", GetLocation(oCrystal)));
			 DestroyObject(oCrystal, 25.0);
			 
			 //DelayCommand(26.0, ActionCreateWynCreature("003_cr_firegen_xavier", GetLocation(oXav)));	   
			 //DelayCommand(40.0, AssignCommand(oCrystal, ActionSpeakString("Giggling INFIDEL! Run from me! *Vanishes", TALKVOLUME_TALK)));
			 
			 DestroyObject(oSayen, 26.0);
			 }
	    }
}