#include "acr_quest_i"
#include "acr_creature_i"
#include "x0_i0_position"
#include "acr_spawn_i"
#include "acr_scry_i"

////////////////////////////////////////////////////////////////////////////////
// Constants ///////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

const float NUMBER_OF_COMPASS_DIRECTIONS = 16.0;
const float HALF_COMPASS_ANGLE = 360.0/(NUMBER_OF_COMPASS_DIRECTIONS * 2.0);

string GetCompassDirectionOfBearing(float fDegrees);
string GetCompassDirectionOfAngle(float fAngle);

////////////////////////////////////////////////////////////////////////////////
// Function Definitions ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
 
string GetCompassDirectionOfBearing(float fDegrees)
{
    /* Takes a bearing from degrees (0.0 -> 360.0)
     * where 0.0 is North and 90.0 is West and
     * returns its corresponding compass direction
     */

    // Handle cases when the caller is lazy
    while (fDegrees < 0.0) {
        fDegrees += 360.0;
    }
    while (fDegrees > 360.0) {
        fDegrees -= 360.0;
    }

    // Do the mapping
    if (fDegrees < HALF_COMPASS_ANGLE || fDegrees > HALF_COMPASS_ANGLE * 31) {
        return "north";
    }
    else if (fDegrees < HALF_COMPASS_ANGLE * 3) {
        return "north-northeast";
    }
    else if (fDegrees < HALF_COMPASS_ANGLE * 5) {
        return "northeast";
    }
    else if (fDegrees < HALF_COMPASS_ANGLE * 7) {
        return "east-northeast";
    }
    else if (fDegrees < HALF_COMPASS_ANGLE * 9) {
        return "east";
    }
    else if (fDegrees < HALF_COMPASS_ANGLE * 11) {
        return "east-southeast";
    }
    else if (fDegrees < HALF_COMPASS_ANGLE * 13) {
        return "southeast";
    }
    else if (fDegrees < HALF_COMPASS_ANGLE * 15) {
        return "south-southeast";
    }
    else if (fDegrees < HALF_COMPASS_ANGLE * 17) {
        return "south";
    }
    else if (fDegrees < HALF_COMPASS_ANGLE * 19) {
        return "south-southwest";
    }
    else if (fDegrees < HALF_COMPASS_ANGLE * 21) {
        return "southwest";
    }
    else if (fDegrees < HALF_COMPASS_ANGLE * 23) {
        return "west-southwest";
    }
    else if (fDegrees < HALF_COMPASS_ANGLE * 25) {
        return "west";
    }
    else if (fDegrees < HALF_COMPASS_ANGLE * 27) {
        return "west-northwest";
    }
    else if (fDegrees < HALF_COMPASS_ANGLE * 29) {
        return "northwest";
    }
    return "north-northwest";
}


string GetCompassDirectionOfAngle(float fAngle)
{
    /* Takes an angle from degrees (0.0 -> 360.0)
     * where 0.0 is the positive X-axis and 90.0
     * is the positive Y-axis and returns its
     * corresponding compass direction
     */
    return GetCompassDirectionOfBearing(-fAngle + 90.0);
}


void main()
{   ACR_CreatureOnConversation();
 	effect eCutScene = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);
	effect eInvis = EffectInvisibility(INVISIBILITY_TYPE_IMPROVED);
	effect eEthereal = EffectEthereal();
	    
ActionSpeakString(GetTag(OBJECT_SELF) + " convo.", TALKVOLUME_TALK);   
	
