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

	SendMessageToAllDMs("onEnter firing");

 // Custom code goes here.
 object oPC;
 if((GetIsPC(GetEnteringObject())) || (GetIsDMPossessed(GetEnteringObject()))) {
 	oPC = GetEnteringObject();
	int nAppearance = GetLocalInt(OBJECT_SELF, "Appearance");     
    object oMyCreature = GetLocalObject(OBJECT_SELF, "Undead_Proxy_Cre");	     
    object oMyCorpse = GetNearestObjectByTag("tsm_plc_undead_proxy", OBJECT_SELF, 1);
    SendMessageToAllDMs("onEnter. oMyCreature = " + GetName(oMyCreature) + ". oMyCorpse = " + GetName(oMyCorpse));
	effect eParalyze = EffectParalyze(-1,SAVING_THROW_WILL,FALSE);
	effect eSpawning = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE, 1);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSpawning, oMyCorpse, 2.0);
	SetCreatureAppearanceType(oMyCreature,nAppearance);
   	RemoveEffect(oMyCreature, eParalyze);
	}
}