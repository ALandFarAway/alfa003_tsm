////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ACR Configuration File
//     Filename : acf_cre_onperception
//    $Revision:: 280        $ current version of the file
//        $Date:: 2007-03-20#$ date the file was created or modified
//       Author : Cipher
//
//    Var Prefix:
//  Dependencies:
//
//  Description
//  This script calls the ACR's OnPerception event handler for creatures
//  and any custom code a server may need. It is not updated in ACR updates.
//
//  Revision History
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#include "acr_creature_i"

////////////////////////////////////////////////////////////////////////////////
// Constants ///////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Structures //////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Global Variables ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Function Prototypes /////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Function Definitions ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

void main()
{
    ACR_CreatureOnPerception();

    object oPerceived = GetLastPerceived();
	object oPhaedra = GetObjectByTag("003_cr_bane_bp_elthonds", 0);
	effect eFreeze = EffectCutsceneImmobilize();
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFreeze, OBJECT_SELF, 8.0);
	
	if(GetTag(OBJECT_SELF) == "003_cr_slv_gyasisayen") {
		if((GetLocalInt(OBJECT_SELF, "Spoken") == 0) && (FindSubString(GetTag(oPerceived), "efreet", 0) != -1)) 
			{SetLocalInt(OBJECT_SELF, "Spoken", 1);
			 ClearAllActions(TRUE);
			 DelayCommand(3.0, ActionSpeakString("I am the Scion! The Diadem has passed from my house to me, and hence to Electra! Be DISMISSED.", TALKVOLUME_TALK));
			 DelayCommand(4.0, ActionCastSpellAtObject(SPELL_DISMISSAL, oPerceived, METAMAGIC_NONE, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
			 DelayCommand(9.0, ClearAllActions(TRUE));
			 DelayCommand(10.0, ActionSpeakString("*Screams in rage when his Dismissal fails.", TALKVOLUME_TALK));
			 DelayCommand(16.0, ActionCastSpellAtObject(SPELL_WALL_DISPEL_MAGIC, oPerceived, METAMAGIC_NONE, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
			 }
	}
	
	if(GetTag(OBJECT_SELF) == "abr_cr_ou_efreet_lord") {
		if((GetLocalInt(OBJECT_SELF, "Spoken") == 0) && (FindSubString(GetTag(oPerceived), "sayen", 0) != -1)) 
			{SetLocalInt(OBJECT_SELF, "Spoken", 1);
			 ClearAllActions(TRUE);
			 DelayCommand(8.0, ActionSpeakString("Infidel! You and your electrum child violate the honor of House Sayen!", TALKVOLUME_TALK));
			 DelayCommand(10.0, ActionCastSpellAtObject(SPELL_DISINTEGRATE, oPerceived, METAMAGIC_NONE, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
			 DelayCommand(13.0, ClearAllActions(TRUE));
			 DelayCommand(14.0,ActionCastSpellAtObject(SPELL_WALL_OF_FIRE, oPerceived, METAMAGIC_NONE, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
			 DelayCommand(19.0, ClearAllActions(TRUE));
			 DelayCommand(20.0, ActionCastSpellAtObject(SPELL_DISINTEGRATE, oPerceived, METAMAGIC_NONE, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
			 DelayCommand(29.0, ClearAllActions(TRUE));
			 DelayCommand(30.0, ActionCastSpellAtObject(SPELL_FIREBALL, oPhaedra, METAMAGIC_NONE, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
			 }
	}
 
		    
}