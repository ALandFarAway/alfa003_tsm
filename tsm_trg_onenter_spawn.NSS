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
 		{int nPercentChance = GetLocalInt(OBJECT_SELF, "ACR_SPAWN_CHANCE");
		 if(Random(100)+1 < nPercentChance) 
		 	{string sMessage=GetLocalString(OBJECT_SELF, "ACR_SPAWN_MESSAGE");
		 
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
			 float fDelayVFXOne = GetLocalFloat(OBJECT_SELF, "ACR_VFX_DELAY");
			 float fDelayVFXTwo = GetLocalFloat(OBJECT_SELF, "ACR_VFX_DELAY_TWO");
			 
			 int nVFX = GetLocalInt(OBJECT_SELF, "ACR_SPAWN_VFX");
			 int nVFXTwo = GetLocalInt(OBJECT_SELF, "ACR_SPAWN_VFX_TWO");
			 effect eOne = EffectVisualEffect(nVFX);
		     effect eTwo = EffectVisualEffect(nVFXTwo);
			 int nDurationType = GetLocalInt(OBJECT_SELF, "ACR_SPAWN_VFX_DUR_TYPE");
		     int nDurationTypeTwo = GetLocalInt(OBJECT_SELF, "ACR_SPAWN_VFX_DUR_TYPE_TWO");
		     float fDurationLength = GetLocalFloat(OBJECT_SELF, "ACR_SPAWN_VFX_LENGTH");
			 float fDurationLengthTwo = GetLocalFloat(OBJECT_SELF, "ACR_SPAWN_VFX_LENGTH_TWO");
		
			 SendMessageToPC(oPC, sMessage);
			 	
			 if((nSpawnNumber > 0) && (sSpawn != "")) {
					DelayCommand(fDelaySpawnOne, ActionCreateCreature(sSpawn, lSpawnWP)); 
					
					
					ApplyEffectToObject(nDurationType, eOne, oSpawnWP, fDurationLength);
			        if(nSpawnNumber > 1) 
						{DelayCommand(fDelaySpawnOne, ActionCreateCreature(sSpawn, lSpawnWP));}
					if(nSpawnNumber > 2) 
						{DelayCommand(fDelaySpawnOne, ActionCreateCreature(sSpawn, lSpawnWP));}
					if((nSpawnNumber > 3) && (Random(2) == 1))
						{DelayCommand(fDelaySpawnOne, ActionCreateCreature(sSpawn, lSpawnWP));}
					if((nSpawnNumber > 4) && (Random(2) == 1))
						{DelayCommand(fDelaySpawnOne, ActionCreateCreature(sSpawn, lSpawnWP));}
					
					if(fDelayVFXOne > fDelaySpawnOne) {
					    DelayCommand(fDelayVFXOne - fDelaySpawnOne, ApplyEffectToObject(nDurationType, eOne, GetNearestObjectByTag(sSpawn, OBJECT_SELF,1), fDurationLength));
			    		}
						
					if(fDelaySpawnOne >= fDelayVFXOne) {
						DelayCommand(fDelayVFXOne, ApplyEffectAtLocation(nDurationType, eOne, lSpawnWP, fDurationLength));
				    	}
				}
			
			if((nSpawnNumberTwo > 0) && (sSpawnTwo != "")) {
				DelayCommand(fDelaySpawnTwo, ActionCreateCreature(sSpawnTwo, lSpawnWPTwo)); 
				ApplyEffectToObject(nDurationTypeTwo, eTwo, oSpawnWPTwo, fDurationLengthTwo);
			    if(nSpawnNumberTwo > 1) 
					{DelayCommand(fDelaySpawnTwo, ActionCreateCreature(sSpawnTwo, lSpawnWPTwo));}
				if(nSpawnNumberTwo > 2)
					{DelayCommand(fDelaySpawnTwo, ActionCreateCreature(sSpawnTwo, lSpawnWPTwo));}
				if((nSpawnNumberTwo > 3) && (Random(2) == 1))
					{DelayCommand(fDelaySpawnTwo, ActionCreateCreature(sSpawnTwo, lSpawnWPTwo));}
				if((nSpawnNumberTwo > 4) && (Random(2) == 1))
					{DelayCommand(fDelaySpawnTwo, ActionCreateCreature(sSpawnTwo, lSpawnWPTwo));}
					
				if(fDelayVFXTwo > fDelaySpawnTwo) {
					DelayCommand(fDelayVFXTwo - fDelaySpawnTwo, ApplyEffectToObject(nDurationTypeTwo, eTwo, GetNearestObjectByTag(sSpawnTwo, OBJECT_SELF,1), fDurationLengthTwo));
			        }
				
				if(fDelaySpawnTwo >= fDelayVFXTwo) {
					DelayCommand(fDelayVFXTwo, ApplyEffectToObject(nDurationTypeTwo, eTwo, oSpawnWPTwo, fDurationLengthTwo));
			        }
				}
			
		SetLocalInt(OBJECT_SELF, "RUN_ONCE", 1);			
		}		
	}	
}