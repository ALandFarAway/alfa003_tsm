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

	//ExecuteScript("acf_cre_onspawnin", OBJECT_SELF);
	//ActivateLongTermBuffs(OBJECT_SELF);
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
		if(FindSubString(sPCName, "Bae") != -1) {
			oBae = oPC;
		}
		if(FindSubString(sPCName, "Ash") != -1) {
			oAsh = oPC;
		}
	oPC = GetNextPC(TRUE);
	}
	
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAOE, OBJECT_SELF, HoursToSeconds(100));
	ActionCastSpellAtObject(SPELL_GLOBE_OF_INVULNERABILITY, OBJECT_SELF, METAMAGIC_NONE, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
	ActionCastSpellAtObject(SPELL_PROTECTION_FROM_ARROWS, OBJECT_SELF, METAMAGIC_NONE, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
	ActionCastSpellAtObject(SPELL_DEATH_WARD, OBJECT_SELF, METAMAGIC_NONE, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
	AssignCommand(oInvisoCaster, DelayCommand(1.0, ActionSpeakString("I am the curse of Horus-Re; I am the scourge of Scions. I am EFREET, whose freedom no longer shall be withheld!", TALKVOLUME_TALK)));
	
	AssignCommand(oInvisoCaster, DelayCommand(10.0, ActionSpeakString("All shall suffer; all shall be separated, part from part! Let the harpies fly! Release the djinn!", TALKVOLUME_TALK)));
	
	
	AssignCommand(oInvisoCaster, DelayCommand(11.0, ActionCreateWynCreature("abr_cr_ou_genie_efreeti", GetLocation(oPhaedra))));
	AssignCommand(oInvisoCaster, DelayCommand(13.0, ActionCreateWynCreature("abr_cr_ou_genie_efreeti", GetLocation(oGlobe))));
	
	AssignCommand(oInvisoCaster, DelayCommand(13.0, SetScale(oEfreet, 1.15, 1.15, 1.15)));
	AssignCommand(oInvisoCaster, DelayCommand(14.0, SetScale(oEfreet, 1.3, 1.3, 1.3)));
	AssignCommand(oInvisoCaster, DelayCommand(15.0, SetScale(oEfreet, 1.45, 1.45, 1.45)));
	AssignCommand(oInvisoCaster, DelayCommand(16.0, SetScale(oEfreet, 1.6, 1.6, 1.6)));
	AssignCommand(oInvisoCaster, DelayCommand(17.0, SetScale(oEfreet, 1.75, 1.75, 1.75)));
	AssignCommand(oInvisoCaster, DelayCommand(18.0, SetScale(oEfreet, 1.9, 1.9, 1.9)));
	AssignCommand(oInvisoCaster, DelayCommand(20.0, SetScale(oEfreet, 2.05, 2.05, 2.05)));
	
	AssignCommand(oInvisoCaster, DelayCommand(20.0, ActionCreateWynPlaceable("rr_crystal_coll", GetLocation(oCollCreate))));
	
	AssignCommand(oInvisoCaster, DelayCommand(10.0, ActionCreateWynEffect("fx_portal_gen_small", GetLocation(oBertilak))));
	AssignCommand(oInvisoCaster, DelayCommand(11.0, ActionCreateWynCreature("009_cr_mh_harpy4", GetLocation(oBertilak))));
	AssignCommand(oInvisoCaster, DelayCommand(13.0, ActionCreateWynCreature("abr_cr_ou_genie_efreeti", GetLocation(oBertilak))));
	
	AssignCommand(oInvisoCaster, DelayCommand(12.0, ActionCreateWynEffect("fx_portal_gen_small", GetLocation(oBae))));
	AssignCommand(oInvisoCaster, DelayCommand(13.0, ActionCreateWynCreature("009_cr_mh_harpy4", GetLocation(oBae))));
	
	AssignCommand(oInvisoCaster, DelayCommand(14.0, ActionCreateWynEffect("fx_portal_gen_small", GetLocation(oNio))));
	AssignCommand(oInvisoCaster, DelayCommand(15.0, ActionCreateWynCreature("009_cr_mh_harpy4", GetLocation(oNio))));
	
	AssignCommand(oInvisoCaster, DelayCommand(16.0, ActionCreateWynEffect("fx_portal_gen_small", GetLocation(oSaerela))));
	AssignCommand(oInvisoCaster, DelayCommand(17.0, ActionCreateWynCreature("009_cr_mh_harpy4", GetLocation(oSaerela))));
	
	AssignCommand(oInvisoCaster, DelayCommand(18.0, ActionCreateWynEffect("fx_portal_gen_small", GetLocation(oAsh))));
	AssignCommand(oInvisoCaster, DelayCommand(19.0, ActionCreateWynCreature("009_cr_mh_harpy4", GetLocation(oAsh))));
	
	AssignCommand(oInvisoCaster, DelayCommand(20.0, ActionSpeakString("*A circle of blazing light dilates open before each of you, becoming windows on a sandy expanse. A hot, gritty wind blows through.", TALKVOLUME_TALK)));
	
	AssignCommand(oInvisoCaster, DelayCommand(20.0, ActionCreateWynEffect("fx_portal_gen_small", GetLocation(oJhessi))));
	AssignCommand(oInvisoCaster, DelayCommand(21.0, ActionCreateWynCreature("009_cr_mh_harpy4", GetLocation(oJhessi))));
	
	AssignCommand(oInvisoCaster, DelayCommand(22.0, ActionCreateWynEffect("fx_portal_gen_small", GetLocation(oBellie))));
	AssignCommand(oInvisoCaster, DelayCommand(23.0, ActionCreateWynCreature("009_cr_mh_harpy4", GetLocation(oBellie))));
	
	
	
	AssignCommand(oInvisoCaster, DelayCommand(24.0, ActionCreateWynCreature("abr_cr_ou_genie_djinni_h", GetLocation(oGlobe))));
	AssignCommand(oInvisoCaster, DelayCommand(25.0, ActionCreateWynCreature("abr_cr_ou_genie_djinni_h", GetLocation(oGlobe))));
	AssignCommand(oInvisoCaster, DelayCommand(26.0, ActionCreateWynCreature("abr_cr_ou_genie_djinni_h", GetLocation(oGlobe))));
	
	 
}