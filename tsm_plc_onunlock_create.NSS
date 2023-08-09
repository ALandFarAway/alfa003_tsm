//Wynna July 2020


#include "acr_placeable_i"
#include "acr_xp_i"
#include "acr_quest_i"
#include "acr_spawn_i"

void ActionCreateCreature(string sCreature, location lLocPlace)
{
    CreateObject(OBJECT_TYPE_CREATURE, sCreature, lLocPlace, FALSE);
}

void main()
{
	ACR_PlaceableOnUnlock();
	if(GetLocalInt(OBJECT_SELF, "Run_Once") != 1) {
		SetLocalInt(OBJECT_SELF, "Run_Once", 1);
		object oPC = GetLastUnlocked();
		string sCreateType = GetLocalString(OBJECT_SELF, "OBJECT_TYPE_STRING");
		int nCreateType = OBJECT_TYPE_CREATURE;
		if(sCreateType == "Placeable")
			{nCreateType = OBJECT_TYPE_PLACEABLE;}
		if(sCreateType == "Item")
			{nCreateType = OBJECT_TYPE_ITEM;}
		if(sCreateType == "Door")
			{nCreateType = OBJECT_TYPE_DOOR;}
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
	 
				SendMessageToAllDMs("plc onunlock create " + sCreate);
				SendMessageToPC(oPC, sMessage);
			    ActionSpeakString(sBroadcast, TALKVOLUME_TALK);
			
				int a = 0;
				while(a < nNumberCreate) {
					SendMessageToAllDMs("a = " + IntToString(a));
					object oCreate = CreateObject(nCreateType, sCreate, lCreateLocation, FALSE);
					SendMessageToAllDMs("sCreateTwo = " + sCreateTwo);
					SendMessageToAllDMs("sCreateLocationTwo = " + sCreateLocationTwo);
			 		object oCreateTwo = CreateObject(nCreateTypeTwo, sCreateTwo, lCreateLocationTwo, FALSE);
					a++;
					} 
		
		if(nDestroy == 1)
			{DestroyObject(OBJECT_SELF, fDestroyDelay);}
			
		if(GetTag(OBJECT_SELF) == "5f_plc_mdr2_cave_in") {
			DestroyObject(GetObjectByTag("mdr2_cliff_wall", 0), 1.0, FALSE);
			DestroyObject(GetObjectByTag("mdr2_cliff_wall2", 0), 2.0, FALSE);
			DestroyObject(GetObjectByTag("mdr2_cliff_wall3", 0), 3.0, FALSE);
			DestroyObject(GetObjectByTag("mdr2_cliff_wall4", 0), 4.0, FALSE);
			DestroyObject(GetObjectByTag("mdr2_cliff_wall5", 0), 5.0, FALSE);
			DestroyObject(GetObjectByTag("mdr2_cliff_wall6", 0), 6.0, FALSE);
			
		}
	}			
}