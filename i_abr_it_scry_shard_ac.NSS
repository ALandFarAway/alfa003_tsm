
#include "acr_spawn_i"
#include "acr_db_persist_i"

void main()
{
             
    object oMaster = GetItemActivator();
	object oTarget = GetItemActivatedTarget();
	object oShard = GetItemActivated();
	string sTargetRes = GetDescription(oShard);
	//string sTargetRes = GetCampaignString("ALFA_SCRY", GetTag(oShard) + "_" + GetResRef(oTarget), oMaster);
	//SendMessageToPC(oMaster, GetTag(oShard) + "_" + GetResRef(oTarget) + " = " + sTargetRes);

	if((FindSubString(GetTag(oTarget), "_SCRY") != -1) && (GetObjectType(oTarget) == OBJECT_TYPE_PLACEABLE) && (sTargetRes != "")) {
		
		//Create undetectable OOC Scrying Namer at location of Scrying Object to receive 10 letter Roster Name for stored scrying target
		    object oScryNamer = GetLocalObject(oTarget, "oScryNamer");
			if(oScryNamer == OBJECT_INVALID) {
				oScryNamer = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_scry_namer", GetLocation(oTarget));
	            SetLocalObject(oScryNamer, "oScryer", oMaster);
				SetLocalObject(oScryNamer, "oTarget", oTarget);
				SetLocalObject(oScryNamer, "oShard", oShard);
				SetLocalString(oScryNamer, "sTargetRes", sTargetRes);
				SetLocalString(oScryNamer, "sShard", GetTag(oShard));
				}
			 
			SendMessageToPC(oMaster, "*An image of " + GetName(oTarget) + " appears in the " + GetName(oTarget));	
		    AssignCommand(oTarget, ActionSpeakString("Please speak a name no longer than 10 letters for this subject. *Pleasant voice.", TALKVOLUME_TALK));	
		}
		
	else if(GetObjectType(oTarget) == OBJECT_TYPE_CREATURE) {
		SendMessageToPC(oMaster, "You see the image of " + GetName(oTarget) + " shimmer into the " + GetName(oShard) + " and remain fixed there, unmoving.");
		SendMessageToPC(oMaster, "oShard Tag = " + GetTag(oShard));
		//SetCampaignString("ALFA_SCRY", GetTag(oShard) + "_" + GetResRef(oTarget), GetResRef(oTarget), oMaster); 
		string sName = GetName(oShard);
		SetFirstName(oShard, GetName(oTarget) + " " + sName);
		SetDescription(oShard, GetResRef(oTarget));
		//SetDescription(oShard, "A " + sName + " with a reflection of " + GetName(oTarget) + " somehow fixed into it.");
		}
	

}