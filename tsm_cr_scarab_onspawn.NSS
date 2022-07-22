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

void main() {

	ExecuteScript("acf_cre_onspawnin", OBJECT_SELF);
	object oScarab = OBJECT_SELF;
	object oInvisoCaster = GetObjectByTag("003_cr_invis_caster", 0);
	object oOrb = GetObjectByTag("phalorm_orb_black", 0);
	effect eLight = EffectVisualEffect(VFX_DUR_GLOW_RED, FALSE);
	
		
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLight, OBJECT_SELF, 900.0);
	ActionForceMoveToObject(oOrb, TRUE, 0.5);
	DelayCommand(5.0, ActionSpeakString("*Scuttles off of Nioniel and climbs into the crystal globe", TALKVOLUME_TALK));
	DestroyObject(OBJECT_SELF, 10.0);
	
	 
}