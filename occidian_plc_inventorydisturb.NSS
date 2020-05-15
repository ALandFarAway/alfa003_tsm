//Wynna September 2009


#include "acr_placeable_i"

void main()
{
	ACR_PlaceableOnDisturbed();
    object oItem = GetInventoryDisturbItem();
	object oUser = GetLastDisturbed();
		
	
		 
if((GetTag(OBJECT_SELF) == "slv_plc_xorn_hole") && (GetInventoryDisturbType() == 0))
		{string sInedible = "That item is inedible and will not count towards payment.";
		 string sEdible = "That item is edible.";
		 string sTainted = "That item is tainted by organic substances and the ratio of nourishment to waste is too low. It will count only half its weight towards payment.";
		 string sEat = sInedible;
		 object oMyTrigger = GetLocalObject(OBJECT_SELF, "XornTrigger");
			 if(oMyTrigger == OBJECT_INVALID)
			 	{oMyTrigger = GetObjectByTag("slv_deandragon_x_xorn");
				 SetLocalObject(OBJECT_SELF, "oMyTrigger", oMyTrigger);
				 }
		 object oXorn = GetLocalObject(oMyTrigger, "oXorn");
		 int iTotalWeight;
		 int iWeight;
		 int nBaseItem = GetBaseItemType(oItem);
		 if((nBaseItem == BASE_ITEM_ARROW) || (nBaseItem == BASE_ITEM_BOLT) ||(nBaseItem ==  BASE_ITEM_CLUB) || (nBaseItem == BASE_ITEM_DART) || (nBaseItem == BASE_ITEM_ENCHANTED_POTION) || (nBaseItem == BASE_ITEM_GREATCLUB) || (nBaseItem == BASE_ITEM_GRENADE)
		 	 || (nBaseItem == BASE_ITEM_HEAVYCROSSBOW)  || (nBaseItem == BASE_ITEM_LARGEBOX)  ||(nBaseItem ==  BASE_ITEM_LIGHTCROSSBOW)  || (nBaseItem == BASE_ITEM_LONGBOW)  || (nBaseItem == BASE_ITEM_POTIONS)  || (nBaseItem == BASE_ITEM_SHORTBOW)
			  || (nBaseItem == BASE_ITEM_SHORTSPEAR)  || (nBaseItem == BASE_ITEM_SPEAR))
		 	{iWeight = FloatToInt(IntToFloat(GetWeight(oItem)) * 0.5);
			 sEat = sTainted;
			 }
		 
		 if((nBaseItem == BASE_ITEM_AMULET) || (nBaseItem == BASE_ITEM_ARMOR ) || (nBaseItem ==  BASE_ITEM_BASTARDSWORD ) || (nBaseItem ==  BASE_ITEM_BATTLEAXE ) || (nBaseItem ==  BASE_ITEM_BULLET ) || (nBaseItem ==  BASE_ITEM_CGIANT_AXE ) || (nBaseItem ==  BASE_ITEM_CGIANT_SWORD ) || (nBaseItem ==  BASE_ITEM_DAGGER)
		 		  || (nBaseItem ==  BASE_ITEM_DIREMACE ) || (nBaseItem ==  BASE_ITEM_DOUBLEAXE ) || (nBaseItem ==  BASE_ITEM_DWARVENWARAXE ) || (nBaseItem ==  BASE_ITEM_FALCHION ) || (nBaseItem ==  BASE_ITEM_FLAIL ) || (nBaseItem ==  BASE_ITEM_GEM ) || (nBaseItem ==  BASE_ITEM_GOLD ) || (nBaseItem ==  BASE_ITEM_GREATAXE ) || (nBaseItem ==  BASE_ITEM_GREATSWORD ) || (nBaseItem ==  BASE_ITEM_HALBERD)
				   || (nBaseItem ==  BASE_ITEM_HANDAXE ) || (nBaseItem ==  BASE_ITEM_HEAVYFLAIL ) || (nBaseItem ==  BASE_ITEM_HELMET ) || (nBaseItem ==  BASE_ITEM_KAMA ) || (nBaseItem ==  BASE_ITEM_KATANA ) || (nBaseItem ==  BASE_ITEM_KEY ) || (nBaseItem ==  BASE_ITEM_KUKRI ) || (nBaseItem ==  BASE_ITEM_LARGESHIELD ) || (nBaseItem ==  BASE_ITEM_LIGHTFLAIL  ) || (nBaseItem ==  BASE_ITEM_LIGHTHAMMER)
				    || (nBaseItem ==  BASE_ITEM_LIGHTMACE ) || (nBaseItem ==  BASE_ITEM_LONGSWORD ) || (nBaseItem ==  BASE_ITEM_MACE ) || (nBaseItem ==  BASE_ITEM_MORNINGSTAR ) || (nBaseItem ==  BASE_ITEM_RAPIER ) || (nBaseItem ==  BASE_ITEM_RING ) || (nBaseItem ==  BASE_ITEM_SCIMITAR ) || (nBaseItem ==  BASE_ITEM_SCYTHE ) || (nBaseItem ==  BASE_ITEM_SHORTSWORD)
				     || (nBaseItem ==  BASE_ITEM_SHURIKEN ) || (nBaseItem ==  BASE_ITEM_SICKLE ) || (nBaseItem ==  BASE_ITEM_SMALLSHIELD ) || (nBaseItem ==  BASE_ITEM_THROWINGAXE ) || (nBaseItem ==  BASE_ITEM_TOWERSHIELD ) || (nBaseItem ==  BASE_ITEM_TWOBLADEDSWORD ) || (nBaseItem ==  BASE_ITEM_WARHAMMER ) || (nBaseItem ==  BASE_ITEM_WARMACE))
		 	{iWeight = GetWeight(oItem);
			 sEat = sEdible;
			}
		 
		 if((FindSubString(GetName(oItem), "Bell") != -1) || (FindSubString(GetName(oItem), "Block and Tackle") != -1)  || (FindSubString(GetName(oItem), "Chain") != -1)  || (FindSubString(GetName(oItem), "Crowbar") != -1) || (FindSubString(GetName(oItem), "Fishhook") != -1)  
			 || (FindSubString(GetName(oItem), "Flask") != -1) || (FindSubString(GetName(oItem), "Flint and Steel") != -1)  || (FindSubString(GetName(oItem), "Grappling Hook") != -1)  || (FindSubString(GetName(oItem), "Hammer") != -1)  || (FindSubString(GetName(oItem), "Lantern") != -1)
			  || (FindSubString(GetName(oItem), "Lock") != -1)   || (FindSubString(GetName(oItem), "Manacles") != -1)  || (FindSubString(GetName(oItem), "Mirror") != -1)  || (FindSubString(GetName(oItem), "Oil") != -1)  || (FindSubString(GetName(oItem), "Piton") != -1)
			   || (FindSubString(GetName(oItem), "Pot,") != -1)   || (FindSubString(GetName(oItem), "Ram,") != -1)  || (FindSubString(GetName(oItem), "Needle") != -1)  || (FindSubString(GetName(oItem), "Shovel") != -1) || (FindSubString(GetName(oItem), "Whistle") != -1)  
				 || (FindSubString(GetName(oItem), "Metal") != -1)  || (FindSubString(GetName(oItem), "Stone") != -1)  || (FindSubString(GetName(oItem), "Whetstone") != -1) 
				  || (FindSubString(GetName(oItem), "Gold") != -1) || (FindSubString(GetName(oItem), "Copper") != -1)|| (FindSubString(GetName(oItem), "Silver") != -1)|| (FindSubString(GetName(oItem), "Iron") != -1) || (FindSubString(GetName(oItem), "Steel") != -1)
				  || (FindSubString(GetName(oItem), "Bronze") != -1)  || (FindSubString(GetName(oItem), "Ingot") != -1))  
			{iWeight = GetWeight(oItem);
			 sEat = sEdible;
			 }
		 
		 if((FindSubString(GetName(oItem), "Hide") != -1) || (FindSubString(GetName(oItem), "Leather") != -1) || (FindSubString(GetName(oItem), "Padded") != -1) 
			  || (FindSubString(GetName(oItem), "Cape") != -1) || (FindSubString(GetName(oItem), "Tunic") != -1)	 || (FindSubString(GetName(oItem), "Robes") != -1)  || (FindSubString(GetName(oItem), "clothes") != -1) || (FindSubString(GetName(oItem), "Shirt") != -1) || (FindSubString(GetName(oItem), "Bikini") != -1)
					 || (FindSubString(GetName(oItem), "Dayware") != -1) || (FindSubString(GetName(oItem), "robes") != -1) || (FindSubString(GetName(oItem), "Outfit") != -1) || (FindSubString(GetName(oItem), "shirt") != -1) || (FindSubString(GetName(oItem), "Clothing") != -1) || (FindSubString(GetName(oItem), "Underclothes") != -1)
						 || (FindSubString(GetName(oItem), "Trousers") != -1) || (FindSubString(GetName(oItem), "attire") != -1) || (FindSubString(GetName(oItem), "Dress,") != -1) || (FindSubString(GetName(oItem), "Belt") != -1) || (FindSubString(GetName(oItem), "Garb") != -1) || (FindSubString(GetName(oItem), "Sandal") != -1)
							 || (FindSubString(GetName(oItem), "Vest") != -1) || (FindSubString(GetName(oItem), "Handwraps") != -1) || (FindSubString(GetName(oItem), "Skullcap") != -1) || (FindSubString(GetName(oItem), "Hood") != -1) || (FindSubString(GetName(oItem), "wrappings") != -1) || (FindSubString(GetName(oItem), "Shade") != -1)
							  || (FindSubString(GetName(oItem), "Bandana") != -1) || (FindSubString(GetName(oItem), "Cloth") != -1) || (FindSubString(GetName(oItem), "Blindfold") != -1)  || (FindSubString(GetName(oItem), "Eyepatch") != -1) || (FindSubString(GetName(oItem), "Beret") != -1) || (FindSubString(GetName(oItem), "Eyeglasses") != -1)
							   || (FindSubString(GetName(oItem), "Turban") != -1))
			{
			 sEat = sInedible;
			 iWeight = 0;
			 }
			 	
			 	
		 iTotalWeight = GetLocalInt(OBJECT_SELF, "TotalWeight");;
		 iTotalWeight = iTotalWeight + iWeight;
		 SetLocalInt(OBJECT_SELF, "TotalWeight", iTotalWeight);
		 DestroyInventory(OBJECT_SELF);
			 
		 AssignCommand(oXorn, ActionSpeakString(sEat, TALKVOLUME_TALK));
		 
		 if((iTotalWeight >= 28) && (oXorn != OBJECT_INVALID))	
			 {SetLocalInt(OBJECT_SELF, "TotalWeight", 0);
			 object oXornBodyWP = GetWaypointByTag("xorn_arm_1");
			 	
		if(GetTag(oItem)!="slv_tra200_alloy")
		 	 	{AssignCommand(oXorn, ActionSpeakString("Is not Aurroneous's gift. Bring gift. I will take you.", TALKVOLUME_TALK));
			 	 //CreateObject(OBJECT_TYPE_ITEM, "slv_deansphinx_x_essence", GetLocation(OBJECT_SELF));
				}
					 
			 AssignCommand(oXorn, ActionSpeakString("*Drops away through the stone floor without leaving a mark.", TALKVOLUME_TALK));
			 effect eDust = EffectVisualEffect(VFX_IMP_DUST_EXPLOSION, FALSE);
			 effect eStone = EffectVisualEffect(VFX_COM_CHUNK_STONE_MEDIUM, FALSE);
			 DelayCommand(1.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eDust, GetLocation(oXornBodyWP)));
			 DelayCommand(2.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eStone, GetLocation(oXornBodyWP)));
			 DelayCommand(2.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eDust, GetLocation(oXornBodyWP)));
			 DelayCommand(3.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eStone, GetLocation(oXornBodyWP)));
			 DelayCommand(3.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eDust, GetLocation(oXornBodyWP)));
			 DelayCommand(4.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eStone, GetLocation(oXornBodyWP)));
		 
			 
		if((ACR_RetrieveQuestState("slv_deansphinx_e_earth", oUser) >= 1) || (ACR_RetrieveQuestState("slv_deansphinx_x", oUser) >= 6)|| (ACR_RetrieveQuestState("slv_deansphinx_j", oUser) >= 5))
			 {
			 location lUser = GetLocation(oUser);
			 object oDisgorged = GetLocalObject(OBJECT_SELF, "oDisgorged");
			 if(oDisgorged == OBJECT_INVALID)
			 	{oDisgorged = GetWaypointByTag("xorn_disgorge");
				 SetLocalObject(OBJECT_SELF, "oDisgorged", oDisgorged);
				}
			 object oJorunWP = GetLocalObject(OBJECT_SELF, "oJorunWP");
		 	 if(oJorunWP == OBJECT_INVALID)
				 {oJorunWP = GetWaypointByTag("slv_deandragon_j_jorun_wp");
				  SetLocalObject(OBJECT_SELF, "oJorunWP", oDisgorged);
				}
					
			if(GetTag(oItem)=="slv_tra200_alloy")
		 	 	{oDisgorged = GetWaypointByTag("xorn_disgorge_sundabar");
				 SetLocalObject(OBJECT_SELF, "oDisgorged", oDisgorged);
				 }
			
		    if(ACR_RetrieveQuestState("slv_deandragon_j", oUser) == 5) 
		 	 	{DelayCommand(10.0, ACR_AddPersistentJournalQuestEntry("slv_deandragon_j", 6, oUser, FALSE, FALSE, FALSE, FALSE));
				 object oJorun = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_sundabar_jorun", GetLocation(oJorunWP), FALSE);
				}
				
			if(ACR_RetrieveQuestState("slv_deansphinx_j", oUser) == 6) 
		 	 	{DelayCommand(10.0, ACR_AddPersistentJournalQuestEntry("slv_deansphinx_j", 7, oUser, FALSE, FALSE, FALSE, FALSE));
				 object oJorun = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_sundabar_jorun", GetLocation(oJorunWP), FALSE);
				}
				
			 object oPartyMember=GetFirstFactionMember(oUser);
			 effect eParalyze = EffectParalyze();
				 while(oPartyMember!=OBJECT_INVALID)
				 {if(ACR_RetrieveQuestState("slv_deandragon_j", oPartyMember) != 0) 
		 	 		{DelayCommand(10.0, ACR_AddPersistentJournalQuestEntry("slv_deandragon_j", 6, oPartyMember, FALSE, FALSE, FALSE, FALSE));
					}
				 if(ACR_RetrieveQuestState("slv_deansphinx_j", oPartyMember) != 0) 
		 	 		{DelayCommand(10.0, ACR_AddPersistentJournalQuestEntry("slv_deansphinx_j", 7, oPartyMember, FALSE, FALSE, FALSE, FALSE));
					}
				 ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eDust, GetLocation(oPartyMember));
				 ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eStone, GetLocation(oPartyMember));
				 DelayCommand(7.0, SendMessageToPC(oPartyMember, "You have been swallowed by a Xorn! Rock presses you from all sides. You cannot breath, nor even expand your ribcage. It is exactly like being buried alive."));
				 DelayCommand(10.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eDust, GetLocation(oPartyMember)));
				 DelayCommand(10.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eStone, GetLocation(oPartyMember)));
				 DelayCommand(12.0, AssignCommand(oPartyMember, ActionJumpToLocation(GetLocation(oDisgorged))));
				 DelayCommand(30.0, SendMessageToPC(oPartyMember, "*Disgorges you in a cloud of dust and clods of dirt. It drops away from around you and is gone through the stone without leaving a trace."));
				 DelayCommand(35.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eDust, GetLocation(oDisgorged)));
				 DelayCommand(35.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eStone, GetLocation(oDisgorged)));
				 oPartyMember=GetNextFactionMember(oUser);
				 }
				 
				 ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eDust, GetLocation(oUser));
				 ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eStone, GetLocation(oUser));
				 object oXornEaten = CreateObject(OBJECT_TYPE_PLACEABLE, "003_plc_xorn_body", GetLocation(oDisgorged));
				 object oXornEater = CreateObject(OBJECT_TYPE_PLACEABLE, "003_plc_xorn_body", lUser);
				 DelayCommand(1.0, AssignCommand(oXornEater, ActionSpeakString("*Erupts from the ground and engulfs the party whole! All limbs and eyes have merged with the body to create a smooth, frictionless surface.", TALKVOLUME_TALK)));
				 DelayCommand(7.0, SendMessageToPC(oUser, "You have been swallowed by a Xorn! Rock presses you from all sides. You cannot breath, nor even expand your ribcage. It is exactly like being buried alive."));
				 DelayCommand(10.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eDust, GetLocation(oUser)));
				 DelayCommand(10.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eStone, GetLocation(oUser)));
				 DelayCommand(10.0, AssignCommand(oXorn, ActionJumpToLocation(GetLocation(oDisgorged))));
				 DelayCommand(12.0, AssignCommand(oUser, ActionJumpToLocation(GetLocation(oDisgorged))));
				 DelayCommand(30.0, AssignCommand(oXornEaten, ActionSpeakString("*Disgorges its passenger in a cloud of dust and clods of dirt. It drops away from around " + GetName(oUser), TALKVOLUME_TALK)));
				 DestroyObject(oXornEater, 30.0);
				 DestroyObject(oXorn, 35.0);
				 DestroyObject(oXornEaten, 35.0);
				 DelayCommand(26.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eDust, GetLocation(oDisgorged)));
				 DelayCommand(26.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eStone, GetLocation(oDisgorged)));
				 DelayCommand(35.0, AssignCommand(oXorn, ActionJumpToLocation(GetLocation(oXornBodyWP))));
				 DelayCommand(28.0, SetLocalInt(oMyTrigger, "Xorn", 0));
				 //DelayCommand(40.0, SendMessageToPC(oUser, "You travelled for what seemed an eternity and might have been fifteen minutes, but have no idea how far you have come."));
				 }
			
			 }
		 
		}
		
