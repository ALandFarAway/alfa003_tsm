#include "acr_spawn_i"
#include "silvy_univ_inc"
#include "acr_db_persist_i"
#include "silvy_univ_func"
#include "acr_quest_i"
 
void main()
{
	object oTarget = GetItemActivatedTarget();
	int iLieDown = GetLocalInt(oTarget, "iWandLieDown");
	if(iLieDown == 0)
		{SetLocalInt(oTarget, "iWandLieDown", 1);
		 AssignCommand(oTarget, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_BACK, 1.0, 3600.0));}
	if(iLieDown == 1)
		{SetLocalInt(oTarget, "iWandLieDown", 0);
		 AssignCommand(oTarget, ActionPlayAnimation(ANIMATION_FIREFORGET_STANDUP, 1.0, 3600.0));}
					      
   }