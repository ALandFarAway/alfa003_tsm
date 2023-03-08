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
	if((sFocusName != "Scrying Shard") && (sFocusName != "Scrying Droplet")) {
		sFocusName = "Scrying Focus";
		}
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
	
	int nDexRank = GetAbilityModifier(ABILITY_DEXTERITY, oScryer);
	int nDexRoll = d20(1);
	int nDexCheck = nDexRoll + nDexRank;
	int nSpotRank = GetSkillRank(SKILL_SPOT, oTarget, FALSE);
	int nSpotRoll = d20(1);
	int nSpotCheck = nSpotRoll + nSpotRank;
	string sSuccess = "success";
	if (nDexCheck < nSpotCheck) {
		sSuccess = "failure";
		}
			
	if(GetObjectType(oTarget) == OBJECT_TYPE_PLACEABLE) {
		SendMessageToPC(oScryer, "This " + sFocusName + " has not been imbued.");
		return;
		}
	
	if(GetLocalInt(oTarget, "Focus_" + sScryerName) == 2) {
		SendMessageToPC(oScryer, "You have recently tried and failed to memorize the constantly changing expressions, postures, gait, and other defining details of " + sTargetName + " and focus them into the " + sFocusName + ". You will have to try again at a later time.");
		return;
		}
		
	//For PCs attempting to imbue a focus, first run a dex check vs. their target's spot
	if((!GetIsDMPossessed(oScryer)) && (GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)) {
			SendMessageToPC(oScryer,  "<color=cyan>" + GetName(oScryer) + ":</color> <color=lightblue>Dexterity: *" + sSuccess + "*: " + IntToString(nDexRoll) + " + " + IntToString(nDexRank) + " = " + IntToString(nDexCheck) + " vs DC" + IntToString(nSpotCheck) + "</color>");
			if(nSpotCheck >= nDexCheck) {
				SendMessageToPC(oScryer, "You are clumsier than your target is perceptive.");
				SendMessageToPC(oTarget, "You feel unsettled, under scrutiny.");
				if(GetIsPC(oTarget) == FALSE) {
					AssignCommand(oTarget, ActionMoveAwayFromObject(oScryer, FALSE, 20.0));
					SetLocalInt(oTarget, "Focus_" + sScryerName, 2);
					SendMessageToPC(oScryer, "Either self-conscious (if friendly) or suspicious (if foe), your target moves away before you can even start to concentrate, breaking your focus on the constantly changing expressions, postures, gait, and other defining details of " + sTargetName + ". You will have to try again another time.");
					return;
					}
				else {SetLocalInt(oTarget, "Focus_" + sScryerName, 2);
					SendMessageToPC(oScryer, "You are unable to hold the reflection of your subject in the " + sFocusName + ", breaking your focus on the constantly changing expressions, postures, gait, and other defining details of " + sTargetName + ". You will have to try again another time." );
					return;
					}
				}
			}
	
		
	//Imbuing your own essence, or DMs possessing an NPC automatically succeed to Familiar level. PCs who got this far must make a concentration check vs. a DC based on a d20 + the averaged ability modifiers of the target squared to go to lesser Firsthand Knowledge level			
	if((oTarget==oScryer) || ((GetIsDMPossessed(oScryer)) && (GetObjectType(oTarget) == OBJECT_TYPE_CREATURE))  || ((GetIsSkillSuccessful(oScryer, SKILL_CONCENTRATION, nDC, TRUE)) && (GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)))  {
		if(oTarget==oScryer) {
			SendMessageToPC(oScryer, "You imbue your own defining characteristics into the " + sFocusName + ". Your image shimmers into the " + sFocusName + " in a lifelike, 3D representation, occasionally blinking or changing expression.");
			} 
		else if(GetIsDMPossessed(oScryer)) {
			SendMessageToPC(oScryer,  "<color=cyan>" + GetName(oScryer) + ":</color> <color=lightblue>Dexterity: *" + sSuccess + "*: " + IntToString(nDexRoll) + " + " + IntToString(nDexRank) + " = " + IntToString(nDexCheck) + " vs DC" + IntToString(nSpotCheck) + "</color>");
			SendMessageToPC(oScryer, "You memorize the defining characteristics of " + sTargetName + " and focus your perception of them into the " + sFocusName + ". The image of " + sTargetName + " within it animates, taking on depth and movement, occasionally blinking or changing expression.");
			}
		else {
			SendMessageToPC(oScryer, "You memorize the defining characteristics of " + sTargetName + " and focus your perception of them into the " + sFocusName + ". The image of " + sTargetName + " shimmers into the " + sFocusName + " and remains fixed there, unmoving.");
			}
		object oImage;
		if((oTarget==oScryer) || (GetIsDMPossessed(oScryer))) {
			oImage = CreateItemOnObject("abr_it_scry_fc_imago", oScryer, 1);
			} 
		else {
			oImage = CreateItemOnObject("abr_it_scry_fc_image", oScryer, 1);
			}
		
		if(FindSubString(sFocusName, "Droplet", 0) != -1) {
			SetItemIcon(oImage, 1897);
			}
			
		SetFirstName(oImage, sFocusName + ": " + sTargetName);
		SetDescription(oImage, "A scrying focus showing a lifelike reflection of " + sTargetName + ". This token was created by " + GetName(oScryer) + " and establishes familiar knowledge of " + sTargetName + " for " + GetName(oScryer) + " or secondhand knowledge for anybody else who holds it.");
		//Names with apostrophes have to be normalized to store in the p-database
		if(FindSubString(sTargetName, "'") != -1) {
			int nPosTarget = FindSubString(sTargetName, "'", 0);
			ACR_SetPersistentString(oImage, "sPTargetName", SpliceString(sTargetName, nPosTarget, 1));
			}
		else {
			ACR_SetPersistentString(oImage, "sPTargetName", sTargetName);	
			}
				
		if(FindSubString(sScryerName, "'") != -1) {
			int nPosScryer = FindSubString(sScryerName, "'", 0);
			ACR_SetPersistentString(oImage, "sPScryerName", SpliceString(sScryerName, nPosScryer, 1));
			}
		else {
			ACR_SetPersistentString(oImage, "sPScryerName", sScryerName);	
			}
					
		if((GetIsPC(oTarget) == FALSE) || (GetIsDMPossessed(oTarget) == TRUE)) {
			ACR_SetPersistentString(oImage, "sPTargetRes", GetResRef(oTarget));
			}
		
		if(GetIsPC(oTarget) == TRUE) {
			ACR_SetPersistentString(oImage, "sPTargetRes", "");
			}
		
		DestroyObject(oFocus);
		}		
	
	else {
		SetLocalInt(oTarget, "Focus_" + sScryerName, 2);
		SendMessageToPC(oScryer, "You are unable to concentrate enough to memorize the constantly changing expressions, postures, gait, and other defining details of " + sTargetName + " and focus them into the " + sFocusName + ". You will have to try again another time.");
		}
}