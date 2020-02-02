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
	
object oQuester=GetEnteringObject();
object oPC=GetEnteringObject();
//Rivermoot Exterior one-liner scripts.
 if(GetTag(OBJECT_SELF) == "rm_swordrock")
 	{SendMessageToPC(GetEnteringObject(), "This rock is a monument to the dead, roughly chiselled with the names of fallen warriors.");}

  if((GetTag(OBJECT_SELF) == "wyvernmessage") && (GetLocalInt(GetEnteringObject(), "wyvern") != 1))
	{SendMessageToPC(GetEnteringObject(), "It looks as if the kobolds tried to erect a barricade here, and failed. Smashed wood and stone litter the ground.");
	 SetLocalInt(GetEnteringObject(), "wyvern", 1);
	}

 if(GetTag(OBJECT_SELF) == "rm_scout_05_01_trig") 
 	{if(ACR_RetrieveQuestState("rm_scout_05", oQuester) == 1)
		{SendMessageToPC(oQuester, "You can see the padlock on the crypts, solidly and reassuringly locked tight. This vantage completes the view from the southeast corner. Scout the other corners.");
	 	 ACR_AddPersistentJournalQuestEntry("rm_scout_05", 2, GetEnteringObject(), FALSE, FALSE, FALSE, FALSE);
		 }
	}
		
 if((GetTag(OBJECT_SELF) == "rm_scout_05_trig") && (GetIsPC(oQuester)) && (GetLocalInt(OBJECT_SELF, "Triggered") !=1))
 	{SetLocalInt(OBJECT_SELF, "Triggered", 1);
	if(ACR_RetrieveQuestState("rm_scout_05", oQuester) == 2)
		{SendMessageToPC(oQuester, "You have scouted the first corner of the Wendover Crypts grounds.");
	 	 ACR_AddPersistentJournalQuestEntry("rm_scout_05", 3, GetEnteringObject(), FALSE, FALSE, FALSE, FALSE);
		 }
	else if(ACR_RetrieveQuestState("rm_scout_05", oQuester) == 3)
		{SendMessageToPC(oQuester, "You have scouted the second corner of the Wendover Crypts grounds.");
	 	 ACR_AddPersistentJournalQuestEntry("rm_scout_05", 4, GetEnteringObject(), FALSE, FALSE, FALSE, FALSE);
		 }
	else if(ACR_RetrieveQuestState("rm_scout_05", oQuester) == 4)
		{SendMessageToPC(oQuester, "You have scouted the last corner of the Wendover Crypts grounds. Return to Kadalion.");
	 	 ACR_AddPersistentJournalQuestEntry("rm_scout_05", 5, GetEnteringObject(), FALSE, FALSE, FALSE, FALSE);
		 }
		 
	int nSpawnChance=Random(100);
	if(nSpawnChance<50)
		{if(GetLocalInt(GetArea(OBJECT_SELF), "nSpawned")==0)
			{SetLocalInt(GetArea(OBJECT_SELF), "nSpawned", 1);
			 int nInc=1;
			 for(nInc=1; nInc<10; nInc++)
				{object oUndeadSpawn = GetObjectByTag("wc_undead_create_wp", nInc);
				 if(oUndeadSpawn != OBJECT_INVALID)
					{int nRandom = Random(100)+1;
					 if(nRandom < 33)
					 	{CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_un_zombie02", GetLocation(oUndeadSpawn));
						 SendMessageToPC(oQuester, "The dead rise!");
					     }
					}	
				}	
			}
		}
	}

 if((GetTag(OBJECT_SELF) == "rm_wands_cave_pool_trigger") && (GetLocalInt(oPC, "rm_wands_pool_msg")))
 	{SetLocalInt(oPC, "rm_wands_pool_msg", 1);
	 DelayCommand(3600.0, SetLocalInt(oPC, "rm_wands_pool_msg", 0));
	 SendMessageToPC(GetEnteringObject(), "The surface of the pool is covered in scum and floating mats of cave vegetation, rocking gently. There appears to be a hole in the bottom of the pool, and at least the beginnings of a passage. Diving in to explore will mean swimming, for an unknown amount of time. To attempt it, lower yourself in with the rocking handhold.");
	 }

	
}