//The Scrying Namer is only called by activating an imbued shard on a scrying object. Any time the Scrying Namer hears spoken words, it assigns them to the Roster as a Roster Name associated with a ResRef
if((GetTag(OBJECT_SELF)== "003_cr_scry_namer") && (GetLastSpeaker() != GetLocalObject(OBJECT_SELF, "oTarget"))  && (GetLastSpeaker() != OBJECT_SELF)  && (GetTag(GetLastSpeaker()) != "003_cr_scry_listen")) {
	object oMaster = GetLocalObject(OBJECT_SELF, "oScryer");
	object oTarget = GetLocalObject(OBJECT_SELF, "oTarget");
	string sTargetRes = GetLocalString(OBJECT_SELF, "sTargetRes");
	location lTarget = GetLocation(oTarget);
	//effect eBeam = EffectBeam(VFX_BEAM_DIVINATION, oMaster, BODY_NODE_CHEST, FALSE);
	effect eDivAOE = EffectVisualEffect(VFX_HIT_AOE_DIVINATION, FALSE);
	int nMatch = GetListenPatternNumber();
	if(nMatch == 6031) {
		string sRosterName = GetMatchedSubstring(0);
		SendMessageToPC(oMaster, "These names of the wider populace are now keyed on this " + GetName(oTarget) + ":");
		AddRosterMemberByTemplate(sRosterName, sTargetRes);
		string sRoster = GetFirstRosterMember();
		int nInc = 0;
		while((sRoster != "") && (nInc < 10)) {
			SendMessageToPC(oMaster, sRoster);
			sRoster = GetNextRosterMember();
			nInc++;
		}
		//ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eBeam, lTarget, 2.0);
		DelayCommand(2.0, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eDivAOE, lTarget, 5.0));
		DestroyObject(OBJECT_SELF, 7.0);
		}	 				
	}	

	//A duplicate Scryer holds the position of the PC scryer and feeds any conversation to them
	if((FindSubString(GetTag(OBJECT_SELF), "003_cr_scry_wisp") != -1) && (GetLastSpeaker() != OBJECT_SELF)  && (GetTag(GetLastSpeaker()) != "003_cr_scry_listen")) {
		ActionSpeakString("Wisp convo");
		object oScryer = GetLocalObject(OBJECT_SELF, "oScryer");
		int nMatch = GetListenPatternNumber();
		if(nMatch == 6031) {
			string sSpokenBy = GetName(GetLastSpeaker());
			string sRelay = GetMatchedSubstring(0);
			DelayCommand(1.0, SendMessageToPC(oScryer, sSpokenBy + ": " + sRelay));
		}
	}	 

	//Any time the Scrying Sensor hears spoken words, it relays them to the OOC ScryListener and reinforces its directive to follow oScried
	if((FindSubString(GetTag(OBJECT_SELF), "003_cr_scry_send") != -1) && (GetLastSpeaker() != OBJECT_SELF)  && (GetTag(GetLastSpeaker()) != "003_cr_scry_listen")) {
		object oScryer = GetLocalObject(OBJECT_SELF, "oScryer");
		object oScried = GetLocalObject(OBJECT_SELF, "oScried");
		object oScryListen = GetLocalObject(OBJECT_SELF, "oScryListen");
		ActionForceFollowObject(oScried, 0.5, 0); 
		int nMatch = GetListenPatternNumber();
		if(nMatch == 6031) {
			string sSpokenBy = GetName(GetLastSpeaker());
			SetFirstName(oScryListen, sSpokenBy);
			string sRelay = GetMatchedSubstring(0);
			if(GetLastSpeaker() != oScryListen)  {
				DelayCommand(1.0, AssignCommand(oScryListen, ActionSpeakString(sRelay, TALKVOLUME_TALK)));
			}
			//Scrying Sensor won't force follow across ATs, so here it checks to make sure oScried hasn't left the area and jumps to oScried if so
			if(GetArea(OBJECT_SELF) != GetArea(oScried)) {
				ActionJumpToObject(oScried, TRUE);
			}
		}
	}	 


//Action queue for OOC Scrying Listener that handles most Scrying interaction
//SendMessageToPC(GetLocalObject(OBJECT_SELF, "oScryer"), "Convo " + GetTag(OBJECT_SELF) + " oScryer = " + GetName(GetLocalObject(OBJECT_SELF, "oScryer")));	
		
