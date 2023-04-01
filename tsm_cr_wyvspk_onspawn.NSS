//
//     Filename : tsm_cr_harpy_onspawn
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

void main() {
	object oWyvern = GetLocalObject(OBJECT_SELF, "oWyvern");
	object oPortal = GetObjectByTag("alfa_portal_plc_wyv", 0);
	object oCaveLightA = GetObjectByTag("cave_light_a", 0);
	object oCaveLightB = GetObjectByTag("cave_light_b", 0);
	object oCaveLightC = GetObjectByTag("cave_light_c", 0);
	
	object oExpWP = GetWaypointByTag("cave_explosion_wp");
	object oWyvSpawn = GetWaypointByTag("cave_wyvern_spawn_wp");
	object oWyvSpawnB = GetWaypointByTag("cave_wyvern_spawnb_wp");
	object oWyvSpawnC = GetWaypointByTag("cave_wyvern_spawnc_wp");
	object oInvisSpawn = GetWaypointByTag("dqspx_thar_tomb");
	object oMoveA = GetWaypointByTag("wyvern_movea_wp");
	object oMoveB = GetWaypointByTag("wyvern_moveb_wp");
	object oMoveC = GetWaypointByTag("wyvern_movec_wp");
	object oExplosionWP = GetWaypointByTag("cave_explosion_wp");
				
	object oBlackWP = GetWaypointByTag("cave_bridge_black_wp");
	object oBlackBWP = GetWaypointByTag("cave_bridge_blackb_wp");
	object oRubbleWP = GetWaypointByTag("cave_bridge_rubble_wp");
	object oRubbleBWP = GetWaypointByTag("cave_bridge_rubbleb_wp");
	object oRubbleCWP = GetWaypointByTag("cave_bridge_rubblec_wp");
	object oRubbleDWP = GetWaypointByTag("cave_bridge_rubbled_wp");
	object oWallWP = GetWaypointByTag("cave_bridge_wall_wp");
	object oWallBWP = GetWaypointByTag("cave_bridge_wallb_wp");
	object oWallCWP = GetWaypointByTag("cave_bridge_wallc_wp");
	object oWallDWP = GetWaypointByTag("cave_bridge_walld_wp");
	effect eExplode = EffectVisualEffect(VFX_IMP_DUST_EXPLOSION, FALSE);
	effect eShrapnel = EffectVisualEffect(VFX_COM_CHUNK_STONE_MEDIUM, FALSE);
	
	effect eCutScene = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);
	effect eFreeze = EffectCutsceneImmobilize();
	effect eLight = EffectVisualEffect(VFX_DUR_LIGHT_RED_5);
	effect eLightB = EffectVisualEffect(VFX_DUR_LIGHT_RED_10);
	effect eLightC = EffectVisualEffect(VFX_DUR_LIGHT_RED_15);
	
	object oRedLight = CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_scry_send_xavier", GetLocation(oWyvern));
	SetFirstName(oRedLight, "Red");
	SetLastName(oRedLight, "Light");
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eFreeze,oRedLight);
    	 		
	SetScale(oWyvern, 0.1, 0.1, 0.1);
	ActionSpeakString("*Over the bridge, the light filtering through cracks in the ceiling dims and goes out, dirt and pebbles trickling through at first, then that ceasing, as the light is closed off.", TALKVOLUME_TALK);
	
	float fDelay = 30.0;	
	DestroyObject(oCaveLightA);
	DestroyObject(oCaveLightB, fDelay-20.0);
				
	DelayCommand(fDelay-20.0, AssignCommand(OBJECT_SELF, ActionSpeakString("*More light is extinguished.", TALKVOLUME_TALK)));
	DelayCommand(fDelay-19.0, AssignCommand(OBJECT_SELF, ActionSpeakString("A roar sounds distantly, echoing in the chamber", TALKVOLUME_TALK)));
	DelayCommand(fDelay-19.0, AssignCommand(oWyvern, PlaySound("as_an_dragonror1", FALSE)));
	DelayCommand(fDelay-19.0, AssignCommand(OBJECT_SELF, PlaySound("as_an_dragonror1", FALSE)));
			    
	object oPC = GetFirstObjectInShape(SHAPE_SPHERE, 20.0, GetLocation(oPortal), FALSE, OBJECT_TYPE_CREATURE);
	while(oPC != OBJECT_INVALID) {
		if(GetIsSkillSuccessful(oPC, SKILL_LISTEN, 15, TRUE)) {DelayCommand(fDelay-18.0, SendMessageToPC(oPC, "The roar came from the east, out the abyss, over the edge of this little stone island. Looking for the source of the sound, you peer into depths that you hadn't realized were quite that deep...until now."));}
		oPC = GetNextObjectInShape(SHAPE_SPHERE, 20.0, GetLocation(oPortal), FALSE, OBJECT_TYPE_CREATURE);
		}
				
	DestroyObject(oCaveLightC, fDelay-10.0);
	DelayCommand(fDelay-10.0, AssignCommand(OBJECT_SELF, ActionSpeakString("*A small cross-shape, backlit in silhouette against a red light, becomes visible down and to the east.", TALKVOLUME_TALK)));
	
	DelayCommand(fDelay, AssignCommand(OBJECT_SELF, ActionSpeakString("*The wings flap again, the creature that is flying out of the revealed distances, clearly draconic in shape.", TALKVOLUME_TALK)));
	DestroyObject(oRedLight, fDelay);
				
	effect eRemove = GetFirstEffect(oWyvern);
	while (GetIsEffectValid(eRemove) != FALSE) {
		DelayCommand(fDelay, RemoveEffect(oWyvern, eRemove));
		eRemove = GetNextEffect(oWyvern);
		}
	
	DelayCommand(fDelay, AssignCommand(oWyvern, ActionCastSpellAtObject(SPELL_PROTECTION_FROM_ARROWS, oWyvern, METAMAGIC_PERMANENT, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
	DelayCommand(fDelay, AssignCommand(oWyvern, ActionCastSpellAtObject(SPELL_GLOBE_OF_INVULNERABILITY, oWyvern, METAMAGIC_PERMANENT, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
				
	DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFreeze,oWyvern, 10.0));
    DelayCommand(1.0 + fDelay, AssignCommand(OBJECT_SELF, PlaySound("al_mg_crystalev1", FALSE)));
	
		 		
	DelayCommand(1.0 + fDelay, SetFirstName(OBJECT_SELF, "Twisted Wyvern"));
	DelayCommand(1.0 + fDelay, ChangeToStandardFaction(oWyvern, STANDARD_FACTION_HOSTILE));
	DelayCommand(2.0 + fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLight, oWyvern, 10.0));
				
	DelayCommand(2.0 + fDelay, SetScale(oWyvern, 0.15, 0.15, 0.15));
	DelayCommand(3.0 + fDelay, SetScale(oWyvern, 0.2, 0.2, 0.2));
	DelayCommand(4.0 + fDelay, SetScale(oWyvern, 0.25, 0.25, 0.25));
	DelayCommand(5.0 + fDelay, SetScale(oWyvern, 0.3, 0.35, 0.3));
	DelayCommand(6.0 + fDelay, SetScale(oWyvern, 0.35, 0.35, 0.35));
	DelayCommand(7.0 + fDelay, SetScale(oWyvern, 0.4, 0.4, 0.4));
	DelayCommand(8.0 + fDelay, SetScale(oWyvern, 0.45, 0.45, 0.45));
	DelayCommand(9.0 + fDelay, SetScale(oWyvern, 0.5, 0.5, 0.5));
	
	eRemove = GetFirstEffect(oWyvern);
	while (GetIsEffectValid(eRemove) != FALSE) {
		if(GetEffectType(eRemove) == EFFECT_TYPE_CUTSCENEIMMOBILIZE) {DelayCommand(fDelay + 10.0, RemoveEffect(oWyvern, eRemove));}
		eRemove = GetNextEffect(oWyvern);
		}
	DelayCommand(10.0 + fDelay, AssignCommand(OBJECT_SELF, PlaySound("al_mg_crystalev1", FALSE)));
	DelayCommand(10.0 + fDelay, AssignCommand(OBJECT_SELF, ActionSpeakString("*Large enough to see detail as it swoops out of the darkness and banks past you, the creature is a twisted wyvern...but different even from those befouled creatures. Raw flesh and bone glisten in its red aura. It is undead, and suffused in magic.", TALKVOLUME_TALK)));
	DelayCommand(10.0 + fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLightB, oWyvern, 10.0));
	DelayCommand(10.0 + fDelay, SetLastName(OBJECT_SELF, "Zombie"));
	DelayCommand(10.0 + fDelay, SetLastName(oWyvern, "Zombie"));
	DelayCommand(10.0 + fDelay, SetScale(oWyvern, 0.55, 0.55, 0.55));
	DelayCommand(10.0 + fDelay, AssignCommand(oWyvern, ActionForceMoveToLocation(GetLocation(oMoveA), TRUE, 5.0)));
				
	DelayCommand(11.0 + fDelay, AssignCommand(oWyvern, PlaySound("as_an_dragonror2", FALSE)));
	DelayCommand(11.0 + fDelay, AssignCommand(OBJECT_SELF, PlaySound("as_an_dragonror2", FALSE)));
	
	DelayCommand(20.0 + fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLightC, oWyvern, 40.0));
	DelayCommand(20.0 + fDelay, AssignCommand(OBJECT_SELF, ActionForceMoveToLocation(GetLocation(oMoveB), TRUE, 5.0)));
	DelayCommand(21.0 + fDelay, SetScale(oWyvern, 0.6, 0.6, 0.6));
	DelayCommand(22.0 + fDelay, SetScale(oWyvern, 0.65, 0.65, 0.65));
	DelayCommand(23.0 + fDelay, SetScale(oWyvern, 0.7, 0.7, 0.7));
	DelayCommand(24.0 + fDelay, SetScale(oWyvern, 0.75, 0.75, 0.75));
	DelayCommand(25.0 + fDelay, SetScale(oWyvern, 0.8, 0.8, 0.8));
	DelayCommand(26.0 + fDelay, SetScale(oWyvern, 0.85, 0.85, 0.85));
	DelayCommand(27.0 + fDelay, SetScale(oWyvern, 0.9, 0.9, 0.9));
	DelayCommand(28.0 + fDelay, SetScale(oWyvern, 0.95, 0.95, 0.95));
	DelayCommand(29.0 + fDelay, SetScale(oWyvern, 1.0, 1.0, 1.0));
				
	DelayCommand(30.0 + fDelay, AssignCommand(OBJECT_SELF, ActionSpeakString("*Its true size finally apparent, it banks again, diving beneath the bridge and briefly out of sight before soaring up on the other side, trailing the smell of rotting flesh.", TALKVOLUME_TALK)));
	DelayCommand(30.0 + fDelay, AssignCommand(oWyvern, ActionJumpToLocation(GetLocation(oWyvSpawnB))));      
	DelayCommand(31.0 + fDelay, AssignCommand(oWyvern, PlaySound("as_an_dragonror3", FALSE)));
	DelayCommand(31.0 + fDelay, AssignCommand(OBJECT_SELF, PlaySound("as_an_dragonror3", FALSE)));
	DelayCommand(32.0 + fDelay, AssignCommand(oWyvern, ActionForceMoveToLocation(GetLocation(oMoveC), TRUE, 5.0)));
	DelayCommand(35.0 + fDelay, AssignCommand(oWyvern, ActionCastSpellAtObject(SPELL_PROTECTION_FROM_ARROWS, oWyvern, METAMAGIC_PERMANENT, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
	DelayCommand(35.0 + fDelay, AssignCommand(oWyvern, ActionCastSpellAtObject(SPELL_GLOBE_OF_INVULNERABILITY, oWyvern, METAMAGIC_PERMANENT, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
				
				
				  
	DelayCommand(57.0 + fDelay, AssignCommand(oWyvern, PlaySound("as_an_dragonror1", FALSE)));
	DelayCommand(58.0 + fDelay, AssignCommand(OBJECT_SELF, ActionSpeakString("*Roars and folds wings, swooping out of sight into the chasm.", TALKVOLUME_TALK)));
				 
	DelayCommand(60.0 + fDelay, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutScene, oWyvern));
	DelayCommand(60.0 + fDelay, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eFreeze,oWyvern));
    	 		 
	DelayCommand(75.0 + fDelay, AssignCommand(OBJECT_SELF, ActionSpeakString("*The bridge explodes upwards!", TALKVOLUME_TALK)));
	DelayCommand(76.0 + fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eShrapnel, oWyvSpawnC, 5.0));
	DelayCommand(76.0 + fDelay, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eShrapnel, GetLocation(oWyvSpawnC), 5.0));
	DelayCommand(77.0 + fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eExplode, oWyvSpawnC, 5.0));
	DelayCommand(77.0 + fDelay, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eExplode, GetLocation(oWyvSpawnC), 5.0));
				
	DelayCommand(80.0 + fDelay, ActionCreateWynCreature("abr_un_wyv_twisted", GetLocation(oWyvSpawnC)));
	DelayCommand(80.0 + fDelay, AssignCommand(OBJECT_SELF, ActionSpeakString("*Shrapnel flies as the wyvern bursts through the bridge from below.", TALKVOLUME_TALK)));
				
	DelayCommand(81.0 + fDelay, ActionCreateWynPlaceable("cave_bridge_blackout", GetLocation(oBlackWP)));
	DelayCommand(81.0 + fDelay, ActionCreateWynPlaceable("cave_bridge_blackoutb", GetLocation(oBlackBWP)));
	DelayCommand(81.5 + fDelay, ActionCreateWynPlaceable("cave_bridge_rubble", GetLocation(oRubbleWP)));
	DelayCommand(81.5 + fDelay, ActionCreateWynPlaceable("cave_bridge_rubbleb", GetLocation(oRubbleBWP)));
	DelayCommand(82.0 + fDelay, ActionCreateWynPlaceable("cave_bridge_rubblec", GetLocation(oRubbleCWP)));
	DelayCommand(82.0 + fDelay, ActionCreateWynPlaceable("cave_bridge_rubbled", GetLocation(oRubbleDWP)));
	DelayCommand(82.5 + fDelay, ActionCreateWynPlaceable("cave_bridge_wall", GetLocation(oWallWP)));
	DelayCommand(82.5 + fDelay, ActionCreateWynPlaceable("cave_bridge_wallb", GetLocation(oWallBWP)));
	DelayCommand(83.0 + fDelay, ActionCreateWynPlaceable("cave_bridge_wallc", GetLocation(oWallCWP)));
	DelayCommand(83.0 + fDelay, ActionCreateWynPlaceable("cave_bridge_walld", GetLocation(oWallDWP)));
	DelayCommand(85.0 + fDelay, SetLocalInt(oPortal, "Activated", 2));
				
}