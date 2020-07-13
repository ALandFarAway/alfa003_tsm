//Wynna July 2020


#include "acr_placeable_i"
#include "acr_xp_i"
#include "acr_quest_i"
#include "acr_spawn_i"




void main()
{
	ACR_PlaceableOnOpen();

	object oPC = GetLastOpenedBy();
	string sCreateType = GetLocalString(OBJECT_SELF, "OBJECT_TYPE_STRING");
	int nCreateType = OBJECT_TYPE_CREATURE;
	if(sCreateType == "Placeable")
		{nCreateType = OBJECT_TYPE_PLACEABLE;}
	if(sCreateType == "Item")
		{nCreateType = OBJECT_TYPE_ITEM;}
	string sCreate = GetLocalString(OBJECT_SELF, "RESREF_TO_CREATE");
	string sCreateLocation = GetLocalString(OBJECT_SELF, "LOCATION_WP_STRING");
	object oCreateLocation = GetNearestObjectByTag(sCreateLocation);
	location lCreateLocation = GetLocation(oCreateLocation);
	if(oCreateLocation == OBJECT_INVALID)
		{lCreateLocation = GetLocation(OBJECT_SELF);}

    
	object oCreate = CreateObject(nCreateType, sCreate, lCreateLocation, FALSE);
			
}