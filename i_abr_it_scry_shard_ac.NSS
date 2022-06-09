
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
	int nCountName = GetStringLength(sToken);
	string sTargetName = GetStringLeft(sToken, nCountName - 6);
	string sScryerName = GetFirstName(oScryer);
	int nCountScryerName = GetStringLength(sScryerName);
	int nTargetRes = GetStringLength(sTokenLast);
	string sTargetRes = GetStringLeft(sTokenLast, nTargetRes - nCountScryerName);
	int nDC = 20 + GetAbilityModifier(ABILITY_DEXTERITY, oTarget);
	int nScryer = 0;
	if(sScryerName == GetStringRight(sTokenLast, nCountScryerName)) {
		nScryer = 1;
		}
	
	
	SendMessageToPC(oScryer, "sTargetRes = " + sTargetRes);
	SendMessageToPC(oScryer, "sTargetName = " + sTargetName);
	SendMessageToPC(oScryer, "nDC = " + IntToString(nDC));
	SendMessageToPC(oScryer, "nScryer = " + IntToString(nScryer));
	SendMessageToPC(oScryer, "sLastName = " + sTokenLast);
	SendMessageToPC(oScryer, "sScryerName from Token's Last Name = " + GetStringRight(sTokenLast, nCountScryerName)); 

	if((FindSubString(GetTag(oTarget), "_SCRY") != -1) && (GetObjectType(oTarget) == OBJECT_TYPE_PLACEABLE) && (sTargetRes != "")) {
		
		//Create undetectable OOC Scrying Namer at location of Scrying Object to receive 10 letter Roster Name for stored scrying target
		    object oScryNamer = GetLocalObject(oTarget, "oScryNamer");
			if(oScryNamer == OBJECT_INVALID) {
				oScryNamer = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_scry_namer", GetLocation(oTarget));
	            SetLocalObject(oScryNamer, "oScryer", oScryer);
				SetLocalObject(oScryNamer, "oTarget", oTarget);
				SetLocalString(oScryNamer, "sTargetRes", sTargetRes);
				}
			 
			if(nScryer == 1) {
				if(FindSubString(sToken, "Image", 0) != -1) {
					SendMessageToPC(oScryer, "*A faint, still image of " + sTargetName + " appears in the " + GetName(oTarget));
					AssignCommand(oTarget, ActionSpeakString("The match between the arcane signature of this scrying shard and its holder is noted. Scrying of this subject will proceed with the firsthand knowledge imbued herewith. *Pleasant voice.", TALKVOLUME_TALK));	
				}
				
				else if(FindSubString(sToken, "Imago", 0) != -1) {
					SendMessageToPC(oScryer, "*A lifelike, animated image of " + sTargetName + " appears in the " + GetName(oTarget));
				    AssignCommand(oTarget, ActionSpeakString("The match between the arcane signature of this scrying shard and its holder is noted. Scrying of this subject will benefit from the familiarity imbued herewith. *Pleasant voice.", TALKVOLUME_TALK));	
				}
			}
			if(nScryer == 0) {
				SendMessageToPC(oScryer, "*A nearly translucent, roughly sketched image of " + sTargetName + " appears in the " + GetName(oTarget));
					AssignCommand(oTarget, ActionSpeakString("The arcane signature of this scrying shard and its holder are not a match. Scrying of this subject will be at secondhand knowledge only. *Pleasant voice.", TALKVOLUME_TALK));	
				
			}
			
			//string sRosterMember = GetFirstRosterMember();
			AssignCommand(oTarget, ActionSpeakString("Please speak a name no longer than 10 letters for this potential scrying subject.", TALKVOLUME_TALK));	
		}
		
	else if((GetObjectType(oTarget) == OBJECT_TYPE_CREATURE) && (GetLastName(oToken) == "")) {
		if(GetIsSkillSuccessful(oScryer, SKILL_CONCENTRATION, nDC, TRUE)) {
			SendMessageToPC(oScryer, "You memorize the defining characteristics of " + GetName(oTarget) + " and focus your perception of them into the scrying shard. The image of " + GetName(oTarget) + " shimmers into the reflective surface and remains fixed there faintly, unmoving.");
			SetFirstName(oToken, GetName(oTarget) + " Image");
			SetLastName(oToken, GetResRef(oTarget) + " " + GetFirstName(oScryer));
			SetDescription(oToken, "A scrying shard showing a faint reflection of " + GetName(oTarget) + ". This shard was created by " + GetName(oScryer) + " and establishes firsthand knowledge of " + GetName(oTarget) + " for " + GetName(oScryer) + " or secondhand knowledge for anybody else who holds it.");
			}
		else {SendMessageToPC(oScryer, "You are unable to concentrate enough to memorize the constantly changing expressions, postures, gait, and other defining details of " + GetName(oTarget) + " and focus them into the Token. You will have to try again another time.");
			}
		}
	
	else if((GetObjectType(oTarget) == OBJECT_TYPE_CREATURE) && (GetName(oTarget) == sTargetName) && (GetLastName(oToken) != "")) {
		 if(GetIsSkillSuccessful(oScryer, SKILL_CONCENTRATION, nDC, TRUE)) {
			SendMessageToPC(oScryer, "Your familiarity with " + GetName(oTarget) + " increases. You see the existing image of " + GetName(oTarget) + " in the scrying shard take on depth, dimension, and movement, blinking every now and then.");
			SetFirstName(oToken, GetName(oTarget) + " Imago");
			SetDescription(oToken, "A scrying shard showing the imago of " + GetName(oTarget) + " in realistic, living condition, chest rising and falling, every so often smiling or frowning. This shard was enspelled by " + GetName(oScryer) + " and establishes familiar knowledge of " + GetName(oTarget) + " for " + GetName(oScryer) + " or secondhand knowledge for anybody else who holds it.");
			}
	     else {SendMessageToPC(oScryer, "You are unable to concentrate enough to improve your grasp of the defining details of " + GetName(oTarget) + " and focus them into the shard. You will have to try again another time.");
			}
		}

}