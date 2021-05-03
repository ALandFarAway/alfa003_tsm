//Wynna July 2020


#include "acr_placeable_i"
#include "acr_xp_i"
#include "acr_quest_i"
#include "acr_spawn_i"



void main()
{
	ACR_PlaceableOnOpen();
	//SendMessageToAllDMs("onopen create fired");
	object oPC = GetLastOpenedBy();
	string sCreateType = GetLocalString(OBJECT_SELF, "OBJECT_TYPE_STRING");
	int nCreateType = OBJECT_TYPE_CREATURE;
	if(sCreateType == "Placeable")
		{nCreateType = OBJECT_TYPE_PLACEABLE;}
	if(sCreateType == "Item")
		{nCreateType = OBJECT_TYPE_ITEM;}
	string sCreate = GetLocalString(OBJECT_SELF, "RESREF_TO_CREATE");
	string sCreateLocation = GetLocalString(OBJECT_SELF, "LOCATION_WP_STRING");
	object oCreateLocation = GetWaypointByTag(sCreateLocation);
	location lCreateLocation = GetLocation(oCreateLocation);
	//SendMessageToAllDMs("sCreate = " + sCreate);
	//SendMessageToAllDMs("sCreateLocation = " + sCreateLocation);
	if(oCreateLocation == OBJECT_INVALID)
		{lCreateLocation = GetLocation(OBJECT_SELF);
		//SendMessageToAllDMs("lCreateLocation invalid");
	}
	
	string sCreateTypeTwo = GetLocalString(OBJECT_SELF, "OBJECT_TYPE_STRING_TWO");
	int nCreateTypeTwo = OBJECT_TYPE_CREATURE;
	if(sCreateTypeTwo == "Placeable")
		{nCreateTypeTwo = OBJECT_TYPE_PLACEABLE;}
	if(sCreateTypeTwo == "Item")
		{nCreateTypeTwo = OBJECT_TYPE_ITEM;}
	string sCreateTwo = GetLocalString(OBJECT_SELF, "RESREF_TO_CREATE_TWO");
	string sCreateLocationTwo = GetLocalString(OBJECT_SELF, "LOCATION_WP_STRING_TWO");
	object oCreateLocationTwo = GetWaypointByTag(sCreateLocationTwo);
	location lCreateLocationTwo = GetLocation(oCreateLocationTwo);
	if(oCreateLocationTwo == OBJECT_INVALID)
		{lCreateLocationTwo = GetLocation(OBJECT_SELF);
		//SendMessageToAllDMs("lCreateLocationTwo invalid");
		}
	
		
	string sMessage = GetLocalString(OBJECT_SELF, "CREATE_MESSAGE_STRING");
	string sBroadcast = GetLocalString(OBJECT_SELF, "CREATE_BROADCAST_STRING");
	//SendMessageToAllDMs("sMessage = " + sMessage);
	//SendMessageToAllDMs("sBroadcast = " + sBroadcast);
	int nDelay = GetLocalInt(OBJECT_SELF, "CREATE_DELAY_INT");
	float fDelay = IntToFloat(nDelay);
	int nDestroy = GetLocalInt(OBJECT_SELF, "DESTROY_SELF");
	int nDestroyDelay = GetLocalInt(OBJECT_SELF, "DESTROY_DELAY");
	float fDestroyDelay = IntToFloat(nDestroyDelay);
	int nPlayOnce = GetLocalInt(OBJECT_SELF, "PLAY_ONCE");
	int nNumberCreate = GetLocalInt(OBJECT_SELF, "CREATE_NUMBER");
	if (nNumberCreate == 0) {
		nNumberCreate = 1;
	}
	if(nPlayOnce == 1) {
			SendMessageToAllDMs("nPlayOnce = 1");
			
			int a = 0;
			while(a < nNumberCreate) {
			SendMessageToAllDMs("a = " + IntToString(a));
			object oCreate = CreateObject(nCreateType, sCreate, lCreateLocation, FALSE);
			SendMessageToAllDMs("sCreateTwo = " + sCreateTwo);
			SendMessageToAllDMs("sCreateLocationTwo = " + sCreateLocationTwo);
	 		object oCreateTwo = CreateObject(nCreateTypeTwo, sCreateTwo, lCreateLocationTwo, FALSE);
			a++;
			}
			SetLocalInt(OBJECT_SELF, "PLAY_ONCE", 2);
		}
		
	if(nPlayOnce == 0) {
		SendMessageToAllDMs("nPlayOnce = 0");
		SendMessageToPC(oPC, sMessage);
		SetLocalInt(OBJECT_SELF, "PLAY_ONCE", 1);
		ActionSpeakString(sBroadcast, TALKVOLUME_TALK);
		DelayCommand(fDelay, ExecuteScript("tsm_plc_onopen_create", OBJECT_SELF));
		}
	
	if(nDestroy == 1)
		{DestroyObject(OBJECT_SELF, fDestroyDelay);}
			
}