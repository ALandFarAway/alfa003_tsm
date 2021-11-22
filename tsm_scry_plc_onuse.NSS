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


	if(FindSubString(GetTag(OBJECT_SELF), "_scry") != -1)
	{object oScryer = GetLastUsedBy();
	 string sSpeak = GetLocalString(OBJECT_SELF, "SCRY_SPEAK");
	 	   if(GetLocalInt(OBJECT_SELF, "SCRY_ACTIVE") == 0) {
			SendMessageToPC(oScryer, "The scrying object requires a spell");
		}
		if(GetLocalInt(OBJECT_SELF, "SCRY_ACTIVE") == 1) {
			SendMessageToPC(oScryer, sSpeak);
		}	
	}
		
}