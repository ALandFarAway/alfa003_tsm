////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ACR Configuration File
//     Filename : acf_cre_onendcombatround
//    $Revision:: 280        $ current version of the file
//        $Date:: 2007-03-20#$ date the file was created or modified
//       Author : Cipher
//
//    Var Prefix:
//  Dependencies:
//
//  Description
//  This script calls the ACR's OnEndCombatRound event handler for creatures
//  and any custom code a server may need. It is not updated in ACR updates.
//
//  Revision History
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#include "acr_creature_i"

////////////////////////////////////////////////////////////////////////////////
// Constants ///////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Structures //////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Global Variables ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Function Prototypes /////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Function Definitions ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//Make the caller face oTarget
void SetFacingObject(object oTarget)
{
	vector vFace=GetPosition(oTarget);
	SetFacingPoint(vFace);
}

void main()
{
    ACR_CreatureOnEndCombatRound();

    // Custom code goes here.
	
	//object oAttacker = GetLastAttacker();
	object oTargetSpear = GetNearestObjectByTag("003_cr_argent_spearman_train", OBJECT_SELF,1);
	object oTargetSword = GetNearestObjectByTag("003_cr_argent_swordsman_train", OBJECT_SELF,1);
	object oTargetDummy = GetNearestObjectByTag("abr_pl_mp_pracdummuse", OBJECT_SELF,1);
	float fDistanceSpear = GetDistanceBetween(OBJECT_SELF, oTargetSpear);
	float fDistanceSword = GetDistanceBetween(OBJECT_SELF, oTargetSword);
	object oTargetChoice;
	if((oTargetSpear != OBJECT_INVALID) && (oTargetSword != OBJECT_INVALID)) {
		if(fDistanceSpear <= fDistanceSword) {
			oTargetChoice = oTargetSpear;
		}
		else {oTargetChoice = oTargetSword;}
	}
	
	else if(oTargetSpear != OBJECT_INVALID) {
		oTargetChoice = oTargetSpear;
		}
		
	else if(oTargetSword != OBJECT_INVALID) {
		oTargetChoice = oTargetSword;
		}
		
	else if((oTargetSword == OBJECT_INVALID) && (oTargetSpear == OBJECT_INVALID)) {
		oTargetChoice  = oTargetDummy;
		}

	/*ClearAllActions(TRUE);
	AssignCommand(oTargetChoice, ClearAllActions(TRUE));
	AssignCommand(oTargetChoice, ActionAttack(OBJECT_SELF, TRUE));	
	ActionSpeakString("endcombatround oTargetChoice = " + GetTag(oTargetChoice), TALKVOLUME_TALK);
	ActionAttack(oTargetChoice, TRUE);
	object oBattleSound = GetObjectByTag("githbattle_rwk_object");
	SoundObjectPlay(oBattleSound);
	DelayCommand(1.0, SoundObjectStop(oBattleSound));	
	AssignCommand(oBattleSound, PlaySound("cb_ht_bladeplat1", FALSE));
	AssignCommand(oBattleSound, DelayCommand(2.0, PlaySound("cb_ht_bladeplat2", FALSE)));
	AssignCommand(oBattleSound, DelayCommand(4.0, PlaySound("cb_ht_bladewood1", FALSE)));
	AssignCommand(oBattleSound, DelayCommand(6.0, PlaySound("cb_ht_bladewood2", FALSE)));
	AssignCommand(oBattleSound, DelayCommand(8.0, PlaySound("cb_ht_metblplat1", FALSE)));
	AssignCommand(oBattleSound, DelayCommand(10.0, PlaySound("cb_ht_metblplat2", FALSE)));
	*/
	
	int nNLDTotal = _GetNLDTotal(oTargetChoice);
    int nHPMax = GetMaxHitPoints(oTargetChoice);
	object oCleric = GetObjectByTag("003_cr_ilmater_traveller", 0);
	object oCombatEndWP = GetWaypointByTag("al_training_combat_end_wp");
	 
	
	if((oTargetChoice != oTargetDummy) && (nHPMax - nNLDTotal < 20)) {
		ClearAllActions(TRUE);
		AssignCommand(oTargetChoice, ClearAllActions(TRUE));
		ActionSpeakString("Do you yield?", TALKVOLUME_TALK);
		AssignCommand(oCleric, ActionMoveToObject(oTargetChoice, FALSE, 1.0));
		DelayCommand(1.0, AssignCommand(oCleric, ActionCastSpellAtObject(SPELL_CURE_LIGHT_WOUNDS, oTargetChoice, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, FALSE)));
		DelayCommand(2.0, ActionPlayAnimation(ANIMATION_LOOPING_KNEELIDLE,1.0,5.0));
		DelayCommand(6.0, AssignCommand(oTargetChoice, ActionSpeakString("I yield!", TALKVOLUME_TALK)));
		DelayCommand(8.0, SetFacingObject(oTargetChoice));
		DelayCommand(8.0, AssignCommand(oTargetChoice, SetFacingObject(OBJECT_SELF)));
		DelayCommand(9.0, ActionPlayAnimation(ANIMATION_FIREFORGET_SALUTE,1.0,0.0));
		DelayCommand(9.0, AssignCommand(oTargetChoice, ActionPlayAnimation(ANIMATION_FIREFORGET_SALUTE,1.0,0.0)));
		DelayCommand(10.0, ActionForceMoveToObject(oCombatEndWP, FALSE, 1.0));
		DelayCommand(10.0, AssignCommand(oTargetChoice, ActionForceMoveToObject(oCombatEndWP, FALSE, 1.0)));
		
		}
	
	
    
}