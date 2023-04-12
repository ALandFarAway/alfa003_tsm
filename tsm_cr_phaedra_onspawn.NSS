//
//     Filename : tsm_cr_phaedra_onspawn
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


void main() {

	ExecuteScript("acf_cre_onspawnin_buffed", OBJECT_SELF);
	ClearAllActions(TRUE);
	effect eAOE = EffectAreaOfEffect(AOE_MOB_FEAR);
	effect eAnti = EffectVisualEffect(VFX_DUR_ANTI_LIGHT_10);
	effect eDoom = EffectVisualEffect(VFX_DUR_AOE_CREEPING_DOOM);
	effect eGhost = EffectVisualEffect(VFX_DUR_GHOSTLY_PULSE);
	effect eSmoke = EffectVisualEffect(VFX_DUR_GHOST_SMOKE);
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eAOE, OBJECT_SELF);
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, OBJECT_SELF);
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDoom, OBJECT_SELF);
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eAnti, OBJECT_SELF);
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSmoke, OBJECT_SELF);
	object oSayen = GetObjectByTag("003_cr_slv_gyasisayen", 0);
	if((oSayen != OBJECT_INVALID) && (GetDistanceBetween(OBJECT_SELF, oSayen) > 0.0)&& (GetDistanceBetween(OBJECT_SELF, oSayen) < 10.0)) {
		vector vSayen = GetPositionFromLocation(GetLocation(oSayen));
		SetFacingPoint(vSayen, TRUE);
		AssignCommand(OBJECT_SELF, ActionPlayAnimation(ANIMATION_FIREFORGET_KNEELTALK, 1.0, 3.0));
		ActionSpeakString("Master.", TALKVOLUME_TALK);
	}
	/*object oBertilak = GetObjectByTag("003_pc_bertilak_2", 0);
	object oPC = GetFirstPC(TRUE);
	while(oPC != OBJECT_INVALID) {
		string sPCName = GetName(oPC);
		if(FindSubString(sPCName, "Bert") != -1) {
			oBertilak = oPC;
			}
		
	oPC = GetNextPC(TRUE);
	}
 */
}