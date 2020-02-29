//OnSpellCastAt for TSM NPCs
//Wynna February 2020


#include "acr_creature_i"
#include "acr_db_persist_i"
#include "acr_quest_i"
#include "003_silverymoon_i"
					
					
void main()
{
	ACR_CreatureOnSpellCastAt();
    object oCaster = GetLastSpellCaster();
    object oArea = GetArea(OBJECT_SELF);


		if(((FindSubString(GetTag(OBJECT_SELF), "deneir") != -1) || (FindSubString(GetTag(OBJECT_SELF), "vos_scribe") != -1)) && (GetIsEnemy(oCaster, OBJECT_SELF)) && (GetIsPC(oCaster))) 
			{effect eKnockdown = EffectKnockdown();
			 ChangeToStandardFaction(OBJECT_SELF, STANDARD_FACTION_COMMONER);
			 ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnockdown, OBJECT_SELF, 600.0);
			 }
}