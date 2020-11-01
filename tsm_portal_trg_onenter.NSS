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
    string sKeyTag = GetLocalString(OBJECT_SELF, "PORTAL_KEY");
	string sKeyTagTwo = GetLocalString(OBJECT_SELF, "PORTAL_KEY_2");
	string sKeyTagThree = GetLocalString(OBJECT_SELF, "PORTAL_KEY_3");
	string sKeyTagFour = GetLocalString(OBJECT_SELF, "PORTAL_KEY_4");
	string sKeyTagFive = GetLocalString(OBJECT_SELF, "PORTAL_KEY_5");
	string sKeyTagSix = GetLocalString(OBJECT_SELF, "PORTAL_KEY_6");
	string sMyTarget = GetLocalString(OBJECT_SELF, "PORTAL_TARGET");
	string sMyTargetTwo = GetLocalString(OBJECT_SELF, "PORTAL_TARGET_2");
	string sMyTargetThree = GetLocalString(OBJECT_SELF, "PORTAL_TARGET_3");
	string sMyTargetFour = GetLocalString(OBJECT_SELF, "PORTAL_TARGET_4");
	string sMyTargetFive = GetLocalString(OBJECT_SELF, "PORTAL_TARGET_5");
	string sMyTargetSix = GetLocalString(OBJECT_SELF, "PORTAL_TARGET_6");
	object oMyWaypoint = GetWaypointByTag(sMyTarget);
	
	
	if((sKeyTag != "") && (GetLocalInt(OBJECT_SELF, "Activated") == 0)) {
		if((((((GetItemPossessedBy(oTraveller, sKeyTag) != OBJECT_INVALID) || (GetItemPossessedBy(oTraveller, sKeyTagTwo) != OBJECT_INVALID) || (GetItemPossessedBy(oTraveller, sKeyTagThree) != OBJECT_INVALID) || (GetItemPossessedBy(oTraveller, sKeyTagFour) != OBJECT_INVALID) || (GetItemPossessedBy(oTraveller, sKeyTagFive) != OBJECT_INVALID) || (GetItemPossessedBy(oTraveller, sKeyTagSix) != OBJECT_INVALID)))))) {
		 SetLocalInt(OBJECT_SELF, "Activated", 1);
		 if(GetItemPossessedBy(oTraveller, sKeyTag) != OBJECT_INVALID)
		 	{oMyWaypoint = GetWaypointByTag(sMyTarget);}
		 else if(GetItemPossessedBy(oTraveller, sKeyTagTwo) != OBJECT_INVALID)
		 	{oMyWaypoint = GetWaypointByTag(sMyTargetTwo);}
		 else if(GetItemPossessedBy(oTraveller, sKeyTagThree) != OBJECT_INVALID)
		 	{oMyWaypoint = GetWaypointByTag(sMyTargetThree);}
		 else if(GetItemPossessedBy(oTraveller, sKeyTagFour) != OBJECT_INVALID)
		 	{oMyWaypoint = GetWaypointByTag(sMyTargetFour);}
		 else if(GetItemPossessedBy(oTraveller, sKeyTagFive) != OBJECT_INVALID)
		 	{oMyWaypoint = GetWaypointByTag(sMyTargetFive);}
		 else if(GetItemPossessedBy(oTraveller, sKeyTagSix) != OBJECT_INVALID)
		 	{oMyWaypoint = GetWaypointByTag(sMyTargetSix);}
		
		 SetLocalObject(OBJECT_SELF, "sCurrent_WP", oMyWaypoint);
		 AssignCommand(oTraveller, ActionJumpToObject(oMyWaypoint));
		 DelayCommand(6.0, SetLocalInt(OBJECT_SELF, "Activated", 0));
		
		}
	}
	if((sKeyTag != "") && (GetLocalInt(OBJECT_SELF, "Activated")==1))
		{oMyWaypoint = GetLocalObject(OBJECT_SELF, "sCurrent_WP");
		 AssignCommand(oTraveller, ActionJumpToObject(oMyWaypoint));
		 }
	
	if(sKeyTag == "")
		{AssignCommand(oTraveller, ActionJumpToObject(oMyWaypoint));
		 }
	}	
	

		
}