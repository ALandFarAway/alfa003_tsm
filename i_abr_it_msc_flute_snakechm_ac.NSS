
#include "acr_spawn_i"
#include "acr_db_persist_i"

void main()
{
             
//OnActivate Script for the quest reward Snake Charmer's Flute for Wynna's Dean Sphinx quest of 2020
    object oUser = GetItemActivator();
	object oTarget = GetItemActivatedTarget();
    effect eCharm = EffectVisualEffect(VFX_DUR_SPELL_CHARM_MONSTER, FALSE);
    effect eBardsong = EffectVisualEffect(VFX_DUR_BARD_SONG, FALSE);
    effect eCharmed = EffectCharmed();
	int nBardLevel = GetLevelByClass(CLASS_TYPE_BARD, oUser);
	int nPerformSkill = GetSkillRank(SKILL_PERFORM_WIND_INSTRUMENTS, oUser, FALSE);
	int nSongLengthInt = (nBardLevel * nPerformSkill);
	float fSongLength = IntToFloat(nSongLengthInt + 6);
    
	if((FindSubString(GetTag(oTarget), "kobold") != -1) || (FindSubString(GetTag(oTarget), "lizard") != -1)  || (FindSubString(GetTag(oTarget), "snake") != -1))
	  {AssignCommand(oUser, ActionSpeakString("Charm will last 6 seconds + BardLevel" + IntToString(nBardLevel) + " x Perform Wind Instruments Skill Level" + IntToString(nPerformSkill) + " which is " + FloatToString(fSongLength), TALKVOLUME_TALK));
	   ActionCastFakeSpellAtObject(SPELL_CHARM_MONSTER, oTarget, PROJECTILE_PATH_TYPE_DEFAULT);
	   ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBardsong, oUser, fSongLength);	
	   ApplyEffectToObject(DURATION_TYPE_INSTANT, eCharm, oTarget);	
	   ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eCharmed, oTarget, fSongLength);	
		}
	
 
         
   
		  
}