//
//     Filename : tsm_cr_scarab_onspawn
//      Version : 0.1
//         Date : 7/18/22
//       Author : Wynna
//
//  Description
//  This script creates an onspawn fire aura for an ephreet lord.
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

void ActionCreateWynItem(string sCreature, object oObject)
{
   CreateItemOnObject(sCreature, oObject, 1, sCreature, TRUE);
}

void main() {

	ExecuteScript("acf_cre_onspawnin", OBJECT_SELF);
	object oScarab = OBJECT_SELF;
	object oInvisoCaster = GetObjectByTag("003_cr_invis_caster", 0);
	object oOrb = GetObjectByTag("phalorm_globe_black", 0);
	effect eLight = EffectVisualEffect(VFX_DUR_GLOW_RED, FALSE);
	effect eEvil = EffectVisualEffect(VFX_HIT_AOE_EVIL, FALSE);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLight, OBJECT_SELF, 10.0);
	ApplyEffectToObject(DURATION_TYPE_INSTANT, eEvil, OBJECT_SELF);
	ActionForceMoveToObject(oOrb, TRUE, 0.5);
	DelayCommand(5.0, ActionSpeakString("*Scuttles off of Nioniel, then blinks out.", TALKVOLUME_TALK));
	DelayCommand(6.0, ActionJumpToObject(oOrb, FALSE));
	DelayCommand(10.0, ActionSpeakString("*Appears beneath the orb and climbs up the black crystal into the orb.", TALKVOLUME_TALK));
	DelayCommand(11.0, ActionCreateWynItem("03_it_amul_scarab_prot", oOrb));
	DestroyObject(OBJECT_SELF, 12.0);
	 
}