//
//  System Name : Mage's Private Sanctum
//     Filename : tsm_sanctum_onenter
//      Version : 0.1
//         Date : 7/8/22
//       Author : Wynna
//
//  Description
//  This script handles on enter actions for the area of effect Mage's Private Sanctum.
//  It is not updated in ACR updates.
//
//  Revision History
////////////////////////////////////////////////////////////////////////////////

//	Wynna - 7/8/2022

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
#include "acr_trigger_i"
#include "X0_I0_SPELLS"


void main()
{
    ACR_TriggerOnEnter();

	object oTarget = GetEnteringObject();
	effect eDmg = EffectDamage(d6(1), DAMAGE_TYPE_FIRE, DAMAGE_POWER_NORMAL, FALSE);
	effect eFireHit = EffectVisualEffect(VFX_IMP_PULSE_FIRE, FALSE);
	object oEfreet = GetAreaOfEffectCreator(OBJECT_SELF);
	string sEfreet = GetName(oEfreet);
	
	if(GetTag(oTarget) != "abr_cr_ou_efreet_lord") {
		ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmg, oTarget);
		ApplyEffectToObject(DURATION_TYPE_INSTANT, eFireHit, oTarget);
		SendMessageToPC(oTarget, "The aura of the " + sEfreet + " burns you!");
	}			
		  
}