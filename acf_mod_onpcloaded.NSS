////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ALFA Configuration File
//     Filename : acf_mod_onpcloaded.nss
//    $Revision:: 198        $ current version of the file
//        $Date:: 2006-12-23#$ date the file was created or modified
//       Author : Cipher
//
//  Local Variable Prefix = None
//
//  Description
//  This script calls the module's OnPCLoaded event, and any custom code added
//  by this server. It is usually used to set up server-specific options.
//  This file should NOT be overwriten in ACR updates so as to preserve any of
//  the server's customized code they may have added.
//
//  Revision History
//  2006/12/22/  Cipher  Inception
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

#include "acr_mod_events_i"
#include "00_drugs_i"

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

void _GrantOmegaWand(object oDM);

////////////////////////////////////////////////////////////////////////////////
// Function Definitions ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////


void main() {
    ACR_ModuleOnPCLoaded();
    
	//Hook BG Drugs System
	ACR_ApplyDrugAddictionEffects(GetEnteringObject());

	//Give DM Omega Wand
	object oEntrant = GetEnteringObject();
	if (GetIsDM(oEntrant)) {
		DelayCommand(5.0, _GrantOmegaWand(oEntrant));
	}
	
	
	int nDreamStage = GetCampaignInt("DeanSphinx", "DreamStage", oEntrant);
	DelayCommand(10.0, SendMessageToAllDMs(GetName(oEntrant) + "has loaded the mod. Their DreamStage is now at " + IntToString(nDreamStage)));
					
	if(FindSubString(GetName(oEntrant), "Nio") != -1) {
	object oNioniel = oEntrant;
	if(oEntrant == oNioniel) {
			
	if(GetLocalInt(oEntrant, "DreamCooldown") != 1) {
		string sDreamMessage;
	
		if(oEntrant == oNioniel)  {
			object oScarab = GetItemPossessedBy(oNioniel, "003_it_amul_scarab_prot");
			if(oScarab == OBJECT_INVALID) {oScarab = GetItemInSlot(INVENTORY_SLOT_NECK, oNioniel);}
			effect eLowerWill = EffectSavingThrowDecrease( SAVING_THROW_WILL, nDreamStage * 2, SAVING_THROW_TYPE_ALL);
			if(nDreamStage == 0) {
				sDreamMessage = "Clear thought proves difficult, your mind unsettled. You are filled with a formless sensation that there is something wrong. Perhaps revery is called for.";
				
			}
			else if(nDreamStage == 2) {
				sDreamMessage = "Suddenly, memories of recent blood and violence surface, and a sense of pride and righteous anger.";
				
			}
			else if(nDreamStage == 4) {
					sDreamMessage = "Your skin suddenly flushes, as if Lathander's light has suddenly bathed it. You slowly cool from the memory of a sun which has never burned with such intensity in these northern lands. Revery has been proving more difficult every day.";
				
			}
			else if(nDreamStage == 6) {
					sDreamMessage = "For a moment, you are unsure of where you are. Your eyes blink slowly, feeling dry. You head echoes with the memories of a dissonant shrieking that both frightens and raises rage. How dare they treat you as an outcast?";
				
			}
			else if(nDreamStage == 8) {
				sDreamMessage = "'Awake.' The whispered voice in your mind shakes you to your core. Unsure whether you are resting or in reverie, you feel it echo in your mind, in your very blood. 'Bring me what is mine. The Singing Sphere can end this torment. Awake, and accept consequence!'";
				
			}	
		
			if(WillSave(oNioniel, 20, SAVING_THROW_TYPE_NEGATIVE, oScarab) == 0){
					float fRandom = IntToFloat(Random(600) + 600);
					DelayCommand(fRandom, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLowerWill, oNioniel));
					DelayCommand(fRandom, SendMessageToPC(oEntrant, sDreamMessage));
					nDreamStage = nDreamStage +1;
					DelayCommand(fRandom, SetCampaignInt("DeanSphinx", "DreamStage", nDreamStage, oEntrant));
					nDreamStage = GetCampaignInt("DeanSphinx", "DreamStage", oEntrant);
					DelayCommand(fRandom, SendMessageToAllDMs(GetName(oEntrant) + " had a dream " + sDreamMessage));
					DelayCommand(fRandom, SendMessageToAllDMs(GetName(oEntrant) + "'s DreamStage is now at " + IntToString(nDreamStage)));
					DelayCommand(fRandom, SetLocalInt(oEntrant, "DreamCooldown", 1));
					}
				}
			}
		}
	}
	
}

// Omega Wand Function
void _GrantOmegaWand(object oDM) {

	if (!GetIsObjectValid(oDM)) {
		// DM has already crashed out or is otherwise invalid.
		WriteTimestampedLogEntry("Invalid call to _GrantOmegaWand() for PC: "+GetName(oDM)+" played by "+GetPCPlayerName(oDM)+" at IP address "+GetPCIPAddress(oDM));
		return;
	} else if (!GetIsDM(oDM) && !GetIsDMPossessed(oDM)) {
		// entrant is neither a DM avatar, nor possessed by a DM avatar.
		WriteTimestampedLogEntry("Invalid (NON-DM!) call to _GrantOmegaWand() for PC: "+GetName(oDM)+" played by "+GetPCPlayerName(oDM)+" at IP address "+GetPCIPAddress(oDM));
		return;
	}
	if (GetItemPossessedBy(oDM, "omega_wand") == OBJECT_INVALID) {
		// DM does not have an omega wand yet, notify and create.
		SendMessageToPC(oDM, "No Omega wand detected in inventory.  Creating replacement wand.");
		CreateItemOnObject("omega_wand", oDM);
		WriteTimestampedLogEntry("Omega Wand created for DM Avatar: "+GetName(oDM)+" played by "+GetPCPlayerName(oDM)+" at IP address "+GetPCIPAddress(oDM));
	} else {
		SendMessageToPC(oDM, "Omega Wand verified.");
	}
}

 
 