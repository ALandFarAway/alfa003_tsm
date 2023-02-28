//
//  System Name : Scrying
//     Filename : tsm_scry_plc_onspellcastat
//      Version : 0.1
//         Date : 7/8/22
//       Author : Wynna
//
//  Description
//  This script handles on spellcastat actions of placeables used in the scrying system. 
//  This should be in the On Spell Cast At Script slot of placeables in the _ALFA_Scrying Category: 
//  It provides a scrying focus out of the scrying object to the scryer.
//	Mirror - Arcane Mark or Summon Instrument generate a scrying shard in the caster's inventory.
//	Holy Water Font - Create Water generates a scrying droplet in a cleric's inventory.
//	Natural Pool of Water - Create Water generates a scrying droplet in a druid's inventory.
//	It is not updated in ACR updates.
//
//  Revision History
////////////////////////////////////////////////////////////////////////////////

//	Wynna - 7/8/2022

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////

#include "acr_placeable_i"
#include "acr_scry_i"

void main() {
 
	ACR_PlaceableOnSpellCastAt();

	 //3068 = Create Water Cantrip
	 //3066 = Arcane Mark Cantrip
	 //3071 = Summon Instrument Cantrip
	 
	 int nLastSpell = GetLastSpell();
	 object oCaster = GetLastSpellCaster();
	 object oTarget = OBJECT_SELF;
	 int nCasterType = GetLocalInt(oCaster, "nSpellCasterType");
	 string sTag = GetTag(OBJECT_SELF);
	 string sResRef = GetResRef(OBJECT_SELF);
	 
	 SendMessageToAllDMs("plc oncastat: nSpellCasterType = " + IntToString(nCasterType));
	 SendMessageToAllDMs("plc oncastat: nLastSpell = " + IntToString(nLastSpell));
	 SendMessageToPC(oCaster, "plc oncastat: nSpellCasterType = " + IntToString(nCasterType));
	 SendMessageToPC(oCaster, "plc oncastat: nLastSpell = " + IntToString(nLastSpell));
	 if((nLastSpell == 3068) && (sResRef == "abr_pl_so_holyfont") && ((nCasterType == CLASS_TYPE_CLERIC) || (nCasterType == CLASS_TYPE_INVALID))) {
	 	object oFocus = CreateItemOnObject("abr_it_scry_focus", oCaster, 1);
		SetFirstName(oFocus, "Scrying Droplet");
		SendMessageToPC(oCaster, "You call forth a droplet of water vapor, catching it in a vial as it rises from the " + GetName(oTarget) + ".");
	    SetItemIcon(oFocus, 1896);
		}
	 
	 else if((nLastSpell == 3068) && (sResRef == "abr_pl_so_pool") && ((nCasterType == CLASS_TYPE_DRUID) || (nCasterType == CLASS_TYPE_INVALID))) {
	 	object oFocus = CreateItemOnObject("abr_it_scry_focus", oCaster, 1);
		SetFirstName(oFocus, "Scrying Droplet");
		SendMessageToPC(oCaster, "You call forth a droplet of water vapor, catching it in a vial as it rises from the " + GetName(oTarget) + ".");
	    SetItemIcon(oFocus, 1896);
		}
	 
	 else if((nLastSpell == 3066)  && (sResRef == "abr_pl_so_mirror")) {
	    object oFocus = CreateItemOnObject("abr_it_scry_focus", oCaster, 1);
		SetFirstName(oFocus, "Scrying Shard");
		SendMessageToPC(oCaster, "A shard shimmers into your hand out of the " + GetName(oTarget) + " on which you draw your mark, leaving the glass unblemished.");
	 	}
	 
	 else if((nLastSpell == 3071) && (sResRef == "abr_pl_so_mirror")) {
	    object oFocus = CreateItemOnObject("abr_it_scry_focus", oCaster, 1);
		SetFirstName(oFocus, "Scrying Shard");
		SendMessageToPC(oCaster, "A shard shaped like your instrument of choice shimmers into your hand out of the " + GetName(oTarget) + ", leaving the glass unblemished.");
	 	}	
}