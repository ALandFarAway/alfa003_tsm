////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ACR Configuration File
//     Filename : acf_cre_onattacked_grapple
//    $Revision:: 280        $ current version of the file
//        $Date:: 2023-04-25#$ date the file was created or modified
//       Author : Wynna
//
//    Var Prefix:
//  Dependencies:
//
//  Description
//  This script calls the ACR's OnAttacked event handler for creatures and
//  has the creature attempt a grapple attack in return. It is not updated in 
//	ACR updates.
//
//  Revision History
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#include "acr_creature_i"
#include "acr_spells_i"
#include "acr_spelltrack_i"

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

void ActionFeatAdd(object oCreature, int nFeat)
	{FeatAdd(oCreature, nFeat, FALSE, TRUE, TRUE);}
    
void main()
{
    ACR_CreatureOnPhysicallyAttacked();
	
	int nMaxHP = GetMaxHitPoints(OBJECT_SELF);
	int nLastHP = GetLocalInt(OBJECT_SELF, "nLastHP");
	int nCurrentHP = GetCurrentHitPoints(OBJECT_SELF);
	int nAttackMissed = 0;
	if((nCurrentHP == nMaxHP) || (nCurrentHP == nLastHP)) {nAttackMissed = 1;}
	SetLocalInt(OBJECT_SELF, "nLastHP", nCurrentHP);
	object oAttacker = GetLocalObject(OBJECT_SELF, "ACR_Grappled");
	if(oAttacker != OBJECT_INVALID) {SendMessageToAllDMs(GetName(OBJECT_SELF) + ". Grapple OnAttack called. ACR_Grappling = " + IntToString(GetLocalInt(OBJECT_SELF, "ACR_Grappling")) + ". oGrappled ongoing = " + GetName(oAttacker));}
	else {oAttacker = GetLastAttacker(OBJECT_SELF); SendMessageToAllDMs(GetName(OBJECT_SELF) + ". Grapple OnAttack called. ACR_Grappling = " + IntToString(GetLocalInt(OBJECT_SELF, "ACR_Grappling")) + ". oGrappled = oAttacker");}
			
	if((nAttackMissed == 0) && (GetLocalInt(OBJECT_SELF, "ACR_Grappling") == 0)) {	 
		 if(GetDistanceBetween(OBJECT_SELF, oAttacker) < 5.0) {
		 	ClearAllActions(TRUE);
			ActionSpeakString(GetName(OBJECT_SELF) + " attempts to grapple " + GetName(oAttacker), TALKVOLUME_TALK);
		//	AssignCommand(oAttacker, ActionSpeakString((GetName(oAttacker) + " attack of Opportunity on " + GetName(OBJECT_SELF), TALKVOLUME_TALK));
			AssignCommand(oAttacker, ActionAttack(OBJECT_SELF, FALSE));
			if(TouchAttackMelee(oAttacker, TRUE, 0) > 0) {
				int nGrapple = 15;
				int nBABFoe = GetTRUEBaseAttackBonus(oAttacker);
				int nStrFoe = GetAbilityModifier(ABILITY_STRENGTH, oAttacker);
				int nSubdual = d3(1);
				int nSize = GetCreatureSize(OBJECT_SELF);
				if(nSize == CREATURE_SIZE_HUGE) {nSize = 8;}
				if(nSize == CREATURE_SIZE_LARGE) {nSize = 4;}
				if(nSize == CREATURE_SIZE_MEDIUM) {nSize = 0;}
				if(nSize == CREATURE_SIZE_SMALL) {nSize = -4; nSubdual = d2(1);}
				if(nSize == CREATURE_SIZE_TINY) {nSize = -8; nSubdual = d2(1);}
				int nAttack = d20(1);
				int nAttackFoe = d20(1);
				int nMyGrapple = nAttack + nGrapple + nSize;
				int nFoeGrapple = nAttackFoe + nBABFoe + nStrFoe;
				effect eKnockdown = EffectKnockdown();
				
				SendMessageToAllDMs(GetName(OBJECT_SELF) + " Opposed Grapple Rolls:");
				SendMessageToAllDMs(GetName(OBJECT_SELF) + ": " + IntToString(nAttack) + " + " + IntToString(nGrapple) + " + " + IntToString(nSize) + " = " + IntToString(nMyGrapple));
				SendMessageToAllDMs(GetName(oAttacker) + ": " + IntToString(nAttackFoe) + " + " + IntToString(nBABFoe) + " + " + IntToString(nStrFoe) + " = " + IntToString(nFoeGrapple));
			    SendMessageToPC(oAttacker, "Opposed Grapple Rolls:");
				SendMessageToPC(oAttacker, GetName(OBJECT_SELF) + ": " + IntToString(nAttack) + " + " + IntToString(nGrapple) + " + " + IntToString(nSize) + " = " + " = " + IntToString(nMyGrapple));
				SendMessageToPC(oAttacker, GetName(oAttacker) + ": " + IntToString(nAttackFoe) + " + " + IntToString(nBABFoe) + " + " + IntToString(nStrFoe) + " = " + IntToString(nFoeGrapple));
			    SendMessageToPC(OBJECT_SELF, "Opposed Grapple Rolls:");
				SendMessageToPC(OBJECT_SELF, GetName(OBJECT_SELF) + ": " + IntToString(nAttack) + " + " + IntToString(nGrapple) + " + " + IntToString(nSize) + " = " + " = " + IntToString(nMyGrapple));
				SendMessageToPC(OBJECT_SELF, GetName(oAttacker) + ": " + IntToString(nAttackFoe) + " + " + IntToString(nBABFoe) + " + " + IntToString(nStrFoe) + " = " + IntToString(nFoeGrapple));
			    if((nFoeGrapple > nMyGrapple) || (GetCreatureSize(OBJECT_SELF) + 2  < GetCreatureSize(oAttacker)) || ((nMyGrapple == nFoeGrapple) && (nGrapple + nSize <= nBABFoe + nStrFoe)))  {
					SendMessageToAllDMs(GetName(oAttacker) + " breaks free. Onattacked.");
					SendMessageToPC(oAttacker, "You break free!");
					SendMessageToPC(OBJECT_SELF, GetName(oAttacker) + " breaks free of your grapple attack!");
					SetLocalInt(oAttacker, "ACR_Grappling", 0);
					SetLocalInt(OBJECT_SELF, "ACR_Grappling", 0);
					SetLocalObject(oAttacker, "ACR_Grappler", OBJECT_INVALID);
					SetLocalObject(OBJECT_SELF, "ACR_Grappled", OBJECT_INVALID);
					ClearAllActions(TRUE);
					AssignCommand(oAttacker, ClearAllActions(TRUE));
					}
				else if((nMyGrapple > nFoeGrapple) || ((nMyGrapple == nFoeGrapple) && (nGrapple + nSize > nBABFoe + nStrFoe))) {
					SetLocalInt(oAttacker, "ACR_Grappling", 1);
					SetLocalInt(OBJECT_SELF, "ACR_Grappling", 1);
					SetLocalObject(oAttacker, "ACR_Grappler", OBJECT_SELF);
					SetLocalObject(OBJECT_SELF, "ACR_Grappled", oAttacker);
					SendMessageToAllDMs(GetName(OBJECT_SELF) + " has grappled " + GetName(oAttacker) + ". Onattacked.");
					SendMessageToPC(oAttacker, "You are grappled!");
					ACR_ApplyNLDDamageToCreature(oAttacker, nSubdual);
					ActionForceMoveToObject(oAttacker, FALSE, 0.5);
					AssignCommand(oAttacker, ActionForceMoveToObject(OBJECT_SELF, FALSE, 0.5));
					int nDexModFoe = GetAbilityModifier(ABILITY_DEXTERITY, oAttacker);
					int nDexMod = GetAbilityModifier(ABILITY_DEXTERITY, OBJECT_SELF);
					effect eACDecFoe = EffectACDecrease(nDexModFoe, AC_DODGE_BONUS, AC_VS_DAMAGE_TYPE_ALL);
					effect eACDec = EffectACDecrease(nDexMod, AC_DODGE_BONUS, AC_VS_DAMAGE_TYPE_ALL);
					ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eACDecFoe, oAttacker, 7.0);
					ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eACDec, OBJECT_SELF, 7.0);
					effect eMoveSlow = EffectMovementSpeedDecrease(50);
					ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eMoveSlow, oAttacker, 7.0);
					ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eMoveSlow, OBJECT_SELF, 7.0);
					effect eAttackPenalty = EffectAttackDecrease(4, ATTACK_BONUS_ONHAND);
					effect eAttackPenaltyOffhand = EffectAttackDecrease(4, ATTACK_BONUS_ONHAND);
					ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAttackPenalty, oAttacker, 7.0);
					ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAttackPenalty, OBJECT_SELF, 7.0);
					ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAttackPenaltyOffhand, oAttacker, 7.0);
					ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAttackPenaltyOffhand, OBJECT_SELF, 7.0);
					/*if(GetHasFeat(1729, oAttacker, FALSE)) {
						FeatRemove(oAttacker, 1729);
						DelayCommand(7.0, ActionFeatAdd(oAttacker, 1729));
						}
					if(GetHasFeat(1734, oAttacker, FALSE)) {
						FeatRemove(oAttacker, 1734);
						DelayCommand(7.0, ActionFeatAdd(oAttacker, 1734));
						}
					if(GetHasFeat(1735, oAttacker, FALSE)) {
						FeatRemove(oAttacker, 1735);
						DelayCommand(7.0, ActionFeatAdd(oAttacker, 1735));
						}
					if(GetHasFeat(1736, oAttacker, FALSE)) {
						FeatRemove(oAttacker, 1736);
						DelayCommand(7.0, ActionFeatAdd(oAttacker, 1736));
						}
					if(GetHasFeat(1729, OBJECT_SELF, FALSE)) {
						FeatRemove(OBJECT_SELF, 1729);
						DelayCommand(7.0, ActionFeatAdd(OBJECT_SELF, 1729));
						}
					if(GetHasFeat(1734, OBJECT_SELF, FALSE)) {
						FeatRemove(OBJECT_SELF, 1734);
						DelayCommand(7.0, ActionFeatAdd(OBJECT_SELF, 1734));
						}
					if(GetHasFeat(1735, OBJECT_SELF, FALSE)) {
						FeatRemove(OBJECT_SELF, 1735);
						DelayCommand(7.0, ActionFeatAdd(OBJECT_SELF, 1735));
						}
					if(GetHasFeat(1736, OBJECT_SELF, FALSE)) {
						FeatRemove(OBJECT_SELF, 1736);
						DelayCommand(7.0, ActionFeatAdd(OBJECT_SELF, 1736));
						}*/
					}
				}
		 	}
		 }	
}