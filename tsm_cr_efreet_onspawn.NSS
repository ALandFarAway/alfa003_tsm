//
//  System Name : Scrying
//     Filename : tsm_cr_efreet_onspawn
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

void main()

	{
	effect eAOE = EffectAreaOfEffect(AOE_MOB_FIRE, "tsm_aoe_fire_onenter", "tsm_aoe_fire_onhb", "tsm_aoe_fire_onexit", "aoe_fire");
    //ApplyEffectToObject(DURATION_TYPE_PERMANENT, eAOE, OBJECT_SELF);
	ExecuteScript("acf_cre_onspawnin", OBJECT_SELF);
	ActionSpeakString("Free! FREE! FREEEEE!");
	ActivateLongTermBuffs(OBJECT_SELF);
	DelayCommand(2.0, SetScale(OBJECT_SELF, 1.5, 1.5, 1.5));
	DelayCommand(4.0, SetScale(OBJECT_SELF, 2.0, 2.0, 2.0));
	DelayCommand(5.0, ActionSpeakString("Wait. No! Bound! *Howls, fire exploding outward from it in sudden rage.* Still bound by the wizard and his electrum child!", TALKVOLUME_TALK));
	DelayCommand(6.0, SetScale(OBJECT_SELF, 2.5, 2.5, 2.5));
	DelayCommand(8.0, SetScale(OBJECT_SELF, 3.0, 3.0, 3.0));
	DelayCommand(10.0, ActionSpeakString("I am the curse of Horace-Re; I am the scourge of Scions. I am EFREET, sent to slay, not to serve!", TALKVOLUME_TALK));
	DelayCommand(15.0, ActionSpeakString("Bound by trickery; bound by the power of the very Diadem I was sent to recover; bound into the void gem with which he had violated the Diadem; bound to serve him by barring intruders from his resting place and taking in the deaths that were fed to me!", TALKVOLUME_TALK));
	DelayCommand(25.0, ActionSpeakString("All shall suffer; all shall be separated, part from part!", TALKVOLUME_TALK));
	
	
	
	 
}