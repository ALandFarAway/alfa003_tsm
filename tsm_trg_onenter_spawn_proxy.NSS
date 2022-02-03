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
    effect eRise = EffectVisualEffect(VFX_IMP_RAISE_DEAD, 1);
	SendMessageToAllDMs("onEnter for " + GetName(OBJECT_SELF)+ ". oMyCreature = " + GetName(oMyCreature) + ". oMyCorpse = " + GetName(oMyCorpse));
	effect eParalyze = EffectParalyze(-1,SAVING_THROW_WILL,FALSE);
	effect eSpawning = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE, 1);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSpawning, oMyCorpse, 2.0);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRise, oMyCorpse, 2.0);
	DelayCommand(1.0, SetCreatureAppearanceType(oMyCreature,nAppearance));
   	DelayCommand(2.0, RemoveEffect(oMyCreature, eParalyze));
	}
}