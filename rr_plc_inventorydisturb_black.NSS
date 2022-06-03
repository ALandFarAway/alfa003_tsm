//OnInventoryDisturb for Rauvin Ruins placeables
//Wynna Feb 2022

void ActionCreateCreature(string sCreature, location lLocPlace)
{
    CreateObject(OBJECT_TYPE_CREATURE, sCreature, lLocPlace, FALSE);
}

#include "acr_placeable_i"

void main()
{
	ACR_PlaceableOnDisturbed();
    object oItem = GetModuleItemAcquired();
	object oPC = GetLastDisturbed();
	effect eSmoke = EffectVisualEffect(VFX_DUR_SMOKE, FALSE);
	object oCenter = GetObjectByTag("phalorm_globe_black", 0);
	object oCreate = GetNearestObjectByTag("WP_phalorm_globe_platform_black", OBJECT_SELF, 1);	
	location lCreate = GetLocation(oCreate);
	string sCreate = "003_cr_un_ghost_aloisus";	
	object oCreateWeird = GetWaypointByTag("phalorm_earth_up_wp");
	location lCreateWeird = GetLocation(oCreateWeird);
	int nRandom = Random(12);
	if(nRandom==1) 
		{sCreate = "003_cr_un_ghost_si";}
	if(nRandom==2) 
		{sCreate = "003_cr_un_ghost_valbrace";}
	if(nRandom==3) 
		{sCreate = "003_cr_undead_wraith_jarra";}
	if(nRandom==4) 
		{sCreate = "003_cr_un_ghost_aloisus";}
	if(nRandom==5) 
		{sCreate = "003_cr_undead_shadow_medium";}
	if(nRandom==6) 
		{sCreate = "abr_cr_un_monkey_ghost";}
	if(nRandom==7) 
		{sCreate = "abr_cr_un_panther_ghost";}
	if(nRandom==8) 
		{sCreate = "abr_cr_un_lion_ghost";}
	if(nRandom==9) 
		{sCreate = "abr_cr_un_harpy_ghost";}
	if(nRandom==10) 
		{sCreate = "abr_cr_un_scorpion_ghost";}
	if(nRandom==11) 
		{sCreate = "003_cr_undead_wraith_dread";}
	
	object oWPOne = GetWaypointByTag("rr_hglyph_wp1b");
	object oWPTwo = GetWaypointByTag("rr_hglyph_wp2b");
	object oWPThree = GetWaypointByTag("rr_hglyph_wp3b");
	object oWPFour = GetWaypointByTag("rr_hglyph_wp4b");
	object oWPFive = GetWaypointByTag("rr_hglyph_wp5b");
	object oWPSix = GetWaypointByTag("rr_hglyph_wp6b");
	location lWPOne = GetLocation(oWPOne);
	location lWPTwo = GetLocation(oWPTwo);
	location lWPThree = GetLocation(oWPThree);
	location lWPFour = GetLocation(oWPFour);
	location lWPFive = GetLocation(oWPFive);
	location lWPSix = GetLocation(oWPSix);
	location lWPGlyph;
	effect eWeb = EffectVisualEffect(VFX_AOE_WEB_OF_PURITY, FALSE);
	effect ePurge = EffectVisualEffect(VFX_AOE_ETHEREAL_PURGE, FALSE);
	effect eQuake = EffectVisualEffect(VFX_SPELL_HIT_EARTHQUAKE, FALSE);
	effect eShake = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE, FALSE);
	effect eBurst = EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_EVIL, FALSE);
	effect eKnockdown = EffectKnockdown();
	effect eNegDamage = EffectDamage(d10()+20, DAMAGE_TYPE_NEGATIVE, DAMAGE_POWER_NORMAL, FALSE);
	
	object oSoulReaper = GetObjectByTag("003_cr_bane_bp_elthonds", 0);
	
	object oRelayblackA = GetObjectByTag("rauvin_crystal_relay_black_a", 0);
	object oRelayblackB = GetObjectByTag("rauvin_crystal_relay_black_b", 0);
	object oRelayblackC = GetObjectByTag("rauvin_crystal_relay_black_c", 0);
	object oRelayblackD = GetObjectByTag("rauvin_crystal_relay_black_d", 0);
	object oRelayblackE = GetObjectByTag("rauvin_crystal_relay_black_e", 0);
	object oRelayblackF = GetObjectByTag("rauvin_crystal_relay_black_f", 0);
	object oRelayInvis = GetObjectByTag("rauvin_crystal_relay_invis", 0);
	object oBlackCrystal = GetObjectByTag("rauvin_crystal_black", 0);
	object oSayanWall = GetObjectByTag("plc_sayen_wall", 0);
	object oSayanEffect = GetObjectByTag("fx_portal_sayan", 0);
	object oDracoSkel = GetObjectByTag("rr_dragon_skeleton", 0);
	
	
	
	
	object oParsifal = GetObjectByTag("003_cr_un_lich_parsifal", 0);
	object oVassal = GetObjectByTag("003_cr_un_banite_vassal", 0);
			 
	effect eBeamblackA = EffectBeam(VFX_BEAM_NECROMANCY, oRelayblackA, BODY_NODE_CHEST, FALSE);
	effect eBeamblackB = EffectBeam(VFX_BEAM_NECROMANCY, oRelayblackB, BODY_NODE_CHEST, FALSE);
	effect eBeamblackC = EffectBeam(VFX_BEAM_NECROMANCY, oRelayblackC, BODY_NODE_CHEST, FALSE);
	effect eBeamblackD = EffectBeam(VFX_BEAM_NECROMANCY, oRelayblackD, BODY_NODE_CHEST, FALSE);
	effect eBeamblackE = EffectBeam(VFX_BEAM_NECROMANCY, oRelayblackE, BODY_NODE_CHEST, FALSE);
	effect eBeamblackF = EffectBeam(VFX_BEAM_NECROMANCY, oRelayblackF, BODY_NODE_CHEST, FALSE);
	effect eBeamblackCenter = EffectBeam(VFX_BEAM_NECROMANCY, oCenter, BODY_NODE_CHEST, FALSE);
	 		 
	
	//SendMessageToPC(oPC, "Disturb called");
			
	int nCount = 0;
	object oInventory = GetFirstItemInInventory(OBJECT_SELF);
	if((GetLocalInt(OBJECT_SELF, "Activated") == 1) && (GetTag(OBJECT_SELF) == "phalorm_rauvin_panel_b") && (FindSubString(GetTag(GetInventoryDisturbItem()), "003_it_phalorm_hglyph_", 0) != -1) && (GetInventoryDisturbType() == 0))
		{
		while(oInventory != OBJECT_INVALID) {
		    nCount = nCount+1;
			//SendMessageToPC(oPC, IntToString(nCount));
			if(nCount == 1) {lWPGlyph = lWPOne;}
			else if(nCount == 2) {lWPGlyph = lWPTwo;}
			else if(nCount == 3) {lWPGlyph = lWPThree;}
			else if(nCount == 4) {lWPGlyph = lWPFour;}
			else if(nCount == 5) {lWPGlyph = lWPFive;}
			else if(nCount == 6) {lWPGlyph = lWPSix;}
			if(nCount > 6) {return;}
			oInventory = GetNextItemInInventory(OBJECT_SELF);
		}
	}
	
	
	if(GetLocalInt(OBJECT_SELF, "Activated") > 0) {
		if((GetTag(GetInventoryDisturbItem()) == "003_it_phalorm_hglyph_blue") && (GetInventoryDisturbType() == 0))
			{CreateObject(OBJECT_TYPE_PLACEABLE, "rr_plc_hglyph_blue", lWPGlyph);
			 if(lWPGlyph==lWPOne) {
				 SetLocalInt(OBJECT_SELF, "H1", 1);
				}
			if(GetLocalInt(OBJECT_SELF, "Activated") == 1) {
				if(lWPGlyph==lWPTwo) {
				 	SetLocalInt(OBJECT_SELF, "H2", 2);
					}
				}
			 }	
		if((GetTag(GetInventoryDisturbItem()) == "003_it_phalorm_hglyph_green") && (GetInventoryDisturbType() == 0))
			{CreateObject(OBJECT_TYPE_PLACEABLE, "rr_plc_hglyph_green", lWPGlyph);
			 if(lWPGlyph==lWPTwo) {
			 	SetLocalInt(OBJECT_SELF, "H2", 1);
				}
			 if(GetLocalInt(OBJECT_SELF, "Activated") == 1) {
				 if(lWPGlyph==lWPSix) {
				 	SetLocalInt(OBJECT_SELF, "H6", 2);
					}
				}
			 }	
		if((GetTag(GetInventoryDisturbItem()) == "003_it_phalorm_hglyph_gold") && (GetInventoryDisturbType() == 0))
			{CreateObject(OBJECT_TYPE_PLACEABLE, "rr_plc_hglyph_gold", lWPGlyph);
			 if(lWPGlyph==lWPThree) {
			 	SetLocalInt(OBJECT_SELF, "H3", 1);
				}
			 }	
		if((GetTag(GetInventoryDisturbItem()) == "003_it_phalorm_hglyph_red") && (GetInventoryDisturbType() == 0))
			{CreateObject(OBJECT_TYPE_PLACEABLE, "rr_plc_hglyph_red", lWPGlyph);
			 if(lWPGlyph==lWPFour) {
			 	SetLocalInt(OBJECT_SELF, "H4", 1);
				}
			 if(GetLocalInt(OBJECT_SELF, "Activated") == 2) {
				 if(lWPGlyph==lWPOne) {
				 	SetLocalInt(OBJECT_SELF, "H1", 3);
					}
				}
			 }	
		
			 
		 if((GetTag(GetInventoryDisturbItem()) == "003_it_phalorm_hglyph_violet") && (GetInventoryDisturbType() == 0))
			{CreateObject(OBJECT_TYPE_PLACEABLE, "rr_plc_hglyph_violet", lWPGlyph);
			 if(GetLocalInt(OBJECT_SELF, "Activated") == 1) {
			 	 if(lWPGlyph==lWPOne) {
				 	SetLocalInt(OBJECT_SELF, "H1", 2);
					}
				 if(lWPGlyph==lWPFour) {
					 SetLocalInt(OBJECT_SELF, "H4", 2);
					}
				}
			if(GetLocalInt(OBJECT_SELF, "Activated") == 2) {
				 if(lWPGlyph==lWPThree) {
				 	SetLocalInt(OBJECT_SELF, "H3", 3);
					}
				 if(lWPGlyph==lWPFive) {
				 	SetLocalInt(OBJECT_SELF, "H5", 3);
					}
				}
			 }	
			 
		if((GetTag(GetInventoryDisturbItem()) == "003_it_phalorm_hglyph_orange") && (GetInventoryDisturbType() == 0))
			{CreateObject(OBJECT_TYPE_PLACEABLE, "rr_plc_hglyph_orange", lWPGlyph);
			 if(GetLocalInt(OBJECT_SELF, "Activated") == 1) {
				 if(lWPGlyph==lWPThree) {
				 	SetLocalInt(OBJECT_SELF, "H3", 2);
					}
				}
			 if(GetLocalInt(OBJECT_SELF, "Activated") == 2) {
				 if(lWPGlyph==lWPTwo) {
				 	SetLocalInt(OBJECT_SELF, "H2", 3);
					}
				 if(lWPGlyph==lWPSix) {
				 	SetLocalInt(OBJECT_SELF, "H6", 3);
					}
				}
			 }	
			 
			 		
		if((GetTag(GetInventoryDisturbItem()) == "003_it_phalorm_hglyph_indigo") && (GetInventoryDisturbType() == 0))
			{CreateObject(OBJECT_TYPE_PLACEABLE, "rr_plc_hglyph_indigo", lWPGlyph);
			 if(GetLocalInt(OBJECT_SELF, "Activated") == 1) {
				 if(lWPGlyph==lWPFive) {
				 	SetLocalInt(OBJECT_SELF, "H5", 2);
					}
				}
			 }	
			 
		if((GetTag(GetInventoryDisturbItem()) == "003_it_phalorm_hglyph_white") && (GetInventoryDisturbType() == 0))
			{CreateObject(OBJECT_TYPE_PLACEABLE, "rr_plc_hglyph_white", lWPGlyph);
			 if(GetLocalInt(OBJECT_SELF, "Activated") == 2) {
				 if(lWPGlyph==lWPFour) {
				 	SetLocalInt(OBJECT_SELF, "H4", 3);
					}
				}
			 }	
			 
		
		if((GetTag(GetInventoryDisturbItem()) == "003_it_phalorm_hglyph_blue") && (GetInventoryDisturbType() == 1))
			{DestroyObject(GetNearestObjectByTag("rr_plc_hglyph_blue", OBJECT_SELF, 1));
			 DestroyObject(GetNearestObjectByTag("rr_plc_hglyph_n", OBJECT_SELF, 1));
			 }	
		if((GetTag(GetInventoryDisturbItem()) == "003_it_phalorm_hglyph_green") && (GetInventoryDisturbType() == 1))
			{DestroyObject(GetNearestObjectByTag("rr_plc_hglyph_green", OBJECT_SELF, 1));
			 DestroyObject(GetNearestObjectByTag("rr_plc_hglyph_e", OBJECT_SELF, 1));
			 }	
		if((GetTag(GetInventoryDisturbItem()) == "003_it_phalorm_hglyph_gold") && (GetInventoryDisturbType() == 1))
			{DestroyObject(GetNearestObjectByTag("rr_plc_hglyph_gold", OBJECT_SELF, 1));
			 DestroyObject(GetNearestObjectByTag("rr_plc_hglyph_p", OBJECT_SELF, 1));
			 }		
		if((GetTag(GetInventoryDisturbItem()) == "003_it_phalorm_hglyph_red") && (GetInventoryDisturbType() == 1))
			{DestroyObject(GetNearestObjectByTag("rr_plc_hglyph_red", OBJECT_SELF, 1));
			 DestroyObject(GetNearestObjectByTag("rr_plc_hglyph_o", OBJECT_SELF, 1));
			 }
		if((GetTag(GetInventoryDisturbItem()) == "003_it_phalorm_hglyph_violet") && (GetInventoryDisturbType() == 1))
			{DestroyObject(GetNearestObjectByTag("rr_plc_hglyph_violet", OBJECT_SELF, 1));
			 DestroyObject(GetNearestObjectByTag("rr_plc_hglyph_i", OBJECT_SELF, 1));
			 }	
		if((GetTag(GetInventoryDisturbItem()) == "003_it_phalorm_hglyph_orange") && (GetInventoryDisturbType() == 1))
			{DestroyObject(GetNearestObjectByTag("rr_plc_hglyph_orange", OBJECT_SELF, 1));
			 DestroyObject(GetNearestObjectByTag("rr_plc_hglyph_s", OBJECT_SELF, 1));
			 }	
		if((GetTag(GetInventoryDisturbItem()) == "003_it_phalorm_hglyph_indigo") && (GetInventoryDisturbType() == 1))
			{DestroyObject(GetNearestObjectByTag("rr_plc_hglyph_indigo", OBJECT_SELF, 1));
			 DestroyObject(GetNearestObjectByTag("rr_plc_hglyph_d", OBJECT_SELF, 1));
			 }	
		if((GetTag(GetInventoryDisturbItem()) == "003_it_phalorm_hglyph_white") && (GetInventoryDisturbType() == 1))
			{DestroyObject(GetNearestObjectByTag("rr_plc_hglyph_white", OBJECT_SELF, 1));
			 DestroyObject(GetNearestObjectByTag("rr_plc_hglyph_r", OBJECT_SELF, 1));
			 }	
			
		}		 
		 
	if((GetLocalInt(OBJECT_SELF, "Activated") == 0) && (GetTag(GetInventoryDisturbItem()) == "abr_it_rng_orbacid") && (GetInventoryDisturbType() == 0))
		{ 
	     SetLocalInt(OBJECT_SELF, "Activated", 1);
		 
		 ActionSpeakString("*Hieroglyph inscribed tablets appear, standing up on top of the panel", TALKVOLUME_TALK);
		 CreateItemOnObject("003_it_phalorm_hglyph_red", OBJECT_SELF, 1);	
		 CreateItemOnObject("003_it_phalorm_hglyph_gold", OBJECT_SELF, 1);	
		 CreateItemOnObject("003_it_phalorm_hglyph_orange", OBJECT_SELF, 1);	
		 CreateItemOnObject("003_it_phalorm_hglyph_green", OBJECT_SELF, 1);	
		 CreateItemOnObject("003_it_phalorm_hglyph_blue", OBJECT_SELF, 1);	
		 CreateItemOnObject("003_it_phalorm_hglyph_indigo", OBJECT_SELF, 1);	
		 CreateItemOnObject("003_it_phalorm_hglyph_violet", OBJECT_SELF, 1);	
		 CreateItemOnObject("003_it_phalorm_hglyph_violet", OBJECT_SELF, 1);	
		 CreateObject(OBJECT_TYPE_PLACEABLE, "rr_plc_hglyph_red", lWPFour);
		 CreateObject(OBJECT_TYPE_PLACEABLE, "rr_plc_hglyph_orange", lWPOne);
		 CreateObject(OBJECT_TYPE_PLACEABLE, "rr_plc_hglyph_gold", lWPThree);
		 CreateObject(OBJECT_TYPE_PLACEABLE, "rr_plc_hglyph_green", lWPTwo);
		 CreateObject(OBJECT_TYPE_PLACEABLE, "rr_plc_hglyph_blue", lWPFive);
		 CreateObject(OBJECT_TYPE_PLACEABLE, "rr_plc_hglyph_indigo", lWPSix);
		 //CreateObject(OBJECT_TYPE_PLACEABLE, "rr_plc_hglyph_violet", lWPSix);
		 }	 	
	 	
	if((GetTag(OBJECT_SELF) == "phalorm_rauvin_panel_b") && (GetInventoryDisturbType() == 0))
		{if((GetTag(GetInventoryDisturbItem()) != "abr_it_rng_orbacid") && (GetTag(GetInventoryDisturbItem()) != "003_it_phalorm_hglyph_1") && (GetTag(GetInventoryDisturbItem()) != "003_it_phalorm_hglyph_2") && (GetTag(GetInventoryDisturbItem()) != "003_it_phalorm_hglyph_3") && (GetTag(GetInventoryDisturbItem()) != "003_it_phalorm_hglyph_4")) { 
			 }
		 }
	
	if((GetLocalInt(OBJECT_SELF, "H1") == 1) && (GetLocalInt(OBJECT_SELF, "H2") == 1) && (GetLocalInt(OBJECT_SELF, "H3") == 1) && (GetLocalInt(OBJECT_SELF, "H4") == 1))
		{	 SendMessageToAllDMs(GetName(oPC) + " calling Earth Weird to exit Ritual of Unmaking.");	 
		 	 ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eWeb, GetLocation(OBJECT_SELF), 5.0);
			 DelayCommand(1.0, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, ePurge, GetLocation(OBJECT_SELF), 5.0));
			 ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eWeb, lCreateWeird, 5.0);
			 
			 DestroyObject(GetNearestObjectByTag("rr_plc_hglyph_red", OBJECT_SELF, 1), 0.5, 1);
			 DestroyObject(GetNearestObjectByTag("rr_plc_hglyph_gold", OBJECT_SELF, 1), 1.0, 1);
			 DestroyObject(GetNearestObjectByTag("rr_plc_hglyph_green", OBJECT_SELF, 1), 1.5, 1);
			 DestroyObject(GetNearestObjectByTag("rr_plc_hglyph_blue", OBJECT_SELF, 1), 2.0, 1);
			 CreateObject(OBJECT_TYPE_PLACEABLE, "rr_plc_hglyph_n", lWPTwo);
			 CreateObject(OBJECT_TYPE_PLACEABLE, "rr_plc_hglyph_e", lWPThree);
			 CreateObject(OBJECT_TYPE_PLACEABLE, "rr_plc_hglyph_p", lWPFour);
			 CreateObject(OBJECT_TYPE_PLACEABLE, "rr_plc_hglyph_o", lWPFive);
			 SetLocalInt(OBJECT_SELF, "H1", 0);
			 SetLocalInt(OBJECT_SELF, "H2", 0);
			 SetLocalInt(OBJECT_SELF, "H3", 0);
			 SetLocalInt(OBJECT_SELF, "H4", 0);
			 SetLocalInt(OBJECT_SELF, "H5", 0);
			 SetLocalInt(OBJECT_SELF, "H6", 0);
			 
			 DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamblackA, oRelayblackB, 25.0));
			 DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamblackA, oRelayblackC, 25.0));
			 DelayCommand(5.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamblackB, oRelayblackD, 21.0));
			 DelayCommand(5.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamblackC, oRelayblackD, 21.0));
			 
			 DelayCommand(9.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamblackA, oCenter, 16.0));
			 DelayCommand(9.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamblackB, oCenter, 16.0));
			 DelayCommand(9.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamblackC, oCenter, 16.0));
			 DelayCommand(9.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamblackD, oCenter, 16.0));
			 
			 
			 DelayCommand(15.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_EPIC_UNDEAD), oRelayblackA));
			 DelayCommand(15.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_EPIC_UNDEAD), oRelayblackB));
			 DelayCommand(15.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_EPIC_UNDEAD), oRelayblackC));
			 DelayCommand(15.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_EPIC_UNDEAD), oRelayblackD));
			 
			 DelayCommand(20.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_FNF_SUMMON_EPIC_UNDEAD), oCenter, 1.0));
			 DelayCommand(22.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_FNF_SUMMON_EPIC_UNDEAD), oCenter, 1.0));
			 DelayCommand(24.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_FNF_SUMMON_EPIC_UNDEAD), oCenter, 1.0));
			 
			 DelayCommand(31.0, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_FNF_LOS_EVIL_30), GetLocation(oCenter), 5.0));
			 
			 
			 DelayCommand(30.0, ActionCreateCreature("phalorm_cr_el_earthweird_b", lCreateWeird));
			
		 }
		 
	else if((GetLocalInt(OBJECT_SELF, "H1") == 2) && (GetLocalInt(OBJECT_SELF, "H2") == 2) && (GetLocalInt(OBJECT_SELF, "H3") == 2) && (GetLocalInt(OBJECT_SELF, "H4") == 2) && (GetLocalInt(OBJECT_SELF, "H5") == 2) && (GetLocalInt(OBJECT_SELF, "H6") == 2))
		{	 SendMessageToAllDMs(GetName(oPC) + " removing barrier into Sayan's crypt.");	 
		 	 SetLocalInt(OBJECT_SELF, "Activated", 2);
			 CreateItemOnObject("003_it_phalorm_hglyph_white", OBJECT_SELF, 1);	
		 	 CreateItemOnObject("003_it_phalorm_hglyph_orange", OBJECT_SELF, 1);	
		 
			 
			 DestroyObject(GetNearestObjectByTag("rr_plc_hglyph_violet", OBJECT_SELF, 1), 0.5, 1);
			 DestroyObject(GetNearestObjectByTag("rr_plc_hglyph_blue", OBJECT_SELF, 1), 1.0, 1);
			 DestroyObject(GetNearestObjectByTag("rr_plc_hglyph_orange", OBJECT_SELF, 1), 1.5, 1);
			 DestroyObject(GetNearestObjectByTag("rr_plc_hglyph_violet", OBJECT_SELF, 2), 2.0, 1);
			 DestroyObject(GetNearestObjectByTag("rr_plc_hglyph_indigo", OBJECT_SELF, 1), 2.5, 1);
			 DestroyObject(GetNearestObjectByTag("rr_plc_hglyph_green", OBJECT_SELF, 1), 3.0, 1);
			 CreateObject(OBJECT_TYPE_PLACEABLE, "rr_plc_hglyph_i", lWPOne);
			 CreateObject(OBJECT_TYPE_PLACEABLE, "rr_plc_hglyph_n", lWPTwo);
			 CreateObject(OBJECT_TYPE_PLACEABLE, "rr_plc_hglyph_s", lWPThree);
			 CreateObject(OBJECT_TYPE_PLACEABLE, "rr_plc_hglyph_i", lWPFour);
			 CreateObject(OBJECT_TYPE_PLACEABLE, "rr_plc_hglyph_d", lWPFive);
			 CreateObject(OBJECT_TYPE_PLACEABLE, "rr_plc_hglyph_e", lWPSix);
			 SetLocalInt(OBJECT_SELF, "H1", 0);
			 SetLocalInt(OBJECT_SELF, "H2", 0);
			 SetLocalInt(OBJECT_SELF, "H3", 0);
			 SetLocalInt(OBJECT_SELF, "H4", 0);
			 SetLocalInt(OBJECT_SELF, "H5", 0);
			 SetLocalInt(OBJECT_SELF, "H6", 0);
			 	
			 
			 DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamblackA, oRelayblackB, 25.0));
			 DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamblackA, oRelayblackC, 25.0));
			 DelayCommand(5.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamblackB, oRelayblackD, 21.0));
			 DelayCommand(5.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamblackC, oRelayblackD, 21.0));
			 
			 DelayCommand(9.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamblackA, oCenter, 16.0));
			 DelayCommand(9.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamblackB, oCenter, 16.0));
			 DelayCommand(9.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamblackC, oCenter, 16.0));
			 DelayCommand(9.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamblackD, oCenter, 16.0));
			 
			 DelayCommand(10.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamblackCenter, oRelayblackE, 15.0));
			 DelayCommand(15.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamblackE, oRelayInvis, 10.0));
			 DelayCommand(20.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eQuake, oRelayInvis, 5.0));
			 DelayCommand(25.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBurst, oRelayInvis, 1.0));
			 object oDamaged = GetFirstObjectInShape(SHAPE_SPHERE, 20.0, GetLocation(oRelayInvis), FALSE, OBJECT_TYPE_CREATURE);
			 while ((oDamaged != OBJECT_INVALID) && (GetIsPC(oDamaged))) {
				  DelayCommand(26.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnockdown, oDamaged, 3.0));
				  DelayCommand(27.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eNegDamage, oDamaged, 1.0));
				  oDamaged = GetNextObjectInShape(SHAPE_SPHERE, 20.0, GetLocation(oRelayInvis), FALSE, OBJECT_TYPE_CREATURE);
			 }
			 DestroyObject(oRelayInvis, 30.0);
			 
		 }
		 
		 else if((GetLocalInt(OBJECT_SELF, "H1") == 3) && (GetLocalInt(OBJECT_SELF, "H2") == 3) && (GetLocalInt(OBJECT_SELF, "H3") == 3) && (GetLocalInt(OBJECT_SELF, "H4") == 3) && (GetLocalInt(OBJECT_SELF, "H5") == 3) && (GetLocalInt(OBJECT_SELF, "H6") == 3))
		{	 SendMessageToAllDMs(GetName(oPC) + " opening access to Sayan's sarc.");	 
		 	 SetLocalInt(OBJECT_SELF, "Activated", 3);
			 CreateItemOnObject("003_it_phalorm_hglyph_white", OBJECT_SELF, 1);	
		 
			 
			 DestroyObject(GetNearestObjectByTag("rr_plc_hglyph_red", OBJECT_SELF, 1), 0.5, 1);
			 DestroyObject(GetNearestObjectByTag("rr_plc_hglyph_orange", OBJECT_SELF, 1), 1.5, 1);
			 DestroyObject(GetNearestObjectByTag("rr_plc_hglyph_violet", OBJECT_SELF, 1), 0.5, 1);
			 DestroyObject(GetNearestObjectByTag("rr_plc_hglyph_white", OBJECT_SELF, 1), 1.0, 1);
			 DestroyObject(GetNearestObjectByTag("rr_plc_hglyph_violet", OBJECT_SELF, 2), 2.0, 1);
			 DestroyObject(GetNearestObjectByTag("rr_plc_hglyph_orange", OBJECT_SELF, 1), 2.5, 1);
			 CreateObject(OBJECT_TYPE_PLACEABLE, "rr_plc_hglyph_o", lWPOne);
			 CreateObject(OBJECT_TYPE_PLACEABLE, "rr_plc_hglyph_s", lWPTwo);
			 CreateObject(OBJECT_TYPE_PLACEABLE, "rr_plc_hglyph_i", lWPThree);
			 CreateObject(OBJECT_TYPE_PLACEABLE, "rr_plc_hglyph_r", lWPFour);
			 CreateObject(OBJECT_TYPE_PLACEABLE, "rr_plc_hglyph_i", lWPFive);
			 CreateObject(OBJECT_TYPE_PLACEABLE, "rr_plc_hglyph_s", lWPSix);
			 SetLocalInt(OBJECT_SELF, "H1", 0);
			 SetLocalInt(OBJECT_SELF, "H2", 0);
			 SetLocalInt(OBJECT_SELF, "H3", 0);
			 SetLocalInt(OBJECT_SELF, "H4", 0);
			 SetLocalInt(OBJECT_SELF, "H5", 0);
			 SetLocalInt(OBJECT_SELF, "H6", 0);
			 	
			 
			 DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamblackA, oRelayblackB, 25.0));
			 DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamblackA, oRelayblackC, 25.0));
			 DelayCommand(5.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamblackB, oRelayblackD, 21.0));
			 DelayCommand(5.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamblackC, oRelayblackD, 21.0));
			 
			 DelayCommand(9.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamblackA, oCenter, 16.0));
			 DelayCommand(9.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamblackB, oCenter, 16.0));
			 DelayCommand(9.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamblackC, oCenter, 16.0));
			 DelayCommand(9.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamblackD, oCenter, 16.0));
			 
			 DelayCommand(10.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamblackCenter, oRelayblackE, 15.0));
			 DelayCommand(15.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamblackE, oRelayblackF, 10.0));
			 DelayCommand(20.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eQuake, oRelayblackF, 5.0));
			 DelayCommand(25.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBurst, oRelayblackF, 1.0));
			 DestroyObject(oSayanWall, 26.0);
			 DestroyObject(oSayanEffect, 26.0);
			 
		}
		 
		 else if(nCount == 6) {
		 	AssignCommand(oCenter, ActionSpeakString("A ghostly figure rises up from the central crystal.", TALKVOLUME_TALK));	
			DestroyObject(GetObjectByTag(sCreate, 0));
			object oGhost = CreateObject(OBJECT_TYPE_CREATURE, sCreate, lCreate, FALSE); 
		}
}