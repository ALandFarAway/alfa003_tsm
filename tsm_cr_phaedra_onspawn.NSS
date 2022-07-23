//
//     Filename : tsm_cr_phaedra_onspawn
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
	ActionSpeakString("Master Sayen. *Kneels, tears streaming from her good eye, pale-faced... and is ignored.", TALKVOLUME_TALK);
	//ExecuteScript("acf_cre_onspawnin", OBJECT_SELF);
	 
}