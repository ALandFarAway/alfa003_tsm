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

	
	object oBaeithra;
	if(FindSubString(GetName(oRester), "ithra") != -1)
	{oBaeithra = oRester;}
	*/
	object oSaerela;
	if(FindSubString(GetName(oRester), "Saer") != -1)
	{oSaerela = oRester;}
	
	object oNioniel;
	if(FindSubString(GetName(oRester), "Nio") != -1)
	{oNioniel = oRester;}
	
	object oSaveAgainst;
	//if(oRester == oNioniel) {
	//SendMessageToPC(oRester, "nLocal = " + IntToString(GetLocalInt(oRester, "DreamCooldown")));
	//SendMessageToPC(oRester, "nCampaign = " + IntToString(GetCampaignInt("DeanSphinx", "DreamStage", oRester)));
			
	if(GetLocalInt(oRester, "DreamCooldown") != 1) {
		int nDreamStage = GetCampaignInt("DeanSphinx", "DreamStage", oRester);
		string sDreamMessage;
		if(oRester == oSaerela) {
			object oArmor = GetItemPossessedBy(oSaerela, "03_it_e1_arm_song_eaerlann");
			if(oArmor == OBJECT_INVALID) {oArmor = GetItemInSlot(INVENTORY_SLOT_CHEST, oSaerela);}
			oSaveAgainst = oArmor;
			if(nDreamStage == 0) {
				sDreamMessage = "Reverie proves difficult, your thoughts unsettled. You are filled with a formless sensation that there is something wrong.";
				
			}
			else if(nDreamStage == 2) {
				sDreamMessage = "Unsure of whether you achieved revery at all, you are unable to shake fragments of memories of recent blood and violence: the Baelnorn in the High Forest Tower, the explosion of the dwarven water wheel, the many battles it took to clear out the Drowned Tower.";
				
			}
			else if(nDreamStage == 4) {
					sDreamMessage = "You open your eyes suddenly, confused for a moment. Revery has proved more difficult every day. You are ice cold, and for a moment your eyes see only ice encasing you, before the imagining fades away.";
				
			}
			else if(nDreamStage == 6) {
					sDreamMessage = "Your eyes blink open slowly. You see your servant, dear Balran Ithrinn, leaning over you on this bed of ice as he casts the words that will....will what? You blink once more, and you are surrounded only by the here and now.";
				
			}
			else if(nDreamStage == 8) {
				sDreamMessage = "'Sleep.' The whispered voice in your mind shakes you to your core. Unsure whether you are resting or in reverie, you feel it echo in your mind, in your frozen blood. 'Sleep as you have commanded. The Singing Sphere will guard your tomb. Sleep, and delay Lady Frostkiss's vengeance!'";
				
			}	
		}
		
		if(oRester == oNioniel)  {
			object oScarab = GetItemPossessedBy(oNioniel, "003_it_amul_scarab_prot");
			if(oScarab == OBJECT_INVALID) {oScarab = GetItemInSlot(INVENTORY_SLOT_NECK, oNioniel);}
			effect eLowerWill = EffectSavingThrowDecrease( SAVING_THROW_WILL, nDreamStage * 2, SAVING_THROW_TYPE_ALL);
			oSaveAgainst = oScarab;
			if(nDreamStage == 0) {
				sDreamMessage = "Rest proves difficult, your thoughts unsettled. You are filled with a formless sensation that there is something wrong.";
				
			}
			else if(nDreamStage == 2) {
				sDreamMessage = "Unsure of whether you rested at all, you are unable to shake fragments of memories of recent blood and violence, and a sense of pride and righteous anger.";
				
			}
			else if(nDreamStage == 4) {
					sDreamMessage = "You open your eyes suddenly into the chill of the Marches. Your skin cools from the memory of a sun which has never burned with such intensity in these northern lands. Rest has proved more difficult every day.";
				
			}
			else if(nDreamStage == 6) {
					sDreamMessage = "For a moment, you are unsure of where you are. Your eyes blink open slowly, feeling dry. Your head echoes with the memories of a dissonant shrieking that both frightens and raises rage. How dare they treat you as an outcast?";
				
			}
			else if(nDreamStage == 8) {
				sDreamMessage = "'Awake.' The whispered voice in your mind shakes you to your core. Unsure whether you are resting or in reverie, you feel it echo in your mind, in your very blood. 'Bring me what is mine. The Singing Sphere can end this torment. Awake, and accept consequence!'";
				
			}	
		
		if(WillSave(oRester, 20, SAVING_THROW_TYPE_NEGATIVE, oSaveAgainst) == 0){
					effect eLowerWill = EffectSavingThrowDecrease( SAVING_THROW_WILL, nDreamStage * 2, SAVING_THROW_TYPE_ALL);
					ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLowerWill, oRester);
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
	//}
}