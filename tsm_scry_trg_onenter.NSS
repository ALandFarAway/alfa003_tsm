////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ACR Configuration File
//     Filename : acf_trg_onenter.nss
//    $Revision:: 236        $ current version of the file
//        $Date:: 2007-01-21#$ date the file was created or modified
//       Author : Cipher
//
//    Var Prefix:
//  Dependencies:
//
//  Description
//  This script calls the ACR's OnEnter code for triggers, and any
//  custom code a server may need. It is not updated in ACR updates.
//
//  Revision History
//  2007/01/20  Cipher  Inception
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#include "acr_trigger_i"
#include "acr_scry_i"

void main() {
	ACR_TriggerOnEnter();

	  object oScryer = GetEnteringObject();
	  
	  CreateItemOnObject("abr_it_scry_droplet", oScryer, 1);
	  SendMessageToPC(oScryer, "You call forth a droplet of water vapor, catching it in a vial as it rises from " + GetName(OBJECT_SELF) + ".");
}		   