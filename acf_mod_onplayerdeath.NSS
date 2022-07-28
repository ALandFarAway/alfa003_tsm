////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ALFA Configuration File
//     Filename : acf_mod_onplayerdeath.nss
//    $Revision:: 197        $ current version of the file
//        $Date:: 2006-12-23#$ date the file was created or modified
//       Author : Ronan
//
//  Local Variable Prefix = None
//
//  Description
//  This script calls the module's OnPlayerDeath event, and any custom code added
//  by this server. It is usually used to set up server-specific options.
//  This file should NOT be overwriten in ACR updates so as to preserve any of
//  the server's customized code they may have added.
//
//  Revision History
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

#include "acr_mod_events_i"

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

void main() {
    ACR_ModuleOnPlayerDeath();
	object oDied = GetLastPlayerDied();

	if((FindSubString(GetName(oDied), "Bae") != -1) && (GetLocalInt(OBJECT_SELF, "BaeDeath") == 0)){
		SetLocalInt(OBJECT_SELF, "BaeDeath", 1);
		object oSilverwing = GetObjectByTag("003_cr_dragon_silver_dez", 0);
		object oSilverwingWP = GetWaypointByTag("dqspx_arena_WP");
		location lSafety = GetLocation(oSilverwingWP);
		location lDeath = GetLocation(oDied);
    	object oBae = CreateObject(OBJECT_TYPE_CREATURE, "003_pc_baeithra_2", lDeath);
		SetImmortal(oBae, TRUE);
		effect eVFX   = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);
		effect eGhost = EffectCutsceneGhost();
		AssignCommand(oSilverwing, ClearAllActions(TRUE));
		AssignCommand(oSilverwing, ActionSpeakString("*Whips around as Bae'ithra falls...and ROARS!", TALKVOLUME_TALK));
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVFX, oDied, 1800.0);
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGhost, oDied, 1800.0);
		DelayCommand(10.0, AssignCommand(oDied, ActionJumpToLocation(lSafety)));
		AssignCommand(oBae, ClearAllActions(TRUE));
		AssignCommand(oBae, ActionSpeakString("*Screams in sudden pain and staggers, clawing at his back", TALKVOLUME_TALK));
		DelayCommand(10.0, AssignCommand(oBae, ClearAllActions(TRUE)));
		DelayCommand(10.0, AssignCommand(oBae, ActionSpeakString("*Goes down, then pushes himself back up to his feet, fighting on", TALKVOLUME_TALK)));
		DelayCommand(20.0, AssignCommand(oDied, ActionJumpToLocation(lSafety)));
		DelayCommand(20.0, AssignCommand(oBae, ClearAllActions(TRUE)));
		DelayCommand(20.0, AssignCommand(oBae, ActionSpeakString("*Goes to his knees, buckling backwards, arms outspread beneath the sky", TALKVOLUME_TALK)));
		DelayCommand(20.0, AssignCommand(oBae, ActionSpeakString("I am ready, my kin! *Cries out", TALKVOLUME_TALK)));
		DelayCommand(30.0, AssignCommand(oSilverwing, ActionSpeakString("*Now! Now I see hope for her salvation!", TALKVOLUME_TALK)));
		DelayCommand(30.0, AssignCommand(oSilverwing, ActionCastSpellAtObject(SPELL_SUPERIOR_RESISTANCE, oBae, METAMAGIC_EXTEND, TRUE, 10, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
		effect ePoly = EffectPolymorph(POLYMORPH_TYPE_WYRMLING_WHITE, FALSE, FALSE);
		DelayCommand(35.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePoly, oBae, 1800.0));
		}	
	
	if(GetIsPC(GetLastPlayerDied()))
		{SendMessageToAllDMs("!!!ONDEATH FOR " + GetName(GetLastPlayerDied()) + " FIRING!!!");}

}