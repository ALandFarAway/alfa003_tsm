////
//  System Name : Scrying
//     Filename : acf_scry_npc_onconvo
//      Version : 0.1
//         Date : 7/8/22
//       Author : Wynna
//
//  Description
//  This script handles scrying interactions by NPCs used in the scrying system. 
//  This should be in the On Conversation slot of these creatures: 
//	Invisible Scrying Speaker - Handles execution of the Scry spell upon hearing a listen pattern set in its  
//	 onspawn that holds a PC name or nickname, or an NPC nickname
//	Invisible Scrying Namer - Sets PC and NPC nicknames on a scrying object
//	Invisible Scrying Sender - Follows target and sends all conversation it hears back to Speaker to speak out loud
//	Invisible Scryer's Presence - Stays at scrying object to send all conversation there onward to oScryer 
//	It is not updated in ACR updates.
//
//  Revision History
////////////////////////////////////////////////////////////////////////////////

//	Wynna - 7/8/2022

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////

#include "acr_creature_i"
#include "acr_scry_i"
#include "acr_db_persist_i"

void ActionCreateWynCreature(string sCreature, location lLocCreature)
{
    CreateObject(OBJECT_TYPE_CREATURE, sCreature, lLocCreature);
}

void ActionCreateWynEffect(string sObject, location lLocObject)
{
    CreateObject(OBJECT_TYPE_PLACED_EFFECT, sObject, lLocObject);
}

void main()
{   ACR_CreatureOnConversation();
 	effect eCutScene = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);
	effect eInvis = EffectInvisibility(INVISIBILITY_TYPE_IMPROVED);
	effect eEthereal = EffectEthereal();
	    
//Actions for scrying sensor in response to substrings set on it at spawn
if((GetTag(OBJECT_SELF) == "003_cr_scry_send") && (GetLastSpeaker() == GetLocalObject(OBJECT_SELF, "oScryer")))
		{string sMatch = GetMatchedSubstring(1);
		int nMatch = GetListenPatternNumber();
		//6040 will end an ongoing scrying session
		if(nMatch == 6040) {
		//End Spell
			object oScrySpeak = GetLocalObject(OBJECT_SELF, "oScrySpeak");
			object oDupe = GetLocalObject(GetLastSpeaker(), "oDupe");;
			object oScry = GetLocalObject(OBJECT_SELF, "oScry");
			string sScryName = GetName(oScry);
			object oScryer = GetLocalObject(OBJECT_SELF, "oScryer");
			location lHere = GetLocalLocation(oScryer, "ACR_SCRY_LOCATION");
		    object oScrySend = GetLocalObject(OBJECT_SELF, "oScrySend");
			object oScried = GetLocalObject(OBJECT_SELF, "oScried");
			object oScrySelf = GetLocalObject(OBJECT_SELF, "oScrySelf");
			effect eEffect = GetFirstEffect(oScryer);
			int nGoHome = 0;
			while(nGoHome < 9) {
			
				if(nGoHome == 0) {			
					AssignCommand(oScry, ActionSpeakString("*The images in the " + sScryName + " fade.", TALKVOLUME_TALK));		
					SendMessageToPC(oScryer, "The scry spell ends.");		
					if(GetLocalInt(GetModule(), "DM_Spam") == 0) {
						SendMessageToAllDMs("Send: " + GetName(oScryer) + "'s scry spell is cancelled and the images in the " + sScryName + " fade.");		
						}
					}
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
			
				if(GetIsObjectValid(oDupe)) {
					AssignCommand(oScryer, ActionJumpToLocation(lHere));
					DestroyObject(GetLocalObject(oScryer, "oDupe"), 3.0);
					SetLocalObject(oScryer, "oDupe", OBJECT_INVALID);
					}		
				
				nGoHome++;
			} 	
			 					
			//Unset ALL local objects at the end of the spell
			//Destroy Scrying Speaker, Sensor and Scryer Dupe and Presence
			SetLocalObject(oScry, "oScryer", OBJECT_INVALID);
			SetLocalObject(oScry, "oScrySpeak", OBJECT_INVALID);
			SetLocalObject(oScry, "oScried", OBJECT_INVALID);
			SetLocalObject(oScry, "oScrySend", OBJECT_INVALID);
			SetLocalObject(oScry, "oScrySelf", OBJECT_INVALID);
			SetLocalObject(oScry, "oViewerA", OBJECT_INVALID);
			SetLocalObject(oScry, "oViewerB", OBJECT_INVALID);
			SetLocalObject(oScry, "oViewerC", OBJECT_INVALID);
			SetLocalObject(oScry, "oViewerD", OBJECT_INVALID);
			SetLocalObject(oScry, "oViewerE", OBJECT_INVALID);
			SetLocalObject(oScry, "oViewerF", OBJECT_INVALID);
			SetLocalObject(oScry, "oViewerG", OBJECT_INVALID);
			SetLocalObject(oScry, "oViewerH", OBJECT_INVALID);
			SetLocalObject(oScry, "oDupe", OBJECT_INVALID);
			SetLocalObject(oScryer, "oScry", OBJECT_INVALID);
			SetLocalObject(oScryer, "oScrySpeak", OBJECT_INVALID);
			SetLocalObject(oScryer, "oScried", OBJECT_INVALID);
			SetLocalObject(oScryer, "oScrySend", OBJECT_INVALID);
			SetLocalObject(oScryer, "oScrySelf", OBJECT_INVALID);
			SetLocalObject(oScryer, "oDupe", OBJECT_INVALID);
			SetLocalObject(oScried, "oScryer", OBJECT_INVALID);
			SetLocalObject(oScried, "oScry", OBJECT_INVALID);
			SetLocalObject(oScried, "oScrySpeak", OBJECT_INVALID);
			SetLocalObject(oScried, "oScrySend", OBJECT_INVALID);
			SetLocalObject(oScried, "oScrySelf", OBJECT_INVALID);
			SetLocalObject(oScried, "oDupe", OBJECT_INVALID);
			
			DeleteLocalLocation(oScryer, "ACR_SCRY_LOCATION");
			DeleteLocalLocation(oScry, "ACR_SCRY_LOCATION");
			DeleteLocalLocation(oScry, "lViewerA");
			DeleteLocalLocation(oScry, "lViewerB");
			DeleteLocalLocation(oScry, "lViewerC");
			DeleteLocalLocation(oScry, "lViewerD");
			DeleteLocalLocation(oScry, "lViewerE");
			DeleteLocalLocation(oScry, "lViewerF");
			DeleteLocalLocation(oScry, "lViewerG");
			DeleteLocalLocation(oScry, "lViewerH");
			SetLocalInt(oScry, "nScryActive", 0);
								 
			DestroyObject(oScrySpeak);  
			DestroyObject(oScrySelf);
			DestroyObject(oDupe);
			SetLocalObject(oScryer, "oDupe", OBJECT_INVALID);
			DestroyObject(OBJECT_SELF, 1.0);
			return;
		}

}
	
if((GetTag(OBJECT_SELF)== "003_cr_scry_send") && ((GetLastSpeaker()== GetLocalObject(OBJECT_SELF, "oViewerA")) || (GetLastSpeaker()== GetLocalObject(OBJECT_SELF, "oViewerB")) || (GetLastSpeaker()== GetLocalObject(OBJECT_SELF, "oViewerC")) || (GetLastSpeaker()== GetLocalObject(OBJECT_SELF, "oViewerD")) || (GetLastSpeaker()== GetLocalObject(OBJECT_SELF, "oViewerE")) || (GetLastSpeaker()== GetLocalObject(OBJECT_SELF, "oViewerF")) || (GetLastSpeaker()== GetLocalObject(OBJECT_SELF, "oViewerG")) || (GetLastSpeaker()== GetLocalObject(OBJECT_SELF, "oViewerH")))) 
	{object oScrySpeak = GetLocalObject(OBJECT_SELF, "oScrySpeak");
	 object oDupe = GetLocalObject(GetLastSpeaker(), "oDupe");
	 location lHere;
	 object oScry = GetLocalObject(OBJECT_SELF, "oScry");
		if(GetLastSpeaker() == GetLocalObject(oScry, "oViewerA")){
		lHere = GetLocalLocation(oScry, "lViewerA");
		}
	if(GetLastSpeaker() == GetLocalObject(oScry, "oViewerB")){
		lHere = GetLocalLocation(oScry, "lViewerB");
		}
	if(GetLastSpeaker() == GetLocalObject(oScry, "oViewerC")){
		lHere = GetLocalLocation(oScry, "lViewerC");
		}
	if(GetLastSpeaker() == GetLocalObject(oScry, "oViewerD")){
		lHere = GetLocalLocation(oScry, "lViewerD");
		}
	if(GetLastSpeaker() == GetLocalObject(oScry, "oViewerE")){
		lHere = GetLocalLocation(oScry, "lViewerE");
		}
	if(GetLastSpeaker() == GetLocalObject(oScry, "oViewerF")){
		lHere = GetLocalLocation(oScry, "lViewerF");
		}
	if(GetLastSpeaker() == GetLocalObject(oScry, "oViewerG")){
		lHere = GetLocalLocation(oScry, "lViewerG");
		}
	if(GetLastSpeaker() == GetLocalObject(oScry, "oViewerH")){
		lHere = GetLocalLocation(oScry, "lViewerH");
		}
			
	 effect eEffect = GetFirstEffect(GetLastSpeaker());
	 int nRep = 0;
	 while ((GetIsEffectValid(eEffect)) && (nRep < 10)) { 
		object oCreator = GetEffectCreator(eEffect);
		if(oCreator == oScrySpeak) {
			RemoveEffect(GetLastSpeaker(), eEffect);
			}
		eEffect = GetNextEffect(GetLastSpeaker());
		nRep ++;
		}
			
		if(GetIsObjectValid(oDupe)) {
			AssignCommand(GetLastSpeaker(), ActionJumpToLocation(lHere));
			DestroyObject(GetLocalObject(GetLastSpeaker(), "oDupe"), 3.0);
			SetLocalObject(GetLastSpeaker(), "oDupe", OBJECT_INVALID);
			}
					
		SendMessageToPC(GetLastSpeaker(), "Speaking breaks your immersion.");		
	}
	
