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
	object oSayen = GetObjectByTag("003_cr_slv_gyasisayen", 0);
	vector vSayen = GetPositionFromLocation(GetLocation(oSayen));
	SetFacingPoint(vSayen, TRUE);
	AssignCommand(OBJECT_SELF, ActionPlayAnimation(ANIMATION_FIREFORGET_KNEELTALK, 1.0, 3.0));
	ActionSpeakString("Master Sayen. *Kneels, tears streaming from her good eye, pale-faced... and is ignored.", TALKVOLUME_TALK);
	
	object oBertilak = GetObjectByTag("003_pc_bertilak_2", 0);
	object oPC = GetFirstPC(TRUE);
	while(oPC != OBJECT_INVALID) {
		string sPCName = GetName(oPC);
		if(FindSubString(sPCName, "Bert") != -1) {
			oBertilak = oPC;
			}
		
	oPC = GetNextPC(TRUE);
	}
	
	SendMessageToPC(oBertilak, "*You see Phaedra look up. When she finds you, she looks at you with murder in her eye.");
    effect eFreeze = EffectCutsceneImmobilize();
	DelayCommand(2.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFreeze, OBJECT_SELF, 15.0));
	
	 
}