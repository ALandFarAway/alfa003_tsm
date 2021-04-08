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
	
	object oAshera;
	if(FindSubString(GetName(oRester), "Ashely") != -1)
	{oAshera = oRester;}

	object oSaerela;
	if(FindSubString(GetName(oRester), "Saers") != -1)
	{oSaerela = oRester;}
	
	object oBaeithra;
	if(FindSubString(GetName(oRester), "ithran") != -1)
	{oBaeithra = oRester;}
	
	if((oRester == oAshera) || (oRester == oSaerela)|| (oRester == oBaeithra)) {
	SendMessageToPC(oRester, "nLocal = " + IntToString(GetLocalInt(oRester, "DreamCooldown")));
	SendMessageToPC(oRester, "nCampaign = " + IntToString(GetCampaignInt("DeanSphinx", "DreamStage", oRester)));
			
	if(GetLocalInt(oRester, "DreamCooldown") != 1) {
		int nDreamStage = GetCampaignInt("DeanSphinx", "DreamStage", oRester);
		string sDreamMessage;
		if((oRester == oAshera) || (oRester == oSaerela)) {
			if(nDreamStage == 0) {
				sDreamMessage = "You wake from a restless sleep, filled with dreams you can't recall.";
			}
			else if(nDreamStage == 2) {
				sDreamMessage = "When you wake, you carry with you the fragments of dreams of recent blood and violence, and the sound of long, deep-voiced laughter.";
			}
			else if(nDreamStage == 4) {
				sDreamMessage = "You wake sluggishly into a cold room. The Marches are always cold, but you feel this chill in your bones. The taste of blood lingers on your tongue, no matter how often you flick it against your teeth, clenched in what seems for a moment a too-short jaw.";
			}
			else if(nDreamStage == 6) {
				sDreamMessage = "Your eyes blink open slowly, feeling dry. You should be able to draw an inner eyelid across them, shouldn't you? To protect them from extended dry air? Speaking of dry, your skin itches, between your shoulder blades. You scratch, with fingernails that seem to need more trimming than you last recalled.";
			}
			else if(nDreamStage == 8) {
				sDreamMessage = "'Feedstock.' The word chases you out of dreams of death, of your broodkin cut down by monsters crossbred from members of your own tribe and alien stock, of crystals shattering and flying, striking your too-soft hide, blood flowing. You hear a laughing voice, and the softer tones of the human torturer, Flat Face, holding a conversation with his master in the mirror. Unsure if you are awake or asleep, you squirm with the itching of skin. You are dry, so dry that your hide cracks in scales around the wound you received from flying shards of shattered crystal in the dessicated cave.";
			}
		}
		
		if(oRester == oBaeithra)  {
			if(nDreamStage == 0) {
				sDreamMessage = "You wake from a restless sleep, filled with dreams you can't recall.";
			}
			else if(nDreamStage == 2) {
				sDreamMessage = "When you wake, you carry with you the fragments of dreams of recent blood and violence, and the sense of pride and righteous anger.";
			}
			else if(nDreamStage == 4) {
				sDreamMessage = "You wake suddenly into a cold room, with a heat in your chest burning away the chill of the Marches. Your blood thunders in your veins, throbbing like the beating of massive wings.";
			}
			else if(nDreamStage == 6) {
				sDreamMessage = "Your eyes blink open slowly, feeling dry. You should be able to draw an inner eyelid across them, shouldn't you? To protect them from extended dry air? Speaking of dry, your skin itches, between your shoulder blades. You scratch, with fingernails that seem to need more trimming than you last recalled.";
			}
			else if(nDreamStage == 8) {
				sDreamMessage = "'Awake.' The booming voice shakes you to your core. Unsure whether you are awake or asleep, you feel it echo in your mind, in your very blood. 'Bring me what is mine, and my Queen's. Seek us in the Floating Mountain, to bring us what you owe, for loss and death and lesser blood twisted. There are those of your own kin that suffer as mine. Awake, and accept consequence!'";
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
	}
}