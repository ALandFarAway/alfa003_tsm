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

	  if(GetSpellId() == 3056) {
			object oScryer = GetLastSpellCaster();
			object oScried; 
			string sScryName = GetName(OBJECT_SELF);
			string sSpeak = GetLocalString(OBJECT_SELF, "SCRY_SPEAK");
			location lHere = GetLocation(OBJECT_SELF);
			int nScryerLevel = GetCasterLevel(oScryer);
			float fScryTimer;
			effect eDivination = EffectVisualEffect(VFX_BEAM_DIVINATION, FALSE);
	
			object oScry = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_scry_listen", lHere);
            SetLocalInt(OBJECT_SELF, "SCRY_ACTIVE", 1);
			SetLocalFloat(OBJECT_SELF, "SCRY_TIMER", 60.0 * nScryerLevel);
			ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eDivination, lHere, fScryTimer);
			ActionSpeakString(sSpeak, TALKVOLUME_TALK);
			DelayCommand(2.0, SendMessageToPC(oScryer, "You feel the " + sScryName + " is ready to receive a name to scry."));
			fScryTimer = GetLocalFloat(OBJECT_SELF, "SCRY_TIMER");	
			DelayCommand(fScryTimer, SendMessageToPC(oScryer, "The scry spell ends and the scrying object goes dark."));		
			DestroyObject(oScry, fScryTimer+1.0);
			DelayCommand(fScryTimer+2.0, SetLocalInt(OBJECT_SELF, "SCRY_ACTIVE", 0));
		}	
	
}