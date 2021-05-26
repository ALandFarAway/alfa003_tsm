////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ACR Configuration File
//     Filename : acf_trg_onclick.nss
//    $Revision:: 236        $ current version of the file
//        $Date:: 2007-01-21#$ date the file was created or modified
//       Author : Cipher
//
//    Var Prefix:
//  Dependencies:
//
//  Description
//  This script calls the ACR's OnClick code for triggers, and any
//  custom code a server may need. It is not updated in ACR updates.
//
//  Revision History
//  2007/01/20  Cipher  Inception
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#include "acr_trigger_i"

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
#include "acr_db_persist_i"
#include "acr_quest_i"

void main()
{
	ACR_TriggerOnEnter();
	object oPC = GetEnteringObject();
	int nQuestState = GetLocalInt(OBJECT_SELF, "QuestStateToFire");
	string sQuest = GetLocalString(OBJECT_SELF, "Quest");
	SendMessageToPC(oPC, sQuest + " = " + IntToString(ACR_GetPersistentInt(oPC, sQuest)));
	string sObjectType;
	int nObjectType = OBJECT_TYPE_CREATURE;
	string sObjectResRef;
	int nXP;
	

	if(ACR_GetPersistentInt(oPC, sQuest) == nQuestState) {
		int nHD = GetHitDice(oPC);
		SendMessageToPC(oPC, "oPC has " + IntToString(nHD) + " HD");
	
		if(nHD == 1) {
			nXP = 500;
			sObjectResRef = GetLocalString(OBJECT_SELF, "QuestResRefCRTwo");
		}
		else if(nHD == 2) {
			nXP = 1001;
			sObjectResRef = GetLocalString(OBJECT_SELF, "QuestResRefCRTwo");
		}
		else if(nHD == 3) {
			nXP = 3001;
			sObjectResRef = GetLocalString(OBJECT_SELF, "QuestResRefCRTwo");
		}
		else if(nHD == 4) {
			sObjectResRef = GetLocalString(OBJECT_SELF, "QuestResRefCRFive");
		}
		else if(nHD == 5) {
			sObjectResRef = GetLocalString(OBJECT_SELF, "QuestResRefCRFive");
		}
		else if(nHD == 6) {
			sObjectResRef = GetLocalString(OBJECT_SELF, "QuestResRefCRFive");
		}
		else if(nHD == 7) {
			nXP = 21001;
			sObjectResRef = GetLocalString(OBJECT_SELF, "QuestResRefCREight");
		}
		else if(nHD == 8) {
			nXP = 28001;
			sObjectResRef = GetLocalString(OBJECT_SELF, "QuestResRefCREight");
		}
		else if(nHD >= 9) {
			nXP = 36001;
			sObjectResRef = GetLocalString(OBJECT_SELF, "QuestResRefCREight");
		}
		
			
	string sWaypoint = GetLocalString(OBJECT_SELF, "QuestWP");
	object oWaypoint = GetWaypointByTag(sWaypoint);
	int nQuestNumberCreate = GetLocalInt(OBJECT_SELF, "QuestNumberCreate");
		
	//int nRep = 0;
		
	//while (nRep < nQuestNumberCreate) {
		object oQuestCreature = CreateObject(nObjectType, sObjectResRef, GetLocation(oWaypoint));
		ResetCreatureLevelForXP(oQuestCreature, nXP, TRUE);
		int nCreatureHD = GetHitDice(oQuestCreature);
		SendMessageToPC(oPC, sObjectResRef + " created with " + IntToString(nCreatureHD) + " hit dice.");
	
	//	}
	}
}