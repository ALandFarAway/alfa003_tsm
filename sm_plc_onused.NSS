////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ACR Configuration File
//     Filename : acf_plc_onused.nss
//    $Revision:: 183        $ current version of the file
//        $Date:: 2006-12-21#$ date the file was created or modified
//       Author : Ronan
//
//  Local Variable Prefix =
//
//  Dependencies external of nwscript:
//
//  Description
//  This script calls the ACR's OnUsed code for placeables, and any
//  custom code a server may need. It is not updated in ACR updates.
//
//  Revision History
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

#include "acr_placeable_i"
#include "dmfi_inc_langexe" 
#include "acr_quest_i"

void main() {
 

	ACR_PlaceableOnUsed();
	
	
	// Maskarran secret entry Jump AT in the Fochlucan basement
	if(FindSubString(GetTag(OBJECT_SELF), "mask_crate")!= -1) 
		{object oDestination = GetLocalObject(OBJECT_SELF, "oDestination");
		 if(oDestination == OBJECT_INVALID)
		 	{oDestination = GetWaypointByTag(GetTag(OBJECT_SELF) + "_Go");
		 	 SetLocalObject(OBJECT_SELF, "oDestination", oDestination);
			 }
		 if(GetItemPossessedBy(GetLastUsedBy(), "tsm_maskarranshrine_cratekey") != OBJECT_INVALID)
			{SendMessageToPC(GetLastUsedBy(), "Your key unlocks the crate, revealing a tunnel through which you crawl.");
		 	 AssignCommand(GetLastUsedBy(), ActionJumpToLocation(GetLocation(oDestination)));
			}
		 else
		 	{SendMessageToPC(GetLastUsedBy(), "These crates are securely padlocked.");
		 	 }
		}

	// Maskarran secret entry Jump AT in Silvy South
	if(FindSubString(GetTag(OBJECT_SELF), "masktunnel")!= -1) 
		{object oDestination = GetLocalObject(OBJECT_SELF, "oDestination");
		 if(oDestination == OBJECT_INVALID)
		 	{oDestination = GetWaypointByTag("MaskTunnelStatue_ent");
		 	 SetLocalObject(OBJECT_SELF, "oDestination", oDestination);
			 }
		 if(GetItemPossessedBy(GetLastUsedBy(), "tsm_maskarranshrine_cratekey") != OBJECT_INVALID)
			{SendMessageToPC(GetLastUsedBy(), "Your key unlocks the grate, revealing a slanting tunnel through which you drop into the darkness.");
		 	 AssignCommand(GetLastUsedBy(), ActionJumpToLocation(GetLocation(oDestination)));
			}
		 else
		 	{SendMessageToPC(GetLastUsedBy(), "This grate is securely padlocked.");
		 	 }
		}

	//Sylune's Portal Stones in the High Palace and Catacombs_1		
	if(FindSubString(GetTag(OBJECT_SELF), "sm_sylune_listener")!= -1) 
		{string sLang = GetLocalString(OBJECT_SELF, "SJC_PLC_LANG");
		 string sSuccess = GetLocalString(OBJECT_SELF, "SJC_TRANSLATED_TEXT");
		 string sFail = GetLocalString(OBJECT_SELF, "SJC_FAILED_TEXT");
		 object oPC = GetLastUsedBy();
		
		 if (DMFI_IsLanguageKnown(oPC, sLang) == TRUE)
			{SendMessageToPC(oPC, sSuccess);
			}
			else
			{SendMessageToPC(oPC, sFail);
			}
			
		 if(GetLocalInt(OBJECT_SELF, "Active") == 1)
		 	{DelayCommand(60.0, SetLocalInt(OBJECT_SELF, "Active", 0));
			 object oPortalTo = GetLocalObject(OBJECT_SELF, "oPortalTo");
			 if((ACR_RetrieveQuestState("slv_deansphinx_h", oPC) >= 5) && (GetTag(GetArea(OBJECT_SELF)) == "6d_int_silvy_catacombs_1"))
				{object oStormWP = GetLocalObject(OBJECT_SELF, "oStormWP");
			     if(oStormWP == OBJECT_INVALID)
				 	{oStormWP = GetWaypointByTag("storm_sylune_WP");
					 SetLocalObject(OBJECT_SELF, "oStormWP", oStormWP);
					 }
				 if(GetLocalObject(GetModule(), "oStorm") == OBJECT_INVALID)
				 	{object oStorm = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_silverhand_storm", GetLocation(oStormWP));
				 	 SetLocalObject(GetModule(), "oStorm", oStorm);
					 }
				 }
			 AssignCommand(GetLastUsedBy(), ActionJumpToObject(oPortalTo, FALSE));
			 }
		}
	
	// Jump AT in the sewers
	if(FindSubString(GetTag(OBJECT_SELF), "03_plc_sewer")!= -1) 
		{object oDestination = GetWaypointByTag(GetTag(OBJECT_SELF) + "_Go");
		 AssignCommand(GetLastUsedBy(), ActionJumpToLocation(GetLocation(oDestination)));
		}
		
 
	
}