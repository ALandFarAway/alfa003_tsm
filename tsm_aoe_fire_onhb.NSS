//
//  System Name : Mage's Private Sanctum
//     Filename : tsm_sanctum_onexit
//      Version : 0.1
//         Date : 7/8/22
//       Author : Wynna
//
//  Description
//  This script handles on heartbeat actions for the area of effect Mage's Private Sanctum.
//  It is not updated in ACR updates.
//
//  Revision History
////////////////////////////////////////////////////////////////////////////////

//	Wynna - 7/8/2022

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
#include "acr_trigger_i"


void main()
{
    ACR_TriggerOnHeartbeat();

	effect eDmg = EffectDamage(d6(1), DAMAGE_TYPE_FIRE, DAMAGE_POWER_NORMAL, FALSE);
	effect eFireHit = EffectVisualEffect(VFX_IMP_PULSE_FIRE, FALSE);
	object oEfreet = GetAreaOfEffectCreator(OBJECT_SELF);
	
	object oTarget= GetFirstInPersistentObject(OBJECT_SELF, OBJECT_TYPE_CREATURE, PERSISTENT_ZONE_ACTIVE);
	while (oTarget != OBJECT_INVALID) {
		if(GetTag(oTarget) != "abr_cr_ou_efreet_lord") {
			ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmg, oTarget);
			ApplyEffectToObject(DURATION_TYPE_INSTANT, eFireHit, oTarget);
			SendMessageToPC(oTarget, "The aura of the ephreet burns you!");
			oTarget= GetNextInPersistentObject(OBJECT_SELF, OBJECT_TYPE_CREATURE, PERSISTENT_ZONE_ACTIVE);
		}
	}   
	
}