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
	
	string sMessage1 = "Nice!";
	string sMessage2 = "A hit!";
	string sMessage3 = "Oh ho!";
	string sMessage4 = "Missed!";
	string sMessage5 = "Feck!";
	string sMessage6 = "Hells!";
	string sMessage7 = "Yield?";
	string sMessage8 = "Shite!";
	string sMessage9 = "Close!";
	string sMessage10 = "Ouch!";
	 
	
	int nSpeak = d4(1);
	if(nSpeak ==1) {
	int nMessage = d10(1);
	 
	if(nMessage == 1) ActionSpeakString(sMessage1, TALKVOLUME_TALK);
    if(nMessage == 2) ActionSpeakString(sMessage2, TALKVOLUME_TALK);
    if(nMessage == 3) ActionSpeakString(sMessage3, TALKVOLUME_TALK);
    if(nMessage == 4) ActionSpeakString(sMessage4, TALKVOLUME_TALK);
    if(nMessage == 5) ActionSpeakString(sMessage5, TALKVOLUME_TALK);
    if(nMessage == 6) ActionSpeakString(sMessage6, TALKVOLUME_TALK);
    if(nMessage == 7) ActionSpeakString(sMessage7, TALKVOLUME_TALK);
    if(nMessage == 8) ActionSpeakString(sMessage8, TALKVOLUME_TALK);
    if(nMessage == 9) ActionSpeakString(sMessage9, TALKVOLUME_TALK);
    if(nMessage == 10) ActionSpeakString(sMessage10, TALKVOLUME_TALK);
    }    
	
	
	if((oTargetChoice != oTargetDummy) && (nHPMax - nNLDTotal < 5)) {
		AssignCommand(oCleric, ActionMoveToObject(oTargetChoice, FALSE, 1.0));
		AssignCommand(oTargetChoice, ClearAllActions(TRUE));
		ClearAllActions(TRUE);
		DelayCommand(1.0, AssignCommand(oCleric, ActionCastSpellAtObject(SPELL_CURE_MODERATE_WOUNDS, oTargetChoice, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, FALSE)));
		DelayCommand(2.0, ClearAllActions(TRUE));
		DelayCommand(2.0, AssignCommand(oTargetChoice, ClearAllActions(TRUE)));
		DelayCommand(7.0, SetFacingObject(oTargetChoice));
		DelayCommand(7.5, AssignCommand(oTargetChoice, SetFacingObject(OBJECT_SELF)));
		DelayCommand(9.0, ActionPlayAnimation(ANIMATION_FIREFORGET_SALUTE,1.0,0.0));
		DelayCommand(9.0, AssignCommand(oTargetChoice, ActionPlayAnimation(ANIMATION_FIREFORGET_SALUTE,1.0,0.0)));
		DelayCommand(15.0, ActionForceMoveToObject(oCombatEndWP, FALSE, 0.5));
		DelayCommand(15.5, AssignCommand(oTargetChoice, ActionForceMoveToObject(oCombatEndWP, FALSE, 0.5)));
		DelayCommand(25.0, ActionForceMoveToObject(oCombatEndWP, FALSE, 0.5));
		DelayCommand(25.5, AssignCommand(oTargetChoice, ActionForceMoveToObject(oCombatEndWP, FALSE, 0.5)));
		
		}
	
	
    
}