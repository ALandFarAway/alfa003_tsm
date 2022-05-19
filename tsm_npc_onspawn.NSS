#include "acr_spawn_i"
#include "silvy_univ_inc"
#include "acr_db_persist_i"
#include "silvy_univ_func"
#include "acr_quest_i"
 
void main()
{
	AssignCommand(OBJECT_SELF, ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectTrueSeeing(),OBJECT_SELF));
	effect eCutScene = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);
	AssignCommand(OBJECT_SELF, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutScene,OBJECT_SELF));
	    	      
         
	if(GetTag(OBJECT_SELF)== "003_cr_lath_cyrthol")
        { 	 
         AssignCommand(OBJECT_SELF, ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectTrueSeeing(),OBJECT_SELF));
    	 SetListenPattern(OBJECT_SELF, "**Sylune**", 6001);
         SetListening(OBJECT_SELF, TRUE);
    	}
		
		if(GetTag(OBJECT_SELF)== "003_cr_scry_send") {
			 SetListenPattern(OBJECT_SELF, "**", 6031);
			 SetListening(OBJECT_SELF, TRUE);
			 }
		
		if(GetTag(OBJECT_SELF)== "003_cr_scry_listen") {
			 SetListenPattern(OBJECT_SELF, "**None**", 6010);
			 SetListenPattern(OBJECT_SELF, "**Firsthand**", 6011);
			 SetListenPattern(OBJECT_SELF, "**Secondhand**", 6012);
			 SetListenPattern(OBJECT_SELF, "**Familiar**", 6013);
			 SetListenPattern(OBJECT_SELF, "**Nothing**", 6014);
			 SetListenPattern(OBJECT_SELF, "**Picture**", 6015);
			 SetListenPattern(OBJECT_SELF, "**Possession**", 6016);
			 SetListenPattern(OBJECT_SELF, "**Body**", 6017);
			 	 
		
			 int nListenPattern = 6020;
         	 object oPC = GetFirstPC(FALSE);
			 while ((oPC != OBJECT_INVALID) && (nListenPattern < 6030)) {
				 string sPCName = GetName(oPC);
				 //ActionSpeakString("spawn: " + IntToString(nListenPattern) + " " + sPCName, TALKVOLUME_TALK);
				 SetListenPattern(OBJECT_SELF, "**" + sPCName + "**", nListenPattern);
				 nListenPattern++;
				 oPC = GetNextPC(FALSE);
			 }
			 
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