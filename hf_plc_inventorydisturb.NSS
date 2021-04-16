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
	 object oCrystalDiscordA = GetObjectByTag("crystal_discord_a", 0);
	 object oCrystalDiscordB = GetObjectByTag("crystal_discord_b", 0);
	 object oCrystalDiscordC = GetObjectByTag("crystal_discord_c", 0);
	 object oCrystalDiscordD = GetObjectByTag("crystal_discord_d", 0);
	 object oCrystalDiscordE = GetObjectByTag("crystal_discord_e", 0);
	 object oCrystalDiscordF = GetObjectByTag("crystal_discord_f", 0);
	 object oCrystalDiscordG = GetObjectByTag("crystal_discord_g", 0);
	 object oCrystalDiscordH = GetObjectByTag("crystal_discord_h", 0);
	 
	 effect eBeamBlue;
	 effect eBeamGreen;
	 effect eBeamGold;
	 effect eBeamRed;
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
	 
	 effect eBeamTestA = EffectBeam(VFX_BEAM_ABJURATION, OBJECT_SELF, BODY_NODE_CHEST, FALSE);
	 effect eBeamTestB = EffectBeam(VFX_BEAM_ACID, OBJECT_SELF, BODY_NODE_CHEST, FALSE);
	 effect eBeamTestC = EffectBeam(VFX_BEAM_BLACK, OBJECT_SELF, BODY_NODE_CHEST, FALSE);
	 effect eBeamTestD = EffectBeam(VFX_BEAM_CHAIN, OBJECT_SELF, BODY_NODE_CHEST, FALSE);
	 effect eBeamTestE = EffectBeam(VFX_BEAM_COLD, OBJECT_SELF, BODY_NODE_CHEST, FALSE);
	 effect eBeamTestF = EffectBeam(VFX_BEAM_CONJURATION, OBJECT_SELF, BODY_NODE_CHEST, FALSE);
	 effect eBeamTestG = EffectBeam(VFX_BEAM_CURES, OBJECT_SELF, BODY_NODE_CHEST, FALSE);
	 effect eBeamTestH = EffectBeam(VFX_BEAM_DIVINATION, OBJECT_SELF, BODY_NODE_CHEST, FALSE);
	 effect eBeamTestI = EffectBeam(VFX_BEAM_ELDRITCH, OBJECT_SELF, BODY_NODE_CHEST, FALSE);
	 effect eBeamTestJ = EffectBeam(VFX_BEAM_ENCHANTMENT, OBJECT_SELF, BODY_NODE_CHEST, FALSE);
	 effect eBeamTestK = EffectBeam(VFX_BEAM_EVIL, OBJECT_SELF, BODY_NODE_CHEST, FALSE);
	 effect eBeamTestL = EffectBeam(VFX_BEAM_EVOCATION, OBJECT_SELF, BODY_NODE_CHEST, FALSE);
	 effect eBeamTestM = EffectBeam(VFX_BEAM_FIRE, OBJECT_SELF, BODY_NODE_CHEST, FALSE);
	 effect eBeamTestN = EffectBeam(VFX_BEAM_FIRE_LASH, OBJECT_SELF, BODY_NODE_CHEST, FALSE);
	 effect eBeamTestO = EffectBeam(VFX_BEAM_FIRE_W, OBJECT_SELF, BODY_NODE_CHEST, FALSE);
	 effect eBeamTestP = EffectBeam(VFX_BEAM_FIRE_W_SILENT, OBJECT_SELF, BODY_NODE_CHEST, FALSE);
	 effect eBeamTestQ = EffectBeam(VFX_BEAM_GREEN_DRAGON_ACID, OBJECT_SELF, BODY_NODE_CHEST, FALSE);
	 effect eBeamTestR = EffectBeam(VFX_BEAM_HOLY, OBJECT_SELF, BODY_NODE_CHEST, FALSE);
	 effect eBeamTestS = EffectBeam(VFX_BEAM_ICE, OBJECT_SELF, BODY_NODE_CHEST, FALSE);
	 effect eBeamTestT = EffectBeam(VFX_BEAM_ILLUSION, OBJECT_SELF, BODY_NODE_CHEST, FALSE);
	 effect eBeamTestU = EffectBeam(VFX_BEAM_LIGHTNING, OBJECT_SELF, BODY_NODE_CHEST, FALSE);
	 effect eBeamTestV = EffectBeam(VFX_BEAM_MAGIC, OBJECT_SELF, BODY_NODE_CHEST, FALSE);
	 effect eBeamTestW = EffectBeam(VFX_BEAM_MIND, OBJECT_SELF, BODY_NODE_CHEST, FALSE);
	 effect eBeamTestX = EffectBeam(VFX_BEAM_NECROMANCY, OBJECT_SELF, BODY_NODE_CHEST, FALSE);
	 effect eBeamTestY = EffectBeam(VFX_BEAM_ODD, OBJECT_SELF, BODY_NODE_CHEST, FALSE);
	 effect eBeamTestZ = EffectBeam(VFX_BEAM_POISON, OBJECT_SELF, BODY_NODE_CHEST, FALSE);
	 effect eBeamTestZA = EffectBeam(VFX_BEAM_PRISMATIC_SPRAY, OBJECT_SELF, BODY_NODE_CHEST, FALSE);
	 effect eBeamTestZB = EffectBeam(VFX_BEAM_RESCUEE, OBJECT_SELF, BODY_NODE_CHEST, FALSE);
	 effect eBeamTestZC = EffectBeam(VFX_BEAM_SHOCKING_GRASP, OBJECT_SELF, BODY_NODE_CHEST, FALSE);
	 effect eBeamTestZD = EffectBeam(VFX_BEAM_SILENT_COLD, OBJECT_SELF, BODY_NODE_CHEST, FALSE);
	 effect eBeamTestZE = EffectBeam(VFX_BEAM_SILENT_EVIL, OBJECT_SELF, BODY_NODE_CHEST, FALSE);
	 effect eBeamTestZF = EffectBeam(VFX_BEAM_SILENT_FIRE, OBJECT_SELF, BODY_NODE_CHEST, FALSE);
	 effect eBeamTestAA = EffectBeam(VFX_BEAM_SILENT_HOLY, OBJECT_SELF, BODY_NODE_CHEST, FALSE);
	 effect eBeamTestBB = EffectBeam(VFX_BEAM_SILENT_LIGHTNING, OBJECT_SELF, BODY_NODE_CHEST, FALSE);
	 effect eBeamTestCC = EffectBeam(VFX_BEAM_SILENT_MIND, OBJECT_SELF, BODY_NODE_CHEST, FALSE);
	 effect eBeamTestDD = EffectBeam(VFX_BEAM_SILENT_ODD, OBJECT_SELF, BODY_NODE_CHEST, FALSE);
	 effect eBeamTestEE = EffectBeam(VFX_BEAM_SONIC, OBJECT_SELF, BODY_NODE_CHEST, FALSE);
	 effect eBeamTestFF = EffectBeam(VFX_BEAM_TRANSMUTATION, OBJECT_SELF, BODY_NODE_CHEST, FALSE);
	 effect eBeamTestGG = EffectBeam(VFX_BEAM_WEB_OF_PURITY, OBJECT_SELF, BODY_NODE_CHEST, FALSE);
	 effect eBeamTestHH = EffectBeam(VFX_FNF_SUNBEAM, OBJECT_SELF, BODY_NODE_CHEST, FALSE);
	 effect eBeamTestII = EffectBeam(VFX_SPELL_BEAM_MOON_BOLT, OBJECT_SELF, BODY_NODE_CHEST, FALSE);
	 
	 effect eSummonBlue = EffectVisualEffect(VFX_FNF_SUMMON_CELESTIAL, FALSE);
	 effect eSummonGreen = EffectVisualEffect(VFX_FNF_NATURES_BALANCE, FALSE);
	 effect eSummonRed = EffectVisualEffect(VFX_FNF_SUMMON_GATE, FALSE);
	 effect eSummonGold = EffectVisualEffect(VFX_FNF_SUMMONDRAGON, FALSE);
	 
	 if(FindSubString(GetTag(oItem), "003_it_phalorm") != -1)
	 	{ActionSpeakString(GetTag(oItem), TALKVOLUME_TALK);
		 SendMessageToPC(oDisturber, GetTag(oItem));
		 }
	 else{ActionPutDownItem(oItem);
	 	  DelayCommand(5.0, ActionSpeakString("*Spins, hurling the item back out.", TALKVOLUME_TALK));
	 	  SpawnItemProjectile(OBJECT_SELF, oDisturber, GetLocation(OBJECT_SELF), GetLocation(oDisturber), BASE_ITEM_SLING, PROJECTILE_PATH_TYPE_HIGH_BALLISTIC, OVERRIDE_ATTACK_RESULT_HIT_SUCCESSFUL, DAMAGE_TYPE_COLD);
	 	  ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSoundBurstSilent, OBJECT_SELF, 5.0); 
	      DelayCommand(5.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSoundSpike, OBJECT_SELF, 5.0)); 
	     }
	 
	 ActionSpeakString("A", TALKVOLUME_TALK);
	 ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamTestA, oRelayBlueA, 5.0);
	 
	 DelayCommand(2.5, ActionSpeakString("ExplodeA", TALKVOLUME_TALK));
	 DelayCommand(2.5, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eExplosionTestA, oRelayBlueA, 5.0));
	 DelayCommand(7.5, ActionSpeakString("ExplodeB", TALKVOLUME_TALK));
	 DelayCommand(7.5, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eExplosionTestB, oRelayBlueA, 5.0));
	 DelayCommand(12.5, ActionSpeakString("ExplodeD", TALKVOLUME_TALK));
	 DelayCommand(12.5, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eExplosionTestC, oRelayBlueA, 5.0));
	 DelayCommand(17.5, ActionSpeakString("ExplodeE", TALKVOLUME_TALK));
	 DelayCommand(17.5, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eExplosionTestD, oRelayBlueA, 5.0));
	 DelayCommand(22.5, ActionSpeakString("ExplodeF", TALKVOLUME_TALK));
	 DelayCommand(22.5, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eExplosionTestF, oRelayBlueA, 5.0));
	 DelayCommand(27.5, ActionSpeakString("ExplodeG", TALKVOLUME_TALK));
	 DelayCommand(27.5, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eExplosionTestG, oRelayBlueA, 5.0));
	 DelayCommand(32.5, ActionSpeakString("ExplodeH", TALKVOLUME_TALK));
	 DelayCommand(32.5, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eExplosionTestH, oRelayBlueA, 5.0));
	 DelayCommand(37.5, ActionSpeakString("ExplodeI", TALKVOLUME_TALK));
	 DelayCommand(37.5, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eExplosionTestI, oRelayBlueA, 5.0));
	 
	 
	 
	 DelayCommand(5.0, ActionSpeakString("B", TALKVOLUME_TALK));
	 DelayCommand(5.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamTestB, oRelayBlueA, 5.0));
	 DelayCommand(10.0, ActionSpeakString("C", TALKVOLUME_TALK));
	 DelayCommand(10.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamTestC, oRelayBlueA, 5.0));
	 
	 DelayCommand(15.0, ActionSpeakString("D", TALKVOLUME_TALK));
	 DelayCommand(15.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamTestD, oRelayBlueA, 5.0));
	 DelayCommand(20.0, ActionSpeakString("E", TALKVOLUME_TALK));
	 DelayCommand(20.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamTestE, oRelayBlueA, 5.0));
	 
	 DelayCommand(25.0, ActionSpeakString("F", TALKVOLUME_TALK));
	 DelayCommand(25.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamTestF, oRelayBlueA, 5.0));
	 DelayCommand(30.0, ActionSpeakString("G", TALKVOLUME_TALK));
	 DelayCommand(30.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamTestG, oRelayBlueA, 5.0));
	 
	 DelayCommand(35.0, ActionSpeakString("H", TALKVOLUME_TALK));
	 DelayCommand(35.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamTestH, oRelayBlueA, 5.0));
	 DelayCommand(40.0, ActionSpeakString("I", TALKVOLUME_TALK));
	 DelayCommand(40.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamTestI, oRelayBlueA, 5.0));
	 
	 DelayCommand(45.0, ActionSpeakString("J", TALKVOLUME_TALK));
	 DelayCommand(45.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamTestJ, oRelayBlueA, 5.0));
	 DelayCommand(50.0, ActionSpeakString("K", TALKVOLUME_TALK));
	 DelayCommand(50.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamTestK, oRelayBlueA, 5.0));
	 
	 DelayCommand(55.0, ActionSpeakString("L", TALKVOLUME_TALK));
	 DelayCommand(55.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamTestL, oRelayBlueA, 5.0));
	 DelayCommand(60.0, ActionSpeakString("M", TALKVOLUME_TALK));
	 DelayCommand(60.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamTestM, oRelayBlueA, 5.0));
	 
	 DelayCommand(65.0, ActionSpeakString("N", TALKVOLUME_TALK));
	 DelayCommand(65.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamTestN, oRelayBlueA, 5.0));
	 DelayCommand(70.0, ActionSpeakString("O", TALKVOLUME_TALK));
	 DelayCommand(70.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamTestO, oRelayBlueA, 5.0));
	 
	 DelayCommand(75.0, ActionSpeakString("P", TALKVOLUME_TALK));
	 DelayCommand(75.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamTestP, oRelayBlueA, 5.0));
	 DelayCommand(80.0, ActionSpeakString("Q", TALKVOLUME_TALK));
	 DelayCommand(80.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamTestQ, oRelayBlueA, 5.0));
	 
	 DelayCommand(85.0, ActionSpeakString("R", TALKVOLUME_TALK));
	 DelayCommand(85.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamTestR, oRelayBlueA, 5.0));
	 DelayCommand(90.0, ActionSpeakString("S", TALKVOLUME_TALK));
	 DelayCommand(90.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamTestS, oRelayBlueA, 5.0));
	 
	 DelayCommand(95.0, ActionSpeakString("T", TALKVOLUME_TALK));
	 DelayCommand(95.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamTestT, oRelayBlueA, 5.0));
	 DelayCommand(100.0, ActionSpeakString("U", TALKVOLUME_TALK));
	 DelayCommand(100.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamTestU, oRelayBlueA, 5.0));
	 
	 DelayCommand(105.0, ActionSpeakString("V", TALKVOLUME_TALK));
	 DelayCommand(105.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamTestV, oRelayBlueA, 5.0));
	 DelayCommand(110.0, ActionSpeakString("W", TALKVOLUME_TALK));
	 DelayCommand(110.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamTestW, oRelayBlueA, 5.0));
	 
	 DelayCommand(115.0, ActionSpeakString("X", TALKVOLUME_TALK));
	 DelayCommand(115.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamTestX, oRelayBlueA, 5.0));
	 DelayCommand(120.0, ActionSpeakString("Y", TALKVOLUME_TALK));
	 DelayCommand(120.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamTestY, oRelayBlueA, 5.0));
	 
	 DelayCommand(125.0, ActionSpeakString("Z", TALKVOLUME_TALK));
	 DelayCommand(125.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamTestZ, oRelayBlueA, 5.0));
	 DelayCommand(130.0, ActionSpeakString("ZA", TALKVOLUME_TALK));
	 DelayCommand(130.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamTestZA, oRelayBlueA, 5.0));
	 
	 DelayCommand(135.0, ActionSpeakString("ZB", TALKVOLUME_TALK));
	 DelayCommand(135.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamTestZB, oRelayBlueA, 5.0));
	 DelayCommand(140.0, ActionSpeakString("ZC", TALKVOLUME_TALK));
	 DelayCommand(140.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamTestZC, oRelayBlueA, 5.0));
	 
	 DelayCommand(145.0, ActionSpeakString("ZD", TALKVOLUME_TALK));
	 DelayCommand(145.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamTestZD, oRelayBlueA, 5.0));
	 DelayCommand(150.0, ActionSpeakString("ZE", TALKVOLUME_TALK));
	 DelayCommand(150.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamTestZE, oRelayBlueA, 5.0));
	 
	 DelayCommand(155.0, ActionSpeakString("ZF", TALKVOLUME_TALK));
	 DelayCommand(155.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamTestZF, oRelayBlueA, 5.0));
	 DelayCommand(160.0, ActionSpeakString("AA", TALKVOLUME_TALK));
	 DelayCommand(160.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamTestAA, oRelayBlueA, 5.0));
	 
	 DelayCommand(165.0, ActionSpeakString("BB", TALKVOLUME_TALK));
	 DelayCommand(165.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamTestBB, oRelayBlueA, 5.0));
	 DelayCommand(170.0, ActionSpeakString("CC", TALKVOLUME_TALK));
	 DelayCommand(170.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamTestCC, oRelayBlueA, 5.0));
	 
	 DelayCommand(175.0, ActionSpeakString("DD", TALKVOLUME_TALK));
	 DelayCommand(175.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamTestDD, oRelayBlueA, 5.0));
	 DelayCommand(180.0, ActionSpeakString("EE", TALKVOLUME_TALK));
	 DelayCommand(180.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamTestEE, oRelayBlueA, 5.0));
	 
	 DelayCommand(185.0, ActionSpeakString("FF", TALKVOLUME_TALK));
	 DelayCommand(185.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamTestFF, oRelayBlueA, 5.0));
	 DelayCommand(190.0, ActionSpeakString("GG", TALKVOLUME_TALK));
	 DelayCommand(190.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamTestGG, oRelayBlueA, 5.0));
	 
	 DelayCommand(195.0, ActionSpeakString("HH", TALKVOLUME_TALK));
	 DelayCommand(195.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamTestHH, oRelayBlueA, 5.0));
	 DelayCommand(200.0, ActionSpeakString("II", TALKVOLUME_TALK));
	 DelayCommand(200.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamTestII, oRelayBlueA, 5.0));
	 }
}