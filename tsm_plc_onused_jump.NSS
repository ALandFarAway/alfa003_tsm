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
 


	if (!GetIsObjectValid(OBJECT_SELF))
		return;

	ACR_PlaceableOnUsed();
	object oUser = GetLastUsedBy();
	string sDest = GetLocalString(OBJECT_SELF, "WP_Destination_Tag");
	object oDest = GetWaypointByTag(sDest);
	AssignCommand(oUser, ActionJumpToLocation(GetLocation(oDest)));
	


		
	  
	
}