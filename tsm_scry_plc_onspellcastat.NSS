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
#include "acr_scry_i"

void main() {
 
	ACR_PlaceableOnSpellCastAt();

	 //3068 = Create Water Cantrip
	 //3066 = Arcane Mark Cantrip
	 //3071 = Summon Instrument Cantrip
	 
	 int nLastSpell = GetLastSpell();
	 object oCaster = GetLastSpellCaster();
	 int nCasterType = GetLastSpellCastClass();
	 object oTarget = OBJECT_SELF;
	 string sTag = GetTag(OBJECT_SELF);
	 string sResRef = GetResRef(OBJECT_SELF);
	 string sBless;
	 
	 SendMessageToPC(oCaster, "nCasterType = " + IntToString(nCasterType));
	 if((nLastSpell == 3068) && (sResRef == "abr_pl_so_holyfont") && (nCasterType == CLASS_TYPE_CLERIC)) {
	 	object oFocus = CreateItemOnObject("abr_it_scry_focus", oCaster, 1);
		SetFirstName(oFocus, "Scrying Droplet");
		SendMessageToPC(oCaster, "You call forth a droplet of water vapor, catching it in a vial as it rises from " + GetName(oTarget) + ".");
	    SetItemIcon(oFocus, 1896);
		}
	 
	 else if((nLastSpell == 3068) && (sResRef == "abr_pl_so_pool") && (nCasterType == CLASS_TYPE_DRUID)) {
	 	object oFocus = CreateItemOnObject("abr_it_scry_focus", oCaster, 1);
		SetFirstName(oFocus, "Scrying Droplet");
		SendMessageToPC(oCaster, "You call forth a droplet of water vapor, catching it in a vial as it rises from " + GetName(oTarget) + ".");
	    SetItemIcon(oFocus, 1896);
		}
	 
	 else if((nLastSpell == 3066)  && ((sResRef == "abr_pl_so_mirror") || (sResRef == "tsm_plc_scry_mirror"))) {
	    object oFocus = CreateItemOnObject("abr_it_scry_focus", oCaster, 1);
		SetFirstName(oFocus, "Scrying Shard");
		SendMessageToPC(oCaster, "A shard shimmers into your hand, out of the " + GetName(oTarget) + " on which you draw your mark, leaving the glass unblemished.");
	 }
	 
	 else if((nLastSpell == 3071)  && ((sResRef == "abr_pl_so_mirror") || (sResRef == "tsm_plc_scry_mirror"))) {
	    object oFocus = CreateItemOnObject("abr_it_scry_focus", oCaster, 1);
		SetFirstName(oFocus, "Scrying Shard");
		SendMessageToPC(oCaster, "A shard shaped like your instrument of choice shimmers into your hand, out of the " + GetName(oTarget) + ", leaving the glass unblemished.");
	 }	
}