if((GetTag(OBJECT_SELF)== "003_cr_scry_listen") && ((GetLastSpeaker()== GetLocalObject(OBJECT_SELF, "oScryer")) || (GetLocalObject(OBJECT_SELF, "oScryer") == OBJECT_INVALID))) {
		//Get existing local objects set by Spellhook
		object oScry = GetLocalObject(OBJECT_SELF, "oScry");
		string sScryName = GetName(oScry);
		object oScryer = GetLocalObject(OBJECT_SELF, "oScryer");
		float fScryTimer = GetLocalFloat(OBJECT_SELF, "fScryTimer");
		
		//This NPC was set to listen for specific words in tsm_scry_npc_onspawn
		//6020 thru 6029 are the names of the first ten PCs currently logged in
		//6030 thru 6039 are the names of up to ten NPCs this Scryer can Scry
		string sMatch = GetMatchedSubstring(1);
		int nMatch = GetListenPatternNumber();
		if((nMatch >= 6020) && (nMatch < 6040)) {
		 
		//oScryer must speak the full name of the PC or Roster Name of the allowable NPC he/she wishes to Scry	
		if(nMatch >= 6020) {
				int nIncA = 6020;
	         	object oScried = GetFirstPC(FALSE);
				string sScriedName = GetName(oScried);
				while ((oScried != OBJECT_INVALID) && (nIncA < 6040)) {
					int nScryActive = GetLocalInt(oScry, "nScryActive");
					if(nScryActive == 1) {
						 SendMessageToPC(oScryer, "You are scrying" + GetName(oScried) + " and must wait for this spell to end before scrying again. Use your scrying object for an update on your current subject.");
						 break;
						 }
					
					//First, the script checks the roster of up to ten allowable NPCs
					string sRosterName = GetFirstRosterMember();
					if(nIncA == 6020) {
						int nRosterInc = 0;
						while ((sRosterName != "") && (nRosterInc < 10)) {
							/*If the spoken name matches the Roster Name of one of the Roster NPCs
							then create an OOC invisible version of that NPC where it should be found
							so that WillSave and location data may be gotten  later on in this script.*/
							
							if(TestStringAgainstPattern("**" + sRosterName + "**", GetMatchedSubstring(1))) 
								{sScriedName = sRosterName;
								 if(GetObjectFromRosterName(sRosterName) == OBJECT_INVALID) {
									 oScried = SpawnRosterMember(sScriedName, GetLocation(OBJECT_SELF));
									 ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutScene, oScried);
				 					 ApplyEffectToObject(DURATION_TYPE_PERMANENT, eInvis, oScried);
				 					 ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEthereal, oScried);
				 					 SetStandardFactionReputation(STANDARD_FACTION_HOSTILE, 50, oScried);
									 }
								 string sScriedArea = GetLocalString(oScried, "ACR_SCRY_AREA_TAG");
								 
								 int nWillSaveBase = GetWillSavingThrow(oScried);
								 SetLocalInt(OBJECT_SELF, "oScriedWSBase", nWillSaveBase);
								 object oScriedArea = GetFirstArea();
								 while(oScriedArea != OBJECT_INVALID) {
								 	if(GetTag(oScriedArea) == sScriedArea) {
										ACR_PreSpawnArea(oScriedArea);
										DespawnRosterMember(sScriedName);
										object oFirst = GetFirstObjectInArea(oScriedArea);
										int nNPC = 1;
										object oNPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC, oFirst, nNPC); 
										while (oNPC != OBJECT_INVALID) {
										if((sScriedName == GetName(oNPC)) || (FindSubString(GetName(oNPC), sScriedName, 0) != -1))
												{oScried = oNPC;
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
							sRosterName = GetNextRosterMember();
							nRosterInc++;
							}
						} 
						
					 
					 /*If the spoken name matches the name of one of the Roster NPCs or PCs currently logged in
					   give that potential oScried a WillSave vs oScryer's DC*/
					 
					 if((TestStringAgainstPattern("**" + sScriedName + "**", GetMatchedSubstring(1)))  && (nScryActive == 0))
						{SendMessageToPC(oScryer, "You feel your spell contesting with " + sScriedName + "'s willpower to resist it.");
						//oScried makes a privately rolled WillSave vs. stored DC:
						
						int nKnowledge = -10;	
						int nConnection = 0;
						object oToken = GetFirstItemInInventory(oScryer);
						while(oToken != OBJECT_INVALID) {
							if(FindSubString(GetTag(oToken), "abr_it_scry_", 0) != -1) {
								nConnection = 0;
								string sToken = GetFirstName(oToken);
								string sTokenLast = GetLastName(oToken);
								string sScryerName = GetFirstName(oScryer);
								int nCountName = GetStringLength(sToken);
								int nCountScryerName = GetStringLength(sScryerName);
								string sTargetName = GetStringLeft(sToken, nCountName - 8 - nCountScryerName);
								int nScryer = 0;
								if(sScryerName == GetStringRight(sToken, nCountScryerName)) {
									nScryer = 1;
									}
								int nImage = 0;
								int nPossession = 0;
								int nBody = 0;
								
								//SendMessageToPC(oScryer, sTargetName + "==" + sScriedName + "==" + sTokenLast);
								if((sTargetName == sScriedName) || (FindSubString(sToken, sScriedName) != -1) || (sTokenLast == sScriedName)) {
									sToken = GetStringLowerCase(sToken);
									if((FindSubString(sToken, "image", 0) != -1) || (FindSubString(sToken, "picture", 0) != -1)) {
										nImage = 1;
										nConnection = 2;
										}
									if(((FindSubString(sToken, "possess", 0) != -1) || (FindSubString(sToken, "cloth", 0) != -1)) && (nConnection < 4)) {
										nPossession = 1;
										nConnection = 4;
										}
									if(((FindSubString(sToken, "body", 0) != -1) || (FindSubString(sToken, "nail", 0) != -1) || (FindSubString(sToken, "hair", 0) != -1) || (FindSubString(sToken, "blood", 0) != -1)  || (FindSubString(sToken, "tooth", 0) != -1) || (FindSubString(sToken, "bone", 0) != -1))  && (nConnection < 10)){
										nBody = 1;
										nConnection = 10;
										}
										
									if((nScryer == 0) && (FindSubString(sToken, "imag", 0) != -1)) {
										nKnowledge = -5;
										}
									
									if((nScryer == 1) || (GetIsDMPossessed(oScryer))) {
										if(FindSubString(sToken, "image", 0) != -1) {
											nKnowledge = 0;
											if(nConnection < 2) {nConnection = 2;}
											}
										if(FindSubString(sToken, "imago", 0) != -1) {
											nKnowledge = 5;
											if(nConnection < 2) {nConnection = 2;}
											}
										}
									
									if(nKnowledge == -10) {
										SendMessageToPC(oScryer, "*You have no knowledge of " + sScriedName + ".");
										}
									else if(nKnowledge == -5) {
										SendMessageToPC(oScryer, "*Your knowledge of " + sScriedName + " is secondhand.");
										}
									else if(nKnowledge == 0) {
										SendMessageToPC(oScryer, "*Your knowledge of " + sScriedName + " is: firsthand.");
										}
									else if(nKnowledge == 5) {
										SendMessageToPC(oScryer, "*Your knowledge of " + sScriedName + " is: familiar.");
										}
									
									if(nBody == 1) {
										SendMessageToPC(oScryer, "*You are holding a body part that belonged to " + sScriedName + ".");
										}			
									else if(nPossession == 1) {
										SendMessageToPC(oScryer, "*You are holding a possession that belonged to " + sScriedName + ".");
										}
									else if(nImage == 1) {
										SendMessageToPC(oScryer, "*You are holding an image of " + sScriedName + ".");
										}
											
									if(nConnection == 0) {
										SendMessageToPC(oScryer, "*You have no connection to " + sScriedName + ".");
										}
									else if(nConnection == 2) {
										SendMessageToPC(oScryer, "*You have a minor connection to " + sScriedName + ".");
										}
									else if(nConnection == 4) {
										SendMessageToPC(oScryer, "*You have an average connection to " + sScriedName + ".");
										}
									else if(nConnection == 10) {
										SendMessageToPC(oScryer, "*You have a very strong connection to " + sScriedName + ".");
										}
								}
							 }
							oToken = GetNextItemInInventory(oScryer);
								
						}
							
						//SendMessageToPC(oScryer, "Stored DC = " + IntToString(GetLocalInt(OBJECT_SELF, "nScryDC")));
						//SendMessageToPC(oScryer, "nKnowledge = " + IntToString(nKnowledge));
						//SendMessageToPC(oScryer, "nConnection = " + IntToString(nConnection));
						int nDC = GetLocalInt(OBJECT_SELF, "nScryDC") + nKnowledge + nConnection;
				 		int nCasterLevel = GetLocalInt(OBJECT_SELF, "nCasterLevel");
						int nWillSaveRoll = d20(1);
						int nWillSaveBase = GetLocalInt(OBJECT_SELF, "oScriedWSBase");
						if(nWillSaveBase == 0) {
							nWillSaveBase = GetWillSavingThrow(oScried);
						}
						int nWillSave = nWillSaveRoll + nWillSaveBase;
						SendMessageToPC(oScryer, "nWillSave was " + IntToString(nWillSave) + " vs DC" + IntToString(nDC));
						//SendMessageToPC(oScryer, "nWillSaveRoll is " + IntToString(nWillSaveRoll) + " : WillSaveBase is " + IntToString(nWillSaveBase));
						SendMessageToAllDMs(GetName(oScried) + " rolled a " + IntToString(nWillSave) + " vs DC " + IntToString(nDC) + " against " + GetName(oScryer) + " scrying them."); 
						if(nWillSave >= nDC){
							    SendMessageToPC(oScryer, "You feel your spell fail.");
								SetLocalObject(oScry, "oScryListen", OBJECT_INVALID);
								SetLocalObject(oScryer, "oScryListen", OBJECT_INVALID);
								SendMessageToAllDMs(GetName(oScried) + " saved and will not be scried by " + GetName(oScryer));
								if(nWillSave >= nDC + 5){SendMessageToPC(oScried, "You have a momentary sense of being watched...but it passes.");}
							 	if(GetLocalInt(OBJECT_SELF, "nScryKnowledge") > 0) {
									SendMessageToPC(oScried, "A passing sensation has a familiar presence to it, as if you had heard " + GetName(oScryer) + " call your name." );
									}
								if(GetLocalInt(OBJECT_SELF, "nScryKnowledge") == 0) {
									SendMessageToPC(oScried, "A passing sensation has a familiar presence to it, as of hearing the voice of somebody you had met once or twice but can't quite recall." );
									}
								SetLocalInt(oScry, "nScryActive", 0);
								DestroyObject(OBJECT_SELF, 2.0);
							}
							
						//If oScried fails their WillSave they become the oScried object
						else {//Add oScried to the collection of objects
							 	SetLocalObject(oScry, "oScried", oScried);
							 	SetLocalObject(OBJECT_SELF, "oScried", oScried);
								SetLocalObject(oScryer, "oScried", oScried);
							 	
								//Notify oScryer and DMs that Scry was successful and set the Scrying Object as active
								SendMessageToAllDMs(GetName(oScried) + " failed and is being scried by " + GetName(oScryer) + " for the next " + FloatToString(fScryTimer, 2, 0) + " seconds."); 
								SendMessageToPC(oScryer, "You feel your spell overcome " + sScriedName + "'s willpower.");
								SendMessageToPC(oScryer, "Your scrying will last " + FloatToString(fScryTimer, 2, 0) + " seconds.");
							 	if(GetObjectType(oScry) == OBJECT_TYPE_PLACEABLE) {
									SendMessageToPC(oScryer, "During that time you, as the scryer, may touch the " + GetName(oScry) + " to hear an update on the person being scried.");
							 		}
								
								SetLocalInt(oScry, "nScryActive", 1);
								
								//Throw oScried a bone if their roll was within 5 of the DC
								if (nDC - nWillSave < 5) 
								 	{SendMessageToPC(oScryer, "You have a feeling that " + GetName(oScried) + " might have sensed something.");
								 	 SendMessageToPC(oScried, "You feel watched.");
								 	 if(GetLocalInt(OBJECT_SELF, "nScryKnowledge") > 0) {
										SendMessageToPC(oScried, "There is a familiarity to the sensation. You have felt this attention before." );
										}
									 if(GetLocalInt(OBJECT_SELF, "nScryKnowledge") == 0) {
										SendMessageToPC(oScried, "The sensation feels vaguely familiar." );
										}
									SendMessageToAllDMs( "Saving roll was within 5 of the DC. " + GetName(oScried) + " feels watched.");
								 	}
									
								//Spawn an invisible Scrying Sensor on oScried and add it to the collective
								//Detect Scrying or See Invisible will reveal it
								location lThere = GetLocation(oScried);
								location lHere = GetLocation(oScryer);
								SetLocalLocation(oScryer, "ACR_SCRY_LOCATION", lHere);
								object oScrySend = GetLocalObject(OBJECT_SELF, "oScrySend");
								if(oScrySend == OBJECT_INVALID) {
									if(GetIsDMPossessed(oScryer)) {oScrySend = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_scry_send_xavier", lThere);}
									else {oScrySend = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_scry_send", lThere);}
					            	SetLocalObject(oScry, "oScrySend", oScrySend);
									SetLocalObject(OBJECT_SELF, "oScrySend", oScrySend);
									SetLocalObject(oScryer, "oScrySend", oScrySend);
									SetLocalObject(oScried, "oScrySend", oScrySend);
									
									SetLocalObject(oScrySend, "oScryListen", OBJECT_SELF);
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
								 ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVFX, oScryer, 60.0);
								 ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGhost, oScryer, 60.0);
								
								 // Dupe the PC to leave behind and jump scrying PC to location
								// if (GetIsDMPossessed(oScryer) == FALSE)
								    //{	
										object oDupe = CopyObject(oScryer, GetLocation(oScryer), OBJECT_INVALID, "003_cr_scry_dupe");
										object oScryWisp = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_scry_wisp", GetLocation(oScryer));
										SetLocalObject(oDupe, "oOriginal", oScryer);
										SetLocalObject(oScryer, "oDupe", oDupe);
										ChangeToStandardFaction(oDupe, STANDARD_FACTION_COMMONER);
										ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFreeze, oDupe, 60.0);
									    DestroyObject(oDupe, 60.0);
										 
										// Jump to the target
										//DelayCommand(1.0, AssignCommand(oScryer, JumpToLocation(lThere)));
								
								        // Follow the target UNTIL the spell expires - THIS MUST BE DONE LAST!
								        //DelayCommand(2.0, AssignCommand(oScryer, ActionForceFollowObject(oScried, 0.5)));
								        //DelayCommand(5.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFreeze, oScryer, 60.0));
									    //DelayCommand(10.0, AssignCommand(oScryer, ActionForceFollowObject(oScried, 0.5)));
								    	//DelayCommand(20.0, AssignCommand(oScryer, ActionForceFollowObject(oScried, 0.5)));
								    //	}
								     
								  //else
								  //  {
								        // Jump NPC to the location
								        //AssignCommand(oScryer, JumpToLocation(lThere));
								
								    // }
								
								    // Stop whatever it is we're doing
							        DelayCommand(59.5, AssignCommand(oScryer, ClearAllActions(TRUE)));
							
							        // Return to the original scrying location
							        DelayCommand(60.0, AssignCommand(oScryer, JumpToLocation(lHere)));
							
							       
								//Find out information about oScried's area and area weather
								object oArea = GetArea(oScried);
								string sSubjectArea = "somewhere where you can see no identifying details of the surroundings.";	
								string sAreaTag = GetTag(oArea);
								 
								
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
								else if(FindSubString(sAreaTag, "circus", 0) != -1)
									{sSubjectArea = "outside, within site of circus exhibits.";}
								else if(FindSubString(sAreaTag, "bigtp", 0) != -1)
									{sSubjectArea = "inside a circus big top tent.";}
								else if(FindSubString(sAreaTag, "int_cards", 0) != -1)
									{sSubjectArea = "inside a tent, with card tables visible.";}
								else if(FindSubString(sAreaTag, "int_mirror", 0) != -1)
									{sSubjectArea = "inside a tent, with many mirrors seemingly on display.";}
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
									{sSubjectArea = "inside, with a huge library and wings off to dormitory towers.";}
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
								else if((FindSubString(sAreaTag, "_int_", 0) != -1) && (FindSubString(sAreaTag, "interior", 0) != -1)) 
									{sSubjectArea = "inside, though nothing uniquely identifiable is visible.";}
								else if(FindSubString(sAreaTag, "_ext_", 0) != -1)
									{sSubjectArea = "outside, though nothing uniquely identifiable is visible.";}
								else {sSubjectArea = "somewhere where you can see no identifying details of the surroundings.";}	
								
								
									
								int nWeatherRain = GetWeather(oArea, WEATHER_TYPE_RAIN);
								string sWeatherRain = "";
								int nWeatherSnow = GetWeather(oArea, WEATHER_TYPE_SNOW);
								string sWeatherSnow = "";
								int nDay = GetIsDay();
								
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
										
									if(nWeatherSnow == 0)  
										{sWeatherSnow = "The sky is clear. ";}
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
								
								string sFacing = GetCompassDirectionOfAngle(GetFacing(oScried));
								SetLocalLocation(OBJECT_SELF, "lScryStart", GetLocation(oScried));
								location lStart = GetLocalLocation(OBJECT_SELF, "lScryStart");
								//Determine what creatures and objects are near oScried	
								object oObject = GetFirstObjectInShape(SHAPE_SPHERE, 10.0, GetLocation(oScried), FALSE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_ITEM | OBJECT_TYPE_PLACED_EFFECT | OBJECT_TYPE_DOOR);
								string sObjectName = GetName(oObject);
								float fDistance = GetDistanceBetween(oScried, oObject);
								int nInc = 1;
								while ((oObject != OBJECT_INVALID) && (nInc <= 12)){
									oObject = GetNextObjectInShape(SHAPE_SPHERE, 10.0, GetLocation(oScried), FALSE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_ITEM | OBJECT_TYPE_PLACED_EFFECT | OBJECT_TYPE_DOOR);
								    sObjectName = GetName(oObject);
									fDistance = GetDistanceBetween(oScried, oObject);
									if((sObjectName != GetName(oScried)) && (sObjectName != "")) {
								    	if(nInc == 1) {
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
											}
											
										}
									nInc++;
									}
								
								string sNextTo;
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
								if((GetLocalString(OBJECT_SELF, "sNextToA") != "") || (GetLocalString(OBJECT_SELF, "sNextToB") != "") || (GetLocalString(OBJECT_SELF, "sNextToC") != "") || (GetLocalString(OBJECT_SELF, "sNextToD") != "") || (GetLocalString(OBJECT_SELF, "sNextToE") != "") || (GetLocalString(OBJECT_SELF, "sNextToF") != "") || (GetLocalString(OBJECT_SELF, "sNextToG") != "") || (GetLocalString(OBJECT_SELF, "sNextToH") != "") || (GetLocalString(OBJECT_SELF, "sNextToI") != "") || (GetLocalString(OBJECT_SELF, "sNextToJ") != "") || (GetLocalString(OBJECT_SELF, "sNextToK") != "") || (GetLocalString(OBJECT_SELF, "sNextToL") != ""))	
									{ActionSpeakString(sGenderNoun + " is standing next to " + sNextTo + ".", TALKVOLUME_TALK);}
								if((GetLocalString(OBJECT_SELF, "sFurtherA") != "") || (GetLocalString(OBJECT_SELF, "sFurtherB") != "") || (GetLocalString(OBJECT_SELF, "sFurtherC") != "") || (GetLocalString(OBJECT_SELF, "sFurtherD") != "") || (GetLocalString(OBJECT_SELF, "sFurtherE") != "") || (GetLocalString(OBJECT_SELF, "sFurtherF") != "") || (GetLocalString(OBJECT_SELF, "sFurtherG") != "") || (GetLocalString(OBJECT_SELF, "sFurtherH") != "") || (GetLocalString(OBJECT_SELF, "sFurtherI") != "") || (GetLocalString(OBJECT_SELF, "sFurtherJ") != "") || (GetLocalString(OBJECT_SELF, "sFurtherK") != "") || (GetLocalString(OBJECT_SELF, "sFurtherL") != ""))	
									{ActionSpeakString(sFurther + " can be seen nearby.", TALKVOLUME_TALK);}
								if((GetLocalString(OBJECT_SELF, "sOtherA") != "") || (GetLocalString(OBJECT_SELF, "sOtherB") != "") || (GetLocalString(OBJECT_SELF, "sOtherC") != "") || (GetLocalString(OBJECT_SELF, "sOtherD") != "") || (GetLocalString(OBJECT_SELF, "sOtherE") != "") || (GetLocalString(OBJECT_SELF, "sOtherF") != "") || (GetLocalString(OBJECT_SELF, "sOtherG") != "") || (GetLocalString(OBJECT_SELF, "sOtherH") != "") || (GetLocalString(OBJECT_SELF, "sOtherI") != "") || (GetLocalString(OBJECT_SELF, "sOtherJ") != "") || (GetLocalString(OBJECT_SELF, "sOtherK") != "") || (GetLocalString(OBJECT_SELF, "sOtherL") != ""))	
									{ActionSpeakString("Within view: " + sOther, TALKVOLUME_TALK );}
								
								//Notify oScryer and DMs of the end of the spell
								DelayCommand(fScryTimer - 5.0, ActionSpeakString("*The images in the " + sScryName + " fade.", TALKVOLUME_TALK));		
			 					DelayCommand(fScryTimer - 1.0, SendMessageToPC(oScryer, "The scry spell ends."));		
			 					DelayCommand(fScryTimer - 5.0, SendMessageToAllDMs(GetName(oScryer) + "'s scry spell ends and the images in the " + sScryName + " fade."));		
			 					//DelayCommand(fScryTimer - 5.0, SendMessageToPC(oScryer, "Your scry spell ends and the images in the " + sScryName + " fade."));		
			 
								//Unset ALL local objects at the end of the successful spell
								//Destroy Scrying Sensor and ScryListen
								//Backup in tsm_scry_npc_onspawn in case this successful branch doesn't fire
								DelayCommand(fScryTimer, SetLocalObject(oScry, "oScried", OBJECT_INVALID));
								DelayCommand(fScryTimer, SetLocalObject(OBJECT_SELF, "oScried", OBJECT_INVALID));
								DelayCommand(fScryTimer, SetLocalObject(oScryer, "oScried", OBJECT_INVALID));
								DelayCommand(fScryTimer, SetLocalObject(oScrySend, "oScried", OBJECT_INVALID));
								DelayCommand(fScryTimer, SetLocalObject(oScry, "oScryListen", OBJECT_INVALID));
								DelayCommand(fScryTimer, SetLocalObject(oScried, "oScryListen", OBJECT_INVALID));
								DelayCommand(fScryTimer, SetLocalObject(oScryer, "oScryListen", OBJECT_INVALID));
								DelayCommand(fScryTimer, SetLocalObject(oScrySend, "oScryListen", OBJECT_INVALID));
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
								
								DestroyObject(oScrySend, fScryTimer + 2.0); 
								DestroyObject(oScryWisp, fScryTimer + 3.0);
								DestroyObject(OBJECT_SELF, fScryTimer + 5.0);
								break;
								}
							 
							 }
						 nIncA++;
						 oScried = GetNextPC(FALSE);
						 sScriedName = GetName(oScried);
						 
				}	
			}
			
		else {SendMessageToPC(oScryer, "Your scrying spell fails to show you anyone by that name.");}	
		}
	else {if(nMatch == 6041) {
			SendMessageToPC(oScryer, "Your scrying spell fails to show you anyone by that name. Either they are not an adventurer or this " + GetName(oScry) + " is not keyed with their identity from an imbued scrying focus.");}	
		}
	}
					 	   	 
}