#include "acr_spawn_i"
#include "silvy_univ_inc"
#include "acr_db_persist_i"
#include "silvy_univ_func"
#include "acr_quest_i"
 
void main()
{
	object oTarget = GetItemActivatedTarget();
	int iKneelDown = GetLocalInt(oTarget, "iWandKneelDown");
	if(iKneelDown == 0)
		{SetLocalInt(oTarget, "iWandKneelDown", 1);
		 AssignCommand(oTarget, ActionPlayAnimation(ANIMATION_LOOPING_KNEELIDLE, 1.0, 3600.0));}
	if(iKneelDown == 1)
		{SetLocalInt(oTarget, "iWandKneelDown", 0);
		 AssignCommand(oTarget, ActionPlayAnimation(ANIMATION_FIREFORGET_STANDUP, 1.0, 3600.0));}
					      
   }