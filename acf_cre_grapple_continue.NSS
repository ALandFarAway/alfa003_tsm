////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ACR Configuration File
//     Filename : acf_cr_onattacked_grapple
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
    ACR_CreatureOnEndCombatRound();
	
	int nMaxHP = GetMaxHitPoints(OBJECT_SELF);
	int nLastHP = GetLocalInt(OBJECT_SELF, "nLastHP");
	int nCurrentHP = GetCurrentHitPoints(OBJECT_SELF);
	SendMessageToAllDMs("grapple_continue called. ACR_Grappling = " + IntToString(GetLocalInt(OBJECT_SELF, "ACR_Grappling")));
							
	if(GetLocalInt(OBJECT_SELF, "ACR_Grappling") == 1) {	 
		object oGrappled = GetLocalObject(OBJECT_SELF, "ACR_Grappled");
		SendMessageToAllDMs("grapple_continue. ACR_Grappled = " + GetName(oGrappled));
		int nGrapple = 15;
		int nBABFoe = GetTRUEBaseAttackBonus(oGrappled);
		int nStrFoe = GetAbilityModifier(ABILITY_STRENGTH, oGrappled);
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
				
		SendMessageToAllDMs("Grapple continue Opposed Grapple Rolls:");
		SendMessageToAllDMs("Grapple continue " + GetName(OBJECT_SELF) + ": " + IntToString(nAttack) + " + " + IntToString(nGrapple) + " + " + IntToString(nSize) + " = " + IntToString(nMyGrapple));
		SendMessageToAllDMs("Grapple continue " + GetName(oGrappled) + ": " + IntToString(nAttackFoe) + " + " + IntToString(nBABFoe) + " + " + IntToString(nStrFoe) + " = " + IntToString(nFoeGrapple));
		SendMessageToPC(oGrappled, "Opposed Grapple Rolls:");
		SendMessageToPC(oGrappled, GetName(OBJECT_SELF) + ": " + IntToString(nAttack) + " + " + IntToString(nGrapple) + " + " + IntToString(nSize) + " = " + " = " + IntToString(nMyGrapple));
		SendMessageToPC(oGrappled, GetName(oGrappled) + ": " + IntToString(nAttackFoe) + " + " + IntToString(nBABFoe) + " + " + IntToString(nStrFoe) + " = " + IntToString(nFoeGrapple));
		SendMessageToPC(OBJECT_SELF, "Opposed Grapple Rolls:");
		SendMessageToPC(OBJECT_SELF, GetName(OBJECT_SELF) + ": " + IntToString(nAttack) + " + " + IntToString(nGrapple) + " + " + IntToString(nSize) + " = " + " = " + IntToString(nMyGrapple));
		SendMessageToPC(OBJECT_SELF, GetName(oGrappled) + ": " + IntToString(nAttackFoe) + " + " + IntToString(nBABFoe) + " + " + IntToString(nStrFoe) + " = " + IntToString(nFoeGrapple));
		if((nFoeGrapple > nMyGrapple) || (GetCreatureSize(OBJECT_SELF) + 2  < GetCreatureSize(oGrappled)) || ((nMyGrapple == nFoeGrapple) && (nGrapple + nSize <= nBABFoe + nStrFoe)))  {
			SendMessageToAllDMs(GetName(oGrappled) + " breaks free. Grapple continue.");
			SendMessageToPC(oGrappled, "You break free of a grapple attack!");
			SendMessageToPC(OBJECT_SELF, GetName(oGrappled) + " breaks free of your grapple attack!");
			SetLocalInt(oGrappled, "ACR_Grappling", 0);
			SetLocalInt(OBJECT_SELF, "ACR_Grappling", 0);
			SetLocalObject(oGrappled, "ACR_Grappler", OBJECT_INVALID);
			SetLocalObject(OBJECT_SELF, "ACR_Grappled", OBJECT_INVALID);
			ClearAllActions(TRUE);
			AssignCommand(oGrappled, ClearAllActions(TRUE));
			}
		else if((nMyGrapple > nFoeGrapple) || ((nMyGrapple == nFoeGrapple) && (nGrapple + nSize > nBABFoe + nStrFoe))) {
			SendMessageToAllDMs(GetName(oGrappled) + " is still grappled. Grapple continue.");
			ActionForceFollowObject(oGrappled, 0.5, 1);
			AssignCommand(oGrappled, ActionForceFollowObject(OBJECT_SELF, 0.5, 1));
			DelayCommand(7.0, ClearAllActions(TRUE));
			DelayCommand(7.0, AssignCommand(oGrappled, ClearAllActions(TRUE)));
			int nDexModFoe = GetAbilityModifier(ABILITY_DEXTERITY, oGrappled);
			int nDexMod = GetAbilityModifier(ABILITY_DEXTERITY, OBJECT_SELF);
			effect eACDecFoe = EffectACDecrease(nDexModFoe, AC_DODGE_BONUS, AC_VS_DAMAGE_TYPE_ALL);
			effect eACDec = EffectACDecrease(nDexMod, AC_DODGE_BONUS, AC_VS_DAMAGE_TYPE_ALL);
			ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eACDecFoe, oGrappled, 7.0);
			ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eACDec, OBJECT_SELF, 7.0);
			effect eMoveSlow = EffectMovementSpeedDecrease(50);
			ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eMoveSlow, oGrappled, 7.0);
			ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eMoveSlow, OBJECT_SELF, 7.0);
			effect eAttackPenalty = EffectAttackDecrease(4, ATTACK_BONUS_ONHAND);
			effect eAttackPenaltyOffhand = EffectAttackDecrease(4, ATTACK_BONUS_ONHAND);
			ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAttackPenalty, oGrappled, 7.0);
			ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAttackPenalty, OBJECT_SELF, 7.0);
			ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAttackPenaltyOffhand, oGrappled, 7.0);
			ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAttackPenaltyOffhand, OBJECT_SELF, 7.0);
			if(GetHasFeat(1729, oGrappled, FALSE)) {
				FeatRemove(oGrappled, 1729);
				DelayCommand(7.0, ActionFeatAdd(oGrappled, 1729));
				}
			if(GetHasFeat(1734, oGrappled, FALSE)) {
				FeatRemove(oGrappled, 1734);
				DelayCommand(7.0, ActionFeatAdd(oGrappled, 1734));
				}
			if(GetHasFeat(1735, oGrappled, FALSE)) {
				FeatRemove(oGrappled, 1735);
				DelayCommand(7.0, ActionFeatAdd(oGrappled, 1735));
				}
			if(GetHasFeat(1736, oGrappled, FALSE)) {
				FeatRemove(oGrappled, 1736);
				DelayCommand(7.0, ActionFeatAdd(oGrappled, 1736));
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
				}
			}
		 }	
}