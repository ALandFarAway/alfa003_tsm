//High Forest Trigger OnExit
//Wynna August 2020


#include "acr_trigger_i"
#include "acr_spawn_i"
#include "acr_tools_i"

void main()
{
	ACR_TriggerOnExit();
    object oArea = GetArea(OBJECT_SELF);
	object oCorraled = GetExitingObject();
    	
	
	
// Corrals creatures with the LocalInt ALFA_Corral set to 1 never leave the designated trigger with this script. Place a Corral Containment Trigger around the space you want them to stay in, and place a Corral_Area_Center_WP (from ALFA_Systems waypoints) where you want them to return towards if they try to exit.

	if(GetTag(OBJECT_SELF) == "tsm_trg_corral_creature")
		{if(GetLocalObject(OBJECT_SELF, "Center") == OBJECT_INVALID)
			{SetLocalObject(OBJECT_SELF, "Center", GetNearestObjectByTag("Corral_Area_Center_WP", OBJECT_SELF));
			}
			{}
		 if(GetLocalInt(oCorraled, "ALFA_Corral")==1)
			{object oCenter = GetLocalObject(OBJECT_SELF, "Center");
		 	 location lInward = GetLocation(oCenter);
		 	 AssignCommand(oCorraled, ClearAllActions(TRUE));
			 DelayCommand(2.0, AssignCommand(oCorraled, ActionForceMoveToLocation(lInward, TRUE, 15.0)));
			 DelayCommand(20.0, AssignCommand(oCorraled, ActionRandomWalk()));
			 
			 }
		}
		

									
}