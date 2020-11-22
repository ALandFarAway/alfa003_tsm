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
	object oPC = GetEnteringObject();

 if(GetTag(OBJECT_SELF) == "tsm_trigger_onenter_spawn")
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
	
		 int nRunOnce = GetLocalInt(OBJECT_SELF, "RUN_ONCE");
	
		 if(nRunOnce == 1) {
			//SendMessageToAllDMs("RunOnce = 1.");
			
			if((nSpawnNumber > 0) && (sSpawn != "")) {
				//SendMessageToAllDMs("oSpawnOneA = " + IntToString(nSpawnType) + " " + sSpawn + " at location of " +sSpawnWP );
			    object oSpawnOne = CreateObject(nSpawnType, sSpawn, lSpawnWP); 
			    //SendMessageToAllDMs(IntToString(nDurationType) + " " + IntToString(nVFX) + " on " + sSpawnWP + " for " + FloatToString(fDurationLength) + " seconds.");
				ApplyEffectToObject(nDurationType, eTwo, oSpawnWP, fDurationLength);
		        //SendMessageToAllDMs(IntToString(nDurationTypeTwo) + " " + IntToString(nVFXTwo) + " on " + sSpawnWPTwo + " for " + FloatToString(fDurationLengthTwo) + " seconds.");
				ApplyEffectToObject(nDurationTypeTwo, eTwo, oSpawnWPTwo, fDurationLengthTwo);
		        if((nSpawnNumber > 1) && (Random(2) == 1))
					{//SendMessageToAllDMs("oSpawnOneB = " + IntToString(nSpawnType) + " " + sSpawn + " at location of " +sSpawnWP );
			         object oSpawnTwo = CreateObject(nSpawnType, sSpawn, lSpawnWP);}
				if((nSpawnNumber > 2) && (Random(2) == 1))
					{//SendMessageToAllDMs("oSpawnOneC = " + IntToString(nSpawnType) + " " + sSpawn + " at location of " +sSpawnWP );
			         object oSpawnThree = CreateObject(nSpawnType, sSpawn, lSpawnWP);}
				if((nSpawnNumber > 3) && (Random(2) == 1))
					{//SendMessageToAllDMs("oSpawnOneD = " + IntToString(nSpawnType) + " " + sSpawn + " at location of " +sSpawnWP );
			         object oSpawnFour = CreateObject(nSpawnType, sSpawn, lSpawnWP);}
				if((nSpawnNumber > 4) && (Random(2) == 1))
					{//SendMessageToAllDMs("oSpawnOneE = " + IntToString(nSpawnType) + " " + sSpawn + " at location of " +sSpawnWP );
			         object oSpawnFive = CreateObject(nSpawnType, sSpawn, lSpawnWP);}
				
				if(fDelayVFXOne > fDelaySpawnOne) {
				    //SendMessageToAllDMs("Delayed " + FloatToString(fDelayVFXOne) + " " + IntToString(nDurationType) + " " + IntToString(nVFX) + " on " + sSpawnWP + " for " + FloatToString(fDurationLength) + " seconds.");
					DelayCommand(fDelayVFXOne - fDelaySpawnOne, ApplyEffectToObject(nDurationType, eOne, oSpawnOne, fDurationLength));
		    		}
				//SendMessageToAllDMs("nSpawnNumber = " + IntToString(nSpawnNumber));
			    //int a = 0;
				//while((a < nSpawnNumber - 1)&& (a < 10)) {
				//SendMessageToAllDMs("a = " + IntToString(a) + ". " + IntToString(nSpawnType) + " " + sSpawn + " at location of " +sSpawnWP );
			    //CreateObject(nSpawnType, sSpawn, lSpawnWP); 
			    //a++;
				//}
			}
			
			if((nSpawnNumberTwo > 0) && (sSpawnTwo != "")) {
				//SendMessageToAllDMs("oSpawnTwo = " + IntToString(nSpawnTypeTwo) + " " + sSpawnTwo + " at location of " +sSpawnWPTwo );
			    object oSpawnTwo = CreateObject(nSpawnTypeTwo, sSpawnTwo, lSpawnWPTwo); 
			    if(fDelayVFXTwo > fDelaySpawnTwo) {
				//SendMessageToAllDMs("Delayed " + FloatToString(fDelayVFXTwo) + " " + IntToString(nDurationTypeTwo) + " " + IntToString(nVFXTwo) + " on " + sSpawnWPTwo + " for " + FloatToString(fDurationLengthTwo) + " seconds.");
				DelayCommand(fDelayVFXTwo - fDelaySpawnTwo, ApplyEffectToObject(nDurationTypeTwo, eTwo, oSpawnTwo, fDurationLengthTwo));
		        }
				//SendMessageToAllDMs("nSpawnNumberTwo = " + IntToString(nSpawnNumberTwo));
			    int b = 0;
				while((b < nSpawnNumberTwo - 1) && (b < 10)) {
				//SendMessageToAllDMs("b = " + IntToString(b) + ". " + IntToString(nSpawnTypeTwo) + " " + sSpawnTwo + " at location of " +sSpawnWPTwo );
			    CreateObject(nSpawnTypeTwo, sSpawnTwo, lSpawnWPTwo); 
			    b++;
				}
			}
			
			SetLocalInt(OBJECT_SELF, "RUN_ONCE", 2);
		}
			
		if(nRunOnce == 0) {
			SendMessageToPC(oPC, sMessage);
			//SendMessageToAllDMs("RunOnce = 0. sMessage = " + sMessage);
			SetLocalInt(OBJECT_SELF, "RUN_ONCE", 1);
			if(fDelaySpawnOne >= fDelayVFXOne) {
				DelayCommand(fDelayVFXOne, ApplyEffectAtLocation(nDurationType, eOne, lSpawnWP, fDurationLength));
		    	//SendMessageToAllDMs("Delayed " + FloatToString(fDelayVFXOne) + " " + IntToString(nDurationType) + " " + IntToString(nVFX) + " at " + sSpawnWP + " location for " + FloatToString(fDurationLength) + " seconds.");
				}
			
			if(fDelaySpawnTwo >= fDelayVFXTwo) {
				DelayCommand(fDelayVFXTwo, ApplyEffectToObject(nDurationTypeTwo, eTwo, oSpawnWPTwo, fDurationLengthTwo));
		        //SendMessageToAllDMs("Delayed " + FloatToString(fDelayVFXTwo) + " " + IntToString(nDurationTypeTwo) + " " + IntToString(nVFXTwo) + " on " + sSpawnWPTwo + " for " + FloatToString(fDurationLengthTwo) + " seconds.");
				
				}
			//SendMessageToAllDMs(FloatToString(fDelaySpawnOne) + " execute tsm_trg_onenter_spawn");
			DelayCommand(fDelaySpawnOne, ExecuteScript("tsm_trg_onenter_spawn", OBJECT_SELF));
			}	
		 
		 
		 
		 
		 
		 }
	   
}