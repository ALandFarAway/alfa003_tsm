//
//     Filename : tsm_cr_scarab_onspawn
//      Version : 0.1
//         Date : 7/18/22
//       Author : Wynna
//
//  Description
//  This script creates an onspawn fire aura for a janni's owl bear companion.
//	It is not updated in ACR updates.
//
//  Revision History
////////////////////////////////////////////////////////////////////////////////

//	Wynna - 2/2/2023

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
void ActionCreateWynCreature(string sCreature, location lLocCreature)
{
    CreateObject(OBJECT_TYPE_CREATURE, sCreature, lLocCreature, TRUE, "janni_owlbear");
}

#include "acr_spawn_i"


void main() {

	ActionCastSpellAtObject(SPELL_GREATER_INVISIBILITY, OBJECT_SELF, METAMAGIC_EXTEND, TRUE, 10, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
	ActionCastSpellAtObject(SPELL_ETHEREALNESS, OBJECT_SELF, METAMAGIC_EXTEND, TRUE, 10, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
	ExecuteScript("acf_cre_onspawnin_buffed", OBJECT_SELF);
	
	DelayCommand(6.0, ActionCreateWynCreature("003_cr_mb_owlbear_cub", GetLocation(OBJECT_SELF)));
	DelayCommand(10.0, AssignCommand(GetObjectByTag("003_cr_mb_owlbear_cub", 0), ActionForceFollowObject(OBJECT_SELF, 0.5)));
	 
		
	 
}