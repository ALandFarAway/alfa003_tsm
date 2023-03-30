//
//  System Name : Scrying
//     Filename : i_abr_scry_fc_image_ac
//      Version : 0.1
//         Date : 7/8/22
//       Author : Wynna
//
//  Description
//  This script handles the on activate actions for a scrying image used in the scrying system. 
//	The image will be created in a caster's inventory upon a successful Concentration check when 
//   using a previous focus on a creature.
//  Hold the image in inventory when casting a scry spell to apply bonuses to the chances of a successful scry.
//  This item enhances Knowledge of a target to "firsthand" and Connection to "minor".
//	Use the image on a scrying object to imbue a scrying nickname into the object. Use that nickname 
//   to call up a potential scrying target's identity in future.
//  Use the image on a creature (including yourself) for a Concentration check to generate the next level of focus, 
//	 an imago.
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
	object oArea = GetArea(oScryer);
	string sTriggerTag;
	if(oTarget == OBJECT_INVALID) {
		location lTarget = GetLocation(oScryer);
		object oScry = GetFirstObjectInShape(SHAPE_SPHERE, 5.0, lTarget, FALSE, OBJECT_TYPE_TRIGGER);
		while(oScry != OBJECT_INVALID) {
			sTriggerTag = GetTag(oScry);
			if(FindSubString(sTriggerTag, "_SCRY_") != -1) {
				SetLocalObject(oArea, "oScry", oScry);
				}
			oScry = GetNextObjectInShape(SHAPE_SPHERE, 5.0, lTarget, FALSE, OBJECT_TYPE_TRIGGER);
			}
		
		oTarget = GetLocalObject(oArea, "oScry");
	}
	
			
	string sTargetName = GetName(oTarget);
	object oFocus = GetItemActivated();
	string sFocusName = GetFirstName(oFocus);
	string sFocusType = "Shard";
	if(FindSubString(sFocusName, "Droplet", 0) != -1) {
		sFocusType = "Droplet";
	}
	string sPTargetRes = ACR_GetPersistentString(oFocus, "sPTargetRes");
	string sPTargetName = ACR_GetPersistentString(oFocus, "sPTargetName");
	string sPScryerName = ACR_GetPersistentString(oFocus, "sPScryerName");
	string sTargetNick = GetLocalString(oTarget, sPTargetRes);
				
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
	
	int nPos = FindSubString(sScryerName, "'", 0);
	int nScryer = 0;
	if((sScryerName == sPScryerName) || (sPScryerName == SpliceString(sScryerName, nPos, 1))) {
		nScryer = 1;
		}
		
	//Images can be used on a scrying object placeable to transfer the knowledge stored on it							
	if((FindSubString(GetTag(oTarget), "_SCRY") != -1) && ((GetObjectType(oTarget) == OBJECT_TYPE_PLACEABLE) || (GetObjectType(oTarget) == OBJECT_TYPE_TRIGGER))) {
			if(nScryer == 1) {
				AssignCommand(oTarget, ActionSpeakString("*A one-dimensional, still image of " + sPTargetName + " appears in the " + sTargetName, TALKVOLUME_TALK));
				SendMessageToPC(oScryer, "You feel the match of your divine or arcane signature resonate back from this Scrying " + sFocusType + ", as its creator.  Scrying of this subject while holding this Scrying " + sFocusType + " will benefit from the firsthand knowledge imbued herewith.");	
				}
			if(nScryer == 0) {
				AssignCommand(oTarget, ActionSpeakString("*A nearly translucent, roughly sketched image of " + sPTargetName + " appears in the " + sTargetName, TALKVOLUME_TALK));
				SendMessageToPC(oScryer, "The arcane signature of this Scrying " + sFocusType + " and its holder are not a match. Scrying of this subject while holding this Scrying " + sFocusType + " will be at secondhand knowledge only.");	
				}
			if(sTargetNick != "") {
				SendMessageToPC(oScryer, sPTargetName + "'s identity is already imbued into this " + sTargetName + " under the nickname " + sTargetNick);	
				}
			
			else if(sTargetNick == "") {
				//Create undetectable OOC Scrying Namer at location of Scrying Object to receive nickname for stored scrying target
			    object oScryNamer = GetLocalObject(oTarget, "oScryNamer");
				if(oScryNamer == OBJECT_INVALID) {
					oScryNamer = CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_scry_namer", GetLocation(oTarget));
		            SetLocalObject(oScryNamer, "oScryer", oScryer);
					SetLocalObject(oScryNamer, "oFocus", oFocus);
					SetLocalObject(oScryNamer, "oTarget", oTarget);
					SetLocalString(oScryNamer, "sPTargetRes", sPTargetRes);
					SetLocalString(oScryNamer, "sPTargetName", sPTargetName);
					}
					
				DelayCommand(2.0, SendMessageToPC(oScryer, "You must speak a name for this potential scrying subject."));	
			}  
		}
		
	if((GetObjectType(oTarget) == OBJECT_TYPE_CREATURE) && (sTargetName != sPTargetName)) {
		 SendMessageToPC(oScryer, "This image is of somebody other than the person you just attempted to commit to it. You cannot enhance your knowledge of somebody by focusing on somebody else.");
		 return;
		 }
		 
	if(GetLocalInt(oTarget, "Focus_" + sScryerName) == 2) {
		SendMessageToPC(oScryer, "You have recently tried and failed to memorize the constantly changing expressions, postures, gait, and other defining details of " + sTargetName + " and focus them into the " + sFocusName + ". You will have to try again at a later time.");
		return;
		}
	
	if(GetLocalInt(oTarget, "Focus_" + sScryerName) == 1) {
		SendMessageToPC(oScryer, "You have recently memorized the constantly changing expressions, postures, gait, and other defining details of " + sTargetName + " and focused them into the Scrying " + sFocusType + ". You will have to try to improve on your understandings at a later time.");
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
	
	//PCs who got this far must make a concentration check vs. a DC based on a d20 + the averaged ability modifiers of the target squared to go to Familiar level			
	if((oTarget==oScryer) || ((GetIsDMPossessed(oScryer)) && (GetObjectType(oTarget) == OBJECT_TYPE_CREATURE))  || ((GetIsSkillSuccessful(oScryer, SKILL_CONCENTRATION, nDC, TRUE)) && (GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)))  {
		if(oTarget==oScryer) {
			SendMessageToPC(oScryer, "You imbue your own defining characteristics into the " + sFocusName + ". Your image shimmers into the " + sFocusName + " in a lifelike, 3D representation, occasionally blinking or changing expression.");
			} 
		else if(GetIsDMPossessed(oScryer)) {
			SendMessageToPC(oScryer,  "<color=cyan>" + GetName(oScryer) + ":</color> <color=lightblue>Dexterity: *" + sSuccess + "*: " + IntToString(nDexRoll) + " + " + IntToString(nDexRank) + " = " + IntToString(nDexCheck) + " vs DC" + IntToString(nSpotCheck) + "</color>");
			SendMessageToPC(oScryer, "You memorize the defining characteristics of " + sTargetName + " and focus your perception of them into the " + sFocusName + ". The image of " + sTargetName + " within it animates, taking on depth and movement, occasionally blinking or changing expression.");
			}
		else {
			SendMessageToPC(oScryer, "You memorize the defining characteristics of " + sTargetName + " and focus your perception of them into the " + sFocusName + ". The image of " + sTargetName + " within it animates, taking on depth and movement, occasionally blinking or changing expression.");
			}
		object oImago = CreateItemOnObject("abr_it_scry_fc_imago", oScryer, 1);
		
		if(FindSubString(sFocusName, "Droplet", 0) != -1) {
			SetItemIcon(oImago, 1897);
			}
			
		SetFirstName(oImago, sFocusName + ": " + sTargetName);
		SetDescription(oImago, "A scrying focus showing a lifelike reflection of " + sTargetName + ". This token was created by " + GetName(oScryer) + " and establishes familiar knowledge of " + sTargetName + " for " + GetName(oScryer) + " or secondhand knowledge for anybody else who holds it.");
		//Names with apostrophes have to be normalized to store in the p-database
		if(FindSubString(sTargetName, "'") != -1) {
			int nPosTarget = FindSubString(sTargetName, "'", 0);
			ACR_SetPersistentString(oImago, "sPTargetName", SpliceString(sTargetName, nPosTarget, 1));
			}
		else {
			ACR_SetPersistentString(oImago, "sPTargetName", sTargetName);	
			}
				
		if(FindSubString(sScryerName, "'") != -1) {
			int nPosScryer = FindSubString(sScryerName, "'", 0);
			ACR_SetPersistentString(oImago, "sPScryerName", SpliceString(sScryerName, nPosScryer, 1));
			}
		else {
			ACR_SetPersistentString(oImago, "sPScryerName", sScryerName);	
			}
					
		if((GetIsPC(oTarget) == FALSE) || (GetIsDMPossessed(oTarget) == TRUE)) {
			ACR_SetPersistentString(oImago, "sPTargetRes", GetResRef(oTarget));
			}
			
		DestroyObject(oFocus);
		}
		
	else {
		SetLocalInt(oTarget, "Focus_" + sScryerName, 2);
		SendMessageToPC(oScryer, "You are unable to concentrate enough to memorize the constantly changing expressions, postures, gait, and other defining details of " + sTargetName + " and focus them into the " + sFocusName + ". You will have to try again another time.");
		}
}