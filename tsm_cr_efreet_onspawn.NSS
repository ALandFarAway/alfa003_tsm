//
//    Filename : tsm_cr_efreet_onspawn
//      Version : 0.1
//         Date : 7/18/22
//       Author : Wynna
//
//  Description
//  This script creates spawn effects for an ephreet lord.
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

void ActionCreateWynEffect(string sObject, location lLocObject)
{
    CreateObject(OBJECT_TYPE_PLACED_EFFECT, sObject, lLocObject);
}

void main() {

	ExecuteScript("acf_cre_onspawnin_buffed", OBJECT_SELF);
	object oEfreet = OBJECT_SELF;
	object oInvisoCaster = GetObjectByTag("003_cr_invis_caster", 0);
	SetFirstName(oInvisoCaster, "Efreet of Set");
	object oOrb = GetObjectByTag("phalorm_orb_black", 0);
	object oGlobe = GetObjectByTag("phalorm_globe_black", 0);
	effect eAOE = EffectAreaOfEffect(AOE_MOB_FIRE);
    object oCollCreate = GetWaypointByTag("rr_coll_create_wp");
	object oPhaedra = GetObjectByTag("003_cr_bane_bp_elthonds", 0);
	object oPC = GetFirstPC(TRUE);
	object oJhessi = GetObjectByTag("003_pc_jhessi_2", 0);
	object oNio = GetObjectByTag("003_pc_nioniel_2", 0);
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
	
	AssignCommand(oInvisoCaster, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAOE, OBJECT_SELF, HoursToSeconds(100)));
	AssignCommand(oInvisoCaster, ActionCastSpellAtObject(SPELL_GLOBE_OF_INVULNERABILITY, OBJECT_SELF, METAMAGIC_NONE, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
	AssignCommand(oInvisoCaster, ActionCastSpellAtObject(SPELL_PROTECTION_FROM_ARROWS, OBJECT_SELF, METAMAGIC_NONE, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
	AssignCommand(oInvisoCaster, ActionCastSpellAtObject(SPELL_DEATH_WARD, OBJECT_SELF, METAMAGIC_NONE, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
	AssignCommand(oInvisoCaster, DelayCommand(1.0, ActionSpeakString("I am the curse of Horus-Re; I am the scourge of Scions. I am EFREET, whose freedom no longer shall be withheld!", TALKVOLUME_TALK)));
	
	AssignCommand(oInvisoCaster, DelayCommand(10.0, ActionSpeakString("All shall suffer; all shall be separated, part from part! Let the harpies fly! Release the djinn!", TALKVOLUME_TALK)));
	
	
	
	 
}