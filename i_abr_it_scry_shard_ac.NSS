
#include "acr_spawn_i"
#include "acr_db_persist_i"

void main()
{
             
    object oMaster = GetItemActivator();
	object oTarget = GetItemActivatedTarget();
	location lTarget = GetLocation(oTarget);
	object oShard = GetItemActivated();
	
	string sRoster = GetFirstRosterMember();
	int nRoster = 1;
	while (sRoster != "") {
		nRoster++;
		sRoster = GetNextRosterMember();
	}
    
	string sTargetRes = GetCampaignString("ALFA_SCRY", GetTag(oShard), oMaster);
	SendMessageToPC(oMaster, GetTag(oShard)+ " = " + sTargetRes);

	if((FindSubString(GetTag(oTarget), "_SCRY") != -1) && (GetObjectType(oTarget) == OBJECT_TYPE_PLACEABLE) && (sTargetRes != "")) {
		
		//Create undetectable OOC Scrying Namer at location of Scrying Object to receive 10 letter Roster Name for stored scrying target
		    SetLocalInt(oMaster, "nNamed", 1);
			object oScryNamer = GetLocalObject(oTarget, "oScryNamer");
			if(oScryNamer == OBJECT_INVALID) {
				oScryNamer = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_scry_namer", GetLocation(oTarget));
	            SetLocalObject(oScryNamer, "oScryer", oMaster);
				SetLocalObject(oScryNamer, "oTarget", oTarget);
				SetLocalString(oScryNamer, "sTargetRes", sTargetRes);
				SetLocalString(oScryNamer, "sShard", GetTag(oShard));
				}
			 
			SendMessageToPC(oMaster, "*An image of " + GetName(oTarget) + " appears in the " + GetName(oTarget));	
		    AssignCommand(oTarget, ActionSpeakString("Please speak a name no longer than 10 letters for this subject. *Pleasant voice.", TALKVOLUME_TALK));	
		}
		
	else if(GetObjectType(oTarget) == OBJECT_TYPE_CREATURE) {
		SetTag(oShard, "scry_" + GetResRef(oTarget));
		SetCampaignString("ALFA_SCRY", GetTag(oShard), GetResRef(oTarget), oMaster); 
		SendMessageToPC(oMaster, "You see the image of " + GetName(oTarget) + " shimmer into the " + GetName(oShard) + " and remain fixed there, unmoving.");
		string sName = GetName(oShard);
		SetFirstName(oShard, GetName(oTarget) + " " + sName);
		SetDescription(oShard, "A " + sName + " with a reflection of " + GetName(oTarget) + " somehow fixed into it.");
		}
	

}