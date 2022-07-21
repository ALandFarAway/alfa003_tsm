//
//    Filename : tsm_cr_efreet_onspawn
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
	ActivateLongTermBuffs(OBJECT_SELF);
	object oEfreet = OBJECT_SELF;
	object oInvisoCaster = GetObjectByTag("003_cr_invis_caster", 0);
	SetFirstName(oInvisoCaster, "Efreet of Set");
	object oOrb = GetObjectByTag("phalorm_orb_black", 0);
		
	AssignCommand(oInvisoCaster, DelayCommand(5.0, ActionSpeakString("I am the curse of Horace-Re; I am the scourge of Scions. I am EFREET, sent to slay!", TALKVOLUME_TALK)));
	AssignCommand(oInvisoCaster, DelayCommand(6.0, SetScale(oEfreet, 1.25, 1.25, 1.25)));
	AssignCommand(oInvisoCaster, DelayCommand(10.0, SetScale(oEfreet, 1.5, 1.5, 1.5)));
	AssignCommand(oInvisoCaster, DelayCommand(16.0, SetScale(oEfreet, 1.75, 1.75, 1.75)));
	AssignCommand(oInvisoCaster, DelayCommand(20.0, SetScale(oEfreet, 2.0, 2.0, 2.0)));
	AssignCommand(oInvisoCaster, DelayCommand(15.0, ActionSpeakString("Bound by trickery; bound by the wizard and his electrum child; bound by the violated power that compels me!", TALKVOLUME_TALK)));
	AssignCommand(oInvisoCaster, DelayCommand(25.0, ActionSpeakString("All shall suffer; all shall be separated, part from part! Let the harpies fly!", TALKVOLUME_TALK)));
	AssignCommand(oInvisoCaster, DelayCommand(26.0, ActionCreateWynCreature("009_cr_mh_harpy4", GetLocation(OBJECT_SELF))));
	AssignCommand(oInvisoCaster, DelayCommand(28.0, ActionCreateWynCreature("009_cr_mh_harpy4", GetLocation(OBJECT_SELF))));
	AssignCommand(oInvisoCaster, DelayCommand(30.0, ActionCreateWynCreature("009_cr_mh_harpy4", GetLocation(OBJECT_SELF))));
	AssignCommand(oInvisoCaster, DelayCommand(32.0, ActionCreateWynCreature("009_cr_mh_harpy4", GetLocation(OBJECT_SELF))));
	
	
	 
}