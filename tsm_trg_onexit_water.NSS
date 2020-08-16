//High Forest Trigger OnExit
//Wynna August 2020


#include "acr_trigger_i"
#include "acr_spawn_i"
#include "acr_tools_i"

void main()
{
	ACR_TriggerOnExit();
    object oArea = GetArea(OBJECT_SELF);
	object oSwimmer = GetExitingObject();
    	
	
	
// Swimming creatures with the LocalInt ACR_CREATURE_AQUATIC set to 1 never leave the designated water with this script. Place a Swimming Containment Trigger (from ALFA_Swimming triggers) around the water you want them to stay in, and place a Swim_Area_Center_WP (from ALFA_Systems waypoints) where you want them to return towards if they try to exit.

	if(GetTag(OBJECT_SELF) == "tsm_trg_swim_creature")
		{if(GetLocalObject(OBJECT_SELF, "Center") == OBJECT_INVALID)
			{SetLocalObject(OBJECT_SELF, "Center", GetNearestObjectByTag("Swim_Area_Center_WP", OBJECT_SELF));
			}
			{}
		 if(GetLocalInt(oSwimmer, "ACR_CREATURE_AQUATIC")==1)
			{object oCenter = GetLocalObject(OBJECT_SELF, "Center");
		 	 location lInward = GetLocation(oCenter);
		 	 AssignCommand(oSwimmer, ClearAllActions(TRUE));
			 DelayCommand(2.0, AssignCommand(oSwimmer, ActionForceMoveToLocation(lInward, TRUE, 15.0)));
			 DelayCommand(20.0, AssignCommand(oSwimmer, ActionRandomWalk()));
			 
			 }
		}
		

									
}