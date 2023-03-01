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
		if(nGTCurrent <= 346) {nGTChange = 346;}
		else if((nGTCurrent >= 346) && (nGTCurrent <= 350)) {nGTChange = nGTCurrent +1;}
		else if(nGTCurrent == 350) {nGTChange = 401;}
		else if(nGTCurrent == 401) {nGTChange = 402;}
		else if(nGTCurrent == 402) {nGTChange = 406;}
		else if(nGTCurrent == 406) {nGTChange = 426;}
		else if((nGTCurrent >= 426) && (nGTCurrent <= 460)) {nGTChange = nGTCurrent +1;}
		else if(nGTCurrent == 461) {nGTChange = 346;}
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