//Action queue for OOC Scrying Speaker that handles most Scrying interaction
if((GetTag(OBJECT_SELF)== "003_cr_scry_speak") && ((GetLastSpeaker()== GetLocalObject(OBJECT_SELF, "oScryer")) || (GetLocalObject(OBJECT_SELF, "oScryer") == OBJECT_INVALID))) 
	{
		//Get existing local objects set by Spellhook
		object oScry = GetLocalObject(OBJECT_SELF, "oScry");
		string sScryName = GetName(oScry);
		object oScryer = GetLocalObject(OBJECT_SELF, "oScryer");
		float fScryTimer = GetLocalFloat(OBJECT_SELF, "fScryTimer");
		//This NPC was set to listen for specific words in tsm_scry_npc_onspawn
		//6020 thru 6029 are the names of the first ten PCs currently logged in
		//6030 thru 6039 are the names of up to ten NPCs stored on the scrying object
		string sMatch = GetMatchedSubstring(1);
		int nMatch = GetListenPatternNumber();
		//6040 will end an ongoing scrying session
		if(nMatch == 6040) {
		//End Spell
			object oScryer = GetLocalObject(OBJECT_SELF, "oScryer");
			location lHere = GetLocalLocation(oScryer, "ACR_SCRY_LOCATION");
		    object oScrySend = GetLocalObject(OBJECT_SELF, "oScrySend");
			object oScried = GetLocalObject(OBJECT_SELF, "oScried");
			object oScrySelf = GetLocalObject(OBJECT_SELF, "oScrySelf");
			object oDupe = GetLocalObject(oScryer, "oDupe");
			object oScry = GetLocalObject(OBJECT_SELF, "oScry");
			effect eEffect = GetFirstEffect(oScryer);
			int nRep = 0;
			while ((GetIsEffectValid(eEffect)) && (nRep < 10)) { 
				 object oCreator = GetEffectCreator(eEffect);
				 if(oCreator == OBJECT_SELF) {
				 	RemoveEffect(oScryer, eEffect);
				   }
				 eEffect = GetNextEffect(oScryer);
				 nRep ++;
				}
			
			if(GetIsObjectValid(oDupe)) {
				AssignCommand(oScryer, ActionJumpToLocation(lHere));
				}
						
			AssignCommand(oScry, ActionSpeakString("*The images in the " + sScryName + " fade.", TALKVOLUME_TALK));		
			SendMessageToPC(oScryer, "The scry spell ends.");		
			if(GetLocalInt(GetModule(), "DM_Spam") == 0) {
				SendMessageToAllDMs(GetName(oScryer) + "'s scry spell is cancelled and the images in the " + sScryName + " fade.");		
				}
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
				
												
				//Bring your people home
				effect eEffect = GetFirstEffect(oScryer);
					int nRep = 0;
					while ((GetIsEffectValid(eEffect)) && (nRep < 10)) { 
						 object oCreator = GetEffectCreator(eEffect);
						 if(oCreator == OBJECT_SELF) {
						 	RemoveEffect(oScryer, eEffect);
						   }
						 eEffect = GetNextEffect(oScryer);
						 nRep ++;
						}
			
				if(GetIsObjectValid(oDupe)) {
					AssignCommand(oScryer, ActionJumpToLocation(lHere));
					DestroyObject(GetLocalObject(oScryer, "oDupe"), 3.0);
					SetLocalObject(oScryer, "oDupe", OBJECT_INVALID);
					}		
				
				nGoHome++;
			} 	
			 					
			//Unset ALL local objects at the end of the spell
			//Destroy Scrying Speaker, Sensor and Scryer Dupe and Presence
			SetLocalObject(oScry, "oScryer", OBJECT_INVALID);
			SetLocalObject(oScry, "oScrySpeak", OBJECT_INVALID);
			SetLocalObject(oScry, "oScried", OBJECT_INVALID);
			SetLocalObject(oScry, "oScrySend", OBJECT_INVALID);
			SetLocalObject(oScry, "oScrySelf", OBJECT_INVALID);
			SetLocalObject(oScry, "oViewerA", OBJECT_INVALID);
			SetLocalObject(oScry, "oViewerB", OBJECT_INVALID);
			SetLocalObject(oScry, "oViewerC", OBJECT_INVALID);
			SetLocalObject(oScry, "oViewerD", OBJECT_INVALID);
			SetLocalObject(oScry, "oViewerE", OBJECT_INVALID);
			SetLocalObject(oScry, "oViewerF", OBJECT_INVALID);
			SetLocalObject(oScry, "oViewerG", OBJECT_INVALID);
			SetLocalObject(oScry, "oViewerH", OBJECT_INVALID);
			SetLocalObject(oScry, "oDupe", OBJECT_INVALID);
			SetLocalObject(oScryer, "oScry", OBJECT_INVALID);
			SetLocalObject(oScryer, "oScrySpeak", OBJECT_INVALID);
			SetLocalObject(oScryer, "oScried", OBJECT_INVALID);
			SetLocalObject(oScryer, "oScrySend", OBJECT_INVALID);
			SetLocalObject(oScryer, "oScrySelf", OBJECT_INVALID);
			SetLocalObject(oScryer, "oDupe", OBJECT_INVALID);
			SetLocalObject(oScried, "oScryer", OBJECT_INVALID);
			SetLocalObject(oScried, "oScry", OBJECT_INVALID);
			SetLocalObject(oScried, "oScrySpeak", OBJECT_INVALID);
			SetLocalObject(oScried, "oScrySend", OBJECT_INVALID);
			SetLocalObject(oScried, "oScrySelf", OBJECT_INVALID);
			SetLocalObject(oScried, "oDupe", OBJECT_INVALID);
			
			DeleteLocalLocation(oScryer, "ACR_SCRY_LOCATION");
			DeleteLocalLocation(oScry, "ACR_SCRY_LOCATION");
			DeleteLocalLocation(oScry, "lViewerA");
			DeleteLocalLocation(oScry, "lViewerB");
			DeleteLocalLocation(oScry, "lViewerC");
			DeleteLocalLocation(oScry, "lViewerD");
			DeleteLocalLocation(oScry, "lViewerE");
			DeleteLocalLocation(oScry, "lViewerF");
			DeleteLocalLocation(oScry, "lViewerG");
			DeleteLocalLocation(oScry, "lViewerH");
			SetLocalInt(oScry, "nScryActive", 0);
								 
			DestroyObject(oScrySend);  
			DestroyObject(oScrySelf);
			DestroyObject(oDupe);
			SetLocalObject(oScryer, "oDupe", OBJECT_INVALID);
			DestroyObject(OBJECT_SELF, 1.0);
			return;
		}
		
		int nScryActive = GetLocalInt(oScry, "nScryActive");
		if(nScryActive == 1) {
			SendMessageToPC(oScryer, "You must wait for this spell to end before scrying again. Use your scrying object for an update on your current subject.");
			return;
			}
			
		string sPTargetRes = GetLocalString(oScry, sMatch);
					 
		if((nMatch >= 6020) && (nMatch < 6040)) {
		  
		//oScryer must speak the full name of the PC or Nickname of the allowable NPC he/she wishes to Scry	
				int nIncA = 6020;
	         	object oScried = GetFirstPC(FALSE);
				while ((oScried != OBJECT_INVALID) && (nIncA < 6040)) {
					string sScriedName = GetName(oScried);
					string sScriedNickStored = GetLocalString(oScryer, sScriedName);
										
					//First, if the spoken name matches a stored NPC's nickname or full name, then spawn the associated resref and grab some variables off it, then get rid of it again
					if(nIncA == 6020) {
						if(sPTargetRes != "") {
							oScried = CreateObject(OBJECT_TYPE_CREATURE, sPTargetRes, GetLocation(OBJECT_SELF));
							sScriedName = GetName(oScried);
							sScriedNickStored = GetLocalString(oScryer, sScriedName);
							ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutScene, oScried);
				 			ApplyEffectToObject(DURATION_TYPE_PERMANENT, eInvis, oScried);
				 			ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEthereal, oScried);
				 			SetStandardFactionReputation(STANDARD_FACTION_HOSTILE, 50, oScried);
							string sScriedArea = GetLocalString(oScried, "ACR_SCRY_AREA_TAG");
							int nWillSaveBase = GetWillSavingThrow(oScried);
							SetLocalInt(OBJECT_SELF, "oScriedWSBase", nWillSaveBase);
							object oScriedSubArea;
							string sScriedSubArea;
							object oScriedArea = GetFirstArea();
							while(oScriedArea != OBJECT_INVALID) {
								if(GetTag(oScriedArea) == sScriedArea) {
									ACR_PreSpawnArea(oScriedArea);
									DestroyObject(oScried);
									object oFirst = GetFirstObjectInArea(oScriedArea);
									int nNPC = 1;
									object oNPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC, oFirst, nNPC); 
									while (oNPC != OBJECT_INVALID) {
										if(sScriedName == GetName(oNPC)) {
											 oScried = oNPC;
											 break;
											}
										oNPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC, oFirst, nNPC);
										nNPC++;
										}
									break;
									}
								oScriedArea = GetNextArea();
								 }
							} 
						}
					 
					 /*If the spoken name matches the name of one of the keyed NPCs or PCs currently logged in
					   give that potential oScried a WillSave vs oScryer's DC*/
					 if(((TestStringAgainstPattern("**" + sScriedName + "**", sMatch)) || (TestStringAgainstPattern("**" + sScriedNickStored + "**", sMatch))) && (nScryActive == 0))
						{if(GetLocalInt(oScried, "abr_sp_nondetect") != 0) {
							int nCL = GetLocalInt(OBJECT_SELF, "nCasterLevel");
							int nCLRoll = d20(1);
							int nNDDC = GetLocalInt(oScried, "abr_sp_nondetect");
							SendMessageToPC(oScryer, GetName(oScried) + " has Non-Detection active. " + GetName(oScryer) + " rolled a " + IntToString(nCLRoll) + " + " + IntToString(nCL) + " = " + IntToString(nCLRoll + nCL) + "CL Check vs. DC" + IntToString(nNDDC) + ".");
							if(GetLocalInt(GetModule(), "DM_Spam") == 0) {
								SendMessageToAllDMs(GetName(oScried) + " has Non-Detection active. " + GetName(oScryer) + " rolled a " + IntToString(nCLRoll) + " + " + IntToString(nCL) + " = " + IntToString(nCLRoll + nCL) + "CL Check vs. DC" + IntToString(nNDDC) + ".");
								}
							if(nCL + nCLRoll <  nNDDC) {
								SendMessageToPC(oScryer, "There is no result to your spell. As soon as you finish casting it, its power simply ends.");
								SendMessageToPC(oScried, "You have a sensation as of somebody's attention passing over you without detecting your presence.");
								SetLocalObject(oScry, "oScrySpeak", OBJECT_INVALID);
								SetLocalObject(oScryer, "oScrySpeak", OBJECT_INVALID);
								SetLocalInt(oScry, "nScryActive", 0);
								DestroyObject(OBJECT_SELF, 2.0);
								return;
								}
							else {
								SendMessageToPC(oScryer, "For a moment there is no result to your spell. Then you have a sense of having bested a ward you didn't even know existed until it was broken, and you know you must still win a battle of wills with your now detectable target.");
								SendMessageToPC(oScried, "You have a sensation as of somebody's attention passing over you...then pausing, and returning.");
								}
							}
							
						else if(GetLocalInt(oScried, "abr_sp_sanctum") != 0) {
							if(GetLocalInt(GetModule(), "DM_Spam") == 0) {
								SendMessageToAllDMs(GetName(oScried) + " has Mage's Private Sanctum active.");
								}
							SendMessageToPC(oScryer, "There is no result to your spell. As soon as you finish casting it, its power simply ends.");
							SendMessageToPC(oScried, "You have a sensation as of somebody's attention passing over you without detecting your presence.");
							SetLocalObject(oScry, "oScrySpeak", OBJECT_INVALID);
							SetLocalObject(oScryer, "oScrySpeak", OBJECT_INVALID);
							SetLocalInt(oScry, "nScryActive", 0);
							DestroyObject(OBJECT_SELF, 2.0);
							return;
							}
							
						else if(GetTag(GetItemInSlot(INVENTORY_SLOT_NECK, oScried)) == "abr_it_ne_amu_noscry") {
							int nCL = GetLocalInt(OBJECT_SELF, "nCasterLevel");
							int nCLRoll = d20(1);
							SendMessageToPC(oScryer, GetName(oScried) + " is wearing an amulet of non-detection. " + GetName(oScryer) + " rolled a " + IntToString(nCLRoll) + " + " + IntToString(nCL) + " = " + IntToString(nCLRoll + nCL) + "CL Check vs. DC19.");
							if(GetLocalInt(GetModule(), "DM_Spam") == 0) {
								SendMessageToAllDMs(GetName(oScried) + " is wearing an amulet of non-detection. " + GetName(oScryer) + " rolled a " + IntToString(nCLRoll) + " + " + IntToString(nCL) + " = " + IntToString(nCLRoll + nCL) + "CL Check vs. DC19.");
								}
							if(nCL + nCLRoll < 19) {
								SendMessageToPC(oScryer, "There is no result to your spell. As soon as you finish casting it, its power simply ends.");
								SendMessageToPC(oScried, "Your amulet warms against your throat. You feel it warding off a divination attempt.");
								SetLocalObject(oScry, "oScrySpeak", OBJECT_INVALID);
								SetLocalObject(oScryer, "oScrySpeak", OBJECT_INVALID);
								SetLocalInt(oScry, "nScryActive", 0);
								DestroyObject(OBJECT_SELF, 2.0);
								return;
								}
							else {
								SendMessageToPC(oScryer, "For a moment there is no result to your spell. Then you have a sense of having bested a ward you didn't even know existed until it was broken, and you know you must still win a battle of wills with your now detectable target.");
								SendMessageToPC(oScried, "Your amulet warms against your throat. You feel its non-detection powers fail...and your will struggling with another's divination attempt.");
								}
							}
							
						SendMessageToPC(oScryer, "You feel your spell contesting with " + sScriedName + "'s willpower to resist it.");
						//oScried makes a privately rolled WillSave vs. stored DC:
						
						int nKnowledge = -10;	
						int nConnection = 0;
						int nImage = 0;
						int nPossession = 0;
						int nBody = 0;
								
						object oToken = GetFirstItemInInventory(oScryer);
						while(oToken != OBJECT_INVALID) {
							string sTokenTag = GetTag(oToken);
							string sPTargetName = ACR_GetPersistentString(oToken, "sPTargetName");
							string sLTargetName = GetLocalString(oToken, "sTargetName");
							int nPosMatch = FindSubString(sMatch, "'", 0);
							if(((FindSubString(sTokenTag, "abr_it_scry_", 0) != -1) || ((sPTargetName == sScriedName) || (sPTargetName == SpliceString(sMatch, nPosMatch, 1)) || (sLTargetName == sScriedName) || (sLTargetName == SpliceString(sMatch, nPosMatch, 1)) )) && (sPTargetName != "") && (sTokenTag != "abr_it_scry_kit")) {
								string sPTargetNick = ACR_GetPersistentString(oToken, "sPTargetNick");
								string sLTargetNick = GetLocalString(oToken, "sTargetNick");
								string sScryerName = GetName(oScryer);
								string sPScryerName = ACR_GetPersistentString(oToken, "sPScryerName");
								string sLScryerName = GetLocalString(oToken, "sScryerName");
								int nPosScryer = FindSubString(sScryerName, "'", 0);
								int nScryer = 0; 
								if((sScryerName == sPScryerName) || (sPScryerName == SpliceString(sScryerName, nPosScryer, 1))) {
									nScryer = 1;
									}
								if((sPTargetName == sScriedName) || (sPTargetNick == sMatch) || (sPTargetName == SpliceString(sMatch, nPosMatch, 1)) || (sPTargetNick == SpliceString(sMatch, nPosMatch, 1))|| (sLTargetName == sScriedName) || (sLTargetNick == sMatch) || (sLTargetName == SpliceString(sMatch, nPosMatch, 1)) || (sLTargetNick == SpliceString(sMatch, nPosMatch, 1))) {
									if(FindSubString(sTokenTag, "imag", 0) != -1) {
										nImage = 1;
										if(nConnection < 2) {nConnection = 2;}
										}
									if(FindSubString(sTokenTag, "possess", 0) != -1) {
										nPossession = 1;
										if(nConnection < 4) {nConnection = 4;}
										}
									if(FindSubString(sTokenTag, "body", 0) != -1) {
										nBody = 1;
										if(nConnection < 10) {nConnection = 10;}
										}
										
									if((nScryer == 0) && (FindSubString(sTokenTag, "imag", 0) != -1)) {
										if(nKnowledge < -5) {nKnowledge = -5;}
										}
									
									if(nScryer == 1) {
										if(FindSubString(sTokenTag, "image", 0) != -1) {
											if(nKnowledge < 0) {nKnowledge = 0;}
											}
										if(FindSubString(sTokenTag, "imago", 0) != -1) {
											if(nKnowledge < 5) {nKnowledge = 5;}
											}
										}
									}
								 }
								oToken = GetNextItemInInventory(oScryer);
							}
					
							if(nBody == 1) {
								SendMessageToPC(oScryer, "You are holding a body part that belonged to " + sScriedName + ".");
								}			
							else if(nPossession == 1) {
								SendMessageToPC(oScryer, "You are holding a possession that belonged to " + sScriedName + ".");
								}
							else if(nImage == 1) {
								SendMessageToPC(oScryer, "You are holding an image of " + sScriedName + ".");
								}
											
							if(nConnection == 0) {
								SendMessageToPC(oScryer, "You have no connection to " + sScriedName + ".");
								}
							else if(nConnection == 2) {
								SendMessageToPC(oScryer, "You have a minor connection to " + sScriedName + ".");
								}
							else if(nConnection == 4) {
								SendMessageToPC(oScryer, "You have an average connection to " + sScriedName + ".");
								}
							else if(nConnection == 10) {
								SendMessageToPC(oScryer, "You have a very strong connection to " + sScriedName + ".");
								}	
							 
							if(nKnowledge == -10) {
								SendMessageToPC(oScryer, "You have no knowledge of " + sScriedName + ".");
								}
							else if(nKnowledge == -5) {
								SendMessageToPC(oScryer, "Your knowledge of " + sScriedName + " is secondhand.");
								}
							else if(nKnowledge == 0) {
								SendMessageToPC(oScryer, "Your knowledge of " + sScriedName + " is: firsthand.");
								}
							else if(nKnowledge == 5) {
								SendMessageToPC(oScryer, "Your knowledge of " + sScriedName + " is: familiar.");
								}
															
											
						int nDC = GetLocalInt(OBJECT_SELF, "nScryDC") + nKnowledge + nConnection;
				 		int nCasterLevel = GetLocalInt(OBJECT_SELF, "nCasterLevel");
						int nWillSaveRoll = d20(1);
						int nWillSaveBase = GetLocalInt(OBJECT_SELF, "oScriedWSBase");
						if(nWillSaveBase == 0) {
							nWillSaveBase = GetWillSavingThrow(oScried);
							}
						int nWillSave = nWillSaveRoll + nWillSaveBase;
						if(oScryer == oScried) {
							nWillSave = nDC-1;
						}
						if(GetLocalInt(GetModule(), "DM_Spam") == 0) {
							SendMessageToAllDMs(GetName(oScried) + " rolled a " + IntToString(nWillSave) + " vs DC " + IntToString(nDC) + " against " + GetName(oScryer) + " scrying them."); 
							}
						if(nWillSave >= nDC){
							    SendMessageToPC(oScryer, "You feel your spell fail.");
								SetLocalObject(oScry, "oScrySpeak", OBJECT_INVALID);
								SetLocalObject(oScryer, "oScrySpeak", OBJECT_INVALID);
								if(GetLocalInt(GetModule(), "DM_Spam") == 0) {
									SendMessageToAllDMs(GetName(oScried) + " saved and will not be scried by " + GetName(oScryer));
								}
								if(nWillSave >= nDC + 10){
									SendMessageToPC(oScried, "You have a momentary sense of being watched...but it passes.");
									}
								SetLocalInt(oScry, "nScryActive", 0);
								DestroyObject(OBJECT_SELF, 2.0);
								return;
								}
							
						//If oScried fails their WillSave they become the oScried object
						else {//Add oScried to the collection of objects
							 	SetLocalObject(oScry, "oScried", oScried);
							 	SetLocalObject(OBJECT_SELF, "oScried", oScried);
								SetLocalObject(oScryer, "oScried", oScried);
							 	SetLocalObject(OBJECT_SELF, "oScryer", oScryer);
								SetLocalObject(oScried, "oScryer", oScryer);
								SetLocalObject(oScried, "oScry", oScry);
								SetLocalObject(oScried, "oScrySpeak", OBJECT_SELF);
								location lHere = GetLocation(oScry);
								SetLocalLocation(oScryer, "ACR_SCRY_LOCATION", lHere);
								SetLocalLocation(oScry, "ACR_SCRY_LOCATION", lHere);
								//Notify oScryer and DMs that Scry was successful and set the Scrying Object as active
								if(GetLocalInt(GetModule(), "DM_Spam") == 0) {
									SendMessageToAllDMs(GetName(oScried) + " failed and is being scried by " + GetName(oScryer) + " for the next " + FloatToString(fScryTimer, 2, 0) + " seconds."); 
									}
								SendMessageToPC(oScryer, "You feel your spell overcome " + sScriedName + "'s willpower.");
								SendMessageToPC(oScryer, "Your scrying will last " + FloatToString(fScryTimer, 2, 0) + " seconds.");
								if(GetObjectType(oScry) == OBJECT_TYPE_PLACEABLE) {
									SendMessageToPC(oScryer, "During that time you, as the scryer, may touch the " + GetName(oScry) + " to hear an update on the person being scried.");
								 	}
								SetLocalInt(oScry, "nScryActive", 1);
								effect eIcon = EffectEffectIcon(53);
								ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eIcon, oScryer, fScryTimer);
								
								//Throw oScried a bone if their roll was within 5 of the DC
								if (nWillSave + 5 > nDC) 
								 	{SendMessageToPC(oScryer, "You have a feeling that " + GetName(oScried) + " might have sensed something.");
								 	 SendMessageToPC(oScried, "You feel like someone is watching you.");
								 	 SendMessageToAllDMs( "Saving roll was within 5 of the DC. " + GetName(oScried) + " feels watched.");
								 	}
									
								//Spawn an invisible Scrying Sensor on oScried and add it to the collective
								//Detect Scrying or See Invisible will reveal it
								location lThere = GetLocation(oScried);
								SetLocalLocation(oScry, "lThere", lThere);
								object oScrySend = GetLocalObject(OBJECT_SELF, "oScrySend");
								if(oScrySend == OBJECT_INVALID) {
									if(GetName(oScryer)== "Xavier") {oScrySend = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_scry_send_xavier", lThere);}
									else {oScrySend = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_scry_send", lThere);}
					            	SetLocalObject(oScry, "oScrySend", oScrySend);
									SetLocalObject(OBJECT_SELF, "oScrySend", oScrySend);
									SetLocalObject(oScryer, "oScrySend", oScrySend);
									SetLocalObject(oScried, "oScrySend", oScrySend);
									
									SetLocalObject(oScrySend, "oScrySpeak", OBJECT_SELF);
									SetLocalObject(oScrySend, "oScried", oScried);
									SetLocalObject(oScrySend, "oScryer", oScryer);
									SetLocalObject(oScrySend, "oScry", oScry);
									
									SetFirstName(oScrySend, "Scrying Sensor");
									SetLocalInt(oScrySend, "nCasterLevel", nCasterLevel);
									DelayCommand(2.0, AssignCommand(oScrySend, ActionForceFollowObject(oScried, 0.5f, 0)));
									}
									
									
								// Make the PC completely invisible
								 effect eVFX   = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);
								 effect eGhost = EffectCutsceneGhost();
								 effect eFreeze = EffectCutsceneImmobilize();
								 
								 float fAway = 60.0;
								 object oScrySelf;
								 
								ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVFX, oScryer, fAway);
								ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGhost, oScryer, fAway);
									 		
								// Dupe the PC to leave Dupe behind. Possessed NPC Dupes can't be destroyed, so don't do that?
								object oDupe;
								if(!GetIsDMPossessed(oScryer)) {
									oDupe = CopyObject(oScryer, GetLocation(oScryer), OBJECT_INVALID, "003_cr_scry_dupe");
									ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFreeze, oScryer, fAway);
									}
								else {
									string sDupeRes = GetResRef(oScryer);
									oDupe = CreateObject(OBJECT_TYPE_CREATURE, sDupeRes, GetLocation(oScryer));
									}
											
								SetLocalObject(oScryer, "oDupe", oDupe);
								ChangeToStandardFaction(oDupe, STANDARD_FACTION_COMMONER);
								ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFreeze, oDupe, fAway);
								DelayCommand(fAway - 1.5, SetLocalObject(oScryer, "oDupe", OBJECT_INVALID));
								DestroyObject(oDupe, fAway);
											
								oScrySelf = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_scry_self", GetLocation(oScry));
								SetLocalObject(oScrySelf, "oScryer", oScryer);
								SetLocalObject(oScrySelf, "oScried", oScried);
								SetLocalObject(oScrySend, "oScrySelf", oScrySelf);
								SetLocalObject(oScryer, "oScrySelf", oScrySelf);
								ChangeToStandardFaction(oScrySelf, STANDARD_FACTION_COMMONER);
								ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFreeze, oScrySelf, fScryTimer);
								DestroyObject(oScrySelf, fAway);
								// Follow the target UNTIL the spell expires - THIS MUST BE DONE LAST!
								DelayCommand(4.0, FadeToBlack(oScryer, FADE_SPEED_SLOWEST, 5.0));
									    
								// Jump to the target
								DelayCommand(5.0, AssignCommand(oScryer, JumpToLocation(lThere)));
									
								// Stop whatever it is we're doing
							    DelayCommand(fAway - 0.5, AssignCommand(oScryer, ClearAllActions(TRUE)));
								DelayCommand(fAway, AssignCommand(oScryer, JumpToLocation(lHere)));
								
								ActionSpeakString("Every person within 10 feet can see the images in the " + GetName(oScry) + " as clearly as if the viewer is there.", TALKVOLUME_TALK);
								object oViewerA;
								object oViewerB;
								object oViewerC;
								object oViewerD;
								object oViewerE;
								object oViewerF;
								object oViewerG;
								object oViewerH;
									
								int nViewer = 1;
								object oViewer = GetFirstObjectInShape(SHAPE_SPHERE, 5.0, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE); 	
								while((nViewer < 15) && (oViewer != OBJECT_INVALID)) {
									if((oViewer != oScryer) && (GetName(oViewer) != GetName(GetLocalObject(oScry, "oViewerA"))) && (GetName(oViewer) != GetName(GetLocalObject(oScry, "oViewerB"))) && (GetName(oViewer) != GetName(GetLocalObject(oScry, "oViewerC"))) && (GetName(oViewer) != GetName(GetLocalObject(oScry, "oViewerD"))) && (GetName(oViewer) != GetName(GetLocalObject(oScry, "oViewerE"))) && (GetName(oViewer) != GetName(GetLocalObject(oScry, "oViewerF"))) && (GetName(oViewer) != GetName(GetLocalObject(oScry, "oViewerG"))) && (GetName(oViewer) != GetName(GetLocalObject(oScry, "oViewerH"))) && (GetName(oViewer) != GetName(oScried)) && (oViewer != OBJECT_SELF) && (oViewer != oScried) && (oViewer != oScrySend) && (oViewer != oScrySelf)) {
										location lViewer = GetLocation(oViewer);
										SetLocalLocation(oViewer, "lHere", lViewer);
										if(nViewer == 1) {
											oViewerA = oViewer;
											SetLocalObject(oScry, "oViewerA", oViewer);
											SetLocalObject(oScrySend, "oViewerA", oViewer);
											SetLocalLocation(oScry, "lViewerA", lViewer);
											}
										if(nViewer == 2) {
											oViewerB = oViewer;
											SetLocalObject(oScry, "oViewerB", oViewer);
											SetLocalObject(oScrySend, "oViewerB", oViewer);
											SetLocalLocation(oScry, "lViewerB", lViewer);
											}
										if(nViewer == 3) {
											oViewerC = oViewer;
											SetLocalObject(oScry, "oViewerC", oViewer);
											SetLocalObject(oScrySend, "oViewerC", oViewer);
											SetLocalLocation(oScry, "lViewerC", lViewer);
											}
										if(nViewer == 4) {
											oViewerD = oViewer;
											SetLocalObject(oScry, "oViewerD", oViewer);
											SetLocalObject(oScrySend, "oViewerD", oViewer);
											SetLocalLocation(oScry, "lViewerD", lViewer);
											}
										if(nViewer == 5) {
											oViewerE = oViewer;
											SetLocalObject(oScry, "oViewerE", oViewer);
											SetLocalObject(oScrySend, "oViewerE", oViewer);
											SetLocalLocation(oScry, "lViewerE", lViewer);
											}
										if(nViewer == 6) {
											oViewerF = oViewer;
											SetLocalObject(oScry, "oViewerF", oViewer);
											SetLocalObject(oScrySend, "oViewerF", oViewer);
											SetLocalLocation(oScry, "lViewerF", lViewer);
											}
										if(nViewer == 7) {
											oViewerG = oViewer;
											SetLocalObject(oScry, "oViewerG", oViewer);
											SetLocalObject(oScrySend, "oViewerG", oViewer);
											SetLocalLocation(oScry, "lViewerG", lViewer);
											}
										if(nViewer == 8) {
											oViewerH = oViewer;
											SetLocalObject(oScry, "oViewerH", oViewer);
											SetLocalObject(oScrySend, "oViewerH", oViewer);
											SetLocalLocation(oScry, "lViewerH", lViewer);
											}
											
										object oDupeView;
										if(GetTag(oViewer) != GetTag(oScried)) {
											if(!GetIsDMPossessed(oViewer)) {
												oDupeView = CopyObject(oViewer, GetLocation(oViewer), OBJECT_INVALID, "003_cr_scry_dupe");
												}
											else {
												string sDupeResView = GetResRef(oViewer);
												oDupeView = CreateObject(OBJECT_TYPE_CREATURE, sDupeResView, GetLocation(oViewer));
												}
											}		
										SetLocalObject(oViewer, "oDupe", oDupeView);
										SetLocalObject(oScry, "oDupe", oDupeView);
										ChangeToStandardFaction(oDupeView, STANDARD_FACTION_COMMONER);
										ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFreeze, oDupeView, fAway);
										DelayCommand(fAway - 1.5, SetLocalObject(oViewer, "oDupe", OBJECT_INVALID));
										DestroyObject(oDupeView, fAway);
										
										SetLocalLocation(oViewer, "lScryView", GetLocation(oViewer));
										if(GetLocalInt(GetModule(), "DM_Spam") == 0) {
											SendMessageToAllDMs("Scryer " + GetName(oScryer) + " jumping to " + GetName(GetAreaFromLocation(lThere)));
											}
										DelayCommand(4.0, FadeToBlack(oViewer, FADE_SPEED_SLOWEST, 5.0));
										DelayCommand(5.0, AssignCommand(oViewer, JumpToLocation(lThere)));
										DelayCommand(5.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVFX, oViewer, fAway));
										DelayCommand(5.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGhost, oViewer, fAway));
										DelayCommand(5.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFreeze, oViewer, fAway));
										DelayCommand(fAway - 1.0, AssignCommand(oViewer, ClearAllActions(TRUE)));
										DelayCommand(fAway, AssignCommand(oViewer, JumpToLocation(lViewer)));
										}
										
								nViewer++;
								oViewer = GetNextObjectInShape(SHAPE_SPHERE, 5.0, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE); 
								}
									
								//Find out information about oScried's area and area weather
								object oArea = GetArea(oScried);
								string sSubjectArea = GetLocalString(oScried, "ACR_SCRY_AREA_DESC");
								if(sSubjectArea == "") {
									sSubjectArea = GetLocalString(oArea, "ACR_AREA_DESC");
									}
								string sAreaTag = GetTag(oArea);
								 
								if(sSubjectArea == "") {
									if(FindSubString(sAreaTag, "caravan", 0) != -1) 
										{sSubjectArea = "inside a caravan.";}
									else if(FindSubString(sAreaTag, "ferry", 0) != -1)
										{sSubjectArea = "on a ferry.";}
									else if(FindSubString(sAreaTag, "int_highforest_cave_aq", 0) != -1)
										{sSubjectArea = "inside a darkened ruin in which the sound of water runs all around.";}
									 else if((FindSubString(sAreaTag, "cave", 0) != -1) || (FindSubString(sAreaTag, "cavern", 0) != -1))
										{sSubjectArea = "inside a natural cave.";}
									else if((FindSubString(sAreaTag, "tavern", 0) != -1) || (FindSubString(sAreaTag, "brightblade", 0) != -1) || (FindSubString(sAreaTag, "angler", 0) != -1)  || (FindSubString(sAreaTag, "flagon", 0) != -1) )
										{sSubjectArea = "inside a tavern, tables and a long bar visible.";}
									else if((FindSubString(sAreaTag, "crypt", 0) != -1) || (FindSubString(sAreaTag, "mausoleum", 0) != -1)  || (FindSubString(sAreaTag, "tomb", 0) != -1)|| (FindSubString(sAreaTag, "catacomb", 0) != -1) )
										{sSubjectArea = "inside a crypt, surrounded by the bones of the dead.";}
									else if(FindSubString(sAreaTag, "mine", 0) != -1)
										{sSubjectArea = "inside hand-carved tunnels, with the tracks of a minecart visible.";}
									else if(FindSubString(sAreaTag, "ruins", 0) != -1)
										{sSubjectArea = "inside crumbling ruins.";}
									else if(FindSubString(sAreaTag, "sewer", 0) != -1)
										{sSubjectArea = "inside a fetid sewer.";}
									else if(FindSubString(sAreaTag, "stable", 0) != -1)
										{sSubjectArea = "inside a stable, horses in their stalls.";}
									else if((FindSubString(sAreaTag, "ext_highway", 0) != -1) || (FindSubString(sAreaTag, "ext_river_road", 0) != -1))
										{sSubjectArea = "outside, on a well-travelled highway beside a major river.";}
									else if((FindSubString(sAreaTag, "temple", 0) != -1) || (FindSubString(sAreaTag, "chapel", 0) != -1)  || (FindSubString(sAreaTag, "lathander", 0) != -1))
										{sSubjectArea = "inside a temple, judging by the decor and the sound of prayer.";}
									else if((FindSubString(sAreaTag, "_inn", 0) != -1) || (FindSubString(sAreaTag, "griffon_up", 0) != -1) || (FindSubString(sAreaTag, "troll", 0) != -1))
										{sSubjectArea = "inside a cosy inn room.";}
									else if(FindSubString(sAreaTag, "_argent", 0) != -1)
										{sSubjectArea = "inside an argent legion outpost, the arms and insignia of the military all around.";}
									else if(FindSubString(sAreaTag, "bigtp", 0) != -1)
										{sSubjectArea = "inside a circus big top tent.";}
									else if(FindSubString(sAreaTag, "int_cards", 0) != -1)
										{sSubjectArea = "inside a tent, with card tables visible.";}
									else if(FindSubString(sAreaTag, "int_mirror", 0) != -1)
										{sSubjectArea = "inside a tent, with many mirrors seemingly on display.";}
									else if(FindSubString(sAreaTag, "circus_xyz", 0) != -1)
										{sSubjectArea = "tied down within an arena, sandy floor soaked with bloody stains, circled by axe-bearing minotaurs.";}
									else if(FindSubString(sAreaTag, "circus", 0) != -1)
										{sSubjectArea = "outside, within site of circus exhibits.";}
									else if(FindSubString(sAreaTag, "4c_ext", 0) != -1)
										{sSubjectArea = "outside, beside the bank of a mighty river flowing through an icy alpine evergreen forest.";}
									else if(FindSubString(sAreaTag, "ext_frosthills", 0) != -1)
										{sSubjectArea = "outside, with the peaks of the Frost Hills rising all around.";
										 if(FindSubString(sAreaTag, "fourth", 0) != -1)
										 	{sSubjectArea = sSubjectArea + " The fort of Fourthpeak is visible commanding the heights.";}
										 else if(FindSubString(sAreaTag, "lake", 0) != -1)
										 	{sSubjectArea = sSubjectArea + " A deep alpine lake shimmers nearby.";}
										 else if(FindSubString(sAreaTag, "glacier_tr", 0) != -1)
										 	{sSubjectArea = sSubjectArea + " A trail winds up into the frozen heights of a glacier.";}
										 else if((FindSubString(sAreaTag, "glacier_settle", 0) != -1) || (FindSubString(sAreaTag, "settlestone", 0) != -1))
										 	{sSubjectArea = sSubjectArea + " Narrow walls enclose a small settlement.";}
										 else if(FindSubString(sAreaTag, "glacier_keeper", 0) != -1)
										 	{sSubjectArea = sSubjectArea + " A forbidding pair of gates inscribed with dwarven runes blocks the way ahead.";}
										 else if(FindSubString(sAreaTag, "glacier", 0) != -1)
										 	{sSubjectArea = sSubjectArea + " A glacial waste of icy and snow stretches in all directions.";}
										 else if(FindSubString(sAreaTag, "road", 0) != -1)
										 	{sSubjectArea = sSubjectArea + " A road wends ahead beside a massive stone cliff, as far as can be seen.";}
										}
									else if(FindSubString(sAreaTag, "int_fourthpeak", 0) != -1) 
										{sSubjectArea = "inside a rocky cave.";}
									else if(FindSubString(sAreaTag, "int_frosthills_glacier_plat", 0) != -1) 
										{sSubjectArea = "enclosed by walls of ice-shrouded marble.";}
									else if(FindSubString(sAreaTag, "int_frosthills_glacier_snkg", 0) != -1) 
										{sSubjectArea = "inside dark ruins with icicles hanging from the ceiling.";}
									else if(FindSubString(sAreaTag, "int_frosthills_glacier_tr", 0) != -1) 
										{sSubjectArea = "within a natural cave of ice and snow-covered rock.";}
									else if(FindSubString(sAreaTag, "int_frosthills_mh1", 0) != -1) 
										{sSubjectArea = "sheltered by ponderous stone walls inscribed with dwarven runes. Armored dwarves pass within view.";}
									else if(FindSubString(sAreaTag, "int_settlestone_dotr", 0) != -1)
										{sSubjectArea = "inside some ancient dungeon.";}
									else if((FindSubString(sAreaTag, "int_frosthills_settlestone", 0) != -1) || (FindSubString(sAreaTag, "int_settlestone", 0) != -1)) 
										{sSubjectArea = "inside, but through a window may be seen the ruined walls of Settlestone.";}
									else if(FindSubString(sAreaTag, "ext_moonwood_winter", 0) != -1)
										{sSubjectArea = "on the fringe of a forest of evergreen trees, with the palisade of Winter Edge visible.";}
									else if(FindSubString(sAreaTag, "ext_moonwood_quaer", 0) != -1)
										{sSubjectArea = "on the edge of an ancient forest, with the walls and guards of Quaervarr in sight.";}
									else if(FindSubString(sAreaTag, "ext_moonwood", 0) != -1) 
										{sSubjectArea = "within a deep forest of evergreen trees.";}
									else if(FindSubString(sAreaTag, "ext_surbin", 0) != -1) 
										{sSubjectArea = "in rolling hills with a broad river in sight.";}
									else if(FindSubString(sAreaTag, "int_herald", 0) != -1) 
										{sSubjectArea = "inside, with beautiful furnishings and shelves of books visible.";}
									else if((FindSubString(sAreaTag, "int_we_", 0) != -1) || (FindSubString(sAreaTag, "int_wintedge_", 0) != -1))
										{sSubjectArea = "inside a rustic building, with the top of Winter Edge's pallisade visible through a window.";}
									else if(FindSubString(sAreaTag, "treecity", 0) != -1)
										{sSubjectArea = "within a structure that appears to be carved inside curving walls of oakwood.";}
									else if(FindSubString(sAreaTag, "int_quaer", 0) != -1)
										{sSubjectArea = "inside a rustic structure with the pallisade walls of Quaervarr visible through a window.";}
									else if(FindSubString(sAreaTag, "5f_ext_nether", 0) != -1)
										{sSubjectArea = "outside, in mountainous terrain, with immensely tall peaks rising all around.";}
									else if(FindSubString(sAreaTag, "int_nether_dt", 0) != -1)
										{sSubjectArea = "inside a gloomy ruin.";}
									else if(FindSubString(sAreaTag, "ext_fellbar", 0) != -1)
										{sSubjectArea = "outside in icy heights, among the dwarven bastions of Felbarr.";}
									else if(FindSubString(sAreaTag, "ext_silvypass_east_auv", 0) != -1)
										{sSubjectArea = "outside, with a mountain road winding up to the walls of Auvendell visible.";}
									else if(FindSubString(sAreaTag, "ext_silvypass_east_sund", 0) != -1)
										{sSubjectArea = "outside, on a road surrounded by mountains, with road cairns labeled with the distance to Sundabar and Citadel Felbarr.";}
									else if(FindSubString(sAreaTag, "int_auvandell", 0) != -1)
										{sSubjectArea = "inside stone walls, with the gates of Auvandell visible through a window.";}
									else if(FindSubString(sAreaTag, "int_felbarr_lowroad", 0) != -1)
										{sSubjectArea = "inside a gloomy subterranean passage, with dwarven archways and the marks of dwarven axes visible, but not fresh.";}
									else if(FindSubString(sAreaTag, "int_felbarr", 0) != -1)
										{sSubjectArea = "inside stone walls of obvious dwarven engineering, thickly inscribed with dwarven runes.";}
									else if(FindSubString(sAreaTag, "ext_sundabar", 0) != -1)
										{sSubjectArea = "outside, on the busy streets of Sundabar.";}
									else if(FindSubString(sAreaTag, "int_sundabar_everfire", 0) != -1)
										{sSubjectArea = "inside a chamber where blindingly bright lava flows.";}
									else if(FindSubString(sAreaTag, "int_sundabar_lava", 0) != -1)
										{sSubjectArea = "inside a dark tunnel, its walls made of blackened, cooled lava.";}
									else if(FindSubString(sAreaTag, "int_sundabar", 0) != -1)
										{sSubjectArea = "inside a building, near a window showing the busy streets of Sundabar.";}
									else if(FindSubString(sAreaTag, "ext_evermoors", 0) != -1)
										{sSubjectArea = "outside, surrounded by the endless horizon of a swampy marshland.";}
									else if(FindSubString(sAreaTag, "ext_rivmoot", 0) != -1)
										{sSubjectArea = "in the immediately recognizable vicinity of Rivermoot.";}
									else if(FindSubString(sAreaTag, "int_rivmoot", 0) != -1)
										{sSubjectArea = "in a rustic structure, with the protected main courtyard of Rivermoot visible through a window.";}
									else if(FindSubString(sAreaTag, "ext_highhold", 0) != -1)
										{sSubjectArea = "outside, with the riverbank and the well-guarded entrance to High Hold visible.";}
									else if(FindSubString(sAreaTag, "int_clock", 0) != -1)
										{sSubjectArea = "inside what seems to be a tower room scattered with goods of obviously gnomish make.";}
									else if(FindSubString(sAreaTag, "int_hh_", 0) != -1)
										{sSubjectArea = "inside rough stone walls, with the torchlit entrance to High Hold visible through a nearby window.";}
									else if(FindSubString(sAreaTag, "ext_north_road", 0) != -1)
										{sSubjectArea = "outside, on a bleak highway through stony land.";}
									else if(FindSubString(sAreaTag, "ext_rauvenwatch", 0) != -1)
										{sSubjectArea = "outside, with the imposing walls of Rauvenwatch Keep visible.";}
									else if(FindSubString(sAreaTag, "moon_mielikki", 0) != -1)
										{sSubjectArea = "outside, in the peace of Mielikki's Grove in Silverymoon";}
									else if(FindSubString(sAreaTag, "silverymoon_surround", 0) != -1)
										{sSubjectArea = "outside the walls of Silverymoon.";}
									else if(FindSubString(sAreaTag, "ext_silvery", 0) != -1)
										{sSubjectArea = "outside, on busy streets that could only belong to Silverymoon.";}
									else if(FindSubString(sAreaTag, "ext_silvy_ladycol", 0) != -1)
										{sSubjectArea = "outside, on an expansive rooftop overlooking the city of Silverymoon.";}
									else if(FindSubString(sAreaTag, "int_rwkeep", 0) != -1)
										{sSubjectArea = "inside thick stone walls, with a window showing the courtyard of Rauvenwatch Keep.";}
									else if(FindSubString(sAreaTag, "int_silvy_constab", 0) != -1)
										{sSubjectArea = "inside a constabulary.";}
									else if(FindSubString(sAreaTag, "int_silvy_everdusk", 0) != -1)
										{sSubjectArea = "inside a building of quiet beauty, marble carved into the shapes of trees, with the sound of running water and elven voices praising the Seldarine.";}
									else if(FindSubString(sAreaTag, "int_silvy_foch", 0) != -1)
										{sSubjectArea = "inside a tall dim building, with the pennants of dramatic performances overhanging stage and walls, with a background of bardsong and the sound of clapping audiences.";}
									else if(FindSubString(sAreaTag, "int_silvy_ladycol_grd", 0) != -1)
										{sSubjectArea = "inside, with a huge library and wings off to dormitory towers visible through an open door.";}
									else if(FindSubString(sAreaTag, "int_silvy_ladycol_class", 0) != -1)
										{sSubjectArea = "inside, with the doors to classrooms opening and closing for robed masters and students.";}
									else if((FindSubString(sAreaTag, "int_silvy_ladycol", 0) != -1) || (FindSubString(sAreaTag, "int_silvy_palace", 0) != -1) || (FindSubString(sAreaTag, "derochelle", 0) != -1) )
										{sSubjectArea = "inside walls...but the details are blurred, as if you are denied seeing them.";}
									else if((FindSubString(sAreaTag, "int_silvy_vault", 0) != -1) || (FindSubString(sAreaTag, "int_silvy_palace", 0) != -1) )
										{sSubjectArea = "inside, surrounded by walls of floor to ceiling bookshelves.";}
									else if(FindSubString(sAreaTag, "int_silvy", 0) != -1)
										{sSubjectArea = "inside, with a window showing the busy streets that could only belong to Silverymoon.";}
									else if(FindSubString(sAreaTag, "ext_khelb", 0) != -1)
										{sSubjectArea = "outside, with the walls of Khelb visible.";}
									else if(FindSubString(sAreaTag, "int_silvypass_central", 0) != -1)
										{sSubjectArea = "outside, amid rarified peaks of ice and snow.";}
									else if((FindSubString(sAreaTag, "ext_silvypass", 0) != -1) || (FindSubString(sAreaTag, "ext_nether", 0) != -1))
										{sSubjectArea = "outside, on a well-travelled but remote highway between high peaks.";}
									else if(FindSubString(sAreaTag, "int_khelb", 0) != -1)
										{sSubjectArea = "inside, with the walls of Khelb visible through a window.";}
									else if(FindSubString(sAreaTag, "int_nether_flying", 0) != -1)
										{sSubjectArea = "inside a tavern, with a window showing a busy highway and a stable.";}
									else if(FindSubString(sAreaTag, "int_silvypass_hkn", 0) != -1)
										{sSubjectArea = "inside a cramped fort, filled with weapons racks and bunks.";}
									else if(FindSubString(sAreaTag, "int_silvypass_crystal", 0) != -1)
										{sSubjectArea = "inside a ruin filled with crystal outcroppings.";}
									else if((FindSubString(sAreaTag, "int_silvypass_delzo", 0) != -1) || (FindSubString(sAreaTag, "int_silvypass_path", 0) != -1) || (FindSubString(sAreaTag, "int_silvypass_spider", 0) != -1))
										{sSubjectArea = "inside, with rocky walls, cobwebs and ruined dwarven tunnels all visible.";}
									else if(FindSubString(sAreaTag, "int_silvypass", 0) != -1)
										{sSubjectArea = "inside, surrounded by stone and the signs of dwarven occupancy.";}
									else if(FindSubString(sAreaTag, "ext_rauvin", 0) != -1)
										{sSubjectArea = "outside, beneath trees overlooking a river valley.";}
									else if(FindSubString(sAreaTag, "ext_silverwood", 0) != -1)
										{sSubjectArea = "outside, with only trees visible in all directions.";}
									else if(FindSubString(sAreaTag, "ext_highforest_olostin", 0) != -1)
										{sSubjectArea = "outside, with the keep of Olostin's Hold visible on its high plateau.";}
									else if(FindSubString(sAreaTag, "int_highforest_cw_rillifane", 0) != -1)
										{sSubjectArea = "inside a dimly lit cavern filled with plantlife and the ripple of running water.";}
									else if(FindSubString(sAreaTag, "int_highforest_north_tree", 0) != -1)
										{sSubjectArea = "inside a huge hollow tree, judging by the look of the curving walls.";}
									else if(FindSubString(sAreaTag, "int_highforest_olostin", 0) != -1)
										{sSubjectArea = "inside a richly-appointed but martial keep.";}
								    else if(FindSubString(sAreaTag, "8e_int_highforest_cntrl_fort", 0) != -1)
										{sSubjectArea = "inside a dim ruin, walls crumbling.";}
									else if(FindSubString(sAreaTag, "oh_apple", 0) != -1)
										{sSubjectArea = "inside a cosy cottage of wood and stained glass windows.";}
			
											
										
									else if((FindSubString(sAreaTag, "_int_", 0) != -1) && (FindSubString(sAreaTag, "interior", 0) != -1)) 
										{sSubjectArea = "inside, though nothing uniquely identifiable is visible.";}
									else if(FindSubString(sAreaTag, "_ext_", 0) != -1)
										{sSubjectArea = "outside, though nothing uniquely identifiable is visible.";}
									else {sSubjectArea = "somewhere where you can see no identifying details of the surroundings.";}	
									
								}
									
								int nWeatherRain = GetWeather(oArea, WEATHER_TYPE_RAIN);
								string sWeatherRain = "";
								int nWeatherSnow = GetWeather(oArea, WEATHER_TYPE_SNOW);
								string sWeatherSnow = "";
								int nHour = GetTimeHour();
								int nDay = TRUE;
								if((nHour >= 18) || (nHour <= 6))
									{nDay = FALSE;}
								
								if(FindSubString(sAreaTag, "ext", 1) != -1)
								   {if((nWeatherRain == 0)  && (nDay == TRUE))
										{sWeatherRain = "The sun is shining. ";}
									if((nWeatherRain == 0)  && (nDay == FALSE))
										{sWeatherRain = "It is a clear night. ";}
									if(nWeatherRain == 1)  
										{sWeatherRain = "It is drizzling rain. ";}
									if(nWeatherRain == 2)  
										{sWeatherRain = "It is raining lightly. ";}
									if(nWeatherRain == 3)  
										{sWeatherRain = "Rain is falling. ";}
									if(nWeatherRain == 4)  
										{sWeatherRain = "Rain is pouring down. ";}
									if(nWeatherRain == 5)  
										{sWeatherRain = "A storm rages. ";}
										
									if(nWeatherSnow == 1)  
										{sWeatherSnow = "A few flakes of snow are falling. ";}
									if(nWeatherSnow == 2)  
										{sWeatherSnow = "It is snowing lightly. ";}
									if(nWeatherSnow == 3)  
										{sWeatherSnow = "Snow is falling. ";}
									if(nWeatherSnow == 4)  
										{sWeatherSnow = "Snow is falling heavily. ";}
									if(nWeatherSnow == 5)  
										{sWeatherSnow = "A blizzard rages. ";}
									}
									
								
								string sGenderNoun = "He";
								string sGenderAdj = "him";
								if(GetGender(oScried) == GENDER_FEMALE) {
									sGenderNoun = "She";
									sGenderAdj = "her";
								}
								
								//Speak oScried's area and weather description 
								ActionSpeakString( GetName(oScried) + " is " + sSubjectArea + " " + sWeatherRain + sWeatherSnow, TALKVOLUME_TALK);
								SendMessageToPC(oScryer, GetName(oScried) + " is " + sSubjectArea + " " + sWeatherRain + sWeatherSnow);
								
								
								SetLocalLocation(OBJECT_SELF, "lScryStart", GetLocation(oScried));
								location lStart = GetLocalLocation(OBJECT_SELF, "lScryStart");
								//Determine what creatures and objects are near oScried	
								object oObject = GetFirstObjectInShape(SHAPE_SPHERE, 10.0, GetLocation(oScried), FALSE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_ITEM | OBJECT_TYPE_PLACED_EFFECT | OBJECT_TYPE_DOOR);
								string sObjectName = GetName(oObject);
								float fDistance = GetDistanceBetween(oScried, oObject);
								int nInc = 1;
								string sNextTo;
								string sFurther;
								string sOther;
								while //(
								(oObject != OBJECT_INVALID) 
									//&& (nInc <= 12))
									{
									oObject = GetNextObjectInShape(SHAPE_SPHERE, 10.0, GetLocation(oScried), FALSE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_ITEM | OBJECT_TYPE_PLACED_EFFECT | OBJECT_TYPE_DOOR);
								    sObjectName = GetName(oObject);
									fDistance = GetDistanceBetween(oScried, oObject);
									if((sObjectName != GetName(oScried)) && (sObjectName != "")) {
									
											//string sObjectNameA = GetName(oObject);
											//float fDistanceA = GetDistanceBetween(oScried, oObject);
											sNextTo = GetLocalString(OBJECT_SELF, "sNextTo");
											sFurther = GetLocalString(OBJECT_SELF, "sFurther");
											sOther = GetLocalString(OBJECT_SELF, "sOther");
											int nObjectType = GetObjectType(oObject);
											if((nObjectType == OBJECT_TYPE_CREATURE) && (fDistance < 3.0))
												{SetLocalString(OBJECT_SELF, "sNextTo",  sNextTo + " and " + sObjectName);}
											else if(nObjectType == OBJECT_TYPE_CREATURE)
												{SetLocalString(OBJECT_SELF, "sFurther", sFurther + " and " + sObjectName);}
											else {SetLocalString(OBJECT_SELF, "sOther",  sOther + " and " + sObjectName);}
									
								    	/*if(nInc == 1) {
											string sObjectNameA = GetName(oObject);
											float fDistanceA = GetDistanceBetween(oScried, oObject);
											int nObjectTypeA = GetObjectType(oObject);
											if((nObjectTypeA == OBJECT_TYPE_CREATURE) && (fDistanceA < 3.0))
												{SetLocalString(OBJECT_SELF, "sNextToA", sObjectNameA);}
											else if(nObjectTypeA == OBJECT_TYPE_CREATURE)
												{SetLocalString(OBJECT_SELF, "sFurtherA", sObjectNameA);}
											else {SetLocalString(OBJECT_SELF, "sOtherA", sObjectNameA);}
											}
										else if(nInc == 2) {
											string sObjectNameB = GetName(oObject);
											float fDistanceB = GetDistanceBetween(oScried, oObject);
											int nObjectTypeB = GetObjectType(oObject);
											if((nObjectTypeB == OBJECT_TYPE_CREATURE) && (fDistanceB < 3.0))
												{SetLocalString(OBJECT_SELF, "sNextToB", sObjectNameB);}
											else if(nObjectTypeB == OBJECT_TYPE_CREATURE)
												{SetLocalString(OBJECT_SELF, "sFurtherB", sObjectNameB);}
											else {SetLocalString(OBJECT_SELF, "sOtherB", sObjectNameB);}
											}
										else if(nInc == 3) {
											string sObjectNameC = GetName(oObject);
											float fDistanceC = GetDistanceBetween(oScried, oObject);
											int nObjectTypeC = GetObjectType(oObject);
											if((nObjectTypeC == OBJECT_TYPE_CREATURE) && (fDistanceC < 3.0))
												{SetLocalString(OBJECT_SELF, "sNextToC", sObjectNameC);}
											else if(nObjectTypeC == OBJECT_TYPE_CREATURE)
												{SetLocalString(OBJECT_SELF, "sFurtherC", sObjectNameC);}
											else {SetLocalString(OBJECT_SELF, "sOtherC", sObjectNameC);}
											}
										else if(nInc == 4) {
											string sObjectNameD = GetName(oObject);
											float fDistanceD = GetDistanceBetween(oScried, oObject);
											int nObjectTypeD = GetObjectType(oObject);
											if((nObjectTypeD == OBJECT_TYPE_CREATURE) && (fDistanceD < 3.0))
												{SetLocalString(OBJECT_SELF, "sNextToD", sObjectNameD);}
											else if(nObjectTypeD == OBJECT_TYPE_CREATURE)
												{SetLocalString(OBJECT_SELF, "sFurtherD", sObjectNameD);}
											else {SetLocalString(OBJECT_SELF, "sOtherD", sObjectNameD);}
											}
										if(nInc == 5) {
											string sObjectNameE = GetName(oObject);
											float fDistanceE = GetDistanceBetween(oScried, oObject);
											int nObjectTypeE = GetObjectType(oObject);
											if((nObjectTypeE == OBJECT_TYPE_CREATURE) && (fDistanceE < 3.0))
												{SetLocalString(OBJECT_SELF, "sNextToE", sObjectNameE);}
											else if(nObjectTypeE == OBJECT_TYPE_CREATURE)
												{SetLocalString(OBJECT_SELF, "sFurtherE", sObjectNameE);}
											else {SetLocalString(OBJECT_SELF, "sOtherE", sObjectNameE);}
											}
										else if(nInc == 6) {
											string sObjectNameF = GetName(oObject);
											float fDistanceF = GetDistanceBetween(oScried, oObject);
											int nObjectTypeF = GetObjectType(oObject);
											if((nObjectTypeF == OBJECT_TYPE_CREATURE) && (fDistanceF < 3.0))
												{SetLocalString(OBJECT_SELF, "sNextToF", sObjectNameF);}
											else if(nObjectTypeF == OBJECT_TYPE_CREATURE)
												{SetLocalString(OBJECT_SELF, "sFurtherF", sObjectNameF);}
											else {SetLocalString(OBJECT_SELF, "sOtherF", sObjectNameF);}
											}
										else if(nInc == 7) {
											string sObjectNameG = GetName(oObject);
											float fDistanceG = GetDistanceBetween(oScried, oObject);
											int nObjectTypeG = GetObjectType(oObject);
											if((nObjectTypeG == OBJECT_TYPE_CREATURE) && (fDistanceG < 3.0))
												{SetLocalString(OBJECT_SELF, "sNextToG", sObjectNameG);}
											else if(nObjectTypeG == OBJECT_TYPE_CREATURE)
												{SetLocalString(OBJECT_SELF, "sFurtherG", sObjectNameG);}
											else {SetLocalString(OBJECT_SELF, "sOtherG", sObjectNameG);}
											}
										else if(nInc == 8) {
											string sObjectNameH = GetName(oObject);
											float fDistanceH = GetDistanceBetween(oScried, oObject);
											int nObjectTypeH = GetObjectType(oObject);
											if((nObjectTypeH == OBJECT_TYPE_CREATURE) && (fDistanceH < 3.0))
												{SetLocalString(OBJECT_SELF, "sNextToH", sObjectNameH);}
											else if(nObjectTypeH == OBJECT_TYPE_CREATURE)
												{SetLocalString(OBJECT_SELF, "sFurtherH", sObjectNameH);}
											else {SetLocalString(OBJECT_SELF, "sOtherH", sObjectNameH);}
											}
										if(nInc == 9) {
											string sObjectNameI = GetName(oObject);
											float fDistanceI = GetDistanceBetween(oScried, oObject);
											int nObjectTypeI = GetObjectType(oObject);
											if((nObjectTypeI == OBJECT_TYPE_CREATURE) && (fDistanceI < 3.0))
												{SetLocalString(OBJECT_SELF, "sNextToI", sObjectNameI);}
											else if(nObjectTypeI == OBJECT_TYPE_CREATURE)
												{SetLocalString(OBJECT_SELF, "sFurtherI", sObjectNameI);}
											else {SetLocalString(OBJECT_SELF, "sOtherI", sObjectNameI);}
											}
										else if(nInc == 10) {
											string sObjectNameJ = GetName(oObject);
											float fDistanceJ = GetDistanceBetween(oScried, oObject);
											int nObjectTypeJ = GetObjectType(oObject);
											if((nObjectTypeJ == OBJECT_TYPE_CREATURE) && (fDistanceJ < 3.0))
												{SetLocalString(OBJECT_SELF, "sNextToJ", sObjectNameJ);}
											else if(nObjectTypeJ == OBJECT_TYPE_CREATURE)
												{SetLocalString(OBJECT_SELF, "sFurtherJ", sObjectNameJ);}
											else {SetLocalString(OBJECT_SELF, "sOtherJ", sObjectNameJ);}
											}
										else if(nInc == 11) {
											string sObjectNameK = GetName(oObject);
											float fDistanceK = GetDistanceBetween(oScried, oObject);
											int nObjectTypeK = GetObjectType(oObject);
											if((nObjectTypeK == OBJECT_TYPE_CREATURE) && (fDistanceK < 3.0))
												{SetLocalString(OBJECT_SELF, "sNextToK", sObjectNameK);}
											else if(nObjectTypeK == OBJECT_TYPE_CREATURE)
												{SetLocalString(OBJECT_SELF, "sFurtherK", sObjectNameK);}
											else {SetLocalString(OBJECT_SELF, "sOtherK", sObjectNameK);}
											}
										else if(nInc == 12) {
											string sObjectNameL = GetName(oObject);
											float fDistanceL = GetDistanceBetween(oScried, oObject);
											int nObjectTypeL = GetObjectType(oObject);
											if((nObjectTypeL == OBJECT_TYPE_CREATURE) && (fDistanceL < 3.0))
												{SetLocalString(OBJECT_SELF, "sNextToL", sObjectNameL);}
											else if(nObjectTypeL == OBJECT_TYPE_CREATURE)
												{SetLocalString(OBJECT_SELF, "sFurtherL", sObjectNameL);}
											else {SetLocalString(OBJECT_SELF, "sOtherL", sObjectNameL);}
											}*/
											
										}
									//nInc++;
									}
								
								/*string sNextTo;
								string sFurther;
								string sOther;
								
								if(GetLocalString(OBJECT_SELF, "sNextToA") != "")
									{sNextTo = GetLocalString(OBJECT_SELF, "sNextToA");
									 SetLocalString(OBJECT_SELF, "sNextTo", sNextTo);
									}
								else if(GetLocalString(OBJECT_SELF, "sFurtherA") != "")
									{sFurther = GetLocalString(OBJECT_SELF, "sFurtherA");
									 SetLocalString(OBJECT_SELF, "sFurther", sFurther);
									}	
								else if(GetLocalString(OBJECT_SELF, "sOtherA") != "")
									{sOther = GetLocalString(OBJECT_SELF, "sOtherA");
									 SetLocalString(OBJECT_SELF, "sOther", sOther);
									}	
										
								if(GetLocalString(OBJECT_SELF, "sNextToB") != "")
									{sNextTo = GetLocalString(OBJECT_SELF, "sNextTo") + " and " + GetLocalString(OBJECT_SELF, "sNextToB");
									 SetLocalString(OBJECT_SELF, "sNextTo", sNextTo);
									}	
								else if(GetLocalString(OBJECT_SELF, "sFurtherB") != "")
									{sFurther = GetLocalString(OBJECT_SELF, "sFurther") + " and " + GetLocalString(OBJECT_SELF, "sFurtherB");
									 SetLocalString(OBJECT_SELF, "sFurther", sFurther);
									}	
								else if(GetLocalString(OBJECT_SELF, "sOtherB") != "")
									{sOther = GetLocalString(OBJECT_SELF, "sOther") + " and " + GetLocalString(OBJECT_SELF, "sOtherB");
									 SetLocalString(OBJECT_SELF, "sOther", sOther);
									}	
											
								if(GetLocalString(OBJECT_SELF, "sNextToC") != "")
									{sNextTo = GetLocalString(OBJECT_SELF, "sNextTo") + " and " + GetLocalString(OBJECT_SELF, "sNextToC");
									 SetLocalString(OBJECT_SELF, "sNextTo", sNextTo);
									}	
								else if(GetLocalString(OBJECT_SELF, "sFurtherC") != "")
									{sFurther = GetLocalString(OBJECT_SELF, "sFurther") + " and " + GetLocalString(OBJECT_SELF, "sFurtherC");
									 SetLocalString(OBJECT_SELF, "sFurther", sFurther);
									}	
								else if(GetLocalString(OBJECT_SELF, "sOtherC") != "")
									{sOther = GetLocalString(OBJECT_SELF, "sOther") + " and " + GetLocalString(OBJECT_SELF, "sOtherC");
									 SetLocalString(OBJECT_SELF, "sOther", sOther);
									}	
										
								if(GetLocalString(OBJECT_SELF, "sNextToD") != "")
									{sNextTo = GetLocalString(OBJECT_SELF, "sNextTo") + " and " + GetLocalString(OBJECT_SELF, "sNextToD");
									 SetLocalString(OBJECT_SELF, "sNextTo", sNextTo);
									}	
								else if(GetLocalString(OBJECT_SELF, "sFurtherD") != "")
									{sFurther = GetLocalString(OBJECT_SELF, "sFurther") + " and " + GetLocalString(OBJECT_SELF, "sFurtherD");
									 SetLocalString(OBJECT_SELF, "sFurther", sFurther);
									}	
								else if(GetLocalString(OBJECT_SELF, "sOtherD") != "")
									{sOther = GetLocalString(OBJECT_SELF, "sOther") + " and " + GetLocalString(OBJECT_SELF, "sOtherD");
									 SetLocalString(OBJECT_SELF, "sOther", sOther);
									}	
								
								if(GetLocalString(OBJECT_SELF, "sNextToE") != "")
									{sNextTo = GetLocalString(OBJECT_SELF, "sNextTo") + " and " + GetLocalString(OBJECT_SELF, "sNextToE");
									 SetLocalString(OBJECT_SELF, "sNextTo", sNextTo);
									}	
								else if(GetLocalString(OBJECT_SELF, "sFurtherE") != "")
									{sFurther = GetLocalString(OBJECT_SELF, "sFurther") + " and " + GetLocalString(OBJECT_SELF, "sFurtherE");
									 SetLocalString(OBJECT_SELF, "sFurther", sFurther);
									}	
								else if(GetLocalString(OBJECT_SELF, "sOtherE") != "")
									{sOther = GetLocalString(OBJECT_SELF, "sOther") + " and " + GetLocalString(OBJECT_SELF, "sOtherE");
									 SetLocalString(OBJECT_SELF, "sOther", sOther);
									}	
								
								if(GetLocalString(OBJECT_SELF, "sNextToF") != "")
									{sNextTo = GetLocalString(OBJECT_SELF, "sNextTo") + " and " + GetLocalString(OBJECT_SELF, "sNextToF");
									 SetLocalString(OBJECT_SELF, "sNextTo", sNextTo);
									}	
								else if(GetLocalString(OBJECT_SELF, "sFurtherF") != "")
									{sFurther = GetLocalString(OBJECT_SELF, "sFurther") + " and " + GetLocalString(OBJECT_SELF, "sFurtherF");
									 SetLocalString(OBJECT_SELF, "sFurther", sFurther);
									}	
								else if(GetLocalString(OBJECT_SELF, "sOtherF") != "")
									{sOther = GetLocalString(OBJECT_SELF, "sOther") + " and " + GetLocalString(OBJECT_SELF, "sOtherF");
									 SetLocalString(OBJECT_SELF, "sOther", sOther);
									}	
								
								if(GetLocalString(OBJECT_SELF, "sNextToG") != "")
									{sNextTo = GetLocalString(OBJECT_SELF, "sNextTo") + " and " + GetLocalString(OBJECT_SELF, "sNextToG");
									 SetLocalString(OBJECT_SELF, "sNextTo", sNextTo);
									}	
								else if(GetLocalString(OBJECT_SELF, "sFurtherG") != "")
									{sFurther = GetLocalString(OBJECT_SELF, "sFurther") + " and " + GetLocalString(OBJECT_SELF, "sFurtherG");
									 SetLocalString(OBJECT_SELF, "sFurther", sFurther);
									}	
								else if(GetLocalString(OBJECT_SELF, "sOtherG") != "")
									{sOther = GetLocalString(OBJECT_SELF, "sOther") + " and " + GetLocalString(OBJECT_SELF, "sOtherG");
									 SetLocalString(OBJECT_SELF, "sOther", sOther);
									}	
								
								if(GetLocalString(OBJECT_SELF, "sNextToH") != "")
									{sNextTo = GetLocalString(OBJECT_SELF, "sNextTo") + " and " + GetLocalString(OBJECT_SELF, "sNextToH");
									 SetLocalString(OBJECT_SELF, "sNextTo", sNextTo);
									}	
								else if(GetLocalString(OBJECT_SELF, "sFurtherH") != "")
									{sFurther = GetLocalString(OBJECT_SELF, "sFurther") + " and " + GetLocalString(OBJECT_SELF, "sFurtherH");
									 SetLocalString(OBJECT_SELF, "sFurther", sFurther);
									}	
								else if(GetLocalString(OBJECT_SELF, "sOtherH") != "")
									{sOther = GetLocalString(OBJECT_SELF, "sOther") + " and " + GetLocalString(OBJECT_SELF, "sOtherH");
									 SetLocalString(OBJECT_SELF, "sOther", sOther);
									}	
								
								if(GetLocalString(OBJECT_SELF, "sNextToI") != "")
									{sNextTo = GetLocalString(OBJECT_SELF, "sNextTo") + " and " + GetLocalString(OBJECT_SELF, "sNextToI");
									 SetLocalString(OBJECT_SELF, "sNextTo", sNextTo);
									}	
								else if(GetLocalString(OBJECT_SELF, "sFurtherI") != "")
									{sFurther = GetLocalString(OBJECT_SELF, "sFurther") + " and " + GetLocalString(OBJECT_SELF, "sFurtherI");
									 SetLocalString(OBJECT_SELF, "sFurther", sFurther);
									}	
								else if(GetLocalString(OBJECT_SELF, "sOtherI") != "")
									{sOther = GetLocalString(OBJECT_SELF, "sOther") + " and " + GetLocalString(OBJECT_SELF, "sNextToOtherI");
									 SetLocalString(OBJECT_SELF, "sOther", sOther);
									}	
								
								if(GetLocalString(OBJECT_SELF, "sNextToJ") != "")
									{sNextTo = GetLocalString(OBJECT_SELF, "sNextTo") + " and " + GetLocalString(OBJECT_SELF, "sNextToJ");
									 SetLocalString(OBJECT_SELF, "sNextTo", sNextTo);
									}	
								else if(GetLocalString(OBJECT_SELF, "sFurtherJ") != "")
									{sFurther = GetLocalString(OBJECT_SELF, "sFurther") + " and " + GetLocalString(OBJECT_SELF, "sFurtherJ");
									 SetLocalString(OBJECT_SELF, "sFurther", sFurther);
									}	
								else if(GetLocalString(OBJECT_SELF, "sOtherJ") != "")
									{sOther = GetLocalString(OBJECT_SELF, "sOther") + " and " + GetLocalString(OBJECT_SELF, "sOtherJ");
									 SetLocalString(OBJECT_SELF, "sOther", sOther);
									}	
								
								if(GetLocalString(OBJECT_SELF, "sNextToK") != "")
									{sNextTo = GetLocalString(OBJECT_SELF, "sNextTo") + " and " + GetLocalString(OBJECT_SELF, "sNextToK");
									 SetLocalString(OBJECT_SELF, "sNextTo", sNextTo);
									}	
								else if(GetLocalString(OBJECT_SELF, "sFurtherK") != "")
									{sFurther = GetLocalString(OBJECT_SELF, "sFurther") + " and " + GetLocalString(OBJECT_SELF, "sFurtherK");
									 SetLocalString(OBJECT_SELF, "sFurther", sFurther);
									}	
								else if(GetLocalString(OBJECT_SELF, "sOtherK") != "")
									{sOther = GetLocalString(OBJECT_SELF, "sOther") + " and " + GetLocalString(OBJECT_SELF, "sOtherK");
									 SetLocalString(OBJECT_SELF, "sOther", sOther);
									}	
								
								if(GetLocalString(OBJECT_SELF, "sNextToL") != "")
									{sNextTo = GetLocalString(OBJECT_SELF, "sNextTo") + " and " + GetLocalString(OBJECT_SELF, "sNextToL");
									 SetLocalString(OBJECT_SELF, "sNextTo", sNextTo);
									}	
								else if(GetLocalString(OBJECT_SELF, "sFurtherL") != "")
									{sFurther = GetLocalString(OBJECT_SELF, "sFurther") + " and " + GetLocalString(OBJECT_SELF, "sFurtherL");
									 SetLocalString(OBJECT_SELF, "sFurther", sFurther);
									}	
								else if(GetLocalString(OBJECT_SELF, "sOtherL") != "")
									{sOther = GetLocalString(OBJECT_SELF, "sOther") + " and " + GetLocalString(OBJECT_SELF, "sOtherL");
									 SetLocalString(OBJECT_SELF, "sOther", sOther);
									}	
								*/
								sNextTo = GetLocalString(OBJECT_SELF, "sNextTo");
								if(FindSubString(GetStringLeft(sNextTo, 4), "and") != -1)
									{int nStrLgthN = GetStringLength(sNextTo);
									 sNextTo = GetStringRight(sNextTo, nStrLgthN - 4);
									}
								if(FindSubString(GetStringRight(sNextTo, 4), "and") != -1)
									{int nStrLgthN = GetStringLength(sNextTo);
									 sNextTo = GetStringLeft(sNextTo, nStrLgthN - 4) + ".";
									}
								sFurther = GetLocalString(OBJECT_SELF, "sFurther");
								if(FindSubString(GetStringLeft(sFurther, 4), "and") != -1)
									{int nStrLgthF = GetStringLength(sFurther);
									 sFurther = GetStringRight(sFurther, nStrLgthF - 4);
									}
								if(FindSubString(GetStringRight(sFurther, 4), "and") != -1)
									{int nStrLgthF = GetStringLength(sFurther);
									 sFurther = GetStringLeft(sFurther, nStrLgthF - 4) + ".";
									}
								sOther = GetLocalString(OBJECT_SELF, "sOther");
								if(FindSubString(GetStringLeft(sOther, 4), "and") != -1)
									{int nStrLgthO = GetStringLength(sOther);
									sOther = GetStringRight(sOther, nStrLgthO - 4);
									}
								if(FindSubString(GetStringRight(sOther, 5), "and") != -1)
									{int nStrLgthO = GetStringLength(sOther);
									sOther = GetStringLeft(sOther, nStrLgthO - 5) + ".";
									}
									
								//Now that creatures and objects are prioritized by distance from oScried, tell oScryer
								
								if(GetLocalString(OBJECT_SELF, "sNextTo") != "")
									{ActionSpeakString(sGenderNoun + " is standing next to " + sNextTo + ".", TALKVOLUME_TALK);}
								if(GetLocalString(OBJECT_SELF, "sFurther") != "") 
									{ActionSpeakString(sFurther + " can be seen nearby.", TALKVOLUME_TALK);}
								if(GetLocalString(OBJECT_SELF, "sOther") != "") 
									{ActionSpeakString("Within view: " + sOther, TALKVOLUME_TALK );}
								
								/*if((GetLocalString(OBJECT_SELF, "sNextToA") != "") || (GetLocalString(OBJECT_SELF, "sNextToB") != "") || (GetLocalString(OBJECT_SELF, "sNextToC") != "") || (GetLocalString(OBJECT_SELF, "sNextToD") != "") || (GetLocalString(OBJECT_SELF, "sNextToE") != "") || (GetLocalString(OBJECT_SELF, "sNextToF") != "") || (GetLocalString(OBJECT_SELF, "sNextToG") != "") || (GetLocalString(OBJECT_SELF, "sNextToH") != "") || (GetLocalString(OBJECT_SELF, "sNextToI") != "") || (GetLocalString(OBJECT_SELF, "sNextToJ") != "") || (GetLocalString(OBJECT_SELF, "sNextToK") != "") || (GetLocalString(OBJECT_SELF, "sNextToL") != ""))	
									{ActionSpeakString(sGenderNoun + " is standing next to " + sNextTo + ".", TALKVOLUME_TALK);}
								if((GetLocalString(OBJECT_SELF, "sFurtherA") != "") || (GetLocalString(OBJECT_SELF, "sFurtherB") != "") || (GetLocalString(OBJECT_SELF, "sFurtherC") != "") || (GetLocalString(OBJECT_SELF, "sFurtherD") != "") || (GetLocalString(OBJECT_SELF, "sFurtherE") != "") || (GetLocalString(OBJECT_SELF, "sFurtherF") != "") || (GetLocalString(OBJECT_SELF, "sFurtherG") != "") || (GetLocalString(OBJECT_SELF, "sFurtherH") != "") || (GetLocalString(OBJECT_SELF, "sFurtherI") != "") || (GetLocalString(OBJECT_SELF, "sFurtherJ") != "") || (GetLocalString(OBJECT_SELF, "sFurtherK") != "") || (GetLocalString(OBJECT_SELF, "sFurtherL") != ""))	
									{ActionSpeakString(sFurther + " can be seen nearby.", TALKVOLUME_TALK);}
								if((GetLocalString(OBJECT_SELF, "sOtherA") != "") || (GetLocalString(OBJECT_SELF, "sOtherB") != "") || (GetLocalString(OBJECT_SELF, "sOtherC") != "") || (GetLocalString(OBJECT_SELF, "sOtherD") != "") || (GetLocalString(OBJECT_SELF, "sOtherE") != "") || (GetLocalString(OBJECT_SELF, "sOtherF") != "") || (GetLocalString(OBJECT_SELF, "sOtherG") != "") || (GetLocalString(OBJECT_SELF, "sOtherH") != "") || (GetLocalString(OBJECT_SELF, "sOtherI") != "") || (GetLocalString(OBJECT_SELF, "sOtherJ") != "") || (GetLocalString(OBJECT_SELF, "sOtherK") != "") || (GetLocalString(OBJECT_SELF, "sOtherL") != ""))	
									{ActionSpeakString("Within view: " + sOther, TALKVOLUME_TALK );}
								*/
								//Notify oScryer and DMs of the end of the spell
								DelayCommand(fScryTimer - 5.0, ActionSpeakString("*The images in the " + sScryName + " fade.", TALKVOLUME_TALK));		
			 					DelayCommand(fScryTimer - 1.0, SendMessageToPC(oScryer, "The scry spell ends."));		
			 					if(GetLocalInt(GetModule(), "DM_Spam") == 0) {
									DelayCommand(fScryTimer - 5.0, SendMessageToAllDMs(GetName(oScryer) + "'s scry spell ends and the images in the " + sScryName + " fade."));		
			 						}
								//Unset ALL local objects at the end of the successful spell
								//Destroy Scrying Sensor and ScryListen
								//Backup in tsm_scry_npc_onspawn in case this successful branch doesn't fire
								DelayCommand(fScryTimer, SetLocalObject(oScry, "oScried", OBJECT_INVALID));
								DelayCommand(fScryTimer, SetLocalObject(oScry, "oViewerA", OBJECT_INVALID));
								DelayCommand(fScryTimer, SetLocalObject(oScry, "oViewerB", OBJECT_INVALID));
								DelayCommand(fScryTimer, SetLocalObject(oScry, "oViewerC", OBJECT_INVALID));
								DelayCommand(fScryTimer, SetLocalObject(oScry, "oViewerD", OBJECT_INVALID));
								DelayCommand(fScryTimer, SetLocalObject(oScry, "oViewerE", OBJECT_INVALID));
								DelayCommand(fScryTimer, SetLocalObject(oScry, "oViewerF", OBJECT_INVALID));
								DelayCommand(fScryTimer, SetLocalObject(oScry, "oViewerG", OBJECT_INVALID));
								DelayCommand(fScryTimer, SetLocalObject(oScry, "oViewerH", OBJECT_INVALID));
								DelayCommand(fScryTimer, SetLocalObject(OBJECT_SELF, "oScried", OBJECT_INVALID));
								DelayCommand(fScryTimer, SetLocalObject(oScryer, "oScried", OBJECT_INVALID));
								DelayCommand(fScryTimer, SetLocalObject(oScrySend, "oScried", OBJECT_INVALID));
								DelayCommand(fScryTimer, SetLocalObject(oScry, "oScrySpeak", OBJECT_INVALID));
								DelayCommand(fScryTimer, SetLocalObject(oScried, "oScrySpeak", OBJECT_INVALID));
								DelayCommand(fScryTimer, SetLocalObject(oScryer, "oScrySpeak", OBJECT_INVALID));
								DelayCommand(fScryTimer, SetLocalObject(oScrySend, "oScrySpeak", OBJECT_INVALID));
								DelayCommand(fScryTimer, SetLocalObject(oScry, "oScryer", OBJECT_INVALID));
								DelayCommand(fScryTimer, SetLocalObject(OBJECT_SELF, "oScryer", OBJECT_INVALID));
								DelayCommand(fScryTimer, SetLocalObject(oScried, "oScryer", OBJECT_INVALID));
								DelayCommand(fScryTimer, SetLocalObject(oScrySend, "oScryer", OBJECT_INVALID));
								DelayCommand(fScryTimer, SetLocalObject(oScried, "oScry", OBJECT_INVALID));
								DelayCommand(fScryTimer, SetLocalObject(OBJECT_SELF, "oScry", OBJECT_INVALID));
								DelayCommand(fScryTimer, SetLocalObject(oScryer, "oScry", OBJECT_INVALID));
								DelayCommand(fScryTimer, SetLocalObject(oScrySend, "oScry", OBJECT_INVALID));
								DelayCommand(fScryTimer, SetLocalObject(oScried, "oScrySend", OBJECT_INVALID));
								DelayCommand(fScryTimer, SetLocalObject(OBJECT_SELF, "oScrySend", OBJECT_INVALID));
								DelayCommand(fScryTimer, SetLocalObject(oScryer, "oScrySend", OBJECT_INVALID));
								DelayCommand(fScryTimer, SetLocalObject(oScry, "oScrySend", OBJECT_INVALID));
								
								DelayCommand(fScryTimer, SetLocalFloat(OBJECT_SELF, "fScryTimer", 0.0));
								DelayCommand(fScryTimer, SetLocalInt(oScry, "nScryActive", 0));
								DelayCommand(fScryTimer, DeleteLocalLocation(oScry, "lViewerA"));
								DelayCommand(fScryTimer, DeleteLocalLocation(oScry, "lViewerB"));
								DelayCommand(fScryTimer, DeleteLocalLocation(oScry, "lViewerC"));
								DelayCommand(fScryTimer, DeleteLocalLocation(oScry, "lViewerD"));
								DelayCommand(fScryTimer, DeleteLocalLocation(oScry, "lViewerE"));
								DelayCommand(fScryTimer, DeleteLocalLocation(oScry, "lViewerF"));
								DelayCommand(fScryTimer, DeleteLocalLocation(oScry, "lViewerG"));
								DelayCommand(fScryTimer, DeleteLocalLocation(oScry, "lViewerH"));
			 
								DestroyObject(oScrySend, fScryTimer + 2.0);  
								DestroyObject(oScrySelf, fScryTimer + 3.0);
								DestroyObject(OBJECT_SELF, fScryTimer + 5.0);
								break;
								}
							 
							 }
						 nIncA++;
						 oScried = GetNextPC(FALSE);
					}	
			}
	else {if((nMatch == 6041) && (GetLocalInt(oScry, "nScryActive") == 0))  {
			SendMessageToPC(oScryer, "Your scrying spell fails to show you anyone by that nickname. This " + GetName(oScry) + " is not keyed under that name with their identity from an imbued scrying focus. Your spell is still active and you may speak a different name.");}	
		}
	}
	
	
