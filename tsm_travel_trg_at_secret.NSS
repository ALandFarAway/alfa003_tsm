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

//First run a proximity check on party members
	object oPartyMember = GetFirstFactionMember(oTraveller);
	if(GetLocalInt(GetArea(OBJECT_SELF), "ACR_IS_TRAVEL_AREA") !=1)
		{while(oPartyMember != OBJECT_INVALID)
			{if((GetDistanceBetween(oPartyMember, oTraveller) > 20.0) || (GetArea(oTraveller) != GetArea(oPartyMember)))
				{FloatingTextStringOnCreature("You must gather your party together before going on.", oTraveller, TRUE);
				 return;
				}
			oPartyMember = GetNextFactionMember(oTraveller);
			}		
		
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
		
	else if (GetTag(OBJECT_SELF) == "5g_auv_wild_enter")
		{oDestination = GetLocalObject(OBJECT_SELF, "oDestination");
		 if(oDestination == OBJECT_INVALID)
				{oDestination = GetWaypointByTag("TM_Auvendell_Wild_WP");
				 SetLocalObject(OBJECT_SELF, "oDestination", oDestination);
				 }
			
		object oPartyMember = GetFirstFactionMember(oTraveller, TRUE);
		 while (oPartyMember != OBJECT_INVALID)
		 	{if(((GetIsSkillSuccessful(oPartyMember, SKILL_SPOT, 20, FALSE)) && (GetIsSkillSuccessful(oPartyMember, SKILL_SEARCH, 20, FALSE))) || (ACR_RetrieveQuestState("slv_deandragon_d", oPartyMember) > 0))
				{if(GetLocalInt(GetArea(OBJECT_SELF), GetName(OBJECT_SELF)) != 1)
					{SetLocalInt(GetArea(OBJECT_SELF), GetName(OBJECT_SELF), 1);
					 SendMessageToPC(oPartyMember, "You have found a way to clamber around a spur of rock where it had seemed impassable.");
			 		 DelayCommand(5.0, JumpPartyToArea(oTraveller, oDestination));
					 DelayCommand(60.0, SetLocalInt(GetArea(OBJECT_SELF), GetName(OBJECT_SELF), 0));
					 }
				 }
			else if(GetLocalInt(GetArea(OBJECT_SELF), GetName(OBJECT_SELF)) == 1)
				{SendMessageToPC(oPartyMember, "One of your party members has discovered a way to clamber around a spur of rock where it had seemed impassable.");
		 		 }
			oPartyMember = GetNextFactionMember(oTraveller, TRUE);
			}
		}
		
		
	else if (GetTag(OBJECT_SELF) == "TM_Auril")
		{if(GetIsDM(GetEnteringObject()))
			{AssignCommand(oTraveller, ActionJumpToObject(oDestination));}
		else {
		object oPartyMember = GetFirstFactionMember(oTraveller, TRUE);
		 while (oPartyMember != OBJECT_INVALID)
		 	{if((GetIsSkillSuccessful(oPartyMember, SKILL_SPOT, 25, FALSE)) || (GetIsSkillSuccessful(oPartyMember, SKILL_SEARCH, 25, FALSE))|| (GetIsSkillSuccessful(oPartyMember, SKILL_SURVIVAL, 20, FALSE)) || (GetDeity(oPartyMember) == "Auril"))
				{if(GetLocalInt(GetArea(OBJECT_SELF), GetName(OBJECT_SELF)) != 1)
					{SetLocalInt(GetArea(OBJECT_SELF), GetName(OBJECT_SELF), 1);
					 SendMessageToPC(oTraveller, "You have found a way through the snowy chasms to advance where it had seemed impassible.");
			 		 SetCommandable(TRUE, oPartyMember);
		             //AssignCommand(oPartyMember, ActionJumpToObject(oDestination));
					 int iType = 2;
					 object oAssociate = GetAssociate(iType, oPartyMember, 1);
					 while(iType < 4)
						{oAssociate = GetAssociate(iType, oPartyMember, 1);
					 	 if(GetIsObjectValid(oAssociate))
					 			{AssignCommand(oAssociate, ActionJumpToObject(oDestination));
					 			}
					 	 iType++;
					 	}
					 DelayCommand(30.0, SetLocalInt(GetArea(OBJECT_SELF), GetName(OBJECT_SELF), 0));
					 }
				 }
			else if(GetLocalInt(GetArea(OBJECT_SELF), GetName(OBJECT_SELF)) == 1)
				{SendMessageToPC(oPartyMember, "One of your party members has found a way through the snowy chasms to advance where it had seemed impassible.");
		 		 SetCommandable(TRUE, oPartyMember);
		         //AssignCommand(oPartyMember, ActionJumpToObject(oDestination));
				 int iType = 2;
				 object oAssociate = GetAssociate(iType, oPartyMember, 1);
				 while(iType < 4)
					{oAssociate = GetAssociate(iType, oPartyMember, 1);
				 	 if(GetIsObjectValid(oAssociate))
				 			{AssignCommand(oAssociate, ActionJumpToObject(oDestination));
				 			}
				 	 iType++;
				 	}
				}
			 if (GetHasFeat(FEAT_BARDSONG_INSPIRE_COURAGE, oPartyMember)) {
				// bard found- force-deactivate any inspirations, head off crashes
				SetActionMode(oPartyMember, 15, FALSE);
				SetActionMode(oPartyMember, 16, FALSE);	
				SetActionMode(oPartyMember, 17, FALSE);	
				SetActionMode(oPartyMember, 18, FALSE);	
				SetActionMode(oPartyMember, 19, FALSE);	
				SetActionMode(oPartyMember, 20, FALSE);	
				SetActionMode(oPartyMember, 21, FALSE);	
			 }	
			oPartyMember = GetNextFactionMember(oTraveller, TRUE);
			}
			WriteTimestampedLogEntry(GetName(oPartyMember) + " ATing via TSM_TRAVEL_TRG_AT_SECRET.NSS through " + GetName(OBJECT_SELF) + " to " + GetName(oDestination) + " with " + GetName(oTraveller) + " as party leader.");
			JumpPartyToArea(oTraveller, oDestination);
		}
	}
		
		
	else if (GetTag(OBJECT_SELF) == "TM_Delzoun")
		{object oPartyMember = GetFirstFactionMember(oTraveller, TRUE);
		 while (oPartyMember != OBJECT_INVALID)
		 	{if(((GetIsSkillSuccessful(oPartyMember, SKILL_SPOT, 25, FALSE)) || (GetIsSkillSuccessful(oPartyMember, SKILL_SEARCH, 25, FALSE))) || (GetRacialType(oPartyMember) == RACIAL_TYPE_DWARF))
				{if(GetLocalInt(GetArea(OBJECT_SELF), GetName(OBJECT_SELF)) != 1)
					{SetLocalInt(GetArea(OBJECT_SELF), GetName(OBJECT_SELF), 1);
					 SendMessageToPC(oPartyMember, "You have found a way down through a ravine to an ancient bridge that leads to a cliffside ruin.");
			 		 SetCommandable(TRUE, oPartyMember);
		             //AssignCommand(oPartyMember, ActionJumpToObject(oDestination));
					 int iType = 2;
					 object oAssociate = GetAssociate(iType, oPartyMember, 1);
					 while(iType < 4)
						{oAssociate = GetAssociate(iType, oPartyMember, 1);
					 	 if(GetIsObjectValid(oAssociate))
					 			{AssignCommand(oAssociate, ActionJumpToObject(oDestination));
					 			}
					 	 iType++;
					 	}
					 DelayCommand(60.0, SetLocalInt(GetArea(OBJECT_SELF), GetName(OBJECT_SELF), 0));
					 }
				 }
			else if(GetLocalInt(GetArea(OBJECT_SELF), GetName(OBJECT_SELF)) == 1)
				{SendMessageToPC(oPartyMember, "One of your party members has discovered a way down through a ravine to an ancient bridge that leads to a cliffside ruin.");
		 		 SetCommandable(TRUE, oPartyMember);
		         //AssignCommand(oPartyMember, ActionJumpToObject(oDestination));
					 int iType = 2;
					 object oAssociate = GetAssociate(iType, oPartyMember, 1);
					 while(iType < 4)
						{oAssociate = GetAssociate(iType, oPartyMember, 1);
					 	 if(GetIsObjectValid(oAssociate))
					 			{AssignCommand(oAssociate, ActionJumpToObject(oDestination));
					 			}
					 	 iType++;
					 	}
					 }
				if (GetHasFeat(FEAT_BARDSONG_INSPIRE_COURAGE, oPartyMember)) {
		 			// bard found- force-deactivate any inspirations, head off crashes
					SetActionMode(oPartyMember, 15, FALSE);
					SetActionMode(oPartyMember, 16, FALSE);	
					SetActionMode(oPartyMember, 17, FALSE);	
					SetActionMode(oPartyMember, 18, FALSE);	
					SetActionMode(oPartyMember, 19, FALSE);	
					SetActionMode(oPartyMember, 20, FALSE);	
					SetActionMode(oPartyMember, 21, FALSE);	
				 }	
			oPartyMember = GetNextFactionMember(oTraveller, TRUE);
			}
			WriteTimestampedLogEntry(GetName(oPartyMember) + " ATing via TSM_TRAVEL_TRG_AT_SECRET.NSS through " + GetName(OBJECT_SELF) + " to " + GetName(oDestination) + " with " + GetName(oTraveller) + " as party leader.");
			JumpPartyToArea(oTraveller, oDestination);
		}
		
		
	else if (GetTag(OBJECT_SELF) == "TM_Silvypass_North")
		{object oPartyMember = GetFirstFactionMember(oTraveller, TRUE);
		 while (oPartyMember != OBJECT_INVALID)
		 	{if(((GetIsSkillSuccessful(oPartyMember, SKILL_SPOT, 25, FALSE)) || (GetIsSkillSuccessful(oPartyMember, SKILL_SEARCH, 25, FALSE)))|| (GetRacialType(oPartyMember) == RACIAL_TYPE_DWARF))
				{if(GetLocalInt(GetArea(OBJECT_SELF), GetName(OBJECT_SELF)) != 1)
					{SetLocalInt(GetArea(OBJECT_SELF), GetName(OBJECT_SELF), 1);
					 SendMessageToPC(oPartyMember, "You have found a way into a hidden valley.");
			 		 SetCommandable(TRUE, oPartyMember);
		             //AssignCommand(oPartyMember, ActionJumpToObject(oDestination));
					 int iType = 2;
					 object oAssociate = GetAssociate(iType, oPartyMember, 1);
					 while(iType < 4)
						{oAssociate = GetAssociate(iType, oPartyMember, 1);
					 	 if(GetIsObjectValid(oAssociate))
					 			{AssignCommand(oAssociate, ActionJumpToObject(oDestination));
					 			}
					 	 iType++;
					 	}
					 DelayCommand(60.0, SetLocalInt(GetArea(OBJECT_SELF), GetName(OBJECT_SELF), 0));
					 }
				 }
			else if(GetLocalInt(GetArea(OBJECT_SELF), GetName(OBJECT_SELF)) == 1)
				{SendMessageToPC(oPartyMember, "One of your party members has discovered a way into a hidden valley.");
		 		 SetCommandable(TRUE, oPartyMember);
		         AssignCommand(oPartyMember, ActionJumpToObject(oDestination));
					 int iType = 2;
					 object oAssociate = GetAssociate(iType, oPartyMember, 1);
					 while(iType < 4)
						{oAssociate = GetAssociate(iType, oPartyMember, 1);
					 	 if(GetIsObjectValid(oAssociate))
					 			{AssignCommand(oAssociate, ActionJumpToObject(oDestination));
					 			}
					 	 iType++;
					 	}
					 }
					if (GetHasFeat(FEAT_BARDSONG_INSPIRE_COURAGE, oPartyMember)) {
		 				// bard found- force-deactivate any inspirations, head off crashes
						SetActionMode(oPartyMember, 15, FALSE);
						SetActionMode(oPartyMember, 16, FALSE);	
						SetActionMode(oPartyMember, 17, FALSE);	
						SetActionMode(oPartyMember, 18, FALSE);	
						SetActionMode(oPartyMember, 19, FALSE);	
						SetActionMode(oPartyMember, 20, FALSE);	
						SetActionMode(oPartyMember, 21, FALSE);	
					 }	
			oPartyMember = GetNextFactionMember(oTraveller, TRUE);
			}
			WriteTimestampedLogEntry(GetName(oPartyMember) + " ATing via TSM_TRAVEL_TRG_AT_SECRET.NSS through " + GetName(OBJECT_SELF) + " to " + GetName(oDestination) + " with " + GetName(oTraveller) + " as party leader.");
			JumpPartyToArea(oTraveller, oDestination);
		}
		
}