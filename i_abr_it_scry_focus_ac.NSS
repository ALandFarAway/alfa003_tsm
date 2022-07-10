//
//  System Name : Scrying
//     Filename : i_abr_scry_focus_ac
//      Version : 0.1
//         Date : 7/8/22
//       Author : Wynna
//
//  Description
//  This script handles the on activate actions for a scrying focus used in the scrying system. 
//	The focus will be created in a caster's inventory upon casting certain class-related spells on a scrying object.
//  Use the focus on a creature (including yourself) for a Concentration check to generate the next level of focus, 
//	 an image imbued with the identity of that creature.
//   
//	It is not updated in ACR updates.
//
//  Revision History
////////////////////////////////////////////////////////////////////////////////

//	Wynna - 7/8/2022

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////

#include "acr_scry_i"
#include "x0_i0_stringlib"
 
void main()
{
    object oScryer = GetItemActivator();
	string sScryerName = GetName(oScryer);
	object oTarget = GetItemActivatedTarget();
	string sTargetName = GetName(oTarget);
	object oFocus = GetItemActivated();
	string sFocusName = GetFirstName(oFocus);
	int nDCRoll = 10+ d10(1);
	float fDCAbility = (GetAbilityModifier(ABILITY_CHARISMA, oTarget) + GetAbilityModifier(ABILITY_CONSTITUTION, oTarget) + GetAbilityModifier(ABILITY_DEXTERITY, oTarget) + GetAbilityModifier(ABILITY_INTELLIGENCE, oTarget) + GetAbilityModifier(ABILITY_STRENGTH, oTarget) + GetAbilityModifier(ABILITY_WISDOM, oTarget))/6.0 ;
	fDCAbility = pow(fDCAbility, 2.0);
	int nDCAbility = 0; 
	if(fDCAbility < 1.5)
		{nDCAbility = 1;}
	else if(fDCAbility < 2.5)
		{nDCAbility = 2;}
	else if(fDCAbility < 3.5)
		{nDCAbility = 3;}
	else if(fDCAbility < 4.5)
		{nDCAbility = 4;}
	else if(fDCAbility < 5.5)
		{nDCAbility = 5;}
	int nDC = nDCRoll + nDCAbility;
	SendMessageToPC(oScryer, IntToString(nDCRoll) + " + " + IntToString(nDCAbility) + " = " + IntToString(nDC));	
		
	if(GetObjectType(oTarget) == OBJECT_TYPE_PLACEABLE) {
		SendMessageToPC(oScryer, "This " + sFocusName + " has not been imbued.");
		return;
		}
		
	if(GetObjectType(oTarget) == OBJECT_TYPE_CREATURE) {
		if((GetLocalInt(oTarget, "Focus_" + sScryerName) == 0) || (GetIsDMPossessed(oScryer))) {
			DelayCommand(900.0, SetLocalInt(oTarget, "Focus_" + sScryerName, 0));
			
			int nDexRank = GetAbilityModifier(ABILITY_DEXTERITY, oScryer);
			int nDexCheck = d20(1) + nDexRank;
			int nSpotRank = GetSkillRank(SKILL_SPOT, oTarget, FALSE);
			int nSpotCheck = d20(1) + nSpotRank;
			if(nSpotCheck >= nDexCheck) {
				SendMessageToPC(oScryer, "You  have been detected!");
				SendMessageToPC(oTarget, "You feel observed.");
				if(GetIsPC(oTarget) == FALSE) {
					AssignCommand(oTarget, ActionMoveAwayFromObject(oScryer, FALSE, 20.0));
					SetLocalInt(oTarget, "Focus_" + sScryerName, 2);
					SendMessageToPC(oScryer, "Your target moves away, breaking your focus on the constantly changing expressions, postures, gait, and other defining details of " + sTargetName + " . You will have to try again another time.");
					return;
					}
				}
			
			if(GetIsSkillSuccessful(oScryer, SKILL_CONCENTRATION, nDC, TRUE)) {
				SetLocalInt(oTarget, "Focus_" + sScryerName, 1);
				SendMessageToPC(oScryer, "You memorize the defining characteristics of " + sTargetName + " and focus your perception of them into the " + sFocusName + ". The image of " + sTargetName + " shimmers into the " + sFocusName + " and remains fixed there, unmoving.");
				object oImage = CreateItemOnObject("abr_it_scry_fc_image", oScryer, 1);
				if(FindSubString(sFocusName, "Droplet", 0) != -1) {
					SetItemIcon(oImage, 1897);
				}
				SetFirstName(oImage, sFocusName + ": " + sTargetName);
				SetDescription(oImage, "A scrying focus showing a still reflection of " + sTargetName + ". This token was created by " + GetName(oScryer) + " and establishes firsthand knowledge of " + sTargetName + " for " + GetName(oScryer) + " or secondhand knowledge for anybody else who holds it.");
				if(FindSubString(sTargetName, "'") != -1) {
					int nPosTarget = FindSubString(sTargetName, "'", 0);
					ACR_SetPersistentString(oImage, "sPTargetName", SpliceString(sTargetName, nPosTarget, 1));
					//SendMessageToPC(oScryer, "Setting: sTargetNameSpliced = " + SpliceString(sTargetName, nPosTarget, 1));
					//SendMessageToPC(oScryer, "Setting: sPTargetName = " + ACR_GetPersistentString(oImage, "sPTargetName"));
					}
				else {
					ACR_SetPersistentString(oImage, "sPTargetName", sTargetName);	
					//SendMessageToPC(oScryer, "Setting: sPTargetName = " + ACR_GetPersistentString(oImage, "sPTargetName"));
					}
				
				if(FindSubString(sScryerName, "'") != -1) {
					int nPosScryer = FindSubString(sScryerName, "'", 0);
					ACR_SetPersistentString(oImage, "sPScryerName", SpliceString(sScryerName, nPosScryer, 1));
					//SendMessageToPC(oScryer, "Setting: sScryerNameSpliced = " + SpliceString(sScryerName, nPosScryer, 1));
					//SendMessageToPC(oScryer, "Setting: sPScryerName = " + ACR_GetPersistentString(oImage, "sPScryerName"));
					}
				else {
					ACR_SetPersistentString(oImage, "sPScryerName", sScryerName);	
					//SendMessageToPC(oScryer, "Setting: sPTargetName = " + ACR_GetPersistentString(oImage, "sPTargetName"));
					}
					
				
				SendMessageToPC(oScryer, "Focus: sTargetName = " + sTargetName);
				SendMessageToPC(oScryer, "Focus: sScryerName = " + sScryerName);
				SendMessageToPC(oScryer, "Focus: sPTargetName = " + ACR_GetPersistentString(oImage, "sPTargetName"));
				SendMessageToPC(oScryer, "Focus: sPScryerName = " + ACR_GetPersistentString(oImage, "sPScryerName"));
				if(GetIsPC(oTarget) == FALSE) {
					ACR_SetPersistentString(oImage, "sPTargetRes", GetResRef(oTarget));
					}
				DestroyObject(oFocus);
				}
			else {
				 SetLocalInt(oTarget, "Focus_" + sScryerName, 2);
				 SendMessageToPC(oScryer, "You are unable to concentrate enough to memorize the constantly changing expressions, postures, gait, and other defining details of " + sTargetName + " and focus them into the " + sFocusName + ". You will have to try again another time.");
				}
			}
		else if(GetLocalInt(oTarget, "Focus_" + sScryerName) == 2) {
			SendMessageToPC(oScryer, "You have recently tried and failed to memorize the constantly changing expressions, postures, gait, and other defining details of " + sTargetName + " and focus them into the " + sFocusName + ". You will have to try again at a later time.");
		}
	}
}