//The Scrying Namer is only called by activating an imbued shard on a scrying object. Any time the Scrying Namer hears spoken words, it assigns them to the scrying object as a nickname associated with a ResRef
if((GetTag(OBJECT_SELF)== "003_cr_scry_namer") && (GetLastSpeaker() == GetLocalObject(OBJECT_SELF, "oScryer"))) {
	object oScryer = GetLocalObject(OBJECT_SELF, "oScryer");
	object oTarget = GetLocalObject(OBJECT_SELF, "oTarget");
	object oFocus = GetLocalObject(OBJECT_SELF, "oFocus");
	object oScrySpeak = GetLocalObject(oScryer, "oScrySpeak");
	string sTargetRes = GetLocalString(OBJECT_SELF, "sPTargetRes");
	string sTargetName = GetLocalString(OBJECT_SELF, "sPTargetName");
	location lTarget = GetLocation(oTarget);
	effect eDivAOE = EffectVisualEffect(VFX_HIT_AOE_DIVINATION, FALSE);
	int nMatch = GetListenPatternNumber();
	if(nMatch == 6041) {
		string sMatch = GetMatchedSubstring(0);
		SetLocalString(oTarget, sTargetRes, sMatch);
		SetLocalString(oTarget, sMatch, sTargetRes);
		SetLocalString(oScryer, sTargetName, sMatch);
		SetListenPattern(oScrySpeak, "**" + sMatch + "**", 6039);
				 
		string sScryTargetA = GetLocalString(oTarget, "sScryTargetA");
		string sScryTargetB = GetLocalString(oTarget, "sScryTargetB");
		string sScryTargetC = GetLocalString(oTarget, "sScryTargetC");
		string sScryTargetD = GetLocalString(oTarget, "sScryTargetD");
		string sScryTargetE = GetLocalString(oTarget, "sScryTargetE");
		string sScryTargetF = GetLocalString(oTarget, "sScryTargetF");
		string sScryTargetG = GetLocalString(oTarget, "sScryTargetG");
		string sScryTargetH = GetLocalString(oTarget, "sScryTargetH");
		string sScryTargetI = GetLocalString(oTarget, "sScryTargetI");
		string sScryTargetJ = GetLocalString(oTarget, "sScryTargetJ");
		
		if(sScryTargetA == "") {
			SetLocalString(oTarget, "sScryTargetA", sMatch);
		}
		else if(sScryTargetB == "") {
			SetLocalString(oTarget, "sScryTargetB", sMatch);
		}
		else if(sScryTargetC == "") {
			SetLocalString(oTarget, "sScryTargetC", sMatch);
		}
		else if(sScryTargetD == "") {
			SetLocalString(oTarget, "sScryTargetD", sMatch);
		}
		else if(sScryTargetE == "") {
			SetLocalString(oTarget, "sScryTargetE", sMatch);
		}
		else if(sScryTargetF == "") {
			SetLocalString(oTarget, "sScryTargetF", sMatch);
		}
		else if(sScryTargetG == "") {
			SetLocalString(oTarget, "sScryTargetG", sMatch);
		}
		else if(sScryTargetH == "") {
			SetLocalString(oTarget, "sScryTargetH", sMatch);
		}
		else if(sScryTargetI == "") {
			SetLocalString(oTarget, "sScryTargetI", sMatch);
		}
		else if(sScryTargetJ == "") {
			SetLocalString(oTarget, "sScryTargetJ", sMatch);
		}
		
		ACR_SetPersistentString(oFocus, "sPTargetNick", sMatch);
		object oToken = GetFirstItemInInventory(oScryer);
		while(oToken != OBJECT_INVALID) {
			if((FindSubString(GetTag(oToken), "abr_it_scry_", 0) != -1) && (GetTag(oToken) != "abr_it_scry_kit")) {
				string sPTokenRes = ACR_GetPersistentString(oToken, "sPTargetRes");
				string sPTokenName = ACR_GetPersistentString(oToken, "sPTargetName");
				if(sPTokenName == sTargetName) {ACR_SetPersistentString(oToken, "sPTargetNick", sMatch);}
				if((sPTokenName == "") && (ACR_GetPersistentString(oToken, "sPTargetNick") == sMatch)){ACR_SetPersistentString(oToken, "sPTargetName", sMatch);}
				if((ACR_GetPersistentString(oToken, "sPTargetNick") == "") && (sPTokenName == sMatch)){ACR_SetPersistentString(oToken, "sPTargetNick", sMatch);}
				}	
			oToken = GetNextItemInInventory(oScryer);
			}
		DelayCommand(2.0, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eDivAOE, lTarget, 5.0));
		DestroyObject(OBJECT_SELF, 5.0);
		}	 				
	}	

	//Any time the Scrying Sensor hears spoken words, it relays them to the OOC ScryListener and reinforces its directive to follow oScried
	if((FindSubString(GetTag(OBJECT_SELF), "003_cr_scry_send") != -1) && (GetLastSpeaker() != OBJECT_SELF)  && (GetTag(GetLastSpeaker()) != "003_cr_scry_speak")) {
		object oScryer = GetLocalObject(OBJECT_SELF, "oScryer");
		object oScried = GetLocalObject(OBJECT_SELF, "oScried");
		object oScrySpeak = GetLocalObject(OBJECT_SELF, "oScrySpeak");
		ActionForceFollowObject(oScried, 0.5, 0); 
		int nMatch = GetListenPatternNumber();
		string sRelay = GetMatchedSubstring(0);
		if((nMatch == 6040) && (GetLastSpeaker() == oScryer)) {
		//End Spell
			location lHere = GetLocalLocation(oScryer, "ACR_SCRY_LOCATION");
		    object oScrySend = OBJECT_SELF;
			object oScrySelf = GetLocalObject(OBJECT_SELF, "oScrySelf");
			object oDupe = GetLocalObject(oScryer, "oDupe");
			AssignCommand(oDupe, ActionSpeakString(sRelay, TALKVOLUME_TALK));
			object oScry = GetLocalObject(OBJECT_SELF, "oScry");
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
			
			if(GetIsObjectValid(oDupe)) {AssignCommand(oScryer, ActionJumpToLocation(lHere));}		
			if(GetArea(OBJECT_SELF) != GetArea(oScrySpeak)) {
				AssignCommand(oScry, ActionSpeakString("*The images in the " + GetName(oScry) + " fade.", TALKVOLUME_TALK));		
				SendMessageToPC(oScryer, "The scry spell ends.");		
				SendMessageToAllDMs(GetName(oScryer) + "'s scry spell is cancelled and the images in the " + GetName(oScry) + " fade.");		
			 	}				
			//Unset ALL local objects at the end of the spell
			//Destroy Scrying Sensor and ScryListen
			SetLocalObject(oScry, "oScryer", OBJECT_INVALID);
			SetLocalObject(oScry, "oScrySpeak", OBJECT_INVALID);
			SetLocalObject(oScry, "oScried", OBJECT_INVALID);
			SetLocalObject(oScry, "oScrySend", OBJECT_INVALID);
			SetLocalObject(oScry, "oScrySelf", OBJECT_INVALID);
			SetLocalObject(oScry, "oDupe", OBJECT_INVALID);
			SetLocalObject(oScry, "oViewerA", OBJECT_INVALID);
			SetLocalObject(oScry, "oViewerB", OBJECT_INVALID);
			SetLocalObject(oScry, "oViewerC", OBJECT_INVALID);
			SetLocalObject(oScry, "oViewerD", OBJECT_INVALID);
			SetLocalObject(oScry, "oViewerE", OBJECT_INVALID);
			SetLocalObject(oScry, "oViewerF", OBJECT_INVALID);
			SetLocalObject(oScry, "oViewerG", OBJECT_INVALID);
			SetLocalObject(oScry, "oViewerH", OBJECT_INVALID);
			SetLocalObject(oScryer, "oScry", OBJECT_INVALID);
			SetLocalObject(oScryer, "oScrySpeak", OBJECT_INVALID);
			SetLocalObject(oScryer, "oScried", OBJECT_INVALID);
			SetLocalObject(oScryer, "oScrySend", OBJECT_INVALID);
			SetLocalObject(oScryer, "oScrySelf", OBJECT_INVALID);
			SetLocalObject(oScryer, "oDupe", OBJECT_INVALID);
			SetLocalObject(oScried, "oScryer", OBJECT_INVALID);
			SetLocalObject(oScried, "oScry", OBJECT_INVALID);
			SetLocalObject(oScried, "oScrySpeak", OBJECT_INVALID);
			SetLocalObject(oScried, "oScrySend", OBJECT_INVALID);
			SetLocalObject(oScried, "oScrySelf", OBJECT_INVALID);
			SetLocalObject(oScried, "oDupe", OBJECT_INVALID);
			
			DeleteLocalLocation(oScryer, "ACR_SCRY_LOCATION");
			DeleteLocalLocation(oScry, "lViewerA");
			DeleteLocalLocation(oScry, "lViewerB");
			DeleteLocalLocation(oScry, "lViewerC");
			DeleteLocalLocation(oScry, "lViewerD");
			DeleteLocalLocation(oScry, "lViewerE");
			DeleteLocalLocation(oScry, "lViewerF");
			DeleteLocalLocation(oScry, "lViewerG");
			DeleteLocalLocation(oScry, "lViewerH");
			SetLocalInt(oScry, "nScryActive", 0);
			
			DestroyObject(oScrySpeak);  
			DestroyObject(oScrySelf);
			DestroyObject(oDupe);
			DestroyObject(OBJECT_SELF, 1.0);
			return;
		}
		
		else if(nMatch == 6041) {
			string sSpokenBy = GetName(GetLastSpeaker());
			SetFirstName(oScrySpeak, sSpokenBy);
			if(GetLastSpeaker() != oScrySpeak)  {
				DelayCommand(1.0, AssignCommand(oScrySpeak, ActionSpeakString(sRelay, TALKVOLUME_TALK)));
			}
		}
	}	 

	//A listener feeds any conversation to oScryer while oScryer is with oScried
	if((FindSubString(GetTag(OBJECT_SELF), "003_cr_scry_self") != -1) && (GetLastSpeaker() != OBJECT_SELF)  && (GetTag(GetLastSpeaker()) != "003_cr_scry_speak")) {
		object oScryer = GetLocalObject(OBJECT_SELF, "oScryer");
		int nMatch = GetListenPatternNumber();
		if(nMatch == 6031) {
			string sSpokenBy = GetName(GetLastSpeaker());
			string sRelay = GetMatchedSubstring(0);
			SendMessageToPC(oScryer, sSpokenBy + " says: " + sRelay);
		}
	}	 
}