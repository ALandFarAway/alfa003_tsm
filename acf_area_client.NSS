//
//  System Name : ACR Configuration File
//     Filename : acf_area_client.nss
//      Version : 0.1
//         Date : 7/25/06
//       Author : Ronan
//
//  Local Variable Prefix =
//
//
//  Dependencies external of nwscript:
//
//  Description
//  This script calls the ACR's OnAreaOnClientEnter code, and any custom code a
//  server may need. It is not updated in ACR updates.
//
//  Revision History
////////////////////////////////////////////////////////////////////////////////

//	Wynna - 7/8/2022 : Added check to get sensor scrying on N/PC and make it jump to them

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////

#include "acr_area_i"

////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Constants ///////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Structures //////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Global Variables ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Function Prototypes /////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

// The main event handler.
void main();

////////////////////////////////////////////////////////////////////////////////
// Function Definitions ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

void main() {
    ACR_AreaOnClientEnter();

    object oEnterer = GetEnteringObject();
	
	//Is Scrying active on this PC
	object oScrySend = GetLocalObject(oEnterer, "oScrySend");
	object oScryer =  GetLocalObject(oEnterer, "oScryer");
	object oATTarget = GetLocalObject(oEnterer, "oATTarget");
	if(oATTarget == OBJECT_INVALID) {
	string sATTarget = GetLocalString(oEnterer, "sATTarget");
		 oATTarget = GetWaypointByTag(sATTarget);
		}
	location lATTarget = GetLocation(oATTarget);	
	SendMessageToPC(oEnterer, "client oScryer = " + GetName(oScryer)); 
	SendMessageToPC(oEnterer, "client oATTarget = " + GetTag(oATTarget)); 
	SendMessageToPC(oEnterer, "client oScrySend = " + GetTag(oScrySend)); 
	SendMessageToPC(oEnterer, "client GetArea oScrySend = " + GetTag(GetArea(oScrySend))); 
		
	if(oScrySend != OBJECT_INVALID) {
	    SendMessageToPC(oEnterer, "client oSend should be jumping to " + GetName(oEnterer) + " at " + GetTag(oATTarget) + " now."); 
		AssignCommand(oScrySend, ClearAllActions(TRUE));
		/*DelayCommand(1.0 , AssignCommand(oScrySend, ActionJumpToLocation(lATTarget)));
		DelayCommand(9.0, SendMessageToPC(oEnterer, "client GetArea oScrySend = " + GetTag(GetArea(oScrySend)))); 
		DelayCommand(10.0 , AssignCommand(oScrySend, ActionJumpToObject(oATTarget, FALSE)));
		DelayCommand(19.0, SendMessageToPC(oEnterer, "client GetArea oScrySend = " + GetTag(GetArea(oScrySend)))); 
		DelayCommand(20.0 , AssignCommand(oScrySend, ActionJumpToObject(oATTarget, TRUE)));
		DelayCommand(29.0, SendMessageToPC(oEnterer, "client GetArea oScrySend = " + GetTag(GetArea(oScrySend)))); 
		DelayCommand(30.0 , AssignCommand(oScrySend, ActionJumpToLocation(GetLocation(oEnterer))));
		DelayCommand(39.0, SendMessageToPC(oEnterer, "client GetArea oScrySend = " + GetTag(GetArea(oScrySend)))); 
		DelayCommand(40.0 , AssignCommand(oScrySend, ActionJumpToObject(oEnterer, FALSE)));
		DelayCommand(49.0, SendMessageToPC(oEnterer, "client GetArea oScrySend = " + GetTag(GetArea(oScrySend)))); 
		*/
		DelayCommand(1.0 , AssignCommand(oScrySend, ActionJumpToObject(oEnterer, TRUE)));
		DelayCommand(3.0, SetLocalObject(oEnterer, "oATTarget", OBJECT_INVALID));
		DelayCommand(3.0, SetLocalString(oEnterer, "sATTarget", ""));
		DelayCommand(10.0, AssignCommand(oScrySend, ActionForceFollowObject(oEnterer, 0.5f, 0)));
		}
}