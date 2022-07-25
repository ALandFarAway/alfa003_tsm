//
//  System Name : AOE
//     Filename : tsm_aoe_onenter
//      Version : 0.1
//         Date : 7/8/22
//       Author : Wynna
//
//  Description
//  This script handles on enter actions for an area of effect.
//  It is not updated in ACR updates.
//
//  Revision History
////////////////////////////////////////////////////////////////////////////////

//	Wynna - 7/8/2022

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
#include "acr_trigger_i"
#include "X0_I0_SPELLS"


void main()
{
    ACR_TriggerOnEnter();

	object oEnterer = GetEnteringObject();	
	SendMessageToPC(oEnterer, "Entered");		
		  
}