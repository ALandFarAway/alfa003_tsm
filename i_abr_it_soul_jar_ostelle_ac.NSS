
#include "acr_spawn_i"
#include "acr_db_persist_i"

void main()
{
             
//OnActivate Script for plot item Ostelle's soul jar for Wynna's Dean Sphinx quest of 2022
    object oUser = GetItemActivator();
	object oTarget = GetItemActivatedTarget();
    location lTarget = GetLocation(oTarget);
    location lCreate = GetItemActivatedTargetLocation();
         
    object oCreate = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_slv_profnec", lCreate, FALSE);
	//DelayCommand(5.0, AssignCommand(oCreate, ActionForceFollowObject(oUser, 2.0))); 		 
	DelayCommand(6.0, AddHenchman(oUser, oCreate));	  
}