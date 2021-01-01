////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ACR Configuration File
//     Filename : acf_trg_onenter.nss
//    $Revision:: 236        $ current version of the file
//        $Date:: 2007-01-21#$ date the file was created or modified
//       Author : Cipher
//
//    Var Prefix:
//  Dependencies:
//
//  Description
//  This script calls the ACR's OnEnter code for triggers, and any
//  custom code a server may need. It is not updated in ACR updates.
//
//  Revision History
//  2007/01/20  Cipher  Inception
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#include "acr_trigger_i"
#include "acr_quest_i"
#include "acr_spawn_i"



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
    ACR_TriggerOnEnter();

    // Custom code goes here.
	object oEnterer = GetEnteringObject();
	object oMarp = GetObjectByTag("abr_cr_hu_marpenoth", 0);
	object oMinotaur = GetObjectByTag("flbtr_plc_minotaur_statue", 0);
	object oAmnestria = GetObjectByTag("003_cr_elf_sun_amnestria", 0);
	object oRobed = GetObjectByTag("003_cr_circus_magician", 0);
	object oWyvern = GetObjectByTag("abr_cr_dragon_wyvern_twisted_lg", 0);
	object oHalfOrcCleric = GetObjectByTag("003_cr_halforc_male", 0);
	object oCleric = GetObjectByTag("abr_cr_hu_orcclericheal", 0);
	object oClericTwo = GetObjectByTag("abr_cr_hu_orcclerichealTwo", 0);
	object oBattlePriest = GetObjectByTag("abr_cr_hu_orcbattlepriestOne", 0);
	object oBattlePriestTwo = GetObjectByTag("abr_cr_hu_orcbattlepriestTwo", 0);
	object oChieftain = GetObjectByTag("abr_cr_hu_orcchieftainOne", 0);
	object oBerserker = GetObjectByTag("abr_cr_hu_orcberserkerOne", 0);
	object oBerserkerTwo = GetObjectByTag("abr_cr_hu_orcberserkerTwo", 0);
	object oBerserkerThree = GetObjectByTag("abr_cr_hu_orcberserkerThree", 0);
	object oCaptain = GetObjectByTag("003_orc_captainOne", 0);
	object oCaptainTwo = GetObjectByTag("003_orc_captainTwo", 0);
	
	SendMessageToPC(oEnterer, "Entered");
	
	object oBuffer = oRobed;
	int nRep = 0;
	
	while (nRep < 9) {
	nRep = nRep +1;
	SendMessageToPC(oEnterer, IntToString(nRep) + " " + GetName(oBuffer));
	if(nRep == 2)
		{oBuffer = oHalfOrcCleric;}
	if(nRep == 3)
		{oBuffer = oCleric;}
	if(nRep == 4)
		{oBuffer = oClericTwo;}
	if(nRep == 5)
		{oBuffer = oBattlePriest;}
	if(nRep == 6)
		{oBuffer = oBattlePriestTwo;}
	if(nRep == 7)
		{oBuffer = oMarp;}
	if(nRep == 8)
		{oBuffer = oAmnestria;}
	
	
	
	
	int nEndure = GetHasSpell(SPELL_ENDURE_ELEMENTS, oBuffer);
	int nArrows = GetHasSpell(SPELL_PROTECTION_FROM_ARROWS, oBuffer);
	int nGlobeLess = GetHasSpell(SPELL_LESSER_GLOBE_OF_INVULNERABILITY, oBuffer);
	int nMirror = GetHasSpell(SPELL_MIRROR_IMAGE, oBuffer);
	int nMageArmor = GetHasSpell(SPELL_MAGE_ARMOR, oBuffer);
	int nStoneskin = GetHasSpell(SPELL_STONESKIN, oBuffer);
	int nBless = GetHasSpell(SPELL_BLESS, oBuffer);
	int nPrayer = GetHasSpell(SPELL_PRAYER, oBuffer);
	
	int nCleric = GetLevelByClass(CLASS_TYPE_CLERIC, oBuffer);
	int nBard = GetLevelByClass(CLASS_TYPE_BARD, oBuffer);
	int nDruid = GetLevelByClass(CLASS_TYPE_DRUID, oBuffer);
	int nPaladin = GetLevelByClass(CLASS_TYPE_PALADIN, oBuffer);
	int nRanger = GetLevelByClass(CLASS_TYPE_RANGER, oBuffer);
	int nDomainLevel;
	string sDomainLevel;
	string sDomainClass;
	
	if((nCleric > 0) && (nCleric >= nPaladin) && (nCleric >= nDruid) && (nCleric >= nRanger) && (nCleric >= nBard))
		{nDomainLevel = nCleric;
		sDomainLevel = IntToString(nDomainLevel);
		sDomainClass = "Cleric " + sDomainLevel;
		}
	else if((nPaladin  > 0) && (nPaladin >= nCleric) && (nPaladin >= nDruid) && (nPaladin >= nRanger) && (nPaladin >= nBard))
		{nDomainLevel = nPaladin;
		sDomainLevel = IntToString(nDomainLevel);
		sDomainClass = "Paladin " + sDomainLevel;
		}
	else if((nDruid  > 0) && (nDruid >= nCleric) && (nDruid >= nPaladin) && (nDruid >= nRanger) && (nDruid >= nBard))
		{nDomainLevel = nDruid;
		sDomainLevel = IntToString(nDomainLevel);
		sDomainClass = "Druid " + sDomainLevel;
		}
	else if((nBard  > 0) && (nBard >= nCleric) && (nBard >= nPaladin) && (nBard >= nRanger) && (nBard >= nDruid))
		{nDomainLevel = nBard;
		sDomainLevel = IntToString(nDomainLevel);
		sDomainClass = "Bard " + sDomainLevel;
		}
	else if((nRanger  > 0) && (nRanger >= nCleric) && (nRanger >= nPaladin) && (nRanger >= nBard) && (nRanger >= nDruid))
		{nDomainLevel = nRanger;
		sDomainLevel = IntToString(nDomainLevel);
		sDomainClass = "Ranger " + sDomainLevel;
		}
	
	if(((GetIsPC(oEnterer)) || (GetIsDMPossessed(oEnterer))) && (GetLocalInt(OBJECT_SELF, "PerceiveFired") != 1))
		{AssignCommand(oBuffer, ClearAllActions(TRUE));
		 AssignCommand(oBuffer, ActionSpeakString(GetName(oEnterer)));
		 SetLocalInt(OBJECT_SELF, "PerceiveFired", 1);
		 AssignCommand(oBuffer, ClearAllActions(TRUE));
		 if(GetTag(oBuffer) == "003_cr_circus_magician")
			 {
			 ActionCastSpellAtObject(SPELL_PROTECTION_FROM_ARROWS, oBuffer, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
			 DelayCommand(5.0, ClearAllActions(TRUE));
			 DelayCommand(6.0, ActionCastSpellAtObject(SPELL_PROTECTION_FROM_ARROWS, oMarp, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
			}
			
		 if(nCleric > 0){
		 	if(Random(3) == 1)
		 		{ActionCastSpellAtObject(SPELL_MAGIC_CIRCLE_AGAINST_GOOD, oBuffer, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
			 	}
			}
		
		if((nPrayer > 0) && (Random(3) == 1))
		 		{ActionCastSpellAtObject(SPELL_PRAYER, oBuffer, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
			 	}
		else if((nBless > 0) && (Random(3) == 1))
		 		{ActionCastSpellAtObject(SPELL_BLESS, oBuffer, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
			 	}
			
	
		if((Random(3) == 1) && (nStoneskin > 0))
		 	{ActionCastSpellAtObject(SPELL_STONESKIN, oBuffer, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
			 }
		else if((Random(3) == 1) && (nGlobeLess > 0))
		 	{ActionCastSpellAtObject(SPELL_LESSER_GLOBE_OF_INVULNERABILITY, oBuffer, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
			 }
		else if((Random(3) == 1) && (nMageArmor > 0))
		 	{ActionCastSpellAtObject(SPELL_MAGE_ARMOR, oBuffer, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
			 }
		else if((Random(3) == 1) && (nMirror > 0))
		 	{ActionCastSpellAtObject(SPELL_MIRROR_IMAGE, oBuffer, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
			 }
		
		}
		
	//DelayCommand(10.0, ChangeToStandardFaction(oBuffer, STANDARD_FACTION_HOSTILE));	 
	}
}