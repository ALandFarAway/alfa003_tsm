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
	//SendMessageToPC(oPC, GetTag(OBJECT_SELF) + " triggered");
	 
 if((GetTag(OBJECT_SELF) == "tsm_trg_onenter_spawn_qxtra") && (GetIsPC(oPC)) && (GetLocalInt(OBJECT_SELF, "RUN_ONCE") != 2))
	{string sQuest = GetLocalString(OBJECT_SELF, "ACR_SPAWN_QUEST");
	 int nLowerState = GetLocalInt(OBJECT_SELF, "ACR_QST_LOWER_STATE");
	 int nUpperState = GetLocalInt(OBJECT_SELF, "ACR_QST_UPPER_STATE");
	 int nRunOnce = GetLocalInt(OBJECT_SELF, "RUN_ONCE");
	 //SendMessageToPC(oPC, sQuest + " " + IntToString(nRunOnce));
	 int nRandom = Random(100) +1;
	 //SendMessageToPC(oPC,"nRandom = " + IntToString(nRandom));
	 if((ACR_RetrieveQuestState(sQuest, oPC) >= nLowerState)&& (ACR_RetrieveQuestState(sQuest, oPC) < nUpperState)) {
		 //SendMessageToPC(oPC, "Quest State = " + IntToString(ACR_RetrieveQuestState(sQuest, oPC)));
	     int nPercentChance = GetLocalInt(OBJECT_SELF, "ACR_SPAWN_CHANCE");
		 if(nRandom > nPercentChance) {
			 SetLocalInt(OBJECT_SELF, "RUN_ONCE", 2);
			// SendMessageToPC(oPC, "nRandom greater than nPercent Chance. RUN_ONCE Now 2");
	 		 DelayCommand(3600.0, SetLocalInt(OBJECT_SELF, "RUN_ONCE", 0));
			}
		 else {
			 string sMessage=GetLocalString(OBJECT_SELF, "ACR_SPAWN_MESSAGE");
			 //SendMessageToPC(oPC, "nRandom less than nPercent Chance. Firing.");
	 		 
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
			 
			 float fDelaySpawnOne = GetLocalFloat(OBJECT_SELF, "ACR_SPAWN_DELAY");
			 float fDelaySpawnTwo = GetLocalFloat(OBJECT_SELF, "ACR_SPAWN_DELAY_TWO");
			//float fDelayVFXOne = GetLocalFloat(OBJECT_SELF, "ACR_VFX_DELAY");
			 //float fDelayVFXTwo = GetLocalFloat(OBJECT_SELF, "ACR_VFX_DELAY_TWO");
			 
			 //int nVFX = GetLocalInt(OBJECT_SELF, "ACR_SPAWN_VFX");
			// int nVFXTwo = GetLocalInt(OBJECT_SELF, "ACR_SPAWN_VFX_TWO");
			 //effect eOne = EffectVisualEffect(nVFX);
		    //effect eTwo = EffectVisualEffect(nVFXTwo);
			 //int nDurationType = GetLocalInt(OBJECT_SELF, "ACR_SPAWN_VFX_DUR_TYPE");
		     //int nDurationTypeTwo = GetLocalInt(OBJECT_SELF, "ACR_SPAWN_VFX_DUR_TYPE_TWO");
		     //float fDurationLength = GetLocalFloat(OBJECT_SELF, "ACR_SPAWN_VFX_LENGTH");
			// float fDurationLengthTwo = GetLocalFloat(OBJECT_SELF, "ACR_SPAWN_VFX_LENGTH_TWO");
		
			 
			 
			 if(nRunOnce == 1) {
				//SendMessageToPC(oPC, "nRunOnce = 1");
				if((nSpawnNumber > 0) && (sSpawn != "")) {
					object oSpawnOne = CreateObject(nSpawnType, sSpawn, lSpawnWP); 
					SendMessageToPC(oPC, "Created " + sSpawn);
				    //ApplyEffectToObject(nDurationType, eTwo, oSpawnWP, fDurationLength);
			        //ApplyEffectToObject(nDurationTypeTwo, eTwo, oSpawnWPTwo, fDurationLengthTwo);
			        if(nSpawnNumber > 1) 
						{object oSpawnOneB = CreateObject(nSpawnType, sSpawn, lSpawnWP);
						 SendMessageToPC(oPC, "Created " + sSpawn);
				    	}
					if(nSpawnNumber > 2) 
						{object oSpawnOneC = CreateObject(nSpawnType, sSpawn, lSpawnWP);
						 SendMessageToPC(oPC, "Created " + sSpawn);
				    }
					if((nSpawnNumber > 3) && (Random(2) == 1))
						{object oSpawnOneD = CreateObject(nSpawnType, sSpawn, lSpawnWP);
						SendMessageToPC(oPC, "Created " + sSpawn);
				      }
					if((nSpawnNumber > 4) && (Random(2) == 1))
						{object oSpawnOneE = CreateObject(nSpawnType, sSpawn, lSpawnWP);
						SendMessageToPC(oPC, "Created " + sSpawn);
				    }
					//if(fDelayVFXOne > fDelaySpawnOne) {
					   // DelayCommand(fDelayVFXOne - fDelaySpawnOne, ApplyEffectToObject(nDurationType, eOne, oSpawnOne, fDurationLength));
			    	//	}
				}
				
				if((nSpawnNumberTwo > 0) && (sSpawnTwo != "")) {
					object oSpawnTwo = CreateObject(nSpawnTypeTwo, sSpawnTwo, lSpawnWPTwo); 
				    //DelayCommand(1.0, AssignCommand(oSpawnTwo,ActionSpeakString("*Climbs out of a xorn's mouth.", TALKVOLUME_TALK)));
					 SendMessageToPC(oPC, "2. Created " + sSpawn);
				     if(nSpawnNumberTwo > 1) 
						{object oSpawnTwoB = CreateObject(nSpawnTypeTwo, sSpawnTwo, lSpawnWPTwo);
						 //DelayCommand(1.0, AssignCommand(oSpawnTwoB, ActionSpeakString("*Climbs out of a xorn's mouth.", TALKVOLUME_TALK)));
						SendMessageToPC(oPC, "2. Created " + sSpawn);
				     }
					if(nSpawnNumberTwo > 2)
						{object oSpawnTwoC = CreateObject(nSpawnTypeTwo, sSpawnTwo, lSpawnWPTwo);
						SendMessageToPC(oPC, "2. Created " + sSpawn);
				     // DelayCommand(1.0, AssignCommand(oSpawnTwoC, ActionSpeakString("*Climbs out of a xorn's mouth.", TALKVOLUME_TALK)));
						}
					if((nSpawnNumberTwo > 3) && (Random(2) == 1))
						{object oSpawnTwoD = CreateObject(nSpawnTypeTwo, sSpawnTwo, lSpawnWPTwo);
						 //DelayCommand(1.0, AssignCommand(oSpawnTwoD, ActionSpeakString("*Climbs out of a xorn's mouth.", TALKVOLUME_TALK)));
						SendMessageToPC(oPC, "2. Created " + sSpawn);
				     }
					if((nSpawnNumberTwo > 4) && (Random(2) == 1))
						{object oSpawnTwoE = CreateObject(nSpawnTypeTwo, sSpawnTwo, lSpawnWPTwo);
						// DelayCommand(1.0, AssignCommand(oSpawnTwoE, ActionSpeakString("*Climbs out of a xorn's mouth.", TALKVOLUME_TALK)));
						SendMessageToPC(oPC, "2. Created " + sSpawn);
				     }
				//	if(fDelayVFXTwo > fDelaySpawnTwo) {
					//DelayCommand(fDelayVFXTwo - fDelaySpawnTwo, ApplyEffectToObject(nDurationTypeTwo, eTwo, oSpawnTwo, fDurationLengthTwo));
			       // }
				}
				
				SetLocalInt(OBJECT_SELF, "RUN_ONCE", 2);
				//SendMessageToPC(oPC, "RUN_ONCE set to 2");
				
			}
				
			if(nRunOnce == 0) {
				SendMessageToPC(oPC, sMessage);
				//SendMessageToPC(oPC, "nRunOnce = 0");
				SetLocalInt(OBJECT_SELF, "RUN_ONCE", 1);
			/*	if(fDelaySpawnOne >= fDelayVFXOne) {
					DelayCommand(fDelayVFXOne, ApplyEffectAtLocation(nDurationType, eOne, lSpawnWP, fDurationLength));
			    		}
				
				if(fDelaySpawnTwo >= fDelayVFXTwo) {
					DelayCommand(fDelayVFXTwo, ApplyEffectToObject(nDurationTypeTwo, eTwo, oSpawnWPTwo, fDurationLengthTwo));
			       }*/
				DelayCommand(fDelaySpawnOne, ExecuteScript("tsm_trg_onenter_spawn_qxtra", OBJECT_SELF));
				}			 
			 } 
		}
	} 
}