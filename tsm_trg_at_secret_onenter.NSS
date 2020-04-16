////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ACR Configuration File
//     Filename : acf_trg_onenter.nss
//    $Revision:: 236        $ current version of the file
//        $Date:: 2007-01-21#$ date the file was created or modified
//       Author : Cipher
//
//    Var Prefix:
//  Dependencies:
//
//  Description
//  This script calls the ACR's OnEnter code for triggers, and any
//  custom code a server may need. It is not updated in ACR updates.
//
//  Revision History
//  2009/08/6  Wynna
//  2010/9/22  AcadiusLost - Bardsong disable
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#include "acr_trigger_i"
#include "acr_quest_i"
#include "acr_spawn_i"



////////////////////////////////////////////////////////////////////////////////
// Constants ///////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Structures //////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Global Variables ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Function Prototypes /////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Function Definitions ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////


void main()
{
    ACR_TriggerOnEnter();

    // ATing out of or into Travel Map areas
	object oTraveller = GetEnteringObject();
    object oDestination = GetLocalObject(OBJECT_SELF, "oDestination");
	if(oDestination == OBJECT_INVALID)
		{string sDestination = GetLocalString(OBJECT_SELF, "sDestination");
	     oDestination = GetWaypointByTag(sDestination);
		 SetLocalObject(OBJECT_SELF, "oDestination", oDestination);
		 }
		 
			 	 
	if((!GetIsPC(oTraveller)) && (!GetIsDM(oTraveller))&& (!GetIsOwnedByPlayer(oTraveller))) 
	   {DestroyObject(oTraveller);
	    return;
	   }
		
	//ATing into secret areas
	
			
	if(GetTag(OBJECT_SELF) == "TM_Holdfast") 
		{object oPartyMember = GetFirstFactionMember(oTraveller, TRUE);
		 while (oPartyMember != OBJECT_INVALID)
		 	{if(((GetIsSkillSuccessful(oPartyMember, SKILL_SPOT, 25, FALSE)) && (GetIsSkillSuccessful(oPartyMember, SKILL_SEARCH, 25, FALSE)))  || (GetLevelByClass(CLASS_TYPE_HARPER, oPartyMember) > 0) || (GetIsDM(oTraveller)))
				{if(GetLocalInt(GetArea(OBJECT_SELF), "HoldfastPLC") != 1)
					{object oHoldfastWP = GetLocalObject(OBJECT_SELF, "holdfast_plc_wp");
		             if(oHoldfastWP == OBJECT_INVALID)
					 	{oHoldfastWP = GetWaypointByTag("holdfast_plc_wp");
						 SetLocalObject(OBJECT_SELF, "holdfast_plc_wp", oHoldfastWP);
						 }
					 CreateObject(OBJECT_TYPE_PLACEABLE, "003_holdfast_plc", GetLocation(oHoldfastWP), FALSE);
				 	 SetLocalInt(GetArea(OBJECT_SELF), "HoldfastPLC", 1);
					 DelayCommand(60.0, SetLocalInt(GetArea(OBJECT_SELF), "HoldfastPLC", 0));
					 }
				 SendMessageToPC(oPartyMember, "You come across a well-hidden stone door, concealed in the cliff. The door swings open at a touch.");
		 		 }
			else if(GetLocalInt(GetArea(OBJECT_SELF), "HoldfastPLC") == 1)
				{SendMessageToPC(oPartyMember, "One of your party members has discovered awell-hidden stone door, concealed in the cliff. The door swings open at a touch.");
		 		 }
			oPartyMember = GetNextFactionMember(oTraveller, TRUE);
			}
		}
	
		else {AssignCommand(oTraveller, ActionJumpToLocation(GetLocation(oDestination)));
			}	

		
}