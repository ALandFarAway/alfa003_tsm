
//Wynna April 2022


#include "acr_trigger_i"
#include "acr_spawn_i"
#include "acr_tools_i"

void main()
{	
	ACR_TriggerOnEnter();
	object oPC = GetEnteringObject();
	object oArea = GetArea(oPC);
	object oAntipathy = GetNearestObjectByTag("rr_temple_WP", OBJECT_SELF, 1);
    

    if(GetItemPossessedBy(oPC, "abr_it_rng_orbacid") == OBJECT_INVALID)
        {AssignCommand(oPC, ActionMoveToObject(oAntipathy, TRUE, 1.0));
         SendMessageToPC(oPC, "You feel physically repelled from going further.  You are driven back from the doorway.");
        }

}