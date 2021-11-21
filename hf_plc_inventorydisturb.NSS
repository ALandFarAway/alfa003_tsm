//OnInventoryDisturb for all High Forest placeables outside the classrooms
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

void main()
{
	ACR_PlaceableOnDisturbed();
    object oItem = GetModuleItemAcquired();
	object oDisturber = GetLastDisturbed();
	effect eSmoke = EffectVisualEffect(VFX_DUR_SMOKE, FALSE);	
		
	

		 
if((FindSubString(GetTag(OBJECT_SELF), "phalorm_globe")!= -1) && (GetInventoryDisturbType() == 0))
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
	 
	 if(GetItemPossessedBy(oGlobeTeleBlue, "003_it_phalorm_diamond")!= OBJECT_INVALID) {
	 	object oPlatformBookOn = CreateObject(OBJECT_TYPE_PLACEABLE,"phalorm_platform_active", GetLocation(oWPPlatformBook));
		object oLightOn = CreateObject(OBJECT_TYPE_PLACED_EFFECT,"fx_gem_energy_blue", GetLocation(oDisturber));
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamBlueGlobe, oGlobeBook, 10.0);
		DelayCommand(2.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSummonBlue, oDisturber, 5.0));
		DelayCommand(5.0, AssignCommand(oDisturber, ActionJumpToObject(oWPTeleBlue, FALSE)));
		DestroyObject(oPlatformBookOn, 10.0);
		DestroyObject(oLightOn, 10.0);	 	 	 	 	 	 
	 }
	 
	 if(GetItemPossessedBy(oGlobeTeleGreen, "003_it_phalorm_diamond")!= OBJECT_INVALID) {
	 	object oPlatformBookOn = CreateObject(OBJECT_TYPE_PLACEABLE,"phalorm_platform_active", GetLocation(oWPPlatformBook));
		object oLightOn = CreateObject(OBJECT_TYPE_PLACED_EFFECT,"fx_gem_energy_green", GetLocation(oDisturber));
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamGreenGlobe, oGlobeBook, 10.0);
		DelayCommand(2.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSummonGreen, oDisturber, 5.0));
		DelayCommand(5.0, AssignCommand(oDisturber, ActionJumpToObject(oWPTeleGreen, FALSE)));
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