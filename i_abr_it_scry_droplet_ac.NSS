
#include "acr_spawn_i"
#include "acr_db_persist_i"

void main()
{
             
    object oMaster = GetItemActivator();
	object oTarget = GetItemActivatedTarget();
	object oShard = GetItemActivated();
	int nCountName = GetStringLength(GetFirstName(oShard));
	string sTargetName = GetStringLeft(GetFirstName(oShard), nCountName - 6);
	string sTargetRes = GetLastName(oShard);
	//string sTargetRes = GetCampaignString("ALFA_SCRY", GetTag(oShard) + "_" + GetResRef(oTarget), oMaster);
	//SendMessageToPC(oMaster, "sTargetRes = " + sTargetRes);
	//SendMessageToPC(oMaster, "sTargetName = " + sTargetName);
	//SendMessageToPC(oMaster, "oTarget Tag = " + GetTag(oTarget));

	if((FindSubString(GetTag(oTarget), "_SCRY") != -1) && (GetObjectType(oTarget) == OBJECT_TYPE_PLACEABLE) && (sTargetRes != "")) {
		
		//Create undetectable OOC Scrying Namer at location of Scrying Object to receive 10 letter Roster Name for stored scrying target
		    object oScryNamer = GetLocalObject(oTarget, "oScryNamer");
			if(oScryNamer == OBJECT_INVALID) {
				oScryNamer = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_scry_namer", GetLocation(oTarget));
	            SetLocalObject(oScryNamer, "oScryer", oMaster);
				SetLocalObject(oScryNamer, "oTarget", oTarget);
				//SetLocalObject(oScryNamer, "oShard", oShard);
				SetLocalString(oScryNamer, "sTargetRes", sTargetRes);
				//SetLocalString(oScryNamer, "sShard", GetTag(oShard));
				}
			 
			SendMessageToPC(oMaster, "*An image of " + sTargetName + " appears in the " + GetName(oTarget));	
		    AssignCommand(oTarget, ActionSpeakString("Please speak a name no longer than 10 letters for this subject. *Pleasant voice.", TALKVOLUME_TALK));	
		}
		
	else if(GetObjectType(oTarget) == OBJECT_TYPE_CREATURE) {
		SendMessageToPC(oMaster, "You see the image of " + GetName(oTarget) + " shimmer into the scrying droplet and remain fixed there, unmoving.");
		//SendMessageToPC(oMaster, "oShard Tag = " + GetTag(oShard));
		//SetCampaignString("ALFA_SCRY", GetTag(oShard) + "_" + GetResRef(oTarget), GetResRef(oTarget), oMaster); 
		//string sName = GetName(oShard);
		SetFirstName(oShard, GetName(oTarget) + " Image");
		SetLastName(oShard, GetResRef(oTarget));
		SetDescription(oShard, "A scrying droplet showing a reflection of " + GetName(oTarget));
		}
	

}