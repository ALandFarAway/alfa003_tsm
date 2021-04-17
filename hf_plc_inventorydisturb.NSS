//OnInventoryDisturb for all High Forest placeables outside the classrooms
//Wynna April 2021


#include "acr_placeable_i"

void main()
{
	ACR_PlaceableOnDisturbed();
    object oItem = GetModuleItemAcquired();
	object oDisturber = GetLastDisturbed();
	effect eSmoke = EffectVisualEffect(VFX_DUR_SMOKE, FALSE);	
		
	
		 
if((FindSubString(GetTag(OBJECT_SELF), "phalorm_globe")!= -1) && (GetInventoryDisturbType() == 0))
	{object oRelayBlueA = GetObjectByTag("phalorm_crystal_relay_blue_a", 0);
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
	 
	 object oCrystalDiscordA = GetObjectByTag("crystal_discord_a", 0);
	 object oCrystalDiscordB = GetObjectByTag("crystal_discord_b", 0);
	 object oCrystalDiscordC = GetObjectByTag("crystal_discord_c", 0);
	 object oCrystalDiscordD = GetObjectByTag("crystal_discord_d", 0);
	 object oCrystalDiscordE = GetObjectByTag("crystal_discord_e", 0);
	 object oCrystalDiscordF = GetObjectByTag("crystal_discord_f", 0);
	 object oCrystalDiscordG = GetObjectByTag("crystal_discord_g", 0);
	 object oCrystalDiscordH = GetObjectByTag("crystal_discord_h", 0);
	 
	 effect eBeamBlue = EffectBeam(VFX_BEAM_LIGHTNING, OBJECT_SELF, BODY_NODE_CHEST, FALSE);
	 effect eBeamBlueB = EffectBeam(VFX_BEAM_LIGHTNING, oRelayBlueA, BODY_NODE_CHEST, FALSE);
	 effect eBeamBlueC = EffectBeam(VFX_BEAM_LIGHTNING, oRelayBlueB, BODY_NODE_CHEST, FALSE);
	 effect eBeamBlueD = EffectBeam(VFX_BEAM_LIGHTNING, oRelayBlueC, BODY_NODE_CHEST, FALSE);
	 effect eBeamGreen = EffectBeam(VFX_BEAM_GREEN_DRAGON_ACID, OBJECT_SELF, BODY_NODE_CHEST, FALSE);
	 effect eBeamGold = EffectBeam(VFX_SPELL_BEAM_MOON_BOLT, OBJECT_SELF, BODY_NODE_CHEST, FALSE);
	 effect eBeamRed = EffectBeam(VFX_BEAM_FIRE, OBJECT_SELF, BODY_NODE_CHEST, FALSE);
	 effect eBeamOpal = EffectBeam(VFX_BEAM_WEB_OF_PURITY, OBJECT_SELF, BODY_NODE_CHEST, FALSE);
	 
	 effect eSoundBurst = EffectVisualEffect(VFX_FNF_SOUND_BURST, FALSE);
	 effect eSoundBurstSilent = EffectVisualEffect(VFX_FNF_SOUND_BURST_SILENT, FALSE);
	 effect eScreenBump = EffectVisualEffect(VFX_FNF_SCREEN_BUMP, FALSE);
	 effect eScreenShake = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE, FALSE);
	 effect eImplosion = EffectVisualEffect(VFX_FNF_IMPLOSION, FALSE);
	 effect eHowl = EffectVisualEffect(VFX_FNF_HOWL_MIND, FALSE);
	 effect eSoundSpike = EffectVisualEffect(VFX_SOUND_SPIKE, FALSE);
	 
	 
	 effect eExplosionBlue;
	 effect eExplosionGreen;
	 effect eExplosionGold;
	 effect eExplosionRed;
	 effect eExplosionTestA = EffectVisualEffect(VFX_FNF_ELECTRIC_EXPLOSION,FALSE);
	 effect eExplosionTestB = EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_ACID,FALSE);
	 effect eExplosionTestC = EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_EVIL,FALSE);
	 effect eExplosionTestD = EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_FIRE,FALSE);
	 effect eExplosionTestE = EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_GREASE,FALSE);
	 effect eExplosionTestF = EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_MIND,FALSE);
	 effect eExplosionTestG = EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_NATURE,FALSE);
	 effect eExplosionTestH = EffectVisualEffect(VFX_FNF_MYSTICAL_EXPLOSION,FALSE);
	 effect eExplosionTestI = EffectVisualEffect(VFX_IMP_DUST_EXPLOSION,FALSE);
	 
	 effect eSummonBlue = EffectVisualEffect(VFX_FNF_SUMMON_CELESTIAL, FALSE);
	 effect eSummonGreen = EffectVisualEffect(VFX_FNF_NATURES_BALANCE, FALSE);
	 effect eSummonRed = EffectVisualEffect(VFX_FNF_SUMMON_GATE, FALSE);
	 effect eSummonGold = EffectVisualEffect(VFX_FNF_SUMMONDRAGON, FALSE);
	 
	 if(FindSubString(GetTag(oItem), "003_it_phalorm") != -1)
	 	{//ActionSpeakString(GetTag(oItem), TALKVOLUME_TALK);
		 //SendMessageToPC(oDisturber, GetTag(oItem));
		 object oPlatformBlueOn = CreateObject(OBJECT_TYPE_PLACEABLE,"phalorm_platform_active", GetLocation(oWPPlatformBlue));
		 ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eExplosionTestA, OBJECT_SELF, 5.0);
		 ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamBlue, oRelayBlueA, 5.0);
		 DelayCommand(5.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eExplosionTestA, oRelayBlueA, 5.0));
		 DelayCommand(5.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamBlue, oRelayBlueB, 5.0));
		 DelayCommand(10.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eExplosionTestA, oRelayBlueB, 5.0));
		 DelayCommand(10.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamBlue, oRelayBlueC, 5.0));
		 
		 }
	 else{ActionPutDownItem(oItem);
	 	  //DelayCommand(5.0, ActionSpeakString("*Spins, hurling the item back out.", TALKVOLUME_TALK));
	 	  SpawnItemProjectile(OBJECT_SELF, oDisturber, GetLocation(OBJECT_SELF), GetLocation(oDisturber), BASE_ITEM_SLING, PROJECTILE_PATH_TYPE_HIGH_BALLISTIC, OVERRIDE_ATTACK_RESULT_HIT_SUCCESSFUL, DAMAGE_TYPE_COLD);
	 	  ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSoundBurstSilent, OBJECT_SELF, 5.0); 
	      //DelayCommand(5.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSoundSpike, OBJECT_SELF, 5.0)); 
	     }
	 
	  
	 DelayCommand(2.5, ActionSpeakString("ExplodeA", TALKVOLUME_TALK));
	 DelayCommand(2.5, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eExplosionTestA, oRelayBlueA, 5.0));
	 DelayCommand(7.5, ActionSpeakString("ExplodeB", TALKVOLUME_TALK));
	 DelayCommand(7.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eExplosionTestB, oRelayBlueA, 5.0));
	 DelayCommand(12.5, ActionSpeakString("ExplodeC", TALKVOLUME_TALK));
	 DelayCommand(12.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eExplosionTestC, oRelayBlueA, 5.0));
	 DelayCommand(17.5, ActionSpeakString("ExplodeD", TALKVOLUME_TALK));
	 DelayCommand(17.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eExplosionTestD, oRelayBlueA, 5.0));
	 DelayCommand(22.5, ActionSpeakString("ExplodeF", TALKVOLUME_TALK));
	 DelayCommand(22.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eExplosionTestF, oRelayBlueA, 5.0));
	 DelayCommand(27.5, ActionSpeakString("ExplodeG", TALKVOLUME_TALK));
	 DelayCommand(27.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eExplosionTestG, oRelayBlueA, 5.0));
	 DelayCommand(32.5, ActionSpeakString("ExplodeH", TALKVOLUME_TALK));
	 DelayCommand(32.5, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eExplosionTestH, oRelayBlueA, 5.0));
	 DelayCommand(37.5, ActionSpeakString("ExplodeI", TALKVOLUME_TALK));
	 DelayCommand(37.5, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eExplosionTestI, oRelayBlueA, 5.0));
	 DelayCommand(42.5, ActionSpeakString("ExplodeE", TALKVOLUME_TALK));
	 DelayCommand(42.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eExplosionTestE, oRelayBlueA, 5.0));
	 
	 
	 
	 }
}