////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ACR Configuration File
//     Filename : acf_cre_onspawnin
//    $Revision:: 280        $ current version of the file
//        $Date:: 2007-03-20#$ date the file was created or modified
//       Author : Cipher
//
//    Var Prefix:
//  Dependencies:
//
//  Description
//  This script calls the ACR's OnSpawnIn event handler for creatures
//  and any custom code a server may need. It is not updated in ACR updates.
//
//  Revision History
//    2010/11/17  AcadiusLost - Autodisabled flocking on creatures without a "parent" spawn point.
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#include "acr_creature_i"
#include "x0_i0_position" 
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

void main()
{
    ACR_CreatureOnSpawnIn();
	
	SetLocalString(OBJECT_SELF, "sMyTag", GetTag(OBJECT_SELF));
	
	//animation code
	if (GetLocalInt(OBJECT_SELF,"USE_IMMOBILE_AMBIENT_ANIM")==1)
		{
		float fRand=IntToFloat(d6(3));
		DelayCommand(fRand,ExecuteScript("dpss_ambient_anim",OBJECT_SELF));
		}
		
	//Temp. Remove after session
    if(FindSubString(GetTag(OBJECT_SELF), "ghost") != -1) {
		object oCount = GetFirstObjectInShape(SHAPE_SPHERE, 50.0, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
		int nCount = 0;
		while(oCount != OBJECT_INVALID) {
			if(GetRacialType(oCount) != RACIAL_TYPE_UNDEAD) 
				{nCount++;}
			oCount = GetNextObjectInShape(SHAPE_SPHERE, 50.0, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
			}
		
		int nRandAtt = Random(nCount);
		if(Random(3) == 1) {
			object oGhostSwoop = CreateObject(OBJECT_TYPE_PLACED_EFFECT, "tsm_afx_ghost", GetLocation(OBJECT_SELF));
			SetLocalObject(OBJECT_SELF, "oGhostSwoop", oGhostSwoop);
			}
		location lRandom = GetRandomLocation(GetArea(OBJECT_SELF), OBJECT_SELF, 30.0); 
		ActionForceMoveToLocation(lRandom, FALSE, 20.0);
		/*if(Random(3) == 1) {
			DelayCommand(IntToFloat(Random(20)), ChangeToStandardFaction(OBJECT_SELF, STANDARD_FACTION_HOSTILE));
			DelayCommand(IntToFloat(Random(10) + 10), ClearAllActions(FALSE));
			object oAttack = GetFirstObjectInShape(SHAPE_SPHERE, 50.0, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
			int nAttack = 0;
			while(oAttack != OBJECT_INVALID) {
				if(GetRacialType(oAttack) != RACIAL_TYPE_UNDEAD) 
					{nAttack++;
					 if(nAttack == nRandAtt) {
					 	ActionAttack(oAttack, FALSE);
					 	return;
						}
					}
				oAttack = GetNextObjectInShape(SHAPE_SPHERE, 50.0, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
				}
			}*/
		}
		
	//Hydra's extra attacks
	if(GetTag(OBJECT_SELF) == "abr_cr_mb_hydra5") {
	SetBaseAttackBonus(5, OBJECT_SELF);
	int nBAB = GetBaseAttackBonus(OBJECT_SELF);
	}
	
	//Unhallowed Turn Resistance Increase
	if(FindSubString(GetTag(GetArea(OBJECT_SELF)), "rauvin_ruins") != -1) {
		if((GetRacialType(OBJECT_SELF) == RACIAL_TYPE_UNDEAD) || (GetSubRace(OBJECT_SELF) == RACIAL_SUBTYPE_UNDEAD)) {
		 effect eTurnInc = EffectTurnResistanceIncrease(4);
		 int nBefore = GetTurnResistanceHD(OBJECT_SELF);
		 ApplyEffectToObject(DURATION_TYPE_PERMANENT, eTurnInc, OBJECT_SELF);
		 }
	
	}
				
}