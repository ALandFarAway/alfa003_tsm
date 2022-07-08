#include "acr_scry_i"

void main()
{
             
    object oScryer = GetItemActivator();
	string sScryerName = GetName(oScryer);
	object oTarget = GetItemActivatedTarget();
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
		
	int nScryer = 0;
	if(sScryerName == sPScryerName) {
		nScryer = 1;
		}
	
	if((FindSubString(GetTag(oTarget), "_SCRY") != -1) && (GetObjectType(oTarget) == OBJECT_TYPE_PLACEABLE)) {
			if(nScryer == 1) {
				AssignCommand(oTarget, ActionSpeakString("*A one-dimensional, still image of " + sPTargetName + " appears in the " + sTargetName, TALKVOLUME_TALK));
				SendMessageToPC(oScryer, "You feel the match of your arcane signature resonate back from this Scrying " + sFocusType + ", as its creator.  Scrying of this subject while holding this Scrying " + sFocusType + " will benefit from the firsthand knowledge imbued herewith.");	
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
					oScryNamer = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_scry_namer", GetLocation(oTarget));
		            SetLocalObject(oScryNamer, "oScryer", oScryer);
					SetLocalObject(oScryNamer, "oFocus", oFocus);
					SetLocalObject(oScryNamer, "oTarget", oTarget);
					SetLocalString(oScryNamer, "sPTargetRes", sPTargetRes);
					SetLocalString(oScryNamer, "sPTargetName", sPTargetName);
					}
					
				DelayCommand(4.0, SendMessageToPC(oScryer, "You must speak a name for this potential scrying subject."));	
			}  
		}
		
	if((GetObjectType(oTarget) == OBJECT_TYPE_CREATURE) && (sTargetName != sPTargetName)) {
		 SendMessageToPC(oScryer, "This image is of somebody other than the person you just attempted to commit to it. You cannot enhance your knowledge of somebody by focusing on somebody else.");
		 return;
		 }
	else if((GetObjectType(oTarget) == OBJECT_TYPE_CREATURE) && (sTargetName == sPTargetName) && (sPTargetName != "")) {
		if((GetLocalInt(oTarget, "Focus_" + sScryerName) == 0) || (GetIsDMPossessed(oScryer))) {
			 DelayCommand(900.0, SetLocalInt(oTarget, "Focus_" + sScryerName, 0));
			
			 int nDexRank = GetAbilityModifier(ABILITY_DEXTERITY, oScryer);
			int nDexCheck = d20(1) + nDexRank;
			int nSpotRank = GetSkillRank(SKILL_SPOT, oTarget, FALSE);
			int nSpotCheck = d20(1) + nSpotRank;
			SendMessageToPC(oScryer, "DexCheck = " +  IntToString(nDexCheck) + ". DexRank = " +  IntToString(nDexRank));
			SendMessageToPC(oScryer, "SpotCheck = " +  IntToString(nSpotCheck) + ". SpotRank = " +  IntToString(nSpotRank));
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
			 	SendMessageToPC(oScryer, "Your familiarity with " + sPTargetName + " increases. You see the existing image of " + sTargetName + " in the Scrying " + sFocusType + " take on depth, dimension, and movement, blinking every now and then.");
				object oImago = CreateItemOnObject("abr_it_scry_fc_imago", oScryer, 1);
				if(FindSubString(sFocusName, "Droplet", 0) != -1) {
					SetItemIcon(oImago, 1898);
				}
				SetFirstName(oImago, "Scrying Imago: " + sPTargetName);
				SetDescription(oImago, "A Scrying" + sFocusType + " showing the imago of " + sPTargetName + " in realistic, living condition, chest rising and falling, every so often smiling or frowning. This Scrying " + sFocusType + " was enspelled by " + GetName(oScryer) + " and establishes familiar knowledge of " + sTargetName + " for " + GetName(oScryer) + " or secondhand knowledge for anybody else who holds it.");
				ACR_SetPersistentString(oImago, "sPTargetName", sTargetName);
				ACR_SetPersistentString(oImago, "sPScryerName", sScryerName);
				if(GetIsPC(oTarget) == FALSE) {
					ACR_SetPersistentString(oImago, "sPTargetRes", GetResRef(oTarget));
					}
				}
		     else {
			    SetLocalInt(oTarget, "Focus_" + sScryerName, 2);
				SendMessageToPC(oScryer, "You are unable to concentrate enough to improve your grasp of the defining details of " + sTargetName + " and focus them into the Scrying " + sFocusType + ". You will have to try again another time.");
				}
			DestroyObject(oFocus);
			}
		else if(GetLocalInt(oTarget, "Focus_" + sScryerName) == 1) {
			SendMessageToPC(oScryer, "You have recently memorized the constantly changing expressions, postures, gait, and other defining details of " + sTargetName + " and focused them into the Scrying " + sFocusType + ". You will have to try to improve on your understandings at a later time.");
		}
		else if(GetLocalInt(oTarget, "Focus_" + sScryerName) == 2) {
			SendMessageToPC(oScryer, "You have recently tried and failed to memorize the constantly changing expressions, postures, gait, and other defining details of " + sTargetName + " and focus them into the Scrying " + sFocusType + ". You will have to try again at a later time.");
		}
	}
}