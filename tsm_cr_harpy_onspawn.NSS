//
//     Filename : tsm_cr_harpy_onspawn
//      Version : 0.1
//         Date : 7/18/22
//       Author : Wynna
//
//  Description
//  This script creates an onspawn script for a harpy to destroy the portal it rode in on.
//	It is not updated in ACR updates.
//
//  Revision History
////////////////////////////////////////////////////////////////////////////////

//	Wynna - 7/8/2022

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////

#include "acr_spawn_i"


void main() {

	ExecuteScript("acf_cre_onspawnin", OBJECT_SELF);
	
	
	ClearAllActions(TRUE);
	DestroyObject(GetObjectByTag("fx_portal_gen_small", 0), 5.0);
	DestroyObject(GetObjectByTag("fx_demon_portal", 0), 1.0);
	
	
	
}