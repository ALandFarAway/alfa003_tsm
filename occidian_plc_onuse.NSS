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
	effect eSonicImplode = EffectVisualEffect(1009, FALSE);
	if(GetIsSkillSuccessful(oPC, SKILL_DISABLE_TRAP, 28)) {
			object oGlyphTrig = GetNearestObjectByTag("occ_trg_glyph_explode", OBJECT_SELF, 1);
			SetLocalInt(oGlyphTrig, "Fired", 1);
			SetUseableFlag(OBJECT_SELF, FALSE);
			 	
		}
	else {DelayCommand(1.0, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSonicImplode, GetLocation(OBJECT_SELF), 3.0));
			 DestroyObject(OBJECT_SELF, 10.0);
			 SetLocalInt(OBJECT_SELF, "Fired", 1);
			 int nDamage = d8(5);
			 if(ReflexSave(oPC, 15, SAVING_THROW_TYPE_TRAP, OBJECT_SELF)) {
			 	nDamage = nDamage/2;
			 	}
			 effect eDamage = EffectDamage(nDamage, DAMAGE_TYPE_SONIC, DAMAGE_POWER_NORMAL, FALSE);
			 ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oPC);
			 
			 int nParty = 0;
			 while (nParty < 6) {
				 nParty = nParty + 1;
				 object oParty = GetNearestObject(OBJECT_TYPE_CREATURE, oPC, nParty);
				 int nPartyDmg = d8(5);
				 if(GetDistanceBetween(oPC, oParty) < 5.0)
				 	{if(ReflexSave(oParty, 15, SAVING_THROW_TYPE_TRAP, OBJECT_SELF)) {
					    nPartyDmg = nPartyDmg/2;
					 	}
				     effect eDamageParty = EffectDamage(nPartyDmg, DAMAGE_TYPE_SONIC, DAMAGE_POWER_NORMAL, FALSE);
				 	 ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamageParty, oParty);
				 	}
				 }
			 
			 }
		

	}
}