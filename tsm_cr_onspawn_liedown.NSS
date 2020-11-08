#include "acr_spawn_i"
#include "silvy_univ_inc"
#include "acr_db_persist_i"
#include "silvy_univ_func"
#include "acr_quest_i"
 
void main()
{
	object oTarget = OBJECT_SELF;
	AssignCommand(oTarget, ActionPlayAnimation(ANIMATION_FIREFORGET_LAYDOWN, 1.0, 200.0));
					      
   }