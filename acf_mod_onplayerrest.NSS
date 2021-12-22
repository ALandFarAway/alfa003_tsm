////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ALFA Configuration File
//     Filename : acf_mod_onplayerrest.nss
//    $Revision:: 197        $ current version of the file
//        $Date:: 2006-12-23#$ date the file was created or modified
//       Author : Ronan
//
//  Local Variable Prefix = None
//
//  Description
//  This script calls the module's OnPlayerRest event, and any custom code added
//  by this server.
//  This file should NOT be overwriten in ACR updates so as to preserve any of
//  the server's customized code they may have added.
//
//  Revision History
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

////////////////////////////////////////////////////////////////////////////////
// Function Definitions ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
void main()
{
	effect e;
	object player = GetLastPCRested();
	string str;
	
	/* remove fatigue/exhaustion */
	SetLocalInt(player, "loc_flevel", 0);

	ACR_ModuleOnPlayerRest();
		
	// Custom code goes below this line.
	
	/* 5 minutes after, apply narcotic withdrawl */
	AssignCommand(player, DelayCommand(TurnsToSeconds(5), ACR_ApplyDrugAddictionEffects(player)));
	
	object oRester = GetLastPCRested();
	
	/*object oAshera;
	if(FindSubString(GetName(oRester), "Ash") != -1)
	{oAshera = oRester;}

	object oSaerela;
	if(FindSubString(GetName(oRester), "Saer") != -1)
	{oSaerela = oRester;}
	
	object oBaeithra;
	if(FindSubString(GetName(oRester), "ithra") != -1)
	{oBaeithra = oRester;}
	
	if((oRester == oAshera) || (oRester == oSaerela)|| (oRester == oBaeithra)) {
	//SendMessageToPC(oRester, "nLocal = " + IntToString(GetLocalInt(oRester, "DreamCooldown")));
	//SendMessageToPC(oRester, "nCampaign = " + IntToString(GetCampaignInt("DeanSphinx", "DreamStage", oRester)));
			
	if(GetLocalInt(oRester, "DreamCooldown") != 1) {
		int nDreamStage = GetCampaignInt("DeanSphinx", "DreamStage", oRester);
		string sDreamMessage;
		if((oRester == oAshera) || (oRester == oSaerela)) {
			if(nDreamStage == 0) {
				sDreamMessage = "";
			}
			else if(nDreamStage == 2) {
				sDreamMessage = "";
			}
			else if(nDreamStage == 4) {
				sDreamMessage = "";
			}
			else if(nDreamStage == 6) {
				sDreamMessage = "";
			}
			else if(nDreamStage == 8) {
				sDreamMessage = "";
			}
		}
		
		if(oRester == oBaeithra)  {
			if(nDreamStage == 0) {
				//sDreamMessage = "Rest proves difficult, your thoughts unsettled. You are filled with a formless sensation that there is something wrong.";
				sDreamMessage = "";
			}
			else if(nDreamStage == 2) {
				//sDreamMessage = "Unsure of whether you rested at all, you are unable to shake fragments of memories of recent blood and violence, and a sense of pride and righteous anger.";
				sDreamMessage = "";
			}
			else if(nDreamStage == 4) {
				//sDreamMessage = "You open your eyes suddenly into a cold room, with a heat in your chest burning away the chill of the Marches. Your blood thunders in your veins, throbbing like the beating of massive wings. Rest has proved more difficult every day.";
				sDreamMessage = "";
			}
			else if(nDreamStage == 6) {
				//sDreamMessage = "For a moment, you are unsure of where you are. Your eyes blink open slowly, feeling dry. You should be able to draw an inner eyelid across them, shouldn't you? To protect them from extended dry air? Speaking of dry, your skin itches, between your shoulder blades. You scratch, with fingernails that seem to need more trimming than you last recalled.";
				sDreamMessage = "";
			}
			else if(nDreamStage == 8) {
				//sDreamMessage = "'Awake.' The booming voice in your mind shakes you to your core. Unsure whether you are resting or in reverie, you feel it echo in your mind, in your very blood. 'Bring me what is mine, and my Queen's. Seek us in the Floating Mountain, to bring us what you owe, for loss and death and lesser blood twisted. There are those of your own kin that suffer as mine. Awake, and accept consequence!'";
				sDreamMessage = "";
			}	
		}
		SendMessageToPC(oRester, sDreamMessage);
		nDreamStage = nDreamStage +1;
		SetCampaignInt("DeanSphinx", "DreamStage", nDreamStage, oRester);
		nDreamStage = GetCampaignInt("DeanSphinx", "DreamStage", oRester);
		SendMessageToAllDMs(GetName(oRester) + " had a dream " + sDreamMessage);
		SendMessageToAllDMs(GetName(oRester) + "'s DreamStage is now at " + IntToString(nDreamStage));
		SetLocalInt(oRester, "DreamCooldown", 1);
		}
	}*/
}