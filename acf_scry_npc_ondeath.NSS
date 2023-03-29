//
//  System Name : Scrying
//     Filename : acf_scry_npc_ondeath
//      Version : 0.1
//         Date : 7/8/22
//       Author : Wynna
//
//  Description
//  This script handles death actions of NPCs used in the scrying system. 
//  This should be in the On Death Script slot of these creatures: 
//	Invisible Scrying Sender - If it is killed, it ends the scrying spell.
//	It is not updated in ACR updates.
//
//  Revision History
////////////////////////////////////////////////////////////////////////////////

//	Wynna - 7/8/2022

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////

#include "acr_creature_i"
#include "acr_scry_i"

void main()
{
    ACR_CreatureOnDeath();

    if((GetTag(OBJECT_SELF)== "003_cr_scry_send") || (GetTag(OBJECT_SELF)== "003_cr_scry_send_xavier")) {
		object oScryer = GetLocalObject(OBJECT_SELF, "oScryer");
		object oScry = GetLocalObject(OBJECT_SELF, "oScry");
		object oScrySpeak = GetLocalObject(OBJECT_SELF, "oScrySpeak");
		object oScried = GetLocalObject(OBJECT_SELF, "oScried");
		location lHere = GetLocalLocation(oScry, "ACR_SCRY_LOCATION");
		if(GetLocalInt(GetModule(), "DM_Spam") == 0) {
			SendMessageToAllDMs(GetName(GetLastKiller()) + " strikes down " + GetName(oScryer) + "'s scrying sensor and the scrying ends.");
			}
		AssignCommand(oScrySpeak, ActionSpeakString("You see " + GetName(GetLastKiller()) + " strike down the scrying sensor and the images in the " + GetName(oScry) + " vanish.", TALKVOLUME_TALK));
		 		
		int nGoHome = 0;
		while(nGoHome < 9) {
			if(nGoHome == 1) {
				oScryer = GetLocalObject(oScry, "oViewerA");
				lHere = GetLocalLocation(oScry, "lViewerA");
				}
			if(nGoHome == 2) {
				oScryer = GetLocalObject(oScry, "oViewerB");
				lHere = GetLocalLocation(oScry, "lViewerB");
				}
			if(nGoHome == 3) {
				oScryer = GetLocalObject(oScry, "oViewerC");
				lHere = GetLocalLocation(oScry, "lViewerC");
				}
			if(nGoHome == 4) {
				oScryer = GetLocalObject(oScry, "oViewerD");
				lHere = GetLocalLocation(oScry, "lViewerD");
				}
			if(nGoHome == 5) {
				oScryer = GetLocalObject(oScry, "oViewerE");
				lHere = GetLocalLocation(oScry, "lViewerE");
				}
			if(nGoHome == 6) {
				oScryer = GetLocalObject(oScry, "oViewerF");
				lHere = GetLocalLocation(oScry, "lViewerF");
				}
			if(nGoHome == 7) {
				oScryer = GetLocalObject(oScry, "oViewerG");
				lHere = GetLocalLocation(oScry, "lViewerG");
				}
			if(nGoHome == 8) {
				oScryer = GetLocalObject(oScry, "oViewerH");
				lHere = GetLocalLocation(oScry, "lViewerH");
				}
				
			SendMessageToPC(oScryer, "You see " + GetName(GetLastKiller()) + " strike down your scrying sensor and the scrying ends.");
			//Bring your people home
			effect eEffect = GetFirstEffect(oScryer);
				int nRep = 0;
				while ((GetIsEffectValid(eEffect)) && (nRep < 10)) { 
					 object oCreator = GetEffectCreator(eEffect);
					 if(oCreator == oScrySpeak) {
					 	RemoveEffect(oScryer, eEffect);
					   }
					 eEffect = GetNextEffect(oScryer);
					 nRep ++;
					}
				
			if(GetArea(oScryer) != GetAreaFromLocation(lHere)) {
				AssignCommand(oScryer, ActionJumpToLocation(lHere));			
				}
			nGoHome++;
		} 	
			
		//Unset all local variables and destroy oScrySpeaker, too
		SetLocalObject(oScry, "oScried", OBJECT_INVALID);
		SetLocalObject(oScry, "oScrySpeak", OBJECT_INVALID);
		SetLocalObject(oScry, "oScryer", OBJECT_INVALID);
		SetLocalObject(oScry, "oScrySend", OBJECT_INVALID);
		SetLocalObject(oScryer, "oScried", OBJECT_INVALID);
		SetLocalObject(oScryer, "oScrySpeak", OBJECT_INVALID);
		SetLocalObject(oScryer, "oScrySend", OBJECT_INVALID);
		SetLocalObject(oScryer, "oScry", OBJECT_INVALID);
		SetLocalObject(oScried, "oScrySpeak", OBJECT_INVALID);
		SetLocalObject(oScried, "oScryer", OBJECT_INVALID);
		SetLocalObject(oScried, "oScry", OBJECT_INVALID);
		SetLocalObject(oScried, "oScrySend", OBJECT_INVALID);
		SetLocalInt(oScry, "nScryActive", 0);
		DestroyObject(oScrySpeak, 2.0);		
	}
		
}