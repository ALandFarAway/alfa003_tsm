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
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eAOE, OBJECT_SELF);
	ExecuteScript("acf_cre_onspawnin", OBJECT_SELF);
	ActivateLongTermBuffs(OBJECT_SELF);
	
	int nAppearance = GetAppearanceType(OBJECT_SELF);
	SetCreatureAppearanceType(OBJECT_SELF, APPEARANCE_TYPE_BALOR);

	DelayCommand(2.0, SetCreatureAppearanceType(OBJECT_SELF, APPEARANCE_TYPE_SPHINX));
	
	DelayCommand(4.0, SetCreatureAppearanceType(OBJECT_SELF, APPEARANCE_TYPE_SPHINX));
	
	DelayCommand(6.0, SetCreatureAppearanceType(OBJECT_SELF, APPEARANCE_TYPE_MUMMY_GREATER));
	
	DelayCommand(8.0, SetCreatureAppearanceType(OBJECT_SELF, nAppearance));
	 
}