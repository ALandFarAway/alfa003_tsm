//
//     Filename : tsm_cr_wyvern_zombie_narrator_onspawn
//      Version : 0.1
//         Date : 7/18/22
//       Author : Wynna
//
//  Description
//  This script creates an onspawn script for a harpy to destroy the portal it rode in on.
//	It is not updated in ACR updates.
//
//  Revision History
////////////////////////////////////////////////////////////////////////////////

//	Wynna - 7/8/2022

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////

#include "acr_spawn_i"

void ActionCreateWynCreature(string sCreature, location lLocCreature)
{
    CreateObject(OBJECT_TYPE_CREATURE, sCreature, lLocCreature);
}
void ActionCreateWynPlaceable(string sPlaceable, location lLocPlaceable)
{
    CreateObject(OBJECT_TYPE_PLACEABLE, sPlaceable, lLocPlaceable);
}
void ActionCreateWynPlacedEffect(string sPlaceable, location lLocPlaceable)
{
    CreateObject(OBJECT_TYPE_PLACEABLE, sPlaceable, lLocPlaceable);
}
void main() {
	object oWyvern = GetLocalObject(OBJECT_SELF, "oWyvern");
	object oPortal = GetObjectByTag("alfa_portal_plc_wyv", 0);
	object oCaveLightA = GetObjectByTag("cave_light_a", 0);
	object oCaveLightB = GetObjectByTag("cave_light_b", 0);
	object oCaveLightC = GetObjectByTag("cave_light_c", 0);
	object oCaveLightD = GetObjectByTag("abr_afx_ror_player_soul_01", 0);
	object oWyvSpawn = GetWaypointByTag("cave_wyvern_spawn_wp");
	object oWyvSpawnB = GetWaypointByTag("cave_wyvern_spawnb_wp");
	object oWyvSpawnC = GetWaypointByTag("cave_wyvern_spawnc_wp");
	object oInvisSpawn = GetWaypointByTag("dqspx_thar_tomb");
	object oMoveA = GetWaypointByTag("wyvern_movea_wp");
	object oMoveB = GetWaypointByTag("wyvern_moveb_wp");
	object oMoveC = GetWaypointByTag("wyvern_movec_wp");
	object oMoveD = GetWaypointByTag("wyvern_moved_wp");
	object oExplosionWP = GetWaypointByTag("cave_explosion_wp");
	object oOrcWP = GetWaypointByTag("cave_orc_spawn");
	
				
	object oBlackWP = GetWaypointByTag("bridge_black_wp");
	object oBlackBWP = GetWaypointByTag("bridge_blackb_wp");
	object oRubbleWP = GetWaypointByTag("bridge_rubble_wp");
	object oRubbleBWP = GetWaypointByTag("bridge_rubbleb_wp");
	object oRubbleCWP = GetWaypointByTag("bridge_rubblec_wp");
	object oRubbleDWP = GetWaypointByTag("bridge_rubbled_wp");
	object oWallWP = GetWaypointByTag("bridge_wall_wp");
	object oWallBWP = GetWaypointByTag("bridge_wallb_wp");
	object oWallCWP = GetWaypointByTag("bridge_wallc_wp");
	object oWallDWP = GetWaypointByTag("bridge_walld_wp");
	object oWallEWP = GetWaypointByTag("bridge_walle_wp");
	effect eExplode = EffectVisualEffect(VFX_IMP_DUST_EXPLOSION, FALSE);
	effect eShrapnel = EffectVisualEffect(VFX_COM_CHUNK_STONE_MEDIUM, FALSE);
	
	effect eCutScene = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);
	effect eFreeze = EffectCutsceneImmobilize();
	effect eLight = EffectVisualEffect(VFX_DUR_LIGHT_RED_20);
	effect eShake = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
	effect eQuake = EffectVisualEffect(VFX_SPELL_HIT_EARTHQUAKE);
	
	object oRedLight = CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_scry_send_xavier", GetLocation(oWyvern));
	SetFirstName(oRedLight, "Red");
	SetLastName(oRedLight, "Light");
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eFreeze,oRedLight);
    	 		
	SetScale(oWyvern, 0.5, 0.5, 0.5);
	float fDelay = 30.0;	
	DelayCommand(fDelay-28.0, AssignCommand(OBJECT_SELF, ActionSpeakString("*Over the bridge, the light filtering through cracks in the ceiling dims and goes out, dirt and pebbles trickling through at first, then that ceasing, as the light is closed off.", TALKVOLUME_TALK)));
	
	DestroyObject(oCaveLightA);
	DestroyObject(oCaveLightB, fDelay-20.0);
				
	DelayCommand(fDelay-20.0, AssignCommand(OBJECT_SELF, ActionSpeakString("*More light is extinguished.", TALKVOLUME_TALK)));
	DelayCommand(fDelay-15.0, AssignCommand(OBJECT_SELF, ActionSpeakString("A roar sounds distantly, echoing in the chamber", TALKVOLUME_TALK)));
	DelayCommand(fDelay-15.0, AssignCommand(oWyvern, PlaySound("as_an_dragonror1", FALSE)));
	DelayCommand(fDelay-15.0, AssignCommand(OBJECT_SELF, PlaySound("as_an_dragonror1", FALSE)));
			    
	object oPC = GetFirstObjectInShape(SHAPE_SPHERE, 20.0, GetLocation(oPortal), FALSE, OBJECT_TYPE_CREATURE);
	while(oPC != OBJECT_INVALID) {
		if(GetIsSkillSuccessful(oPC, SKILL_LISTEN, 15, TRUE)) {DelayCommand(fDelay-15.0, SendMessageToPC(oPC, "The roar came from the east, out the abyss, over the edge of this little stone island. Looking for the source of the sound, you peer into depths that you hadn't realized were quite that deep...until now."));}
		oPC = GetNextObjectInShape(SHAPE_SPHERE, 20.0, GetLocation(oPortal), FALSE, OBJECT_TYPE_CREATURE);
		}
				
	DestroyObject(oCaveLightC, fDelay-10.0);
	DestroyObject(oCaveLightD, fDelay-10.0);
	DelayCommand(fDelay-10.0, AssignCommand(OBJECT_SELF, ActionSpeakString("*In the darkness, a red light becomes visible down and to the east, its distance revealing how far the chasm extends underground. It silhouettes a far-away winged shape, speeding this way.", TALKVOLUME_TALK)));
	
	DelayCommand(fDelay, ActionCreateWynPlacedEffect("tsm_afx_area_fog_red", GetLocation(oWyvSpawnC)));			
	DestroyObject(oRedLight, fDelay + 11.0);
				
	effect eRemove = GetFirstEffect(oWyvern);
	while (GetIsEffectValid(eRemove) != FALSE) {
		DelayCommand(fDelay+10.0, RemoveEffect(oWyvern, eRemove));
		eRemove = GetNextEffect(oWyvern);
		}
	
	DelayCommand(10.0 + fDelay, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLight, oWyvern));
	DelayCommand(10.0 + fDelay, AssignCommand(oWyvern, ActionCastSpellAtObject(SPELL_PROTECTION_FROM_ARROWS, oWyvern, METAMAGIC_PERMANENT, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
	DelayCommand(10.0 + fDelay, AssignCommand(oWyvern, ActionCastSpellAtObject(SPELL_GLOBE_OF_INVULNERABILITY, oWyvern, METAMAGIC_PERMANENT, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
	DelayCommand(10.0 + fDelay, AssignCommand(oWyvern, ActionCastSpellAtObject(SPELL_PROTECTION_FROM_ENERGY, oWyvern, METAMAGIC_PERMANENT, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
	DelayCommand(10.0 + fDelay, AssignCommand(oWyvern, ActionCastSpellAtObject(SPELL_REGENERATE, oWyvern, METAMAGIC_PERMANENT, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
				
		 		
	DelayCommand(11.0 + fDelay, SetFirstName(OBJECT_SELF, "Twisted Wyvern"));
	DelayCommand(11.0 + fDelay, ChangeToStandardFaction(oWyvern, STANDARD_FACTION_HOSTILE));
	
	DelayCommand(20.0 + fDelay, AssignCommand(oWyvern, ActionForceMoveToObject(oMoveB, TRUE)));
			
	DelayCommand(30.0 + fDelay, AssignCommand(OBJECT_SELF, ActionSpeakString("*It soars out of the darkness, a twisted wyvern...but different. Raw flesh and bone glisten. It is undead, and suffused in magic.", TALKVOLUME_TALK)));
	DelayCommand(30.0 + fDelay, SetLastName(OBJECT_SELF, "Zombie"));
	DelayCommand(30.0 + fDelay, SetLastName(oWyvern, "Zombie"));
	DelayCommand(30.0 + fDelay, AssignCommand(oWyvern, ActionForceMoveToObject(oMoveA, TRUE)));
	
	DelayCommand(40.0 + fDelay, ActionCreateWynPlaceable("tsm_afx_dthgod_lt_red", GetLocation(oMoveA)));			
	DelayCommand(50.0 + fDelay, AssignCommand(OBJECT_SELF, ActionSpeakString("*It swoops in and out of sight. Around its neck glints a magnificent collar of crystal.", TALKVOLUME_TALK)));
	DelayCommand(59.0 + fDelay, ClearAllActions(TRUE));
	DelayCommand(50.0 + fDelay, AssignCommand(OBJECT_SELF, ActionJumpToObject(oMoveB, TRUE)));
	DelayCommand(50.0 + fDelay, SetScale(oWyvern, 0.65, 0.65, 0.65));
	DelayCommand(60.0 + fDelay, AssignCommand(OBJECT_SELF, ActionJumpToObject(oMoveC, TRUE)));
	DelayCommand(60.0 + fDelay, SetScale(oWyvern, 0.75, 0.75, 0.75));
	
				
	DelayCommand(70.0 + fDelay, AssignCommand(OBJECT_SELF, ActionSpeakString("*It dives beneath the bridge and briefly out of sight before soaring up on the other side, trailing the smell of rotting flesh.", TALKVOLUME_TALK)));
	DelayCommand(70.0 + fDelay, AssignCommand(oWyvern, ActionJumpToLocation(GetLocation(oWyvSpawnB))));      
	DelayCommand(70.0 + fDelay, SetScale(oWyvern, 1.0, 1.0, 1.0));
	DelayCommand(72.0, ClearAllActions(TRUE));
	DelayCommand(72.0 + fDelay, AssignCommand(oWyvern, ActionForceMoveToLocation(GetLocation(oMoveD), TRUE)));
	DelayCommand(75.0 + fDelay, AssignCommand(oWyvern, ActionCastSpellAtObject(SPELL_PROTECTION_FROM_ARROWS, oWyvern, METAMAGIC_PERMANENT, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
	DelayCommand(75.0 + fDelay, AssignCommand(oWyvern, ActionCastSpellAtObject(SPELL_GLOBE_OF_INVULNERABILITY, oWyvern, METAMAGIC_PERMANENT, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
	DelayCommand(75.0 + fDelay, AssignCommand(oWyvern, ActionCastSpellAtObject(SPELL_PROTECTION_FROM_ENERGY, oWyvern, METAMAGIC_PERMANENT, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
	DelayCommand(75.0 + fDelay, AssignCommand(oWyvern, ActionCastSpellAtObject(SPELL_REGENERATE, oWyvern, METAMAGIC_PERMANENT, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
				
	DelayCommand(80.0 + fDelay, AssignCommand(oWyvern, ActionForceMoveToLocation(GetLocation(oWyvSpawnB), TRUE)));
				
				  
	DelayCommand(88.0 + fDelay, AssignCommand(OBJECT_SELF, ActionSpeakString("*Roars and folds wings, swooping out of sight into the chasm.", TALKVOLUME_TALK)));
	
	DestroyObject(oWyvern, 90.0 + fDelay);
				 
		 		 
	DelayCommand(105.0 + fDelay, AssignCommand(OBJECT_SELF, ActionSpeakString("*The bridge explodes upwards!", TALKVOLUME_TALK)));
	DelayCommand(106.0 + fDelay, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eShake, GetLocation(oWyvSpawnC), 5.0));
	DelayCommand(107.0 + fDelay, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eQuake, GetLocation(oWyvSpawnC), 5.0));
				
	DelayCommand(108.0 + fDelay, SetFirstName(OBJECT_SELF, ""));
	DelayCommand(108.0 + fDelay, SetLastName(OBJECT_SELF, ""));
	DelayCommand(110.0 + fDelay, ActionCreateWynCreature("abr_un_wyv_twisted", GetLocation(oWyvSpawnC)));
	DelayCommand(110.0 + fDelay, AssignCommand(OBJECT_SELF, ActionSpeakString("*Shrapnel flies as the wyvern bursts through the bridge from below.", TALKVOLUME_TALK)));
	 
	oPC = GetFirstObjectInShape(SHAPE_SPHERE, 20.0, GetLocation(oPortal), FALSE, OBJECT_TYPE_CREATURE);
	int nStones = Random(4);
	effect eDamage = EffectDamage(d6(nStones), DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_NORMAL, FALSE);
	effect eKnockdown = EffectKnockdown();
	while(oPC != OBJECT_INVALID) {
		if(ReflexSave(oPC, 15, SAVING_THROW_TYPE_TRAP, OBJECT_SELF) == 0) {
			DelayCommand(111.0 + fDelay, SendMessageToPC(oPC, "You are struck by " + IntToString(nStones) + " pieces of flying debris!"));
			DelayCommand(111.5 + fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oPC));
			DelayCommand(111.5 + fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnockdown, oPC, 5.0));
			}
		if(GetDistanceBetween(oWyvSpawnC, oPC) < 5.0) {
			DelayCommand(112.0 + fDelay, SendMessageToPC(oPC, "You are thrown backwards!"));
			DelayCommand(112.5 + fDelay, AssignCommand(oPC, ActionJumpToLocation(GetLocation(oPortal))));
			DelayCommand(112.5 + fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnockdown, oPC, 10.0));
			}
		oPC = GetNextObjectInShape(SHAPE_SPHERE, 20.0, GetLocation(oPortal), FALSE, OBJECT_TYPE_CREATURE);
		}
	
	
	DelayCommand(111.5 + fDelay, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLight, GetNearestObjectByTag("abr_un_wyv_twisted", OBJECT_SELF, 1)));
		
	DelayCommand(111.0 + fDelay, ActionCreateWynPlaceable("cave_bridge_blackout", GetLocation(oBlackWP)));
	DelayCommand(106.0 + fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eShrapnel, GetNearestObjectByTag("cave_bridge_blackout", OBJECT_SELF, 1), 5.0));
	
	DelayCommand(111.0 + fDelay, ActionCreateWynPlaceable("cave_bridge_blackoutb", GetLocation(oBlackBWP)));
	DelayCommand(111.5 + fDelay, ActionCreateWynPlaceable("cave_bridge_rubble", GetLocation(oRubbleWP)));
	DelayCommand(111.5 + fDelay, ActionCreateWynPlaceable("cave_bridge_rubbleb", GetLocation(oRubbleBWP)));
	DelayCommand(112.0 + fDelay, ActionCreateWynPlaceable("cave_bridge_rubblec", GetLocation(oRubbleCWP)));
	DelayCommand(112.0 + fDelay, ActionCreateWynPlaceable("cave_bridge_rubbled", GetLocation(oRubbleDWP)));
	DelayCommand(112.5 + fDelay, ActionCreateWynPlaceable("cave_bridge_wall", GetLocation(oWallWP)));
	DelayCommand(112.5 + fDelay, ActionCreateWynPlaceable("cave_bridge_wallb", GetLocation(oWallBWP)));
	DelayCommand(113.0 + fDelay, ActionCreateWynPlaceable("cave_bridge_wallc", GetLocation(oWallCWP)));
	DelayCommand(113.0 + fDelay, ActionCreateWynPlaceable("cave_bridge_walld", GetLocation(oWallDWP)));
	DelayCommand(113.0 + fDelay, ActionCreateWynPlaceable("cave_bridge_walld", GetLocation(oWallEWP)));
	DelayCommand(115.0 + fDelay, SetLocalInt(oPortal, "Activated", 2));
	
	DelayCommand(120.0 + fDelay, AssignCommand(OBJECT_SELF, ActionSpeakString("*There is movement on the other side of the shattered bridge, creatures moving out of the shadows.", TALKVOLUME_TALK)));
	DelayCommand(120.0 + fDelay, ActionCreateWynCreature("abr_cr_hu_orc_twisted", GetLocation(oOrcWP)));
	DelayCommand(120.0 + fDelay, ActionCreateWynCreature("abr_cr_hu_orc_twisted", GetLocation(oOrcWP)));
	DelayCommand(125.0 + fDelay, ActionCreateWynCreature("abr_cr_hu_orcminer", GetLocation(oOrcWP)));
	DelayCommand(125.0 + fDelay, ActionCreateWynCreature("abr_cr_hu_orcminer", GetLocation(oOrcWP)));
	DelayCommand(125.0 + fDelay, ActionCreateWynCreature("abr_cr_hu_orcminer", GetLocation(oOrcWP)));
	DelayCommand(125.0 + fDelay, ActionCreateWynCreature("abr_cr_hu_orcminer", GetLocation(oOrcWP)));
	DelayCommand(135.0 + fDelay, ActionCreateWynCreature("009_cr_mhg_minotaur_twisted", GetLocation(oOrcWP)));
				
}