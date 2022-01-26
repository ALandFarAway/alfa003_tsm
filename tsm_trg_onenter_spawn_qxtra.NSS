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


void main()
{
    ACR_TriggerOnEnter();

 // Custom code goes here.
 object oPC = GetEnteringObject();
 if(GetLocalInt(OBJECT_SELF, "RUN_ONCE" + GetName(oPC)) == 1) {
	oPC = GetLocalObject(OBJECT_SELF, "oPC");
 }
	 
 if((GetTag(OBJECT_SELF) == "tsm_trg_onenter_spawn_qxtra") && (GetIsPC(oPC)) && (GetLocalInt(OBJECT_SELF, "RUN_ONCE" + GetName(oPC)) != 2))
	{string sQuest = GetLocalString(OBJECT_SELF, "ACR_SPAWN_QUEST");
	 int nLowerState = GetLocalInt(OBJECT_SELF, "ACR_QST_LOWER_STATE");
	 int nUpperState = GetLocalInt(OBJECT_SELF, "ACR_QST_UPPER_STATE");
	 int nRunOnce = GetLocalInt(OBJECT_SELF, "RUN_ONCE" + GetName(oPC));
	 int nRandom = Random(100) +1;
	 //SendMessageToPC(oPC,"nRandom = " + IntToString(nRandom));
	 if((ACR_RetrieveQuestState(sQuest, oPC) >= nLowerState)&& (ACR_RetrieveQuestState(sQuest, oPC) < nUpperState)) {
		 int nPercentChance = GetLocalInt(OBJECT_SELF, "ACR_SPAWN_CHANCE");
		 if((nRunOnce == 0) && (nRandom > nPercentChance)) {
			 SetLocalInt(OBJECT_SELF, "RUN_ONCE" + GetName(oPC), 2);
			 DelayCommand(3600.0, SetLocalInt(OBJECT_SELF, "RUN_ONCE" + GetName(oPC), 0));
			}
		 else {
			 string sMessage=GetLocalString(OBJECT_SELF, "ACR_SPAWN_MESSAGE");
			 float fDelaySpawnOne = GetLocalFloat(OBJECT_SELF, "ACR_SPAWN_DELAY");
			 
			 if(nRunOnce == 1) {
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
				 if((nSpawnNumber > 0) && (sSpawn != "")) {
						object oSpawnOne = CreateObject(nSpawnType, sSpawn, lSpawnWP); 
						if(nSpawnNumber > 1) 
							{object oSpawnOneB = CreateObject(nSpawnType, sSpawn, lSpawnWP);
							 }
						if((nSpawnNumber > 2) && (Random(2) == 1))
							{object oSpawnOneC = CreateObject(nSpawnType, sSpawn, lSpawnWP);
							 }
						if((nSpawnNumber > 3) && (Random(2) == 1))
							{object oSpawnOneD = CreateObject(nSpawnType, sSpawn, lSpawnWP);
							}
						if((nSpawnNumber > 4) && (Random(2) == 1))
							{object oSpawnOneE = CreateObject(nSpawnType, sSpawn, lSpawnWP);
							}
						}
					
				  if((nSpawnNumberTwo > 0) && (sSpawnTwo != "")) {
						object oSpawnTwo = CreateObject(nSpawnTypeTwo, sSpawnTwo, lSpawnWPTwo); 
					    if(nSpawnNumberTwo > 1) 
							{object oSpawnTwoB = CreateObject(nSpawnTypeTwo, sSpawnTwo, lSpawnWPTwo);
						}
						if((nSpawnNumberTwo > 2)&& (Random(2) == 1))
							{object oSpawnTwoC = CreateObject(nSpawnTypeTwo, sSpawnTwo, lSpawnWPTwo);
							}
						if((nSpawnNumberTwo > 3) && (Random(2) == 1))
							{object oSpawnTwoD = CreateObject(nSpawnTypeTwo, sSpawnTwo, lSpawnWPTwo);
							 }
						if((nSpawnNumberTwo > 4) && (Random(2) == 1))
							{object oSpawnTwoE = CreateObject(nSpawnTypeTwo, sSpawnTwo, lSpawnWPTwo);
							}
				
						}
					
					SetLocalInt(OBJECT_SELF, "RUN_ONCE" + GetName(oPC), 2);
					}
				
				if(nRunOnce == 0) {
					SendMessageToPC(oPC, sMessage);
					SetLocalInt(OBJECT_SELF, "RUN_ONCE" + GetName(oPC), 1);
					SetLocalObject(OBJECT_SELF, "oPC", oPC);
					DelayCommand(fDelaySpawnOne, ExecuteScript("tsm_trg_onenter_spawn_qxtra", OBJECT_SELF));
					}			 
				 } 
		}
	} 
}