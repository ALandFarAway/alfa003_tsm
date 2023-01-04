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
//  2007/01/20  Cipher  Inception
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

    // Custom code goes here.
	object oEnterer = GetEnteringObject();

 if(GetTag(OBJECT_SELF) == "tsm_trg_faction_hostile")
	{if((!GetIsPC(oEnterer)) && (!GetIsPossessedFamiliar(oEnterer)) && (!GetIsOwnedByPlayer(oEnterer))) {
			ChangeToStandardFaction (oEnterer, STANDARD_FACTION_HOSTILE);
			}
	 if((GetIsDMPossessed(oEnterer)) || (GetIsPC(oEnterer)) || (GetIsPossessedFamiliar(oEnterer))) {
	 	SendMessageToAllDMs(GetName(oEnterer) + " entered " + GetTag(OBJECT_SELF));
		//SendMessageToPC(oEnterer, GetName(oEnterer) + " entered " + GetTag(OBJECT_SELF));
		object oNPC = GetFirstObjectInShape(SHAPE_SPHERE, 20.0, GetLocation(oEnterer), TRUE, OBJECT_TYPE_CREATURE);
	 	while (oNPC != OBJECT_INVALID) {
			SendMessageToAllDMs("oNPC = " + GetName(oNPC));
		    //SendMessageToPC(oEnterer, "oNPC = " + GetName(oNPC));
		    if((!GetIsPC(oNPC)) && (!GetIsPossessedFamiliar(oNPC)) && (!GetIsOwnedByPlayer(oNPC)))
				{SendMessageToAllDMs("Setting " + GetName(oNPC) + " to hostile");
			     //SendMessageToPC(oEnterer, "Setting " + GetName(oNPC) + " to hostile");
			     ChangeToStandardFaction (oNPC, STANDARD_FACTION_HOSTILE);
				}
			oNPC = GetNextObjectInShape(SHAPE_SPHERE, 10.0, GetLocation(oEnterer), TRUE, OBJECT_TYPE_CREATURE);
	 		}
		}
	  }

 if(GetTag(OBJECT_SELF) == "tsm_trg_faction_common")
	{if((!GetIsPC(oEnterer)) && (!GetIsPossessedFamiliar(oEnterer)) && (!GetIsOwnedByPlayer(oEnterer))) {
			ChangeToStandardFaction (oEnterer, STANDARD_FACTION_COMMONER);
			}
	if((GetIsDMPossessed(oEnterer)) || (GetIsPC(oEnterer)) || (GetIsPossessedFamiliar(oEnterer))) {
	 	object oNPC = GetFirstObjectInShape(SHAPE_SPHERE, 20.0, GetLocation(oEnterer), TRUE, OBJECT_TYPE_CREATURE);
	 	while (oNPC != OBJECT_INVALID) {
			if((!GetIsPC(oNPC)) && (!GetIsPossessedFamiliar(oNPC)) && (!GetIsOwnedByPlayer(oNPC)))
				{ChangeToStandardFaction (oNPC, STANDARD_FACTION_COMMONER);
				}
			oNPC = GetNextObjectInShape(SHAPE_SPHERE, 20.0, GetLocation(oEnterer), TRUE, OBJECT_TYPE_CREATURE);
	 		}
		}
		}
 if(GetTag(OBJECT_SELF) == "tsm_trg_faction_defender")
	{if((!GetIsPC(oEnterer)) && (!GetIsPossessedFamiliar(oEnterer)) && (!GetIsOwnedByPlayer(oEnterer))) {
			ChangeToStandardFaction (oEnterer, STANDARD_FACTION_DEFENDER);
			}
			
	 if((GetIsDMPossessed(oEnterer)) || (GetIsPC(oEnterer)) || (GetIsPossessedFamiliar(oEnterer))) {
	 	object oNPC = GetFirstObjectInShape(SHAPE_SPHERE, 20.0, GetLocation(oEnterer), TRUE, OBJECT_TYPE_CREATURE);
	 	while (oNPC != OBJECT_INVALID) {
			if((!GetIsPC(oNPC)) && (!GetIsPossessedFamiliar(oNPC)) && (!GetIsOwnedByPlayer(oNPC)))
				{ChangeToStandardFaction (oNPC, STANDARD_FACTION_DEFENDER);
				}
			oNPC = GetNextObjectInShape(SHAPE_SPHERE, 20.0, GetLocation(oEnterer), TRUE, OBJECT_TYPE_CREATURE);
	 		}
		}
		}
	   
}