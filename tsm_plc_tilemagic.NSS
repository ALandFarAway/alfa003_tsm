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
 
	 ACR_PlaceableOnUsed();
	object oUse = OBJECT_SELF;
	//while(oUse != OBJECT_INVALID) {
		int nGTCurrent = GetLocalInt(oUse, "GTCurrent");
		int nGTChange;
		if(nGTCurrent == 0) {nGTChange = 869;}
		else if(nGTCurrent == 869) {nGTChange = 984;}
		else if(nGTCurrent == 984) {nGTChange = 985;}
		else if(nGTCurrent == 985) {nGTChange = 1021;}
		else if(nGTCurrent == 1021) {nGTChange = 1022;}
		else if(nGTCurrent == 1022) {nGTChange = 1028;}
		else if(nGTCurrent == 1028) {nGTChange = 921;}
		else if(nGTCurrent == 921) {nGTChange = 625;}
		else if(nGTCurrent == 625) {nGTChange = 881;}
		
		else if(nGTCurrent == 881) {nGTChange = 0;}
		SetLocalInt(oUse, "GTCurrent", nGTChange);
		SendMessageToAllDMs("nGTCurrent = " + IntToString(nGTCurrent) + "; nGTChange = " + IntToString(nGTChange));
		
		effect eTM = GetFirstEffect(oUse);
		int nETM = GetEffectType(eTM);
		while (nETM != EFFECT_TYPE_INVALIDEFFECT) {
			RemoveEffect(oUse, eTM);
			eTM = GetNextEffect(oUse);
			nETM = GetEffectType(eTM);
			}
			
		
		ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(nGTChange), oUse);
		//oUse = GetNextObjectInShape(SHAPE_SPHERE, 5.0, GetSpellTargetLocation(), FALSE, OBJECT_TYPE_PLACEABLE);
	//}
	
	
}