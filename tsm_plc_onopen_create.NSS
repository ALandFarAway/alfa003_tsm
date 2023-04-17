//Wynna July 2020


#include "acr_placeable_i"
#include "acr_xp_i"
#include "acr_quest_i"
#include "acr_spawn_i"

void ActionCreateCreature(string sCreature, location lLocPlace)
{
    CreateObject(OBJECT_TYPE_CREATURE, sCreature, lLocPlace, FALSE);
}

void main()
{
	ACR_PlaceableOnOpen();
	//SendMessageToAllDMs("onopen create fired");
		if(GetLocalInt(OBJECT_SELF, "Run_Once") != 1) {
		SetLocalInt(OBJECT_SELF, "Run_Once", 1);
		object oPC = GetLastOpenedBy();
		string sCreateType = GetLocalString(OBJECT_SELF, "OBJECT_TYPE_STRING");
		int nCreateType = OBJECT_TYPE_CREATURE;
		if(sCreateType == "Placeable")
			{nCreateType = OBJECT_TYPE_PLACEABLE;}
		if(sCreateType == "Item")
			{nCreateType = OBJECT_TYPE_ITEM;}
		string sCreate = GetLocalString(OBJECT_SELF, "RESREF_TO_CREATE");
		string sCreateLocation = GetLocalString(OBJECT_SELF, "LOCATION_WP_STRING");
		object oCreateLocation = GetWaypointByTag(sCreateLocation);
		location lCreateLocation = GetLocation(oCreateLocation);
		//SendMessageToAllDMs("sCreate = " + sCreate);
		//SendMessageToAllDMs("sCreateLocation = " + sCreateLocation);
		if(oCreateLocation == OBJECT_INVALID)
			{lCreateLocation = GetLocation(OBJECT_SELF);
			//SendMessageToAllDMs("lCreateLocation invalid");
		}
		
		string sCreateTypeTwo = GetLocalString(OBJECT_SELF, "OBJECT_TYPE_STRING_TWO");
		int nCreateTypeTwo = OBJECT_TYPE_CREATURE;
		if(sCreateTypeTwo == "Placeable")
			{nCreateTypeTwo = OBJECT_TYPE_PLACEABLE;}
		if(sCreateTypeTwo == "Item")
			{nCreateTypeTwo = OBJECT_TYPE_ITEM;}
		string sCreateTwo = GetLocalString(OBJECT_SELF, "RESREF_TO_CREATE_TWO");
		string sCreateLocationTwo = GetLocalString(OBJECT_SELF, "LOCATION_WP_STRING_TWO");
		object oCreateLocationTwo = GetWaypointByTag(sCreateLocationTwo);
		location lCreateLocationTwo = GetLocation(oCreateLocationTwo);
		if(oCreateLocationTwo == OBJECT_INVALID)
			{lCreateLocationTwo = GetLocation(OBJECT_SELF);
			//SendMessageToAllDMs("lCreateLocationTwo invalid");
			}
		
			
		string sMessage = GetLocalString(OBJECT_SELF, "CREATE_MESSAGE_STRING");
		string sBroadcast = GetLocalString(OBJECT_SELF, "CREATE_BROADCAST_STRING");
		//SendMessageToAllDMs("sMessage = " + sMessage);
		//SendMessageToAllDMs("sBroadcast = " + sBroadcast);
		int nDelay = GetLocalInt(OBJECT_SELF, "CREATE_DELAY_INT");
		float fDelay = IntToFloat(nDelay);
		int nDestroy = GetLocalInt(OBJECT_SELF, "DESTROY_SELF");
		int nDestroyDelay = GetLocalInt(OBJECT_SELF, "DESTROY_DELAY");
		float fDestroyDelay = IntToFloat(nDestroyDelay);
		int nPlayOnce = GetLocalInt(OBJECT_SELF, "PLAY_ONCE");
		int nNumberCreate = GetLocalInt(OBJECT_SELF, "CREATE_NUMBER");
		if (nNumberCreate == 0) {
			nNumberCreate = 1;
		}
	 
				SendMessageToAllDMs("plc onopen create " + sCreate);
				SendMessageToPC(oPC, sMessage);
			    ActionSpeakString(sBroadcast, TALKVOLUME_TALK);
			
				int a = 0;
				while(a < nNumberCreate) {
					SendMessageToAllDMs("a = " + IntToString(a));
					object oCreate = CreateObject(nCreateType, sCreate, lCreateLocation, FALSE);
					SendMessageToAllDMs("sCreateTwo = " + sCreateTwo);
					SendMessageToAllDMs("sCreateLocationTwo = " + sCreateLocationTwo);
			 		object oCreateTwo = CreateObject(nCreateTypeTwo, sCreateTwo, lCreateLocationTwo, FALSE);
					a++;
					} 
		
		if(GetLocalInt(OBJECT_SELF, "TSM_Random_Loot") == 1 ){
			if(Random(2) == 1) {if(Random(4) == 1) {CreateItemOnObject("NW_IT_GOLD100", OBJECT_SELF, 1);}else  {CreateItemOnObject("NW_IT_GOLD50", OBJECT_SELF, 1);}}
			if(Random(3) == 1) {int nGem = Random(100); string sGem = "abr_it_gem_0" + IntToString(nGem);CreateItemOnObject(sGem, OBJECT_SELF, Random(2));}
			if(Random(3) == 1) {int nGem = Random(100); string sGem = "abr_it_gem_0" + IntToString(nGem);CreateItemOnObject(sGem, OBJECT_SELF, Random(2));}
			if(Random(3) == 1) {int nGem = Random(100); string sGem = "abr_it_gem_0" + IntToString(nGem);CreateItemOnObject(sGem, OBJECT_SELF, Random(2));}
			if(Random(4) == 1) {
			int nTreasure = Random(13);
				if(nTreasure = 1) {CreateItemOnObject("abr_it_msc_earring4", OBJECT_SELF, 1);}
				if(nTreasure = 2) {CreateItemOnObject("nw_it_mneck022", OBJECT_SELF, 1);}
				if(nTreasure = 3) {CreateItemOnObject("nw_it_mring023", OBJECT_SELF, 1);}
				if(nTreasure = 4) {CreateItemOnObject("abr_it_msc_earring5", OBJECT_SELF, 1);}
				if(nTreasure = 5) {CreateItemOnObject("abr_it_gr_mirror_fancy", OBJECT_SELF, 1);}
				if(nTreasure = 6) {CreateItemOnObject("nw_it_tr_silver_bowl", OBJECT_SELF, 1);}
				if(nTreasure = 7) {CreateItemOnObject("nw_it_tr_silver_brooch", OBJECT_SELF, 1);}
				if(nTreasure = 8) {CreateItemOnObject("nw_it_tr_silver_chalice", OBJECT_SELF, 1);}
				if(nTreasure = 9) {CreateItemOnObject("nw_it_tr_silver_scabbard", OBJECT_SELF, 1);}
				if(nTreasure = 10) {CreateItemOnObject("nw_it_mneck021", OBJECT_SELF, 1);}
				if(nTreasure = 11) {CreateItemOnObject("nw_it_mring022", OBJECT_SELF, 1);}
				if(nTreasure = 12) {CreateItemOnObject("nw_it_mneck020", OBJECT_SELF, 1);}
				if(nTreasure = 13) {CreateItemOnObject("nw_it_mring021", OBJECT_SELF, 1);}
				}
			
			if(Random(3) == 1) {
			int nPotionLow = Random(18);
				if(nPotionLow = 1) {CreateItemOnObject("abr_it_mpotion_01", OBJECT_SELF, 1);}
				if(nPotionLow = 2) {CreateItemOnObject("abr_it_mpotion_02", OBJECT_SELF, 1);}
				if(nPotionLow = 3) {CreateItemOnObject("abr_it_mpotion_endure_el", OBJECT_SELF, 1);}
				if(nPotionLow = 4) {CreateItemOnObject("abr_it_mpotion_speed", OBJECT_SELF, 1);}
				if(nPotionLow = 5) {CreateItemOnObject("abr_it_mpotion_aid", OBJECT_SELF, 1);}
				if(nPotionLow = 6) {CreateItemOnObject("abr_it_mpotion_bless", OBJECT_SELF, 1);}
				if(nPotionLow = 7) {CreateItemOnObject("abr_it_mpotion_str", OBJECT_SELF, 1);}
				if(nPotionLow = 8) {CreateItemOnObject("abr_it_mpotion_dex", OBJECT_SELF, 1);}
				if(nPotionLow = 9) {CreateItemOnObject("abr_it_mpotion_cha", OBJECT_SELF, 1);}
				if(nPotionLow = 10) {CreateItemOnObject("abr_it_mpotion_int", OBJECT_SELF, 1);}
				if(nPotionLow = 11) {CreateItemOnObject("abr_it_mpotion_lessrest", OBJECT_SELF, 1);}
				if(nPotionLow = 12) {CreateItemOnObject("abr_it_mpotion_wis", OBJECT_SELF, 1);}
				if(nPotionLow = 13) {CreateItemOnObject("abr_it_mpotion_con", OBJECT_SELF, 1);}
				if(nPotionLow = 14) {CreateItemOnObject("abr_it_mpotion_wtr_breathe", OBJECT_SELF, 1);}
				if(nPotionLow = 15) {CreateItemOnObject("abr_it_mpotion_antidote", OBJECT_SELF, 1);}
				if(nPotionLow = 16) {CreateItemOnObject("abr_it_mpotion_barkskin", OBJECT_SELF, 1);}
				if(nPotionLow = 17) {CreateItemOnObject("abr_it_mpotion_lore", OBJECT_SELF, 1);}
				if(nPotionLow = 18) {CreateItemOnObject("abr_it_po_154_2", OBJECT_SELF, 1);}
				}
			
			if(Random(4) == 1) {
			int nScrollLow = Random(27);
				if(nScrollLow = 1) {CreateItemOnObject("abr_scroll_1_bless", OBJECT_SELF, 1);}
				if(nScrollLow = 2) {CreateItemOnObject("abr_scroll_1_brnghands", OBJECT_SELF, 1);}
				if(nScrollLow = 3) {CreateItemOnObject("abr_scroll_1_causefear", OBJECT_SELF, 1);}
				if(nScrollLow = 4) {CreateItemOnObject("abr_scroll_1_chrmperson", OBJECT_SELF, 1);}
				if(nScrollLow = 5) {CreateItemOnObject("abr_scroll_1_colorspray", OBJECT_SELF, 1);}
				if(nScrollLow = 6) {CreateItemOnObject("abr_scroll_1_complang", OBJECT_SELF, 1);}
				if(nScrollLow = 7) {CreateItemOnObject("abr_scroll_1_clw", OBJECT_SELF, 1);}
				if(nScrollLow = 8) {CreateItemOnObject("abr_scroll_0_detmagic", OBJECT_SELF, 1);}
				if(nScrollLow = 9) {CreateItemOnObject("abr_scroll_1_detectundead", OBJECT_SELF, 1);}
				if(nScrollLow = 10) {CreateItemOnObject("abr_scroll_1_grease", OBJECT_SELF, 1);}
				if(nScrollLow = 11) {CreateItemOnObject("abr_scroll_2_hldprsn", OBJECT_SELF, 1);}
				if(nScrollLow = 12) {CreateItemOnObject("abr_scroll_1_identify", OBJECT_SELF, 1);}
				if(nScrollLow = 13) {CreateItemOnObject("abr_scroll_1_lorbofacid", OBJECT_SELF, 1);}
				if(nScrollLow = 14) {CreateItemOnObject("abr_scroll_1_lorbofcold", OBJECT_SELF, 1);}
				if(nScrollLow = 15) {CreateItemOnObject("abr_scroll_1_lorbofelectricity", OBJECT_SELF, 1);}
				if(nScrollLow = 16) {CreateItemOnObject("abr_scroll_1_lorboffire", OBJECT_SELF, 1);}
				if(nScrollLow = 17) {CreateItemOnObject("abr_scroll_1_lorbofsound", OBJECT_SELF, 1);}
				if(nScrollLow = 18) {CreateItemOnObject("abr_scroll_1_magearmor", OBJECT_SELF, 1);}
				if(nScrollLow = 19) {CreateItemOnObject("abr_scroll_1_magicmissile", OBJECT_SELF, 1);}
				if(nScrollLow = 20) {CreateItemOnObject("abr_scroll_1_nightshield", OBJECT_SELF, 1);}
				if(nScrollLow = 21) {CreateItemOnObject("abr_scroll_1_readmagic", OBJECT_SELF, 1);}
				if(nScrollLow = 22) {CreateItemOnObject("abr_scroll_1_removefear", OBJECT_SELF, 1);}
				if(nScrollLow = 23) {CreateItemOnObject("abr_scroll_1_sanctuary", OBJECT_SELF, 1);}
				if(nScrollLow = 24) {CreateItemOnObject("abr_scroll_1_shield", OBJECT_SELF, 1);}
				if(nScrollLow = 25) {CreateItemOnObject("abr_scroll_1_shockgrasp", OBJECT_SELF, 1);}
				if(nScrollLow = 26) {CreateItemOnObject("abr_scroll_1_sleep", OBJECT_SELF, 1);}
				if(nScrollLow = 27) {CreateItemOnObject("abr_scroll_1_truestrike", OBJECT_SELF, 1);}
				}
				
				
			if(Random(4) == 1) {
			int nPotionHigh = Random(17);
				if(nPotionHigh = 1) {CreateItemOnObject("abr_it_mpotion_03", OBJECT_SELF, 1);}
				if(nPotionHigh = 2) {CreateItemOnObject("abr_it_mpotion_04", OBJECT_SELF, 1);}
				if(nPotionHigh = 3) {CreateItemOnObject("abr_it_mpotion_greatrest", OBJECT_SELF, 1);}
				if(nPotionHigh = 4) {CreateItemOnObject("abr_it_mpotion_rest", OBJECT_SELF, 1);}
				if(nPotionHigh = 5) {CreateItemOnObject("abr_it_mpotion_invis", OBJECT_SELF, 1);}
				if(nPotionHigh = 6) {CreateItemOnObject("009_it_potion_curedisease", OBJECT_SELF, 1);}
				if(nPotionHigh = 7) {CreateItemOnObject("abr_it_po_3000_3", OBJECT_SELF, 1);}
				if(nPotionHigh = 8) {CreateItemOnObject("abr_it_po_849_3", OBJECT_SELF, 1);}
				if(nPotionHigh = 9) {CreateItemOnObject("abr_it_po_3107_3", OBJECT_SELF, 1);}
				if(nPotionHigh = 10) {CreateItemOnObject("abr_it_po_157_3", OBJECT_SELF, 1);}
				if(nPotionHigh = 11) {CreateItemOnObject("abr_it_po_857_34", OBJECT_SELF, 1);}
				if(nPotionHigh = 12) {CreateItemOnObject("abr_it_po_145_35", OBJECT_SELF, 1);}
				if(nPotionHigh = 13) {CreateItemOnObject("abr_it_po_147_35", OBJECT_SELF, 1);}
				if(nPotionHigh = 14) {CreateItemOnObject("abr_it_po_146_5", OBJECT_SELF, 1);}
				if(nPotionHigh = 15) {CreateItemOnObject("abr_it_po_3084_5", OBJECT_SELF, 1);}
				if(nPotionHigh = 16) {CreateItemOnObject("abr_it_po_860_5", OBJECT_SELF, 1);}
				if(nPotionHigh = 17) {CreateItemOnObject("abr_it_po_126_5", OBJECT_SELF, 1);}
				}
			
			if(FindSubString(GetName(OBJECT_SELF), "twisted_orc") != -1) {
				if(Random(3) == 1) {CreateItemOnObject("abr_scroll_3_inflictserious", OBJECT_SELF, 1);}
				if(Random(3) == 1) {if(Random(4) == 1) {CreateItemOnObject("aca_it_ar_stlthr_dt1", OBJECT_SELF, 1);}else  {CreateItemOnObject("aca_it_ar_stlthr_dt", OBJECT_SELF, 1);}}
				if(Random(3) == 1) {if(Random(4) == 1) {CreateItemOnObject("abr_it_wpn_mace_eh1", OBJECT_SELF, 1);}else  {CreateItemOnObject("abr_it_wpn_club_mw_1", OBJECT_SELF, 1);}}
				if(Random(3) == 1) {CreateItemOnObject("abr_it_choker_set", OBJECT_SELF, 1);}
				}
			}				
					
		if(nDestroy == 1)
			{DestroyObject(OBJECT_SELF, fDestroyDelay);}
		}		
}