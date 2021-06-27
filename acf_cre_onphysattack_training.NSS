////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ACR Configuration File
//     Filename : acf_cre_onphysicallyattacked
//    $Revision:: 280        $ current version of the file
//        $Date:: 2007-03-20#$ date the file was created or modified
//       Author : Cipher
//
//    Var Prefix:
//  Dependencies:
//
//  Description
//  This script calls the ACR's OnPhysicallyAttacked event handler for creatures
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
    ACR_CreatureOnPhysicallyAttacked();

    // Custom code goes here.
	
	object oAttacker = GetLastAttacker(OBJECT_SELF);
	int nNLDTotal = _GetNLDTotal(oAttacker);
    int nHPMax = GetMaxHitPoints(oAttacker);
    //ActionSpeakString("Onphysattack oAttacker = " + GetTag(oAttacker), TALKVOLUME_TALK);
		
	if(_GetNLDMode(OBJECT_SELF) == FALSE)
			 	{ACR_ToggleNLDMode(OBJECT_SELF);}
		
	/*ActionAttack(oAttacker, FALSE);	
	object oBattleSound = GetObjectByTag("githbattle_rwk_object");
	SoundObjectPlay(oBattleSound);
	DelayCommand(1.0, SoundObjectStop(oBattleSound));	
	*/	
	object oTargetSpear = GetNearestObjectByTag("003_cr_argent_spearman_train", OBJECT_SELF,1);
	object oTargetSword = GetNearestObjectByTag("003_cr_argent_swordsman_train", OBJECT_SELF,1);
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
		
	ActionAttack(oTargetChoice, TRUE);
	
	if(nHPMax - _GetNLDTotal(oAttacker) <= 5) {
		ActionSpeakString("Do you yield?", TALKVOLUME_TALK);
		}
}