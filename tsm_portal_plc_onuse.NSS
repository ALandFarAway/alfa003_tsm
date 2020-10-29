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
	{
	object oTraveller = GetLastUsedBy();
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