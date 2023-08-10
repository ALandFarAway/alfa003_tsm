//Wynna August 2023


#include "acr_placeable_i"
#include "acr_xp_i"
#include "acr_quest_i"
#include "acr_spawn_i"

void ActionCreateCreature(string sCreature, location lLocPlace)
{
    CreateObject(OBJECT_TYPE_CREATURE, sCreature, lLocPlace, FALSE);
}

void ActionCreatePLC(string sPLC, location lLocPlace)
{
    CreateObject(OBJECT_TYPE_PLACEABLE, sPLC, lLocPlace, FALSE);
}
void main()
{
	
		if(GetLocalInt(OBJECT_SELF, "Run_Once") != 1) {
		SetLocalInt(OBJECT_SELF, "Run_Once", 1);
		string sCreateType = GetLocalString(OBJECT_SELF, "OBJECT_TYPE_STRING");
		int nCreateType = OBJECT_TYPE_CREATURE;
		if(sCreateType == "Placeable")
			{nCreateType = OBJECT_TYPE_PLACEABLE;}
		if(sCreateType == "Item")
			{nCreateType = OBJECT_TYPE_ITEM;}
		string sCreate = GetLocalString(OBJECT_SELF, "RESREF_TOUCHED_A");
		string sCreateLocation = GetLocalString(OBJECT_SELF, "LOCATION_TOUCHED_A");
		object oCreateLocation = GetWaypointByTag(sCreateLocation);
		location lCreateLocation = GetLocation(oCreateLocation);
		if(oCreateLocation == OBJECT_INVALID)
			{lCreateLocation = GetLocation(OBJECT_SELF);
			}
		
		string sCreateTwo = GetLocalString(OBJECT_SELF, "RESREF_TOUCHED_B");
		string sCreateLocationTwo = GetLocalString(OBJECT_SELF, "LOCATION_TOUCHED_B");
		object oCreateLocationTwo = GetWaypointByTag(sCreateLocationTwo);
		location lCreateLocationTwo = GetLocation(oCreateLocationTwo);
		if(oCreateLocationTwo == OBJECT_INVALID)
			{lCreateLocationTwo = GetLocation(OBJECT_SELF);
			}
		
			
		string sBroadcast = GetLocalString(OBJECT_SELF, "BROADCAST_TOUCHED");
		int nPlayOnce = GetLocalInt(OBJECT_SELF, "PLAY_ONCE_TOUCHED");
		
	 
				SendMessageToAllDMs("plc ontouched create " + sCreate);
				ActionSpeakString(sBroadcast, TALKVOLUME_TALK);
			
				
					object oCreate = CreateObject(nCreateType, sCreate, lCreateLocation, FALSE);
					object oCreateTwo = CreateObject(OBJECT_TYPE_PLACEABLE, sCreateTwo, lCreateLocationTwo, FALSE);
		}		
}