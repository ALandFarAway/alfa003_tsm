#include "acr_spawn_i"
#include "acr_db_persist_i"
#include "acr_scry_i"

void main()
{
             
    object oScryer = GetItemActivator();
	object oTarget = GetItemActivatedTarget();
	object oFocus = GetItemActivated();
	string sFocus = GetFirstName(oFocus);
	string sFocusLast = GetLastName(oFocus);
	int nCountName = GetStringLength(sFocus);
	string sScryerName = GetFirstName(oScryer);
	int nCountScryerName = GetStringLength(sScryerName);
	string sTargetName = GetStringLeft(sFocus, nCountName - 8 - nCountScryerName);
	string sTargetRes = sFocusLast;
	int nDCRoll = 10+ d10(1);
	SendMessageToPC(oScryer, "nDCRoll = " + IntToString(nDCRoll));
	float fDCAbility = (GetAbilityModifier(ABILITY_CHARISMA, oTarget) + GetAbilityModifier(ABILITY_CONSTITUTION, oTarget) + GetAbilityModifier(ABILITY_DEXTERITY, oTarget) + GetAbilityModifier(ABILITY_INTELLIGENCE, oTarget) + GetAbilityModifier(ABILITY_STRENGTH, oTarget) + GetAbilityModifier(ABILITY_WISDOM, oTarget))/6.0 ;
	SendMessageToPC(oScryer, "fDCAbility = " + FloatToString(fDCAbility));
	fDCAbility = pow(fDCAbility, 2.0);
	SendMessageToPC(oScryer, "fDCAbility = " + FloatToString(fDCAbility));
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
	SendMessageToPC(oScryer, "nDCAbility = " + IntToString(nDCAbility));
	int nDC = nDCRoll + nDCAbility;
	SendMessageToPC(oScryer, "nDC = " + IntToString(nDC));
		
	int nScryer = 0;
	if(sScryerName == GetStringRight(sFocus, nCountScryerName)) {
		nScryer = 1;
		}
	
	if(oTarget == OBJECT_INVALID) {
		SendMessageToPC(oScryer, "You must use your scrying shard on a scrying object within three feet.");
		return;
		}
	
	if((FindSubString(GetTag(oTarget), "_SCRY") != -1) && (GetObjectType(oTarget) == OBJECT_TYPE_PLACEABLE) && (sTargetRes != "")) {
		
		//Create undetectable OOC Scrying Namer at location of Scrying Object to receive 10 letter Roster Name for stored scrying target
		    object oScryNamer = GetLocalObject(oTarget, "oScryNamer");
			if(oScryNamer == OBJECT_INVALID) {
				oScryNamer = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_scry_namer", GetLocation(oTarget));
	            SetLocalObject(oScryNamer, "oScryer", oScryer);
				SetLocalObject(oScryNamer, "oTarget", oTarget);
				SetLocalString(oScryNamer, "sTargetRes", sFocusLast);
				}
			 
			if(nScryer == 1) {
				if(FindSubString(sFocus, "Image", 0) != -1) {
					SendMessageToPC(oScryer, "*A faint, still image of " + sTargetName + " appears in the " + GetName(oTarget));
					DelayCommand(2.0, SendMessageToPC(oScryer, "You feel the match of your arcane signature resonate back from this scrying shard, as its creator. Future scrying of this subject will proceed with the firsthand knowledge imbued herewith."));	
				}
				
				else if(FindSubString(sFocus, "Imago", 0) != -1) {
					SendMessageToPC(oScryer, "*A lifelike, animated image of " + sTargetName + " appears in the " + GetName(oTarget));
				    DelayCommand(2.0, SendMessageToPC(oScryer, "You feel the match of your arcane signature resonate back from this scrying shard, as its creator.  Future scrying of this subject will benefit from the familiarity imbued herewith."));	
				}
			}
			if(nScryer == 0) {
				SendMessageToPC(oScryer, "*A nearly translucent, roughly sketched image of " + sTargetName + " appears in the " + GetName(oTarget));
				DelayCommand(2.0, SendMessageToPC(oScryer, "The arcane signature of this scrying shard and its holder are not a match. Future scrying of this subject will be at secondhand knowledge only."));	
				
			}
			
			DelayCommand(4.0, AssignCommand(oTarget, ActionSpeakString("Please speak a name no longer than 10 letters for this potential scrying subject.", TALKVOLUME_TALK)));	
			SendMessageToPC(oScryer, "These are the names of the wider populace keyed into this " + GetName(oTarget) +":");
			string sRoster = GetFirstRosterMember();
			int nInc = 0;
			while((sRoster != "") && (nInc < 10)) {
				SendMessageToPC(oScryer, sRoster);
				sRoster = GetNextRosterMember();
				nInc++;
			}
			
		}
		
	else if((GetObjectType(oTarget) == OBJECT_TYPE_CREATURE) && (GetLastName(oFocus) == "")) {
		if((GetLocalInt(oTarget, "Focusized_" + GetName(oScryer)) == 0) || (GetIsDMPossessed(oScryer))) {
			DelayCommand(900.0, SetLocalInt(oTarget, "Focusized_" + GetName(oScryer), 0));
			if(GetIsSkillSuccessful(oScryer, SKILL_CONCENTRATION, nDC, TRUE)) {
				SetLocalInt(oTarget, "Focusized_" + GetName(oScryer), 1);
				SendMessageToPC(oScryer, "You memorize the defining characteristics of " + GetName(oTarget) + " and focus your perception of them into the scrying shard. The image of " + GetName(oTarget) + " shimmers into the shard and remains fixed there faintly, unmoving.");
				SetFirstName(oFocus, GetName(oTarget) + " Image: " + GetFirstName(oScryer));
				SetDescription(oFocus, "A scrying shard showing a faint reflection of " + GetName(oTarget) + ". This shard was created by " + GetName(oScryer) + " and establishes firsthand knowledge of " + GetName(oTarget) + " for " + GetName(oScryer) + " or secondhand knowledge for anybody else who holds it.");
				if(GetIsPC(oTarget) == FALSE) {
					SetLastName(oFocus, GetResRef(oTarget));
					}
				else if(GetIsPC(oTarget) == TRUE) {
					SetLastName(oFocus, GetName(oTarget));
					}
				}
			else {
				 SetLocalInt(oTarget, "Focusized_" + GetName(oScryer), 2);
				 SendMessageToPC(oScryer, "You are unable to concentrate enough to memorize the constantly changing expressions, postures, gait, and other defining details of " + GetName(oTarget) + " and focus them into the shard. You will have to try again another time.");
				}
			}
		else if(GetLocalInt(oTarget, "Focusized_" + GetName(oScryer)) == 1) {
			SendMessageToPC(oScryer, "You have already memorized the constantly changing expressions, postures, gait, and other defining details of " + GetName(oTarget) + " today and focused them into the shard. You will have to try to improve on your understandings at a later time.");
		}
		else if(GetLocalInt(oTarget, "Focusized_" + GetName(oScryer)) == 2) {
			SendMessageToPC(oScryer, "You have already tried and failed to memorize the constantly changing expressions, postures, gait, and other defining details of " + GetName(oTarget) + " and focus them into the shard. You will have to try again at a later time.");
		}
	}
	
	else if((GetObjectType(oTarget) == OBJECT_TYPE_CREATURE) && (GetName(oTarget) == sTargetName) && (GetLastName(oFocus) != "")) {
		if((GetLocalInt(oTarget, "Focusized_" + GetName(oScryer)) == 0) || (GetIsDMPossessed(oScryer))) {
			 DelayCommand(900.0, SetLocalInt(oTarget, "Focusized_" + GetName(oScryer), 0));
			 if(GetIsSkillSuccessful(oScryer, SKILL_CONCENTRATION, nDC, TRUE)) {
				SetLocalInt(oTarget, "Focusized_" + GetName(oScryer), 1);
			 	SendMessageToPC(oScryer, "Your familiarity with " + GetName(oTarget) + " increases. You see the existing image of " + GetName(oTarget) + " in the scrying shard take on depth, dimension, and movement, blinking every now and then.");
				SetFirstName(oFocus, GetName(oTarget) + " Imago: " + GetFirstName(oScryer));
				SetDescription(oFocus, "A scrying shard showing the imago of " + GetName(oTarget) + " in realistic, living condition, chest rising and falling, every so often smiling or frowning. This shard was enspelled by " + GetName(oScryer) + " and establishes familiar knowledge of " + GetName(oTarget) + " for " + GetName(oScryer) + " or secondhand knowledge for anybody else who holds it.");
				}
		     else {
			    SetLocalInt(oTarget, "Focusized_" + GetName(oScryer), 2);
				SendMessageToPC(oScryer, "You are unable to concentrate enough to improve your grasp of the defining details of " + GetName(oTarget) + " and focus them into the shard. You will have to try again another time.");
				}
			}
		else if(GetLocalInt(oTarget, "Focusized_" + GetName(oScryer)) == 1) {
			SendMessageToPC(oScryer, "You have already memorized the constantly changing expressions, postures, gait, and other defining details of " + GetName(oTarget) + " today and focused them into the shard. You will have to try to improve on your understandings at a later time.");
		}
		else if(GetLocalInt(oTarget, "Focusized_" + GetName(oScryer)) == 2) {
			SendMessageToPC(oScryer, "You have already tried and failed to memorize the constantly changing expressions, postures, gait, and other defining details of " + GetName(oTarget) + " and focus them into the shard. You will have to try again at a later time.");
		}
	}
}