#include "acr_spawn_i"
#include "silvy_univ_inc"
#include "acr_db_persist_i"
#include "silvy_univ_func"
#include "acr_quest_i"
 
void main()
{
	     
         
	if(GetTag(OBJECT_SELF)== "003_cr_lath_cyrthol")
        { 	 
         AssignCommand(OBJECT_SELF, ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectTrueSeeing(),OBJECT_SELF));
    	 SetListenPattern(OBJECT_SELF, "**Sylune**", 6001);
         SetListening(OBJECT_SELF, TRUE);
    	}
		
	     	 
	if(GetTag(OBJECT_SELF)== "003_cr_voice")
        {SetActionMode(OBJECT_SELF, ACTION_MODE_STEALTH, STEALTH_MODE_ACTIVATED);
		 AssignCommand(OBJECT_SELF, ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectTrueSeeing(),OBJECT_SELF));
    	 effect eInvis = EffectInvisibility(EFFECT_TYPE_GREATERINVISIBILITY);
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