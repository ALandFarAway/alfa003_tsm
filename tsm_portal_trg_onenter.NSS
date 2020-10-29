//Silvy Uni Trigger OnEnter. All triggers.
//Wynna September 2007


#include "acr_trigger_i"
#include "acr_spawn_i"
#include "acr_tools_i"
#include "acr_quest_i"

void main()
{	
	ACR_TriggerOnEnter();
	

if(FindSubString(GetTag(OBJECT_SELF), "_portal") != -1)
	{
	object oTraveller = GetEnteringObject();
    string sMyTarget = GetLocalString(OBJECT_SELF, "PORTAL_TARGET");
	object oMyWaypoint = GetWaypointByTag(sMyTarget);
	string sKeyTag = GetLocalString(OBJECT_SELF, "PORTAL_KEY");
	if((sKeyTag != "") && (GetLocalInt(OBJECT_SELF, "Activated") == 0)) {
		if(GetItemPossessedBy(oTraveller, sKeyTag) != OBJECT_INVALID) {
		SetLocalInt(OBJECT_SELF, "Activated", 1);
		 AssignCommand(oTraveller, ActionJumpToObject(oMyWaypoint));
		 DelayCommand(6.0, SetLocalInt(OBJECT_SELF, "Activated", 0));
		
		}
	}
	if((sKeyTag == "") || ((sKeyTag != "") && (GetLocalInt(OBJECT_SELF, "Activated")==1)))
		{AssignCommand(oTraveller, ActionJumpToObject(oMyWaypoint));
		 }
	
	}	
	

		
}