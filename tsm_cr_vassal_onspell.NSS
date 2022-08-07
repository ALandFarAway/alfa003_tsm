//
//     Filename : tsm_cr_scarab_onspawn
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

#include "acr_creature_i"

void ActionCreateWynCreature(string sCreature, location lLocCreature)
{
    CreateObject(OBJECT_TYPE_CREATURE, sCreature, lLocCreature);
}

void main() {

	ACR_CreatureOnSpellCastAt();

    object oCaster = GetLastSpellCaster();
	object oItem = GetSpellCastItem();

	object oJhessi = GetObjectByTag("003_pc_jhessi_2", 0);
	object oPC = GetFirstPC(TRUE);
	while(oPC != OBJECT_INVALID) {
		string sPCName = GetName(oPC);
		if(FindSubString(sPCName, "Jhessi") != -1) {
			oJhessi = oPC;
			}
		
	oPC = GetNextPC(TRUE);
	}
 
	
	if(GetLastSpell() == 40) {
		ActionSpeakString("Hundreds of motes spring apart, each of them a tiny screaming face. Some vanish. Some swell into ethereal vengeance.", TALKVOLUME_TALK);
		object oGhostField = CreateObject(OBJECT_TYPE_PLACED_EFFECT, "tsm_afx_ror_fieldofghosts", GetLocation(OBJECT_SELF));
		CreateObject(OBJECT_TYPE_CREATURE, "003_cr_swift_ghostchild_f", GetLocation(OBJECT_SELF));
		CreateObject(OBJECT_TYPE_CREATURE, "003_cr_un_ghost_hum_m", GetLocation(OBJECT_SELF));
		CreateObject(OBJECT_TYPE_CREATURE, "003_cr_un_ghost_hum_f", GetLocation(OBJECT_SELF));
		CreateObject(OBJECT_TYPE_CREATURE, "003_cr_un_ghost_gob_f", GetLocation(OBJECT_SELF));
		CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_un_ghost_gob_m", GetLocation(OBJECT_SELF));
		
		DelayCommand(1.0, ActionCreateWynCreature("003_cr_un_ghost_dwwiz", GetLocation(OBJECT_SELF)));
		DelayCommand(1.0, ActionCreateWynCreature("abr_cr_un_harpy_ghost", GetLocation(OBJECT_SELF)));
		DelayCommand(2.0, ActionCreateWynCreature("003_cr_un_ghost_helf_m", GetLocation(OBJECT_SELF)));
		DelayCommand(2.0, ActionCreateWynCreature("003_cr_un_ghost_half_f", GetLocation(OBJECT_SELF)));
		DelayCommand(3.0, ActionCreateWynCreature("003_cr_un_ghost_humwiz", GetLocation(OBJECT_SELF)));
		DelayCommand(3.0, ActionCreateWynCreature("003_cr_un_ghost_elfcl", GetLocation(OBJECT_SELF)));
		DelayCommand(4.0, ActionCreateWynCreature("003_cr_un_ghost_humfgt", GetLocation(OBJECT_SELF)));
		DelayCommand(4.0, ActionCreateWynCreature("003_cr_circus_master_tigersx", GetLocation(OBJECT_SELF)));
		DelayCommand(5.0, ActionCreateWynCreature("003_cr_un_ghost_dwcl9", GetLocation(OBJECT_SELF)));
		DelayCommand(5.0, ActionCreateWynCreature("003_cr_un_ghost_gob_f", GetLocation(OBJECT_SELF)));
		DelayCommand(6.0, ActionCreateWynCreature("003_cr_un_harpy_ghost", GetLocation(OBJECT_SELF)));
		DelayCommand(6.0, ActionCreateWynCreature("abr_cr_un_minotaur_ghost", GetLocation(OBJECT_SELF)));
		DelayCommand(7.0, ActionCreateWynCreature("abr_cr_un_ghost_corrupt", GetLocation(OBJECT_SELF)));
		DelayCommand(7.0, ActionCreateWynCreature("c_st01_ghost_morrigan", GetLocation(OBJECT_SELF)));
		DelayCommand(8.0, ActionCreateWynCreature("003_cr_un_ghost_humcl", GetLocation(OBJECT_SELF)));
		DelayCommand(8.0, ActionCreateWynCreature("003_cr_un_ghost_clown", GetLocation(OBJECT_SELF)));
		DelayCommand(9.0, ActionCreateWynCreature("003_cr_un_ghost_clown", GetLocation(OBJECT_SELF)));
		DelayCommand(10.0, ActionCreateWynCreature("abr_cr_un_ghost_moan", GetLocation(OBJECT_SELF)));
		
		DestroyObject(oGhostField, 10.0);
		DestroyObject(OBJECT_SELF, 10.0);
		}
	 
		
	 
}