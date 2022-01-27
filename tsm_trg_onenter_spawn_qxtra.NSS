////////////////////////////////////////////////////////////////////////////////
//Wynna 1/23/2022
//
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

void ActionCreateCreature(string sCreature, location lLocPlace)
{
    CreateObject(OBJECT_TYPE_CREATURE, sCreature, lLocPlace, FALSE);
}

void main()
{
    ACR_TriggerOnEnter();

 // Custom code goes here.
 object oPC;
 if(GetIsPC(GetEnteringObject())) {
 	oPC = GetEnteringObject();
 }
						 
 if(GetLocalInt(OBJECT_SELF, "RUN_ONCE" + GetName(oPC)) == 0)
	{string sQuest = GetLocalString(OBJECT_SELF, "ACR_SPAWN_QUEST");
	 int nLowerState = GetLocalInt(OBJECT_SELF, "ACR_QST_LOWER_STATE");
	 int nUpperState = GetLocalInt(OBJECT_SELF, "ACR_QST_UPPER_STATE");
	 int nRandom = Random(100) +1;
	 SendMessageToPC(oPC,"nRandom = " + IntToString(nRandom));
	 if((ACR_RetrieveQuestState(sQuest, oPC) >= nLowerState)&& (ACR_RetrieveQuestState(sQuest, oPC) < nUpperState)) {
		 int nPercentChance = GetLocalInt(OBJECT_SELF, "ACR_SPAWN_CHANCE");
		 if(nRandom < nPercentChance) {
			 string sMessage=GetLocalString(OBJECT_SELF, "ACR_SPAWN_MESSAGE");
			 float fDelaySpawnOne = GetLocalFloat(OBJECT_SELF, "ACR_SPAWN_DELAY");
			 float fDelaySpawnTwo = GetLocalFloat(OBJECT_SELF, "ACR_SPAWN_DELAY_TWO");
			 
			 int nSpawnType = GetLocalInt(OBJECT_SELF, "ACR_SPAWN_TYPE");
			 string sSpawn = GetLocalString(OBJECT_SELF, "ACR_SPAWN_RESREF");
			 int nSpawnNumber = GetLocalInt(OBJECT_SELF, "ACR_SPAWN_NUMBER");
			 string sSpawnWP = GetLocalString(OBJECT_SELF, "ACR_SPAWN_WP");
			 object oSpawnWP = GetNearestObjectByTag(sSpawnWP, OBJECT_SELF, 1);
			 location lSpawnWP = GetLocation(oSpawnWP);
				 
			 int nSpawnTypeTwo = GetLocalInt(OBJECT_SELF, "ACR_SPAWN_TYPE_TWO");
			 string sSpawnTwo = GetLocalString(OBJECT_SELF, "ACR_SPAWN_RESREF_TWO");
			 int nSpawnNumberTwo = GetLocalInt(OBJECT_SELF, "ACR_SPAWN_NUMBER_TWO");
			 string sSpawnWPTwo = GetLocalString(OBJECT_SELF, "ACR_SPAWN_WP_TWO");
			 object oSpawnWPTwo = GetNearestObjectByTag(sSpawnWPTwo, OBJECT_SELF, 1);
			 location lSpawnWPTwo = GetLocation(oSpawnWPTwo);
			 
			 SendMessageToPC(oPC, sMessage);
					
			 if((nSpawnNumber > 0) && (sSpawn != "")) {
					DelayCommand(fDelaySpawnOne, ActionCreateCreature(sSpawn, lSpawnWP)); 
					SendMessageToPC(oPC, "oSpawnOne");
					if(nSpawnNumber > 1) 
							{DelayCommand(fDelaySpawnOne, ActionCreateCreature(sSpawn, lSpawnWP));}
					if((nSpawnNumber > 2) && (Random(2) == 1))
							{DelayCommand(fDelaySpawnOne, ActionCreateCreature(sSpawn, lSpawnWP));}
					if((nSpawnNumber > 3) && (Random(2) == 1))
							{DelayCommand(fDelaySpawnOne, ActionCreateCreature(sSpawn, lSpawnWP));}
					if((nSpawnNumber > 4) && (Random(2) == 1))
							{DelayCommand(fDelaySpawnOne, ActionCreateCreature(sSpawn, lSpawnWP));}
					}
					
			 if((nSpawnNumberTwo > 0) && (sSpawnTwo != "")) {
					DelayCommand(fDelaySpawnOne, ActionCreateCreature(sSpawnTwo, lSpawnWP)); 
					if(nSpawnNumberTwo > 1) 
							{DelayCommand(fDelaySpawnTwo, ActionCreateCreature(sSpawnTwo, lSpawnWP));}
					if((nSpawnNumberTwo > 2)&& (Random(2) == 1))
							{DelayCommand(fDelaySpawnTwo, ActionCreateCreature(sSpawnTwo, lSpawnWP));}
					if((nSpawnNumberTwo > 3) && (Random(2) == 1))
							{DelayCommand(fDelaySpawnTwo, ActionCreateCreature(sSpawnTwo, lSpawnWP));}
					if((nSpawnNumberTwo > 4) && (Random(2) == 1))
							{DelayCommand(fDelaySpawnTwo, ActionCreateCreature(sSpawnTwo, lSpawnWP));}
					}
					
			 SetLocalInt(OBJECT_SELF, "RUN_ONCE" + GetName(oPC), 1);
			}			 
		}	  
	} 
}