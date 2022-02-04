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

	SendMessageToAllDMs("onEnter firing for " + GetName(OBJECT_SELF));

 // Custom code goes here.
 object oPC;
 if((GetLocalInt(OBJECT_SELF, "RUN_ONCE") != 1) && ((GetIsPC(GetEnteringObject())) || (GetIsDMPossessed(GetEnteringObject())))) {
 	SetLocalInt(OBJECT_SELF, "RUN_ONCE", 1);
	oPC = GetEnteringObject();
	int nAppearance = GetLocalInt(OBJECT_SELF, "Appearance");     
    object oMyCreature = GetLocalObject(OBJECT_SELF, "Undead_Proxy_Cre");	     
    object oMyCorpse = GetNearestObjectByTag("tsm_plc_undead_proxy", OBJECT_SELF, 1);
    SendMessageToAllDMs(GetName(oPC ) + " entered " + GetName(OBJECT_SELF)+ ". oMyCreature = " + GetName(oMyCreature) + ". oMyCorpse = " + GetName(oMyCorpse));
	//effect eSanctuary = EffectSanctuary(20);
    effect eParalyze = EffectCutsceneParalyze();
	effect eRise = EffectVisualEffect(VFX_CAST_SPELL_SPIRIT_EMERGE, FALSE);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRise, oMyCorpse, 5.0);
	DelayCommand(1.0, SetCreatureAppearanceType(oMyCreature,nAppearance));
	effect eEffect = GetFirstEffect(oMyCreature);
	while(GetIsEffectValid(eEffect)) {
		//SendMessageToAllDMs(GetName(oMyCreature) + " " + IntToString(GetEffectInteger(eEffect,1)));
		RemoveEffect(oMyCreature, eEffect);
		eEffect = GetNextEffect(oMyCreature);
		}
   	}
	object oAttack = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, OBJECT_SELF, 1);
	ActionAttack(oAttack, FALSE);
}