#include "acr_spawn_i"
#include "silvy_univ_inc"
#include "acr_db_persist_i"
#include "silvy_univ_func"
#include "acr_quest_i"
 
void main()
{
	object oTarget = GetItemActivatedTarget();
	int iSitDown = GetLocalInt(oTarget, "iWandSitDown");
	if(iSitDown == 0)
		{SetLocalInt(oTarget, "iWandSitDown", 1);
		 AssignCommand(oTarget, ActionPlayAnimation(ANIMATION_LOOPING_SIT_CROSS, 1.0, 3600.0));}
	else if(iSitDown == 1)
		{SetLocalInt(oTarget, "iWandSitDown", 0);
		 AssignCommand(oTarget, ActionPlayAnimation(ANIMATION_FIREFORGET_STANDUP, 1.0, 3600.0));}
						      
   }