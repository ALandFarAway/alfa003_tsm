//OnUse for all Dean's Exam (deandragon) placeables 
//Wynna February 2009


#include "acr_placeable_i"
#include "acr_xp_i"
#include "acr_quest_i"
#include "acr_i"


void ActionCreateWyn(string sCreature, location lLoc)
{
    CreateObject(OBJECT_TYPE_CREATURE, sCreature, lLoc);
}

void ActionCreateWynPlace(string sPlace, location lLocPlace)
{
    CreateObject(OBJECT_TYPE_PLACEABLE, sPlace, lLocPlace);
}

void ActionCreateItemOnObjectWyn(string sItemTemplate, object oTarget, int nStackSize)
{
    CreateItemOnObject(sItemTemplate, oTarget, 1);
}

void main()
{
	ACR_PlaceableOnUsed();

	object oUser = GetLastUsedBy();
	
   //deandragon_d dragon berry harvesting
	if(FindSubString(GetTag(OBJECT_SELF), "deandragon_d_dragonberry") != -1)
	   {object oQuester = GetLocalObject(OBJECT_SELF, "oQuester");
		if(oQuester == OBJECT_INVALID)
			{oQuester = oUser;}
		object oKnife = GetItemPossessedBy(oQuester, "003_it_wpn_dragontalon");
		
		if((oKnife == OBJECT_INVALID) && (GetLocalInt(OBJECT_SELF, "Frozen") != 1))
			{SendMessageToPC(oQuester, "The delicate clusters of fruit have thick, fibrous stems. While attempting to snap some free, they bruise, the rich red juice dripping like blood onto the ground.  The berries drain to nothing but empty, withered skin. You will need something exceptionally sharp to cut these stems without bruising the next bunch of fruit...whenever that ripens.");
			 DestroyInventory(OBJECT_SELF);
			 DestroyObject(OBJECT_SELF);
			 }
		if((oKnife == OBJECT_INVALID) && (GetLocalInt(OBJECT_SELF, "Frozen") == 1))
			{SendMessageToPC(oQuester, "The frozen clusters of fruit have thick, fibrous stems. While attempting to snap some free, the warmth from your hand thaws the berries and they bruise. Rich red juice drips onto the ground. The berries drain to nothing but empty, withered skin. You will need something exceptionally sharp to cut these stems without bruising the next bunch of fruit...whenever that ripens.");
			 DestroyInventory(OBJECT_SELF);
			 DestroyObject(OBJECT_SELF);
			 }	
		if((oKnife != OBJECT_INVALID) && (GetLocalInt(OBJECT_SELF, "Frozen") != 1)&& (GetLocalInt(oQuester, "BlessedWeapon") == 1))
			{SendMessageToPC(oQuester, "You use a surgically sharp knife to slice the delicate clusters of fruit from the bush, but the fruit is so delicate that the pressure of your hand bruises it.  For a moment they seem fine, but the instant the blessed blade is no longer in contact with the stem, the berries drain to nothing but empty, withered skin, clearly useless. Frozen berries would not have been so delicate.");
			 DestroyInventory(OBJECT_SELF);
			 DestroyObject(OBJECT_SELF);
			 }	
		if((oKnife != OBJECT_INVALID) && (GetLocalInt(OBJECT_SELF, "Frozen") != 1)&& (GetLocalInt(oQuester, "BlessedWeapon") != 1))
			{SendMessageToPC(oQuester, "You use a surgically sharp knife to slice the delicate clusters of fruit from the bush, but the fruit is so delicate that the pressure of your hand bruises it.  The berries drain to nothing but empty, withered skin, clearly useless. Frozen berries would not have been so delicate.");
			 DestroyInventory(OBJECT_SELF);
			 DestroyObject(OBJECT_SELF);
			 }	
		if((oKnife != OBJECT_INVALID) && (GetLocalInt(OBJECT_SELF, "Frozen") == 1)&& (GetLocalInt(oQuester, "BlessedWeapon") != 1))
			{SendMessageToPC(oQuester, "You use a surgically sharp knife to slice the frozen clusters of fruit from the bush, but the fruit is so delicate that the warmth of your hand melts away the frost and bruises the berries.  They drain to nothing but empty, withered skin, clearly useless. Perhaps a blessing on the blade would help.");
			 DestroyInventory(OBJECT_SELF);
			 DestroyObject(OBJECT_SELF);
			 }	
		if((oKnife != OBJECT_INVALID) && (GetLocalInt(OBJECT_SELF, "Frozen") == 1) && (GetLocalInt(oQuester, "BlessedWeapon") == 1))
			{SendMessageToPC(oQuester, "You use a surgically sharp, blessed knife to slice the frozen clusters of fruit from the bush. The berries actually seem to plump up beneath the frost at the touch of the blade.");
			 object oBerries = CreateItemOnObject("003_it_food_dragonberry", OBJECT_SELF, 2);
			 SetLocalObject(oQuester, GetTag(OBJECT_SELF) + "_berries", oBerries);
			 }
		SetUseableFlag(OBJECT_SELF, FALSE);
	}
		
	// Teleport for deandragon_e Elementals tests
	 if(FindSubString(GetTag(OBJECT_SELF), "slv_el_") != -1)
		{string sQuestTag = GetLocalString(OBJECT_SELF, "sQuestTag");
		 string sGoTo = GetLocalString(OBJECT_SELF, "sGoTo");
		 object oGoTo = GetLocalObject(OBJECT_SELF, "oGoTo");
		 location lGoTo = GetLocalLocation(OBJECT_SELF, "lGoTo");
		 if(oGoTo == OBJECT_INVALID)
			 {oGoTo = GetWaypointByTag(sGoTo);
			  SetLocalObject(OBJECT_SELF, "oGoTo", oGoTo);
			  lGoTo = GetLocation(oGoTo);
			  SetLocalLocation(OBJECT_SELF, "lGoTo", lGoTo);
			 }
		 object oToken=CreateItemOnObject("003_it_slv_teleport", oUser, 1);
		 DelayCommand(2.0, SetIdentified(oToken, TRUE));
		 DelayCommand(2.5, AssignCommand(oUser, ActionJumpToLocation(lGoTo)));
 
		 if(GetTag(OBJECT_SELF) == "slv_el_earth")
		 	{if(ACR_RetrieveQuestState("slv_deandragon_e_earth", oUser) == 1)
				 	{ACR_AddPersistentJournalQuestEntry("slv_deandragon_e_earth", 2, oUser, FALSE, FALSE, FALSE, 0);
					 DelayCommand(15.0, SendMessageToPC(oUser, "You have been transported to what appears to be a sealed cavern beneath the earth. Dirt trickles from the ceiling at any loud noise and the rattle of falling rocks may be heard in the darkness. There appears to be no way out...except to dig."));
					 }
			 if(ACR_RetrieveQuestState("slv_deansphinx_e_earth", oUser) == 1)
				 	{ACR_AddPersistentJournalQuestEntry("slv_deansphinx_e_earth", 2, oUser, FALSE, FALSE, FALSE, 0);
					 DelayCommand(15.0, SendMessageToPC(oUser, "You have been transported to what appears to be a sealed cavern beneath the earth. Dirt trickles from the ceiling at any loud noise and the rattle of falling rocks may be heard in the darkness. There appears to be no way out...except to dig."));
					 }
			
			}			 
		if(GetTag(OBJECT_SELF) == "slv_el_water")
		 	{if(ACR_RetrieveQuestState("slv_deandragon_e_water", oUser) == 1)
				 	{ACR_AddPersistentJournalQuestEntry("slv_deandragon_e_water", 2, oUser, FALSE, FALSE, FALSE, 0);
					 DelayCommand(15.0, SendMessageToPC(oUser, "You have teleported to the test of water to find yourself in a cavernous pit filled with water. Stalagtites and stalagtites of blue rock project from the surface of the water. Some of those outcroppings glitter with blue gems! But how do you get to them?"));
					 }
			 if(ACR_RetrieveQuestState("slv_deansphinx_e_water", oUser) == 1)
				 	{ACR_AddPersistentJournalQuestEntry("slv_deansphinx_e_water", 2, oUser, FALSE, FALSE, FALSE, 0);
					 DelayCommand(15.0, SendMessageToPC(oUser, "You have teleported to the test of water to find yourself in a cavernous pit filled with water. Stalagtites and stalagtites of blue rock project from the surface of the water. Some of those outcroppings glitter with blue gems! But how do you get to them?"));
					 }
			}			 
		 if(GetTag(OBJECT_SELF) == "slv_el_air")
		 	{object oGoTo2 = GetLocalObject(OBJECT_SELF, "oGoTo2");
			 if(oGoTo2 == OBJECT_INVALID)
				 	{oGoTo2 = GetWaypointByTag("slv_el_air_wp2");
					 SetLocalObject(OBJECT_SELF, "oGoTo2", oGoTo2);
					}
			 object oGoTo3 = GetLocalObject(OBJECT_SELF, "oGoTo3");
			 if(oGoTo3 == OBJECT_INVALID)
				 	{oGoTo3 = GetWaypointByTag("slv_el_air_wp3");
					 SetLocalObject(OBJECT_SELF, "oGoTo3", oGoTo3);
					}
			 object oGoTo4 = GetLocalObject(OBJECT_SELF, "oGoTo4");
			 if(oGoTo4 == OBJECT_INVALID)
				 	{oGoTo4 = GetWaypointByTag("slv_el_air_wp4");
					 SetLocalObject(OBJECT_SELF, "oGoTo4", oGoTo4);
					}
			 location lGoTo2 = GetLocation(oGoTo2);
			 location lGoTo3 = GetLocation(oGoTo3);
			 location lGoTo4 = GetLocation(oGoTo4);
			 if(ACR_RetrieveQuestState("slv_deandragon_e_air", oUser) == 1)
				 	{ACR_AddPersistentJournalQuestEntry("slv_deandragon_e_air", 2, oUser, FALSE, FALSE, FALSE, 0);
					 }
					 
			 if(ACR_RetrieveQuestState("slv_deansphinx_e_air", oUser) == 1)
				 	{ACR_AddPersistentJournalQuestEntry("slv_deansphinx_e_air", 2, oUser, FALSE, FALSE, FALSE, 0);
					 }
				
			if(GetLocalInt(oUser, "ColdRep") == 0)
					{SetLocalInt(oUser, "ColdRep", 1);
					 DelayCommand(15.0, SendMessageToPC(oUser, "The wrenching sense of teleportation is followed almost immediately by the reorientation of arrival. But something is wrong. You are falling. You are falling UP. By the time you recognize that your arrival had been in mid-air over a frozen landscape, you are already a significant distance higher...and it is bitterly cold."));
					 DelayCommand(20.0, AssignCommand(oUser, ActionJumpToLocation(lGoTo2)));
			 	     DelayCommand(30.5, SendMessageToPC(oUser, "You continue to fall upward helplessly, clearly in the grip of some arcane trap. It feels as if gravity has reversed!"));
					 DelayCommand(35.0, AssignCommand(oUser, ActionJumpToLocation(lGoTo3)));
			 	     DelayCommand(40.5, SendMessageToPC(oUser, "You continue to fall upward helplessly, away from the snow and ice that glitter as if strewn with diamonds."));
					 DelayCommand(45.0, AssignCommand(oUser, ActionJumpToLocation(lGoTo4)));
			 	     DelayCommand(50.5, SendMessageToPC(oUser, "You stop suddenly, as if you had hit an incorporeal barrier. Oscillating gently, you hang suspended 1000 meters in the air! You can only hope that gravity doesn't right itself, because a fall back DOWN from this height would maim or kill you before the cold has a chance to."));
					 DelayCommand(61.0, ExecuteScript("slv_static_voice_cr_pc", oUser));
					}
			}
		if(GetTag(OBJECT_SELF) == "slv_el_fire")
		 	{if(ACR_RetrieveQuestState("slv_deandragon_e_fire", oUser) == 1)
				 	{ACR_AddPersistentJournalQuestEntry("slv_deandragon_e_fire", 2, oUser, FALSE, FALSE, FALSE, 0);
					 DelayCommand(15.0, SendMessageToPC(oUser, "The first thing you notice is the heat. It isn't merely HOT. The temperature is a living, swollen, suffocating creature that wraps you in its folds at the same time it crawls inside and turns your bones molten. Sweat springs out, all over your skin, but it will do little to cool you. Without protection, you will fry."));
			 		 }
			if(ACR_RetrieveQuestState("slv_deansphinx_e_fire", oUser) == 1)
				 	{ACR_AddPersistentJournalQuestEntry("slv_deansphinx_e_fire", 2, oUser, FALSE, FALSE, FALSE, 0);
					 DelayCommand(15.0, SendMessageToPC(oUser, "The first thing you notice is the heat. It isn't merely HOT. The temperature is a living, swollen, suffocating creature that wraps you in its folds at the same time it crawls inside and turns your bones molten. Sweat springs out, all over your skin, but it will do little to cool you. Without protection, you will fry."));
			 		 }
			 
			 }
		}
		

	//Deandragon E shovel
		 	
	 if(GetTag(OBJECT_SELF) == "slv_deandragon_shovel_plc") 
	    {if(GetLocalInt(oUser, "Rest") == 1)
			{SendMessageToPC(oUser, "Your arms still burn from shovelling. A little more rest ought to do it.");	 
			 return;
			}
		 else 
			{int iCon = GetAbilityScore(oUser, ABILITY_CONSTITUTION, FALSE);
			 int iArchitecture = GetSkillRank(SKILL_KNOWLEDGE_ENGINEERING, oUser, FALSE); 
			 int iModify = GetAbilityModifier(ABILITY_CONSTITUTION, oUser);
			 int iUse = GetLocalInt(oUser, "iUse");
			 int iInc = GetLocalInt(oUser, "iInc");
			 
			 if(iUse == 0)
				{SendMessageToPC(oUser, "Part shovel, part pick, this multi-purpose tool both chips away at rock and shovels debris.");
				 iUse++;
				 SetLocalInt(oUser, "iUse", iUse);
				 }
			 int iGem = Random(20);
			 //SendMessageToPC(oUser, "iGem =" + IntToString(iGem));
			 if(iGem == 1)
				{string sGem = IntToString(Random(11) +11);
				 CreateItemOnObject("abr_it_gem_0" + sGem, oUser, 1);
				 SendMessageToPC(oUser, "You break off a bit of gemstone from the rock.");
				 }
			 iInc++;
			 SetLocalInt(oUser, "iInc", iInc);
			 if((iInc <= iCon/3) && (iInc > 2) && (GetLocalInt(oUser, "Weary") != 1))
			 	{SetLocalInt(oUser, "Weary", 1);
				 SendMessageToPC(oUser, "You begin to grow weary. This is hard work.");
			    }
			 else if((iInc <= (iCon/3) * 2) && (iInc > 4) && (GetLocalInt(oUser, "Muscles") != 1))
			 	{SetLocalInt(oUser, "Muscles", 1);
				 SendMessageToPC(oUser, "Your muscles burn. You don't know how much longer you can keep working without a break.");
			    }
			 else if(iInc == iCon)
				{SetLocalInt(oUser, "Rest", 1);
				 SendMessageToPC(oUser, "You can no longer hold up the tool. You need to take a break. Half an hour ought to do it.");
			     DelayCommand(270.0, SendMessageToPC(oUser, "Your break from shovelling has restored you. You think you can dig some more."));
			     DelayCommand(271.0, SetLocalInt(oUser, "Rest", 0));
				 return;
				 }
				 
			if((iArchitecture > 2) || (GetRacialType(oUser) == RACIAL_TYPE_DWARF) || (GetRacialType(oUser) == RACIAL_TYPE_GNOME)) 
			 	{iModify = iModify + 6;}
			//SendMessageToPC(oUser, "iModify = " + IntToString(iModify));
			object oRubble = GetFirstObjectInShape(SHAPE_SPHERE, 7.5, GetLocation(OBJECT_SELF), FALSE, OBJECT_TYPE_PLACEABLE);
			while(oRubble != OBJECT_INVALID)
			 		{if((FindSubString(GetName(oRubble), "Dirt") != -1) || (FindSubString(GetName(oRubble), "Rock") != -1)|| (FindSubString(GetName(oRubble), "Rubble") != -1)) 
						{DestroyObject(oRubble);
						 SendMessageToPC(oUser, "The area is a littler clearer.");
						 int iQuake = Random(20);
			 			 //SendMessageToPC(oUser, "iQuake =" + IntToString(iQuake));
			 			 object oEndangered = GetFirstObjectInShape(SHAPE_SPHERE, 10.0, GetLocation(OBJECT_SELF), FALSE, OBJECT_TYPE_CREATURE);
				 			 
						 if(iQuake + iModify < 8)
							{effect eQuake = EffectVisualEffect(VFX_SPELL_HIT_EARTHQUAKE, FALSE);
							 while(oEndangered != OBJECT_INVALID)
								 {SendMessageToPC(oUser, GetName(oEndangered));
								  if(GetLocalInt(oEndangered, "Slide") != 1)
									 {//SendMessageToPC(oUser, "Setting Slide to 1 on " + GetName(oEndangered));
								      SetLocalInt(oEndangered, "Slide", 1);
									  CreateObject(OBJECT_TYPE_PLACEABLE, "slv_rock_0" + IntToString(Random(4)), GetLocation(oEndangered));
							 	 	  SendMessageToPC(oEndangered, "Rockfall! Chunks of rock rain around you and dust swirls.");
							     	  if(GetLocalInt(oEndangered, "Reflex") != 1)
										  {//SendMessageToPC(oUser, "Setting Reflex to 1 on " + GetName(oEndangered));
								           SetLocalInt(oEndangered, "Reflex", 1);
										   if(ReflexSave(oEndangered, 10, SAVING_THROW_TYPE_TRAP, OBJECT_SELF))
											 	{SendMessageToPC(oEndangered, "You dodge all injury.");
										     	}
										 
									 		else
											 	{SendMessageToPC(oEndangered, "You take injury!");
										     	 effect eRockfall = EffectDamage(d4(), DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_NORMAL, FALSE);
												 ApplyEffectToObject(DURATION_TYPE_INSTANT, eRockfall, oEndangered);
												 ApplyEffectToObject(DURATION_TYPE_INSTANT, eQuake, oEndangered);
												 }
										  }
									}
								 oEndangered = GetNextObjectInShape(SHAPE_SPHERE, 10.0, GetLocation(OBJECT_SELF), FALSE, OBJECT_TYPE_CREATURE);
				 				 }
							object oDone = GetFirstObjectInShape(SHAPE_SPHERE, 10.0, GetLocation(OBJECT_SELF), FALSE, OBJECT_TYPE_CREATURE);
					 		while(oDone != OBJECT_INVALID)
								{//SendMessageToPC(oUser, "Resetting Slide & Reflex on oDone " + GetName(oDone));
								 SetLocalInt(oDone, "Slide", 0);  
								 SetLocalInt(oDone, "Reflex", 0);
								 oDone = GetNextObjectInShape(SHAPE_SPHERE, 10.0, GetLocation(OBJECT_SELF), FALSE, OBJECT_TYPE_CREATURE);
					 			}
							return;
							}
						return;
						}	 
				 else
				 	{oRubble = GetNextObjectInShape(SHAPE_SPHERE, 7.5, GetLocation(OBJECT_SELF), FALSE, OBJECT_TYPE_PLACEABLE);
			 		 if(oRubble == OBJECT_INVALID)
					 	{SendMessageToPC(oUser, "The immediate area is clear and you pick up the tool.");
						 object oShovelItem = CreateItemOnObject("slv_deandragon_shovel", oUser, 1);
						 DestroyObject(OBJECT_SELF);
						 return;
						 }
					}
				}
				
			}  
		}
				
//deandragon k leomund secure shelter doors
		SpeakString("Called Use", TALKVOLUME_TALK);
	
	if((GetTag(OBJECT_SELF) == "leomund_shelter_door") && (GetLocked(OBJECT_SELF)==FALSE))
		{SpeakString("Tagged Use", TALKVOLUME_TALK);
	    SpeakString("Called", TALKVOLUME_TALK);
	    object oCollBox = GetLocalObject(OBJECT_SELF, "MyCollBox");
		 DestroyObject(oCollBox);
		 	
		if(GetLocalInt(OBJECT_SELF, "Spawned") != 1)
			{SpeakString("Spawned Use", TALKVOLUME_TALK);
	         string sSpawn;
			int iSpawn = Random(5) + 1;
			SendMessageToPC(GetEnteringObject(), "Creatures come boiling out the door!");
			if((iSpawn >= 1) && (iSpawn <=3))
				{CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_hu_koboldfighter02", GetLocation(OBJECT_SELF));
				CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_hu_koboldfighter04", GetLocation(OBJECT_SELF));
				CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_hu_koboldscout01", GetLocation(OBJECT_SELF));
				CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_hu_koboldscout01", GetLocation(OBJECT_SELF));
				CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_hu_koboldcaptain", GetLocation(OBJECT_SELF));
				}
			else if(iSpawn == 4)
				{CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_hu_koboldelite01", GetLocation(OBJECT_SELF));
				CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_hu_koboldfighter03", GetLocation(OBJECT_SELF));
				CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_hu_koboldfighter04", GetLocation(OBJECT_SELF));
				CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_hu_koboldscout01", GetLocation(OBJECT_SELF));
				CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_hu_koboldscout01", GetLocation(OBJECT_SELF));
				CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_hu_koboldscout01", GetLocation(OBJECT_SELF));
				CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_hu_koboldcaptain", GetLocation(OBJECT_SELF));
				}
			else if(iSpawn == 5)
				{CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_hu_koboldshaman", GetLocation(OBJECT_SELF));
				CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_hu_koboldcaptain", GetLocation(OBJECT_SELF));
				CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_hu_koboldscout01", GetLocation(OBJECT_SELF));
				CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_hu_koboldscout01", GetLocation(OBJECT_SELF));
				CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_hu_koboldfighter04", GetLocation(OBJECT_SELF));
				CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_hu_koboldscout01", GetLocation(OBJECT_SELF));
				}
			}	
		DestroyObject(OBJECT_SELF, 2.0);
		}				
		
	// deanphoenix_t mirror
	
	if((GetTag(OBJECT_SELF) == "slv_h_artifice_mirror") && (GetLocalInt(OBJECT_SELF, "Used") != 1))
	    {//Classroom definitions
		 SetLocalInt(OBJECT_SELF, "Used", 1);
		 DelayCommand(1800.0, SetLocalInt(OBJECT_SELF, "Used", 0));
		 object oProfTra = GetObjectByTag("003_cr_slv_proftra_NoWalk");
		 object oProfDiv = GetObjectByTag("003_cr_slv_profdiv_NoWalk");
		 object oJennyReflectionWP = GetWaypointByTag("003_deanphoenix_t_jenny_wp");
		 object oJennyReflection = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_deanphoenix_water_gen", GetLocation(oJennyReflectionWP));
		 DelayCommand(5.0, SetScale(oJennyReflection, 0.7, 0.7, 0.7));
		 object oExit = GetWaypointByTag("003_deanphoenix_t_pc_exit");
		 object oSoundPlayer= GetObjectByTag("slv_tra100_brazier");
		 
		 //Deckon Thar definitions
		 effect eFire3 = EffectVisualEffect(VFX_AURA_HELLFIRE_SHIELD);
	     effect eShake = EffectVisualEffect(VFX_IMP_DIVINE_STRIKE_FIRE);
	     effect eCutScene = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY); 
	     effect eDeath = EffectDeath(TRUE);
		 effect eStatue = EffectVisualEffect(VFX_DUR_FREEZE_ANIMATION);
		 
		 location lViewpoint = GetLocation(GetWaypointByTag("003_deanphoenix_t_pc"));
		 location lMirror2 = GetLocation(GetWaypointByTag("slv_phoenix_mirror_dt"));
         location lEarth = GetLocation(GetWaypointByTag("003_cr_deanphoenix_earth_wp"));
         location lAir = GetLocation(GetWaypointByTag("003_cr_deanphoenix_air_wp"));
         location lWater = GetLocation(GetWaypointByTag("003_cr_deanphoenix_water_wp"));
         object oFire1WP = GetWaypointByTag("003_cr_deanphoenix_fire1_wp");
         object oFire2WP = GetWaypointByTag("003_cr_deanphoenix_fire2_wp");
         location lFire1 = GetLocation(oFire1WP);
         location lFire2 = GetLocation(oFire2WP);
         location lFire3 = GetLocation(GetWaypointByTag("003_deanphoenix_cr_fire3_wp"));
         location lXavier = GetLocation(GetWaypointByTag("003_deanphoenix_cr_xavier_wp"));
		 location lXavier2 = GetLocation(GetWaypointByTag("003_deanphoenix_cr_xavier2_wp"));
		 
		 //Deckon Thar creatures & objects
		 object oMirror2 = CreateObject(OBJECT_TYPE_PLACEABLE, "slv_h_artifice_mirror", lMirror2, FALSE, "slv_h_artifice_mirror2");
         object oJenny = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_deanphoenix_water_gen", lWater);
		 effect eFireBeam=EffectBeam(VFX_BEAM_FIRE, oJenny, BODY_NODE_CHEST, FALSE);
		 object oXavier = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_firegen_xavier", lXavier);
		 DelayCommand(10.0, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutScene, oXavier));
         DelayCommand(11.0, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eStatue, oXavier));
    	 object oXavier2 = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_firegen_xavier", lXavier2);
		 location lBarbarian = GetLocation(GetWaypointByTag("003_deanphoenix_cr_skypony_wp"));
		 object oBarbarian1 = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_uthgardt_skypony", lBarbarian);
		 object oBarbarian2 = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_uthgardt_skypony", lBarbarian);
		 object oBarbarian3 = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_uthgardt_skypony", lBarbarian);
		 object oShaman = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_uthgardt_skypony_shaman", lBarbarian);
		 object oAirEl = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_deanphoenix_air", lAir);
		 object oAirEl2 = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_deanphoenix_air", lXavier2);
		 object oAirEl3 = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_deanphoenix_air", lXavier2);
		 object oFireMeph1 = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_deanphoenix_firemeph", GetLocation(oFire2WP));
		 object oFireMeph2 = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_deanphoenix_firemeph", GetLocation(oJenny));
		 object oFireMeph3 = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_deanphoenix_firemeph", lFire1);
		 object oFireMeph4 = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_deanphoenix_firemeph", lXavier2);
		 object oFireMeph5 = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_deanphoenix_firemeph", lXavier2);
		 object oFireMeph6 = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_deanphoenix_firemeph", lXavier2);
		 DestroyObject(oAirEl, 450.0);
		 DestroyObject(oAirEl2, 450.0);
		 DestroyObject(oAirEl3, 450.0);
		 DestroyObject(oJennyReflection, 300.0);
		 DestroyObject(oFireMeph1, 450.0);
		 DestroyObject(oFireMeph2, 450.0);
		 DestroyObject(oFireMeph3, 450.0);
		 DestroyObject(oFireMeph4, 450.0);
		 DestroyObject(oFireMeph5, 450.0);
		 DestroyObject(oFireMeph6, 450.0);
		 DestroyObject(oBarbarian1, 450.0);
		 DestroyObject(oBarbarian2, 450.0);
		 DestroyObject(oBarbarian3, 450.0);
		 DestroyObject(oShaman, 450.0);
		 
		 //Begin Crystalscribed communication recording in mirror
		 DelayCommand(2.0, SpeakString("*The mirror now reflects...someone else, someone not with you, a masked and slender, green-haired woman in silvery scaled armor. She is seen as through a curtain of green fire. Behind her is somewhere else as well, a ruined hall that was once magnificent, with marble floors and pillars of gold.", TALKVOLUME_TALK));
         DelayCommand(15.0, AssignCommand(oJennyReflection, SpeakString("Xavier...are you there? *Her voice is high and nervous.* Please, come to your mirror. Xavier!", TALKVOLUME_TALK)));
         DelayCommand(18.0, AssignCommand(oSoundPlayer, PlaySound("as_pl_battlegrp8")));
         DelayCommand(25.0, SpeakString("*Battle cries sound distantly behind the woman in the mirror. She glances behind herself, then leans into the frame with more urgency.*", TALKVOLUME_TALK));
         DelayCommand(35.0, AssignCommand(oJennyReflection, SpeakString("We haven't much time. I will hope that your mirror will crystalscribe this, in case we have to run.", TALKVOLUME_TALK)));
         DelayCommand(45.0, SpeakString("*The green light is suddenly washed out by a flash of red, reflecting on her face as if coming out of the space before her. For a moment, her eyes reflect a distorted image of flames.*", TALKVOLUME_TALK));
         DelayCommand(48.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFire3, oJennyReflection, 1.0));
         DelayCommand(50.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eShake, oJennyReflection, 2.0));
         DelayCommand(55.0, AssignCommand(oProfTra, SpeakString("Pay close attention.", TALKVOLUME_TALK)));
         DelayCommand(57.0, AssignCommand(oProfDiv, SpeakString("*Softly* Look deeply. Lose yourself in the message.", TALKVOLUME_TALK)));
         DelayCommand(65.0, SpeakString("*A laugh sounds, and a voice rich with the accent of Calimshan speaks as if from around you, within the green fire.*", TALKVOLUME_TALK));
         DelayCommand(70.0, SpeakString("*I am here, my cold-blooded beauty.", TALKVOLUME_TALK));
         DestroyObject(oJennyReflection, 70.0);
		 
		 int nInc = 1;
		 object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, OBJECT_SELF, nInc);
         while(oPC != OBJECT_INVALID)
		 	{DelayCommand(70.0, FadeToBlack(oPC, FADE_SPEED_SLOWEST));
        	 DelayCommand(72.0, AssignCommand(oPC, ActionJumpToLocation(lViewpoint)));
             DelayCommand(412.0, FadeToBlack(oPC, FADE_SPEED_SLOWEST));
             DelayCommand(415.0,  AssignCommand(oPC, ActionJumpToLocation(GetLocation(oExit))));
             nInc++;
			 oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, OBJECT_SELF, nInc);
			}
		 
		 DelayCommand(100.0, AssignCommand(oMirror2, SpeakString("*...drawing closer, more detail resolves itself in reflection, so clear you seem almost to be there with the woman.", TALKVOLUME_TALK)));
         DelayCommand(110.0, AssignCommand(oMirror2, SpeakString("*There are elemental creatures reflected in that mirror, fire mephits and at least one air elemental. The sounds of a nearby storm indicate there are more air elementals near. Sounds of clashing steel and battlecries war with the shriek of the winds.", TALKVOLUME_TALK)));
         DelayCommand(101.0, AssignCommand(oMirror2, PlaySound("as_wt_gustdraft1")));
         DelayCommand(105.0, AssignCommand(oMirror2, PlaySound("as_pl_battlegrp7")));
         DelayCommand(106.0, AssignCommand(oMirror2, PlaySound("as_wt_gustdraft1")));
         DelayCommand(111.0, AssignCommand(oMirror2, PlaySound("as_pl_battlegrp5")));
         DelayCommand(115.0, AssignCommand(oMirror2, PlaySound("as_pl_sscreamm1")));
         DelayCommand(126.0, AssignCommand(oMirror2, PlaySound("as_wt_guststrng1")));
         
		 DelayCommand(130.0, AssignCommand(oJenny, SpeakString("You have to get us out of here!", TALKVOLUME_TALK)));
         DelayCommand(140.0, AssignCommand(oXavier, SpeakString("You do not command me, Jenny. You will come to me immediately upon your return.", TALKVOLUME_TALK)));
         DelayCommand(150.0, AssignCommand(oJenny, SpeakString("Yes, Mas.... Yes, Xavier. If we make it back. We haven't--", TALKVOLUME_TALK)));
         DelayCommand(160.0, AssignCommand(oXavier, SpeakString("*Breaks in* What is that? What instrument carries your dulcet tones to me? Not the dead Air wizard's mirror?", TALKVOLUME_TALK)));
         DelayCommand(170.0, AssignCommand(oJenny, SpeakString("This. *Waves hand through pillar of green light.*  I don't know what it is. The Grumbar priest --", TALKVOLUME_TALK)));
         DelayCommand(180.0, AssignCommand(oXavier, SpeakString("Very interesting that an untuned instrument would play in harmony with my own. The world is large and full of wonder.", TALKVOLUME_TALK)));
         
		 
		 DelayCommand(190.0, AssignCommand(oBarbarian1, ActionJumpToLocation(lFire1)));
         DelayCommand(192.0, AssignCommand(oFireMeph4, ActionJumpToLocation(lFire1)));
         DelayCommand(193.0, AssignCommand(oFireMeph5, ActionJumpToLocation(lFire1)));
         DelayCommand(194.0, AssignCommand(oAirEl2, ActionJumpToLocation(lFire1)));
          
         DelayCommand(200.0, AssignCommand(oXavier, PlaySound("as_pl_laughingm2")));
         DelayCommand(203.0, AssignCommand(oXavier, PlaySound("as_pl_laughingm2")));
         DelayCommand(204.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFireBeam, oBarbarian1, 5.0));
         DelayCommand(205.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFire3, oBarbarian1, 2.0));
         DelayCommand(206.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oBarbarian1));
         DelayCommand(206.5, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFire3, oJenny, 10.0));
         DelayCommand(207.0, AssignCommand(oJenny, ActionForceMoveToLocation(lWater, FALSE)));
		 DelayCommand(210.0, AssignCommand(oXavier, SpeakString("*Laughs, long and hard.* You put my little compositions to good use. I take it the Sky Pony did not wish to sell what I seek?", TALKVOLUME_TALK)));
         DelayCommand(220.0, AssignCommand(oJenny, SpeakString("*Turns back to the mirror.* After about five words they started yelling about sacrilege and we had to chase them out of here. I've barricaded the way with elementals, but they are breaking through!", TALKVOLUME_TALK)));
         DelayCommand(221.0, AssignCommand(oJenny, ActionForceMoveToLocation(lWater, FALSE)));
		 DelayCommand(230.0, AssignCommand(oXavier, SpeakString("I require a powerful air token. /We/ require a powerful air token. The loss of the avariel last year was a setback we must recover. The show, as they say, must go on.", TALKVOLUME_TALK)));
         DelayCommand(240.0, AssignCommand(oJenny, SpeakString("*Tears well up in her eyes and begin to drip in a stream down her face, a steady stream, a rivulet.* It gets worse.", TALKVOLUME_TALK)));
         DelayCommand(250.0, AssignCommand(oXavier, SpeakString("Worse? Worse for you, who holds the position of water, with equivalent positions unfilled?", TALKVOLUME_TALK)));
         DelayCommand(260.0, AssignCommand(oJenny, SpeakString("*Wipes her eyes and quavers* They killed the Grumbar priest.", TALKVOLUME_TALK)));
         DelayCommand(270.0, AssignCommand(oJenny, SpeakString("*Did you hear me? The Uthgardt killed our Earthworker!", TALKVOLUME_TALK)));
         DelayCommand(280.0, AssignCommand(oXavier, SpeakString("I heard you. *Begins to chuckle, an amusement the tremulous woman doesn't seem to share.* And his pet?", TALKVOLUME_TALK)));
         DelayCommand(290.0, AssignCommand(oJenny, SpeakString("Fled, as soon as its master no longer commanded it. It ate its way through the slide, leaving us here!", TALKVOLUME_TALK)));
         DelayCommand(300.0, AssignCommand(oXavier, SpeakString("So we are not only down one avarial, we are now short another required element? Well, that does put you into a bit of a bind. Am I not clever? I do amuse myself. A bind? Or perhaps you're about to be unbound...permanently.", TALKVOLUME_TALK)));
         DelayCommand(310.0, AssignCommand(oJenny, SpeakString("There are dozens of Uthgardt, and they are coming! It's just me left, and the air and fire elementals.", TALKVOLUME_TALK)));
         DelayCommand(320.0, AssignCommand(oXavier, SpeakString("Yes, just you, Jenny, and you have failed me.", TALKVOLUME_TALK)));
         DelayCommand(330.0, AssignCommand(oJenny, SpeakString("You wouldn't leave me here! Think how hard it will be to replace me, too!", TALKVOLUME_TALK)));
         DelayCommand(340.0, AssignCommand(oXavier, SpeakString("Perhaps a clean slate is what is needed. It could hardly get more boring.", TALKVOLUME_TALK)));
         DelayCommand(350.0, AssignCommand(oJenny, SpeakString("I am more to you than just one of the tokens--", TALKVOLUME_TALK)));
         DelayCommand(355.0, AssignCommand(oXavier, PlaySound("as_pl_laughingm2")));
         DelayCommand(358.0, AssignCommand(oXavier, PlaySound("as_pl_laughingm2")));
         DelayCommand(360.0, AssignCommand(oXavier, PlaySound("as_pl_laughingm2")));
         DelayCommand(361.0, AssignCommand(oXavier, PlaySound("as_pl_laughingm2")));
         DelayCommand(361.0, AssignCommand(oXavier, SpeakString("*His laughter begins to roll, growing in volume.*", TALKVOLUME_TALK)));
         DelayCommand(370.0, AssignCommand(oJenny, SpeakString("Please! Master. Please.", TALKVOLUME_TALK)));
         DelayCommand(374.0, AssignCommand(oJenny, PlaySound("as_pl_battlegrp7")));
         DelayCommand(378.0, AssignCommand(oMirror2, PlaySound("as_wt_guststrng1")));
         DelayCommand(380.0, AssignCommand(oXavier, SpeakString("I am coming, Water girl. Grip the mirror and hold tight, that I may focus, not that I need much focus to follow your sweet panic.*", TALKVOLUME_TALK)));
         DestroyObject(oXavier, 381.0);
		 DelayCommand(381.0, AssignCommand(oJenny, ActionForceMoveToLocation(lWater, FALSE)));
		 DelayCommand(385.0, AssignCommand(oBarbarian2, ActionJumpToLocation(lFire1)));
         DelayCommand(386.0, AssignCommand(oBarbarian3, ActionJumpToLocation(lFire1)));
         DelayCommand(388.0, AssignCommand(oShaman, ActionJumpToLocation(lFire1)));
         DelayCommand(389.0, AssignCommand(oFireMeph5, ActionJumpToLocation(lFire1)));
         DelayCommand(390.0, AssignCommand(oFireMeph6, ActionJumpToLocation(GetLocation(oJenny))));
         DelayCommand(391.0, AssignCommand(oAirEl3, ActionJumpToLocation(lFire1)));
         DelayCommand(392.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFireBeam, oShaman, 5.0));
         DelayCommand(395.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFire3, oShaman, 2.0));
         DelayCommand(395.0, AssignCommand(oXavier2, ActionJumpToLocation(lWater)));
         DelayCommand(396.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFire3, oXavier2, 1.0));
         DelayCommand(397.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eShake, oXavier2, 2.0));
         DelayCommand(398.0, AssignCommand(oXavier2, SpeakString("I step on stage. Prepair to be ENTERTAINED!", TALKVOLUME_TALK)));
         DelayCommand(410.0, AssignCommand(oMirror2, SpeakString("*The mirror darkens....", TALKVOLUME_TALK)));
         
		 DelayCommand(450.0, SpeakString("...and then reflections return...but only of the Transmutation classroom in the Lady's College.", TALKVOLUME_TALK));
         DelayCommand(460.0, AssignCommand(oProfTra, SpeakString("You were right, Clarvue. Much more instructive. We don't know where the sending came from or what happened after. What we do know is that all that talk about elementalism and tokens of power indicates something very interesting happening somewhere.", TALKVOLUME_TALK)));
         DelayCommand(470.0, AssignCommand(oProfTra, SpeakString("I am personally quite interested in the mechanism...that green light...that seems to communicate with various scrying mirrors within the region.", TALKVOLUME_TALK)));
         DelayCommand(480.0, AssignCommand(oProfDiv, SpeakString("And I would like to know more about the dead Air wizard that was mentioned. A wizard with powers of Air and a priest of Grumbar make an interesting set, when taken with that woman, Jenny, clearly of a watery descent.", TALKVOLUME_TALK)));
         DelayCommand(490.0, AssignCommand(oProfTra, SpeakString("Indeed. When put beside the sudden scarcity of phoenixii in the Marches, it does seem to add up to somebody--as they say in Amn--cornering the market on elemental powers.", TALKVOLUME_TALK)));
         DelayCommand(500.0, AssignCommand(oProfTra, SpeakString("*Small smile* Most of that, of course, is for older and more powerful mages to concern themselves with. But proctors would certainly be useful research assistants.", TALKVOLUME_TALK)));
         DelayCommand(505.0, AssignCommand(oProfDiv, SpeakString("Listens silently, with an enigmatic smile.*", TALKVOLUME_TALK)));
         DelayCommand(510.0, AssignCommand(oProfTra, SpeakString("Of course, that is what Sera expects of you. To theorize possibilities. To look over our shoulders and learn in safety as we study the matter further. Perhaps even to perform small tasks in support of our great works.", TALKVOLUME_TALK)));
         DelayCommand(520.0, AssignCommand(oProfTra, SpeakString("Well, this has been most enjoyable. You will do great things, scholar. Have no doubt.", TALKVOLUME_TALK)));
         DelayCommand(530.0, AssignCommand(oProfDiv, SpeakString("Be careful, scholars. *Quietly* Wheresoever your research takes you. I must go. Miresk is pounding on my door upstairs.", TALKVOLUME_TALK)));
         DestroyObject(oProfDiv, 531.0);
         AssignCommand(oProfTra, DelayCommand(540.0, SpeakString("*Chuckles* Well, you certainly have your work cut out for you. You have earned your keyword. It is: 'Teaches'.", TALKVOLUME_TALK)));
         if(ACR_RetrieveQuestState("slv_deandragon_t", oUser) ==1)
		 	{DelayCommand(546.0, ACR_AddPersistentJournalQuestEntry("slv_deandragon_t", 2, oUser, FALSE, FALSE, FALSE, 0));
			}
		 AssignCommand(oProfTra, DelayCommand(550.0, SpeakString("Now, if you'll excuse me, Clarvue is telling me right now in my head that Miresk requires both me, and the mirror. *Vanishes*", TALKVOLUME_TALK)));
         DestroyObject(oProfTra, 555.0);
         DestroyObject(OBJECT_SELF, 556.0);
         }	
		
	// deandragon_t mirror old
	
	/*if((GetTag(OBJECT_SELF) == "slv_h_artifice_mirror") && (GetLocalInt(OBJECT_SELF, "Used") != 1))
	    {effect eBard = EffectVisualEffect(VFX_DUR_BARD_SONG);
	     effect eCutScene = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY); 
	     effect eSun = EffectVisualEffect(VFX_FNF_SUNBEAM, FALSE);
	     effect eDeath = EffectDeath(TRUE);
		 
	     SetLocalInt(OBJECT_SELF, "Used", 1);
		 DelayCommand(1800.0, SetLocalInt(OBJECT_SELF, "Used", 0));
		 object oEnter = GetLocalObject(OBJECT_SELF, "oEnter");
		 if(oEnter == OBJECT_INVALID)
		 	{oEnter = GetWaypointByTag("slv_deandragon_t_enter");
			 SetLocalObject(OBJECT_SELF, "oEnter", oEnter);
			}
		 object oExit = GetLocalObject(OBJECT_SELF, "oExit");
		 if(oExit == OBJECT_INVALID)
		 	{oExit = GetWaypointByTag("slv_deandragon_t_exit");
			 SetLocalObject(OBJECT_SELF, "oExit", oExit);
			}
		 object oHaellech = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_slv_haellech", GetLocation(OBJECT_SELF));
		 object oMirror = OBJECT_SELF;
         location lMirror2 = GetLocation(GetWaypointByTag("h_artifice_mirror"));
         object oMirror2 = CreateObject(OBJECT_TYPE_PLACEABLE, "slv_h_artifice_mirror", lMirror2, FALSE, "slv_h_artifice_mirror2");
         SetUseableFlag(oMirror2, TRUE);
		 DestroyObject(oMirror2, 700.0);
		 location lXothor1 = GetLocation(GetWaypointByTag("Xothor1"));
         location lXothor2 = GetLocation(GetWaypointByTag("Xothor2"));
         location lXothor3 = GetLocation(GetWaypointByTag("Xothor3"));
         location lXothor4 = GetLocation(GetWaypointByTag("Xothor4"));
         location lXothor5 = GetLocation(GetWaypointByTag("Xothor5"));
         location lMallechenith = GetLocation(GetWaypointByTag("Mallechenith"));
		 
		 DestroyObject(GetObjectByTag("003_cr_slv_proftra"));
		 DestroyObject(GetObjectByTag("003_cr_slv_profevo"));
		 object oProfTra = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_slv_proftra", GetLocation(oExit));
		 object oProfEvo = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_slv_profevo", GetLocation(oExit));
		 ApplyEffectToObject(DURATION_TYPE_INSTANT, eBard, oHaellech);
         DelayCommand(4.0, (ApplyEffectToObject(DURATION_TYPE_INSTANT, eBard, oHaellech)));
         AssignCommand(oMirror, DelayCommand(5.0, SpeakString("*The mirror now reflects...someone else, someone not with you, a one-eyed dwarf in battle gear. Behind him is somewhere else, as well, a mining cavern shaped into a great hall, but ruined by battle.", TALKVOLUME_TALK)));
         DelayCommand(14.0, (ApplyEffectToObject(DURATION_TYPE_INSTANT, eBard, oHaellech)));
         DelayCommand(15.0, AssignCommand(oHaellech, SpeakString("I am Haellech, sudden Xothor and recorder of doom.  You stand here, thus the Gleam in the Eye has fallen on you...and allowed you to review our tragic history.  Dugmaren allow me the hope that this performance comes soon, and that I play to myself, with reinforcements and defenders surrounding as audience, too.  For now I am all there is left -- hero, hapless and historian, all in one.", TALKVOLUME_TALK)));
         DelayCommand(24.0, (ApplyEffectToObject(DURATION_TYPE_INSTANT, eBard, oHaellech)));
         DelayCommand(30.0, AssignCommand(oHaellech, SpeakString("Three years ago, they came upon us by stealth. I was practicing to play for Highharvestide.  High Priest Mallechenith and the brothers and sisters of the Halls went about their own preparations. The Halls, then, were always thrown open, and the coming feast had distracted all, including, it seems, the greeters at the great doors of the Entry Chambers.  The first we knew of attack was here...", TALKVOLUME_TALK)));
         DelayCommand(31.0, ActionCreateWyn("003_cr_dug_xothor", lXothor1));
         DelayCommand(33.0, ActionCreateWyn("003_cr_dug_xothor_war", lXothor1));
         DelayCommand(36.0, ActionCreateWyn("003_cr_dug_xothor_war", lXothor2));
         DelayCommand(39.0, ActionCreateWyn("003_cr_dug_xothor", lXothor3));
         DelayCommand(42.0, ActionCreateWyn("003_cr_dug_xothor_war", lXothor4));
         DelayCommand(45.0, ActionCreateWyn("003_cr_dug_xothor", lXothor5));
         DelayCommand(48.0, ActionCreateWyn("003_cr_dug_mallechenith", lMallechenith));
		 DestroyObject(GetObjectByTag("003_cr_dug_mallechenith", 0), 375.0);
		 AssignCommand(oMirror, DelayCommand(45.0, SpeakString("*Haellech fades away and the reflection in the mirror darkens...", TALKVOLUME_TALK)));
         DelayCommand(46.0,  AssignCommand(oHaellech, ActionJumpToLocation(GetLocation(oEnter))));
         DelayCommand(446.0,  AssignCommand(oHaellech, ActionJumpToLocation(GetLocation(oExit))));
         int nInc = 1;
		 object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, oHaellech, nInc);
         while(oPC != OBJECT_INVALID)
		 	{DelayCommand(50.0, FadeToBlack(oPC, FADE_SPEED_SLOWEST));
        	 DelayCommand(52.0,  AssignCommand(oPC, ActionJumpToLocation(GetLocation(oEnter))));
             DelayCommand(446.0, FadeToBlack(oPC, FADE_SPEED_SLOWEST));
             DelayCommand(448.0,  AssignCommand(oPC, ActionJumpToLocation(GetLocation(oExit))));
             nInc++;
			 oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, oHaellech, nInc);
			}
		 DelayCommand(56.0, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutScene, oHaellech));
         AssignCommand(oMirror2, DelayCommand(100.0, SpeakString("*...the reflection in the mirror fades back in, and though it shows the same room, it reflects more than just Haellech.  There are Xothor of Dugmaren reflected in that mirror, an everyday scene of bustle and good cheer in a hall not yet ruined.  A dignified elder cleric walks among them, admonishing and approving by turns, clearly a higher cleric.  He is addressed as Mallechenith by many.", TALKVOLUME_TALK)));
         DelayCommand(101.0, AssignCommand(oHaellech, PlaySound("as_pl_chantingm1")));
         DelayCommand(106.0, AssignCommand(oHaellech, PlaySound("as_pl_noblaughi1")));
         DelayCommand(111.0, AssignCommand(oHaellech, PlaySound("as_pl_chantingm1")));
         DelayCommand(112.0, AssignCommand(oHaellech, PlaySound("as_pl_laughingm1")));
         DelayCommand(116.0, AssignCommand(oHaellech, SpeakString("There were shrieks in the stairwell, and the undead came pouring in.  We should have known.  That is when we should have known...", TALKVOLUME_TALK)));
         DelayCommand(118.0, AssignCommand(oHaellech, PlaySound("as_pl_shriekm1")));
         DelayCommand(118.0, ActionCreateWyn("abr_cr_un_zombie_soldier01", lXothor5));
         DelayCommand(120.0, ActionCreateWyn("abr_cr_un_zombie_soldier04", lXothor5));
         DelayCommand(122.0, ActionCreateWyn("abr_cr_un_skeleton_tombguard02", lXothor5));
         DelayCommand(124.0, ActionCreateWyn("abr_cr_un_skeleton_tombguard01", lXothor2));
         DelayCommand(126.0, ActionCreateWyn("abr_cr_un_skeleton_tombguard03", lXothor5));
         DelayCommand(128.0, ActionCreateWyn("abr_cr_un_skeleton_tombguard02", lXothor2));
         DelayCommand(130.0, ActionCreateWyn("abr_cr_un_skeleton_giant", lXothor2));
         DelayCommand(132.0, ActionCreateWyn("abr_cr_un_zombie_soldier02", lXothor5));
         DelayCommand(132.0, AssignCommand(oHaellech, PlaySound("as_pl_panicgrp2")));
         DelayCommand(137.0, ActionCreateWyn("abr_cr_un_zombie_soldier01", lXothor2));
         DelayCommand(140.0, ActionCreateWyn("abr_cr_un_zombie_soldier03", lXothor5));
         DelayCommand(141.0, AssignCommand(GetObjectByTag("003_cr_dug_mallechenith", 0), ClearAllActions(TRUE)));
         DelayCommand(142.0, AssignCommand(GetObjectByTag("003_cr_dug_mallechenith", 0), ActionCastSpellAtObject(SPELL_SUNBEAM, GetObjectByTag("nw_skelwarrkis", 0), METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, FALSE)));
         DelayCommand(143.0, AssignCommand(oHaellech, PlaySound("as_pl_panicgrp1")));
         DelayCommand(145.0, ActionCreateWyn("abr_cr_un_skeleton_sorcerer", lXothor5));
         DelayCommand(146.0, ActionCreateWyn("abr_cr_un_skeleton_tombguard02", lXothor2));
         DelayCommand(148.0, ActionCreateWyn("abr_cr_un_skeleton_tombguard03", lXothor5));
         DelayCommand(150.0, ActionCreateWyn("003_cr_dug_xothor_war", lXothor5));
         DelayCommand(150.0, AssignCommand(oHaellech, PlaySound("as_pl_screamm1")));
         DelayCommand(153.0, ActionCreateWyn("abr_cr_un_zombie_soldier03", lXothor2));
         DelayCommand(157.0, ActionCreateWyn("abr_cr_un_zombie_soldier01", lXothor5));
         DelayCommand(160.0, ActionCreateWyn("003_cr_dug_xothor", lXothor2));
         DelayCommand(165.0, ActionCreateWyn("abr_cr_un_skeleton_icy", lXothor5));
         DelayCommand(167.0, AssignCommand(GetObjectByTag("abr_cr_un_skeleton_icy", 0), ClearAllActions(TRUE)));
         DelayCommand(168.0, AssignCommand(GetObjectByTag("abr_cr_un_skeleton_icy", 0), ActionMoveToLocation(GetLocation(GetWaypointByTag("Mallechenith")))));
         DelayCommand(169.0, AssignCommand(GetObjectByTag("003_cr_dug_mallechenith", 0), ClearAllActions(TRUE)));
         DelayCommand(170.0, AssignCommand(GetObjectByTag("003_cr_dug_mallechenith", 0), ActionJumpToLocation(GetLocation(GetWaypointByTag("Mallechenith")))));
         DelayCommand(170.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eSun, GetNearestCreature(CREATURE_TYPE_RACIAL_TYPE, RACIAL_TYPE_UNDEAD, OBJECT_SELF, 1)));
         DelayCommand(175.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eSun, GetNearestCreature(CREATURE_TYPE_RACIAL_TYPE, RACIAL_TYPE_UNDEAD, OBJECT_SELF, 2)));
         DelayCommand(180.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eSun, GetNearestCreature(CREATURE_TYPE_RACIAL_TYPE, RACIAL_TYPE_UNDEAD, OBJECT_SELF, 3)));
         DelayCommand(185.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eSun, GetNearestCreature(CREATURE_TYPE_RACIAL_TYPE, RACIAL_TYPE_UNDEAD, OBJECT_SELF, 4)));
         DelayCommand(172.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, GetNearestCreature(CREATURE_TYPE_RACIAL_TYPE, RACIAL_TYPE_UNDEAD, OBJECT_SELF, 1)));
         DelayCommand(177.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, GetNearestCreature(CREATURE_TYPE_RACIAL_TYPE, RACIAL_TYPE_UNDEAD, OBJECT_SELF, 2)));
         DelayCommand(182.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, GetNearestCreature(CREATURE_TYPE_RACIAL_TYPE, RACIAL_TYPE_UNDEAD, OBJECT_SELF, 3)));
         DelayCommand(187.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, GetNearestCreature(CREATURE_TYPE_RACIAL_TYPE, RACIAL_TYPE_UNDEAD, OBJECT_SELF, 4)));
         DelayCommand(190.0, AssignCommand(GetObjectByTag("abr_cr_un_skeleton_sorcerer", 0), ClearAllActions(TRUE)));
         DelayCommand(191.0, AssignCommand(GetObjectByTag("abr_cr_un_skeleton_sorcerer", 0), ActionJumpToLocation(GetLocation(GetWaypointByTag("Mallechenith")))));
         DelayCommand(192.0, AssignCommand(GetObjectByTag("003_cr_dug_mallechenith", 0), ClearAllActions(TRUE)));
         DelayCommand(193.0, AssignCommand(GetObjectByTag("003_cr_dug_mallechenith", 0), ActionJumpToLocation(GetLocation(GetWaypointByTag("Mallechenith")))));
         DelayCommand(194.0, AssignCommand(GetObjectByTag("003_cr_dug_mallechenith", 0), ActionCastSpellAtObject(SPELL_SUNBEAM, GetObjectByTag("abr_cr_un_skeleton_sorcerer", 0), METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, FALSE)));
         DelayCommand(196.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, GetObjectByTag("abr_cr_un_skeleton_sorcerer", 0)));
         DelayCommand(197.0, (ApplyEffectToObject(DURATION_TYPE_INSTANT, eBard, oHaellech)));
         DelayCommand(200.0, AssignCommand(oHaellech, SpeakString("Mallechenith was mighty in the defense of his god's temple.", TALKVOLUME_TALK)));
         DelayCommand(212.0, (ApplyEffectToObject(DURATION_TYPE_INSTANT, eBard, oHaellech)));
         DelayCommand(215.0, AssignCommand(oHaellech, SpeakString("T'was not the end, though.  The dead attacked for days, then tendays, then months.  It was a war of attrition, weighted against us, for the undead that were slain -- and our own dead -- rose again to fight against us, wearing the mark of Gargauth.  Clearly, living foes with the power to create the unliving, lurked somewhere.  We sent for aid, but it never came.", TALKVOLUME_TALK)));
         DelayCommand(228.0, (ApplyEffectToObject(DURATION_TYPE_INSTANT, eBard, oHaellech)));
         DelayCommand(230.0, AssignCommand(oHaellech, SpeakString("Mallechenith designed a protection, an edifice through which any attacker must pass, an archway in the Great Entry that did not suffer the tread of abominations.  With mighty prayer and the skills of mechanical artifice that raised him head and shoulders above the greatest designer of wonders even among the Xothor, he made it self-sufficient.", TALKVOLUME_TALK)));
         DelayCommand(243.0, (ApplyEffectToObject(DURATION_TYPE_INSTANT, eBard, oHaellech)));
         DelayCommand(245.0, AssignCommand(oHaellech, SpeakString("A stone he had discovered beneath the Halls, a stone that when crushed released power.  Xothor had been experimenting with it for years.  Recognizing that it must store power first, he...enhanced...it, and built of it.  The clergy were exhausted, and grateful to shift some of the weight of defense to this obsidious sentinal, but others wondered how he had done it or even muttered that /it/ echoed the undead itself in the way that it sucked the very power from living things around it, to use for itself.", TALKVOLUME_TALK)));
         DelayCommand(258.0, (ApplyEffectToObject(DURATION_TYPE_INSTANT, eBard, oHaellech)));
         DelayCommand(262.0, AssignCommand(oHaellech, SpeakString("*Softly*  But we needed it.  And it saved us when the mummy came...", TALKVOLUME_TALK)));
         
		 //object oUndead = GetFirstObjectInArea(GetArea(OBJECT_SELF));
		 //while(oUndead != OBJECT_INVALID)
		// 	{if((GetObjectType(oUndead) == OBJECT_TYPE_CREATURE) && (GetRacialType(oUndead) == RACIAL_TYPE_UNDEAD))
		//		{DestroyObject(oUndead, 265.0);
         //		 oUndead = GetNextObjectInArea(GetArea(OBJECT_SELF));
		//		}
		//	}
		 DelayCommand(269.0, AssignCommand(oHaellech, ClearAllActions(TRUE)));
		 DelayCommand(270.0, AssignCommand(oHaellech, PlaySound("as_pl_chantingm1")));
         DelayCommand(273.0, (ApplyEffectToObject(DURATION_TYPE_INSTANT, eBard, oHaellech)));
         DelayCommand(275.0, AssignCommand(oHaellech, SpeakString("They came at night, through the Great Door....", TALKVOLUME_TALK)));
         DelayCommand(280.0, ActionCreateWyn("abr_cr_un_zombie_soldier01", lXothor5));
         DelayCommand(282.0, ActionCreateWyn("abr_cr_un_zombie_soldier04", lXothor5));
         DelayCommand(284.0, ActionCreateWyn("abr_cr_un_skeleton_tombguard02", lXothor5));
         DelayCommand(286.0, ActionCreateWyn("abr_cr_un_skeleton_tombguard01", lXothor2));
         DelayCommand(288.0, ActionCreateWyn("abr_cr_un_skeleton_tombguard03", lXothor5));
         DelayCommand(290.0, ActionCreateWyn("abr_cr_un_skeleton_tombguard02", lXothor1));
         DelayCommand(295.0, ActionCreateWyn("abr_cr_un_skeleton_giant", lXothor5));
         DelayCommand(297.0, ActionCreateWyn("abr_cr_un_zombie_soldier02", lXothor5));
         DelayCommand(299.0, AssignCommand(oHaellech, PlaySound("as_pl_panicgrp2")));
         DelayCommand(300.0, ActionCreateWyn("abr_cr_un_zombie_soldier01", lXothor4));
         DelayCommand(302.0, ActionCreateWyn("abr_cr_un_zombie_soldier03", lXothor5));
         DelayCommand(305.0, AssignCommand(GetObjectByTag("003_cr_dug_mallechenith", 0), ClearAllActions()));
         DelayCommand(306.0, AssignCommand(GetObjectByTag("003_cr_dug_mallechenith", 0), ActionCastSpellAtObject(SPELL_SUNBEAM, GetObjectByTag("nw_skelwarrkis", 0), METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, FALSE)));
         DelayCommand(310.0, AssignCommand(oHaellech, PlaySound("as_pl_panicgrp1")));
         DelayCommand(312.0, ActionCreateWyn("003_cr_ud_mummy", lMallechenith));
         DelayCommand(315.0, AssignCommand(oHaellech, PlaySound("as_pl_screamm1")));
         DelayCommand(315.0, AssignCommand(GetObjectByTag("003_cr_dug_mallechenith", 0), ClearAllActions(TRUE)));
         DelayCommand(316.0, AssignCommand(GetObjectByTag("003_cr_dug_mallechenith", 0), ActionJumpToLocation(GetLocation(GetWaypointByTag("Mallechenith")))));
         DelayCommand(317.0, AssignCommand(GetObjectByTag("003_cr_ud_mummy", 0), ClearAllActions()));
         DelayCommand(318.0, AssignCommand(GetObjectByTag("003_cr_ud_mummy", 0), ActionAttack(GetObjectByTag("003_cr_dug_mallechenith", FALSE))));
         DelayCommand(320.0, AssignCommand(GetObjectByTag("003_cr_dug_mallechenith", 0), ClearAllActions()));
         DelayCommand(321.0, AssignCommand(GetObjectByTag("003_cr_dug_mallechenith", 0), ActionCastSpellAtObject(SPELL_SUNBEAM, GetObjectByTag("abr_cr_un_skeleton_giant", 0), METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, FALSE)));
         DelayCommand(325.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, GetObjectByTag("abr_cr_un_skeleton_giant", 0)));
         DelayCommand(327.0, AssignCommand(GetObjectByTag("003_cr_dug_mallechenith", 0), ClearAllActions()));
         DelayCommand(329.0, AssignCommand(GetObjectByTag("003_cr_dug_mallechenith", 0), ActionCastSpellAtObject(SPELL_SUNBEAM, GetObjectByTag("003_cr_ud_mummy", 0), METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, FALSE)));
         DelayCommand(330.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, GetObjectByTag("003_cr_ud_mummy", 0)));
         DelayCommand(334.0, (ApplyEffectToObject(DURATION_TYPE_INSTANT, eBard, oHaellech)));
         DelayCommand(336.0, AssignCommand(oHaellech, SpeakString("There were those who said that the mummy struck Mallechenith, and those who claimed they saw him rebuke it before he slew it.  The whispers were lost, though, in the tumultuous joy that arose when the undead came no more.  The temple siege was over; the Xothor had won.", TALKVOLUME_TALK)));
         DelayCommand(348.0, (ApplyEffectToObject(DURATION_TYPE_INSTANT, eBard, oHaellech)));
         DelayCommand(350.0, AssignCommand(oHaellech, SpeakString("I wrote songs, paeons of praise such had never been written, and being a vain and lazy man, took them outside, to the wider audience of the world.  The Xothor set about rebuilding their Hall.  I returned two years later -- mere months ago -- expecting growth and rebirth, and found instead, disaster.", TALKVOLUME_TALK)));
         DelayCommand(365.0, ActionCreateWynPlace("hrv_plc_rock_tall_black", lXothor1));
         DelayCommand(367.0, ActionCreateWynPlace("hrv_plc_rock_tall_black", lXothor2));
         DelayCommand(370.0, ActionCreateWynPlace("hrv_plc_rock_tall_black", lXothor3));
         DelayCommand(372.0, ActionCreateWynPlace("hrv_plc_rock_tall_black", lXothor4));
         DelayCommand(375.0, ActionCreateWynPlace("hrv_plc_rock_tall_black", lXothor5));
         DestroyObject(GetObjectByTag("hrv_plc_rock_tall_black", 0), 600.0);
		 DestroyObject(GetObjectByTag("hrv_plc_rock_tall_black", 1), 601.0);
		 DestroyObject(GetObjectByTag("hrv_plc_rock_tall_black", 2), 602.0);
		 DestroyObject(GetObjectByTag("hrv_plc_rock_tall_black", 3), 603.0);
		 DestroyObject(GetObjectByTag("hrv_plc_rock_tall_black", 4), 604.0);
		 DelayCommand(378.0, (ApplyEffectToObject(DURATION_TYPE_INSTANT, eBard, oHaellech)));
         DelayCommand(380.0, AssignCommand(oHaellech, SpeakString("The obsidious material had /grown/.  It had multiplied, expanding, running wild, if stone may be said to do so.  The Halls of Artifice were soaked with magic both divine and arcane, and Mallechenith's arch had sucked it all up and used it to make more of itself that needed more power that made more crystal that needed more power that....  *Voice falters*  It had taken over, thrusting up through the very floor from the pits in which Mallechenith had once mined it.", TALKVOLUME_TALK)));
         DelayCommand(393.0, (ApplyEffectToObject(DURATION_TYPE_INSTANT, eBard, oHaellech)));
         DelayCommand(395.0, AssignCommand(oHaellech, SpeakString("Worse than that, not only did it suck the power from all around it, it /gorged/ itself on it, continuing to absorb whatever power it could until it overloaded and caused explosions of power.  Random waves of whatever sources it had consumed were liable to sweep the Halls at any time as it /vented/ power, before beginning to absorb more again.  A deadly cycle.  Considering some of the artifacts the Xothor had either studied or created, this blinded or killed as many as had the undead.", TALKVOLUME_TALK)));
         DelayCommand(408.0, (ApplyEffectToObject(DURATION_TYPE_INSTANT, eBard, oHaellech)));
         DelayCommand(410.0, AssignCommand(oHaellech, SpeakString("Mallechenith had gone mad, I was told, with shame and grief.  He had decreed the Halls lost, commanded the creation of crystal tombs that he said would preserve living guardians against some far-future day in which aid might come.  Then he had ordered himself wrapped with winding cloths like a mummy and before his acolyte's eyes had slain himself ritually.  They had tombed him in the obsidious pits beneath the Halls, honoring his last request.", TALKVOLUME_TALK)));
         DelayCommand(423.0, (ApplyEffectToObject(DURATION_TYPE_INSTANT, eBard, oHaellech)));
         DelayCommand(425.0, AssignCommand(oHaellech, SpeakString("On the second night after I had returned, so did Mallechenith.", TALKVOLUME_TALK)));
         DelayCommand(430.0, ActionCreateWyn("003_cr_ud_mummy_priest", lMallechenith));
         DelayCommand(438.0, (ApplyEffectToObject(DURATION_TYPE_INSTANT, eBard, oHaellech)));
         DelayCommand(440.0, AssignCommand(oHaellech, SpeakString("There is very little else to say, after that. The greatest chambers were destroyed, utterly, consumed by blackness. The very walls closed in, crushing those within them.", TALKVOLUME_TALK)));
         
		 
		 DelayCommand(452.0, AssignCommand(oProfTra, ClearAllActions(TRUE)));
		 DelayCommand(452.0, AssignCommand(oProfEvo, ClearAllActions(TRUE)));
		 
		 DelayCommand(452.0, SetLocalInt(GetObjectByTag("003_cr_slv_profevo"), "Walk_Off",1));
		 DelayCommand(452.0, SetLocalInt(GetObjectByTag("003_cr_slv_proftra"), "Walk_Off",1));
		 DelayCommand(453.0, AssignCommand(oProfEvo, ActionJumpToLocation(GetLocation(oExit))));
		 DelayCommand(453.0, AssignCommand(oProfTra, ActionJumpToLocation(GetLocation(oExit))));
		 AssignCommand(oMirror, DelayCommand(475.0, SpeakString("*The mirror once again reflects Haellech and the ruined cavern.", TALKVOLUME_TALK)));
         DelayCommand(476.0, RemoveEffect(oHaellech, eCutScene));
		 DelayCommand(478.0, (ApplyEffectToObject(DURATION_TYPE_INSTANT, eBard, oHaellech)));
         DelayCommand(480.0, AssignCommand(oHaellech, SpeakString("The surges are down to every few days, since we recognized that the more magic we try to cast, the more frequently the obsidious towers overload.  We none of us care to be randomly teleported by a damaged transport ring or seared by gouts of fire from the evercooking pot or have random physical and mental senses destroyed by power sourced from the illithid chair.", TALKVOLUME_TALK)));
         DelayCommand(493.0, (ApplyEffectToObject(DURATION_TYPE_INSTANT, eBard, oHaellech)));
         DelayCommand(495.0, AssignCommand(oHaellech, SpeakString("We have come to see that Mallechenith was the unseen foe the whole time.  He it was who brought the dead among us.  He it was who raised the first mummy.  When he created the arch, his prayers went to Gargauth, not Dugmaren.  The obsidious material from which he built his own crypt have powered his transformation into a monster.  The Halls are indeed lost...befouled by treachery and the ancient enemy.", TALKVOLUME_TALK)));
         DelayCommand(508.0, (ApplyEffectToObject(DURATION_TYPE_INSTANT, eBard, oHaellech)));
         DelayCommand(510.0, AssignCommand(oHaellech, SpeakString("We are few left, a handful only.  Mallechenith cannot enter the upper Halls because of his own device, but 'tis hard to take cheer from this, as we are trapped in these upper levels with surges of magic scything through them at random intervals.", TALKVOLUME_TALK)));
         DelayCommand(523.0, (ApplyEffectToObject(DURATION_TYPE_INSTANT, eBard, oHaellech)));
         DelayCommand(525.0, AssignCommand(oHaellech, SpeakString("The real Xothor cannot defeat Mallechenith while the obsidious columns suck the power from us, or, worse, strike us down.  They cannot even defeat him after, perhaps, though that does not stop them from concentrating on trying to rid the Halls of the obsidious material.  Only then can the battle be won or lost for all time.  They will bring the Halls down upon themselves before ceding this once holy place to the demon god.", TALKVOLUME_TALK)));
         DelayCommand(536.0, (ApplyEffectToObject(DURATION_TYPE_INSTANT, eBard, oHaellech)));
         DelayCommand(540.0, AssignCommand(oHaellech, SpeakString("They have created this.  *Lifts a silver horn in his hand*  The crystal, like all crystals, may shatter, like a singer shattering a tavern window with a long, sustained and well trained note.  They have used it already to clear the upper levels, though not to venture down to the arch itself, where Mallechenith waits.  For that they are creating a vastly more powerful instrument of music, a gong that will shake the foundations of the mountains and destroy anything created of this material.", TALKVOLUME_TALK)));
         DelayCommand(553.0, (ApplyEffectToObject(DURATION_TYPE_INSTANT, eBard, oHaellech)));
         DelayCommand(555.0, AssignCommand(oHaellech, SpeakString("I will not see that, however.  The front doors are guarded by Mallechenith and his horde of undead, but a back door may exist.  The crystals thrusting up through the floor from the pits below have cracked a wall asunder and through it have wandered myconids of late, peaceful creatures who may not even comprehend the horrors that strike them down immediately.  Perhaps a great communicator such as I can convince them to help.  Perhaps they know a way out.", TALKVOLUME_TALK)));
         DelayCommand(568.0, (ApplyEffectToObject(DURATION_TYPE_INSTANT, eBard, oHaellech)));
         DelayCommand(570.0, AssignCommand(oHaellech, SpeakString("I am to take the horn and some of the smallest seeds of crystal for study and try to sneak through for aid from the great dwarven citadels.  *Softly*  I suspect the Xothor merely pity me and allow me to flee while they fight on, and I, the coward, accept.  They will fight a diversion as I flee, collapsing the Great Doors themselves on the heads of the undead, sealing themselves in.  Victory or death.", TALKVOLUME_TALK)));
         DelayCommand(583.0, (ApplyEffectToObject(DURATION_TYPE_INSTANT, eBard, oHaellech)));
         DelayCommand(585.0, AssignCommand(oHaellech, SpeakString("*Glances back*  The time comes. I will play this horn as never has bard played before, and I pray to Dugmaren that the first sound you heard upon entering here was the echo of its larger cousin, and that I, among you, hear it too.  Praise be to Dugmaren.", TALKVOLUME_TALK)));
         AssignCommand(oMirror, DelayCommand(590.0, SpeakString("*The images in the mirror fade, and reflect only the room around you.", TALKVOLUME_TALK)));
         DestroyObject(oHaellech, 591.0);
		 
		 DelayCommand(590.0, AssignCommand(oProfTra, ActionJumpToLocation(GetLocation(oExit))));
         DelayCommand(591.0, AssignCommand(oProfEvo, ActionJumpToLocation(GetLocation(oExit))));
         AssignCommand(oProfTra, DelayCommand(592.0, SpeakString("Poor Haellech. His body was found freeze dried on the slopes of the Nether Mountains, not far from the 'back door' of the Halls. *Shakes head* He never made it, but those who found him found the way in, and the lost Halls of Artifice, thanks to him.  A little bit later we had quite an exciting first Dean's Exam to recover some of the artefacts, this among them.  *Pats the mirror.* Our current proctors were all survivors of that quest. *Cheerfully*", TALKVOLUME_TALK)));
         DelayCommand(594.0, AssignCommand(oProfTra, ActionJumpToLocation(GetLocation(oExit))));
         AssignCommand(oProfTra, DelayCommand(605.0, SpeakString("Well done, Arky!  *Claps Arcadavera on his back.*", TALKVOLUME_TALK)));
         DelayCommand(609.0, AssignCommand(oProfEvo, ActionJumpToLocation(GetLocation(oExit))));
         AssignCommand(oProfEvo, DelayCommand(610.0, SpeakString("Did you see them engender? Fabulous! Wondrous! An emphatic YES on the spontaneous manipulation of carboniferous lattice! Eh, eh? *Shouting and gesturing, he vanishes.*", TALKVOLUME_TALK)));
         DestroyObject(oProfEvo, 611.0);
         DelayCommand(620.0, AssignCommand(oProfTra, ActionJumpToLocation(GetLocation(oExit))));
         AssignCommand(oProfTra, DelayCommand(621.0, SpeakString("*Chuckles* Well, you certainly endeared yourself to Arky, I would say. And I would say you earned this temporal stasis resonance circuit, also. How fitting that we derived it from study of this very mirror. Take it to Imogene and she'll give you a keyword, if I recall how this exam goes.", TALKVOLUME_TALK)));
         DelayCommand(625.0, ActionCreateItemOnObjectWyn("slv_deandragon_t_tsrc", oUser, 1));
		 if(ACR_RetrieveQuestState("slv_deandragon_t", oUser) ==1)
		 	{DelayCommand(626.0, ACR_AddPersistentJournalQuestEntry("slv_deandragon_t", 2, oUser, FALSE, FALSE, FALSE, 0));
			}
		 DelayCommand(633.0, AssignCommand(oProfTra, ActionJumpToLocation(GetLocation(oExit))));
         AssignCommand(oProfTra, DelayCommand(635.0, SpeakString("Now, if you'll excuse me, I'd best take the mirror and go see what epiphany Arky has had. *Vanishes*", TALKVOLUME_TALK)));
         DestroyObject(oProfTra, 640.0);
         DestroyObject(oMirror, 641.0);
         }
	*/
		
	//deandragon_x floating gem
   if(GetTag(OBJECT_SELF) == "slv_deandragon_x_gem_plc")
	   	{object oGemItem = CreateItemOnObject("slv_deandragon_x_gem", GetPlaceableLastClickedBy(), 1);
		 DestroyObject(OBJECT_SELF);
		}

		
	//deandragon_Z crystal ball
   if((GetTag(OBJECT_SELF) == "slv_maze_crystal") && (ACR_RetrieveQuestState("slv_deandragon_z", GetLastUsedBy()) == 2))
      	{ActionSpeakString("Congratulations! *Dean Vihuel's voice* You have successfully marched to the end of the research stage of your campaign for knowledge.", TALKVOLUME_TALK);
		 DelayCommand(10.0, ActionSpeakString("As you are standing here, you have worked out the complete key phrase that you are to give to the gatekeeper. When you have provided it to her, she will summon her rocky steed to carry you further.", TALKVOLUME_TALK));
		 DelayCommand(20.0, ActionSpeakString("You may march on now in Oghma's vanguard to the fieldwork stage of your quest, or you may provision and seek your own way to the gatekeeper at a later time.", TALKVOLUME_TALK));
		 DelayCommand(30.0, ActionSpeakString("It is Occidian we seek, of course, and the Elestar Patterns. Both have waited long enough and may wait a little longer, despite an old man's growing excitement.", TALKVOLUME_TALK));
		 DelayCommand(40.0, ActionSpeakString("The end of decades of preparation is in sight. The final step has been assembling the right crew of scholars to assist in this triumph, and you have proven yourself, finding your way through the same maze of clues and false paths that I have followed for so long.", TALKVOLUME_TALK));
		 DelayCommand(50.0, ActionSpeakString("The moment I see you set out, I shall go ahead of you, and be there to greet you. Until then, know that I still work on final details. Avaunt and awake, troops, for tomorrow we charge the barricades of ignorance!", TALKVOLUME_TALK));
		 DelayCommand(50.0, ACR_AddPersistentJournalQuestEntry("slv_deandragon_z", 3,GetLastUsedBy(),  FALSE, FALSE, FALSE, FALSE));
		}

}