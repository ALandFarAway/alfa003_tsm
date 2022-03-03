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
 object oPC;
 if((GetLocalInt(OBJECT_SELF, "RUN_ONCE") != 1) && ((FindSubString(GetName(oPC), "Bert") != -1) ||  (GetIsPC(GetEnteringObject())) || (GetIsDMPossessed(GetEnteringObject())))) {
 	SendMessageToAllDMs("onEnter firing for " + GetName(OBJECT_SELF));
    SetLocalInt(OBJECT_SELF, "RUN_ONCE", 1);
	oPC = GetEnteringObject();
	int nAppearance = GetLocalInt(OBJECT_SELF, "Appearance");     
    object oMyCreature = GetLocalObject(OBJECT_SELF, "Undead_Proxy_Cre");	     
    if((GetIsObjectValid(oMyCreature)) && (GetLocalInt(oMyCreature, "Proxy") == 1)) {
		SetLocalInt(oMyCreature, "Proxy", 2);	
		object oMyCorpse = GetLocalObject(OBJECT_SELF, "Undead_Proxy_Plc");
	    if(GetIsObjectValid(oMyCorpse)) {
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
		   	object oAttack = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, OBJECT_SELF, 1);
			DelayCommand(2.0, AssignCommand(oMyCreature, ActionForceMoveToObject(oAttack, TRUE)));
			DelayCommand(3.0, AssignCommand(oMyCreature, ActionAttack(oAttack, FALSE)));
			}
		}
	}
}