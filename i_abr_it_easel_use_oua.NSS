//Wynna November 2020


#include "acr_items_i"
#include "acr_spawn_i"
#include "acr_tools_i"
#include "acr_db_persist_i"


void main()
{	
	object oLoser = GetModuleItemLostBy();
    object oMod = GetModule();
	object oReceiver = GetModuleItemAcquiredBy();
	object oItem = GetModuleItemLost();
	
	location lReceiver = GetLocation(oReceiver);
	vector vReceiver = GetPositionFromLocation(lReceiver);
	vector vObject = Vector(vReceiver.x, vReceiver.y, vReceiver.z + 3.0);
	location lObject = Location(GetArea(oReceiver), vObject, 0.0); 
	object oObjectPLC = CreateObject(OBJECT_TYPE_PLACEABLE, "abr_plc_easel_use", lObject);
    DestroyObject(oItem);
		
			 

	}