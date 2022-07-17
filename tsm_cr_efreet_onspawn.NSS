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
	
}