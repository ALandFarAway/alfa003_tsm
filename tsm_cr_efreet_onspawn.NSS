//
//    Filename : tsm_cr_efreet_onspawn
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

void ActionCreateWynEffect(string sObject, location lLocObject)
{
    CreateObject(OBJECT_TYPE_PLACED_EFFECT, sObject, lLocObject);
}

void main() {

	ExecuteScript("acf_cre_onspawnin", OBJECT_SELF);
	ActivateLongTermBuffs(OBJECT_SELF);
	object oEfreet = OBJECT_SELF;
	object oInvisoCaster = GetObjectByTag("003_cr_invis_caster", 0);
	SetFirstName(oInvisoCaster, "Efreet of Set");
	object oOrb = GetObjectByTag("phalorm_orb_black", 0);
	object oGlobe = GetObjectByTag("phalorm_globe_black", 0);
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
		
	object oPortal = CreateObject(OBJECT_TYPE_PLACED_EFFECT, "abr_afx_ajoc_demon_portal", GetLocation(oGlobe));
	AssignCommand(oInvisoCaster, DelayCommand(5.0, ActionSpeakString("I am the curse of Horus-Re; I am the scourge of Scions. I am EFREET, whose freedom no longer shall be withheld!", TALKVOLUME_TALK)));
	AssignCommand(oInvisoCaster, DelayCommand(6.0, SetScale(oEfreet, 1.25, 1.25, 1.25)));
	AssignCommand(oInvisoCaster, DelayCommand(10.0, SetScale(oEfreet, 1.5, 1.5, 1.5)));
	AssignCommand(oInvisoCaster, DelayCommand(16.0, SetScale(oEfreet, 1.75, 1.75, 1.75)));
	AssignCommand(oInvisoCaster, DelayCommand(20.0, SetScale(oEfreet, 2.0, 2.0, 2.0)));
	AssignCommand(oInvisoCaster, DelayCommand(15.0, ActionSpeakString("Bound by trickery; bound by the wizard and his electrum child; bound by the violated power that compels me!", TALKVOLUME_TALK)));
	AssignCommand(oInvisoCaster, DelayCommand(25.0, ActionSpeakString("All shall suffer; all shall be separated, part from part! Let the harpies fly! Release the djinn!", TALKVOLUME_TALK)));
	AssignCommand(oInvisoCaster, DelayCommand(25.0, ActionCreateWynCreature("abr_cr_ou_genie_efreeti", GetLocation(oGlobe))));
	AssignCommand(oInvisoCaster, DelayCommand(25.0, ActionCreateWynCreature("abr_cr_ou_genie_efreeti", GetLocation(oGlobe))));
	AssignCommand(oInvisoCaster, DelayCommand(26.0, ActionCreateWynCreature("009_cr_mh_harpy4", GetLocation(oBertilak))));
	AssignCommand(oInvisoCaster, DelayCommand(28.0, ActionCreateWynCreature("009_cr_mh_harpy4", GetLocation(oBae))));
	AssignCommand(oInvisoCaster, DelayCommand(30.0, ActionCreateWynCreature("009_cr_mh_harpy4", GetLocation(oNio))));
	AssignCommand(oInvisoCaster, DelayCommand(32.0, ActionCreateWynCreature("009_cr_mh_harpy4", GetLocation(oSaerela))));
	AssignCommand(oInvisoCaster, DelayCommand(34.0, ActionCreateWynCreature("009_cr_mh_harpy4", GetLocation(oBellie))));
	AssignCommand(oInvisoCaster, DelayCommand(36.0, ActionCreateWynCreature("009_cr_mh_harpy4", GetLocation(oJhessi))));
	AssignCommand(oInvisoCaster, DelayCommand(36.0, ActionCreateWynCreature("009_cr_mh_harpy4", GetLocation(oAsh))));
	AssignCommand(oInvisoCaster, DelayCommand(38.0, ActionCreateWynCreature("abr_cr_ou_genie_djinni_h", GetLocation(oGlobe))));
	AssignCommand(oInvisoCaster, DelayCommand(40.0, ActionCreateWynCreature("abr_cr_ou_genie_djinni_h", GetLocation(oGlobe))));
	AssignCommand(oInvisoCaster, DelayCommand(42.0, ActionCreateWynCreature("abr_cr_ou_genie_djinni_h", GetLocation(oGlobe))));
	
	
	 
}