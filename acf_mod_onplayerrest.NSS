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
	object oSaerela;
	if(FindSubString(GetName(oRester), "Saer") != -1)
	{oSaerela = oRester;}
	
	object oNioniel;
	if(FindSubString(GetName(oRester), "Nio") != -1)
	{oNioniel = oRester;}
	
	object oJhessi;
	if(FindSubString(GetName(oRester), "Jhess") != -1)
	{oJhessi = oRester;}
	
	object oBertilak;
	if(FindSubString(GetName(oRester), "Bert") != -1)
	{oBertilak = oRester;}
	
	object oRiki;
	if(FindSubString(GetName(oRester), "Rik") != -1)
	{oRiki = oRester;}
	
	object oZova;
	if(FindSubString(GetName(oRester), "Zov") != -1)
	{oZova = oRester;}
	
	object oDerry;
	if(FindSubString(GetName(oRester), "Derr") != -1)
	{oDerry = oRester;}
	
	object oGlaus;
	if(FindSubString(GetName(oRester), "Glaus") != -1)
	{oGlaus = oRester;}
	
			
	if(GetLocalInt(oRester, "DreamCooldown") != 1) {
	object oSayen = GetNearestObjectByTag("003_cr_invis_caster", OBJECT_SELF, 1);
	if(oSayen == OBJECT_INVALID) {
		oSayen = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_invis_caster", GetLocation(OBJECT_SELF));
		SetFirstName(oSayen, "Gyasi");
		SetLastName(oSayen, "Sayen");
		DestroyObject(oSayen, 6.0);
		}
	object oSaveAgainst = oSayen;
			
	int nDreamStage = GetCampaignInt("DeanSphinx", "DreamStage", oRester);
	SendMessageToAllDMs(GetName(oRester) + " is resting. Their cursed DreamStage is currently at " + IntToString(nDreamStage));
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
		}
		
	if(oRester == oJhessi)  {		
			if(nDreamStage == 0) {sDreamMessage = "You have a bad dream: Bertilak's flesh melting away from his face, leaving a skull with blazing eyes";}
			else if(nDreamStage == 2) {sDreamMessage = "You have a bad dream: Ostelle engulfed in black fire.";}
			else if(nDreamStage == 4) {sDreamMessage = "You have a bad dream: A harpy with rotting flesh flaring her wings over a bloodied Aedelvana.";}
			}
				
		if(oRester == oBertilak)  {
			if(nDreamStage == 0) {sDreamMessage = "You have a bad dream: Jhessi chained to a wall in a Banite cell with Phaedra's hand around her throat.";}
			else if(nDreamStage == 2) {sDreamMessage = "You have a bad dream: Lord Elthondsson upon a funeral pyre, but still alive, screaming.";}
			else if(nDreamStage == 4) {sDreamMessage = "You have a bad dream:  Yourself hanging in a cage over snow, watching as a barbarian cleric brings Jhessi back to life, then kills her, then brings her back to life...";}
			}
					
		if(oRester == oZova) {
			if(nDreamStage == 0) {sDreamMessage = "You have a bad dream: Saerela screaming as she is consumed by a black fire emanating from a crystal globe.";}
			else if(nDreamStage == 2) {sDreamMessage = "You have a bad dream: Twin scimitars slitting Derry's throat.";}
			else if(nDreamStage == 4) {sDreamMessage = "You have a bad dream: Aglaril's death in the Temple of Isis.";}
			}
		if(oRester == oRiki) {
			if(nDreamStage == 0) {sDreamMessage = "You have a bad dream: An owlbear, its beak ripping your heart from your chest.";}
			else if(nDreamStage == 2) {sDreamMessage = "You have a bad dream:  A laughing, fey face, gnarled like bark, leaning over your dead, icy body.";}
			else if(nDreamStage == 4) {sDreamMessage = "You have a bad dream:  Yourself, in a cage, while clowns with painted faces poke spears between the bars at you.";}
			else if(nDreamStage == 6) {sDreamMessage = "You have a bad dream:  Derry, screaming as his flesh crystallizes from the feet up.";}
			}
		if(oRester == oDerry) {
			if(nDreamStage == 0) {sDreamMessage = "You have a bad dream: Zova, with pupil-less eyes of red and hands around your neck.";}
			else if(nDreamStage == 2) {sDreamMessage = "You have a bad dream: Your soul torn from your body and sucked into a golden tea pot.";}
			else if(nDreamStage == 8) {sDreamMessage = "You have a bad dream: A great golden dragon battering down the keep of Olostin's Hold while townspeople scream and flee.";}
			else if(nDreamStage == 16) {sDreamMessage = "You have a bad dream: Riki, a corpse frozen within a block of ice.";}
			}
		if(oRester == oGlaus)  {
			if(nDreamStage == 0) {sDreamMessage = "You have a bad dream: Felbarr, besieged by half-crystalized orcs.";}
			else if(nDreamStage == 2) {sDreamMessage = "You have a bad dream: A mummy with a helmet made from the top half of a humanoid skull standing over Bertilak's disease-wracked body.";}
			else if(nDreamStage == 4) {sDreamMessage = "You have a bad dream: Saerela, showing you the five-faceted ring so contemptuously.";}
			else if(nDreamStage == 6) {sDreamMessage = "You have a bad dream: Walls of black crystal imprisoning you.";}
			}
				
		if(WillSave(oRester, 25, SAVING_THROW_TYPE_EVIL, oSaveAgainst) == 0){
			effect eLowerWill = EffectSavingThrowDecrease( SAVING_THROW_WILL, nDreamStage, SAVING_THROW_TYPE_ALL);
			ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLowerWill, oRester);
			}
			
		SendMessageToPC(oRester, sDreamMessage);
		SendMessageToPC(oRester, "You open your eyes feeling tired and listless.");
		nDreamStage = nDreamStage +1;
		SetCampaignInt("DeanSphinx", "DreamStage", nDreamStage, oRester);
		nDreamStage = GetCampaignInt("DeanSphinx", "DreamStage", oRester);
		SendMessageToAllDMs(GetName(oRester) + " had a cursed dream " + sDreamMessage);
		SendMessageToAllDMs(GetName(oRester) + "'s cursed DreamStage is now at " + IntToString(nDreamStage));
		SetLocalInt(oRester, "DreamCooldown", 1);
			
		}
}