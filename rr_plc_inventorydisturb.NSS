//OnInventoryDisturb for tsm placeables
//Wynna Feb 2022


#include "acr_placeable_i"

void main()
{
	ACR_PlaceableOnDisturbed();
    object oItem = GetModuleItemAcquired();
	object oPC = GetLastDisturbed();
	effect eSmoke = EffectVisualEffect(VFX_DUR_SMOKE, FALSE);
	object oCreate = GetNearestObjectByTag("WP_phalorm_globe_platform_green2", OBJECT_SELF, 1);	
	location lCreate = GetLocation(oCreate);
	string sCreate = "003_cr_un_ghost_corrupt";	
	object oCreateWeird = GetWaypointByTag("phalorm_earth_down_wp");
	location lCreateWeird = GetLocation(oCreateWeird);
	int nRandom = Random(3);
	if(nRandom==1) 
		{sCreate = "003_cr_un_ghost_moan";}
	if(nRandom==2) 
		{sCreate = "003_cr_un_ghost_horrific";}
	object oWPOne = GetWaypointByTag("rr_hglyph_wp1");
	object oWPTwo = GetWaypointByTag("rr_hglyph_wp2");
	object oWPThree = GetWaypointByTag("rr_hglyph_wp3");
	object oWPFour = GetWaypointByTag("rr_hglyph_wp4");
	location lWPOne = GetLocation(oWPOne);
	location lWPTwo = GetLocation(oWPTwo);
	location lWPThree = GetLocation(oWPThree);
	location lWPFour = GetLocation(oWPFour);
	location lWPGlyph;
	effect eWeb = EffectVisualEffect(VFX_AOE_WEB_OF_PURITY, FALSE);
	effect ePurge = EffectVisualEffect(VFX_AOE_ETHEREAL_PURGE, FALSE);
	object oSoulReaper = GetObjectByTag("003_cr_bane_bp_elthonds", 0);
	
	int nCount = 0;
	object oInventory = GetFirstItemInInventory(OBJECT_SELF);
	if((GetLocalInt(OBJECT_SELF, "Activated") == 1) && (GetTag(OBJECT_SELF) == "phalorm_rauvin_panel") && (FindSubString(GetTag(GetInventoryDisturbItem()), "003_it_phalorm_hglyph_", 0) != -1) && (GetInventoryDisturbType() == 0))
		{
		while(oInventory != OBJECT_INVALID) {
		    nCount = nCount+1;
			//SendMessageToPC(oPC, IntToString(nCount));
			if(nCount == 1) {lWPGlyph = lWPOne;}
			else if(nCount == 2) {lWPGlyph = lWPTwo;}
			else if(nCount == 3) {lWPGlyph = lWPThree;}
			else if(nCount == 4) {lWPGlyph = lWPFour;}
			if(nCount > 5) {return;}
			oInventory = GetNextItemInInventory(OBJECT_SELF);
		}
	}
	
	if((GetLocalInt(OBJECT_SELF, "Activated") == 1) && (GetTag(OBJECT_SELF) == "phalorm_rauvin_panel") && (GetTag(GetInventoryDisturbItem()) == "003_it_phalorm_hglyph_1") && (GetInventoryDisturbType() == 0))
		{CreateObject(OBJECT_TYPE_PLACEABLE, "rr_plc_hglyph_1", lWPGlyph);
		 if(lWPGlyph==lWPOne) {
		 	SetLocalInt(OBJECT_SELF, "H1", 1);
			}
		 else {
		 	SetLocalInt(OBJECT_SELF, "H1", 0);
		 	}
		 }	
	if((GetLocalInt(OBJECT_SELF, "Activated") == 1) && (GetTag(OBJECT_SELF) == "phalorm_rauvin_panel") && (GetTag(GetInventoryDisturbItem()) == "003_it_phalorm_hglyph_2") && (GetInventoryDisturbType() == 0))
		{CreateObject(OBJECT_TYPE_PLACEABLE, "rr_plc_hglyph_2", lWPGlyph);
		 if(lWPGlyph==lWPTwo) {
		 	SetLocalInt(OBJECT_SELF, "H2", 1);
			}
		 else {
		 	SetLocalInt(OBJECT_SELF, "H2", 0);
		 	}
		 }	
	if((GetLocalInt(OBJECT_SELF, "Activated") == 1) && (GetTag(OBJECT_SELF) == "phalorm_rauvin_panel") && (GetTag(GetInventoryDisturbItem()) == "003_it_phalorm_hglyph_3") && (GetInventoryDisturbType() == 0))
		{CreateObject(OBJECT_TYPE_PLACEABLE, "rr_plc_hglyph_3", lWPGlyph);
		 if(lWPGlyph==lWPThree) {
		 	SetLocalInt(OBJECT_SELF, "H3", 1);
			}
		 else {
		 	SetLocalInt(OBJECT_SELF, "H3", 0);
		 	}
		 }	
	if((GetLocalInt(OBJECT_SELF, "Activated") == 1) && (GetTag(OBJECT_SELF) == "phalorm_rauvin_panel") && (GetTag(GetInventoryDisturbItem()) == "003_it_phalorm_hglyph_4") && (GetInventoryDisturbType() == 0))
		{CreateObject(OBJECT_TYPE_PLACEABLE, "rr_plc_hglyph_4", lWPGlyph);
		 if(lWPGlyph==lWPFour) {
		 	SetLocalInt(OBJECT_SELF, "H4", 1);
			}
		 else {
		 	SetLocalInt(OBJECT_SELF, "H4", 0);
		 	}
		 }	
	
	
		
		
		
	if((GetLocalInt(OBJECT_SELF, "Activated") == 1) && (GetTag(OBJECT_SELF) == "phalorm_rauvin_panel") && (GetTag(GetInventoryDisturbItem()) == "003_it_phalorm_hglyph_1") && (GetInventoryDisturbType() == 1))
		{DestroyObject(GetNearestObjectByTag("rr_plc_hglyph_1", OBJECT_SELF, 1));
		 SetLocalInt(OBJECT_SELF, "H1", 0);
		 }	
	if((GetLocalInt(OBJECT_SELF, "Activated") == 1) && (GetTag(OBJECT_SELF) == "phalorm_rauvin_panel") && (GetTag(GetInventoryDisturbItem()) == "003_it_phalorm_hglyph_2") && (GetInventoryDisturbType() == 1))
		{DestroyObject(GetNearestObjectByTag("rr_plc_hglyph_2", OBJECT_SELF, 1));
		 SetLocalInt(OBJECT_SELF, "H2", 0);
		 }	
	if((GetLocalInt(OBJECT_SELF, "Activated") == 1) && (GetTag(OBJECT_SELF) == "phalorm_rauvin_panel") && (GetTag(GetInventoryDisturbItem()) == "003_it_phalorm_hglyph_3") && (GetInventoryDisturbType() == 1))
		{DestroyObject(GetNearestObjectByTag("rr_plc_hglyph_3", OBJECT_SELF, 1));
		 SetLocalInt(OBJECT_SELF, "H3", 0);
		 }		
	if((GetLocalInt(OBJECT_SELF, "Activated") == 1) && (GetTag(OBJECT_SELF) == "phalorm_rauvin_panel") && (GetTag(GetInventoryDisturbItem()) == "003_it_phalorm_hglyph_4") && (GetInventoryDisturbType() == 1))
		{DestroyObject(GetNearestObjectByTag("rr_plc_hglyph_4", OBJECT_SELF, 1));
		 SetLocalInt(OBJECT_SELF, "H4", 0);
		 }	
			 
		 
	
		 
		 
	if((GetLocalInt(OBJECT_SELF, "Activated") != 1) && (GetTag(OBJECT_SELF) == "phalorm_rauvin_panel") && (GetTag(GetInventoryDisturbItem()) == "abr_it_rng_orbacid") && (GetInventoryDisturbType() == 0))
		{ 
	     SetLocalInt(OBJECT_SELF, "Activated", 1);
		 ActionSpeakString("*Hieroglyph inscribed tablets appear, standing up on top of the panel", TALKVOLUME_TALK);
		 CreateItemOnObject("003_it_phalorm_hglyph_2", OBJECT_SELF, 1);	
		 CreateItemOnObject("003_it_phalorm_hglyph_4", OBJECT_SELF, 1);	
		 CreateItemOnObject("003_it_phalorm_hglyph_3", OBJECT_SELF, 1);	
		 CreateItemOnObject("003_it_phalorm_hglyph_1", OBJECT_SELF, 1);	
		 CreateObject(OBJECT_TYPE_PLACEABLE, "rr_plc_hglyph_1", lWPFour);
		 CreateObject(OBJECT_TYPE_PLACEABLE, "rr_plc_hglyph_2", lWPOne);
		 CreateObject(OBJECT_TYPE_PLACEABLE, "rr_plc_hglyph_3", lWPThree);
		 CreateObject(OBJECT_TYPE_PLACEABLE, "rr_plc_hglyph_4", lWPTwo);
		 }	 	
	 	
	if((GetTag(OBJECT_SELF) == "phalorm_rauvin_panel") && (GetInventoryDisturbType() == 0))
		{if((GetTag(GetInventoryDisturbItem()) != "abr_it_rng_orbacid") && (GetTag(GetInventoryDisturbItem()) != "003_it_phalorm_hglyph_1") && (GetTag(GetInventoryDisturbItem()) != "003_it_phalorm_hglyph_2") && (GetTag(GetInventoryDisturbItem()) != "003_it_phalorm_hglyph_3") && (GetTag(GetInventoryDisturbItem()) != "003_it_phalorm_hglyph_4")) { 
			 ActionSpeakString("A ghostly figure rises up though the quicksand filling the central shaft and drifts into the room.", TALKVOLUME_TALK);	
			 object oGhost = CreateObject(OBJECT_TYPE_CREATURE, sCreate, lCreate, FALSE); 
			 DelayCommand(1.0, AssignCommand(oGhost, ActionJumpToLocation(lCreateWeird)));
			 }
		 }
	
	if((GetLocalInt(OBJECT_SELF, "H1") == 1) && (GetLocalInt(OBJECT_SELF, "H2") == 1) && (GetLocalInt(OBJECT_SELF, "H3") == 1) && (GetLocalInt(OBJECT_SELF, "H4") == 1))
		{SendMessageToAllDMs(GetName(oPC) + " setting off crystals");	 
		 if(FindSubString(GetName(oPC), "Banite") == -1) {	 
		
			 ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eWeb, GetLocation(OBJECT_SELF), 5.0);
			 //DelayCommand(1.0, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, ePurge, GetLocation(OBJECT_SELF), 5.0));
			 //ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eWeb, lCreateWeird, 5.0);
			 object oCenter = GetObjectByTag("phalorm_orb_green2", 0);
		     object oRelayGreenA = GetObjectByTag("rauvin_crystal_relay_green_a", 0);
		     object oRelayGreenB = GetObjectByTag("rauvin_crystal_relay_green_b", 0);
		     object oRelayGreenC = GetObjectByTag("rauvin_crystal_relay_green_c", 0);
		     object oRelayGreenD = GetObjectByTag("rauvin_crystal_relay_green_d", 0);
		     object oBlackCrystal = GetObjectByTag("rauvin_crystal_relay_black", 0);
		     object oParsifal = GetObjectByTag("003_cr_un_lich_parsifal", 0);
			 object oVassal = GetObjectByTag("003_cr_un_banite_vassal", 0);
			 
			 object oHiveA = GetObjectByTag("PLC_hive_jarra", 0);
		     object oHiveB = GetObjectByTag("PLC_hive_valbrace", 0);
		     object oHiveC = GetObjectByTag("PLC_hive_si", 0);
		     object oHiveD = GetObjectByTag("PLC_hive_aloisus", 0);
		     object oWebA = GetObjectByTag("PLC_web_jarra", 0);
		     object oWebB = GetObjectByTag("PLC_web_valbrace", 0);
		     object oWebC = GetObjectByTag("PLC_web_si", 0);
		     object oWebD = GetObjectByTag("PLC_web_aloisus", 0);
		     object oBugsA = GetObjectByTag("fx_butterflies_jarra", 0);
		     object oBugsB = GetObjectByTag("fx_butterflies_valbrace", 0);
		     object oBugsC = GetObjectByTag("fx_butterflies_si", 0);
		     object oBugsD = GetObjectByTag("fx_butterflies_aloisus", 0);
		     effect eBeamGreenA = EffectBeam(VFX_BEAM_GREEN_DRAGON_ACID, oRelayGreenA, BODY_NODE_CHEST, FALSE);
			 effect eBeamGreenB = EffectBeam(VFX_BEAM_GREEN_DRAGON_ACID, oRelayGreenB, BODY_NODE_CHEST, FALSE);
			 effect eBeamGreenC = EffectBeam(VFX_BEAM_GREEN_DRAGON_ACID, oRelayGreenC, BODY_NODE_CHEST, FALSE);
			 effect eBeamGreenD = EffectBeam(VFX_BEAM_GREEN_DRAGON_ACID, oRelayGreenD, BODY_NODE_CHEST, FALSE);
			 effect eBeamGreenCenter = EffectBeam(VFX_BEAM_GREEN_DRAGON_ACID, oCenter, BODY_NODE_CHEST, FALSE);
			 effect eBeamBlackCenter = EffectBeam(VFX_BEAM_NECROMANCY, oCenter, BODY_NODE_CHEST, FALSE);
			 
			 DestroyObject(GetNearestObjectByTag("rr_plc_hglyph_1", OBJECT_SELF, 1), 0.5, 1);
			 DestroyObject(GetNearestObjectByTag("rr_plc_hglyph_2", OBJECT_SELF, 1), 1.0, 1);
			 DestroyObject(GetNearestObjectByTag("rr_plc_hglyph_3", OBJECT_SELF, 1), 1.5, 1);
			 DestroyObject(GetNearestObjectByTag("rr_plc_hglyph_4", OBJECT_SELF, 1), 2.0, 1);
			 CreateObject(OBJECT_TYPE_PLACEABLE, "rr_plc_hglyph_o", lWPOne);
			 CreateObject(OBJECT_TYPE_PLACEABLE, "rr_plc_hglyph_p", lWPTwo);
			 CreateObject(OBJECT_TYPE_PLACEABLE, "rr_plc_hglyph_e", lWPThree);
			 CreateObject(OBJECT_TYPE_PLACEABLE, "rr_plc_hglyph_n", lWPFour);
			 
			 DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamGreenA, oRelayGreenB, 25.0));
			 DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamGreenA, oRelayGreenC, 25.0));
			 DelayCommand(5.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamGreenB, oRelayGreenD, 21.0));
			 DelayCommand(5.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamGreenC, oRelayGreenD, 21.0));
			 
			 DelayCommand(9.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamGreenA, oCenter, 16.0));
			 DelayCommand(9.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamGreenB, oCenter, 16.0));
			 DelayCommand(9.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamGreenC, oCenter, 16.0));
			 DelayCommand(9.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamGreenD, oCenter, 16.0));
			 
			 DelayCommand(10.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamBlackCenter, oWebA, 15.0));
			 DelayCommand(10.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamBlackCenter, oWebB, 15.0));
			 DelayCommand(10.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamBlackCenter, oWebC, 15.0));
			 DelayCommand(10.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamBlackCenter, oWebD, 15.0));
			 
			 DelayCommand(15.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_EPIC_UNDEAD), oWebA));
			 DelayCommand(15.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_EPIC_UNDEAD), oWebB));
			 DelayCommand(15.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_EPIC_UNDEAD), oWebC));
			 DelayCommand(15.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_EPIC_UNDEAD), oWebD));
			 
			 DelayCommand(20.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_FNF_SUMMON_EPIC_UNDEAD), oCenter, 1.0));
			 DelayCommand(22.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_FNF_SUMMON_EPIC_UNDEAD), oCenter, 1.0));
			 DelayCommand(24.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_FNF_SUMMON_EPIC_UNDEAD), oCenter, 1.0));
			 
			 DelayCommand(31.0, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_FNF_LOS_EVIL_30), GetLocation(oCenter), 5.0));
			 
			 DestroyObject(oHiveA, 12.0);
			 DestroyObject(oHiveB, 12.0);
			 DestroyObject(oHiveC, 12.0);
			 DestroyObject(oHiveD, 12.0);
			 DestroyObject(oWebA, 12.0);
			 DestroyObject(oWebB, 12.0);
			 DestroyObject(oWebC, 12.0);
			 DestroyObject(oWebD, 12.0);
			 
			 object oWeird = CreateObject(OBJECT_TYPE_CREATURE, "phalorm_cr_el_earthweird", lCreateWeird, FALSE);
			 }
			 
			 if(FindSubString(GetName(oPC), "Banite") != -1) {
			 
			 ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eWeb, GetLocation(OBJECT_SELF), 5.0);
			 //DelayCommand(1.0, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, ePurge, GetLocation(OBJECT_SELF), 5.0));
			 //ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eWeb, lCreateWeird, 5.0);
			 object oCenter = GetObjectByTag("phalorm_orb_green2", 0);
		     object oRelayGreenA = GetObjectByTag("rauvin_crystal_relay_green_a", 0);
		     object oRelayGreenB = GetObjectByTag("rauvin_crystal_relay_green_b", 0);
		     object oRelayGreenC = GetObjectByTag("rauvin_crystal_relay_green_c", 0);
		     object oRelayGreenD = GetObjectByTag("rauvin_crystal_relay_green_d", 0);
		     object oBlackCrystal = GetObjectByTag("rauvin_crystal_black", 0);
		     object oParsifal = GetObjectByTag("003_cr_un_lich_parsifal", 0);
			 object oVassal = GetObjectByTag("003_cr_un_banite_vassal", 0);
			 object oWallA = GetObjectByTag("phaedra_wall_a", 0);
			 object oWallB = GetObjectByTag("phaedra_wall_b", 0);
			 object oLight = GetObjectByTag("fx_phalorm_light_green_up", 0);
			 
			 
			 object oHiveA = GetObjectByTag("PLC_hive_jarra", 0);
		     object oHiveB = GetObjectByTag("PLC_hive_valbrace", 0);
		     object oHiveC = GetObjectByTag("PLC_hive_si", 0);
		     object oHiveD = GetObjectByTag("PLC_hive_aloisus", 0);
		     object oWebA = GetObjectByTag("PLC_web_jarra", 0);
		     object oWebB = GetObjectByTag("PLC_web_valbrace", 0);
		     object oWebC = GetObjectByTag("PLC_web_si", 0);
		     object oWebD = GetObjectByTag("PLC_web_aloisus", 0);
		     object oBugsA = GetObjectByTag("fx_butterflies_jarra", 0);
		     object oBugsB = GetObjectByTag("fx_butterflies_valbrace", 0);
		     object oBugsC = GetObjectByTag("fx_butterflies_si", 0);
		     object oBugsD = GetObjectByTag("fx_butterflies_aloisus", 0);
		     effect eBeamGreenA = EffectBeam(VFX_BEAM_GREEN_DRAGON_ACID, oRelayGreenA, BODY_NODE_CHEST, FALSE);
			 effect eBeamGreenB = EffectBeam(VFX_BEAM_GREEN_DRAGON_ACID, oRelayGreenB, BODY_NODE_CHEST, FALSE);
			 effect eBeamGreenC = EffectBeam(VFX_BEAM_GREEN_DRAGON_ACID, oRelayGreenC, BODY_NODE_CHEST, FALSE);
			 effect eBeamGreenD = EffectBeam(VFX_BEAM_GREEN_DRAGON_ACID, oRelayGreenD, BODY_NODE_CHEST, FALSE);
			 effect eBeamGreenCenter = EffectBeam(VFX_BEAM_GREEN_DRAGON_ACID, oCenter, BODY_NODE_CHEST, FALSE);
			 effect eBeamBlackCenter = EffectBeam(VFX_BEAM_NECROMANCY, oCenter, BODY_NODE_CHEST, FALSE);
			 
			 DestroyObject(GetNearestObjectByTag("rr_plc_hglyph_1", OBJECT_SELF, 1), 0.5, 1);
			 DestroyObject(GetNearestObjectByTag("rr_plc_hglyph_2", OBJECT_SELF, 1), 1.0, 1);
			 DestroyObject(GetNearestObjectByTag("rr_plc_hglyph_3", OBJECT_SELF, 1), 1.5, 1);
			 DestroyObject(GetNearestObjectByTag("rr_plc_hglyph_4", OBJECT_SELF, 1), 2.0, 1);
			 
			 object oGlyphItemA = GetItemPossessedBy(OBJECT_SELF, "003_it_phalorm_hglyph_1");
			 object oGlyphItemB = GetItemPossessedBy(OBJECT_SELF, "003_it_phalorm_hglyph_2");
			 object oGlyphItemC = GetItemPossessedBy(OBJECT_SELF, "003_it_phalorm_hglyph_3");
			 object oGlyphItemD = GetItemPossessedBy(OBJECT_SELF, "003_it_phalorm_hglyph_4");
			 
			 DestroyObject(oGlyphItemA, 1.0);
			 DestroyObject(oGlyphItemB, 1.5);
			 DestroyObject(oGlyphItemC, 2.0);
			 DestroyObject(oGlyphItemD, 2.5);
			 	 	 
			 DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamGreenA, oRelayGreenB, 25.0));
			 DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamGreenA, oRelayGreenC, 25.0));
			 DelayCommand(5.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamGreenB, oRelayGreenD, 21.0));
			 DelayCommand(5.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamGreenC, oRelayGreenD, 21.0));
			 
			 DelayCommand(9.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamGreenA, oCenter, 16.0));
			 DelayCommand(9.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamGreenB, oCenter, 16.0));
			 DelayCommand(9.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamGreenC, oCenter, 16.0));
			 DelayCommand(9.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamGreenD, oCenter, 16.0));
			 
			 DelayCommand(10.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamBlackCenter, oWebA, 15.0));
			 DelayCommand(10.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamBlackCenter, oWebB, 15.0));
			 DelayCommand(10.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamBlackCenter, oWebC, 15.0));
			 DelayCommand(10.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamBlackCenter, oWebD, 15.0));
			 
			 DelayCommand(15.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_EPIC_UNDEAD), oWebA));
			 DelayCommand(15.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_EPIC_UNDEAD), oWebB));
			 DelayCommand(15.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_EPIC_UNDEAD), oWebC));
			 DelayCommand(15.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_EPIC_UNDEAD), oWebD));
			 
			 DelayCommand(20.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_FNF_SUMMON_EPIC_UNDEAD), oBlackCrystal, 1.0));
			 DelayCommand(22.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_FNF_SUMMON_EPIC_UNDEAD), oBlackCrystal, 1.0));
			 DelayCommand(24.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_FNF_SUMMON_EPIC_UNDEAD), oBlackCrystal, 1.0));
			 
			 DelayCommand(21.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_EPIC_UNDEAD), GetLocation(oSoulReaper)));
			 DelayCommand(23.0, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_FNF_SUMMON_EPIC_UNDEAD), GetLocation(oSoulReaper), 1.0));
			 DelayCommand(25.0, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_FNF_SUMMON_EPIC_UNDEAD), GetLocation(oSoulReaper), 1.0));
			 
			 DelayCommand(30.0, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_FNF_LOS_EVIL_20), GetLocation(oSoulReaper), 5.0));
			 DelayCommand(31.0, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_FNF_LOS_EVIL_30), GetLocation(oCenter), 5.0));
			 
			 DelayCommand(30.0, AssignCommand(oBlackCrystal, ActionSpeakString("*Explodes", TALKVOLUME_TALK)));
			 DelayCommand(31.0, AssignCommand(oSoulReaper, ActionSpeakString("*Throws arms wide in triumph, then stiffens and screams, eyes widening in sudden terror...and vanishes.", TALKVOLUME_TALK)));
		     DelayCommand(30.0, AssignCommand(oParsifal, ActionSpeakString("*Vanishes", TALKVOLUME_TALK)));
			 DelayCommand(31.0, AssignCommand(oVassal, ActionSpeakString("*Flickers, then brightens, the spinning faces of screaming spirits that make it up receding into obscurity within a general glow.", TALKVOLUME_TALK)));
			 DelayCommand(34.0, AssignCommand(oCenter, ActionSpeakString("*Sinks out of sight, into the crystal globe, where its green glow immediately vanishes.", TALKVOLUME_TALK)));
			 
			 DelayCommand(32.0, ChangeToStandardFaction(oVassal, STANDARD_FACTION_DEFENDER));
			 
			 DestroyObject(oLight, 35.0);
			 DestroyObject(oBlackCrystal, 31.5);
			 DestroyObject(oSoulReaper, 32.0);
			 DestroyObject(oWallA, 32.0);
			 DestroyObject(oWallB, 32.0);
			 DestroyObject(oParsifal, 32.0);
			 DestroyObject(oCenter, 35.0);
			 
			 
			 }
		 }
}