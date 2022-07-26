//
//     Filename : tsm_cr_sayen_onspawn
//      Version : 0.1
//         Date : 7/18/22
//       Author : Wynna
//
//  Description
//  This script handles onspawn functions for a high level necromancer.
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

	ExecuteScript("acf_cre_onspawnin_buffed", OBJECT_SELF);
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
	effect eGhost = EffectVisualEffect(VFX_DUR_SPELL_ETHEREALNESS, FALSE);
	effect eEthereal = EffectEthereal();
	effect eAOE = EffectAreaOfEffect(AOE_MOB_FEAR);
    object oPC = GetFirstPC(TRUE);
	object oJhessi = GetObjectByTag("003_pc_jhessi_2", 0);
	object oNio = GetObjectByTag("003_pc_nioniel_2", 0);;
	object oSaerela = GetObjectByTag("003_pc_saerela_2", 0);
	object oBertilak = GetObjectByTag("003_pc_bertilak_2", 0);
	object oBellie = GetObjectByTag("003_pc_bellie_2", 0);
	object oBae = GetObjectByTag("003_pc_baeithra_2", 0);
	object oAsh = GetObjectByTag("003_pc_asheeleaf_2", 0);
	while(oPC != OBJECT_INVALID) {
		string sPCName = GetName(oPC);
		if(FindSubString(sPCName, "Jhessi") != -1) {
			oJhessi = oPC;
		}
		if(FindSubString(sPCName, "Nio") != -1) {
			oNio = oPC;
		}
		if(FindSubString(sPCName, "Saerel") != -1) {
			oSaerela = oPC;
		}
		if(FindSubString(sPCName, "Bert") != -1) {
			oBertilak = oPC;
		}
		if(FindSubString(sPCName, "Bell") != -1) {
			oBellie = oPC;
		}
		if(FindSubString(sPCName, "Bae") != -1) {
			oBae = oPC;
		}
		if(FindSubString(sPCName, "Ash") != -1) {
			oAsh = oPC;
		}
	oPC = GetNextPC(TRUE);
	}
	 
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eInvis, OBJECT_SELF, 30.0);
	//ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGhost, OBJECT_SELF, 90.0);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEthereal, OBJECT_SELF, 90.0);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFreeze, OBJECT_SELF, 30.0);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAOE, OBJECT_SELF, HoursToSeconds(100));
	DestroyObject(oOrbGlow, 1.0);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLight, OBJECT_SELF, 900.0);
	ActionCastSpellAtObject(SPELL_GLOBE_OF_INVULNERABILITY, OBJECT_SELF, METAMAGIC_NONE, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
	ActionCastSpellAtObject(SPELL_PROTECTION_FROM_ARROWS, OBJECT_SELF, METAMAGIC_NONE, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
	ActionCastSpellAtObject(SPELL_ENERGY_IMMUNITY_FIRE, OBJECT_SELF, METAMAGIC_NONE, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
	DelayCommand(10.0, ActionSpeakString("*A voice echoes from around the room* I am Gyasi Sayen, Scion of House Sayen. My unlife was the lock upon the curse of Horus-Re. My destruction left open a doorway.", TALKVOLUME_TALK));
	DelayCommand(20.0, ActionSpeakString("Thou who wert strong enough to destroy an age-weakened lich may serve beside the same sinner with powers refreshed, against what shall surely otherwise destroy us all.", TALKVOLUME_TALK));
	DelayCommand(29.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eAppear, GetLocation(OBJECT_SELF)));
	DelayCommand(30.0, ActionSpeakString("*A figure shimmers out of the tallest black crystal and hovers.* NOW MOVE FROM BEFORE ME!", TALKVOLUME_TALK));
	
	DelayCommand(35.0, ActionCastSpellAtObject(SPELL_GUST_OF_WIND, oMoveTo, METAMAGIC_NONE, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
	DelayCommand(35.0, ActionJumpToObject(oMoveTo, FALSE));
	DelayCommand(36.0, SetFacing(DIRECTION_EAST));
	
	
	DelayCommand(32.0, AssignCommand(GetNearestCreatureToLocation(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, GetLocation(oMoveTo), 1), ActionMoveAwayFromLocation(GetLocation(oMoveTo), TRUE, 10.0))); 
	DelayCommand(33.0, AssignCommand(GetNearestCreatureToLocation(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, GetLocation(oMoveTo), 2), ActionMoveAwayFromLocation(GetLocation(oMoveTo), TRUE, 10.0))); 
	DelayCommand(34.0, AssignCommand(GetNearestCreatureToLocation(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, GetLocation(oMoveTo), 3), ActionMoveAwayFromLocation(GetLocation(oMoveTo), TRUE, 10.0))); 
	DelayCommand(35.0, AssignCommand(GetNearestCreatureToLocation(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, GetLocation(oMoveTo), 4), ActionMoveAwayFromLocation(GetLocation(oMoveTo), TRUE, 10.0))); 
	DelayCommand(36.0, AssignCommand(GetNearestCreatureToLocation(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, GetLocation(oMoveTo), 5), ActionMoveAwayFromLocation(GetLocation(oMoveTo), TRUE, 10.0))); 
	DelayCommand(37.0, AssignCommand(GetNearestCreatureToLocation(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, GetLocation(oMoveTo), 6), ActionMoveAwayFromLocation(GetLocation(oMoveTo), TRUE, 10.0))); 
	DelayCommand(38.0, AssignCommand(GetNearestCreatureToLocation(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, GetLocation(oMoveTo), 7), ActionMoveAwayFromLocation(GetLocation(oMoveTo), TRUE, 10.0))); 
	
	object oAfraid = GetFirstObjectInShape(SHAPE_SPHERE, 5.0, GetLocation(OBJECT_SELF), FALSE, OBJECT_TYPE_CREATURE);
	while (oAfraid != OBJECT_INVALID) {
		
	 	oAfraid = GetNextObjectInShape(SHAPE_SPHERE, 5.0, GetLocation(OBJECT_SELF), FALSE, OBJECT_TYPE_CREATURE);
	}
	DelayCommand(40.0, ActionSpeakString("Come to me, oh thou familiars released to my need, and be free upon condition of your aid!", TALKVOLUME_TALK));
	DelayCommand(45.0, ActionCreateWynCreature("003_cr_un_banite_vassal", GetLocation(OBJECT_SELF)));
	
	//Jhessi
	DelayCommand(46.0, SendMessageToPC(oJhessi, "*You feel Master Evenwood's arcane presence and see his face among the screaming vassals."));
	 
	
	DelayCommand(50.0, ActionSpeakString("Come to me, my acolyte, whom neither mundane nor magical imprisonment shall bar from me, for thou soul became the Sphere's whence attempted thou the Ritual of Remaking.", TALKVOLUME_TALK));
	

	DelayCommand(55.0, ActionCreateWynCreature("003_cr_bane_bp_elthonds", GetLocation(OBJECT_SELF)));
	
	//Bert
	DelayCommand(59.0, SendMessageToPC(oBertilak, "*You see Phaedra look up. When she finds you, she looks at you with murder in her eye."));
    DelayCommand(60.0, ActionCastSpellAtObject(SPELL_GLOBE_OF_INVULNERABILITY, OBJECT_SELF, METAMAGIC_NONE, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
	
	
	DelayCommand(70.0, ActionSpeakString("Fight! Fight all of you! Fight for your afterlife. For the curse of Horus-Re was to release me to the mercy of Set!", TALKVOLUME_TALK));
	
	
	
	 
}