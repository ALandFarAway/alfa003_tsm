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
#include "acr_spawn_i"

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
		ActionSpeakString("Hundreds of motes spring apart, each of them a tiny screaming face. Some vanish. Some swell into ghosts, drifting away in all directions.", TALKVOLUME_TALK);
		object oGhostField = CreateObject(OBJECT_TYPE_PLACED_EFFECT, "tsm_afx_ror_fieldofghosts", GetLocation(OBJECT_SELF));
		CreateObject(OBJECT_TYPE_CREATURE, "003_cr_swift_ghostchild_f", GetLocation(OBJECT_SELF));
		CreateObject(OBJECT_TYPE_CREATURE, "003_cr_un_ghost_hum_m", GetLocation(OBJECT_SELF));
		CreateObject(OBJECT_TYPE_CREATURE, "003_cr_un_ghost_hum_f", GetLocation(OBJECT_SELF));
		CreateObject(OBJECT_TYPE_CREATURE, "003_cr_un_ghost_gob_f", GetLocation(OBJECT_SELF));
		CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_un_ghost_gob_m", GetLocation(OBJECT_SELF));
		SetScale(OBJECT_SELF, 0.9, 0.9, 0.9);
		DelayCommand(1.0, ActionCreateWynCreature("003_cr_un_ghost_dwwiz", GetLocation(OBJECT_SELF)));
		DelayCommand(1.0, ActionCreateWynCreature("abr_cr_un_harpy_ghost", GetLocation(OBJECT_SELF)));
		DelayCommand(1.0, SetScale(OBJECT_SELF, 0.8, 0.8, 0.8));
		DelayCommand(2.0, ActionCreateWynCreature("003_cr_un_ghost_helf_m", GetLocation(OBJECT_SELF)));
		DelayCommand(2.0, ActionCreateWynCreature("003_cr_un_ghost_half_f", GetLocation(OBJECT_SELF)));
		DelayCommand(2.0, SetScale(OBJECT_SELF, 0.7, 0.7, 0.7));
		DelayCommand(3.0, ActionCreateWynCreature("003_cr_un_ghost_humwiz", GetLocation(OBJECT_SELF)));
		DelayCommand(3.0, ActionCreateWynCreature("003_cr_un_ghost_elfcl", GetLocation(OBJECT_SELF)));
		DelayCommand(3.0, SetScale(OBJECT_SELF, 0.6, 0.6, 0.6));
		DelayCommand(4.0, ActionCreateWynCreature("003_cr_un_ghost_humfgt", GetLocation(OBJECT_SELF)));
		DelayCommand(4.0, ActionCreateWynCreature("003_cr_circus_master_tigersx", GetLocation(OBJECT_SELF)));
		DelayCommand(4.0, SetScale(OBJECT_SELF, 0.5, 0.5, 0.5));
		DelayCommand(5.0, ActionCreateWynCreature("003_cr_un_ghost_dwcl9", GetLocation(OBJECT_SELF)));
		DelayCommand(5.0, ActionCreateWynCreature("003_cr_un_ghost_elfwiz", GetLocation(OBJECT_SELF)));
		DelayCommand(5.0, SetScale(OBJECT_SELF, 0.4, 0.4, 0.4));
		DelayCommand(6.0, ActionCreateWynCreature("003_cr_un_ghost_dwcl", GetLocation(OBJECT_SELF)));
		DelayCommand(6.0, ActionCreateWynCreature("abr_cr_un_minotaur_ghost", GetLocation(OBJECT_SELF)));
		DelayCommand(6.0, SetScale(OBJECT_SELF, 0.3, 0.3, 0.3));
		DelayCommand(7.0, ActionCreateWynCreature("abr_cr_un_ghost_corrupt", GetLocation(OBJECT_SELF)));
		DelayCommand(7.0, ActionCreateWynCreature("c_st01_ghost_morrigan", GetLocation(OBJECT_SELF)));
		DelayCommand(7.0, SetScale(OBJECT_SELF, 0.2, 0.2, 0.2));
		DelayCommand(8.0, ActionCreateWynCreature("003_cr_un_ghost_humcl", GetLocation(OBJECT_SELF)));
		DelayCommand(8.0, ActionCreateWynCreature("003_cr_un_ghost_clown", GetLocation(OBJECT_SELF)));
		DelayCommand(8.0, SetScale(OBJECT_SELF, 0.1, 0.1, 0.1));
		DelayCommand(9.0, ActionCreateWynCreature("003_cr_circus_magician_dead", GetLocation(OBJECT_SELF)));
		DelayCommand(9.0, ActionCreateWynCreature("003_cr_un_spirit_evenwood", GetLocation(OBJECT_SELF)));
		DelayCommand(10.0, ActionCreateWynCreature("abr_cr_un_ghost_moan", GetLocation(OBJECT_SELF)));
		DelayCommand(10.0, ActionSpeakString("*With each separation of a spirit, the vassal dwindles, until all that is left is a red spark and the figure of an old man, ghostly tears welling on his ethereal face.", TALKVOLUME_TALK));
		
		DestroyObject(oGhostField, 10.0);
		DelayCommand(50.0, ActionSpeakString("Somewhere, somebody screams.", TALKVOLUME_TALK));
		DelayCommand(55.0, ActionSpeakString("Another scream rings out, this one from a different direction, drifting out a window from the tavern.", TALKVOLUME_TALK));
		DelayCommand(60.0, ActionSpeakString("The door of the Headless Troll Inn bangs open, and Hilda Quintin runs out, shrieking about ghosts.", TALKVOLUME_TALK));
		DelayCommand(60.0, ActionCreateWynCreature("003_cr_oh_quintin", GetLocation(GetWaypointByTag("Post_abr_cr_un_harpy_ghost"))));
		object oTrollWP = GetWaypointByTag("ghost_troll_wp");
		_DespawnArea(GetArea(oTrollWP));
		DelayCommand(60.0, ActionCreateWynCreature("abr_cr_un_harpy_ghost", GetLocation(oTrollWP)));
		DelayCommand(61.0, ActionCreateWynCreature("abr_cr_un_harpy_ghost", GetLocation(oTrollWP)));
		DelayCommand(62.0, ActionCreateWynCreature("abr_cr_un_harpy_ghost", GetLocation(oTrollWP)));
		
		object oFlagonWP = GetWaypointByTag("ghost_flagon_wp");
		DelayCommand(60.0, ActionCreateWynCreature("003_cr_un_ghost_clown", GetLocation(oFlagonWP)));
		DelayCommand(61.0, ActionCreateWynCreature("003_cr_un_ghost_clown", GetLocation(oFlagonWP)));
		DelayCommand(62.0, ActionCreateWynCreature("abr_cr_un_minotaur_ghost", GetLocation(oFlagonWP)));
		DelayCommand(62.0, ActionCreateWynCreature("003_cr_circus_magician_dead", GetLocation(oFlagonWP)));
		
		object oLathWP = GetWaypointByTag("ghost_lathander_wp");
		DelayCommand(60.0, ActionCreateWynCreature("abr_cr_un_ghost_gob_m", GetLocation(oLathWP)));
		DelayCommand(61.0, ActionCreateWynCreature("abr_cr_un_ghost_gob_m", GetLocation(oLathWP)));
		DelayCommand(62.0, ActionCreateWynCreature("abr_cr_un_ghost_gob_f", GetLocation(oLathWP)));
		DelayCommand(62.0, ActionCreateWynCreature("abr_cr_un_ghost_gob_f", GetLocation(oLathWP)));
		
		
		object oKeepWP = GetWaypointByTag("ghost_keep_wp");
		DelayCommand(60.0, ActionCreateWynCreature("003_cr_un_ghost_elfwiz", GetLocation(oKeepWP)));
		DelayCommand(61.0, ActionCreateWynCreature("003_cr_un_ghost_dwcl", GetLocation(oKeepWP)));
		DelayCommand(62.0, ActionCreateWynCreature("003_cr_un_ghost_humfgt", GetLocation(oKeepWP)));
		DelayCommand(62.0, ActionCreateWynCreature("003_cr_un_ghost_humwiz", GetLocation(oKeepWP)));
		
		object oKeepWPB = GetWaypointByTag("ghost_keep_wpB");
		DelayCommand(60.0, ActionCreateWynCreature("003_cr_un_ghost_elfwiz", GetLocation(oKeepWPB)));
		DelayCommand(61.0, ActionCreateWynCreature("abr_cr_un_ghost_corrupt", GetLocation(oKeepWPB)));
		
		DelayCommand(65.0, ActionSpeakString("*The courtyard is in chaos, people fleeing, the undead pursuing, while shouts and cries ring out from within the Troll, the Flagon, the Keep and the Temple.", TALKVOLUME_TALK));
		
		}
	 
		
	 
}