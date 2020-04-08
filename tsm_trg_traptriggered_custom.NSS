////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ACR Configuration File
//     Filename : acf_trg_ontraptriggered.nss
//    $Revision:: 236        $ current version of the file
//        $Date:: 2007-01-21#$ date the file was created or modified
//       Author : Cipher
//
//   Var Prefix :
//  Dependencies:
//
//  Description
//  This script calls the ACR's OnTrapTriggered code for triggers, and any
//  custom code a server may need. It is not updated in ACR updates.
//
//  Revision History
//  2007/01/20  � i p h � r  Inception
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#include "acr_trigger_i"

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
#include "x0_i0_spells"

void main()
{
    ACR_TriggerOnTrapTriggered();

    // Custom code goes here.
	object oVictim = GetEnteringObject();
	object oPlaceable = GetNearestObjectByTag(GetTag(OBJECT_SELF) + "_plc", OBJECT_SELF, 1);
   	int nReflexDC = GetLocalInt(OBJECT_SELF, "ACR_TRAP_SAVE_DC");
	int nDiceType = GetLocalInt(OBJECT_SELF, "ACR_TRAP_DICE_TYPE");
	int nDiceNumber = GetLocalInt(OBJECT_SELF, "ACR_TRAP_DICE_NUMBER");
	
	SendMessageToAllDMs("nReflexDC = " + IntToString(nReflexDC));
	SendMessageToAllDMs("nDiceType = " + IntToString(nDiceType));
	SendMessageToAllDMs("nDiceNumber = " + IntToString(nDiceNumber));
	
	SendMessageToPC(oVictim, "nReflexDC = " + IntToString(nReflexDC));
	SendMessageToPC(oVictim, "nDiceType = " + IntToString(nDiceType));
	SendMessageToPC(oVictim, "nDiceNumber = " + IntToString(nDiceNumber));
	
	int nDamage;
	if(nDiceType == 4)
		{nDamage = d4(nDiceNumber);} 
	if(nDiceType == 6)
		{nDamage = d6(nDiceNumber);} 
	if(nDiceType == 8)
		{nDamage = d8(nDiceNumber);} 
	if(nDiceType == 10)
		{nDamage = d10(nDiceNumber);} 
	if(nDiceType == 12)
		{nDamage = d12(nDiceNumber);} 
	if(nDiceType == 20)
		{nDamage = d20(nDiceNumber);} 
	
	SendMessageToAllDMs("nDamage = " + IntToString(nDamage));
	SendMessageToPC(oVictim, "nDamage = " + IntToString(nDamage));
	
	
	
	if(GetTag(OBJECT_SELF) == "003_trap_custom_spike_minor")
		{effect eTrapDamage = EffectDamage(nDamage, DAMAGE_TYPE_PIERCING, DAMAGE_POWER_NORMAL, FALSE);
		 AssignCommand(oPlaceable, ActionPlayAnimation(ANIMATION_PLACEABLE_OPEN, 1.0, 1.0));
		 if(ReflexSave(oVictim, nReflexDC, SAVING_THROW_TYPE_TRAP))
		 	{}
		 else
			 {ApplyEffectToObject(DURATION_TYPE_INSTANT, eTrapDamage, oVictim); }
		 AssignCommand(oPlaceable, ActionPlayAnimation(ANIMATION_PLACEABLE_CLOSE, 1.0, 4.0));
		 }
}