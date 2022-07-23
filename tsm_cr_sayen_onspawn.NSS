//
//     Filename : tsm_cr_efreet_onspawn
//      Version : 0.1
//         Date : 7/18/22
//       Author : Wynna
//
//  Description
//  This script creates an onspawn fire aura for an ephreet lord.
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

void main() {

	ActivateLongTermBuffs(OBJECT_SELF);
	//ExecuteScript("acf_cre_onspawnin", OBJECT_SELF);
	object oSayen = OBJECT_SELF;
	object oInvisoCaster = GetObjectByTag("003_cr_invis_caster", 0);
	object oOrb = GetObjectByTag("phalorm_orb_black", 0);
	int nHP = GetCurrentHitPoints(oOrb);
	object oMoveTo = GetWaypointByTag("rr_sayen_move_wp");
	object oOrbGlow = GetObjectByTag("fx_okku_mound_rr", 0);
	effect eLight = EffectVisualEffect(VFX_DUR_LIGHT_RED_20, FALSE);
	effect eFreeze = EffectCutsceneImmobilize();
	effect eInvis = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY, FALSE);
	effect eAppear = EffectVisualEffect(VFX_HIT_AOE_ILLUSION, FALSE);
	effect eGhost = EffectVisualEffect(VFX_DUR_GHOST_TRANSPARENT, FALSE);
	 
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eInvis, OBJECT_SELF, 20.0);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGhost, OBJECT_SELF, 25.0);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFreeze, OBJECT_SELF, 30.0);
	DestroyObject(oOrbGlow, 1.0);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLight, OBJECT_SELF, 900.0);
	ActionCastSpellAtObject(SPELL_GLOBE_OF_INVULNERABILITY, OBJECT_SELF, METAMAGIC_NONE, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
	ActionCastSpellAtObject(SPELL_PROTECTION_FROM_ARROWS, OBJECT_SELF, METAMAGIC_NONE, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
	ActionCastSpellAtObject(SPELL_ENERGY_IMMUNITY_FIRE, OBJECT_SELF, METAMAGIC_NONE, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
	DelayCommand(10.0, ActionSpeakString("*A voice echoes from around the room* I am Gyasi Sayen, Scion of House Sayen. My unlife was the lock upon the curse of Horus-Re. My destruction left open a doorway.", TALKVOLUME_TALK));
	DelayCommand(19.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eAppear, GetLocation(OBJECT_SELF)));
	DelayCommand(20.0, ActionSpeakString("*A figure shimmers out of the tallest black crystal and hovers.", TALKVOLUME_TALK));
	DelayCommand(30.0, ActionSpeakString("Thou who were strong enough to destroy an age-weakened lich may serve beside the same sinner with powers refreshed, against what shall surely otherwise destroy us all. NOW MOVE FROM BEFORE ME!", TALKVOLUME_TALK));
	
	DelayCommand(31.0, ActionCastSpellAtObject(SPELL_GUST_OF_WIND, oMoveTo, METAMAGIC_NONE, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
	
	
	DelayCommand(32.0, AssignCommand(GetNearestCreatureToLocation(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, GetLocation(oMoveTo), 1), ActionMoveAwayFromLocation(GetLocation(oMoveTo), TRUE, 10.0))); 
	DelayCommand(33.0, AssignCommand(GetNearestCreatureToLocation(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, GetLocation(oMoveTo), 2), ActionMoveAwayFromLocation(GetLocation(oMoveTo), TRUE, 10.0))); 
	DelayCommand(34.0, AssignCommand(GetNearestCreatureToLocation(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, GetLocation(oMoveTo), 3), ActionMoveAwayFromLocation(GetLocation(oMoveTo), TRUE, 10.0))); 
	DelayCommand(35.0, AssignCommand(GetNearestCreatureToLocation(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, GetLocation(oMoveTo), 4), ActionMoveAwayFromLocation(GetLocation(oMoveTo), TRUE, 10.0))); 
	DelayCommand(36.0, AssignCommand(GetNearestCreatureToLocation(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, GetLocation(oMoveTo), 5), ActionMoveAwayFromLocation(GetLocation(oMoveTo), TRUE, 10.0))); 
	DelayCommand(37.0, AssignCommand(GetNearestCreatureToLocation(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, GetLocation(oMoveTo), 6), ActionMoveAwayFromLocation(GetLocation(oMoveTo), TRUE, 10.0))); 
	DelayCommand(38.0, AssignCommand(GetNearestCreatureToLocation(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, GetLocation(oMoveTo), 7), ActionMoveAwayFromLocation(GetLocation(oMoveTo), TRUE, 10.0))); 
	
	DelayCommand(38.0, ActionJumpToObject(oMoveTo, FALSE));
	DelayCommand(40.0, SetFacing(DIRECTION_EAST));
	 
	
	DelayCommand(40.0, ActionSpeakString("Come to me, oh you familiars released to my need, and be free upon condition of your aid!", TALKVOLUME_TALK));
	DelayCommand(45.0, ActionCreateWynCreature("003_cr_un_banite_vassal", GetLocation(OBJECT_SELF)));
	DelayCommand(50.0, ActionSpeakString("Come to me, also, my acolyte, whom no other mundane nor magical imprisonment shall bar from me, for your soul became the Sphere's when you attempted the Ritual of Remaking.", TALKVOLUME_TALK));
	DelayCommand(55.0, ActionCreateWynCreature("003_cr_bane_bp_elthonds", GetLocation(OBJECT_SELF)));
	
	DelayCommand(70.0, ActionSpeakString("Fight! Fight all of you! Fight for your afterlife. For the curse of Horus-Re was to release me to the mercy of Set!", TALKVOLUME_TALK));
	
	DelayCommand(80.0, ActionSpeakString("The Efreet of Set is released!", TALKVOLUME_TALK));
	
	
	 
}