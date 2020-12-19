//OnUse for all Occidian (lost elvish city) placeables 
//Wynna June 2009


#include "acr_placeable_i"
#include "acr_xp_i"
#include "acr_quest_i"






void main()
{
	ACR_PlaceableOnUsed();

	object oUser = GetLastUsedBy();
	

	// Puzzle levers for entry to Occidian entry cave
	 if(FindSubString(GetTag(OBJECT_SELF), "fel_trail_occ_dragon_") != -1)
		{object oRuneDoor = GetLocalObject(OBJECT_SELF, "oRuneDoor");
		 if(oRuneDoor == OBJECT_INVALID)
		 	{oRuneDoor = GetObjectByTag("fel_trail_occidian_door_rune");
			 SetLocalObject(OBJECT_SELF, "oRuneDoor", oRuneDoor);
			 }
		 location lMyLight = GetLocation(OBJECT_SELF);
		 object oMyLight = GetLocalObject(OBJECT_SELF, "oMyLight");
		 if(oMyLight == OBJECT_INVALID)
				{oMyLight = GetObjectByTag(GetTag(OBJECT_SELF) + "_light");
				 SetLocalObject(OBJECT_SELF, "oMyLight", oMyLight);
				 if(oMyLight == OBJECT_INVALID)
				 	{oMyLight = CreateObject(OBJECT_TYPE_PLACEABLE, "slv_plc_ghostlight4", lMyLight, FALSE,(GetTag(OBJECT_SELF) + "_light")); 
					 SetLocalObject(OBJECT_SELF, "oMyLight", oMyLight);
					 if((FindSubString(GetTag(OBJECT_SELF), "silver") != -1) || (FindSubString(GetTag(OBJECT_SELF), "gold") != -1) ||(FindSubString(GetTag(OBJECT_SELF), "copper") != -1))
					 	{SetLocalInt(oRuneDoor, "Lever", GetLocalInt(oRuneDoor, "Lever") +1);
						 }
					 else
					 	{SetLocalInt(oRuneDoor, "WrongLever", GetLocalInt(oRuneDoor, "WrongLever") +1);
						 }
					  ActionPlayAnimation(ANIMATION_PLACEABLE_OPEN);
						 }
				 else if(oMyLight != OBJECT_INVALID)
					{DestroyObject(oMyLight);
					 SetLocalObject(OBJECT_SELF, "oMyLight", OBJECT_INVALID);
					 if((FindSubString(GetTag(OBJECT_SELF), "silver") != -1) || (FindSubString(GetTag(OBJECT_SELF), "gold") != -1) ||(FindSubString(GetTag(OBJECT_SELF), "copper") != -1))
					 	{SetLocalInt(oRuneDoor, "Lever", GetLocalInt(oRuneDoor, "Lever") -1);
						 }
					  else
					 	{SetLocalInt(oRuneDoor, "WrongLever", GetLocalInt(oRuneDoor, "WrongLever") -1);
						 }
					  ActionPlayAnimation(ANIMATION_PLACEABLE_CLOSE);
						}
				 }
		else if(oMyLight != OBJECT_INVALID)
				{DestroyObject(oMyLight);
				 SetLocalObject(OBJECT_SELF, "oMyLight", OBJECT_INVALID);
				 if((FindSubString(GetTag(OBJECT_SELF), "silver") != -1) || (FindSubString(GetTag(OBJECT_SELF), "gold") != -1) ||(FindSubString(GetTag(OBJECT_SELF), "copper") != -1))
					 	{SetLocalInt(oRuneDoor, "Lever", GetLocalInt(oRuneDoor, "Lever") -1);
						}
					    else
					 	{SetLocalInt(oRuneDoor, "WrongLever", GetLocalInt(oRuneDoor, "WrongLever") -1);
						 }
					   ActionPlayAnimation(ANIMATION_PLACEABLE_CLOSE);
						}
		if((GetLocalInt(oRuneDoor, "Lever") == 3) && (GetLocalInt(oRuneDoor, "WrongLever") == 0))
			{SetLocked(oRuneDoor, FALSE);
			 ActionOpenDoor(oRuneDoor);
			 if(ACR_RetrieveQuestState("slv_deandragon_j", oUser) == 4)
			 	{ACR_AddPersistentJournalQuestEntry("slv_deandragon_j", 5, oUser, FALSE, FALSE, FALSE, FALSE);
				 }
			 if(ACR_RetrieveQuestState("slv_deandragon_x", oUser) == 5)
			 	{ACR_AddPersistentJournalQuestEntry("slv_deandragon_x", 5, oUser, FALSE, FALSE, FALSE, FALSE);
				 }
			 if(ACR_RetrieveQuestState("slv_deansphinx_j", oUser) == 5)
			 	{ACR_AddPersistentJournalQuestEntry("slv_deandragon_j", 6, oUser, FALSE, FALSE, FALSE, FALSE);
				 }
			 
			}
			
		}
		
 //Rope swings to tree platforms
 
 	if(FindSubString(GetTag(OBJECT_SELF), "occ_rope_") != -1)
		{object oMyWP = GetWaypointByTag(GetTag(OBJECT_SELF) + "_WP");
		 SendMessageToPC(oUser, "oMyWP = " + GetTag(oMyWP));
		 AssignCommand(GetLastUsedBy(), ActionJumpToLocation(GetLocation(oMyWP)));
		}
		
	if(GetTag(OBJECT_SELF) == 	"occ_plc_glyph_ward_flr_splode") {
	object oPC = GetLastUsedBy();
	if(GetIsSkillSuccessful(oPC, SKILL_DISABLE_TRAP, 28)) {
			object oGlyphTrig = GetNearestObjectByTag("occ_trg_glyph_explode", OBJECT_SELF, 1);
			SetLocalInt(oGlyphTrig, "Fired", 1);
			SetUseableFlag(OBJECT_SELF, FALSE);
			 	
		}

	}
}