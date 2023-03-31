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
	object oPortal = GetObjectByTag("alfa_portal_plc_wyv", 0);
	object oExpWP = GetWaypointByTag("cave_explosion_wp");
	effect eCutScene = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);
	effect eInvis = EffectInvisibility(INVISIBILITY_TYPE_IMPROVED);
	effect eEthereal = EffectEthereal();
	effect eGhost = EffectCutsceneGhost();	 	 		     	      
    effect eFreeze = EffectCutsceneImmobilize();
		
	
	object oWyvSpawn = GetWaypointByTag("cave_wyvern_spawn_wp");
				object oWyvSpawnB = GetWaypointByTag("cave_wyvern_spawnb_wp");
				object oWyvSpawnC = GetWaypointByTag("cave_wyvern_spawnc_wp");
				object oInvisSpawn = GetWaypointByTag("dqspx_thar_tomb");
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
				object oSpeaker = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_voice_xyz", GetLocation(oInvisSpawn));
				SetFirstName(oSpeaker, "Twisted Wyvern");
				SetLastName(oSpeaker, "Zombie");
				
				ChangeToStandardFaction(OBJECT_SELF, STANDARD_FACTION_COMMONER);
				SetScale(OBJECT_SELF, 0.1, 0.1, 0.1);
				AssignCommand(oSpeaker, ActionSpeakString("*A roar sounds distantly, echoing in the chamber", TALKVOLUME_TALK));
				DelayCommand(1.0, AssignCommand(OBJECT_SELF, PlaySound("as_an_dragonror1", FALSE)));
			    DelayCommand(1.0, AssignCommand(oSpeaker, PlaySound("as_an_dragonror1", FALSE)));
			    object oPC = GetFirstObjectInShape(SHAPE_SPHERE, 20.0, GetLocation(oPortal), FALSE, OBJECT_TYPE_CREATURE);
				while(oPC != OBJECT_INVALID) {
					if(GetIsSkillSuccessful(oPC, SKILL_LISTEN, 15, TRUE)) {SendMessageToPC(oPC, "The roar came out the abyss, over the edge of this little stone island. Turning, you spot shadowy movement in the depths. Which you hadn't realized were quite that deep...until now.");}
					oPC = GetNextObjectInShape(SHAPE_SPHERE, 20.0, GetLocation(oPortal), FALSE, OBJECT_TYPE_CREATURE);
					}
				
				DelayCommand(2.0, SetScale(OBJECT_SELF, 0.15, 0.15, 0.15));
				DelayCommand(3.0, SetScale(OBJECT_SELF, 0.2, 0.2, 0.2));
				DelayCommand(4.0, SetScale(OBJECT_SELF, 0.25, 0.25, 0.25));
				DelayCommand(5.0, SetScale(OBJECT_SELF, 0.3, 0.35, 0.3));
				DelayCommand(6.0, SetScale(OBJECT_SELF, 0.35, 0.35, 0.35));
				DelayCommand(7.0, SetScale(OBJECT_SELF, 0.4, 0.4, 0.4));
				DelayCommand(8.0, SetScale(OBJECT_SELF, 0.45, 0.45, 0.45));
				DelayCommand(9.0, SetScale(OBJECT_SELF, 0.5, 0.5, 0.5));
				DelayCommand(10.0, SetScale(OBJECT_SELF, 0.55, 0.55, 0.55));
				
				DelayCommand(11.0, AssignCommand(OBJECT_SELF, PlaySound("as_an_dragonror2", FALSE)));
			    DelayCommand(11.0, AssignCommand(oSpeaker, PlaySound("as_an_dragonror2", FALSE)));
			    DelayCommand(11.0, SetScale(OBJECT_SELF, 0.6, 0.6, 0.6));
				DelayCommand(12.0, SetScale(OBJECT_SELF, 0.65, 0.65, 0.65));
				DelayCommand(13.0, SetScale(OBJECT_SELF, 0.7, 0.7, 0.7));
				DelayCommand(14.0, SetScale(OBJECT_SELF, 0.75, 0.75, 0.75));
				DelayCommand(15.0, SetScale(OBJECT_SELF, 0.8, 0.8, 0.8));
				DelayCommand(16.0, SetScale(OBJECT_SELF, 0.85, 0.85, 0.85));
				DelayCommand(17.0, SetScale(OBJECT_SELF, 0.9, 0.9, 0.9));
				DelayCommand(18.0, SetScale(OBJECT_SELF, 0.95, 0.95, 0.95));
				DelayCommand(19.0, SetScale(OBJECT_SELF, 1.0, 1.0, 1.0));
				
				DelayCommand(20.0, AssignCommand(OBJECT_SELF, ActionJumpToLocation(GetLocation(oWyvSpawnB))));      
				DelayCommand(21.0, AssignCommand(OBJECT_SELF, PlaySound("as_an_dragonror3", FALSE)));
			    DelayCommand(21.0, AssignCommand(oSpeaker, PlaySound("as_an_dragonror3", FALSE)));
			    
				
				DelayCommand(55.0, AssignCommand(OBJECT_SELF, ActionForceMoveToLocation(GetLocation(oWyvSpawnB), TRUE, 10.0)));      
				DelayCommand(56.0, AssignCommand(OBJECT_SELF, ActionForceMoveToLocation(GetLocation(oWyvSpawnB), TRUE, 10.0)));      
				DelayCommand(57.0, AssignCommand(OBJECT_SELF, ActionForceMoveToLocation(GetLocation(oWyvSpawnB), TRUE, 10.0)));      
				
				DelayCommand(57.0, AssignCommand(OBJECT_SELF, PlaySound("as_an_dragonror1", FALSE)));
			    DelayCommand(58.0, AssignCommand(oSpeaker, ActionSpeakString("*Roars and folds wings, swooping out of sight into the chasm.", TALKVOLUME_TALK)));
				 
				DelayCommand(60.0, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutScene, OBJECT_SELF));
				DelayCommand(60.0, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eFreeze,OBJECT_SELF));
    	 		DelayCommand(60.0, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eInvis, OBJECT_SELF));
				 
				DelayCommand(75.0, AssignCommand(oSpeaker, ActionSpeakString("*The bridge explodes upwards!", TALKVOLUME_TALK)));
				DelayCommand(76.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eShrapnel, oExplosionWP, 5.0));
				DelayCommand(76.0, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eShrapnel, GetLocation(oExplosionWP), 5.0));
				DelayCommand(77.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eExplode, oExplosionWP, 5.0));
				DelayCommand(77.0, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eExplode, GetLocation(oExplosionWP), 5.0));
				
				DelayCommand(80.0, ActionCreateWynCreature("abr_un_wyv_twisted", GetLocation(oWyvSpawnC)));
				DelayCommand(80.0, AssignCommand(oSpeaker, ActionSpeakString("*Shrapnel flies as the wyvern bursts through the bridge from below.", TALKVOLUME_TALK)));
				
				DelayCommand(81.0, ActionCreateWynPlaceable("cave_bridge_blackout", GetLocation(oBlackWP)));
				DelayCommand(81.0, ActionCreateWynPlaceable("cave_bridge_blackoutb", GetLocation(oBlackBWP)));
				DelayCommand(81.5, ActionCreateWynPlaceable("cave_bridge_rubble", GetLocation(oRubbleWP)));
				DelayCommand(81.5, ActionCreateWynPlaceable("cave_bridge_rubbleb", GetLocation(oRubbleBWP)));
				DelayCommand(82.0, ActionCreateWynPlaceable("cave_bridge_rubblec", GetLocation(oRubbleCWP)));
				DelayCommand(82.0, ActionCreateWynPlaceable("cave_bridge_rubbled", GetLocation(oRubbleDWP)));
				DelayCommand(82.5, ActionCreateWynPlaceable("cave_bridge_wall", GetLocation(oWallWP)));
				DelayCommand(82.5, ActionCreateWynPlaceable("cave_bridge_wallb", GetLocation(oWallBWP)));
				DelayCommand(83.0, ActionCreateWynPlaceable("cave_bridge_wallc", GetLocation(oWallCWP)));
				DelayCommand(83.0, ActionCreateWynPlaceable("cave_bridge_walld", GetLocation(oWallDWP)));
				DelayCommand(85.0, SetLocalInt(oPortal, "Activated", 2));
				
}