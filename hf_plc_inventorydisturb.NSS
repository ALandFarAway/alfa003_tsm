//OnInventoryDisturb for all High Forest placeables
//Wynna April 2021


void ActionCreateWynPlace(string sPlace, location lLocPlace)
{
    CreateObject(OBJECT_TYPE_PLACEABLE, sPlace, lLocPlace);
}

void ActionCreateWynCreature(string sCreature, location lLocCreature)
{
    CreateObject(OBJECT_TYPE_CREATURE, sCreature, lLocCreature);
}

void ActionCreateWynPlacedEffect(string sPlacedEffect, location lLocPlaceEffect)
{
    CreateObject(OBJECT_TYPE_PLACED_EFFECT, sPlacedEffect, lLocPlaceEffect);
}

#include "acr_placeable_i"
#include "nw_i0_spells"
#include "acr_spells_i" 

void main()
{
	ACR_PlaceableOnDisturbed();
    object oItem = GetModuleItemAcquired();
	object oDisturber = GetLastDisturbed();
	effect eSmoke = EffectVisualEffect(VFX_DUR_SMOKE, FALSE);	
	object oOrbCreate = GetWaypointByTag("rr_orb_create_wp");
	object oInvisoCaster = GetObjectByTag("003_cr_invis_caster", 0);
	SetFirstName(oInvisoCaster, "Black Orb");
	
	
if(((GetLocalInt(OBJECT_SELF, "Fired") == 0) || (GetIsDM(oDisturber)) || (GetIsDMPossessed(oDisturber))) && (GetTag(OBJECT_SELF) == "phalorm_globe_black") && (GetItemPossessedBy(OBJECT_SELF, "003_it_phalorm_emerald")!= OBJECT_INVALID) && (GetInventoryDisturbType() == 0)) {
	SetLocalInt(OBJECT_SELF, "Fired", 1);
	object oRelayblackA = GetObjectByTag("rauvin_crystal_relay_black_a", 0);
	object oRelayblackB = GetObjectByTag("rauvin_crystal_relay_black_b", 0);
	object oRelayblackC = GetObjectByTag("rauvin_crystal_relay_black_c", 0);
	object oRelayblackD = GetObjectByTag("rauvin_crystal_relay_black_d", 0);
	effect eBeamblackA = EffectBeam(VFX_BEAM_NECROMANCY, oRelayblackA, BODY_NODE_CHEST, FALSE);
	effect eBeamblackB = EffectBeam(VFX_BEAM_NECROMANCY, oRelayblackB, BODY_NODE_CHEST, FALSE);
	effect eBeamblackC = EffectBeam(VFX_BEAM_NECROMANCY, oRelayblackC, BODY_NODE_CHEST, FALSE);
	effect eBeamblackD = EffectBeam(VFX_BEAM_NECROMANCY, oRelayblackD, BODY_NODE_CHEST, FALSE);
	effect eBeamblackCenter = EffectBeam(VFX_BEAM_NECROMANCY, OBJECT_SELF, BODY_NODE_CHEST, FALSE);
	effect eBeamgreenCenter = EffectBeam(VFX_BEAM_ACID, OBJECT_SELF, BODY_NODE_CHEST, FALSE);
	effect eWeb = EffectVisualEffect(VFX_AOE_WEB_OF_PURITY, FALSE);
	effect ePurge = EffectVisualEffect(VFX_AOE_ETHEREAL_PURGE, FALSE);
	effect eBurst = EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_EVIL, FALSE);
	effect eKnockdown = EffectKnockdown();
	effect eNegDamage = EffectDamage(d10()+20, DAMAGE_TYPE_NEGATIVE, DAMAGE_POWER_NORMAL, FALSE);
	effect eDmg = EffectDamage(10, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_NORMAL, TRUE);	
	effect eDmgScarab = EffectDamage(d8(1)+6, DAMAGE_TYPE_PIERCING, DAMAGE_POWER_NORMAL, TRUE);	
	effect eDmgScarabNeg = EffectDamage(d8(1)+6, DAMAGE_TYPE_NEGATIVE, DAMAGE_POWER_NORMAL, TRUE);	
	effect eIon = EffectVisualEffect(VFX_DUR_IOUNSTONE_GREEN, FALSE);
	object oOrb = GetObjectByTag("phalorm_orb_black", 0);
	effect eDispel = EffectAreaOfEffect(61);
	object oGlobe = GetObjectByTag("phalorm_globe_black", 0);
	object oWallN = GetWaypointByTag("aoe_wall_dispel_n");
	object oWallE = GetWaypointByTag("aoe_wall_dispel_e");
	object oWallS = GetWaypointByTag("aoe_wall_dispel_s");
	object oWallW = GetWaypointByTag("aoe_wall_dispel_w");
	effect ePulse = EffectVisualEffect(VFX_IMP_PULSE_FIRE, FALSE);
	
	object oPC = GetFirstPC(TRUE);
	object oJhessi = GetObjectByTag("003_pc_jhessi_2", 0);
	object oNio = GetObjectByTag("003_pc_nioniel_2", 0);;
	object oSaerela = GetObjectByTag("003_pc_saerela_2", 0);
	object oBertilak = GetObjectByTag("003_pc_bertilak_2", 0);
	object oBellie = GetObjectByTag("003_pc_bellie_2", 0);
	object oBae = GetObjectByTag("003_pc_baeithra_2", 0);
	object oAsh = GetObjectByTag("003_pc_asheeleaf_2", 0);
	while(oPC != OBJECT_INVALID) {
		string sPCName = GetName(oPC);
		if(FindSubString(sPCName, "Jhessi") != -1) {
			oJhessi = oPC;
		}
		if(FindSubString(sPCName, "Nio") != -1) {
			oNio = oPC;
		}
		if(FindSubString(sPCName, "Saerel") != -1) {
			oSaerela = oPC;
		}
		if(FindSubString(sPCName, "Bert") != -1) {
			oBertilak = oPC;
		}
		if(FindSubString(sPCName, "Bell") != -1) {
			oBellie = oPC;
		}
		if(FindSubString(sPCName, "Bae") != -1) {
			oBae = oPC;
		}
		if(FindSubString(sPCName, "Ash") != -1) {
			oAsh = oPC;
		}
	oPC = GetNextPC(TRUE);
	}
	
	ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eWeb, GetLocation(OBJECT_SELF), 5.0);
	DelayCommand(1.0, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, ePurge, GetLocation(OBJECT_SELF), 5.0));
	
	DelayCommand(1.0, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eDispel, GetLocation(oWallN), 600.0));
	DelayCommand(1.0, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eDispel, GetLocation(oWallE), 600.0));
	DelayCommand(1.0, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eDispel, GetLocation(oWallS), 600.0));
	DelayCommand(1.0, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eDispel, GetLocation(oWallW), 600.0));
	
	DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamblackA, oRelayblackB, 90.0));
	DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamblackA, oRelayblackC, 90.0));
	DelayCommand(5.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamblackB, oRelayblackD, 86.0));
	DelayCommand(5.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamblackC, oRelayblackD, 86.0));
	
	//10HP
	DelayCommand(5.0, AssignCommand(oInvisoCaster, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmg, oOrb)));	
	DelayCommand(5.0, AssignCommand(oInvisoCaster, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePulse, oOrb)));	
	
	//Nio
	DelayCommand(6.0, SendMessageToPC(oNio, "*A scrabbling at your neck warns you the moment before a cold pain pierces your throat. Your scarab broach has bitten you!"));
	object oScarab = GetItemPossessedBy(oNio, "03_it_amul_scarab_prot");
	AssignCommand(oScarab, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmgScarab, oNio));
	AssignCommand(oScarab, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmgScarabNeg, oNio));
	DestroyObject(oScarab, 7.0);
	DelayCommand(8.0, ActionCreateWynCreature("abr_cr_cn_scarab", GetLocation(oNio)));	
	DelayCommand(10.0, SendMessageToPC(oNio, "*Pulsing in the punctures in your neck, you feel a draw to the black orb, and know the scarab is answering it."));
	DelayCommand(18.0, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, ePurge, GetLocation(OBJECT_SELF), 5.0));
	
	
	DelayCommand(9.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamblackA, OBJECT_SELF, 81.0));
	DelayCommand(9.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamblackB, OBJECT_SELF, 81.0));
	DelayCommand(9.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamblackC, OBJECT_SELF, 81.0));
	DelayCommand(9.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamblackD, OBJECT_SELF, 81.0));
			 
	
	//Sae
	DelayCommand(16.0, SendMessageToPC(oSaerela, "*An emerald green beam appears, playing across your brow."));
	DelayCommand(17.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamgreenCenter, oSaerela, 10.0));
	
	//20HP
	DelayCommand(20.0, AssignCommand(oInvisoCaster, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmg, oOrb)));
	DelayCommand(20.0, AssignCommand(oInvisoCaster, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePulse, oOrb)));	
	
	
	//Sae
	DelayCommand(25.0, SendMessageToPC(oSaerela, "*You sense a familiar echo passing through the emerald green beam. The echo is your own connection to the Drowned Tower you hallowed within the High Forest."));
	
	//Nio
	DelayCommand(25.0, SendMessageToPC(oNio, "*Blood trickles at your throat. In each drop you feel the gathering of something powerful."));
	
	//30HP  40HP
	DelayCommand(35.0, AssignCommand(oInvisoCaster, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmg, oOrb)));
	DelayCommand(35.0, AssignCommand(oInvisoCaster, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePulse, oOrb)));	
	DelayCommand(50.0, AssignCommand(oInvisoCaster, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmg, oOrb)));
	DelayCommand(50.0, AssignCommand(oInvisoCaster, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePulse, oOrb)));	
	
	//Nio
	DelayCommand(45.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamblackCenter, oNio, 10.0));
	DelayCommand(45.0, SendMessageToPC(oNio, "*A red beam strikes you in the throat. A stream of your blood is pulled into it."));
	
	AssignCommand(oOrb, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmgScarabNeg, oNio));
	DelayCommand(55.0, SendMessageToPC(oNio, "*The red beam shuts off. You feel loss...of your blood, and in something else leaving the area, something that required your blood."));
	
	//Sae
	DelayCommand(55.0, SendMessageToPC(oSaerela, "Your connection to the Drowned Tower thrums as if a taut wire stretched from you to it has been plucked. You *feel* a force travelling from this place to the Drowned Tower."));
	
	//50HP 
	DelayCommand(65.0, AssignCommand(oInvisoCaster, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmg, oOrb)));
	DelayCommand(65.0, AssignCommand(oInvisoCaster, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePulse, oOrb)));	
	
	//Sae
	DelayCommand(75.0, SendMessageToPC(oSaerela, "The connection between yourself and the Drowned Tower is plucked once more. The same force is *leaving* there, but this time it is enhanced. It is immensely powerful. And it is coming this way."));
	
	//Sayen create
	DelayCommand(75.0, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, ePurge, GetLocation(OBJECT_SELF), 5.0));
	DelayCommand(75.0, ActionCreateWynCreature("003_cr_slv_gyasisayen", GetLocation(oOrbCreate)));
	
	
	//60HP Glittering chip
	DelayCommand(80.0, AssignCommand(oInvisoCaster, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmg, oOrb)));
	DelayCommand(80.0, AssignCommand(oInvisoCaster, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePulse, oOrb)));	
	//70HP Crack
	DelayCommand(95.0, AssignCommand(oInvisoCaster, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmg, oOrb)));
	DelayCommand(95.0, AssignCommand(oInvisoCaster, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePulse, oOrb)));	
	//80 hp dmg Multiple crack
	DelayCommand(110.0, AssignCommand(oInvisoCaster, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmg, oOrb)));
	DelayCommand(110.0, AssignCommand(oInvisoCaster, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePulse, oOrb)));	
	//90HP Pulsing red
	DelayCommand(130.0, AssignCommand(oInvisoCaster, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmg, oOrb)));
	DelayCommand(130.0, AssignCommand(oInvisoCaster, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePulse, oOrb)));	
	
	//100HP Small flames
	DelayCommand(145.0, AssignCommand(oInvisoCaster, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmg, oOrb)));
	DelayCommand(145.0, AssignCommand(oInvisoCaster, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePulse, oOrb)));	
	//110HP 
	DelayCommand(160.0, AssignCommand(oInvisoCaster, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePulse, oOrb)));	
	DelayCommand(160.0, AssignCommand(oInvisoCaster, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmg, oOrb)));
	
	}
		 
