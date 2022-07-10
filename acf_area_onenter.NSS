////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ACR Configuration File
//     Filename : acf_area_onenter.nss
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
//  This script calls the ACR's OnAreaEnter code, and any custom code a server
//  may need. It is not updated in ACR updates.
//
//  Revision History
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

#include "acr_area_i"

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

//! The main event handler.
void main();

////////////////////////////////////////////////////////////////////////////////
// Function Definitions ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

#include "acr_db_persist_i"

void main() {
    ACR_AreaOnEnter();

    // Custom code goes below this line.
	string sTag = GetTag(OBJECT_SELF);
	object oEnterer = GetEnteringObject();
	
	//Scrying is active on this PC
	object oScrySend = GetLocalObject(oEnterer, "oScrySend");
	object oScryer =  GetLocalObject(oEnterer, "oScryer");
	object oATTarget = GetLocalObject(oEnterer, "oATTarget");
	if(oATTarget == OBJECT_INVALID) {
	string sATTarget = GetLocalString(oEnterer, "sATTarget");
		 oATTarget = GetWaypointByTag(sATTarget);
		}
		
	SendMessageToPC(oEnterer, "onenter oScryer = " + GetName(oScryer)); 
	SendMessageToPC(oEnterer, "onenter oScrySend = " + GetTag(oScrySend)); 
	SendMessageToPC(oEnterer, "onenter oATTarget = " + GetTag(oATTarget)); 
	
	if(oScrySend != OBJECT_INVALID) {
	    SendMessageToPC(oScryer, "onenter oSend should be jumping to " + GetName(oEnterer) + " at " + GetTag(oATTarget) + " now."); 
		AssignCommand(oScrySend, ActionJumpToLocation(GetLocation(oATTarget)));
		DelayCommand(10.0, AssignCommand(oScrySend, ActionForceFollowObject(oEnterer, 0.5f, 0)));
		SetLocalObject(oEnterer, "oATTarget", OBJECT_INVALID);
		SetLocalString(oEnterer, "sATTarget", "");
		}

	
	//Exploration xp
	if(FindSubString(sTag, "ext", 0) != -1) {
	int nXP = 25;
	if((FindSubString(sTag, "6c_", 0) != -1) || (FindSubString(sTag, "6d_", 0) != -1)) {
		nXP = 10;
		}
	if((FindSubString(sTag, "6b_", 0) != -1) && (FindSubString(sTag, "evermoor", 0) == -1)) {
		nXP = 10;
		}
	if((FindSubString(sTag, "7d_", 0) != -1) && (FindSubString(sTag, "silverwood1", 0) != -1)) {
		nXP = 10;
		}
	if(ACR_GetPersistentInt(GetEnteringObject(), GetTag(OBJECT_SELF) + " XP") == 0) {
		ACR_SetPersistentInt(GetEnteringObject(), GetTag(OBJECT_SELF) + " XP", nXP);
		GiveXPToCreature(GetEnteringObject(), nXP);
		SendMessageToPC(GetEnteringObject(), "Congratulations on exploring a new area!");
		}
	}
	
	
}