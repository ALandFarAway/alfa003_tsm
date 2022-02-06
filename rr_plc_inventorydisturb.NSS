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
	object oCreateWeird = GetNearestObjectByTag("phalorm_earth_down_wp", OBJECT_SELF, 1);
	location lCreateWeird = GetLocation(oCreate);
	string sCreate = "003_cr_un_ghost_corrupt";	
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
	
	int nCount = 0;
	object oInventory = GetFirstItemInInventory(OBJECT_SELF);
	if((GetLocalInt(OBJECT_SELF, "Activated") == 1) && (GetTag(OBJECT_SELF) == "phalorm_rauvin_panel") && (FindSubString(GetTag(GetInventoryDisturbItem()), "003_it_phalorm_hglyph_1", 0) != -1) && (GetInventoryDisturbType() == 0))
		{
		while(oInventory != OBJECT_INVALID) {
		    nCount = nCount+1;
			SendMessageToPC(oPC, IntToString(nCount));
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
		 ActionSpeakString("*New hieroglyphs appear, standing up on top of the panel", TALKVOLUME_TALK);
		 CreateItemOnObject("003_it_phalorm_hglyph_2", OBJECT_SELF, 1);	
		 CreateItemOnObject("003_it_phalorm_hglyph_4", OBJECT_SELF, 1);	
		 CreateItemOnObject("003_it_phalorm_hglyph_3", OBJECT_SELF, 1);	
		 CreateItemOnObject("003_it_phalorm_hglyph_1", OBJECT_SELF, 1);	
		 CreateObject(OBJECT_TYPE_PLACEABLE, "rr_plc_hglyph_1", lWPFour);
		 CreateObject(OBJECT_TYPE_PLACEABLE, "rr_plc_hglyph_2", lWPOne);
		 CreateObject(OBJECT_TYPE_PLACEABLE, "rr_plc_hglyph_3", lWPThree);
		 CreateObject(OBJECT_TYPE_PLACEABLE, "rr_plc_hglyph_4", lWPTwo);
		 }	 	
	 	
	if((nCount > 0) && (GetTag(OBJECT_SELF) == "phalorm_rauvin_panel") && (GetInventoryDisturbType() == 0))
		{if((GetTag(GetInventoryDisturbItem()) != "abr_it_rng_orbacid") && (GetTag(GetInventoryDisturbItem()) != "003_it_phalorm_hglyph_1") && (GetTag(GetInventoryDisturbItem()) != "003_it_phalorm_hglyph_2") && (GetTag(GetInventoryDisturbItem()) != "003_it_phalorm_hglyph_3") && (GetTag(GetInventoryDisturbItem()) == "003_it_phalorm_hglyph_4")) { 
			 ActionSpeakString("A ghostly figure rises up though the quicksand filling the central shaft.", TALKVOLUME_TALK);	
			 CreateObject(OBJECT_TYPE_CREATURE, sCreate, lCreate, TRUE); 
			 }
		 }
		 
	if((GetLocalInt(OBJECT_SELF, "H1") == 1) && (GetLocalInt(OBJECT_SELF, "H2") == 1) && (GetLocalInt(OBJECT_SELF, "H3") == 1) && (GetLocalInt(OBJECT_SELF, "H4") == 1))
		{ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eWeb, GetLocation(OBJECT_SELF), 5.0);
		 DelayCommand(1.0, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, ePurge, lCreateWeird, 5.0));
		 ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eWeb, GetLocation(OBJECT_SELF), 5.0);
		 DelayCommand(1.0, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, ePurge, lCreateWeird, 5.0));
		 DestroyObject(GetNearestObjectByTag("rr_plc_hglyph_1", OBJECT_SELF, 1));
		 DestroyObject(GetNearestObjectByTag("rr_plc_hglyph_2", OBJECT_SELF, 1));
		 DestroyObject(GetNearestObjectByTag("rr_plc_hglyph_3", OBJECT_SELF, 1));
		 DestroyObject(GetNearestObjectByTag("rr_plc_hglyph_4", OBJECT_SELF, 1));
		 CreateObject(OBJECT_TYPE_PLACEABLE, "rr_plc_hglyph_o", lWPOne);
		 CreateObject(OBJECT_TYPE_PLACEABLE, "rr_plc_hglyph_p", lWPTwo);
		 CreateObject(OBJECT_TYPE_PLACEABLE, "rr_plc_hglyph_e", lWPThree);
		 CreateObject(OBJECT_TYPE_PLACEABLE, "rr_plc_hglyph_n", lWPFour);
		 CreateObject(OBJECT_TYPE_CREATURE, "phalorm_cr_el_earthweird", lCreateWeird);
		}
}