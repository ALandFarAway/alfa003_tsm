////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ACR Configuration File
//     Filename : acf_trg_onenter.nss
//    $Revision:: 236        $ current version of the file
//        $Date:: 2007-01-21#$ date the file was created or modified
//       Author : Cipher
//
//    Var Prefix:
//  Dependencies:
//
//  Description
//  This script calls the ACR's OnEnter code for triggers, and any
//  custom code a server may need. It is not updated in ACR updates.
//
//  Revision History
//  2007/01/20  Cipher  Inception
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#include "acr_trigger_i"
#include "acr_skills_i"
#include "acr_language_i"
#include "dmfi_inc_tool"
#include "dmfi_inc_english"




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



////////////////////////////////////////////////////////////////////////////////


void main()
{
    ACR_TriggerOnEnter();

    // Custom code goes here.
	object oPC = GetEnteringObject();
	
	if((GetLocalInt(OBJECT_SELF, GetName(oPC)) != 1) || (GetIsDMPossessed(oPC))) {
	    SetLocalInt(OBJECT_SELF, GetName(oPC), 1);
	
	int nDC = GetLocalInt(OBJECT_SELF, "ABILITY_DC_INT");
	string sMessageSuccess=GetLocalString(OBJECT_SELF, "MESSAGE_SUCCESS_STRING");
	string sMessagePartial=GetLocalString(OBJECT_SELF, "MESSAGE_PARTIAL_STRING");
	string sMessageFail=GetLocalString(OBJECT_SELF, "MESSAGE_FAIL_STRING");
	int	nAbility = GetLocalInt(OBJECT_SELF, "ABILITY_INT");
	string sClass = GetLocalString(OBJECT_SELF, "ABILITY_CLASS");
	int nClass = -1;
	if(sClass != "Any") {
		if(sClass == "Barbarian") {nClass = 0;}
		if(sClass == "Bard") {nClass = 1;}
		if(sClass == "Cleric") {nClass = 2;}
		if(sClass == "Druid") {nClass = 3;}
		if(sClass == "Fighter") {nClass = 4;}
		if(sClass == "Monk") {nClass = 5;}
		if(sClass == "Paladin") {nClass = 6;}
		if(sClass == "Ranger") {nClass = 7;}
		if(sClass == "Rogue") {nClass = 8;}
		if(sClass == "Sorceror") {nClass = 9;}
		if(sClass == "Wizard") {nClass = 10;}
		
		if(sClass == "Divine") {nClass = 11;}
		if(sClass == "Arcane") {nClass = 12;}
		if(sClass == "Warrior") {nClass = 13;}
		if(sClass == "Sneaky") {nClass = 14;}				
	}
	
	
	if(((nClass == 11) && ((GetLevelByClass(2, oPC) > 0) || (GetLevelByClass(3, oPC) > 0) || (GetLevelByClass(6, oPC) > 0) || (GetLevelByClass(7, oPC) > 0)))
		||((nClass == 12) && ((GetLevelByClass(1, oPC) > 0) || (GetLevelByClass(9, oPC) > 0) || (GetLevelByClass(10, oPC) > 0)))
		||((nClass == 13) && ((GetLevelByClass(0, oPC) > 0) || (GetLevelByClass(4, oPC) > 0) || (GetLevelByClass(5, oPC) > 0) || (GetLevelByClass(6, oPC) > 0) || (GetLevelByClass(7, oPC) > 0)))
		||((nClass == 14) && ((GetLevelByClass(7, oPC) > 0) || (GetLevelByClass(4, oPC) > 8)))
		||((nClass <= 10) && (GetLevelByClass(nClass, oPC) > 0))
		|| (nClass = -1)
		){
 
		int nModPC = GetAbilityModifier(nAbility, oPC);
		int nAbilityPC = d20(1) + nModPC;

			if(nAbilityPC >= nDC)
			 	{SendMessageToPC(oPC, sMessageSuccess);}
				
			else if((nAbilityPC +5 >= nDC) && (sMessagePartial != ""))
				{SendMessageToPC(oPC, sMessagePartial);}
				
			else{SendMessageToPC(oPC, sMessageFail);}
		}	
	}
}
		
	  		   