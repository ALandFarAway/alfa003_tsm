#include "acr_spawn_i"
#include "silvy_univ_inc"
#include "acr_db_persist_i"
#include "silvy_univ_func"
#include "acr_quest_i"
 
void main()
{
	AssignCommand(OBJECT_SELF, ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectTrueSeeing(),OBJECT_SELF));
         
         
	if(GetTag(OBJECT_SELF)== "003_cr_helm_cyrthol")
        { 	 
         SetListenPattern(OBJECT_SELF, "**Sylune**", 6001);
         }
		
		 
	if(GetTag(OBJECT_SELF)== "003_cr_voice")
        { 	 
         SetListenPattern(OBJECT_SELF, "**Sylune**", 6001);
         SetListenPattern(OBJECT_SELF, "**Alustriel**", 6002);
         SetListenPattern(OBJECT_SELF, "**Dove**", 6003);
         SetListenPattern(OBJECT_SELF, "**Storm**", 6004);
         SetListenPattern(OBJECT_SELF, "**Laeral**", 6005);
         SetListenPattern(OBJECT_SELF, "**Simbul", 6006);
         SetListenPattern(OBJECT_SELF, "**Alassra", 6007);
         SetListenPattern(OBJECT_SELF, "**Qilue**", 6008);
         SetListenPattern(OBJECT_SELF, "**Gone and never lost**", 6009);
         }
		 
		  
	SetListening(OBJECT_SELF, TRUE);
	
          
   }