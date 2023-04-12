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
	/*object oInvisoCaster = GetObjectByTag("003_cr_invis_caster", 0);
	object oOrb = GetObjectByTag("phalorm_orb_black", 0);
	int nHP = GetCurrentHitPoints(oOrb);
	object oMoveTo = GetWaypointByTag("rr_sayen_move_wp");
	object oOrbGlow = GetObjectByTag("fx_okku_mound_rr", 0);
	effect eInvis = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY, FALSE);
	effect eAOE = EffectAreaOfEffect(AOE_MOB_UNNATURAL);
    */
	effect eLight = EffectVisualEffect(VFX_DUR_LIGHT_RED_20, FALSE);
	effect eFreeze = EffectCutsceneImmobilize();
	effect eAppear = EffectVisualEffect(VFX_HIT_AOE_ILLUSION, FALSE);
	effect eEthereal = EffectEthereal();
	effect eAOE = EffectAreaOfEffect(AOE_MOB_FEAR);
	effect eAnti = EffectVisualEffect(VFX_DUR_ANTI_LIGHT_10);
	effect eDoom = EffectVisualEffect(VFX_DUR_AOE_CREEPING_DOOM);
	effect eGhost = EffectVisualEffect(VFX_DUR_GHOSTLY_PULSE);
	effect eSmoke = EffectVisualEffect(VFX_DUR_GHOST_SMOKE);
	
	ExecuteScript("acf_cre_onspawnin_buffed", OBJECT_SELF);
	
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eAOE, OBJECT_SELF);
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, OBJECT_SELF);
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDoom, OBJECT_SELF);
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eAnti, OBJECT_SELF);
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSmoke, OBJECT_SELF);
	ClearAllActions(TRUE);
	
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
		
		if(FindSubString(sPCName, "Ash") != -1) {
			oAsh = oPC;
		}
	oPC = GetNextPC(TRUE);
	}
	 
	ActionCastSpellAtObject(SPELL_GLOBE_OF_INVULNERABILITY, OBJECT_SELF, METAMAGIC_NONE, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
	ActionCastSpellAtObject(SPELL_PROTECTION_FROM_ARROWS, OBJECT_SELF, METAMAGIC_NONE, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
	ActionCastSpellAtObject(SPELL_ENERGY_IMMUNITY_FIRE, OBJECT_SELF, METAMAGIC_NONE, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
	 
}