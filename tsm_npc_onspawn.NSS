#include "acr_spawn_i"
#include "silvy_univ_inc"
#include "acr_db_persist_i"
#include "silvy_univ_func"
#include "acr_quest_i"
 
void main()
{
	AssignCommand(OBJECT_SELF, ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectTrueSeeing(),OBJECT_SELF));
	effect eCutScene = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);
	effect eInvis = EffectInvisibility(INVISIBILITY_TYPE_IMPROVED);
	effect eEthereal = EffectEthereal();
	SetStandardFactionReputation(STANDARD_FACTION_HOSTILE, 50, OBJECT_SELF);
	effect eGhost = EffectCutsceneGhost();	 	 		     	      
    SetImmortal(OBJECT_SELF, TRUE);     
	effect eFreeze = EffectCutsceneImmobilize();
								 
	if(GetTag(OBJECT_SELF)== "003_cr_voice_xyz")
        { 	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutScene, OBJECT_SELF);
			ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, OBJECT_SELF);
			ApplyEffectToObject(DURATION_TYPE_PERMANENT, eInvis, OBJECT_SELF);
			ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEthereal, OBJECT_SELF);
			ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectTrueSeeing(),OBJECT_SELF);
    	 	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eFreeze,OBJECT_SELF);
    	 	}
	
	if(GetTag(OBJECT_SELF)== "003_cr_invis_caster")
        { 	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutScene, OBJECT_SELF);
			ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, OBJECT_SELF);
			ApplyEffectToObject(DURATION_TYPE_PERMANENT, eInvis, OBJECT_SELF);
			ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEthereal, OBJECT_SELF);
			ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectTrueSeeing(),OBJECT_SELF);
    	 	DestroyObject(OBJECT_SELF, 60.0);
			//SetImmortal(OBJECT_SELF, 1);
			//object oOrb = GetObjectByTag("phalorm_orb_black", 0);
			//effect eFireI = EffectDamageImmunityIncrease(DAMAGE_TYPE_FIRE, 100);
		    //ApplyEffectToObject(DURATION_TYPE_PERMANENT, eFireI, oOrb);
		
			
			}
	
	if(GetTag(OBJECT_SELF)== "003_cr_lath_cyrthol")
        { AssignCommand(OBJECT_SELF, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutScene,OBJECT_SELF));
		 
         AssignCommand(OBJECT_SELF, ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectTrueSeeing(),OBJECT_SELF));
    	 SetListenPattern(OBJECT_SELF, "**Sylune**", 6001);
         SetListening(OBJECT_SELF, TRUE);
    	}
		 
	if(GetTag(OBJECT_SELF)== "003_cr_voice")
        {SetActionMode(OBJECT_SELF, ACTION_MODE_STEALTH, STEALTH_MODE_ACTIVATED);
		 AssignCommand(OBJECT_SELF, ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectTrueSeeing(),OBJECT_SELF));
    	  AssignCommand(OBJECT_SELF, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutScene,OBJECT_SELF));
		 AssignCommand(OBJECT_SELF, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eInvis,OBJECT_SELF));
    	 SetListenPattern(OBJECT_SELF, "**Sylune**", 6001);
         SetListenPattern(OBJECT_SELF, "**Alustriel**", 6002);
         SetListenPattern(OBJECT_SELF, "**Dove**", 6003);
         SetListenPattern(OBJECT_SELF, "**Storm**", 6004);
         SetListenPattern(OBJECT_SELF, "**Laeral**", 6005);
         SetListenPattern(OBJECT_SELF, "**Simbul", 6006);
         SetListenPattern(OBJECT_SELF, "**Alassra", 6007);
         SetListenPattern(OBJECT_SELF, "**Qilue**", 6008);
         SetListenPattern(OBJECT_SELF, "**Gone and never lost**", 6009);
         SetListening(OBJECT_SELF, TRUE);
    	}
		 
	if(GetTag(OBJECT_SELF)== "003_cr_foch_mothermay")
        {ActionSit(GetObjectByTag(GetTag(OBJECT_SELF) + "_Chair"));
	     }
   }