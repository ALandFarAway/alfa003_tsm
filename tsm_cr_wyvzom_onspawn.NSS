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
	if(GetLocalInt(GetModule(), "WyvernSpawned") != 1) {
		SetLocalInt(GetModule(), "WyvernSpawned", 1);
		object oWyvSpawn = GetWaypointByTag("cave_wyvern_spawn_wp");
		ActionJumpToLocation(GetLocation(oWyvSpawn));      
		object oPortal = GetObjectByTag("alfa_portal_plc_wyv", 0);
		effect eCutScene = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);
		effect eFreeze = EffectCutsceneImmobilize();
		SetStandardFactionReputation(STANDARD_FACTION_HOSTILE, 50, OBJECT_SELF);
		ChangeToStandardFaction(OBJECT_SELF, STANDARD_FACTION_COMMONER);
		ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutScene, OBJECT_SELF);
		ApplyEffectToObject(DURATION_TYPE_PERMANENT, eFreeze,OBJECT_SELF);
	    SetFirstName(OBJECT_SELF, "Twisted Wyvern");
		SetLastName(OBJECT_SELF, "");
		
		object oSpeaker = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_voice_xyz", GetLocation(oPortal));
		ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutScene, oSpeaker);
		ApplyEffectToObject(DURATION_TYPE_PERMANENT, eFreeze,oSpeaker);
	    SetStandardFactionReputation(STANDARD_FACTION_HOSTILE, 50, oSpeaker);
		SetFirstName(oSpeaker, "Narrator");
		SetLastName(oSpeaker, "");
		
		SetLocalObject(oSpeaker, "oWyvern", OBJECT_SELF);
		}
	 else{
		 object oMoveD = GetWaypointByTag("wyvern_moved_wp");
	     ActionCastSpellAtObject(SPELL_PROTECTION_FROM_ARROWS, OBJECT_SELF, METAMAGIC_PERMANENT, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
		 ActionCastSpellAtObject(SPELL_GLOBE_OF_INVULNERABILITY, OBJECT_SELF, METAMAGIC_PERMANENT, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
		 ActionCastSpellAtObject(SPELL_PROTECTION_FROM_ENERGY, OBJECT_SELF, METAMAGIC_PERMANENT, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
		 ActionSpeakString("*Launches up and over the group, landing at the rear.", TALKVOLUME_TALK);
		 ActionJumpToLocation(GetLocation(oMoveD));      
	}		
}