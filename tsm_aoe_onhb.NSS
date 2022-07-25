//
//  System Name : AOE
//     Filename : tsm_aoe_onexit
//      Version : 0.1
//         Date : 7/8/22
//       Author : Wynna
//
//  Description
//  This script handles on heartbeat actions for an area of effect.
//  It is not updated in ACR updates.
//
//  Revision History
////////////////////////////////////////////////////////////////////////////////

//	Wynna - 7/8/2022

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
#include "acr_trigger_i"


void main()
{
    ACR_TriggerOnHeartbeat();

	object oResident = GetFirstInPersistentObject(OBJECT_SELF, OBJECT_TYPE_CREATURE, PERSISTENT_ZONE_ACTIVE); 
	SendMessageToPC(oResident, "Resident");		
	
	
}