if(((GetTag(OBJECT_SELF) == "slv_plc_xorn_hole_low_in") && (GetInventoryDisturbType() == 0)) && ((GetIsPC(oUser)) || (GetIsDMPossessed(oUser))))
		{string sInedible = "That item is inedible and will not count towards payment.";
		 string sEdible = "That item is edible.";
		 string sTainted = "That item is tainted by organic substances and the ratio of nourishment to waste is too low. It will count only half its weight towards payment.";
		 string sEat = sInedible;
		 object oXornArm1WP = GetWaypointByTag("xorn_arm_1_low_in");
		 object oXornArm1 = GetNearestObjectByTag("003_cr_xorn_arm_1_low_in", oXornArm1WP);
		 int iTotalWeight;
		 int iWeight;
		 int nBaseItem = GetBaseItemType(oItem);
		 if((nBaseItem == BASE_ITEM_ARROW) || (nBaseItem == BASE_ITEM_BOLT) ||(nBaseItem ==  BASE_ITEM_CLUB) || (nBaseItem == BASE_ITEM_DART) || (nBaseItem == BASE_ITEM_ENCHANTED_POTION) || (nBaseItem == BASE_ITEM_GREATCLUB) || (nBaseItem == BASE_ITEM_GRENADE)
		 	 || (nBaseItem == BASE_ITEM_HEAVYCROSSBOW)  || (nBaseItem == BASE_ITEM_LARGEBOX)  ||(nBaseItem ==  BASE_ITEM_LIGHTCROSSBOW)  || (nBaseItem == BASE_ITEM_LONGBOW)  || (nBaseItem == BASE_ITEM_POTIONS)  || (nBaseItem == BASE_ITEM_SHORTBOW)
			  || (nBaseItem == BASE_ITEM_SHORTSPEAR)  || (nBaseItem == BASE_ITEM_SPEAR))
		 	{iWeight = FloatToInt(IntToFloat(GetWeight(oItem)) * 0.5);
			 sEat = sTainted;
			  }
		 
		 if((nBaseItem == BASE_ITEM_AMULET) || (nBaseItem == BASE_ITEM_ARMOR ) || (nBaseItem ==  BASE_ITEM_BASTARDSWORD ) || (nBaseItem ==  BASE_ITEM_BATTLEAXE ) || (nBaseItem ==  BASE_ITEM_BULLET ) || (nBaseItem ==  BASE_ITEM_CGIANT_AXE ) || (nBaseItem ==  BASE_ITEM_CGIANT_SWORD ) || (nBaseItem ==  BASE_ITEM_DAGGER)
		 		  || (nBaseItem ==  BASE_ITEM_DIREMACE ) || (nBaseItem ==  BASE_ITEM_DOUBLEAXE ) || (nBaseItem ==  BASE_ITEM_DWARVENWARAXE ) || (nBaseItem ==  BASE_ITEM_FALCHION ) || (nBaseItem ==  BASE_ITEM_FLAIL ) || (nBaseItem ==  BASE_ITEM_GEM ) || (nBaseItem ==  BASE_ITEM_GOLD ) || (nBaseItem ==  BASE_ITEM_GREATAXE ) || (nBaseItem ==  BASE_ITEM_GREATSWORD ) || (nBaseItem ==  BASE_ITEM_HALBERD)
				   || (nBaseItem ==  BASE_ITEM_HANDAXE ) || (nBaseItem ==  BASE_ITEM_HEAVYFLAIL ) || (nBaseItem ==  BASE_ITEM_HELMET ) || (nBaseItem ==  BASE_ITEM_KAMA ) || (nBaseItem ==  BASE_ITEM_KATANA ) || (nBaseItem ==  BASE_ITEM_KEY ) || (nBaseItem ==  BASE_ITEM_KUKRI ) || (nBaseItem ==  BASE_ITEM_LARGESHIELD ) || (nBaseItem ==  BASE_ITEM_LIGHTFLAIL  ) || (nBaseItem ==  BASE_ITEM_LIGHTHAMMER)
				    || (nBaseItem ==  BASE_ITEM_LIGHTMACE ) || (nBaseItem ==  BASE_ITEM_LONGSWORD ) || (nBaseItem ==  BASE_ITEM_MACE ) || (nBaseItem ==  BASE_ITEM_MORNINGSTAR ) || (nBaseItem ==  BASE_ITEM_RAPIER ) || (nBaseItem ==  BASE_ITEM_RING ) || (nBaseItem ==  BASE_ITEM_SCIMITAR ) || (nBaseItem ==  BASE_ITEM_SCYTHE ) || (nBaseItem ==  BASE_ITEM_SHORTSWORD)
				     || (nBaseItem ==  BASE_ITEM_SHURIKEN ) || (nBaseItem ==  BASE_ITEM_SICKLE ) || (nBaseItem ==  BASE_ITEM_SMALLSHIELD ) || (nBaseItem ==  BASE_ITEM_THROWINGAXE ) || (nBaseItem ==  BASE_ITEM_TOWERSHIELD ) || (nBaseItem ==  BASE_ITEM_TWOBLADEDSWORD ) || (nBaseItem ==  BASE_ITEM_WARHAMMER ) || (nBaseItem ==  BASE_ITEM_WARMACE))
		 	{iWeight = GetWeight(oItem);
			 sEat = sEdible;
			 }
		 
		 if((FindSubString(GetName(oItem), "Bell") != -1) || (FindSubString(GetName(oItem), "Block and Tackle") != -1)  || (FindSubString(GetName(oItem), "Chain") != -1)  || (FindSubString(GetName(oItem), "Crowbar") != -1) || (FindSubString(GetName(oItem), "Fishhook") != -1)  
			 || (FindSubString(GetName(oItem), "Flask") != -1) || (FindSubString(GetName(oItem), "Flint and Steel") != -1)  || (FindSubString(GetName(oItem), "Grappling Hook") != -1)  || (FindSubString(GetName(oItem), "Hammer") != -1)  || (FindSubString(GetName(oItem), "Lantern") != -1)
			  || (FindSubString(GetName(oItem), "Lock") != -1)   || (FindSubString(GetName(oItem), "Manacles") != -1)  || (FindSubString(GetName(oItem), "Mirror") != -1)  || (FindSubString(GetName(oItem), "Oil") != -1)  || (FindSubString(GetName(oItem), "Piton") != -1)
			   || (FindSubString(GetName(oItem), "Pot,") != -1)   || (FindSubString(GetName(oItem), "Ram,") != -1)  || (FindSubString(GetName(oItem), "Needle") != -1)  || (FindSubString(GetName(oItem), "Shovel") != -1) || (FindSubString(GetName(oItem), "Whistle") != -1)  
				 || (FindSubString(GetName(oItem), "Metal") != -1)  || (FindSubString(GetName(oItem), "Stone") != -1)  || (FindSubString(GetName(oItem), "Whetstone") != -1) 
				  || (FindSubString(GetName(oItem), "Gold") != -1) || (FindSubString(GetName(oItem), "Copper") != -1)|| (FindSubString(GetName(oItem), "Silver") != -1)|| (FindSubString(GetName(oItem), "Iron") != -1) || (FindSubString(GetName(oItem), "Steel") != -1)
				  || (FindSubString(GetName(oItem), "Bronze") != -1)  || (FindSubString(GetName(oItem), "Bone") != -1))  
			{iWeight = GetWeight(oItem);
			 sEat = sEdible;
			 }
		 
		 if((FindSubString(GetName(oItem), "Hide") != -1) || (FindSubString(GetName(oItem), "Leather") != -1) || (FindSubString(GetName(oItem), "Padded") != -1) 
			  || (FindSubString(GetName(oItem), "Cape") != -1) || (FindSubString(GetName(oItem), "Tunic") != -1)	 || (FindSubString(GetName(oItem), "Robes") != -1)  || (FindSubString(GetName(oItem), "clothes") != -1) || (FindSubString(GetName(oItem), "Shirt") != -1) || (FindSubString(GetName(oItem), "Bikini") != -1)
					 || (FindSubString(GetName(oItem), "Dayware") != -1) || (FindSubString(GetName(oItem), "robes") != -1) || (FindSubString(GetName(oItem), "Outfit") != -1) || (FindSubString(GetName(oItem), "shirt") != -1) || (FindSubString(GetName(oItem), "Clothing") != -1) || (FindSubString(GetName(oItem), "Underclothes") != -1)
						 || (FindSubString(GetName(oItem), "Trousers") != -1) || (FindSubString(GetName(oItem), "attire") != -1) || (FindSubString(GetName(oItem), "Dress,") != -1) || (FindSubString(GetName(oItem), "Belt") != -1) || (FindSubString(GetName(oItem), "Garb") != -1) || (FindSubString(GetName(oItem), "Sandal") != -1)
							 || (FindSubString(GetName(oItem), "Vest") != -1) || (FindSubString(GetName(oItem), "Handwraps") != -1) || (FindSubString(GetName(oItem), "Skullcap") != -1) || (FindSubString(GetName(oItem), "Hood") != -1) || (FindSubString(GetName(oItem), "wrappings") != -1) || (FindSubString(GetName(oItem), "Shade") != -1)
							  || (FindSubString(GetName(oItem), "Bandana") != -1) || (FindSubString(GetName(oItem), "Cloth") != -1) || (FindSubString(GetName(oItem), "Blindfold") != -1)  || (FindSubString(GetName(oItem), "Eyepatch") != -1) || (FindSubString(GetName(oItem), "Beret") != -1) || (FindSubString(GetName(oItem), "Eyeglasses") != -1)
							   || (FindSubString(GetName(oItem), "Turban") != -1))
			{
			 sEat = sInedible;
			 iWeight = 0;
			 }
			 	
			 	
		 iTotalWeight = GetLocalInt(OBJECT_SELF, "TotalWeight");;
		 iTotalWeight = iTotalWeight + iWeight;
		 SetLocalInt(OBJECT_SELF, "TotalWeight", iTotalWeight);
		 DestroyInventory(OBJECT_SELF);
			 
		 AssignCommand(oXornArm1, ActionSpeakString(sEat, TALKVOLUME_TALK));
		 AssignCommand(oXornArm1, ActionSpeakString(IntToString(iTotalWeight) + " of your pounds.", TALKVOLUME_TALK));
		 
		 if((iTotalWeight >= 70) && (oXornArm1 != OBJECT_INVALID))	
			 {SetLocalInt(OBJECT_SELF, "TotalWeight", 0);
			  object oMyTrigger = GetLocalObject(OBJECT_SELF, "XornTrigger");
			 if(oMyTrigger == OBJECT_INVALID)
			 	{oMyTrigger = GetObjectByTag("occ_xorn_low_in");
				 SetLocalObject(OBJECT_SELF, "oMyTrigger", oMyTrigger);
				 }
			 object oXornCrownWP = GetWaypointByTag("xorn_crown_low_in");
			 object oXornBodyWP = GetWaypointByTag("xorn_body_low_in");
			 object oXornArm2WP = GetWaypointByTag("xorn_arm_2_low_in");
			 object oXornArm3WP = GetWaypointByTag("xorn_arm_3_low_in");
			 object oXornEye2WP = GetWaypointByTag("xorn_eye_2_low_in");
			 object oXornEye3WP = GetWaypointByTag("xorn_eye_3_low_in");
			 object oXornEye4WP = GetWaypointByTag("xorn_eye_4_low_in");
			 object oXornEye5WP = GetWaypointByTag("xorn_eye_5_low_in");
			 object oXornEye6WP = GetWaypointByTag("xorn_eye_6_low_in");
					 
			 object oXornBody = GetNearestObjectByTag("003_plc_xorn_body_low_in", oXornBodyWP);
			 object oXornCrown = GetNearestObjectByTag("003_plc_xorn_crown_low_in", oXornCrownWP);
			 object oXornArm2 = GetNearestObjectByTag("003_cr_xorn_arm_2_low_in", oXornArm2WP);
			 object oXornArm3 = GetNearestObjectByTag("003_cr_xorn_arm_3_low_in", oXornArm3WP);
			 object oXornEye2 = GetNearestObjectByTag("003_plc_xorn_eyes_2_low_in", oXornEye2WP);
			 object oXornEye3 = GetNearestObjectByTag("003_plc_xorn_eyes_3_low_in", oXornEye3WP);
			 object oXornEye4 = GetNearestObjectByTag("003_plc_xorn_eyes_4_low_in", oXornEye4WP);
			 object oXornEye5 = GetNearestObjectByTag("003_plc_xorn_eyes_5_low_in", oXornEye5WP);
			 object oXornEye6 = GetNearestObjectByTag("003_plc_xorn_eyes_6_low_in", oXornEye6WP);
					 
			 AssignCommand(oXornArm1, ActionSpeakString("*Drops away through the stone floor without leaving a mark.", TALKVOLUME_TALK));
			 effect eDust = EffectVisualEffect(VFX_IMP_DUST_EXPLOSION, FALSE);
			 effect eStone = EffectVisualEffect(VFX_COM_CHUNK_STONE_MEDIUM, FALSE);
			 DelayCommand(1.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eDust, GetLocation(oXornArm1)));
			 DelayCommand(2.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eStone, GetLocation(oXornArm1)));
			 DelayCommand(2.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eDust, GetLocation(oXornArm2)));
			 DelayCommand(3.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eStone, GetLocation(oXornArm2)));
			 DelayCommand(3.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eDust, GetLocation(oXornArm3)));
			 DelayCommand(4.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eStone, GetLocation(oXornArm3)));
			 
			 DestroyObject(oXornBody, 1.0);
			 DestroyObject(oXornCrown, 1.0);
			 DestroyObject(oXornArm1, 1.0);
			 DestroyObject(oXornArm2, 1.0);
			 DestroyObject(oXornArm3, 1.0);
			 DestroyObject(oXornEye2, 1.0);
			 DestroyObject(oXornEye3, 1.0);
			 DestroyObject(oXornEye4, 1.0);
			 DestroyObject(oXornEye5, 1.0);
			 DestroyObject(oXornEye6, 1.0);
			 
			 
			 location lUser = GetLocation(oUser);
			 object oDisgorged = GetLocalObject(OBJECT_SELF, "oDisgorged");
			 if(oDisgorged == OBJECT_INVALID)
			 	{oDisgorged = GetWaypointByTag("xorn_disgorge_low_in");
				 SetLocalObject(OBJECT_SELF, "oDisgorged", oDisgorged);
				}
			 effect eParalyze = EffectParalyze();
			 ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eDust, GetLocation(oUser));
			 ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eStone, GetLocation(oUser));
			 DelayCommand(4.0, JumpPartyToArea(oUser, oDisgorged));
			 object oXornEaten = CreateObject(OBJECT_TYPE_PLACEABLE, "003_plc_xorn_body", GetLocation(oDisgorged));
			 object oPartyMember = GetFirstFactionMember(oUser);
			 while(oPartyMember != OBJECT_INVALID)
				 {object oXornEater = CreateObject(OBJECT_TYPE_PLACEABLE, "003_plc_xorn_body", GetLocation(oPartyMember));
				 DelayCommand(1.0, AssignCommand(oXornEater, ActionSpeakString("*Erupts from the ground and engulfs " + GetName(oUser) + " whole! All limbs and eyes have merged with the body to create a smooth, frictionless surface.", TALKVOLUME_TALK)));
				 DelayCommand(1.5, SendMessageToPC(oPartyMember, "You have been swallowed by a Xorn! Rock presses you from all sides. You cannot breath, nor even expand your ribcage. It is exactly like being buried alive."));
				 DelayCommand(25.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eDust, GetLocation(oPartyMember)));
				 DelayCommand(25.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eStone, GetLocation(oPartyMember)));
				 DestroyObject(oXornEater, 25.0);
				 DelayCommand(25.0, AssignCommand(oXornEaten, ActionSpeakString("*Disgorges its passenger in a cloud of dust and clods of dirt. It drops away from around " + GetName(oUser), TALKVOLUME_TALK)));
				 DestroyObject(oXornEaten, 25.0);
				 DelayCommand(27.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eDust, GetLocation(oDisgorged)));
				 DelayCommand(27.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eStone, GetLocation(oDisgorged)));
				 oPartyMember = GetNextFactionMember(oUser);
			 }
			 
			 
			 DelayCommand(5.0, SetLocalInt(oMyTrigger, "Xorn", 0));
			 
			 
			 }
		 
		}
		
