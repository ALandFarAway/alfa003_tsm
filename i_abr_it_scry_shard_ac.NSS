
#include "acr_spawn_i"
#include "acr_db_persist_i"
#include "acr_scry_i"

void main()
{
             
    object oMaster = GetItemActivator();
	object oTarget = GetItemActivatedTarget();
	object oShard = GetItemActivated();
	int nCountName = GetStringLength(GetFirstName(oShard));
	string sTargetName = GetStringLeft(GetFirstName(oShard), nCountName - 6);
	int nCountMasterName = GetStringLength(GetFirstName(oMaster));
	int nTargetRes = GetStringLength(GetLastName(oShard));
	string sTargetRes = GetStringLeft(GetLastName(oShard), nTargetRes - nCountMasterName);
	int nDC = 20 + GetAbilityModifier(ABILITY_DEXTERITY, oTarget);
	//string sTargetRes = GetCampaignString("ALFA_SCRY", GetTag(oShard) + "_" + GetResRef(oTarget), oMaster);
	SendMessageToPC(oMaster, "sLastName = " + GetLastName(oShard));
	SendMessageToPC(oMaster, "sTargetRes = " + sTargetRes);
	SendMessageToPC(oMaster, "sTargetName = " + sTargetName);
	SendMessageToPC(oMaster, "nDC = " + IntToString(nDC));

	if((FindSubString(GetTag(oTarget), "_SCRY") != -1) && (GetObjectType(oTarget) == OBJECT_TYPE_PLACEABLE) && (sTargetRes != "")) {
		
		//Create undetectable OOC Scrying Namer at location of Scrying Object to receive 10 letter Roster Name for stored scrying target
		    object oScryNamer = GetLocalObject(oTarget, "oScryNamer");
			if(oScryNamer == OBJECT_INVALID) {
				oScryNamer = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_scry_namer", GetLocation(oTarget));
	            SetLocalObject(oScryNamer, "oScryer", oMaster);
				SetLocalObject(oScryNamer, "oTarget", oTarget);
				SetLocalString(oScryNamer, "sTargetRes", sTargetRes);
				}
			 
			SendMessageToPC(oMaster, "*An image of " + sTargetName + " appears in the " + GetName(oTarget));
			string sRosterMember = GetFirstRosterMember();
			AssignCommand(oTarget, ActionSpeakString("Please speak a name no longer than 10 letters for this subject. *Pleasant voice.", TALKVOLUME_TALK));	
		}
		
	else if((GetObjectType(oTarget) == OBJECT_TYPE_CREATURE) && (GetLastName(oShard) == "")) {
		if(GetIsSkillSuccessful(oMaster, SKILL_CONCENTRATION, nDC, TRUE)) {
			SendMessageToPC(oMaster, "You memorize the defining characteristics of " + GetName(oTarget) + " and focus your perception of them into the scrying shard. The image of " + GetName(oTarget) + " shimmers into the reflective surface and remains fixed there faintly, unmoving.");
			SetFirstName(oShard, GetName(oTarget) + " Image");
			SetLastName(oShard, GetResRef(oTarget) + " " + GetFirstName(oMaster));
			SetDescription(oShard, "A scrying shard showing a faint reflection of " + GetName(oTarget) + ". This shard was created by " + GetName(oMaster) + " and establishes firsthand knowledge of " + GetName(oTarget) + " for " + GetName(oMaster) + " or secondhand knowledge for anybody else who holds it.");
			}
		else {SendMessageToPC(oMaster, "You are unable to concentrate enough to memorize the constantly changing expressions, postures, gait, and other defining details of " + GetName(oTarget) + " and focus them into the shard. You will have to try again another time.");
			}
		}
	
	else if((GetObjectType(oTarget) == OBJECT_TYPE_CREATURE) && (GetName(oTarget) == sTargetName) && (GetLastName(oShard) != "")) {
		 if(GetIsSkillSuccessful(oMaster, SKILL_CONCENTRATION, nDC, TRUE)) {
			SendMessageToPC(oMaster, "Your familiarity with " + GetName(oTarget) + " increases. You see the existing image of " + GetName(oTarget) + " in the scrying shard take on depth, dimension, and movement, blinking every now and then.");
			SetFirstName(oShard, GetName(oTarget) + " Imago");
			SetDescription(oShard, "A scrying shard showing the imago of " + GetName(oTarget) + " in realistic, living condition, chest rising and falling, every so often smiling or frowning. This shard was enspelled by " + GetName(oMaster) + " and establishes familiar knowledge of " + GetName(oTarget) + " for " + GetName(oMaster) + " or secondhand knowledge for anybody else who holds it.");
			}
	     else {SendMessageToPC(oMaster, "You are unable to concentrate enough to improve your grasp of the defining details of " + GetName(oTarget) + " and focus them into the shard. You will have to try again another time.");
			}
		}

}