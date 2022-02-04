////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ACR Configuration File
//     Filename : acf_plc_ondeath.nss
//    $Revision:: 188        $ current version of the file
//        $Date:: 2006-12-21#$ date the file was created or modified
//       Author : Ronan
//
//  Local Variable Prefix =
//
//  Dependencies external of nwscript:
//
//  Description
//  This script calls the ACR's OnDeath code for placeables, and any
//  custom code a server may need. It is not updated in ACR updates.
//
//  Revision History
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

#include "acr_placeable_i"

////////////////////////////////////////////////////////////////////////////////
// Constants ///////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Structures //////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Global Variables ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Function Prototypes /////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

// The main event handler.
void main();

////////////////////////////////////////////////////////////////////////////////
// Function Definitions ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

void main() {
    ACR_PlaceableOnDeath();

    // Custom code goes here.
	
	SendMessageToAllDMs("onDeath for " + GetName(OBJECT_SELF) + " firing");

if(GetLocalInt(OBJECT_SELF, "Proxy") == 1) {
    object oMyTrigger = GetLocalObject(OBJECT_SELF, "Undead_Proxy_Trg");
    object oMyCreature = GetLocalObject(OBJECT_SELF, "Undead_Proxy_Cre");
    //SendMessageToAllDMs("onDeath Plc Proxy variable = 1. oMyTrigger = " + GetName(oMyTrigger) + ". oMyCreature = " + GetName(oMyCreature));
	if(GetLocalInt(oMyCreature, "Proxy") != 2) {
		SendMessageToAllDMs("oMyCreature Proxy != 2");
		int nAppearance = GetLocalInt(OBJECT_SELF, "Appearance");     
	    effect eRise = EffectVisualEffect(VFX_DUR_SPELL_AWAKEN, FALSE);
		//effect eEmerge = EffectVisualEffect(VFX_CAST_SPELL_SPIRIT_EMERGE, FALSE);
		//effect eParalyze = EffectParalyze(-1,SAVING_THROW_WILL,FALSE);
		if(oMyCreature != OBJECT_INVALID) {
		    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRise, oMyCreature, 5.0);
			ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEmerge, oMyCreature, 5.0);
			effect eLocation = EffectVisualEffect(VFX_AOE_ETHEREAL_PURGE, FALSE);
		    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eLocation, GetLocation(OBJECT_SELF), 5.0);
		    DelayCommand(1.0, SetCreatureAppearanceType(oMyCreature,nAppearance));
		   	effect eEffect = GetFirstEffect(oMyCreature);
				while(GetIsEffectValid(eEffect)) {
					//SendMessageToAllDMs(GetName(oMyCreature) + " " + IntToString(GetEffectInteger(eEffect,1)) + ", "  + IntToString(GetEffectInteger(eEffect,2 )) + ", "  + IntToString(GetEffectInteger(eEffect,3 )) + ", "  + IntToString(GetEffectInteger(eEffect,4 )) + ", "  + IntToString(GetEffectInteger(eEffect,5 )) + ", "  + IntToString(GetEffectInteger(eEffect,6 )) + ", "  + IntToString(GetEffectInteger(eEffect,7 )));
					RemoveEffect(oMyCreature, eEffect);
					eEffect = GetNextEffect(oMyCreature);
					}
			   	} 
		}
	}
}