#include "acr_quest_i"
#include "acr_creature_i"
#include "x0_i0_position"

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
 

    object oPC = GetLastSpeaker();


    if(GetTag(OBJECT_SELF) == "003_cr_lath_cyrthol") 
			   {int nMatch = GetListenPatternNumber();
			    object oCollWP = GetLocalObject(OBJECT_SELF, "oCollWP");
				if(oCollWP == OBJECT_INVALID)
					 	{oCollWP = GetObjectByTag("003_door_sylune_collwp");
						 SetLocalObject(OBJECT_SELF, "oCollWP", oCollWP);
						}
				object oStatue = GetLocalObject(OBJECT_SELF, "oStatue");
			    if(oStatue == OBJECT_INVALID)
					 	{oStatue = GetObjectByTag("003_door_sylune_statue");
						 SetLocalObject(OBJECT_SELF, "oStatue", oStatue);
						}
				location lStatueWP = GetLocalLocation(OBJECT_SELF, "lStatueWP");
			    if(GetLocalInt(OBJECT_SELF, "lStatueWP") == 0)
					 	{lStatueWP = GetLocation(oStatue);
						 SetLocalLocation(OBJECT_SELF, "lStatueWP", lStatueWP);
						}
				object oStatueWP2 = GetLocalObject(OBJECT_SELF, "oStatueWP2");
			    if(oStatueWP2 == OBJECT_INVALID)
					 	{oStatueWP2 = GetObjectByTag("003_door_sylune_WP2");
						 SetLocalObject(OBJECT_SELF, "oStatueWP2", oStatueWP2);
						}
				object oWall= GetLocalObject(OBJECT_SELF, "oWall");
			    if(oWall == OBJECT_INVALID)
					 	{oWall = GetObjectByTag("003_door_sylune_wall");
						 SetLocalObject(OBJECT_SELF, "oWall", oWall);
						}
			    object oMyCollisionBox = GetLocalObject(OBJECT_SELF, "oMyCollisionBox");
				if(oMyCollisionBox == OBJECT_INVALID)
					 	{oMyCollisionBox = GetObjectByTag("003_door_sylune_collbox");
						 SetLocalObject(OBJECT_SELF, "oMyCollisionBox", oMyCollisionBox);
						}
				
			if((nMatch == 6001)  && (GetLocalInt(OBJECT_SELF, "SyluneOpen") == 0) )
					{SetLocalInt(OBJECT_SELF, "SyluneOpen", 1);
					 DestroyObject(oMyCollisionBox);
					 SetLocalObject(OBJECT_SELF, "oMyCollisionBox", OBJECT_INVALID);
					 DestroyObject(oWall);
					 SetLocalObject(OBJECT_SELF, "oWall", OBJECT_INVALID);
					 DestroyObject(oStatue);
					 SetLocalObject(OBJECT_SELF, "oStatue", OBJECT_INVALID);
					 oStatue = CreateObject(OBJECT_TYPE_PLACEABLE, "003_door_sylune_statue", GetLocation(oStatueWP2));
					 SetLocalObject(OBJECT_SELF, "oStatue", oStatue);
					 SendMessageToPC(oPC, "The statue silently slides sideways and the wall section before you drops into the floor.");
					 DelayCommand(59.0, SetLocalInt(OBJECT_SELF, "SyluneOpen", 2));
					 DelayCommand(60.0, ExecuteScript("tsm_npc_conversation", OBJECT_SELF));
					 }
					
			else if (GetLocalInt(OBJECT_SELF, "SyluneOpen")== 2)
				   	{SetLocalInt(OBJECT_SELF, "SyluneOpen", 0);
					 oMyCollisionBox = CreateObject(OBJECT_TYPE_PLACEABLE, "003_door_sylune_collbox", GetLocation(oCollWP));
					 SetLocalObject(OBJECT_SELF, "oMyCollisionBox", oMyCollisionBox);
					 oWall = CreateObject(OBJECT_TYPE_PLACEABLE, "003_door_sylune_wall", GetLocation(oCollWP));
					 SetLocalObject(OBJECT_SELF, "oWall", oWall);
					 DestroyObject(oStatue);
					 SetLocalObject(OBJECT_SELF, "oStatue", OBJECT_INVALID);
				 	 oStatue = CreateObject(OBJECT_TYPE_PLACEABLE, "003_door_sylune_statue", lStatueWP);
					 SetLocalObject(OBJECT_SELF, "oStatue", oStatue);
					  }
		 }
	
	if((GetTag(OBJECT_SELF)== "003_cr_scry_send") && (GetLastSpeaker() != OBJECT_SELF)  && (GetTag(GetLastSpeaker()) != "003_cr_scry_listen")) {
		object oScried = GetLocalObject(OBJECT_SELF, "oScried");
		
		ActionForceFollowObject(oScried, 0.5f, 0);
		object oScryListen = GetLocalObject(OBJECT_SELF, "oScryListen");	 
		int nMatch = GetListenPatternNumber();
		if(nMatch == 6031) {
			string sSpokenBy = GetName(GetLastSpeaker());
			SetFirstName(oScryListen, sSpokenBy);
			string sRelay = GetMatchedSubstring(0);
			if(GetLastSpeaker() != oScryListen) {
				DelayCommand(1.0, AssignCommand(oScryListen, ActionSpeakString(sRelay, TALKVOLUME_TALK)));
			}
		}
	}	 
	
	
	if((GetTag(OBJECT_SELF)== "003_cr_scry_send_xavier") && (GetLastSpeaker() != OBJECT_SELF)  && (GetTag(GetLastSpeaker()) != "003_cr_scry_listen")) {
		object oScried = GetLocalObject(OBJECT_SELF, "oScried");
		object oScryListen = GetLocalObject(OBJECT_SELF, "oScryListen");	 
		ActionForceFollowObject(oScried, 0.5f, 0);
		int nMatch = GetListenPatternNumber();
		if(nMatch == 6031) {
			string sSpokenBy = GetName(GetLastSpeaker());
			string sRelay = GetMatchedSubstring(0);
			SendMessageToAllDMs(sSpokenBy + ": " + sRelay);
		    if(GetLastSpeaker() != oScryListen) {
				DelayCommand(1.0, AssignCommand(oScryListen, ActionSpeakString(sRelay, TALKVOLUME_TALK)));
			}
		}
	}	 

	
	if((GetTag(OBJECT_SELF)== "003_cr_scry_listen") && (GetLastSpeaker()== GetLocalObject(OBJECT_SELF, "oScryer"))) {
		object oScry = GetLocalObject(OBJECT_SELF, "oScry");
		string sMatch = GetMatchedSubstring(1);
		object oScryer = GetLocalObject(OBJECT_SELF, "oScryer");
		string sRosterOne = GetFirstRosterMember();
		string sRosterTwo = GetNextRosterMember();
				 	
		
		int nMatch = GetListenPatternNumber();
		if((nMatch >= 6010) && (nMatch <= 6031)) {
		 	int nKnowledge;
			int nConnection;
			
			if((nMatch >= 6010) && (nMatch <= 6013)) {
				if(nMatch == 6010) {
				 	nKnowledge = -10;
				}
				if(nMatch == 6011) {
				 	nKnowledge = -5;
				}
				if(nMatch == 6012) {
				 	nKnowledge = 0;
				}
				if(nMatch == 6013) {
				 	nKnowledge = 5;
				}
				
				SetLocalInt(OBJECT_SELF, "nScryKnowledge", nKnowledge);
				SendMessageToPC(oScryer, "Your knowledge of the subject is: " + GetMatchedSubstring(1));
			}
			
		else if((nMatch >= 6014) && (nMatch <= 6017)) {
				if(nMatch == 6014) {
			 	nConnection = 0;
				}
				if(nMatch == 6015) {
			 	nConnection = 2;
				}
				if(nMatch == 6016) {
				 	nConnection = 4;
				}
				if(nMatch == 6017) {
				 	nConnection = 10;
				}
				
				SetLocalInt(OBJECT_SELF, "nScryConnection", nConnection);
				SendMessageToPC(oScryer, "Your connection to the subject is: " + GetMatchedSubstring(1));
			}
			
			//SendMessageToPC(oScryer, "DC = " + IntToString(nDC));
			
		else if(nMatch >= 6020) {
				int nTestPattern = 6020;
	         	object oPC = GetFirstPC(FALSE);
				string sPCName = GetName(oPC);
				
				while ((oPC != OBJECT_INVALID) && (nTestPattern <= 6031)) {
					
					
					 int nActive = GetLocalInt(oScry, "SCRY_ACTIVE");
					 if(GetLocalInt(oScry, "SCRY_ACTIVE")==1) {
						 //SendMessageToPC(oScryer, "Active = " + IntToString(nActive));
						 SendMessageToPC(oScryer, "You are scrying" + GetName(oPC) + " and must wait for this spell to end before scrying again. Use your scrying object for an update on your current subject.");
						 break;
						 }
					
					string sRosterName = GetFirstRosterMember();
					if(nTestPattern == 6020) {
						int nRosterInc = 0;
						while ((sRosterName != "") && (nRosterInc < 5)) {
							SendMessageToPC(oScryer, "RosterName is " + sRosterName);
							if(TestStringAgainstPattern("**" + sRosterName + "**", GetMatchedSubstring(1))) 
								{sPCName = sRosterName;}
							sRosterName = GetNextRosterMember();
							nRosterInc++;
							}
						} 
					 
					 SendMessageToPC(oScryer, "1. PCName is " + sPCName);
					 SendMessageToPC(oScryer, "1. RosterName is " + sRosterName);
							
					 if(sPCName == "") {
					 	sPCName = GetName(oPC);
					 }
					 SendMessageToPC(oScryer, "2. PCName is " + sPCName);
					 SendMessageToPC(oScryer, "2. RosterName is " + sRosterName);
						 
						 
					 if((TestStringAgainstPattern("**" + sPCName + "**", GetMatchedSubstring(1)))  && (GetLocalInt(oScry, "SCRY_ACTIVE")==0))
						{SendMessageToPC(oScryer, "Active = " + IntToString(nActive));
						int nDC = GetLocalInt(OBJECT_SELF, "nScryDC") + GetLocalInt(OBJECT_SELF, "nScryKnowledge") + GetLocalInt(OBJECT_SELF, "nScryConnection");
				 		if(WillSave(oPC, nDC, SAVING_THROW_TYPE_MIND_SPELLS, oScryer)) {
							 	SendMessageToPC(oPC, "You have a momentary sense of being watched...but it passes.");
							 	if(GetLocalInt(OBJECT_SELF, "nScryKnowledge") > 0) {
									SendMessageToPC(oScryer, "The passing sensation had a familiar presence to it, as if you had heard " + GetName(oScryer) + " call your name." );
									SendMessageToAllDMs(GetName(oPC) + " WillSaved DC " + IntToString(nDC) + " against " + GetName(oScryer) + " scrying them."); }
								}
							 else {
							 	SetLocalObject(oScry, "oScried", oPC);
							 	float fScryTimer = GetLocalFloat(OBJECT_SELF, "SCRY_TIMER");
								SendMessageToPC(oScryer, "Your scrying will last " + FloatToString(fScryTimer, 2, 0) + " seconds.");
							 	SetLocalInt(oScry, "SCRY_ACTIVE", 1);
								DelayCommand(fScryTimer, SetLocalFloat(oScry, "SCRY_TIMER", 0.0));
								DelayCommand(fScryTimer, SetLocalInt(oScry, "SCRY_ACTIVE", 0));
								SendMessageToAllDMs(GetName(oPC) + " failed a WillSave DC " + IntToString(nDC) + " and is being scried by " + GetName(oScryer) + " for the next " + FloatToString(fScryTimer, 2, 0) + " seconds."); 
								location lThere = GetLocation(oPC);
								object oScrySend = GetLocalObject(OBJECT_SELF, "oScrySend");
								if(oScrySend == OBJECT_INVALID) {
									if(GetIsDMPossessed(oScryer)) {oScrySend = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_scry_send_xavier", lThere);}
									else {oScrySend = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_scry_send", lThere);}
					            	SetLocalObject(oScry, "oScrySend", oScrySend);
									SetLocalObject(OBJECT_SELF, "oScrySend", oScrySend);
									SetLocalObject(oScrySend, "oScryListen", OBJECT_SELF);
									SetLocalObject(oScrySend, "oScried", oPC);
									SetFirstName(oScrySend, "Scrying Sensor");
									DelayCommand(2.0, AssignCommand(oScrySend, ActionForceFollowObject(oPC, 0.5f, 0)));
									DestroyObject(oScrySend, fScryTimer); 
									DelayCommand(fScryTimer, SetLocalObject(OBJECT_SELF, "oScrySend", OBJECT_INVALID));
									}
								
								object oArea = GetArea(oPC);
								string sSubjectArea = GetName(oArea);
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
								
								if(FindSubString(sAreaTag, "ext", 1) != -1)
								   {if(nWeatherRain == 0)  
										{sWeatherRain = "The sun is shining. ";}
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
								if(GetGender(oPC) == GENDER_FEMALE) {
									sGenderNoun = "She";
									sGenderAdj = "her";
								}
								
								ActionSpeakString( GetName(oPC) + " is " + sSubjectArea + " " + sWeatherRain + sWeatherSnow, TALKVOLUME_TALK);
								
								string sFacing = GetCompassDirectionOfAngle(GetFacing(oPC));
								SetLocalLocation(OBJECT_SELF, "lScryStart", GetLocation(oPC));
								location lStart = GetLocalLocation(OBJECT_SELF, "lScryStart");
								 	
								object oObject = GetFirstObjectInShape(SHAPE_SPHERE, 10.0, GetLocation(oPC), FALSE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_ITEM | OBJECT_TYPE_PLACED_EFFECT | OBJECT_TYPE_DOOR);
								string sObjectName = GetName(oObject);
								float fDistance = GetDistanceBetween(oPC, oObject);
								int nInc = 1;
								while ((oObject != OBJECT_INVALID) && (nInc <= 12)){
									oObject = GetNextObjectInShape(SHAPE_SPHERE, 10.0, GetLocation(oPC), FALSE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_ITEM | OBJECT_TYPE_PLACED_EFFECT | OBJECT_TYPE_DOOR);
								    sObjectName = GetName(oObject);
									fDistance = GetDistanceBetween(oPC, oObject);
									if((sObjectName != GetName(oPC)) && (sObjectName != "")) {
								    	if(nInc == 1) {
											string sObjectNameA = GetName(oObject);
											float fDistanceA = GetDistanceBetween(oPC, oObject);
											int nObjectTypeA = GetObjectType(oObject);
											if((nObjectTypeA == OBJECT_TYPE_CREATURE) && (fDistanceA < 3.0))
												{SetLocalString(OBJECT_SELF, "sNextToA", sObjectNameA);}
											else if(nObjectTypeA == OBJECT_TYPE_CREATURE)
												{SetLocalString(OBJECT_SELF, "sFurtherA", sObjectNameA);}
											else {SetLocalString(OBJECT_SELF, "sOtherA", sObjectNameA);}
											}
										else if(nInc == 2) {
											string sObjectNameB = GetName(oObject);
											float fDistanceB = GetDistanceBetween(oPC, oObject);
											int nObjectTypeB = GetObjectType(oObject);
											if((nObjectTypeB == OBJECT_TYPE_CREATURE) && (fDistanceB < 3.0))
												{SetLocalString(OBJECT_SELF, "sNextToB", sObjectNameB);}
											else if(nObjectTypeB == OBJECT_TYPE_CREATURE)
												{SetLocalString(OBJECT_SELF, "sFurtherB", sObjectNameB);}
											else {SetLocalString(OBJECT_SELF, "sOtherB", sObjectNameB);}
											}
										else if(nInc == 3) {
											string sObjectNameC = GetName(oObject);
											float fDistanceC = GetDistanceBetween(oPC, oObject);
											int nObjectTypeC = GetObjectType(oObject);
											if((nObjectTypeC == OBJECT_TYPE_CREATURE) && (fDistanceC < 3.0))
												{SetLocalString(OBJECT_SELF, "sNextToC", sObjectNameC);}
											else if(nObjectTypeC == OBJECT_TYPE_CREATURE)
												{SetLocalString(OBJECT_SELF, "sFurtherC", sObjectNameC);}
											else {SetLocalString(OBJECT_SELF, "sOtherC", sObjectNameC);}
											}
										else if(nInc == 4) {
											string sObjectNameD = GetName(oObject);
											float fDistanceD = GetDistanceBetween(oPC, oObject);
											int nObjectTypeD = GetObjectType(oObject);
											if((nObjectTypeD == OBJECT_TYPE_CREATURE) && (fDistanceD < 3.0))
												{SetLocalString(OBJECT_SELF, "sNextToD", sObjectNameD);}
											else if(nObjectTypeD == OBJECT_TYPE_CREATURE)
												{SetLocalString(OBJECT_SELF, "sFurtherD", sObjectNameD);}
											else {SetLocalString(OBJECT_SELF, "sOtherD", sObjectNameD);}
											}
										if(nInc == 5) {
											string sObjectNameE = GetName(oObject);
											float fDistanceE = GetDistanceBetween(oPC, oObject);
											int nObjectTypeE = GetObjectType(oObject);
											if((nObjectTypeE == OBJECT_TYPE_CREATURE) && (fDistanceE < 3.0))
												{SetLocalString(OBJECT_SELF, "sNextToE", sObjectNameE);}
											else if(nObjectTypeE == OBJECT_TYPE_CREATURE)
												{SetLocalString(OBJECT_SELF, "sFurtherE", sObjectNameE);}
											else {SetLocalString(OBJECT_SELF, "sOtherE", sObjectNameE);}
											}
										else if(nInc == 6) {
											string sObjectNameF = GetName(oObject);
											float fDistanceF = GetDistanceBetween(oPC, oObject);
											int nObjectTypeF = GetObjectType(oObject);
											if((nObjectTypeF == OBJECT_TYPE_CREATURE) && (fDistanceF < 3.0))
												{SetLocalString(OBJECT_SELF, "sNextToF", sObjectNameF);}
											else if(nObjectTypeF == OBJECT_TYPE_CREATURE)
												{SetLocalString(OBJECT_SELF, "sFurtherF", sObjectNameF);}
											else {SetLocalString(OBJECT_SELF, "sOtherF", sObjectNameF);}
											}
										else if(nInc == 7) {
											string sObjectNameG = GetName(oObject);
											float fDistanceG = GetDistanceBetween(oPC, oObject);
											int nObjectTypeG = GetObjectType(oObject);
											if((nObjectTypeG == OBJECT_TYPE_CREATURE) && (fDistanceG < 3.0))
												{SetLocalString(OBJECT_SELF, "sNextToG", sObjectNameG);}
											else if(nObjectTypeG == OBJECT_TYPE_CREATURE)
												{SetLocalString(OBJECT_SELF, "sFurtherG", sObjectNameG);}
											else {SetLocalString(OBJECT_SELF, "sOtherG", sObjectNameG);}
											}
										else if(nInc == 8) {
											string sObjectNameH = GetName(oObject);
											float fDistanceH = GetDistanceBetween(oPC, oObject);
											int nObjectTypeH = GetObjectType(oObject);
											if((nObjectTypeH == OBJECT_TYPE_CREATURE) && (fDistanceH < 3.0))
												{SetLocalString(OBJECT_SELF, "sNextToH", sObjectNameH);}
											else if(nObjectTypeH == OBJECT_TYPE_CREATURE)
												{SetLocalString(OBJECT_SELF, "sFurtherH", sObjectNameH);}
											else {SetLocalString(OBJECT_SELF, "sOtherH", sObjectNameH);}
											}
										if(nInc == 9) {
											string sObjectNameI = GetName(oObject);
											float fDistanceI = GetDistanceBetween(oPC, oObject);
											int nObjectTypeI = GetObjectType(oObject);
											if((nObjectTypeI == OBJECT_TYPE_CREATURE) && (fDistanceI < 3.0))
												{SetLocalString(OBJECT_SELF, "sNextToI", sObjectNameI);}
											else if(nObjectTypeI == OBJECT_TYPE_CREATURE)
												{SetLocalString(OBJECT_SELF, "sFurtherI", sObjectNameI);}
											else {SetLocalString(OBJECT_SELF, "sOtherI", sObjectNameI);}
											}
										else if(nInc == 10) {
											string sObjectNameJ = GetName(oObject);
											float fDistanceJ = GetDistanceBetween(oPC, oObject);
											int nObjectTypeJ = GetObjectType(oObject);
											if((nObjectTypeJ == OBJECT_TYPE_CREATURE) && (fDistanceJ < 3.0))
												{SetLocalString(OBJECT_SELF, "sNextToJ", sObjectNameJ);}
											else if(nObjectTypeJ == OBJECT_TYPE_CREATURE)
												{SetLocalString(OBJECT_SELF, "sFurtherJ", sObjectNameJ);}
											else {SetLocalString(OBJECT_SELF, "sOtherJ", sObjectNameJ);}
											}
										else if(nInc == 11) {
											string sObjectNameK = GetName(oObject);
											float fDistanceK = GetDistanceBetween(oPC, oObject);
											int nObjectTypeK = GetObjectType(oObject);
											if((nObjectTypeK == OBJECT_TYPE_CREATURE) && (fDistanceK < 3.0))
												{SetLocalString(OBJECT_SELF, "sNextToK", sObjectNameK);}
											else if(nObjectTypeK == OBJECT_TYPE_CREATURE)
												{SetLocalString(OBJECT_SELF, "sFurtherK", sObjectNameK);}
											else {SetLocalString(OBJECT_SELF, "sOtherK", sObjectNameK);}
											}
										else if(nInc == 12) {
											string sObjectNameL = GetName(oObject);
											float fDistanceL = GetDistanceBetween(oPC, oObject);
											int nObjectTypeL = GetObjectType(oObject);
											if((nObjectTypeL == OBJECT_TYPE_CREATURE) && (fDistanceL < 3.0))
												{SetLocalString(OBJECT_SELF, "sNextToL", sObjectNameL);}
											else if(nObjectTypeL == OBJECT_TYPE_CREATURE)
												{SetLocalString(OBJECT_SELF, "sFurtherL", sObjectNameL);}
											else {SetLocalString(OBJECT_SELF, "sOtherL", sObjectNameL);}
											}
											
										//SendMessageToPC(oScryer, sObjectName + " is " + FloatToString(fDistance, 2, 0) + " feet to the " + GetCompassDirectionOfAngle(GetAngleBetweenObjects(oPC, oObject)) + ".");
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
									
								if((GetLocalString(OBJECT_SELF, "sNextToA") != "") || (GetLocalString(OBJECT_SELF, "sNextToB") != "") || (GetLocalString(OBJECT_SELF, "sNextToC") != "") || (GetLocalString(OBJECT_SELF, "sNextToD") != "") || (GetLocalString(OBJECT_SELF, "sNextToE") != "") || (GetLocalString(OBJECT_SELF, "sNextToF") != "") || (GetLocalString(OBJECT_SELF, "sNextToG") != "") || (GetLocalString(OBJECT_SELF, "sNextToH") != "") || (GetLocalString(OBJECT_SELF, "sNextToI") != "") || (GetLocalString(OBJECT_SELF, "sNextToJ") != "") || (GetLocalString(OBJECT_SELF, "sNextToK") != "") || (GetLocalString(OBJECT_SELF, "sNextToL") != ""))	
									{ActionSpeakString(sGenderNoun + " is standing next to " + sNextTo + ".", TALKVOLUME_TALK);}
								if((GetLocalString(OBJECT_SELF, "sFurtherA") != "") || (GetLocalString(OBJECT_SELF, "sFurtherB") != "") || (GetLocalString(OBJECT_SELF, "sFurtherC") != "") || (GetLocalString(OBJECT_SELF, "sFurtherD") != "") || (GetLocalString(OBJECT_SELF, "sFurtherE") != "") || (GetLocalString(OBJECT_SELF, "sFurtherF") != "") || (GetLocalString(OBJECT_SELF, "sFurtherG") != "") || (GetLocalString(OBJECT_SELF, "sFurtherH") != "") || (GetLocalString(OBJECT_SELF, "sFurtherI") != "") || (GetLocalString(OBJECT_SELF, "sFurtherJ") != "") || (GetLocalString(OBJECT_SELF, "sFurtherK") != "") || (GetLocalString(OBJECT_SELF, "sFurtherL") != ""))	
									{ActionSpeakString(sFurther + " can be seen nearby.", TALKVOLUME_TALK);}
								if((GetLocalString(OBJECT_SELF, "sOtherA") != "") || (GetLocalString(OBJECT_SELF, "sOtherB") != "") || (GetLocalString(OBJECT_SELF, "sOtherC") != "") || (GetLocalString(OBJECT_SELF, "sOtherD") != "") || (GetLocalString(OBJECT_SELF, "sOtherE") != "") || (GetLocalString(OBJECT_SELF, "sOtherF") != "") || (GetLocalString(OBJECT_SELF, "sOtherG") != "") || (GetLocalString(OBJECT_SELF, "sOtherH") != "") || (GetLocalString(OBJECT_SELF, "sOtherI") != "") || (GetLocalString(OBJECT_SELF, "sOtherJ") != "") || (GetLocalString(OBJECT_SELF, "sOtherK") != "") || (GetLocalString(OBJECT_SELF, "sOtherL") != ""))	
									{ActionSpeakString("Within view: " + sOther, TALKVOLUME_TALK );}
								
								SetLocalLocation(OBJECT_SELF, "lNew", GetLocation(oPC));
								location lNew = GetLocalLocation(OBJECT_SELF, "lNew");
								float fDistanceMoved = GetDistanceBetweenLocations(lStart, lNew);
								//SendMessageToPC(oScryer, "Distance between where the scrying began and where " + GetStringLowerCase(sGenderNoun) + " is now is " + FloatToString(fDistanceMoved, 2, 0));
								string sMoving = "standing still.";
								string sDirection = GetCompassDirectionOfAngle(GetAngleBetweenLocations(lStart, lNew));
								if(fDistanceMoved != 0.0) {
										sMoving = "moving " + sDirection + ".";
									}
								ActionSpeakString(GetName(oPC) + " is " + sMoving, TALKVOLUME_TALK);
								}
							 break;
							 }
						 nTestPattern++;
						 oPC = GetNextPC(FALSE);
				}	
			}
			
		else {SendMessageToPC(oScryer, "Your scrying spell fails to show you anyone by that name.");}	
				
		} 	
		
		 
	}	 
	
		 
	if(GetTag(OBJECT_SELF) == "003_cr_voice") 
		{int nMatch = GetListenPatternNumber();
		 string sArea = "_palace";
		 if(GetTag(GetArea(OBJECT_SELF)) == "6d_int_silvy_catacombs_1")
				{sArea = "_catacombs";
				}
		 object oMyTrigger = GetLocalObject(OBJECT_SELF, "oMyTrigger");
		 object oMyHeadstone = GetLocalObject(OBJECT_SELF, "oMyHeadstone");
		 if(oMyHeadstone == OBJECT_INVALID)
		 	{oMyHeadstone = GetObjectByTag(GetTag(oMyTrigger) + sArea);
			 SetLocalObject(OBJECT_SELF, "oMyHeadstone", oMyHeadstone);
			     if(oMyHeadstone == OBJECT_INVALID)
			 	{oMyHeadstone = GetObjectByTag("sm_sylune_listener_catacombs");
				 SetLocalObject(OBJECT_SELF, "oMyHeadstone", oMyHeadstone);
				 }
			}
		 		 			 
		 if(nMatch == 6009)
				 {if((GetItemPossessedBy(GetPCSpeaker(), "003_it_ward_adrath") == OBJECT_INVALID)&&(GetItemPossessedBy(GetPCSpeaker(), "003_it_ward_duraph") == OBJECT_INVALID)&&(GetItemPossessedBy(GetPCSpeaker(), "003_it_ward_lauthal") == OBJECT_INVALID)&&(GetItemPossessedBy(GetPCSpeaker(), "003_it_ward_thelbane") == OBJECT_INVALID))
						{SpeakString("That avenue is barred to those who are not Ward Initiates.", TALKVOLUME_TALK);
						}
				}
		 if((nMatch > 6001) && (nMatch < 6009))
			 {string sName = "Alustriel";
			  if(nMatch == 6003)
					{sName = "Dove";
					}
			  if(nMatch == 6004)
					{sName = "Storm";
					}
			  if(nMatch == 6005)
					{sName = "Laeral";
					}
			  if(nMatch == 6006)
					{sName = "Simbul";
					}
			  if(nMatch == 6007)
					{sName = "Alassra";
					}
			  if(nMatch == 6008)
					{sName = "Qilue";
					}
			  object oPortalTo = GetLocalObject(OBJECT_SELF, "oPortalTo");
			  if(oPortalTo == OBJECT_INVALID)
					 {oPortalTo = GetWaypointByTag(sName + "_Sylune_Portal_WP");
					  SetLocalObject(OBJECT_SELF, "oPortalTo", oPortalTo);
					  SetLocalObject(oMyHeadstone, "oPortalTo", oPortalTo);
					 }
			  DelayCommand(60.0, SetLocalObject(oMyHeadstone, "oPortalTo", OBJECT_INVALID));
			  SpeakString(sName + ".", TALKVOLUME_TALK);
			  DelayCommand(5.0, SpeakString(sName + " declines. Your signature has been noted.", TALKVOLUME_TALK));
			  if(((nMatch == 6002) || (nMatch == 6004)) && (ACR_RetrieveQuestState("slv_deandragon_h", oPC) >= 4) && (ACR_RetrieveQuestState("slv_deandragon_h", oPC) <= 5))
				 	{DelayCommand(7.5, SpeakString("*A new voice speaks, more feminine, and somehow more 'real'.", TALKVOLUME_TALK));
					 DelayCommand(10.0, SpeakString("One-time passage is granted, I think, to those who wish it. All aspects of the traveller will be noted: divine signature of deific powers and arcane signature of all Weave contact. Recent memories will be divined. If you accept these terms and wish to travel, touch the Headstone within one minute.", TALKVOLUME_TALK));
					 SetLocalInt(oMyHeadstone, "Active", 1);
					 DelayCommand(60.0, SetLocalInt(oMyHeadstone, "Active", 0));
					 }  
				
			if(((nMatch == 6002) || (nMatch == 6004)) && (ACR_RetrieveQuestState("slv_deansphinx_h", oPC) >= 5))
				 	{DelayCommand(7.5, SpeakString("*A new voice speaks, more feminine, and somehow more 'real'.", TALKVOLUME_TALK));
					 DelayCommand(10.0, SpeakString("One-time passage is granted, I think, to those who wish it. All aspects of the traveller will be noted: divine signature of deific powers and arcane signature of all Weave contact. Recent memories will be divined. If you accept these terms and wish to travel, touch the Headstone within one minute.", TALKVOLUME_TALK));
					 SetLocalInt(oMyHeadstone, "Active", 1);
					 DelayCommand(60.0, SetLocalInt(oMyHeadstone, "Active", 0));
					 }  
				}
					
			  if((nMatch == 6001)&& (GetTag(GetArea(OBJECT_SELF)) == "6d_int_silvy_catacombs_1")&& (GetLocalInt(OBJECT_SELF, "SyluneShow") != 1))
				 	{ object oSyluneGhost = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_silverhand_sylune", GetLocation(oMyHeadstone));
					  SetLocalObject(OBJECT_SELF, "oSyluneGhost", oSyluneGhost);
					  AssignCommand(oSyluneGhost, SpeakString("Sylune.", TALKVOLUME_TALK));
					  DelayCommand(5.0, AssignCommand(oSyluneGhost, SpeakString("Sylune, beloved sister.", TALKVOLUME_TALK)));
					  DelayCommand(10.0, AssignCommand(oSyluneGhost, SpeakString("Sylune is no more. That avenue is forever closed.", TALKVOLUME_TALK)));
					  SetLocalInt(OBJECT_SELF, "SyluneShow", 1);
					  DelayCommand(200.0, SetLocalInt(OBJECT_SELF, "SyluneShow", 0));
					         location lGoTo2 = GetLocalLocation(oMyHeadstone, "lGoTo2");
							 location lGoTo3 = GetLocalLocation(oMyHeadstone, "lGoTo3");
							 location lGoTo4 = GetLocalLocation(oMyHeadstone, "lGoTo4");
							 effect eKnockdown = EffectKnockdown();
							 effect eRippleExplode = EffectVisualEffect(507, FALSE);
							 effect eGlobeInvuln = EffectVisualEffect(512, FALSE);
							 effect ePrismatic = EffectVisualEffect(607, FALSE);
							 effect eRedGroundCircle = EffectVisualEffect(496, FALSE);
							 effect eGround1 = EffectVisualEffect(554, FALSE);
							 effect eGround2 = EffectVisualEffect(555, FALSE);
							 effect eGround3 = EffectVisualEffect(556, FALSE);
							 effect eFireExplosion = EffectVisualEffect(564, FALSE);
							 effect eSteamExplosion = EffectVisualEffect(569, FALSE);
							 effect eElectric = EffectVisualEffect(74, FALSE);
							 effect eDarkness = EffectVisualEffect(886, FALSE);
							 effect eFireCone = EffectVisualEffect(871, FALSE);
							 effect eFilaments = EffectVisualEffect(729, FALSE);
							 effect eHeal = EffectVisualEffect(70, FALSE);
							 effect ePestilence = EffectVisualEffect(538, FALSE);
							 effect eSongRunes = EffectVisualEffect(631, FALSE);
							 effect eHolyStrike = EffectVisualEffect(626, FALSE);
							 effect eRevolving = EffectVisualEffect(553, FALSE);
							 effect eCircle = EffectVisualEffect(700, FALSE);
							 effect eQuake = EffectVisualEffect(VFX_SPELL_HIT_EARTHQUAKE, FALSE);
							 effect eExpanding = EffectVisualEffect(552, FALSE);
							 effect eImplode = EffectVisualEffect(736, FALSE);
							 effect ePillar = EffectVisualEffect(999, FALSE);
							 effect eRipple = EffectVisualEffect(1045, FALSE);
							 effect eSonicImplode = EffectVisualEffect(1009, FALSE);
							 effect eRing = EffectVisualEffect(1010, FALSE);
							 effect eWhiteOut = EffectVisualEffect(778, FALSE);
							 object oSylune = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_deandragon_h_sylune", lGoTo4);
					  		 object oDragon = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_deandragon_h_dragon", lGoTo2);
					  		 SetLocalObject(OBJECT_SELF, "oSylune", oSylune);
							 SetLocalObject(OBJECT_SELF, "oRedDragon", oDragon);
							 DelayCommand(15.0, AssignCommand(oSyluneGhost, ActionSpeakString("Sylune died in the Year of Rogue Dragons.", TALKVOLUME_TALK)));
							 DelayCommand(23.0, AssignCommand(oSyluneGhost, ActionSpeakString("While Silverymoon dealt with a flight of dragons at its walls, far away Sylune had not the walls nor the resources of Silverymoon. When the dragons appeared in her skies, there was only her.", TALKVOLUME_TALK)));
							 DelayCommand(30.0, AssignCommand(oSyluneGhost, ActionSpeakString("And so she went to meet them.", TALKVOLUME_TALK)));
							 DelayCommand(37.0, AssignCommand(oSyluneGhost, ActionSpeakString("There was one great red dragon whom she could neither force nor threaten away.", TALKVOLUME_TALK)));
							 DelayCommand(37.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGround1, oDragon, 3.0));
							 DelayCommand(44.0, AssignCommand(oSyluneGhost, ActionSpeakString("Again and again she tried to turn him back with words.", TALKVOLUME_TALK)));
							 DelayCommand(46.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGround2, oDragon, 3.0));
							 DelayCommand(49.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGlobeInvuln, oDragon, 40.0));
							 DelayCommand(52.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRedGroundCircle, oDragon, 3.0));
							 DelayCommand(56.0, AssignCommand(oSyluneGhost, ActionSpeakString("He but used the time to prepare. His evil and his intentions apparent, she raised protections.", TALKVOLUME_TALK)));
							 DelayCommand(58.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGlobeInvuln, oSylune, 5.0));
							 DelayCommand(63.0, AssignCommand(oSyluneGhost, ActionSpeakString("But too late. The dragon attacked, ripping away those protections.", TALKVOLUME_TALK)));
							 DelayCommand(67.5, AssignCommand(oDragon,  ActionCastFakeSpellAtObject(IP_CONST_CASTSPELL_DRAGON_BREATH_FIRE_10, oDragon, PROJECTILE_PATH_TYPE_DEFAULT)));
							 DelayCommand(68.0, AssignCommand(oDragon, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFireCone, oSylune, 3.0)));
							 DelayCommand(69.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFireExplosion, oSylune, 5.0));
							 DelayCommand(72.0, AssignCommand(oDragon, ActionAttack(oSylune)));
							 DelayCommand(73.0, AssignCommand(oSylune, ClearAllActions(TRUE)));
							 DelayCommand(74.0, AssignCommand(oSylune, ActionForceMoveToLocation(lGoTo2)));
							 DelayCommand(78.0, AssignCommand(oSylune, SetFacingPoint(GetPositionFromLocation(GetLocation(oDragon)), FALSE)));
							 DelayCommand(78.5, AssignCommand(oDragon, ClearAllActions(TRUE)));
							 DelayCommand(79.0, AssignCommand(oDragon, SetFacingPoint(GetPositionFromLocation(GetLocation(oSylune)), FALSE)));
							 DelayCommand(79.0, AssignCommand(oSyluneGhost, ActionSpeakString("Stung, she cast a mild warning spell at it before attempting to resume peaceful persuasion.", TALKVOLUME_TALK)));
							 DelayCommand(79.5, AssignCommand(oSylune,  ActionCastFakeSpellAtObject(SPELL_MAGIC_MISSILE, oDragon, PROJECTILE_PATH_TYPE_DEFAULT)));
							 DelayCommand(81.0, AssignCommand(oSylune, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eElectric, oDragon, 3.0)));
							 DelayCommand(83.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eElectric, oDragon, 3.0));
							 DelayCommand(86.0, AssignCommand(oSyluneGhost, ActionSpeakString("Rather than parley, though, the unsubtle creature threw the full force of fang and spell at her. The battle was unavoidably joined!", TALKVOLUME_TALK)));
							 DelayCommand(88.5, AssignCommand(oDragon,  ActionCastFakeSpellAtObject(IP_CONST_CASTSPELL_DRAGON_BREATH_FIRE_10, oDragon, PROJECTILE_PATH_TYPE_DEFAULT)));
							 DelayCommand(89.0, AssignCommand(oDragon, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFireCone, oSylune, 3.0)));
							 DelayCommand(90.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFireExplosion, oSylune, 5.0));
							 DelayCommand(93.0, AssignCommand(oDragon, ActionAttack(oSylune)));
							 DelayCommand(93.5, AssignCommand(oSylune,  ActionCastFakeSpellAtObject(SPELL_SOUND_BURST, oDragon, PROJECTILE_PATH_TYPE_DEFAULT)));
							 DelayCommand(94.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eCircle, oDragon, 3.0));
							 DelayCommand(94.0, AssignCommand(oSylune, ClearAllActions(TRUE)));
							 DelayCommand(94.5, AssignCommand(oSylune, ClearAllActions(TRUE)));
							 DelayCommand(95.0, AssignCommand(oSylune, ActionForceMoveToLocation(lGoTo3)));
							 DelayCommand(99.0, AssignCommand(oSylune, SetFacingPoint(GetPositionFromLocation(GetLocation(oSylune)), FALSE)));
							 DelayCommand(100.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eExpanding, oSylune, 3.0));
							 DelayCommand(102.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHeal, oSylune, 3.0));
							 DelayCommand(105.5, AssignCommand(oSylune,  ActionCastFakeSpellAtObject(SPELL_SONG_OF_DISCORD, oDragon, PROJECTILE_PATH_TYPE_DEFAULT)));
							 DelayCommand(107.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSteamExplosion, oDragon, 3.0));
							 DelayCommand(109.0, AssignCommand(oSylune, ClearAllActions(TRUE)));
							 DelayCommand(109.5, AssignCommand(oSylune, ClearAllActions(TRUE)));
							 DelayCommand(110.0, AssignCommand(oSylune, ActionForceMoveToLocation(lGoTo3)));
							 DelayCommand(114.0, AssignCommand(oSylune, SetFacingPoint(GetPositionFromLocation(GetLocation(oDragon)), FALSE)));
							 DelayCommand(114.5, AssignCommand(oDragon, SetFacingPoint(GetPositionFromLocation(GetLocation(oSylune)), FALSE)));
							 DelayCommand(115.5, AssignCommand(oSylune,  ActionCastFakeSpellAtObject(SPELL_SYMBOL_OF_DEATH, oDragon, PROJECTILE_PATH_TYPE_DEFAULT)));
							 DelayCommand(118.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHeal, oDragon, 3.0));
							 DelayCommand(119.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePestilence, oSylune, 5.0));
							 DelayCommand(119.5, AssignCommand(oSyluneGhost, ActionSpeakString("To negate his natural advantages, she polymorphed into a silver dragon.", TALKVOLUME_TALK)));
							 DelayCommand(120.0, SetLocalInt(OBJECT_SELF, "Stage", 1));
							 DelayCommand(123.5, ExecuteScript("tsm_npc_execute", OBJECT_SELF));
							 DelayCommand(124.0, AssignCommand(oDragon, ClearAllActions(TRUE)));
							 
							 
							 
					  if(ACR_RetrieveQuestState("slv_deandragon_h", oPC) == 4)
								{DelayCommand(195.0, ACR_AddPersistentJournalQuestEntry("slv_deandragon_h", 5, oPC));
								}
					  if(ACR_RetrieveQuestState("slv_deansphinx_h", oPC) == 4)
								{ACR_AddPersistentJournalQuestEntry("slv_deansphinx_h", 5, oPC);
								}
					}
			}
				 
				 
				 
	//slv_deandragon_l 
    if(GetTag(OBJECT_SELF) == "003_cr_dr_nephos") 
			   {DelayCommand(10.0, ChangeToStandardFaction(OBJECT_SELF, STANDARD_FACTION_HOSTILE));
			   }
			 
			   	//slv_deandragon_x 
    if(GetTag(OBJECT_SELF) == "003_cr_slv_procenc2") 
			   {CreateObject(OBJECT_TYPE_PLACEABLE, "slv_deandragon_x_gem_plc", GetLocation(GetWaypointByTag("slv_deandragon_x_alastrarra")));
			   }
	   	 
}