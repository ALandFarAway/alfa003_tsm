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
	effect eDmg = EffectDamage(10, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_NORMAL, TRUE);	
	
	DestroyObject(oOrbGlow, 1.0);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLight, OBJECT_SELF, 900.0);
	DelayCommand(1.0, ActionSpeakString("*A figure shimmers out of the tallest black crystal and hovers.", TALKVOLUME_TALK));
	AssignCommand(oOrb, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmg, oOrb));	
	ActionSpeakString("I am Gyasi Sayen, Scion of House Sayen. My unlife was the lock upon the curse of Horus-Re. My destruction left open its doorway.", TALKVOLUME_TALK);
	DelayCommand(5.0, AssignCommand(oOrb, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmg, oOrb)));
	DelayCommand(10.0, ActionMoveToObject(oMoveTo, FALSE, 0.5));
	DelayCommand(15.0, ActionSpeakString("My destruction as a lich sent me back to reform in triumph, my powers refreshed!", TALKVOLUME_TALK));
	DelayCommand(10.0, AssignCommand(oOrb, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmg, oOrb)));
	DelayCommand(15.0, AssignCommand(oOrb, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmg, oOrb)));
	DelayCommand(20.0, AssignCommand(oOrb, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmg, oOrb)));
	DelayCommand(25.0, AssignCommand(oOrb, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmg, oOrb)));
	DelayCommand(25.0, ActionSpeakString("Thou who were strong enough to destroy an age-weakened lich may serve beside me against what shall surely otherwise destroy us all.", TALKVOLUME_TALK));
	DelayCommand(30.0, AssignCommand(oOrb, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmg, oOrb)));
	DelayCommand(35.0, AssignCommand(oOrb, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmg, oOrb)));
	DelayCommand(35.0, ActionSpeakString("Fight! Fight for your afterlife. For the curse of Horus-Re was to release me to the mercy of Set!", TALKVOLUME_TALK));
	DelayCommand(40.0, AssignCommand(oOrb, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmg, oOrb)));
	DelayCommand(45.0, ActionSpeakString("The Efreet of Set is released!", TALKVOLUME_TALK));
	DelayCommand(45.0, AssignCommand(oOrb, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmg, oOrb)));
	DelayCommand(50.0, AssignCommand(oOrb, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmg, oOrb)));
	
	
	 
}