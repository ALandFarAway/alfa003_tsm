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
#include "dmfi_inc_langexe" 
#include "acr_quest_i"

void ActionCreateWynPlacedEffect(string sPlacedEffect, location lLocPlaceEffect)
{
    CreateObject(OBJECT_TYPE_PLACED_EFFECT, sPlacedEffect, lLocPlaceEffect);
}

void main() {
 

	//
	// GetLastUsedBy must not be called if OBJECT_SELF has been deleted.  If we
	// are called by a DelayCommand / ExecuteScript continuation then it is
	// possible that the object has been deleted in the mean time.
	//
	// The test for OBJECT_SELF being invalid has to be done before calling the
	// ACR hook.
	//

	if (!GetIsObjectValid(OBJECT_SELF))
		return;

	ACR_PlaceableOnSpellCastAt();

	 //3141 = Silent Image
	 //3149 = Bless Water
	 //3068 = Create Water
	 
	 int nLastSpell = GetLastSpell();
	 object oCaster = GetLastSpellCaster();
	 object oTarget = OBJECT_SELF;
	 string sTag = GetTag(OBJECT_SELF);
	 string sResRef = GetResRef(OBJECT_SELF);
	 string sBless;
	 
	 if(((nLastSpell == 3149) || (nLastSpell == 3068)) && ((sResRef == "abr_pl_so_holyfont") || (sResRef == "abr_pl_so_pool"))) {
	 	if(nLastSpell == 3149)
			{sBless = "blessed";}
	    if(nLastSpell == 3068)
			{sBless = "freshly called forth";}
	    CreateItemOnObject("abr_it_scry_vial", oCaster, 1);
		SendMessageToPC(oCaster, "You catch a droplet of " + sBless + " water from " + GetName(oTarget) + " in a small vial.");
	 
	 }
	 
	 else if((nLastSpell == 3141) && ((sResRef == "abr_pl_so_mirror") || (sResRef == "tsm_plc_scry_mirror"))) {
	    CreateItemOnObject("abr_it_scry_shard", oCaster, 1);
		SendMessageToPC(oCaster, "A shard shimmers out of the " + GetName(oTarget) +", leaving the glass unblemished.");
	 
	 }
	 
	 
	
}