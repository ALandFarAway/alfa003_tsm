////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ACR Configuration File
//     Filename : acf_cre_onperception
//    $Revision:: 280        $ current version of the file
//        $Date:: 2007-03-20#$ date the file was created or modified
//       Author : Cipher
//
//    Var Prefix:
//  Dependencies:
//
//  Description
//  This script calls the ACR's OnPerception event handler for creatures
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
void ACR_ApplyNLDDamageToCreature(object oTarget, int nSubdualDamage)
{
    int nNLDTotal = _GetNLDTotal(oTarget);
    int nHPMax = GetMaxHitPoints(oTarget);
    int nCap = nHPMax + 10;
    nNLDTotal = ((nNLDTotal + nSubdualDamage) > nCap) ? nCap :
            nNLDTotal + nSubdualDamage;
    _SetNLDTotal(oTarget, nNLDTotal);
    ACR_ApplyNLDEffects(oTarget, nNLDTotal);
}

void main()
{
    ACR_CreatureOnPerception();

    // Custom code goes here.
	object oPerceived = GetLastPerceived();
	object oTargetSpear = GetNearestObjectByTag("003_cr_argent_spearman_train", OBJECT_SELF,1);
	object oTargetSword = GetNearestObjectByTag("003_cr_argent_swordsman_train", OBJECT_SELF,1);
	int nRandomDummy = Random(6) +3;
	object oTargetDummy = GetNearestObjectByTag("abr_pl_mp_pracdummuse", OBJECT_SELF,nRandomDummy);
	
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
	
	if((GetIsPC(oPerceived)) || (GetIsDMPossessed(oPerceived))) {
		ActionSpeakString("oTargetChoice = " + GetTag(oTargetChoice), TALKVOLUME_TALK);
		if(GetLocalInt(OBJECT_SELF, "Trained") == 0) {
			SetLocalInt(OBJECT_SELF, "Trained", 1);
			if(_GetNLDMode(OBJECT_SELF) == FALSE)
				 	{ACR_ToggleNLDMode(OBJECT_SELF);}
			ActionMoveToObject(oTargetChoice, FALSE, 1.0);
			DelayCommand(2.0, ActionAttack(oTargetChoice, FALSE));
			//DelayCommand(12.0, ActionAttack(oTargetChoice, FALSE));
			//DelayCommand(22.0, ActionAttack(oTargetChoice, FALSE));
						
		}
	}
}