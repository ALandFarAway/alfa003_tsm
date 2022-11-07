
#include "acr_spawn_i"
#include "acr_db_persist_i"

void main()
{
             
//OnActivate Script for the quest reward Snake Charmer's Flute for Wynna's Dean Sphinx quest of 2020
    object oUser = GetItemActivator();
	object oTarget = GetItemActivatedTarget();
    effect eBardsong = EffectVisualEffect(VFX_DUR_BARD_SONG, FALSE);
    effect eCharmed = EffectCharmed();
	int nBardLevel = GetLevelByClass(CLASS_TYPE_BARD, oUser);
	int nPerformSkill = GetSkillRank(SKILL_PERFORM_WIND_INSTRUMENTS, oUser, FALSE);
	int nSongLengthInt = (nBardLevel * nPerformSkill);
	float fSongLength = IntToFloat(nSongLengthInt + 30);
    if((FindSubString(GetTag(oTarget), "kobold") != -1) || (FindSubString(GetTag(oTarget), "lizard") != -1)  || (FindSubString(GetTag(oTarget), "snake") != -1))
	  	{ fSongLength = fSongLength * 2;  }
		
	   ActionCastSpellAtObject(SPELL_CHARM_MONSTER, oTarget, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT);
	   ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBardsong, oUser, fSongLength);	
	   ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBardsong, oTarget, fSongLength);	
	   ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eCharmed, oTarget, fSongLength);	
	   AssignCommand(oTarget, ActionForceMoveToObject(oUser, TRUE, 0.5));
	   AssignCommand(oTarget, ActionForceFollowObject(oUser, 1.0, 1));
	   DelayCommand(fSongLength, AssignCommand(oTarget, ClearAllActions(TRUE)));
	   
		
	
 
         
   
		  
}