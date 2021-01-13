////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ACR Configuration File
//     Filename : acf_plc_onused.nss
//    $Revision:: 183        $ current version of the file
//        $Date:: 2006-12-21#$ date the file was created or modified
//       Author : Ronan
//
//  Local Variable Prefix =
//
//  Dependencies external of nwscript:
//
//  Description
//  This script calls the ACR's OnUsed code for placeables, and any
//  custom code a server may need. It is not updated in ACR updates.
//
//  Revision History
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

#include "acr_placeable_i"
#include "dmfi_inc_langexe" 
#include "acr_quest_i"

void main() {
 

	//
	// GetLastUsedBy must not be called if OBJECT_SELF has been deleted.  If we
	// are called by a DelayCommand / ExecuteScript continuation then it is
	// possible that the object has been deleted in the mean time.
	//
	// The test for OBJECT_SELF being invalid has to be done before calling the
	// ACR hook.
	//

	if (!GetIsObjectValid(OBJECT_SELF))
		return;

	ACR_PlaceableOnUsed();


	if(FindSubString(GetTag(OBJECT_SELF), "_portal") != -1)
	{object oTraveller = GetLastUsedBy();
    
	SendMessageToPC(oTraveller, "Portal Used");
		 
	string sKeyTag = GetLocalString(OBJECT_SELF, "PORTAL_KEY");
	string sKeyTagTwo = GetLocalString(OBJECT_SELF, "PORTAL_KEY_2");
	string sKeyTagThree = GetLocalString(OBJECT_SELF, "PORTAL_KEY_3");
	string sKeyTagFour = GetLocalString(OBJECT_SELF, "PORTAL_KEY_4");
	string sKeyTagFive = GetLocalString(OBJECT_SELF, "PORTAL_KEY_5");
	string sKeyTagSix = GetLocalString(OBJECT_SELF, "PORTAL_KEY_6");
	string sMyTarget = GetLocalString(OBJECT_SELF, "PORTAL_TARGET_WP");
	string sMyTargetTwo = GetLocalString(OBJECT_SELF, "PORTAL_TARGET_WP2");
	string sMyTargetThree = GetLocalString(OBJECT_SELF, "PORTAL_TARGET_WP3");
	string sMyTargetFour = GetLocalString(OBJECT_SELF, "PORTAL_TARGET_WP4");
	string sMyTargetFive = GetLocalString(OBJECT_SELF, "PORTAL_TARGET_WP5");
	string sMyTargetSix = GetLocalString(OBJECT_SELF, "PORTAL_TARGET_WP6");
	object oMyWaypoint;
//	SendMessageToPC(oTraveller, "1. oMyWaypoint = " + GetName(oMyWaypoint));
//	oMyWaypoint = GetObjectByTag(sMyTarget, 0);	 
	//SendMessageToPC(oTraveller, "2. oMyWaypoint = " + GetName(oMyWaypoint));
	
	if((sKeyTag != "") && (GetLocalInt(OBJECT_SELF, "Activated") == 0)) {
		if((((((GetItemPossessedBy(oTraveller, sKeyTag) != OBJECT_INVALID) || (GetItemPossessedBy(oTraveller, sKeyTagTwo) != OBJECT_INVALID) || (GetItemPossessedBy(oTraveller, sKeyTagThree) != OBJECT_INVALID) || (GetItemPossessedBy(oTraveller, sKeyTagFour) != OBJECT_INVALID) || (GetItemPossessedBy(oTraveller, sKeyTagFive) != OBJECT_INVALID) || (GetItemPossessedBy(oTraveller, sKeyTagSix) != OBJECT_INVALID)))))) {
		 SendMessageToPC(oTraveller, "Activated");
		 SetLocalInt(OBJECT_SELF, "Activated", 1);
		 
		 if(GetItemPossessedBy(oTraveller, sKeyTag) != OBJECT_INVALID)
		 	{SendMessageToPC(oTraveller, "1 " + sKeyTag + "..." + sMyTarget);
		      oMyWaypoint = GetWaypointByTag(sMyTarget);}
		 else if(GetItemPossessedBy(oTraveller, sKeyTagTwo) != OBJECT_INVALID)
		 	{SendMessageToPC(oTraveller, "2 " + sKeyTagTwo + "..." + sMyTargetTwo);
		      oMyWaypoint = GetWaypointByTag(sMyTargetTwo);
			  SendMessageToPC(oTraveller, "2b. oMyWaypoint = " + GetName(oMyWaypoint));
	
			  }
		 else if(GetItemPossessedBy(oTraveller, sKeyTagThree) != OBJECT_INVALID)
		 	{SendMessageToPC(oTraveller, "3 " + sKeyTagThree + "..." + sMyTargetThree);
		      oMyWaypoint = GetWaypointByTag(sMyTargetThree);}
		 else if(GetItemPossessedBy(oTraveller, sKeyTagFour) != OBJECT_INVALID)
		 	{SendMessageToPC(oTraveller, "4 " + sKeyTagFour + "..." + sMyTargetFour);
		      oMyWaypoint = GetWaypointByTag(sMyTargetFour);}
		 else if(GetItemPossessedBy(oTraveller, sKeyTagFive) != OBJECT_INVALID)
		 	{SendMessageToPC(oTraveller, "5 " + sKeyTagFive + "..." + sMyTargetFive);
		      oMyWaypoint = GetWaypointByTag(sMyTargetFive);}
		 else if(GetItemPossessedBy(oTraveller, sKeyTagSix) != OBJECT_INVALID)
		 	{SendMessageToPC(oTraveller, "6 " + sKeyTagSix + "..." + sMyTargetSix);
		      oMyWaypoint = GetWaypointByTag(sMyTargetSix);}
		
		 SendMessageToPC(oTraveller, "Waypoint = " + GetName(oMyWaypoint));
		 SetLocalObject(OBJECT_SELF, "sCurrent_WP", oMyWaypoint);
		 object oFinalWaypoint = GetLocalObject(OBJECT_SELF, "sCurrent_WP");
		 SendMessageToPC(oTraveller, "FinalWaypoint = " + GetName(oFinalWaypoint));
		 AssignCommand(oTraveller, ActionJumpToObject(oFinalWaypoint));
		 DelayCommand(60.0, SetLocalInt(OBJECT_SELF, "Activated", 0));
		
		}
	}
	
	if(GetLocalInt(OBJECT_SELF, "Activated")==1)
		{oMyWaypoint = GetLocalObject(OBJECT_SELF, "sCurrent_WP");
		 AssignCommand(oTraveller, ActionJumpToObject(oMyWaypoint));
		 }
	

	}	
	
		
}