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

void main() {
 
	object oUse = GetFirstObjectInShape(SHAPE_SPHERE, 5.0, GetSpellTargetLocation(), FALSE, OBJECT_TYPE_PLACEABLE);
	while(oUse != OBJECT_INVALID) {
		int nUseableFlag = GetUseableFlag(oUse);
		if(nUseableFlag == 0) {SetUseableFlag(oUse, 1);}
		else if(nUseableFlag == 1) {SetUseableFlag(oUse, 0);}
		oUse = GetNextObjectInShape(SHAPE_SPHERE, 5.0, GetSpellTargetLocation(), FALSE, OBJECT_TYPE_PLACEABLE);
	}

	
}