//
//     Filename : tsm_cr_scarab_onspawn
//      Version : 0.1
//         Date : 7/18/22
//       Author : Wynna
//
//  Description
//  This script creates an onspawn fire aura for an ephreet lord.
//	It is not updated in ACR updates.
//
//  Revision History
////////////////////////////////////////////////////////////////////////////////

//	Wynna - 7/8/2022

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////

#include "acr_spawn_i"


void main() {

	object oJhessi = GetObjectByTag("003_pc_jhessi_2", 0);
	object oPC = GetFirstPC(TRUE);
	while(oPC != OBJECT_INVALID) {
		string sPCName = GetName(oPC);
		if(FindSubString(sPCName, "Jhessi") != -1) {
			oJhessi = oPC;
			}
		
	oPC = GetNextPC(TRUE);
	}
 
	ClearAllActions(TRUE);
	ActionForceFollowObject(oJhessi, 0.5);
	ExecuteScript("acf_cre_onspawnin_buffed", OBJECT_SELF);
	
	 
		
	 
}