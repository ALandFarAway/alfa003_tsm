void ActionCreateCreature(string sCreature, location lLocPlace)
{
    CreateObject(OBJECT_TYPE_CREATURE, sCreature, lLocPlace, FALSE);
}


#include "acr_spawn_i"
#include "acr_db_persist_i"

void main()
{
             
//OnActivate Script for plot item Ostelle's soul jar for Wynna's Dean Sphinx quest of 2022
    object oUser = GetItemActivator();
	object oTarget = GetItemActivatedTarget();
    location lTarget = GetLocation(oTarget);
    location lCreate = GetItemActivatedTargetLocation();
    object oPhaedra = GetNearestObjectByTag("003_cr_bane_bp_elthonds",OBJECT_SELF, 1);
	effect eExplode = EffectVisualEffect(VFX_FNF_SOUND_BURST, FALSE);
	effect eWeb = EffectVisualEffect(VFX_AOE_WEB_OF_PURITY, FALSE);
	effect eBeam = EffectVisualEffect(VFX_BEAM_NECROMANCY, FALSE);
	effect ePurge = EffectVisualEffect(VFX_AOE_ETHEREAL_PURGE, FALSE);
	effect eNecAOE = EffectVisualEffect(VFX_HIT_AOE_NECROMANCY, FALSE);
	
	AssignCommand(oUser, ActionSpeakString("*Watches a black crystal crumble in hand", TALKVOLUME_TALK));
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eExplode, oUser, 3.0);
	ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eWeb, lTarget, 5.0);
	ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eBeam, lTarget, 5.0);
	DelayCommand(5.0, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, ePurge, lTarget, 5.0));
	DelayCommand(10.0, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eNecAOE, lTarget, 5.0));
	DelayCommand(10.0, ActionCreateCreature("003_cr_slv_profnec", lTarget));
	DelayCommand(15.0, AssignCommand(GetNearestObjectByTag("003_cr_slv_profnec", OBJECT_SELF, 1), ActionCastSpellAtObject(SPELL_SPELL_MANTLE, GetNearestObjectByTag("003_cr_slv_profnec", OBJECT_SELF, 1), METAMAGIC_NONE, TRUE, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
	DelayCommand(16.0, AddHenchman(oUser, GetNearestObjectByTag("003_cr_slv_profnec", OBJECT_SELF, 1)));	  
	DelayCommand(20.0, AssignCommand(GetNearestObjectByTag("003_cr_slv_profnec", OBJECT_SELF, 1), ActionForceFollowObject(oUser, 2.0))); 		 
	DestroyObject(OBJECT_SELF, 25.0);
}