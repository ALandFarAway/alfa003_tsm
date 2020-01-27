
#include "acr_spawn_i"
#include "acr_db_persist_i"

void main()
{
             
//OnActivate Script for the quest reward Staff of the Forked Tongue for Wynna's Dean Sphinx quest of 2020
    object oUser = GetItemActivator();
    object oDragon = GetItemActivatedTarget();
    effect eGlimmer = EffectVisualEffect(VFX_DUR_PIXIEDUST, FALSE);
    effect eSummon = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1, FALSE);
    effect eDiplomacy = EffectSkillIncrease(SKILL_DIPLOMACY, 2);
	effect eBluff = EffectSkillIncrease(SKILL_BLUFF, 2);
	effect eIntimidate = EffectSkillIncrease(SKILL_INTIMIDATE, 2);
		
	SendMessageToAllDMs(GetName(oUser) + " has used the Staff of the Forked Tongue and has gained the temporary ability to speak Draconic (RP only)");
	DelayCommand(300.0, SendMessageToAllDMs(GetName(oUser) + " temporary ability to speak Draconic has expired."));
	SendMessageToPC(oUser, "You gain the ability to speak Draconic for five minutes. (RP only)");
	DelayCommand(300.0, SendMessageToPC(oUser, "You have lost the temporary ability to speak Draconic."));
		 	 
    if(GetRacialType(oDragon) == RACIAL_TYPE_DRAGON)
		{SetLocalObject(OBJECT_SELF, "oCustomer", oUser); 
		 DelayCommand(300.0, SetLocalObject(OBJECT_SELF, "oCustomer", OBJECT_INVALID));
		 ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDiplomacy, oUser, 300.0);
		 ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBluff, oUser, 300.0);
		 ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eIntimidate, oUser, 300.0);
		 SendMessageToPC(oUser, "Your ability to negotiate with dragons has been increased for five minutes.");
		 DelayCommand(300.0, SendMessageToPC(oUser, "You feel your draconic charisma fading."));
		 
		 
		}
	
	
 
         
   
		  
}