#include "acr_spawn_i"
#include "acr_db_persist_i"
#include "acr_scry_i"

void main()
{
             
    object oScryer = GetItemActivator();
	object oTarget = GetItemActivatedTarget();
	object oToken = GetItemActivated();
	string sToken = GetFirstName(oToken);
	string sTokenLast = GetLastName(oToken);
	string sTargetRes = sTokenLast;
	string sTriggerTag;
	if(oTarget == OBJECT_INVALID) {
		location lTarget = GetItemActivatedTargetLocation();
		oTarget = GetFirstObjectInShape(SHAPE_SPHERE, 5.0, lTarget, FALSE, OBJECT_TYPE_TRIGGER);
		while(oTarget != OBJECT_INVALID) {
			sTriggerTag = GetTag(oTarget);
			//SendMessageToPC(oScryer, "sTriggerTag = " + sTriggerTag);
			if(FindSubString(sTriggerTag, "_SCRY_") != -1) {
				//SendMessageToPC(oScryer, "oTarget = " + GetName(oTarget));
				break;
				}
			oTarget = GetNextObjectInShape(SHAPE_SPHERE, 5.0, lTarget, FALSE, OBJECT_TYPE_TRIGGER);
			}
		}
	
	if(oTarget == OBJECT_INVALID) {
		SendMessageToPC(oScryer, "You must use your scrying droplet on a scrying object within three feet.");
		return;
		}
	int nCountName = GetStringLength(sToken);
	string sScryerName = GetFirstName(oScryer);
	int nCountScryerName = GetStringLength(sScryerName);
	string sTargetName = GetStringLeft(sToken, nCountName - 8 - nCountScryerName);
	int nDCRoll = d20(1);
	int nDCAbility = (GetAbilityModifier(ABILITY_CHARISMA, oTarget) + GetAbilityModifier(ABILITY_CONSTITUTION, oTarget) + GetAbilityModifier(ABILITY_DEXTERITY, oTarget) + GetAbilityModifier(ABILITY_INTELLIGENCE, oTarget) + GetAbilityModifier(ABILITY_STRENGTH, oTarget) + GetAbilityModifier(ABILITY_WISDOM, oTarget))/6 ;
	float fDCAbility = pow(IntToFloat(nDCAbility), 2.0);
	float fDC = IntToFloat(nDCRoll) + fDCAbility;
	int nDC = 0;
	if(fDC < 1.5)
		{nDC = 1;}
	else if(fDC < 2.5)
		{nDC = 2;}
	else if(fDC < 3.5)
		{nDC = 3;}
	else if(fDC < 4.5)
		{nDC = 4;}
	else if(fDC < 5.5)
		{nDC = 5;}
	
	int nScryer = 0;
	if(sScryerName == GetStringRight(sToken, nCountScryerName)) {
		nScryer = 1;
		}
	
	
	if((FindSubString(GetTag(oTarget), "_SCRY") != -1) && (GetObjectType(oTarget) == OBJECT_TYPE_PLACEABLE || OBJECT_TYPE_TRIGGER) && (sTargetRes != "")) {
		
		//Create undetectable OOC Scrying Namer at location of Scrying Object to receive 10 letter Roster Name for stored scrying target
		    object oScryNamer = GetLocalObject(oTarget, "oScryNamer");
			if(oScryNamer == OBJECT_INVALID) {
				oScryNamer = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_scry_namer", GetLocation(oTarget));
	            SetLocalObject(oScryNamer, "oScryer", oScryer);
				SetLocalObject(oScryNamer, "oTarget", oTarget);
				SetLocalString(oScryNamer, "sTargetRes", sTokenLast);
				}
			 
			if(nScryer == 1) {
				if(FindSubString(sToken, "Image", 0) != -1) {
					ActionSpeakString("*A faint, still image of " + sTargetName + " appears in the " + GetName(oTarget), TALKVOLUME_TALK);
					DelayCommand(2.0, AssignCommand(oTarget, ActionSpeakString("The match between the arcane signature of this scrying droplet and its holder is noted. Future scrying of this subject will proceed with the firsthand knowledge imbued herewith. *Pleasant voice.", TALKVOLUME_TALK)));	
					//SendMessageToPC(oScryer, "*A faint, still image of " + sTargetName + " appears in the " + GetName(oTarget));
					//DelayCommand(2.0, SendMessageToPC(oScryer, "The match between the arcane signature of this scrying droplet and its holder is noted. Future scrying of this subject will proceed with the firsthand knowledge imbued herewith. *Pleasant voice."));	
				
				}
				
				else if(FindSubString(sToken, "Imago", 0) != -1) {
					ActionSpeakString("*A lifelike, animated image of " + sTargetName + " appears in the " + GetName(oTarget), TALKVOLUME_TALK);
				    DelayCommand(2.0, AssignCommand(oTarget, ActionSpeakString("The match between the arcane signature of this scrying droplet and its holder is noted. Future scrying of this subject will benefit from the familiarity imbued herewith. *Pleasant voice.", TALKVOLUME_TALK)));	
					//SendMessageToPC(oScryer, "*A lifelike, animated image of " + sTargetName + " appears in the " + GetName(oTarget));
				    //DelayCommand(2.0, SendMessageToPC(oScryer, "The match between the arcane signature of this scrying droplet and its holder is noted. Future scrying of this subject will benefit from the familiarity imbued herewith. *Pleasant voice."));	
				
				}
			}
			if(nScryer == 0) {
				ActionSpeakString("*A nearly translucent, roughly sketched image of " + sTargetName + " appears in the " + GetName(oTarget), TALKVOLUME_TALK);
				DelayCommand(2.0, AssignCommand(oTarget, ActionSpeakString("The arcane signature of this scrying droplet and its holder are not a match. Future scrying of this subject will be at secondhand knowledge only. *Pleasant voice.", TALKVOLUME_TALK)));	
				//SendMessageToPC(oScryer, "*A nearly translucent, roughly sketched image of " + sTargetName + " appears in the " + GetName(oTarget));
				//DelayCommand(2.0, SendMessageToPC(oScryer, "The arcane signature of this scrying droplet and its holder are not a match. Future scrying of this subject will be at secondhand knowledge only. *Pleasant voice."));	
				
			}
			
			DelayCommand(4.0, SendMessageToPC(oScryer, "*Speak a name no longer than 10 letters for this potential scrying subject."));	
		    SendMessageToPC(oScryer, "These are the names of the wider populace keyed into this " + GetName(oTarget) +":");
			string sRoster = GetFirstRosterMember();
			int nInc = 0;
			while((sRoster != "") && (nInc < 10)) {
				SendMessageToPC(oScryer, sRoster);
				sRoster = GetNextRosterMember();
				nInc++;
			}
		}
		
	else if((GetObjectType(oTarget) == OBJECT_TYPE_CREATURE) && (GetLastName(oToken) == "")) {
		if(GetLocalInt(oTarget, "Tokenized_" + GetName(oScryer)) == 0) {
			if(GetIsSkillSuccessful(oScryer, SKILL_CONCENTRATION, nDC, TRUE)) {
				SendMessageToPC(oScryer, "You memorize the defining characteristics of " + GetName(oTarget) + " and focus your perception of them into the scrying droplet. The image of " + GetName(oTarget) + " shimmers into the droplet and remains fixed there faintly, unmoving.");
				SetFirstName(oToken, GetName(oTarget) + " Image: " + GetFirstName(oScryer));
				SetDescription(oToken, "A scrying droplet showing a faint reflection of " + GetName(oTarget) + ". This droplet was created by " + GetName(oScryer) + " and establishes firsthand knowledge of " + GetName(oTarget) + " for " + GetName(oScryer) + " or secondhand knowledge for anybody else who holds it.");
				if(GetIsPC(oTarget) == FALSE) {
					SetLastName(oToken, GetResRef(oTarget));
					}
				else if(GetIsPC(oTarget) == TRUE) {
					SetLastName(oToken, GetName(oTarget));
					}
				}
			else {SendMessageToPC(oScryer, "You are unable to concentrate enough to memorize the constantly changing expressions, postures, gait, and other defining details of " + GetName(oTarget) + " and focus them into the droplet. You will have to try again another time.");
				}
			}
			else {SendMessageToPC(oScryer, "You are unable to concentrate enough to memorize the constantly changing expressions, postures, gait, and other defining details of " + GetName(oTarget) + " and focus them into the shard. You will have to try again another time.");
			}
		}
	
	else if((GetObjectType(oTarget) == OBJECT_TYPE_CREATURE) && (GetName(oTarget) == sTargetName) && (GetLastName(oToken) != "")) {
		if(GetLocalInt(oTarget, "Tokenized_" + GetName(oScryer)) == 0) {
			 if(GetIsSkillSuccessful(oScryer, SKILL_CONCENTRATION, nDC, TRUE)) {
				SendMessageToPC(oScryer, "Your familiarity with " + GetName(oTarget) + " increases. You see the existing image of " + GetName(oTarget) + " in the scrying droplet take on depth, dimension, and movement, blinking every now and then.");
				SetFirstName(oToken, GetName(oTarget) + " Imago: " + GetFirstName(oScryer));
				SetDescription(oToken, "A scrying droplet showing the imago of " + GetName(oTarget) + " in realistic, living condition, chest rising and falling, every so often smiling or frowning. This droplet was enspelled by " + GetName(oScryer) + " and establishes familiar knowledge of " + GetName(oTarget) + " for " + GetName(oScryer) + " or secondhand knowledge for anybody else who holds it.");
				}
		     else {SendMessageToPC(oScryer, "You are unable to concentrate enough to improve your grasp of the defining details of " + GetName(oTarget) + " and focus them into the droplet. You will have to try again another time.");
				}
			}
		else {SendMessageToPC(oScryer, "You have already tried and failed to improve your grasp of the defining details of " + GetName(oTarget) + " and focus them into the shard. You will have to try again at a later time.");
			}
		}

}