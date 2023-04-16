#include "acr_spawn_i"
#include "silvy_univ_inc"
#include "acr_db_persist_i"
#include "silvy_univ_func"
#include "acr_quest_i"
 
void main()
{
	object oTarget = OBJECT_SELF;
	effect eKnockdown = EffectKnockdown();
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnockdown, OBJECT_SELF, 60000.0);
		 
	 				      
   }