else if((FindSubString(GetTag(OBJECT_SELF), "phalorm_globe")!= -1) && (GetInventoryDisturbType() == 0))
	{object oGlobeBlue = GetObjectByTag("phalorm_globe_blue", 0);
	 object oGlobeGreen = GetObjectByTag("phalorm_globe_green", 0);
	 object oGlobeGold = GetObjectByTag("phalorm_globe_gold", 0);
	 object oGlobeRed = GetObjectByTag("phalorm_globe_red", 0);
	 
	 object oRelayBlueA = GetObjectByTag("phalorm_crystal_relay_blue_a", 0);
	 object oRelayBlueB = GetObjectByTag("phalorm_crystal_relay_blue_b", 0);
	 object oRelayBlueC = GetObjectByTag("phalorm_crystal_relay_blue_c", 0);
	 object oRelayGreenA = GetObjectByTag("phalorm_crystal_relay_green_a", 0);
	 object oRelayGreenB = GetObjectByTag("phalorm_crystal_relay_green_b", 0);
	 object oRelayGreenC = GetObjectByTag("phalorm_crystal_relay_green_c", 0);
	 object oRelayGoldA = GetObjectByTag("phalorm_crystal_relay_gold_a", 0);
	 object oRelayGoldB = GetObjectByTag("phalorm_crystal_relay_gold_b", 0);
	 object oRelayGoldC = GetObjectByTag("phalorm_crystal_relay_gold_c", 0);
	 object oRelayRedA = GetObjectByTag("phalorm_crystal_relay_red_a", 0);
	 object oRelayRedB = GetObjectByTag("phalorm_crystal_relay_red_b", 0);
	 object oRelayRedC = GetObjectByTag("phalorm_crystal_relay_red_c", 0);
	 object oWPOpal = GetWaypointByTag("phalorm_orb_opal_WP");
	 object oWPPlatformBlue = GetWaypointByTag("WP_phalorm_globe_platform_blue");
	 object oWPPlatformGreen = GetWaypointByTag("WP_phalorm_globe_platform_green");
	 object oWPPlatformGold = GetWaypointByTag("WP_phalorm_globe_platform_gold");
	 object oWPPlatformRed = GetWaypointByTag("WP_phalorm_globe_platform_red");
	 object oWPPlatformBook = GetWaypointByTag("WP_phalorm_globe_platform_book");
	 object oWPCreateBlue = GetWaypointByTag("WP_phalorm_create_blue");
	 object oWPCreateGreen = GetWaypointByTag("WP_phalorm_create_green");
	 object oWPCreateGold = GetWaypointByTag("WP_phalorm_create_gold");
	 object oWPCreateRed = GetWaypointByTag("WP_phalorm_create_red");
	 
	 object oCrystalDiscordA = GetObjectByTag("crystal_discord_a", 0);
	 object oCrystalDiscordB = GetObjectByTag("crystal_discord_b", 0);
	 object oCrystalDiscordC = GetObjectByTag("crystal_discord_c", 0);
	 object oCrystalDiscordD = GetObjectByTag("crystal_discord_d", 0);
	 object oCrystalDiscordE = GetObjectByTag("crystal_discord_e", 0);
	 object oCrystalDiscordF = GetObjectByTag("crystal_discord_f", 0);
	 object oCrystalDiscordG = GetObjectByTag("crystal_discord_g", 0);
	 object oCrystalDiscordH = GetObjectByTag("crystal_discord_h", 0);
	 object oCrystalDiscordI = GetObjectByTag("crystal_discord_i", 0);
	 object oCrystalDiscordJ = GetObjectByTag("crystal_discord_j", 0);
	 object oCrystalDiscordK = GetObjectByTag("crystal_discord_k", 0);
	 object oCrystalDiscordL = GetObjectByTag("crystal_discord_l", 0);
	 object oCrystalDiscordM = GetObjectByTag("crystal_discord_m", 0);
	 object oCrystalDiscordN = GetObjectByTag("crystal_discord_n", 0);
	 object oCrystalDiscordO = GetObjectByTag("crystal_discord_o", 0);
	 object oCrystalDiscordP = GetObjectByTag("crystal_discord_p", 0);
	 object oFFieldBlue = GetObjectByTag("hf_aq_door_blue_forcefield", 0);
	 object oFFieldGreen = GetObjectByTag("hf_aq_door_green_forcefield", 0);
	 object oFFieldRed = GetObjectByTag("hf_aq_door_red_forcefield", 0);
	 object oFFieldGold = GetObjectByTag("hf_aq_door_gold_forcefield", 0);
	 object oGateBlue = GetObjectByTag("phalorm_door_blue", 0);
	 object oGateGreen = GetObjectByTag("phalorm_door_green", 0);
	 object oGateRed = GetObjectByTag("phalorm_door_red", 0);
	 object oGateGold = GetObjectByTag("phalorm_door_gold", 0);
	 object oDoorBlue = GetObjectByTag("phalorm_blue_chamber", 0);
	 object oDoorGreen = GetObjectByTag("phalorm_green_chamber", 0);
	 object oDoorRed = GetObjectByTag("phalorm_red_chamber", 0);
	 object oDoorGold = GetObjectByTag("phalorm_gold_chamber", 0);
	 object oGlobeTeleBlue = GetObjectByTag("phalorm_globe_tele_blue", 0);
	 object oGlobeTeleGreen = GetObjectByTag("phalorm_globe_tele_green", 0);
	 object oGlobeBook = GetObjectByTag("phalorm_globe_book", 0);
	 object oWPTeleBlue = GetObjectByTag("WP_phalorm_tele_blue", 0);
	 object oWPTeleGreen = GetObjectByTag("WP_phalorm_tele_green", 0);
	 
	 effect eBeamBlueGlobe = EffectBeam(VFX_BEAM_LIGHTNING, oGlobeTeleBlue, BODY_NODE_CHEST, FALSE);
	 effect eBeamGreenGlobe = EffectBeam(VFX_BEAM_GREEN_DRAGON_ACID, oGlobeTeleGreen, BODY_NODE_CHEST, FALSE);
	 
	 effect eBeamBlue = EffectBeam(VFX_BEAM_LIGHTNING, oGlobeBlue, BODY_NODE_CHEST, FALSE);
	 effect eBeamBlueB = EffectBeam(VFX_BEAM_LIGHTNING, oRelayBlueA, BODY_NODE_CHEST, FALSE);
	 effect eBeamBlueC = EffectBeam(VFX_BEAM_LIGHTNING, oRelayBlueB, BODY_NODE_CHEST, FALSE);
	 effect eBeamBlueD = EffectBeam(VFX_BEAM_LIGHTNING, oRelayBlueC, BODY_NODE_CHEST, FALSE);
	 effect eBeamGreen = EffectBeam(VFX_BEAM_GREEN_DRAGON_ACID, oGlobeGreen, BODY_NODE_CHEST, FALSE);
	 effect eBeamGreenB = EffectBeam(VFX_BEAM_GREEN_DRAGON_ACID, oRelayGreenA, BODY_NODE_CHEST, FALSE);
	 effect eBeamGreenC = EffectBeam(VFX_BEAM_GREEN_DRAGON_ACID, oRelayGreenB, BODY_NODE_CHEST, FALSE);
	 effect eBeamGreenD = EffectBeam(VFX_BEAM_GREEN_DRAGON_ACID, oRelayGreenC, BODY_NODE_CHEST, FALSE);
	 effect eBeamGold = EffectBeam(VFX_BEAM_RESCUEE, oGlobeGold, BODY_NODE_CHEST, FALSE);
	 effect eBeamGoldB = EffectBeam(VFX_BEAM_RESCUEE, oRelayGoldA, BODY_NODE_CHEST, FALSE);
	 effect eBeamGoldC = EffectBeam(VFX_BEAM_RESCUEE, oRelayGoldB, BODY_NODE_CHEST, FALSE);
	 effect eBeamGoldD = EffectBeam(VFX_BEAM_RESCUEE, oRelayGoldC, BODY_NODE_CHEST, FALSE);
	 effect eBeamRed = EffectBeam(VFX_BEAM_FIRE, oGlobeRed, BODY_NODE_CHEST, FALSE);
	 effect eBeamRedB = EffectBeam(VFX_BEAM_FIRE, oRelayRedA, BODY_NODE_CHEST, FALSE);
	 effect eBeamRedC = EffectBeam(VFX_BEAM_FIRE, oRelayRedB, BODY_NODE_CHEST, FALSE);
	 effect eBeamRedD = EffectBeam(VFX_BEAM_FIRE, oRelayRedC, BODY_NODE_CHEST, FALSE);
	 effect eBeamOpal = EffectBeam(VFX_BEAM_WEB_OF_PURITY, OBJECT_SELF, BODY_NODE_CHEST, FALSE);
	 
	 effect eSoundBurst = EffectVisualEffect(VFX_FNF_SOUND_BURST, FALSE);
	 effect eSoundBurstSilent = EffectVisualEffect(VFX_FNF_SOUND_BURST_SILENT, FALSE);
	 effect eScreenBump = EffectVisualEffect(VFX_FNF_SCREEN_BUMP, FALSE);
	 effect eScreenShake = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE, FALSE);
	 effect eImplosion = EffectVisualEffect(VFX_FNF_IMPLOSION, FALSE);
	 effect eHowl = EffectVisualEffect(VFX_FNF_HOWL_MIND, FALSE);
	 effect eSoundSpike = EffectVisualEffect(VFX_SOUND_SPIKE, FALSE);
	 effect eChunk = EffectVisualEffect(VFX_COM_CHUNK_STONE_MEDIUM, FALSE);
	 effect eExplosion = EffectVisualEffect(VFX_FNF_ELECTRIC_EXPLOSION,FALSE);
	 
	 effect eSummonBlue = EffectVisualEffect(VFX_FNF_SUMMON_CELESTIAL, FALSE);
	 effect eSummonGreen = EffectVisualEffect(VFX_DUR_ENTANGLE, FALSE);
	 effect eSummonRed = EffectVisualEffect(VFX_FNF_SUMMON_GATE, FALSE);
	 effect eSummonGold = EffectVisualEffect(VFX_FNF_SUMMONDRAGON, FALSE);
	 
	 if((GetItemPossessedBy(oGlobeTeleBlue, "003_it_phalorm_diamond")!= OBJECT_INVALID) || (GetItemPossessedBy(oGlobeBlue, "003_it_phalorm_sapphire")!= OBJECT_INVALID)) {
	 	if(GetItemPossessedBy(oGlobeBlue, "003_it_phalorm_sapphire")!= OBJECT_INVALID) {
			DestroyObject(GetItemPossessedBy(oGlobeBlue, "003_it_phalorm_sapphire"), 1.0);
			CreateItemOnObject("003_it_phalorm_sapphire", oDisturber, 1);
			}
		object oPlatformBookOn = CreateObject(OBJECT_TYPE_PLACEABLE,"phalorm_platform_active", GetLocation(oWPPlatformBook));
		object oLightOn = CreateObject(OBJECT_TYPE_PLACED_EFFECT,"fx_gem_energy_blue", GetLocation(oDisturber));
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamBlueGlobe, oGlobeBook, 10.0);
		DelayCommand(2.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSummonBlue, oDisturber, 5.0));
		DelayCommand(5.0, AssignCommand(oDisturber, ActionJumpToObject(oWPTeleBlue, FALSE)));
		DestroyObject(oFFieldBlue, 5.0);
		DestroyObject(oPlatformBookOn, 10.0);
		DestroyObject(oLightOn, 10.0);
			 	 	 	 	 	 
	 }
	 
	 if((GetItemPossessedBy(oGlobeTeleGreen, "003_it_phalorm_diamond")!= OBJECT_INVALID) || (GetItemPossessedBy(oGlobeGreen, "003_it_phalorm_emerald")!= OBJECT_INVALID)) {
	 	if(GetItemPossessedBy(oGlobeTeleGreen, "003_it_phalorm_emerald")!= OBJECT_INVALID) {
			DestroyObject(GetItemPossessedBy(oGlobeBlue, "003_it_phalorm_emerald"), 1.0);
			CreateItemOnObject("003_it_phalorm_emerald", oDisturber, 1);
			}
		object oPlatformBookOn = CreateObject(OBJECT_TYPE_PLACEABLE,"phalorm_platform_active", GetLocation(oWPPlatformBook));
		object oLightOn = CreateObject(OBJECT_TYPE_PLACED_EFFECT,"fx_gem_energy_green", GetLocation(oDisturber));
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamGreenGlobe, oGlobeBook, 10.0);
		DelayCommand(2.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSummonGreen, oDisturber, 5.0));
		DelayCommand(5.0, AssignCommand(oDisturber, ActionJumpToObject(oWPTeleGreen, FALSE)));
		DestroyObject(oFFieldGreen, 5.0);
		DestroyObject(oPlatformBookOn, 10.0);
		DestroyObject(oLightOn, 10.0);	 	 	 	 	 	 
	 }
	 
	 if(GetItemPossessedBy(oGlobeBlue, "003_it_phalorm_sapphire")!= OBJECT_INVALID) {
		     object oPlatformBlueOn = CreateObject(OBJECT_TYPE_PLACEABLE,"phalorm_platform_active", GetLocation(oWPPlatformBlue));
			 DelayCommand(2.0, ActionCreateWynPlacedEffect("fx_gem_energy_blue", GetLocation(oWPPlatformBlue)));
			 ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eExplosion, OBJECT_SELF, 5.0);
			 ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamBlue, oRelayBlueA, 310.0);
			 DelayCommand(5.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eExplosion, oRelayBlueA, 5.0));
			 DelayCommand(5.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamBlueB, oRelayBlueB, 305.0));
			 DelayCommand(10.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eExplosion, oRelayBlueB, 5.0));
			 DelayCommand(10.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamBlueC, oRelayBlueC, 300.0));
			 DelayCommand(15.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSummonBlue, OBJECT_SELF, 5.0));
			 DelayCommand(20.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSummonBlue, oRelayBlueA, 5.0));
			 DelayCommand(25.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSummonBlue, oRelayBlueB, 5.0));
			 DelayCommand(30.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSummonBlue, oRelayBlueC, 5.0));
			 DelayCommand(35.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eExplosion, oCrystalDiscordA, 5.0));
			 DelayCommand(40.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eExplosion, oCrystalDiscordB, 5.0));
			 DelayCommand(45.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eExplosion, oCrystalDiscordC, 5.0));
			 DelayCommand(50.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eExplosion, oCrystalDiscordD, 5.0));
			 DelayCommand(52.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSummonBlue, oCrystalDiscordA, 5.0));
			 DelayCommand(54.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSummonBlue, oCrystalDiscordB, 5.0));
			 DelayCommand(56.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSummonBlue, oCrystalDiscordC, 5.0));
			 DelayCommand(58.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSummonBlue, oCrystalDiscordD, 5.0));
			 DelayCommand(55.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eChunk, oCrystalDiscordA, 5.0));
			 DelayCommand(57.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eChunk, oCrystalDiscordB, 5.0));
			 DelayCommand(59.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eChunk, oCrystalDiscordC, 5.0));
			 DelayCommand(61.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eChunk, oCrystalDiscordD, 5.0));
			 DestroyObject(oDoorBlue, 50.0);
			 DelayCommand(51.0, ActionUnlockObject(oGateBlue));
			 DestroyObject(oCrystalDiscordA, 55.0);
			 DestroyObject(oCrystalDiscordB, 57.0);
			 DestroyObject(oCrystalDiscordC, 59.0);
			 DestroyObject(oCrystalDiscordD, 61.0);
			 DestroyObject(oFFieldBlue, 65.0);
			 }
			 
		 if ((GetTag(OBJECT_SELF) == "phalorm_globe_blue") && (GetItemPossessedBy(OBJECT_SELF, "003_it_phalorm_sapphire")== OBJECT_INVALID))  {
		      ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSmoke, OBJECT_SELF, 25.0); 
		      DelayCommand(5.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSoundSpike, OBJECT_SELF, 5.0)); 
		      DelayCommand(10.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSummonBlue, OBJECT_SELF, 5.0));
			  DelayCommand(12.0, ActionCreateWynCreature("abr_cr_el_airweird", GetLocation(oWPCreateBlue)));
			  DelayCommand(15.0, ActionSpeakString("*A hazy bubble the height of the door forms around the platform, pushing water outward in a sphere.", TALKVOLUME_TALK));
			  DelayCommand(20.0, AssignCommand(GetObjectByTag("abr_cr_el_airweird", 0), ActionSpeakString("You have chosen...poorly.", TALKVOLUME_TALK)));
			  DelayCommand(25.0, AssignCommand(GetObjectByTag("abr_cr_el_airweird", 0), ActionCastSpellAtObject(SPELL_GLOBE_OF_INVULNERABILITY, GetObjectByTag("abr_cr_el_airweird", 0), METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
			  DelayCommand(30.0, AssignCommand(GetObjectByTag("abr_cr_el_airweird", 0), ActionSpeakString("You have ten seconds to depart this guardian's sight.", TALKVOLUME_TALK)));
			  DelayCommand(40.0, ChangeToStandardFaction(GetObjectByTag("abr_cr_el_airweird", 0),STANDARD_FACTION_HOSTILE));
			  }
		
		if(GetItemPossessedBy(oGlobeGreen, "003_it_phalorm_emerald")!= OBJECT_INVALID) {
		     object oPlatformGreenOn = CreateObject(OBJECT_TYPE_PLACEABLE,"phalorm_platform_active", GetLocation(oWPPlatformGreen));
			 DelayCommand(2.0, ActionCreateWynPlacedEffect("fx_gem_energy_green", GetLocation(oWPPlatformGreen)));
			 ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eExplosion, OBJECT_SELF, 5.0);
			 ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamGreen, oRelayGreenA, 310.0);
			 DelayCommand(5.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eExplosion, oRelayGreenA, 5.0));
			 DelayCommand(5.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamGreenB, oRelayGreenB, 305.0));
			 DelayCommand(10.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eExplosion, oRelayGreenB, 5.0));
			 DelayCommand(10.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamGreenC, oRelayGreenC, 300.0));
			 DelayCommand(15.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSummonGreen, OBJECT_SELF, 5.0));
			 DelayCommand(20.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSummonGreen, oRelayGreenA, 5.0));
			 DelayCommand(25.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSummonGreen, oRelayGreenB, 5.0));
			 DelayCommand(30.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSummonGreen, oRelayGreenC, 5.0));
			 DelayCommand(35.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eExplosion, oCrystalDiscordE, 5.0));
			 DelayCommand(40.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eExplosion, oCrystalDiscordF, 5.0));
			 DelayCommand(45.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eExplosion, oCrystalDiscordG, 5.0));
			 DelayCommand(50.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eExplosion, oCrystalDiscordH, 5.0));
			 DelayCommand(52.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSummonGreen, oCrystalDiscordE, 5.0));
			 DelayCommand(54.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSummonGreen, oCrystalDiscordF, 5.0));
			 DelayCommand(56.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSummonGreen, oCrystalDiscordG, 5.0));
			 DelayCommand(58.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSummonGreen, oCrystalDiscordH, 5.0));
			 DelayCommand(55.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eChunk, oCrystalDiscordE, 5.0));
			 DelayCommand(57.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eChunk, oCrystalDiscordF, 5.0));
			 DelayCommand(59.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eChunk, oCrystalDiscordG, 5.0));
			 DelayCommand(61.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eChunk, oCrystalDiscordH, 5.0));
			 DestroyObject(oDoorGreen, 50.0);
			 DestroyObject(oCrystalDiscordE, 55.0);
			 DestroyObject(oCrystalDiscordF, 57.0);
			 DestroyObject(oCrystalDiscordG, 59.0);
			 DestroyObject(oCrystalDiscordH, 61.0);
			 DestroyObject(oFFieldGreen, 65.0);
			 }
		 if ((GetTag(OBJECT_SELF) == "phalorm_globe_green") && (GetItemPossessedBy(OBJECT_SELF, "003_it_phalorm_emerald")== OBJECT_INVALID)) {
		      ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSoundBurstSilent, OBJECT_SELF, 5.0); 
		      DelayCommand(5.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSoundSpike, OBJECT_SELF, 5.0)); 
		      DelayCommand(10.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSummonGreen, OBJECT_SELF, 5.0));
			  DelayCommand(12.0, ActionCreateWynCreature("abr_cr_el_earthweird", GetLocation(oWPCreateGreen)));
			  DelayCommand(15.0, ActionSpeakString("*A muddy bubble the height of the door forms around the platform, pushing water outward in a sphere.", TALKVOLUME_TALK));
			  DelayCommand(20.0, AssignCommand(GetObjectByTag("abr_cr_el_earthweird", 0), ActionSpeakString("You have chosen...poorly.", TALKVOLUME_TALK)));
			  DelayCommand(25.0, AssignCommand(GetObjectByTag("abr_cr_el_earthweird", 0), ActionCastSpellAtObject(SPELL_GLOBE_OF_INVULNERABILITY, GetObjectByTag("abr_cr_el_earthweird", 0), METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
			  DelayCommand(30.0, AssignCommand(GetObjectByTag("abr_cr_el_earthweird", 0), ActionSpeakString("You have ten of your heartbeats to depart this guardian's sight.", TALKVOLUME_TALK)));
			  DelayCommand(40.0, ChangeToStandardFaction(GetObjectByTag("abr_cr_el_earthweird", 0),STANDARD_FACTION_HOSTILE));
			  }
			  
		 if(GetItemPossessedBy(oGlobeGold, "003_it_phalorm_topaz")!= OBJECT_INVALID) {
		     object oPlatformGoldOn = CreateObject(OBJECT_TYPE_PLACEABLE,"phalorm_platform_active", GetLocation(oWPPlatformGold));
			 DelayCommand(2.0, ActionCreateWynPlacedEffect("fx_gem_energy_yellow", GetLocation(oWPPlatformGold)));
			 ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eExplosion, OBJECT_SELF, 5.0);
			 ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamGold, oRelayGoldA, 310.0);
			 DelayCommand(5.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eExplosion, oRelayGoldA, 5.0));
			 DelayCommand(5.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamGoldB, oRelayGoldB, 305.0));
			 DelayCommand(10.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eExplosion, oRelayGoldB, 5.0));
			 DelayCommand(10.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamGoldC, oRelayGoldC, 300.0));
			 DelayCommand(15.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSummonGold, OBJECT_SELF, 5.0));
			 DelayCommand(20.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSummonGold, oRelayGoldA, 5.0));
			 DelayCommand(25.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSummonGold, oRelayGoldB, 5.0));
			 DelayCommand(30.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSummonGold, oRelayGoldC, 5.0));
			 DelayCommand(35.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eExplosion, oCrystalDiscordI, 5.0));
			 DelayCommand(40.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eExplosion, oCrystalDiscordJ, 5.0));
			 DelayCommand(45.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eExplosion, oCrystalDiscordK, 5.0));
			 DelayCommand(50.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eExplosion, oCrystalDiscordL, 5.0));
			 DelayCommand(52.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSummonGold, oCrystalDiscordI, 5.0));
			 DelayCommand(54.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSummonGold, oCrystalDiscordJ, 5.0));
			 DelayCommand(56.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSummonGold, oCrystalDiscordK, 5.0));
			 DelayCommand(58.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSummonGold, oCrystalDiscordL, 5.0));
			 DelayCommand(55.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eChunk, oCrystalDiscordI, 5.0));
			 DelayCommand(57.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eChunk, oCrystalDiscordJ, 5.0));
			 DelayCommand(59.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eChunk, oCrystalDiscordK, 5.0));
			 DelayCommand(61.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eChunk, oCrystalDiscordL, 5.0));
			 DestroyObject(oDoorGold, 50.0);
			 DestroyObject(oCrystalDiscordI, 55.0);
			 DestroyObject(oCrystalDiscordJ, 57.0);
			 DestroyObject(oCrystalDiscordK, 59.0);
			 DestroyObject(oCrystalDiscordL, 61.0);
			 DestroyObject(oFFieldGold, 65.0);
			 }
		 if ((GetTag(OBJECT_SELF) == "phalorm_globe_gold") && (GetItemPossessedBy(OBJECT_SELF, "003_it_phalorm_topaz")== OBJECT_INVALID)) {
		      ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSoundBurstSilent, OBJECT_SELF, 5.0); 
		      DelayCommand(5.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSoundSpike, OBJECT_SELF, 5.0)); 
		      DelayCommand(10.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSummonGold, OBJECT_SELF, 5.0));
			  DelayCommand(12.0, ActionCreateWynCreature("abr_cr_el_waterweird", GetLocation(oWPCreateGold)));
			  DelayCommand(15.0, AssignCommand(GetObjectByTag("abr_cr_el_waterweird", 0), ActionSpeakString("You have chosen...poorly.", TALKVOLUME_TALK)));
			  DelayCommand(20.0, AssignCommand(GetObjectByTag("abr_cr_el_waterweird", 0), ActionCastSpellAtObject(SPELL_GLOBE_OF_INVULNERABILITY, GetObjectByTag("abr_cr_el_waterweird", 0), METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
			  DelayCommand(25.0, AssignCommand(GetObjectByTag("abr_cr_el_waterweird", 0), ActionSpeakString("You have ten of your heartbeats to depart my sight.", TALKVOLUME_TALK)));
			  DelayCommand(35.0, ChangeToStandardFaction(GetObjectByTag("abr_cr_el_waterweird", 0),STANDARD_FACTION_HOSTILE));
			  }
			  
		if(GetItemPossessedBy(oGlobeRed, "003_it_phalorm_beryl")!= OBJECT_INVALID) {
		     object oPlatformRedOn = CreateObject(OBJECT_TYPE_PLACEABLE,"phalorm_platform_active", GetLocation(oWPPlatformRed));
			 DelayCommand(2.0, ActionCreateWynPlacedEffect("fx_gem_energy_orange", GetLocation(oWPPlatformRed)));
			 ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eExplosion, OBJECT_SELF, 5.0);
			 ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamRed, oRelayRedA, 310.0);
			 DelayCommand(5.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eExplosion, oRelayRedA, 5.0));
			 DelayCommand(5.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamRedB, oRelayRedB, 305.0));
			 DelayCommand(10.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eExplosion, oRelayRedB, 5.0));
			 DelayCommand(10.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamRedC, oRelayRedC, 300.0));
			 DelayCommand(15.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSummonRed, OBJECT_SELF, 5.0));
			 DelayCommand(20.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSummonRed, oRelayRedA, 5.0));
			 DelayCommand(25.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSummonRed, oRelayRedB, 5.0));
			 DelayCommand(30.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSummonRed, oRelayRedC, 5.0));
			 DelayCommand(35.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eExplosion, oCrystalDiscordM, 5.0));
			 DelayCommand(40.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eExplosion, oCrystalDiscordN, 5.0));
			 DelayCommand(45.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eExplosion, oCrystalDiscordO, 5.0));
			 DelayCommand(50.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eExplosion, oCrystalDiscordP, 5.0));
			 DelayCommand(52.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSummonRed, oCrystalDiscordM, 5.0));
			 DelayCommand(54.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSummonRed, oCrystalDiscordN, 5.0));
			 DelayCommand(56.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSummonRed, oCrystalDiscordO, 5.0));
			 DelayCommand(58.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSummonRed, oCrystalDiscordP, 5.0));
			 DelayCommand(55.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eChunk, oCrystalDiscordM, 5.0));
			 DelayCommand(57.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eChunk, oCrystalDiscordN, 5.0));
			 DelayCommand(59.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eChunk, oCrystalDiscordO, 5.0));
			 DelayCommand(61.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eChunk, oCrystalDiscordP, 5.0));
			 DestroyObject(oDoorRed, 50.0);
			 DestroyObject(oCrystalDiscordM, 55.0);
			 DestroyObject(oCrystalDiscordN, 57.0);
			 DestroyObject(oCrystalDiscordO, 59.0);
			 DestroyObject(oCrystalDiscordP, 61.0);
			 DestroyObject(oFFieldRed, 65.0);
			 }
		if((GetTag(OBJECT_SELF) == "phalorm_globe_red") && (GetItemPossessedBy(OBJECT_SELF, "003_it_phalorm_beryl")== OBJECT_INVALID)){
		      ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSoundBurstSilent, OBJECT_SELF, 5.0); 
		      DelayCommand(5.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSoundSpike, OBJECT_SELF, 5.0)); 
		      DelayCommand(10.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSummonRed, OBJECT_SELF, 5.0));
			  DelayCommand(12.0, ActionCreateWynCreature("", GetLocation(oWPCreateRed)));
			  DelayCommand(15.0, ActionSpeakString("*A smoky bubble the height of the door forms around the platform, pushing water outward in a sphere.", TALKVOLUME_TALK));
			  DelayCommand(20.0, AssignCommand(GetObjectByTag("abr_cr_el_fireweird", 0), ActionSpeakString("You have chosen...poorly.", TALKVOLUME_TALK)));
			  DelayCommand(25.0, AssignCommand(GetObjectByTag("abr_cr_el_fireweird", 0), ActionCastSpellAtObject(SPELL_GLOBE_OF_INVULNERABILITY, GetObjectByTag("abr_cr_el_fireweird", 0), METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
			  DelayCommand(30.0, AssignCommand(GetObjectByTag("abr_cr_el_fireweird", 0), ActionSpeakString("You have ten of your heartbeats to depart this guardian's sight.", TALKVOLUME_TALK)));
			  DelayCommand(40.0, ChangeToStandardFaction(GetObjectByTag("abr_cr_el_fireweird", 0),STANDARD_FACTION_HOSTILE));
			  }
			  
		if((GetItemPossessedBy(oGlobeBlue, "003_it_phalorm_sapphire")!= OBJECT_INVALID) && (GetItemPossessedBy(oGlobeGreen, "003_it_phalorm_emerald")!= OBJECT_INVALID)) {
		 	 DelayCommand(40.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamGreenD, oCrystalDiscordM, 20.0));
			 DelayCommand(40.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamBlueD, oCrystalDiscordN, 20.0));
			 DelayCommand(50.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSummonRed, oCrystalDiscordM, 5.0));
			 DelayCommand(55.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eChunk, oCrystalDiscordM, 5.0));
			 DestroyObject(oCrystalDiscordM, 58.0);
			 DelayCommand(50.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSummonRed, oCrystalDiscordN, 5.0));
			 DelayCommand(55.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eChunk, oCrystalDiscordN, 5.0));
			 DelayCommand(57.0, PlaySound("as_cv_glasbreak3"));
			 DelayCommand(59.0, PlaySound("as_cv_glasbreak3"));
			 DelayCommand(60.0, PlaySound("as_cv_glasbreak3"));
			 DestroyObject(oCrystalDiscordN, 58.0);
			 DestroyObject(oGateRed, 60.0);
			 }
		if((GetItemPossessedBy(oGlobeBlue, "003_it_phalorm_sapphire")!= OBJECT_INVALID) && (GetItemPossessedBy(oGlobeGreen, "003_it_phalorm_emerald")!= OBJECT_INVALID)  && (GetItemPossessedBy(oGlobeRed, "003_it_phalorm_beryl")!= OBJECT_INVALID)) {
		 	 DelayCommand(40.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamGreenD, oCrystalDiscordI, 20.0));
			 DelayCommand(40.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamBlueD, oCrystalDiscordJ, 20.0));
			 DelayCommand(40.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamRedD, oCrystalDiscordJ, 20.0));
			 DelayCommand(50.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSummonGold, oCrystalDiscordI, 5.0));
			 DelayCommand(55.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eChunk, oCrystalDiscordI, 5.0));
			 DelayCommand(57.0, PlaySound("as_cv_glasbreak3"));
			 DelayCommand(59.0, PlaySound("as_cv_glasbreak3"));
			 DelayCommand(60.0, PlaySound("as_cv_glasbreak3"));
			 DestroyObject(oCrystalDiscordI, 58.0);
			 DestroyObject(oGateGold, 60.0);
			 }
		}
}