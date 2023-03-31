////////////////////////////////////////////////////////////////////////////////
//
//  System Name : Portals
//     Filename : tsm_portal_plc_onuse.nss
//        $Date:: 2022-08-01 
//       Author : Wynna
//
//  This script looks for a variable upon a portal object that identifies the portal
//  key and destination, with options for keys that are items in the traveller's 
//  inventory or worn, and multiple possible destinations. 
//  It is not updated in ACR updates.
//

#include "acr_placeable_i"
#include "dmfi_inc_langexe" 
#include "acr_quest_i"

void ActionCreateWynCreature(string sCreature, location lLocCreature)
{
    CreateObject(OBJECT_TYPE_CREATURE, sCreature, lLocCreature);
}

void ActionCreateWynPlaceable(string sPlaceable, location lLocPlaceable)
{
    CreateObject(OBJECT_TYPE_PLACEABLE, sPlaceable, lLocPlaceable);
}

void ActionCreateWynPlacedEff(string sEffect, location lLocEffect)
{
    CreateObject(OBJECT_TYPE_PLACED_EFFECT, sEffect, lLocEffect);
}
void main() {
 
	if (!GetIsObjectValid(OBJECT_SELF))
		return;

	ACR_PlaceableOnUsed();


	if(FindSubString(GetTag(OBJECT_SELF), "_portal") != -1)
	{object oTraveller = GetLastUsedBy();
    
	string sKeyTag = GetLocalString(OBJECT_SELF, "PORTAL_KEY");
	string sKeyTagTwo = GetLocalString(OBJECT_SELF, "PORTAL_KEY_2");
	string sKeyTagThree = GetLocalString(OBJECT_SELF, "PORTAL_KEY_3");
	string sKeyTagFour = GetLocalString(OBJECT_SELF, "PORTAL_KEY_4");
	string sKeyTagFive = GetLocalString(OBJECT_SELF, "PORTAL_KEY_5");
	string sKeyTagSix = GetLocalString(OBJECT_SELF, "PORTAL_KEY_6");
	
	string sMyTarget = GetLocalString(OBJECT_SELF, "PORTAL_TARGET_WP");
	string sMyTargetTwo = GetLocalString(OBJECT_SELF, "PORTAL_TARGET_WP2");
	string sMyTargetThree = GetLocalString(OBJECT_SELF, "PORTAL_TARGET_WP3");
	string sMyTargetFour = GetLocalString(OBJECT_SELF, "PORTAL_TARGET_WP4");
	string sMyTargetFive = GetLocalString(OBJECT_SELF, "PORTAL_TARGET_WP5");
	string sMyTargetSix = GetLocalString(OBJECT_SELF, "PORTAL_TARGET_WP6");
	
	object oMask = GetItemInSlot(INVENTORY_SLOT_HEAD, oTraveller);
	string sMask = GetTag(oMask);
	
	object oMyWaypoint = GetWaypointByTag(sMyTarget);
	effect eVis = EffectVisualEffect(VFX_IMP_TORNADO);
    effect eAoe = EffectVisualEffect(VFX_HIT_AOE_CONJURATION);
    effect eCessate = EffectVisualEffect(VFX_DUR_CESSATE_NEUTRAL);
    
	
	//SendMessageToAllDMs("Tag = " + GetTag(OBJECT_SELF));
	SendMessageToAllDMs("nActivated = " + IntToString(GetLocalInt(OBJECT_SELF, "Activated")));
	//SendMessageToAllDMs("sMask = " + sMask);
	//SendMessageToAllDMs("sKey1 = " + sKeyTag);
	//SendMessageToAllDMs("sKey2 = " + sKeyTagTwo);
	//SendMessageToAllDMs("sKey3 = " + sKeyTagThree);
	//SendMessageToAllDMs("sKey4 = " + sKeyTagFour);
	//SendMessageToAllDMs("sKey5 = " + sKeyTagFive);
	//SendMessageToAllDMs("sKey6 = " + sKeyTagSix);
	
	if((oMask != OBJECT_INVALID) && (GetLocalInt(OBJECT_SELF, "Activated") != 1) && 
		((sMask == sKeyTag) || (sMask == sKeyTagTwo) || (sMask == sKeyTagThree) || (sMask == sKeyTagFour) || (sMask == sKeyTagFive) || (sMask == sKeyTagSix)))	{
		
			if(sMask == sKeyTag){oMyWaypoint = GetWaypointByTag(sMyTarget);}
			else if(sMask == sKeyTagTwo){oMyWaypoint = GetWaypointByTag(sMyTargetTwo);}
			else if(sMask == sKeyTagThree){oMyWaypoint = GetWaypointByTag(sMyTargetThree);}
			else if(sMask == sKeyTagFour){oMyWaypoint = GetWaypointByTag(sMyTargetFour);}
			else if(sMask == sKeyTagFive){oMyWaypoint = GetWaypointByTag(sMyTargetFive);}
			else if(sMask == sKeyTagSix){oMyWaypoint = GetWaypointByTag(sMyTargetSix);}
				
			SendMessageToAllDMs(GetName(oTraveller) + " is wearing " + sMask + " and is jumping to " + GetTag(oMyWaypoint));
			ApplyEffectToObject(DURATION_TYPE_INSTANT, eAoe, OBJECT_SELF);
		    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTraveller);
	   		if(GetIsDM(oTraveller) == FALSE) {DelayCommand(1.0, AssignCommand(oTraveller, ActionJumpToObject(oMyWaypoint)));}
			if(((GetIsDM(oTraveller)) || (GetLocalInt(OBJECT_SELF, "Activated") == 0)) && (FindSubString(GetTag(OBJECT_SELF), "wyv") != -1))  {
				SetLocalInt(OBJECT_SELF, "Activated", 1);
				object oExpWP = GetWaypointByTag("cave_explosion_wp");
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
				object oWyvern = CreateObject(OBJECT_TYPE_CREATURE, "abr_un_wyv_twisted", GetLocation(oWyvSpawn));
				object oSpeaker = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_voice_xyz", GetLocation(oInvisSpawn));
				SetFirstName(oSpeaker, "Twisted Wyvern");
				SetLastName(oSpeaker, "Zombie");
				
				ChangeToStandardFaction(oWyvern, STANDARD_FACTION_COMMONER);
				SetScale(oWyvern, 0.1, 0.1, 0.1);
				AssignCommand(oSpeaker, ActionSpeakString("*A roar sounds distantly, echoing in the chamber", TALKVOLUME_TALK));
				DelayCommand(1.0, AssignCommand(oWyvern, PlaySound("as_an_dragonror1", FALSE)));
			    DelayCommand(1.0, AssignCommand(oSpeaker, PlaySound("as_an_dragonror1", FALSE)));
			    object oPC = GetFirstObjectInShape(SHAPE_SPHERE, 20.0, GetLocation(OBJECT_SELF), FALSE, OBJECT_TYPE_CREATURE);
				while(oPC != OBJECT_INVALID) {
					if(GetIsSkillSuccessful(oPC, SKILL_LISTEN, 15, TRUE)) {SendMessageToPC(oPC, "The roar came out the abyss, over the edge of this little stone island. Turning, you spot shadowy movement in the depths. Which you hadn't realized were quite that deep...until now.");}
					oPC = GetNextObjectInShape(SHAPE_SPHERE, 20.0, GetLocation(OBJECT_SELF), FALSE, OBJECT_TYPE_CREATURE);
					}
				
				DelayCommand(2.0, SetScale(oWyvern, 0.15, 0.15, 0.15));
				DelayCommand(3.0, SetScale(oWyvern, 0.2, 0.2, 0.2));
				DelayCommand(4.0, SetScale(oWyvern, 0.25, 0.25, 0.25));
				DelayCommand(5.0, SetScale(oWyvern, 0.3, 0.35, 0.3));
				DelayCommand(6.0, SetScale(oWyvern, 0.35, 0.35, 0.35));
				DelayCommand(7.0, SetScale(oWyvern, 0.4, 0.4, 0.4));
				DelayCommand(8.0, SetScale(oWyvern, 0.45, 0.45, 0.45));
				DelayCommand(9.0, SetScale(oWyvern, 0.5, 0.5, 0.5));
				DelayCommand(10.0, SetScale(oWyvern, 0.55, 0.55, 0.55));
				
				DelayCommand(11.0, AssignCommand(oWyvern, PlaySound("as_an_dragonror2", FALSE)));
			    DelayCommand(11.0, AssignCommand(oSpeaker, PlaySound("as_an_dragonror2", FALSE)));
			    DelayCommand(11.0, SetScale(oWyvern, 0.6, 0.6, 0.6));
				DelayCommand(12.0, SetScale(oWyvern, 0.65, 0.65, 0.65));
				DelayCommand(13.0, SetScale(oWyvern, 0.7, 0.7, 0.7));
				DelayCommand(14.0, SetScale(oWyvern, 0.75, 0.75, 0.75));
				DelayCommand(15.0, SetScale(oWyvern, 0.8, 0.8, 0.8));
				DelayCommand(16.0, SetScale(oWyvern, 0.85, 0.85, 0.85));
				DelayCommand(17.0, SetScale(oWyvern, 0.9, 0.9, 0.9));
				DelayCommand(18.0, SetScale(oWyvern, 0.95, 0.95, 0.95));
				DelayCommand(19.0, SetScale(oWyvern, 1.0, 1.0, 1.0));
				
				DelayCommand(20.0, AssignCommand(oWyvern, ActionJumpToLocation(GetLocation(oWyvSpawnB))));      
				DelayCommand(21.0, AssignCommand(oWyvern, PlaySound("as_an_dragonror3", FALSE)));
			    DelayCommand(21.0, AssignCommand(oSpeaker, PlaySound("as_an_dragonror3", FALSE)));
			    
				
				DelayCommand(55.0, AssignCommand(oWyvern, ActionForceMoveToLocation(GetLocation(oWyvSpawnB), TRUE, 10.0)));      
				DelayCommand(56.0, AssignCommand(oWyvern, ActionForceMoveToLocation(GetLocation(oWyvSpawnB), TRUE, 10.0)));      
				DelayCommand(57.0, AssignCommand(oWyvern, ActionForceMoveToLocation(GetLocation(oWyvSpawnB), TRUE, 10.0)));      
				
				DelayCommand(57.0, AssignCommand(oWyvern, PlaySound("as_an_dragonror1", FALSE)));
			    DelayCommand(58.0, AssignCommand(oSpeaker, ActionSpeakString("*Roars and folds wings, swooping out of sight into the chasm.", TALKVOLUME_TALK)));
				DestroyObject(oWyvern, 60.0);
				
				DelayCommand(75.0, ActionCreateWynPlacedEff("tsm_ffx_1303_rockslide_dust", GetLocation(oWyvSpawnC)));
				DelayCommand(75.0, ActionCreateWynPlacedEff("tsm_ffx_dust_hit", GetLocation(oWyvSpawnC)));
				
				DelayCommand(75.0, AssignCommand(oSpeaker, ActionSpeakString("*The bridge explodes upwards!", TALKVOLUME_TALK)));
				DelayCommand(76.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eShrapnel, oWyvSpawnC, 5.0));
				DelayCommand(76.0, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eShrapnel, GetLocation(oWyvSpawnC), 5.0));
				DelayCommand(77.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eExplode, oWyvSpawnC, 5.0));
				DelayCommand(77.0, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eExplode, GetLocation(oWyvSpawnC), 5.0));
				
				DelayCommand(80.0, ActionCreateWynCreature("abr_un_wyv_twisted", GetLocation(oWyvSpawnC)));
				DelayCommand(80.0, AssignCommand(oSpeaker, ActionSpeakString("*Shrapnel flies as the wyvern bursts through the bridge from below.", TALKVOLUME_TALK)));
				DelayCommand(81.0, DestroyObject(GetObjectByTag("tsm_ffx_dust_hit", 0)));
				DelayCommand(81.0, DestroyObject(GetObjectByTag("tsm_ffx_1303_rockslide_dust", 0)));
				
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
				DelayCommand(85.0, SetLocalInt(OBJECT_SELF, "Activated", 2));
				}
			}
	else {SendMessageToPC(oTraveller, "Nothing happens.");
		if((d20(1) + GetAbilityModifier(ABILITY_WISDOM, oTraveller)) >= 15) {
			SendMessageToPC(oTraveller, "You sense the potential power in this object");
			}
		} 
	}
}