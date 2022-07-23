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


void main() {

	ActivateLongTermBuffs(OBJECT_SELF);
	ClearAllActions(TRUE);
	ActionSpeakString("Master Sayen. *Many voices speak in chorus", TALKVOLUME_TALK);
	ExecuteScript("acf_cre_onspawnin_buffed", OBJECT_SELF);
	 
		
	 
}