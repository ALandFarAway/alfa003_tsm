#include "acr_scry_i"

void main()
{
             
    object oScryer = GetItemActivator();
	string sScryerName = GetName(oScryer);
	object oTarget = GetItemActivatedTarget();
	string sTargetName = GetName(oTarget);
	object oFocus = GetItemActivated();
	string sPTargetRes = ACR_GetPersistentString(oFocus, "sPTargetRes");
	string sPTargetName = ACR_GetPersistentString(oFocus, "sPTargetName");
	string sPScryerName = ACR_GetPersistentString(oFocus, "sPScryerName");
	int nDCRoll = 10+ d10(1);
	//SendMessageToPC(oScryer, "nDCRoll = " + IntToString(nDCRoll));
	float fDCAbility = (GetAbilityModifier(ABILITY_CHARISMA, oTarget) + GetAbilityModifier(ABILITY_CONSTITUTION, oTarget) + GetAbilityModifier(ABILITY_DEXTERITY, oTarget) + GetAbilityModifier(ABILITY_INTELLIGENCE, oTarget) + GetAbilityModifier(ABILITY_STRENGTH, oTarget) + GetAbilityModifier(ABILITY_WISDOM, oTarget))/6.0 ;
	//SendMessageToPC(oScryer, "fDCAbility = " + FloatToString(fDCAbility));
	fDCAbility = pow(fDCAbility, 2.0);
	//SendMessageToPC(oScryer, "fDCAbility = " + FloatToString(fDCAbility));
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
	//SendMessageToPC(oScryer, "nDCAbility = " + IntToString(nDCAbility));
	int nDC = nDCRoll + nDCAbility;
	//SendMessageToPC(oScryer, "nDC = " + IntToString(nDC));
		
	int nScryer = 0;
	if(sScryerName == sPScryerName) {
		nScryer = 1;
		}
	
	if((FindSubString(GetTag(oTarget), "_SCRY") != -1) && (GetObjectType(oTarget) == OBJECT_TYPE_PLACEABLE) && (sPTargetRes != "")) {
		
		//Create undetectable OOC Scrying Namer at location of Scrying Object to receive 10 letter Roster Name for stored scrying target
		    object oScryNamer = GetLocalObject(oTarget, "oScryNamer");
			if(oScryNamer == OBJECT_INVALID) {
				oScryNamer = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_scry_namer", GetLocation(oTarget));
	            SetLocalObject(oScryNamer, "oScryer", oScryer);
				SetLocalObject(oScryNamer, "oTarget", oTarget);
				SetLocalString(oScryNamer, "sPTargetRes", sPTargetRes);
				}
			 
			if(nScryer == 1) {
				SendMessageToPC(oScryer, "A lifelike, animated image of " + sPTargetName + " appears in the " + GetName(oTarget));
				SendMessageToPC(oScryer, "You feel the match of your arcane signature resonate back from this scrying shard, as its creator.  Future scrying of this subject will benefit from the familiarity imbued herewith.");	
			}
			if(nScryer == 0) {
				SendMessageToPC(oScryer, "A nearly translucent, roughly sketched image of " + sPTargetName + " appears in the " + GetName(oTarget));
				SendMessageToPC(oScryer, "The arcane signature of this scrying shard and its holder are not a match. Future scrying of this subject will be at secondhand knowledge only.");	
			}
			
			DelayCommand(4.0, AssignCommand(oTarget, ActionSpeakString("Please speak a name no longer than 10 letters for this potential scrying subject.", TALKVOLUME_TALK)));	
			string sRoster = GetFirstRosterMember();
			if(sRoster == ""){
				SendMessageToPC(oScryer, "There are no names of the wider populace keyed into this " + GetName(oTarget) +":");
				}
			else {
				SendMessageToPC(oScryer, "These are the names of the wider populace keyed into this " + GetName(oTarget) +":");
				}
			int nInc = 0;
			while((sRoster != "") && (nInc < 10)) {
				SendMessageToPC(oScryer, sRoster);
				sRoster = GetNextRosterMember();
				nInc++;
			}
		     
		}
		
	if((GetObjectType(oTarget) == OBJECT_TYPE_CREATURE) && (sTargetName == sPTargetName) && (sTargetName != "")) {
		if((GetLocalInt(oTarget, "Focus_" + sScryerName) == 0) || (GetIsDMPossessed(oScryer))) {
			 DelayCommand(900.0, SetLocalInt(oTarget, "Focus_" + sScryerName, 0));
			 if(GetIsSkillSuccessful(oScryer, SKILL_CONCENTRATION, nDC, TRUE)) {
				SetLocalInt(oTarget, "Focus_" + sScryerName, 1);
			 	SendMessageToPC(oScryer, "Your familiarity with " + GetName(oTarget) + " increases. You see the existing image of " + GetName(oTarget) + " in the scrying shard take on depth, dimension, and movement, blinking every now and then.");
				object oImago = CreateItemOnObject("abr_it_scry_sh_imago", oScryer, 1);
				SetFirstName(oImago, GetName(oTarget) + " Imago: " + GetName(oTarget));
				SetDescription(oImago, "A scrying shard showing the imago of " + GetName(oTarget) + " in realistic, living condition, chest rising and falling, every so often smiling or frowning. This shard was enspelled by " + GetName(oScryer) + " and establishes familiar knowledge of " + GetName(oTarget) + " for " + GetName(oScryer) + " or secondhand knowledge for anybody else who holds it.");
				}
		     else {
			    SetLocalInt(oTarget, "Focus_" + sScryerName, 2);
				SendMessageToPC(oScryer, "You are unable to concentrate enough to improve your grasp of the defining details of " + GetName(oTarget) + " and focus them into the shard. You will have to try again another time.");
				}
			DestroyObject(oFocus);
			}
		else if(GetLocalInt(oTarget, "Focus_" + sScryerName) == 1) {
			SendMessageToPC(oScryer, "You have already memorized the constantly changing expressions, postures, gait, and other defining details of " + GetName(oTarget) + " today and focused them into the shard. You will have to try to improve on your understandings at a later time.");
		}
		else if(GetLocalInt(oTarget, "Focus_" + sScryerName) == 2) {
			SendMessageToPC(oScryer, "You have already tried and failed to memorize the constantly changing expressions, postures, gait, and other defining details of " + GetName(oTarget) + " and focus them into the shard. You will have to try again at a later time.");
		}
	}
}