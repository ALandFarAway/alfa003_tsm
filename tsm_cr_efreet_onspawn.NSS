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

void ActionCreateWynCreature(string sCreature, location lLocCreature)
{
    CreateObject(OBJECT_TYPE_CREATURE, sCreature, lLocCreature);
}

void main()

	{
	ClearAllActions(TRUE);
	ActionSpeakString("Free! FREE! FREEEEE!");
	ActionSpeakString("I am the curse of Horace-Re; I am the scourge of Scions. I am EFREET, sent to slay, not to serve!", TALKVOLUME_TALK);
	DelayCommand(1.5, ClearAllActions(TRUE));
	DelayCommand(2.0, SetScale(OBJECT_SELF, 1.5, 1.5, 1.5));
	DelayCommand(3.5, ClearAllActions(TRUE));
	DelayCommand(4.0, SetScale(OBJECT_SELF, 2.0, 2.0, 2.0));
	DelayCommand(4.5, ClearAllActions(TRUE));
	DelayCommand(5.0, ActionSpeakString("Wait. No! Bound! *Howls, fire exploding outward from it in sudden rage.* Still bound by the wizard and his electrum child!", TALKVOLUME_TALK));
	DelayCommand(5.5, ClearAllActions(TRUE));
	DelayCommand(6.0, SetScale(OBJECT_SELF, 2.5, 2.5, 2.5));
	DelayCommand(7.5, ClearAllActions(TRUE));
	DelayCommand(8.0, SetScale(OBJECT_SELF, 3.0, 3.0, 3.0));
	DelayCommand(14.5, ClearAllActions(TRUE));
	DelayCommand(15.0, ActionSpeakString("Bound by trickery; bound by the violated power of the very Diadem I was sent to recover!", TALKVOLUME_TALK));
	DelayCommand(24.5, ClearAllActions(TRUE));
	DelayCommand(25.0, ActionSpeakString("All shall suffer; all shall be separated, part from part! Let the harpies fly!", TALKVOLUME_TALK));
	DelayCommand(25.5, ClearAllActions(TRUE));
	DelayCommand(26.0, ActionCreateWynCreature("009_cr_mh_harpy4", GetLocation(OBJECT_SELF)));
	DelayCommand(26.0, ActionCreateWynCreature("009_cr_mh_harpy4", GetLocation(OBJECT_SELF)));
	DelayCommand(26.0, ActionCreateWynCreature("009_cr_mh_harpy4", GetLocation(OBJECT_SELF)));
	DelayCommand(26.0, ActionCreateWynCreature("009_cr_mh_harpy4", GetLocation(OBJECT_SELF)));
	DelayCommand(26.0, ActionCreateWynCreature("009_cr_mh_harpy4", GetLocation(OBJECT_SELF)));
	DelayCommand(26.0, ActionCreateWynCreature("009_cr_mh_harpy4", GetLocation(OBJECT_SELF)));
	
	
	 
}