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
	SetFirstName(oInvisoCaster, "Gyasi Sayen");
	object oOrb = GetObjectByTag("phalorm_orb_black", 0);
	int nHP = GetCurrentHitPoints(oOrb);
	
	effect eDmg = EffectDamage(10, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_NORMAL, TRUE);	
	AssignCommand(oInvisoCaster, DelayCommand(1.0, ActionSpeakString("*A figure shimmers out of the tallest black crystal and hovers.", TALKVOLUME_TALK)));
	AssignCommand(oInvisoCaster, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmg, oOrb));	
	AssignCommand(oInvisoCaster, DelayCommand(5.0, ActionSpeakString("I am Gyasi Sayen, Scion of House Sayen. My unlife was the lock upon the curse of Horus-Re. My destruction left open its doorway.", TALKVOLUME_TALK)));
	DelayCommand(6.0, AssignCommand(oInvisoCaster, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmg, oOrb)));
	AssignCommand(oInvisoCaster, DelayCommand(15.0, ActionSpeakString("Fight by my side, for the efreet comes!", TALKVOLUME_TALK)));
	DelayCommand(16.0, AssignCommand(oInvisoCaster, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmg, oOrb)));
	DelayCommand(17.0, AssignCommand(oInvisoCaster, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmg, oOrb)));
	DelayCommand(18.0, AssignCommand(oInvisoCaster, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmg, oOrb)));
	DelayCommand(19.0, AssignCommand(oInvisoCaster, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmg, oOrb)));
	DelayCommand(25.0, AssignCommand(oInvisoCaster, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmg, oOrb)));
	DelayCommand(26.0, AssignCommand(oInvisoCaster, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmg, oOrb)));
	DelayCommand(36.0, AssignCommand(oInvisoCaster, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmg, oOrb)));
	DelayCommand(46.0, AssignCommand(oInvisoCaster, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmg, oOrb)));
	DelayCommand(56.0, AssignCommand(oInvisoCaster, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmg, oOrb)));
	
	
	 
}