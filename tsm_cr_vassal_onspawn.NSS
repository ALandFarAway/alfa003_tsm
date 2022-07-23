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

	//ActivateLongTermBuffs(OBJECT_SELF);
	ClearAllActions(TRUE);
	DelayCommand(0.5, ActionSpeakString("Master Sayen. *Many voices speak in chorus", TALKVOLUME_TALK));
	effect eFreeze = EffectCutsceneImmobilize();
	DelayCommand(1.0, ExecuteScript("acf_cre_onspawnin_buffed", OBJECT_SELF));
	DelayCommand(2.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFreeze, OBJECT_SELF, 25.0));
	 
		
	 
}