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
	 effect eChunk = EffectVisualEffect(VFX_COM_CHUNK_STONE_MEDIUM, FALSE);
	 effect eExplosion = EffectVisualEffect(VFX_FNF_ELECTRIC_EXPLOSION,FALSE);
	 
	 effect eSummonBlue = EffectVisualEffect(VFX_FNF_SUMMON_CELESTIAL, FALSE);
	 effect eSummonGreen = EffectVisualEffect(VFX_FNF_NATURES_BALANCE, FALSE);
	 effect eSummonRed = EffectVisualEffect(VFX_FNF_SUMMON_GATE, FALSE);
	 effect eSummonGold = EffectVisualEffect(VFX_FNF_SUMMONDRAGON, FALSE);
	 
	 if(GetItemPossessedBy(oGlobeBlue, "003_it_phalorm_sapphire")!= OBJECT_INVALID) {
		     object oPlatformBlueOn = CreateObject(OBJECT_TYPE_PLACEABLE,"phalorm_platform_active", GetLocation(oWPPlatformBlue));
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
			 DestroyObject(oCrystalDiscordA, 55.0);
			 DestroyObject(oCrystalDiscordB, 57.0);
			 DestroyObject(oCrystalDiscordC, 59.0);
			 DestroyObject(oCrystalDiscordD, 61.0);
			 }
		 else{ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSmoke, OBJECT_SELF, 25.0); 
		      SpawnItemProjectile(OBJECT_SELF, oDisturber, GetLocation(OBJECT_SELF), GetLocation(oDisturber), BASE_ITEM_SLING, PROJECTILE_PATH_TYPE_HIGH_BALLISTIC, OVERRIDE_ATTACK_RESULT_HIT_SUCCESSFUL, DAMAGE_TYPE_COLD);
		 	  ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSoundBurstSilent, OBJECT_SELF, 5.0); 
		      DelayCommand(5.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSoundSpike, OBJECT_SELF, 5.0)); 
		      DelayCommand(10.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSummonBlue, OBJECT_SELF, 5.0));
			  DelayCommand(12.0, ActionCreateWynCreature("abr_cr_el_airweird", GetLocation(oWPCreateBlue)));
			  DelayCommand(15.0, AssignCommand(GetObjectByTag("abr_cr_el_airweird", 0), ActionSpeakString("You have chosen...poorly. *Reaches into crystal globe for the last item placed there and drops it at its feet.", TALKVOLUME_TALK)));
			  DelayCommand(15.0, SendMessageToPC(oDisturber, "You have chosen...poorly. *Reaches into crystal globe for the last item placed there and drops it at its feet."));
			  DelayCommand(16.0, AssignCommand(GetObjectByTag("abr_cr_el_airweird", 0), ActionTakeItem(oItem, oGlobeBlue)));
			  DelayCommand(20.0, AssignCommand(GetObjectByTag("abr_cr_el_airweird", 0), ActionPutDownItem(oItem)));
			  DelayCommand(20.0, AssignCommand(GetObjectByTag("abr_cr_el_airweird", 0), ActionSpeakString("You have five seconds to depart my sight.", TALKVOLUME_TALK)));
			  DelayCommand(25.0, ChangeToStandardFaction(GetObjectByTag("abr_cr_el_airweird", 0),STANDARD_FACTION_HOSTILE));
			  }
		}
}