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

	ActivateLongTermBuffs(OBJECT_SELF);
	ExecuteScript("acf_cre_onspawnin", OBJECT_SELF);
	object oInvisoCaster = GetObjectByTag("003_cr_invis_caster", 0);
	object oSayen = GetObjectByTag("003_cr_slv_gyasisayen", 0);
	object oOrb = GetObjectByTag("phalorm_globe_black", 0);
	effect eLight = EffectVisualEffect(VFX_DUR_GLOW_RED, FALSE);
	
		
	ActionSpeakString("Master Sayen. *Kneels, pale-faced, and is ignored.", TALKVOLUME_TALK);
	 
}