if(((GetTag(OBJECT_SELF) == "xorn_hole_low_out") && (GetInventoryDisturbType() == 0)) && ((GetIsPC(oUser)) || (GetIsDMPossessed(oUser))))
		{string sInedible = "That item is inedible and will not count towards payment.";
		 string sEdible = "That item is edible.";
		 string sTainted = "That item is tainted by organic substances and the ratio of nourishment to waste is too low. It will count only half its weight towards payment.";
		 string sEat = sInedible;
		 object oXornArm1WP = GetWaypointByTag("xorn_arm_1_low_out");
		 object oXornArm1 = GetNearestObjectByTag("003_cr_xorn_arm_1_low_out", oXornArm1WP);
		 int iTotalWeight;
		 int iWeight;
		 int nBaseItem = GetBaseItemType(oItem);
		 if((nBaseItem == BASE_ITEM_ARROW) || (nBaseItem == BASE_ITEM_BOLT) ||(nBaseItem ==  BASE_ITEM_CLUB) || (nBaseItem == BASE_ITEM_DART) || (nBaseItem == BASE_ITEM_ENCHANTED_POTION) || (nBaseItem == BASE_ITEM_GREATCLUB) || (nBaseItem == BASE_ITEM_GRENADE)
		 	 || (nBaseItem == BASE_ITEM_HEAVYCROSSBOW)  || (nBaseItem == BASE_ITEM_LARGEBOX)  ||(nBaseItem ==  BASE_ITEM_LIGHTCROSSBOW)  || (nBaseItem == BASE_ITEM_LONGBOW)  || (nBaseItem == BASE_ITEM_POTIONS)  || (nBaseItem == BASE_ITEM_SHORTBOW)
			  || (nBaseItem == BASE_ITEM_SHORTSPEAR)  || (nBaseItem == BASE_ITEM_SPEAR))
		 	{iWeight = FloatToInt(IntToFloat(GetWeight(oItem)) * 0.5);
			 sEat = sTainted;
			 SendMessageToPC(oUser, "1");
			 }
		 
		 if((nBaseItem == BASE_ITEM_AMULET) || (nBaseItem == BASE_ITEM_ARMOR ) || (nBaseItem ==  BASE_ITEM_BASTARDSWORD ) || (nBaseItem ==  BASE_ITEM_BATTLEAXE ) || (nBaseItem ==  BASE_ITEM_BULLET ) || (nBaseItem ==  BASE_ITEM_CGIANT_AXE ) || (nBaseItem ==  BASE_ITEM_CGIANT_SWORD ) || (nBaseItem ==  BASE_ITEM_DAGGER)
		 		  || (nBaseItem ==  BASE_ITEM_DIREMACE ) || (nBaseItem ==  BASE_ITEM_DOUBLEAXE ) || (nBaseItem ==  BASE_ITEM_DWARVENWARAXE ) || (nBaseItem ==  BASE_ITEM_FALCHION ) || (nBaseItem ==  BASE_ITEM_FLAIL ) || (nBaseItem ==  BASE_ITEM_GEM ) || (nBaseItem ==  BASE_ITEM_GOLD ) || (nBaseItem ==  BASE_ITEM_GREATAXE ) || (nBaseItem ==  BASE_ITEM_GREATSWORD ) || (nBaseItem ==  BASE_ITEM_HALBERD)
				   || (nBaseItem ==  BASE_ITEM_HANDAXE ) || (nBaseItem ==  BASE_ITEM_HEAVYFLAIL ) || (nBaseItem ==  BASE_ITEM_HELMET ) || (nBaseItem ==  BASE_ITEM_KAMA ) || (nBaseItem ==  BASE_ITEM_KATANA ) || (nBaseItem ==  BASE_ITEM_KEY ) || (nBaseItem ==  BASE_ITEM_KUKRI ) || (nBaseItem ==  BASE_ITEM_LARGESHIELD ) || (nBaseItem ==  BASE_ITEM_LIGHTFLAIL  ) || (nBaseItem ==  BASE_ITEM_LIGHTHAMMER)
				    || (nBaseItem ==  BASE_ITEM_LIGHTMACE ) || (nBaseItem ==  BASE_ITEM_LONGSWORD ) || (nBaseItem ==  BASE_ITEM_MACE ) || (nBaseItem ==  BASE_ITEM_MORNINGSTAR ) || (nBaseItem ==  BASE_ITEM_RAPIER ) || (nBaseItem ==  BASE_ITEM_RING ) || (nBaseItem ==  BASE_ITEM_SCIMITAR ) || (nBaseItem ==  BASE_ITEM_SCYTHE ) || (nBaseItem ==  BASE_ITEM_SHORTSWORD)
				     || (nBaseItem ==  BASE_ITEM_SHURIKEN ) || (nBaseItem ==  BASE_ITEM_SICKLE ) || (nBaseItem ==  BASE_ITEM_SMALLSHIELD ) || (nBaseItem ==  BASE_ITEM_THROWINGAXE ) || (nBaseItem ==  BASE_ITEM_TOWERSHIELD ) || (nBaseItem ==  BASE_ITEM_TWOBLADEDSWORD ) || (nBaseItem ==  BASE_ITEM_WARHAMMER ) || (nBaseItem ==  BASE_ITEM_WARMACE))
		 	{iWeight = GetWeight(oItem);
			 sEat = sEdible;
			 SendMessageToPC(oUser, "2");
			 }
		 
		 if((FindSubString(GetName(oItem), "Bell") != -1) || (FindSubString(GetName(oItem), "Block and Tackle") != -1)  || (FindSubString(GetName(oItem), "Chain") != -1)  || (FindSubString(GetName(oItem), "Crowbar") != -1) || (FindSubString(GetName(oItem), "Fishhook") != -1)  
			 || (FindSubString(GetName(oItem), "Flask") != -1) || (FindSubString(GetName(oItem), "Flint and Steel") != -1)  || (FindSubString(GetName(oItem), "Grappling Hook") != -1)  || (FindSubString(GetName(oItem), "Hammer") != -1)  || (FindSubString(GetName(oItem), "Lantern") != -1)
			  || (FindSubString(GetName(oItem), "Lock") != -1)   || (FindSubString(GetName(oItem), "Manacles") != -1)  || (FindSubString(GetName(oItem), "Mirror") != -1)  || (FindSubString(GetName(oItem), "Oil") != -1)  || (FindSubString(GetName(oItem), "Piton") != -1)
			   || (FindSubString(GetName(oItem), "Pot,") != -1)   || (FindSubString(GetName(oItem), "Ram,") != -1)  || (FindSubString(GetName(oItem), "Needle") != -1)  || (FindSubString(GetName(oItem), "Shovel") != -1) || (FindSubString(GetName(oItem), "Whistle") != -1)  
				 || (FindSubString(GetName(oItem), "Metal") != -1)  || (FindSubString(GetName(oItem), "Stone") != -1)  || (FindSubString(GetName(oItem), "Whetstone") != -1) 
				  || (FindSubString(GetName(oItem), "Gold") != -1) || (FindSubString(GetName(oItem), "Copper") != -1)|| (FindSubString(GetName(oItem), "Silver") != -1)|| (FindSubString(GetName(oItem), "Iron") != -1) || (FindSubString(GetName(oItem), "Steel") != -1)
				  || (FindSubString(GetName(oItem), "Bronze") != -1)  || (FindSubString(GetName(oItem), "Bone") != -1))  
			{iWeight = GetWeight(oItem);
			 sEat = sEdible;
			 SendMessageToPC(oUser, "3");
			 }
		 
		 if((FindSubString(GetName(oItem), "Hide") != -1) || (FindSubString(GetName(oItem), "Leather") != -1) || (FindSubString(GetName(oItem), "Padded") != -1) 
			  || (FindSubString(GetName(oItem), "Cape") != -1) || (FindSubString(GetName(oItem), "Tunic") != -1)	 || (FindSubString(GetName(oItem), "Robes") != -1)  || (FindSubString(GetName(oItem), "clothes") != -1) || (FindSubString(GetName(oItem), "Shirt") != -1) || (FindSubString(GetName(oItem), "Bikini") != -1)
					 || (FindSubString(GetName(oItem), "Dayware") != -1) || (FindSubString(GetName(oItem), "robes") != -1) || (FindSubString(GetName(oItem), "Outfit") != -1) || (FindSubString(GetName(oItem), "shirt") != -1) || (FindSubString(GetName(oItem), "Clothing") != -1) || (FindSubString(GetName(oItem), "Underclothes") != -1)
						 || (FindSubString(GetName(oItem), "Trousers") != -1) || (FindSubString(GetName(oItem), "attire") != -1) || (FindSubString(GetName(oItem), "Dress,") != -1) || (FindSubString(GetName(oItem), "Belt") != -1) || (FindSubString(GetName(oItem), "Garb") != -1) || (FindSubString(GetName(oItem), "Sandal") != -1)
							 || (FindSubString(GetName(oItem), "Vest") != -1) || (FindSubString(GetName(oItem), "Handwraps") != -1) || (FindSubString(GetName(oItem), "Skullcap") != -1) || (FindSubString(GetName(oItem), "Hood") != -1) || (FindSubString(GetName(oItem), "wrappings") != -1) || (FindSubString(GetName(oItem), "Shade") != -1)
							  || (FindSubString(GetName(oItem), "Bandana") != -1) || (FindSubString(GetName(oItem), "Cloth") != -1) || (FindSubString(GetName(oItem), "Blindfold") != -1)  || (FindSubString(GetName(oItem), "Eyepatch") != -1) || (FindSubString(GetName(oItem), "Beret") != -1) || (FindSubString(GetName(oItem), "Eyeglasses") != -1)
							   || (FindSubString(GetName(oItem), "Turban") != -1))
			{
			 sEat = sInedible;
			 iWeight = 0;
			 SendMessageToPC(oUser, "4");
			 }
			 	
			 	
		 iTotalWeight = GetLocalInt(OBJECT_SELF, "TotalWeight");;
		 iTotalWeight = iTotalWeight + iWeight;
		 SetLocalInt(OBJECT_SELF, "TotalWeight", iTotalWeight);
		 DestroyInventory(OBJECT_SELF);
			 
		 AssignCommand(oXornArm1, ActionSpeakString(sEat, TALKVOLUME_TALK));
		 AssignCommand(oXornArm1, ActionSpeakString(IntToString(iTotalWeight) + " of your pounds.", TALKVOLUME_TALK));
		 
		 if((iTotalWeight >= 70) && (oXornArm1 != OBJECT_INVALID))	
			 {SetLocalInt(OBJECT_SELF, "TotalWeight", 0);
			  object oMyTrigger = GetLocalObject(OBJECT_SELF, "XornTrigger");
			 if(oMyTrigger == OBJECT_INVALID)
			 	{oMyTrigger = GetObjectByTag("occ_xorn_low_out");
				 SetLocalObject(OBJECT_SELF, "oMyTrigger", oMyTrigger);
				 }
			 object oXornCrownWP = GetWaypointByTag("xorn_crown_low_out");
			 object oXornBodyWP = GetWaypointByTag("xorn_body_low_out");
			 object oXornArm2WP = GetWaypointByTag("xorn_arm_2_low_out");
			 object oXornArm3WP = GetWaypointByTag("xorn_arm_3_low_out");
			 object oXornEye2WP = GetWaypointByTag("xorn_eye_2_low_out");
			 object oXornEye3WP = GetWaypointByTag("xorn_eye_3_low_out");
			 object oXornEye4WP = GetWaypointByTag("xorn_eye_4_low_out");
			 object oXornEye5WP = GetWaypointByTag("xorn_eye_5_low_out");
			 object oXornEye6WP = GetWaypointByTag("xorn_eye_6_low_out");
					 
			 object oXornBody = GetNearestObjectByTag("003_plc_xorn_body_low_out", oXornBodyWP);
			 object oXornCrown = GetNearestObjectByTag("003_plc_xorn_crown_low_out", oXornCrownWP);
			 object oXornArm2 = GetNearestObjectByTag("003_cr_xorn_arm_2_low_out", oXornArm2WP);
			 object oXornArm3 = GetNearestObjectByTag("003_cr_xorn_arm_3_low_out", oXornArm3WP);
			 object oXornEye2 = GetNearestObjectByTag("003_plc_xorn_eyes_2_low_out", oXornEye2WP);
			 object oXornEye3 = GetNearestObjectByTag("003_plc_xorn_eyes_3_low_out", oXornEye3WP);
			 object oXornEye4 = GetNearestObjectByTag("003_plc_xorn_eyes_4_low_out", oXornEye4WP);
			 object oXornEye5 = GetNearestObjectByTag("003_plc_xorn_eyes_5_low_out", oXornEye5WP);
			 object oXornEye6 = GetNearestObjectByTag("003_plc_xorn_eyes_6_low_out", oXornEye6WP);
					 
			 AssignCommand(oXornArm1, ActionSpeakString("*Drops away through the stone floor without leaving a mark.", TALKVOLUME_TALK));
			 effect eDust = EffectVisualEffect(VFX_IMP_DUST_EXPLOSION, FALSE);
			 effect eStone = EffectVisualEffect(VFX_COM_CHUNK_STONE_MEDIUM, FALSE);
			 DelayCommand(1.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eDust, GetLocation(oXornArm1)));
			 DelayCommand(2.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eStone, GetLocation(oXornArm1)));
			 DelayCommand(2.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eDust, GetLocation(oXornArm2)));
			 DelayCommand(3.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eStone, GetLocation(oXornArm2)));
			 DelayCommand(3.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eDust, GetLocation(oXornArm3)));
			 DelayCommand(4.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eStone, GetLocation(oXornArm3)));
			 
			 DestroyObject(oXornBody, 1.0);
			 DestroyObject(oXornCrown, 1.0);
			 DestroyObject(oXornArm1, 1.0);
			 DestroyObject(oXornArm2, 1.0);
			 DestroyObject(oXornArm3, 1.0);
			 DestroyObject(oXornEye2, 1.0);
			 DestroyObject(oXornEye3, 1.0);
			 DestroyObject(oXornEye4, 1.0);
			 DestroyObject(oXornEye5, 1.0);
			 DestroyObject(oXornEye6, 1.0);
			 
			 
			 location lUser = GetLocation(oUser);
			 object oDisgorged = GetLocalObject(OBJECT_SELF, "oDisgorged");
			 if(oDisgorged == OBJECT_INVALID)
			 	{oDisgorged = GetWaypointByTag("xorn_disgorge_low_out");
				 SetLocalObject(OBJECT_SELF, "oDisgorged", oDisgorged);
				}
			 effect eParalyze = EffectParalyze();
			 ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eDust, GetLocation(oUser));
			 ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eStone, GetLocation(oUser));
			 DelayCommand(4.0, JumpPartyToArea(oUser, oDisgorged));
			 object oXornEaten = CreateObject(OBJECT_TYPE_PLACEABLE, "003_plc_xorn_body", GetLocation(oDisgorged));
			 object oPartyMember = GetFirstFactionMember(oUser);
			 while(oPartyMember != OBJECT_INVALID)
				 {object oXornEater = CreateObject(OBJECT_TYPE_PLACEABLE, "003_plc_xorn_body", GetLocation(oPartyMember));
				 DelayCommand(1.0, AssignCommand(oXornEater, ActionSpeakString("*Erupts from the ground and engulfs " + GetName(oUser) + " whole! All limbs and eyes have merged with the body to create a smooth, frictionless surface.", TALKVOLUME_TALK)));
				 DelayCommand(1.5, SendMessageToPC(oPartyMember, "You have been swallowed by a Xorn! Rock presses you from all sides. You cannot breath, nor even expand your ribcage. It is exactly like being buried alive."));
				 DelayCommand(25.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eDust, GetLocation(oPartyMember)));
				 DelayCommand(25.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eStone, GetLocation(oPartyMember)));
				 DestroyObject(oXornEater, 25.0);
				 DelayCommand(25.0, AssignCommand(oXornEaten, ActionSpeakString("*Disgorges its passenger in a cloud of dust and clods of dirt. It drops away from around " + GetName(oUser), TALKVOLUME_TALK)));
				 DestroyObject(oXornEaten, 25.0);
				 DelayCommand(27.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eDust, GetLocation(oDisgorged)));
				 DelayCommand(27.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eStone, GetLocation(oDisgorged)));
				 oPartyMember = GetNextFactionMember(oUser);
			 
			 }
			 
			 
			 DelayCommand(5.0, SetLocalInt(oMyTrigger, "Xorn", 0));
			 
			 
			 }
		 
		}
}