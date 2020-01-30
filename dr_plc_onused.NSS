////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ACR Configuration File
//     Filename : dr_plc_onused.nss
//    $Revision:: 183        $ current version of the file
//        $Date:: 2006-12-21#$ date the file was created or modified
//       Author : Ronan
	//   Altered by Wynna 10/21/08
//
//  Local Variable Prefix =
//
//  Dependencies external of nwscript:
//
//  Description
//  This script calls the ACR's OnUsed code for placeables, and any
//  custom code a server may need. It is not updated in ACR updates.
//
//  Revision History
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

#include "acr_placeable_i"
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

// The main event handler.
void main();

////////////////////////////////////////////////////////////////////////////////
// Function Definitions ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

void main() {
    ACR_PlaceableOnUsed();
  
    // Custom code goes here.
	
	//Dungeon of the Ruins useable placeables
	


	if(GetTag(OBJECT_SELF) == "dr_magus_mummy")
	   	{DestroyObject(OBJECT_SELF);
		}

	
	if(GetTag(OBJECT_SELF) == "dr_pit_trap_out")
	   	{object oWaypointUp;
		 object oPitDown1 = GetLocalObject(OBJECT_SELF, "oPitDown1");
		 if(oPitDown1 == OBJECT_INVALID)
				{oPitDown1 = GetWaypointByTag("dr_trapdoor1_down");
				 SetLocalObject(OBJECT_SELF, "oPitDown1", oPitDown1);
				 }
		 object oPitDown2 = GetLocalObject(OBJECT_SELF, "oPitDown2");
		 if(oPitDown2 == OBJECT_INVALID)
				{oPitDown2 = GetWaypointByTag("dr_trapdoor2_down");
				 SetLocalObject(OBJECT_SELF, "oPitDown2", oPitDown2);
				 }
		 object oPitUp1 = GetLocalObject(OBJECT_SELF, "oPitUp1");
		 if(oPitUp1 == OBJECT_INVALID)
				{oPitUp1 = GetWaypointByTag("dr_trapdoor1_up");
				 SetLocalObject(OBJECT_SELF, "oPitUp1", oPitUp1);
				 }
		 object oPitUp2 = GetLocalObject(OBJECT_SELF, "oPitUp2");
		 if(oPitUp2 == OBJECT_INVALID)
				{oPitUp2 = GetWaypointByTag("dr_trapdoor2_up");
				 SetLocalObject(OBJECT_SELF, "oPitUp2", oPitUp2);
				 }
		 if(GetDistanceBetween(GetLastUsedBy(), oPitDown1) < 2.0)
		 	{SendMessageToPC(GetLastUsedBy(), "You scale the ladder.");
			 oWaypointUp = oPitUp1;
			AssignCommand(GetLastUsedBy(), ActionJumpToObject(oWaypointUp, FALSE));
			 }
		 else if(GetDistanceBetween(GetLastUsedBy(), oPitDown2) < 2.0)
		 	{oWaypointUp = oPitUp2;
			 SendMessageToPC(GetLastUsedBy(), "You scale the ladder.");
			 AssignCommand(GetLastUsedBy(), ActionJumpToObject(oWaypointUp, FALSE));
			}
		 else
		 	{
			 SendMessageToPC(GetLastUsedBy(), "You pick up the ladder to carry it...where?");
			 object oLadderItem = CreateItemOnObject("dr_it_ladder_pit", GetLastUsedBy(), 1);
			 DestroyObject(OBJECT_SELF);
			 }
		}

	if(GetTag(OBJECT_SELF) == "003_plc_corpse_mummy")
	   	{object oMummyItem = CreateItemOnObject("003_it_corpse_mummy", GetLastUsedBy(), 1);
		 DestroyObject(OBJECT_SELF);
		}

	if(GetTag(OBJECT_SELF) == "dr_secret_pillar")
		 {SpeakString("A tile sinks into the pillar at a touch. Two sections of the wall silently slide apart, revealing a doorway.", TALKVOLUME_TALK);
		  object oDoorwayOut = GetLocalObject(OBJECT_SELF, "oDoorwayOut");
		  if(oDoorwayOut == OBJECT_INVALID)
			 	{oDoorwayOut = GetObjectByTag("dr_secret_doorway_1_out");
				SetLocalObject(OBJECT_SELF, "oDoorwayOut", oDoorwayOut);
				}
		  object oDoorwayWP = GetLocalObject(OBJECT_SELF, "oDoorwayWP");
		   if(oDoorwayWP == OBJECT_INVALID)
			 	{oDoorwayWP = GetWaypointByTag("dr_secret_doorway_1_WP");
				SetLocalObject(OBJECT_SELF, "oDoorwayWP", oDoorwayWP);
				}
		  object oDoorway = GetLocalObject(OBJECT_SELF, "oDoorway");
		   if(oDoorway == OBJECT_INVALID)
			 	{oDoorway = GetObjectByTag("dr_secret_doorway_1_in");
				SetLocalObject(OBJECT_SELF, "oDoorway", oDoorway);
				if(oDoorway == OBJECT_INVALID)
				 	{oDoorway = CreateObject(OBJECT_TYPE_PLACEABLE, "dr_secret_doorway_1_in", GetLocation(oDoorwayWP));
					SetLocalObject(OBJECT_SELF, "oDoorway", oDoorway);
					}
				}
		  oDoorway = GetLocalObject(OBJECT_SELF, "oDoorway");
		  DestroyObject(oDoorway, 59.0);
		  DelayCommand(60.0, SetLocalObject(OBJECT_SELF, "oDoorway", OBJECT_INVALID));
		  DelayCommand(60.2, SetLocalObject(oDoorwayOut, "oDoorway", OBJECT_INVALID));
		  DelayCommand(60.5, SpeakString("Two sections of the wall silently slide together, hiding a doorway.", TALKVOLUME_TALK));
		  SetLocalInt(OBJECT_SELF, "Spoken", 1);
		  DelayCommand(5.0, SetLocalInt(OBJECT_SELF, "Spoken", 0));
		  }
	  
	if(GetTag(OBJECT_SELF) == "dr_secret_doorway_1_in")
		 {object oDoorwayWP = GetLocalObject(OBJECT_SELF, "oDoorwayWP");
		   if(oDoorwayWP == OBJECT_INVALID)
			 	{oDoorwayWP = GetWaypointByTag("dr_secret_doorway_in_WP");
				SetLocalObject(OBJECT_SELF, "oDoorwayWP", oDoorwayWP);
				}
		 AssignCommand(GetLastUsedBy(), ActionJumpToLocation(GetLocation(oDoorwayWP)));
		 }
	  

 	if(GetTag(OBJECT_SELF) == "dr_secret_doorway_1_out")
		 {object oDoorwayPillar = GetLocalObject(OBJECT_SELF, "oDoorwayPillar");
		  if(oDoorwayPillar == OBJECT_INVALID)
			 	{oDoorwayPillar = GetObjectByTag("dr_secret_pillar");
				SetLocalObject(OBJECT_SELF, "oDoorwayPillar", oDoorwayPillar);
				}
		  object oDoorwayWP = GetLocalObject(OBJECT_SELF, "oDoorwayWP");
		   if(oDoorwayWP == OBJECT_INVALID)
			 	{oDoorwayWP = GetWaypointByTag("dr_secret_doorway_1_WP");
				SetLocalObject(OBJECT_SELF, "oDoorwayWP", oDoorwayWP);
				}
		  object oDoorwayOutWP = GetLocalObject(OBJECT_SELF, "oDoorwayOutWP");
		   if(oDoorwayOutWP == OBJECT_INVALID)
			 	{oDoorwayOutWP = GetWaypointByTag("dr_secret_doorway_out_WP");
				SetLocalObject(OBJECT_SELF, "oDoorwayOutWP", oDoorwayOutWP);
				}
		 object oDoorway = GetLocalObject(OBJECT_SELF, "oDoorway");
		   if(oDoorway == OBJECT_INVALID)
			 	{oDoorway = GetObjectByTag("dr_secret_doorway_1_in");
				SetLocalObject(OBJECT_SELF, "oDoorway", oDoorway);
				if(oDoorway == OBJECT_INVALID)
				 	{oDoorway = CreateObject(OBJECT_TYPE_PLACEABLE, "dr_secret_doorway_1_in", GetLocation(oDoorwayWP));
					SetLocalObject(OBJECT_SELF, "oDoorway", oDoorway);
					}
				}
		  oDoorway = GetLocalObject(OBJECT_SELF, "oDoorway");
		  AssignCommand(GetLastUsedBy(), ActionJumpToLocation(GetLocation(oDoorwayOutWP)));
		  DelayCommand(60.0, SetLocalObject(OBJECT_SELF, "oDoorway", OBJECT_INVALID));
		  DelayCommand(60.2, SetLocalObject(oDoorwayPillar, "oDoorway", OBJECT_INVALID));
		  if(GetLocalInt(oDoorwayPillar, "Spoken") != 1)
		  	{DelayCommand(60.5, AssignCommand(oDoorwayPillar, SpeakString("Two sections of the wall silently slide together, hiding a doorway.", TALKVOLUME_TALK)));
		  	}
		  }
	  
	if(GetTag(OBJECT_SELF) == "dr_floor_pattern")
		 {SpeakString("A tile sinks into the pattern on the floor. A tiny hole appears at the center of the tiled design, then the rings of the pattern spin and dilate, sliding outward to reveal a trap door.", TALKVOLUME_TALK);
		  object oTrapdoorOut = GetLocalObject(OBJECT_SELF, "oTrapdoorOut");
		  if(oTrapdoorOut == OBJECT_INVALID)
			 	{oTrapdoorOut = GetObjectByTag("dr_secret_trapdoor_1_out");
				SetLocalObject(OBJECT_SELF, "oTrapdoorOut", oTrapdoorOut);
				}
		  object oTrapdoorWP = GetLocalObject(OBJECT_SELF, "oTrapdoorWP");
		   if(oTrapdoorWP == OBJECT_INVALID)
			 	{oTrapdoorWP = GetWaypointByTag("dr_secret_trapdoor_1_WP");
				SetLocalObject(OBJECT_SELF, "oTrapdoorWP", oTrapdoorWP);
				}
		  object oTrapdoor = GetLocalObject(OBJECT_SELF, "oTrapdoor");
		   if(oTrapdoor == OBJECT_INVALID)
			 	{oTrapdoor = GetObjectByTag("dr_secret_trapdoor_1_in");
				SetLocalObject(OBJECT_SELF, "oTrapdoor", oTrapdoor);
				if(oTrapdoor == OBJECT_INVALID)
				 	{oTrapdoor = CreateObject(OBJECT_TYPE_PLACEABLE, "dr_secret_trapdoor_1_in", GetLocation(oTrapdoorWP));
					SetLocalObject(OBJECT_SELF, "oTrapdoor", oTrapdoor);
					}
				}
		  oTrapdoor = GetLocalObject(OBJECT_SELF, "oTrapdoor");
		  DestroyObject(oTrapdoor, 59.0);
		  DelayCommand(60.0, SetLocalObject(OBJECT_SELF, "oTrapdoor", OBJECT_INVALID));
		  DelayCommand(60.2, SetLocalObject(oTrapdoorOut, "oTrapdoor", OBJECT_INVALID));
		  DelayCommand(60.5, SpeakString("The tiled pattern  silently spirals closed in the floor, sealing off a trapdoor.", TALKVOLUME_TALK));
		  SetLocalInt(OBJECT_SELF, "Spoken", 1);
		  DelayCommand(5.0, SetLocalInt(OBJECT_SELF, "Spoken", 0));
		  }
	  
	if(GetTag(OBJECT_SELF) == "dr_secret_trapdoor_1_in")
		 {object oTrapdoorWP = GetLocalObject(OBJECT_SELF, "oTrapdoorWP");
		   if(oTrapdoorWP == OBJECT_INVALID)
			 	{oTrapdoorWP = GetWaypointByTag("dr_secret_trapdoor_in_WP");
				SetLocalObject(OBJECT_SELF, "oTrapdoorWP", oTrapdoorWP);
				}
		 AssignCommand(GetLastUsedBy(), ActionJumpToLocation(GetLocation(oTrapdoorWP)));
		 }
	  

 	if(GetTag(OBJECT_SELF) == "dr_secret_trapdoor_1_out")
		 {object oTrapdoorWP = GetLocalObject(OBJECT_SELF, "oTrapdoorWP");
		   if(oTrapdoorWP == OBJECT_INVALID)
			 	{oTrapdoorWP = GetWaypointByTag("dr_secret_trapdoor_1_WP");
				SetLocalObject(OBJECT_SELF, "oTrapdoorWP", oTrapdoorWP);
				}
		  object oTrapdoorTiles = GetLocalObject(OBJECT_SELF, "oTrapdoorTiles");
		  if(oTrapdoorTiles == OBJECT_INVALID)
			 	{oTrapdoorTiles = GetObjectByTag("dr_floor_pattern");
				SetLocalObject(OBJECT_SELF, "oTrapdoorTiles", oTrapdoorTiles);
				if(oTrapdoorTiles == OBJECT_INVALID)
				 	{oTrapdoorTiles = CreateObject(OBJECT_TYPE_PLACEABLE, "dr_floor_pattern", GetLocation(oTrapdoorWP));
					SetLocalObject(OBJECT_SELF, "oTrapdoorTiles", oTrapdoorTiles);
					}
				}
		  object oTrapdoorOutWP = GetLocalObject(OBJECT_SELF, "oTrapdoorOutWP");
		   if(oTrapdoorOutWP == OBJECT_INVALID)
			 	{oTrapdoorOutWP = GetWaypointByTag("dr_secret_trapdoor_out_WP");
				SetLocalObject(OBJECT_SELF, "oTrapdoorOutWP", oTrapdoorOutWP);
				}
		 object oTrapdoor = GetLocalObject(OBJECT_SELF, "oTrapdoor");
		   if(oTrapdoor == OBJECT_INVALID)
			 	{oTrapdoor = GetObjectByTag("dr_secret_trapdoor_1_in");
				SetLocalObject(OBJECT_SELF, "oTrapdoor", oTrapdoor);
				if(oTrapdoor == OBJECT_INVALID)
				 	{oTrapdoor = CreateObject(OBJECT_TYPE_PLACEABLE, "dr_secret_trapdoor_1_in", GetLocation(oTrapdoorWP));
					SetLocalObject(OBJECT_SELF, "oTrapdoor", oTrapdoor);
					}
				}
		  oTrapdoor = GetLocalObject(OBJECT_SELF, "oTrapdoor");
		  AssignCommand(GetLastUsedBy(), ActionJumpToLocation(GetLocation(oTrapdoorOutWP)));
		  DelayCommand(60.0, SetLocalObject(OBJECT_SELF, "oTrapdoor", OBJECT_INVALID));
		  DelayCommand(60.2, SetLocalObject(oTrapdoorTiles, "oTrapdoor", OBJECT_INVALID));
		  DelayCommand(60.4, SetLocalObject(OBJECT_SELF, "oTrapdoorTiles", OBJECT_INVALID));
		  DestroyObject(oTrapdoor, 60.5);
		  DestroyObject(oTrapdoorTiles, 60.6);
		  if(GetLocalInt(oTrapdoorTiles, "Spoken") != 1)
		  	{DelayCommand(60.5, AssignCommand(oTrapdoorTiles, SpeakString("The tiled pattern  silently spirals closed in the floor, sealing off a trapdoor.", TALKVOLUME_TALK)));
		  	}
		  }
	  
	
		
	if(FindSubString(GetTag(OBJECT_SELF), "dr_rowboat") != -1)
	 {object oMasterWP = GetLocalObject(OBJECT_SELF, "oMasterWP");
	   if(oMasterWP == OBJECT_INVALID)
	 	{oMasterWP = GetWaypointByTag("dr_lockdoor_up_WP");
		SetLocalObject(OBJECT_SELF, "oMasterWP", oMasterWP);
		}
	  object oMyTrig = GetLocalObject(OBJECT_SELF, "oMyTrig");
	  object oMyBoat = GetLocalObject(OBJECT_SELF, "oMyBoat");
	  object oMyOppositeLaunch = GetLocalObject(OBJECT_SELF, "oMyOppositeLaunch");
	  object oMyOpposite = GetLocalObject(OBJECT_SELF, "oMyOpposite");
	  object oBoater;
	  object oGoTo;
	  object oLand;
	  string sNewTag;
	  if(GetTag(OBJECT_SELF) == "dr_rowboat_1a_go")
	  	{oGoTo = GetWaypointByTag("dr_rowboat_1b_boat_WP");
		 oLand = GetWaypointByTag("dr_rowboat_land_a_WP");
		 sNewTag = "dr_rowboat_1b_boat";
		 if(oMyTrig == OBJECT_INVALID)
		 	{oMyTrig = GetObjectByTag("dr_rowboat_1a");
			}
		 if(oMyOpposite == OBJECT_INVALID)
		 	{oMyOpposite = GetObjectByTag("dr_rowboat_1b");
			}
		 }
	  if(GetTag(OBJECT_SELF) == "dr_rowboat_1b_go")
	  	{oGoTo = GetWaypointByTag("dr_rowboat_1a_boat_WP");
		 oLand = GetWaypointByTag("dr_rowboat_land_b_WP");
		 sNewTag = "dr_rowboat_1a_boat";
		 if(oMyTrig == OBJECT_INVALID)
		 	{oMyTrig = GetObjectByTag("dr_rowboat_1b");
			}
		 if(oMyOpposite == OBJECT_INVALID)
		 	{oMyOpposite = GetObjectByTag("dr_rowboat_1a");
			}
		 }
	  if(GetTag(OBJECT_SELF) == "dr_rowboat_2a_go")
	  	{oGoTo = GetWaypointByTag("dr_rowboat_2b_boat_WP");
		 oLand = GetWaypointByTag("dr_rowboat_land_a_WP");
		 sNewTag = "dr_rowboat_2b_boat";
		 if(oMyTrig == OBJECT_INVALID)
		 	{oMyTrig = GetObjectByTag("dr_rowboat_2a");
			}
		 if(oMyOpposite == OBJECT_INVALID)
		 	{oMyOpposite = GetObjectByTag("dr_rowboat_2b");
			}
		 }
	  if(GetTag(OBJECT_SELF) == "dr_rowboat_2b_go")
	  	{oGoTo = GetWaypointByTag("dr_rowboat_2a_boat_WP");
		 oLand = GetWaypointByTag("dr_rowboat_land_b_WP");
		 sNewTag = "dr_rowboat_2a_boat";
		 if(oMyTrig == OBJECT_INVALID)
		 	{oMyTrig = GetObjectByTag("dr_rowboat_2b");
			}
		 if(oMyOpposite == OBJECT_INVALID)
		 	{oMyOpposite = GetObjectByTag("dr_rowboat_2a");
			}
		 }
	   if(oMyBoat == OBJECT_INVALID)
	 	{oMyBoat = GetObjectByTag(GetTag(oMyTrig) + "_boat");
		 SetLocalObject(OBJECT_SELF, "oMyBoat", oMyBoat);
		}
	  if(oMyOppositeLaunch == OBJECT_INVALID)
	 	{oMyOppositeLaunch = GetObjectByTag(GetTag(oMyOpposite) + "_go");
		 SetLocalObject(OBJECT_SELF, "oMyOppositeLaunch", oMyOppositeLaunch);
		}
	  int nLevel = GetLocalInt(oMasterWP, "nLevel");
	  if(nLevel < 10)
	  	{SpeakString( "The water is not deep enough to launch the rowboat.", TALKVOLUME_TALK);
		}
	  if(oMyBoat == OBJECT_INVALID)
	  	{SpeakString("There is no boat to launch.", TALKVOLUME_TALK);
	     }
	  int nCount = GetLocalInt(oMyBoat, "nCount");
	  if(nCount <= 0) 
		 	{SpeakString("There is nobody in the boat to launch.", TALKVOLUME_TALK);
			 }
	  if((nCount > 0) && (oMyBoat != OBJECT_INVALID) && (nLevel >= 10))
	  	{object oFirstStop = GetNearestObjectByTag("dr_boat_stop", oMyBoat, 1);
		 object oSecondStop = GetNearestObjectByTag("dr_boat_stop", oGoTo, 2);
		 DestroyObject(oMyBoat);
		 object oFirstBoat = CreateObject(OBJECT_TYPE_PLACEABLE, "dr_rowboat", GetLocation(oFirstStop));
		 DestroyObject(oFirstBoat, 10.0);
		 object oSecondBoat = CreateObject(OBJECT_TYPE_PLACEABLE, "dr_rowboat", GetLocation(oSecondStop));
		 DestroyObject(oSecondBoat, 20.0);
		 SetLocalObject(OBJECT_SELF, "oMyBoat", OBJECT_INVALID);
		 SetLocalObject(oMyTrig, "oMyBoat", OBJECT_INVALID);
		 object oBoat = CreateObject(OBJECT_TYPE_PLACEABLE, "dr_rowboat", GetLocation(oGoTo), FALSE, sNewTag);
		 SetLocalObject(oMyOppositeLaunch, "oMyBoat", oBoat);
		 SetLocalObject(oMyOpposite, "oMyBoat", oBoat);
		 SetUseableFlag(oMyOppositeLaunch, TRUE);
		 SetUseableFlag(OBJECT_SELF, FALSE);
		 oBoater = GetFirstObjectInShape(SHAPE_SPHERE, 5.0, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE); 
		 while(oBoater != OBJECT_INVALID) 
			 {if(GetLocalInt(oBoater, GetTag(oMyTrig)) > 0) 
			 	{ AssignCommand(oBoater, ActionJumpToLocation(GetLocation(oFirstStop)));
			     DelayCommand(1.0, ExitWater(OBJECT_SELF, oBoater));
				 DelayCommand(10.0, AssignCommand(oBoater, ActionJumpToLocation(GetLocation(oSecondStop))));
			     DelayCommand(20.0, AssignCommand(oBoater, ActionJumpToLocation(GetLocation(oLand))));
			    }
			   oBoater = GetNextObjectInShape(SHAPE_SPHERE, 5.0, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE); 
		 	}
	  
		}
	}
	 
	 
	if((GetTag(OBJECT_SELF) == "dr_lockdoor_lvr_1") || (GetTag(OBJECT_SELF) == "dr_lockdoor_lvr_2") || (GetTag(OBJECT_SELF) == "dr_lockdoor_lvr"))
	 {object oMasterWP = GetWaypointByTag("dr_lockdoor_up_WP");
	  int nState = GetLocalInt(oMasterWP, "nState");
	  int nLevel = GetLocalInt(oMasterWP, "nLevel");
	  object oCollBox = GetLocalObject(oMasterWP, "oCollBox");
	  if(oCollBox == OBJECT_INVALID)
	  	{oCollBox = GetObjectByTag("dr_collision1");
		 SetLocalObject(oMasterWP, "oCollBox", oCollBox);
		 }
	  object oCollBoxWP = GetLocalObject(oMasterWP, "dr_collbox_WP");
	  if(oCollBoxWP == OBJECT_INVALID)
	  	{oCollBoxWP = GetWaypointByTag("dr_collbox_WP");
		 SetLocalObject(oMasterWP, "oCollBoxWP", oCollBoxWP);
		 }
	  object oMyGate = GetLocalObject(oMasterWP, "oMyGate");
	  object oUp = GetWaypointByTag("dr_lockdoor_up_WP");
	  object oDown = GetWaypointByTag("dr_lockdoor_down_WP");
	  object oRattle = GetObjectByTag("dr_rattle_sound");
	  object oMetal= GetObjectByTag("dr_metal_sound");
	  object oWaterHighest = GetWaypointByTag("dr_water_11_WP");
	  object oWaterLowest = GetWaypointByTag("dr_water_0_WP");
	  object oWaterFloorWP = GetWaypointByTag("dr_water_4_WP");
	  object oUnderwater = GetLocalObject(oMasterWP, "oUnderwater");
	  object oUnderwaterLight = GetLocalObject(oMasterWP, "oUnderwaterLight");
	  object oUnderwaterLightWP = GetWaypointByTag("dr_water_8_WP");
	  object oWaterLevel = GetWaypointByTag("dr_water_" + IntToString(nLevel) + "_WP");
	  object oWaterFloor = GetLocalObject(oMasterWP, "oWaterFloor");
	  effect eCold = EffectDamage(Random(6) + 1, DAMAGE_TYPE_COLD, DAMAGE_POWER_NORMAL, FALSE);
	  effect eDrown = EffectDamage(Random(6) + 1, DAMAGE_TYPE_ALL, DAMAGE_POWER_NORMAL, FALSE);
	  effect eBatter = EffectDamage(Random(6) + 1, DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_NORMAL, FALSE);
	  effect eSwim;
	  effect eUnconscious = EffectStunned();
	  object oSuccess = GetLocalObject(OBJECT_SELF, "oSuccess");
	  if(oSuccess == OBJECT_INVALID)
			{oSuccess = GetWaypointByTag("dr_current_10_WP");
			 SetLocalObject(OBJECT_SELF, "oSuccess", oSuccess);
			}
	  int nRising = GetLocalInt(oMasterWP, "nRising");
	  if((GetAbilityScore(GetLastUsedBy(), ABILITY_STRENGTH) >= 16) || (GetLocalInt(OBJECT_SELF, "Greased") == 1))
	  	{if((GetAbilityScore(GetLastUsedBy(), ABILITY_STRENGTH) >= 16) && (GetLocalInt(GetLastUsedBy(), "StrMsg") != 1))
			{SendMessageToPC(GetLastUsedBy(), "By throwing all your strength into it, you are able to force the lever to move.");
		 	 SetLocalInt(GetLastUsedBy(), "StrMsg", 1);
			 }
		 if((GetLocalInt(OBJECT_SELF, "Greased") == 1) && (GetLocalInt(GetLastUsedBy(), "GrsMsg") != 1))
	  		{SendMessageToPC(GetLastUsedBy(), "The Grease did it. The lever creaks and grates but slides into position.");
			 SetLocalInt(GetLastUsedBy(), "GrsMsg", 1);
			 SetLocalObject(oMasterWP, "oUser", GetLastUsedBy());
			 }	 
		  
		if(nState == 0)
		 	 {if(GetLocalInt(oMasterWP, "ClatterMsg") != 1)
				  {SetLocalInt(oMasterWP, "ClatterMsg", 1);
				   if((GetName(OBJECT_SELF) == "Rusty Lever") || (GetName(OBJECT_SELF) == "Dented Lever"))
				 	{SpeakString("* The lever locks into its new position and cannot be budged. With the clattering groan of an ancient but still functioning mechanism, the drainage grate rises swiftly, revealing itself as the top of a massive metal door!*" , TALKVOLUME_TALK);
			 	  	 DelayCommand(3.0, SpeakString("*The rattling of chains may be heard, but the workings of the door are buried in solid rock to either side of the grooves in the walls that let it slide upward.*", TALKVOLUME_TALK));
					 }
				   if(GetName(OBJECT_SELF) == "Tarnished Lever")
				 	{SpeakString("*Somewhere, the rattling of chains may be heard, and the groaning of stressed metal. The drumming of water suddenly becomes louder, as if now enclosed.*", TALKVOLUME_TALK);
			 	  	 }
				   }
			  DelayCommand(3.0, SpeakString("*The large pit chamber begins to fill with water. Violent, rushing currents churn around the central platform, frothing against jagged rocks.*", TALKVOLUME_TALK));
			  SoundObjectPlay(oRattle);
			  SoundObjectPlay(oMetal);
			  DelayCommand(15.0, SoundObjectStop(oRattle));
			  DelayCommand(15.0, SoundObjectStop(oMetal));
			  DestroyObject(oMyGate);
			  object oGate = CreateObject(OBJECT_TYPE_PLACEABLE, "dr_lockdoor", GetLocation(oUp));
			  SetLocalObject(oMasterWP, "oMyGate", oGate);
			  if(oCollBox == OBJECT_INVALID)
			  	{oCollBox = CreateObject(OBJECT_TYPE_PLACEABLE, "dr_collision1", GetLocation(oCollBoxWP));
			  	SetLocalObject(oMasterWP, "oCollBox", oCollBox);
				}
			  SetLocalInt(oMasterWP, "nState", 1);
			  SetLocalInt(oMasterWP, "nRising", 1);
			  if(nLevel >= 10)
			  	{SetLocalInt(oMasterWP, "nLevel", 10);}
			  else if((nLevel >=0) && (nLevel < 10))
			  	{SetLocalInt(oMasterWP, "nLevel", nLevel + 1);}
			  if(nLevel == 5)
				  {oUnderwater = CreateObject(OBJECT_TYPE_PLACED_EFFECT, "n2_fx_splash2", GetLocation(oWaterFloorWP));
			       SetLocalObject(oMasterWP, "oUnderwater", oUnderwater);
				   }
				}
		else if(nState == 1)
		 	 {SetLocalInt(oMasterWP, "nState", 0);
			  if(GetLocalInt(oMasterWP, "CloseMsg") != 1)
				 	{SpeakString("*The lever grudgingly slides over. Beneath your feet the gurgle of pipes may be heard. The current swirls into violent whirlpools.*", TALKVOLUME_TALK);
			  		 SetLocalInt(oMasterWP, "CloseMsg", 1);
					 }
			  if(nLevel <= 5)
				  { if(GetLocalInt(oMasterWP, "ClatterMsg2") != 1)
					{SetLocalInt(oMasterWP, "ClatterMsg2", 1);
					 if((GetName(OBJECT_SELF) == "Rusty Lever") || (GetName(OBJECT_SELF) == "Dented Lever"))
					 	{SpeakString("*The massive metal door drops through the drainage channel in the floor, slamming into its resting place far below with an echo like a huge gong.*", TALKVOLUME_TALK);
				 	  	 }
				   if(GetName(OBJECT_SELF) == "Tarnished Lever")
					 	{SpeakString("*From across the pit roll deafening echoes like a huge gong. The rushing of water suddenly becomes quieter, as if no longer enclosed.*", TALKVOLUME_TALK);
				 	  	 }
					}
			       SoundObjectPlay(oRattle);
				   SoundObjectPlay(oMetal);
				   DelayCommand(15.0, SoundObjectStop(oRattle));
				   DelayCommand(15.0, SoundObjectStop(oMetal));
				   DestroyObject(oMyGate);
				   object oGate = CreateObject(OBJECT_TYPE_PLACEABLE, "dr_lockdoor", GetLocation(oDown));
				   SetLocalObject(oMasterWP, "oMyGate", oGate);
				   DestroyObject(oCollBox);
				   SetLocalObject(oMasterWP, "oCollBox", OBJECT_INVALID);
				   DestroyObject(oUnderwater);
				   SetLocalObject(oMasterWP, "oUnderwater", OBJECT_INVALID);
				   }
			  if(nLevel <= 0)
			  	{SetLocalInt(oMasterWP, "nLevel", 0);}
			  else if((nLevel >0) && (nLevel <= 10))
			  	{SetLocalInt(oMasterWP, "nLevel", nLevel - 1);}
			  	SetLocalInt(oMasterWP, "nRising", 2);
			  	}

		nLevel = GetLocalInt(oMasterWP, "nLevel");
		nState = GetLocalInt(oMasterWP, "nState");
		nRising = GetLocalInt(oMasterWP, "nRising");
		object oUser = GetLocalObject(oMasterWP, "oUser");
		oWaterLevel = GetWaypointByTag("dr_water_" + IntToString(nLevel) + "_WP");
		object oWater = GetLocalObject(oMasterWP, "oWater");
		DestroyObject(oWater);
		SetLocalObject(oMasterWP, "oWater", OBJECT_INVALID);
		if(nLevel > 0)
			{oWater = CreateObject(OBJECT_TYPE_PLACEABLE, "tsm_water_6x6", GetLocation(oWaterLevel));
			SetLocalObject(oMasterWP, "oWater", oWater);	 
			}
	
		
		 if(nLevel <= 0)
			{DestroyObject(oWater);
		     SetLocalObject(oMasterWP, "oWater", OBJECT_INVALID);	 
		     SetLocalInt(oMasterWP, "On", 0);
	         return;
			} 
		if(nLevel <= 8)
			{object oCollBoxHighWP = GetLocalObject(OBJECT_SELF, "oCollBoxHighWP");
			 if(oCollBoxHighWP == OBJECT_INVALID)
			 	{oCollBoxHighWP = GetWaypointByTag("dr_collboxhigh_WP");
				 SetLocalObject(OBJECT_SELF, "oCollBoxHighWP", oCollBoxHighWP);
				 }
			 object oCollBoxHigh = GetLocalObject(OBJECT_SELF, "oCollBoxHigh");
			 if(oCollBoxHigh == OBJECT_INVALID)
			 	{oCollBoxHigh = GetObjectByTag("dr_collision_high");
				 if(oCollBoxHigh == OBJECT_INVALID)
				 	{oCollBoxHigh = CreateObject(OBJECT_TYPE_PLACEABLE, "dr_collision_high", GetLocation(oCollBoxHighWP));
					 }
				SetLocalObject(OBJECT_SELF, "oCollBoxHigh", oCollBoxHigh);
				}
			}
	    if(nLevel >= 9)
			{object oCollBoxHigh = GetObjectByTag("dr_collision_high");
			 DestroyObject(oCollBoxHigh);
			 SetLocalObject(OBJECT_SELF, "oCollBoxHigh", OBJECT_INVALID);
			}
	    		
		if((nLevel > 0) && (nLevel < 10))
			{DelayCommand(60.0, ExecuteScript("dr_plc_onused_2", OBJECT_SELF));
			}
		}


   	  else  
	   	{SendMessageToPC(GetLastUsedBy(), "The lever is too rusty to budge!");
		} 
		 
	}
}