////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ACR Configuration File
//     Filename : acf_cre_ondeath
//    $Revision:: 280        $ current version of the file
//        $Date:: 2007-03-20#$ date the file was created or modified
//       Author : Cipher
//
//    Var Prefix:
//  Dependencies:
//
//  Description
//  This script calls the ACR's OnDeath event handler for creatures and
//  any custom code a server may need. It is not updated in ACR updates.
//
//  Revision History
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#include "acr_creature_i"
#include "acr_db_persist_i"
#include "acr_scry_i"

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

////////////////////////////////////////////////////////////////////////////////
// Function Definitions ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

void main()
{
    ACR_CreatureOnDeath();

    // Custom code goes here.
	
	
	if((GetTag(OBJECT_SELF)== "003_cr_scry_send") || (GetTag(OBJECT_SELF)== "003_cr_scry_send_xavier")) {
		object oScryer = GetLocalObject(OBJECT_SELF, "oScryer");
		object oScry = GetLocalObject(OBJECT_SELF, "oScry");
		object oScryListen = GetLocalObject(OBJECT_SELF, "oScryListen");
		object oScried = GetLocalObject(OBJECT_SELF, "oScried");
		SendMessageToPC(oScryer, "You see " + GetName(GetLastKiller()) + " strike down your scrying sensor and the scrying ends.");
		SendMessageToAllDMs(GetName(GetLastKiller()) + " strikes down " + GetName(oScryer) + "'s scrying sensor and the scrying ends.");
		//ACR_ScryEnd(oScryer);
		
		//Unset all local variables and destroy oScryListener, too
		SetLocalInt(oScry, "nScryActive", 0);
		
		//SendMessageToPC(oScryer, "nScryActive is now " + IntToString(GetLocalInt(oScry, "nScryActive")));
		//SendMessageToAllDMs("nScryActive is now " + IntToString(GetLocalInt(oScry, "nScryActive")));
		
		SetLocalObject(oScry, "oScried", OBJECT_INVALID);
		SetLocalObject(oScry, "oScryListen", OBJECT_INVALID);
		SetLocalObject(oScry, "oScryer", OBJECT_INVALID);
		SetLocalObject(oScry, "oScrySend", OBJECT_INVALID);
		SetLocalObject(oScryer, "oScried", OBJECT_INVALID);
		SetLocalObject(oScryer, "oScryListen", OBJECT_INVALID);
		SetLocalObject(oScryer, "oScrySend", OBJECT_INVALID);
		SetLocalObject(oScryer, "oScry", OBJECT_INVALID);
		SetLocalObject(oScried, "oScryListen", OBJECT_INVALID);
		SetLocalObject(oScried, "oScryer", OBJECT_INVALID);
		SetLocalObject(oScried, "oScry", OBJECT_INVALID);
		SetLocalObject(oScried, "oScrySend", OBJECT_INVALID);
		SetLocalInt(oScry, "nScryActive", 0);
		DestroyObject(oScryListen, 2.0);		
	}
		
}