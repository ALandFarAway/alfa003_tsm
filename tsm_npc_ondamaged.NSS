////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ACR Configuration File
//     Filename : acf_cre_ondamaged
//    $Revision:: 280        $ current version of the file
//        $Date:: 2007-03-20#$ date the file was created or modified
//       Author : Cipher
//
//    Var Prefix:
//  Dependencies:
//
//  Description
//  This script calls the ACR's OnDamaged event handler for creatures and
//  any custom code a server may need. It is not updated in ACR updates.
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
    ACR_CreatureOnDamaged();
	
	//Fossilizing treants spill parasitic moths
	
		if(GetTag(OBJECT_SELF) == "abr_cr_pla_treant_uncryst")
		{object oMothOne = CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_mb_deathmoth", GetLocation(OBJECT_SELF));
		 if(Random(2)==1) {object oMothTwo = CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_mb_deathmoth", GetLocation(OBJECT_SELF));}
		 if(Random(2)==1) {object oMothThree = CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_mb_deathmoth", GetLocation(OBJECT_SELF));}
		 if(Random(2)==1) {object oMothFour = CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_mb_deathmoth", GetLocation(OBJECT_SELF));}
		 if(Random(2)==1) {object oMothFive = CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_mb_deathmoth", GetLocation(OBJECT_SELF));}
		 if(Random(2)==1) {object oMothSix = CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_mb_deathmoth", GetLocation(OBJECT_SELF));}
		 DelayCommand(3.0, AssignCommand(oMothOne, ActionSpeakString("Death moths flutter out of the petrifying hive.", TALKVOLUME_TALK)));
		 effect eImplode = EffectVisualEffect(VFX_FNF_IMPLOSION, FALSE);
		 DelayCommand(2.0, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eImplode, GetLocation(OBJECT_SELF)));
		 DelayCommand(4.0, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eImplode, GetLocation(oMothOne)));
		 }	
	
	//Drowned monsters regenerate speakstring
	
		if((GetTag(OBJECT_SELF) == "abr_cr_un_drowned_dwarf") || (GetTag(OBJECT_SELF) == "abr_cr_un_drowned_elf") || (GetTag(OBJECT_SELF) == "abr_cr_un_drowned_human") ) {
			if(Random(3)==1)
				{ActionSpeakString("Sucks in water, healing itself a small amount", TALKVOLUME_TALK);}
		
		}
	
	
    //KiS Static combat_03
		 
		if(GetTag(OBJECT_SELF) == "003_cr_kis_atarms_parade") 
			{object oSubdue = GetLocalObject(OBJECT_SELF, "oSubdue");
			 if(oSubdue == OBJECT_INVALID)
			 	{oSubdue = GetLastAttacker();
				SetLocalObject(OBJECT_SELF, "oSubdue", oSubdue);
				}
			if(_GetNLDMode(OBJECT_SELF) == FALSE)
			 	{ACR_ToggleNLDMode(OBJECT_SELF);
				 }
			 if((_GetNLDState(oSubdue) != 2) && (GetLocalInt(oSubdue, "kis_combat_03_win") < 5) && (GetLocalInt(OBJECT_SELF, "Subdued") != 1))
				  	{ActionMoveToObject(oSubdue, TRUE, 1.0);
					 ActionAttack(oSubdue, FALSE);
					 }
			else if(_GetNLDState(OBJECT_SELF) != 0)
			 	{SetLocalInt(OBJECT_SELF, "Subdued", 1);
				 ActionSpeakString("I yield!", TALKVOLUME_TALK);
				 SetLocalInt(oSubdue, "kis_combat_03_win", GetLocalInt(oSubdue, "kis_combat_03_win") +1);
				}
			 }
			 
		if(((FindSubString(GetTag(OBJECT_SELF), "deneir") != -1) || (FindSubString(GetTag(OBJECT_SELF), "vos_scribe") != -1)) && (GetIsEnemy(GetLastDamager())) && (GetIsPC(GetLastDamager()))) 
			{effect eKnockdown = EffectKnockdown();
			 ChangeToStandardFaction(OBJECT_SELF, STANDARD_FACTION_COMMONER);
			 ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnockdown, OBJECT_SELF, 600.0);
			 }
}