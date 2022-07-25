//
//  System Name : AOE
//     Filename : tsm_aoe_onexit
//      Version : 0.1
//         Date : 7/8/22
//       Author : Wynna
//
//  Description
//  This script handles on exit actions for the area of effect Mage's Private Sanctum.
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
    ACR_TriggerOnExit();
		
	object oExiter = GetExitingObject();	
	SendMessageToPC(oExiter, "Exited");		
	
}