
#include "acr_spawn_i"
#include "acr_db_persist_i"

void main()
{
             
    object oUser = GetItemActivator();
	object oTarget = GetItemActivatedTarget();
    effect eBardsong = EffectVisualEffect(VFX_DUR_BARD_SONG, FALSE);
    effect eSinging = EffectBardSongSinging(SPELL_RESISTANCE_COUNTERSONG);
	effect eTurned = EffectTurned();
	int nBardLevel = GetLevelByClass(CLASS_TYPE_BARD, oUser);
	int nPerformSkill = GetSkillRank(SKILL_PERFORM_WIND_INSTRUMENTS, oUser, FALSE);
	int nSongLengthInt = (nBardLevel * nPerformSkill);
	float fSongLength = IntToFloat(nSongLengthInt + 6);
    int nRace = GetRacialType(oTarget);
	
	if(nRace == RACIAL_TYPE_INCORPOREAL)
	  {ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSinging, oUser, fSongLength);	
	   ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBardsong, oTarget, fSongLength);	
	   ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eTurned, oTarget, fSongLength);	
		}
	
 
         
   
		  
}