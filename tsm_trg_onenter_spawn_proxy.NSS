////////////////////////////////////////////////////////////////////////////////
//Wynna 1/23/2022
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#include "acr_trigger_i"
#include "acr_quest_i"
#include "acr_spawn_i"

////////////////////////////////////////////////////////////////////////////////
// Function Definitions ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

void ActionCreateCreature(string sCreature, location lLocPlace)
{
    CreateObject(OBJECT_TYPE_CREATURE, sCreature, lLocPlace, FALSE);
}

void main()
{
    ACR_TriggerOnEnter();

	
 // Custom code goes here.
 object oPC = GetEnteringObject();
 if((GetLocalInt(OBJECT_SELF, "RUN_ONCE") != 1) && ((GetIsPC(GetEnteringObject())) || (GetIsDMPossessed(GetEnteringObject())))) {
 	SendMessageToAllDMs(GetName(oPC) + " triggering " + GetName(OBJECT_SELF));
    SetLocalInt(OBJECT_SELF, "RUN_ONCE", 1);
	int nAppearance = GetLocalInt(OBJECT_SELF, "Appearance");
	object oMyCreature = GetLocalObject(OBJECT_SELF, "Undead_Proxy_Cre");	     
    if((GetIsObjectValid(oMyCreature)) && (GetLocalInt(oMyCreature, "Proxy") == 1)) {
		SetLocalInt(oMyCreature, "Proxy", 2);	
		object oMyCorpse = GetLocalObject(OBJECT_SELF, "Undead_Proxy_Plc");
	    int nDestroyPLC = GetLocalInt(oMyCorpse, "Destroy_PLC");     
        if(GetIsObjectValid(oMyCorpse)) {
			if(GetTag(oMyCreature) == "003_cr_un_ghost_orcfded"){
				if(Random(4) == 1) {CreateItemOnObject("abr_scroll_3_inflictserious", oMyCorpse, 1);}
				if(Random(4) == 1) {if(Random(4) == 1) {CreateItemOnObject("aca_it_ar_stlthr_dt1", oMyCorpse, 1);}else  {CreateItemOnObject("aca_it_ar_stlthr_dt", oMyCorpse, 1);}}
				if(Random(4) == 1) {if(Random(4) == 1) {CreateItemOnObject("abr_it_wpn_mace_eh1", oMyCorpse, 1);}else  {CreateItemOnObject("abr_it_wpn_club_mw_1", oMyCorpse, 1);}}
				if(Random(4) == 1) {CreateItemOnObject("abr_it_choker_set", oMyCorpse, 1);}
				if(Random(4) == 1) {CreateItemOnObject("abr_it_mpotion_invis", oMyCorpse, 1);}
				if(Random(4) == 1) {CreateItemOnObject("abr_it_mpotion_endure-elements", oMyCorpse, 1);}
				if(Random(4) == 1) {CreateItemOnObject("abr_it_mpotion_speed", oMyCorpse, 1);}
				if(Random(4) == 1) {if(Random(4) == 1) {CreateItemOnObject("NW_IT_GOLD100", oMyCorpse, 1);}else  {CreateItemOnObject("NW_IT_GOLD50", oMyCorpse, 1);}}
				if(Random(4) == 1) {int nGem = Random(100); string sGem = "abr_it_gem_0" + IntToString(nGem);CreateItemOnObject(sGem, oMyCorpse, Random(2));}
				}
			if(GetTag(oMyCreature) == "abr_cr_un_skeleton_spellst"){
				ChangeToStandardFaction(oMyCreature, STANDARD_FACTION_DEFENDER);
				}
			if(GetTag(oMyCreature) == "010_cr_undead_mum_khan"){
				object oContainment = GetObjectByTag("fx_containment_fake", 0);
				DestroyObject(oContainment, 2.0);
			}
			
				
			effect eRise = EffectVisualEffect(VFX_FNF_SUMMON_EPIC_UNDEAD, FALSE);
			ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRise, oMyCorpse, 5.0);
			DelayCommand(1.0, SetCreatureAppearanceType(oMyCreature,nAppearance));
			string sMessage = GetLocalString(OBJECT_SELF, "ACR_SPAWN_MESSAGE");
			DelayCommand(1.5, AssignCommand(oMyCreature, ActionSpeakString(sMessage, TALKVOLUME_TALK)));
			effect eEffect = GetFirstEffect(oMyCreature);
			while(GetIsEffectValid(eEffect)) {
				RemoveEffect(oMyCreature, eEffect);
				eEffect = GetNextEffect(oMyCreature);
				}
			if(nDestroyPLC == 1) {
				DestroyObject(oMyCorpse, 2.0);
				}
			
		   	DelayCommand(6.0, AssignCommand(oMyCreature, ActionAttack(GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, OBJECT_SELF, 1), FALSE)));
			}
		}
	}
}