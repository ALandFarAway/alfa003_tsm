//
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

void main() {

	ExecuteScript("acf_cre_onspawnin", OBJECT_SELF);
	ActivateLongTermBuffs(OBJECT_SELF);
	object oSayen = OBJECT_SELF;
	object oInvisoCaster = GetObjectByTag("003_cr_invis_caster", 0);
	object oOrb = GetObjectByTag("phalorm_orb_black", 0);
	int nHP = GetCurrentHitPoints(oOrb);
	object oMoveTo = GetWaypointByTag("rr_sayen_move_wp");
	object oOrbGlow = GetObjectByTag("fx_okku_mound_rr", 0);
	effect eLight = EffectVisualEffect(VFX_DUR_LIGHT_RED_20, FALSE);
	
	DestroyObject(oOrbGlow, 1.0);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLight, OBJECT_SELF, 900.0);
	DelayCommand(10.0, ActionSpeakString("*A figure shimmers out of the tallest black crystal and hovers.", TALKVOLUME_TALK));
	DelayCommand(20.0, ActionSpeakString("I am Gyasi Sayen, Scion of House Sayen. My unlife was the lock upon the curse of Horus-Re. My destruction left open its doorway.", TALKVOLUME_TALK));
	DelayCommand(30.0, ActionMoveToObject(oMoveTo, FALSE, 0.5));
	DelayCommand(40.0, ActionSpeakString("My destruction as a lich sent me back to reform in triumph, my powers refreshed!", TALKVOLUME_TALK));
	DelayCommand(50.0, ActionSpeakString("Thou who were strong enough to destroy an age-weakened lich may serve beside me against what shall surely otherwise destroy us all.", TALKVOLUME_TALK));
	DelayCommand(60.0, ActionSpeakString("Fight! Fight for your afterlife. For the curse of Horus-Re was to release me to the mercy of Set!", TALKVOLUME_TALK));
	DelayCommand(70.0, ActionSpeakString("Come to me, those familiars released to my need, and be free upon condition of your aid!", TALKVOLUME_TALK));
	DelayCommand(75.0, ActionCreateWynCreature("003_cr_un_banite_vassal", GetLocation(OBJECT_SELF)));
	DelayCommand(80.0, ActionSpeakString("The Efreet of Set is released!", TALKVOLUME_TALK));
	
	
	 
}