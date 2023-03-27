////////////////////////////////////////////////////////////////////////////////
//
//                     Wynna			3/15/2023  
//------------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////////


#include "acr_spawn_i"
#include "acr_area_i"

void main()
{   SendMessageToPC(GetItemActivator(), "Leave area after NPC possession to refresh Omega Wand abilities.");
    ExecuteScript("acf_area_onexit", GetItemActivator());
	ExecuteScript("acf_area_client", GetItemActivator());
	
	SetLocalObject(GetModule(), "OmegaDM", GetItemActivator());
	SendMessageToAllDMs("omegaDM = " + GetName(GetLocalObject(GetModule(), "OmegaDM")));
	SendMessageToPC(GetLocalObject(GetModule(), "OmegaDM"), "omegaDM = " + GetName(GetLocalObject(GetModule(), "OmegaDM")));
	object oObject = GetItemActivatedTarget();
	location lTarget = GetItemActivatedTargetLocation();
	SetLocalLocation(GetItemActivator(), "lCreate", lTarget);
	int nTargetType = GetObjectType(oObject);
 	if ((nTargetType == OBJECT_TYPE_DOOR) || (nTargetType == OBJECT_TYPE_PLACEABLE)|| (nTargetType == OBJECT_TYPE_CREATURE)) 
		{SetLocalObject(GetItemActivator(), "Object_Target", oObject);} 
	else 
		{
	    oObject = GetNearestObjectToLocation(OBJECT_TYPE_TRIGGER, lTarget);
		SetLocalObject(GetItemActivator(), "Object_Target", oObject);
		}
		
	AssignCommand(GetLocalObject(GetModule(), "OmegaDM"), ActionStartConversation(GetLocalObject(GetModule(), "OmegaDM"), "omega_wand_wyn", TRUE, TRUE, TRUE, TRUE ));
   	}