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

	ActivateLongTermBuffs(OBJECT_SELF);
	ActionSpeakString("Master Sayen.", TALKVOLUME_TALK);
	object oSayen = GetObjectByTag("003_cr_slv_gyasisayen", 0);
	ActionForceFollowObject(oSayen, 1.0, 0);
	ExecuteScript("acf_cre_onspawnin", OBJECT_SELF);
	 
		
	 
}