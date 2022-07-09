//
//  System Name : Scrying
//     Filename : tsm_scry_npc_onperception
//      Version : 0.1
//         Date : 7/8/22
//       Author : Wynna
//
//  Description
//  This script handles perception actions of NPCs used in the scrying system. 
//  This should be in the On Perception Script slot of these creatures: 
//	Invisible Scrying Sender - If it loses sight of its target across an AT, it jumps to said target
//	It is not updated in ACR updates.
//
//  Revision History
////////////////////////////////////////////////////////////////////////////////

//	Wynna - 7/8/2022

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////

#include "acr_creature_i"
#include "acr_scry_i"

 
void main()
{
    ACR_CreatureOnPerception();
	object oPerceived = GetLastPerceived();
	
	/*if((GetTag(OBJECT_SELF)== "003_cr_scry_send") || (GetTag(OBJECT_SELF)== "003_cr_scry_send_xavier")) {
		object oScried = GetLocalObject(OBJECT_SELF, "oScried");
		object oScryer = GetLocalObject(OBJECT_SELF, "oScryer");
		//Check area information about oScried
		object oArea = GetArea(oScried);
		string sSubjectArea = GetName(oArea);
		string sAreaTag = GetTag(oArea);
			//if Scrying Sensor has not ATd but oScried has, make Scrying Sensor jump to oScried
			if(GetArea(OBJECT_SELF) != oArea) {
				ClearAllActions(TRUE);
				ActionJumpToLocation(GetLocation(oScried));
				DelayCommand(5.0, ActionForceFollowObject(oScried, 0.5f, 0));
				DelayCommand(10.0, ActionJumpToLocation(GetLocation(oScried)));
				DelayCommand(15.0, ActionForceFollowObject(oScried, 0.5f, 0));
				}
		//	}
		}*/		
}