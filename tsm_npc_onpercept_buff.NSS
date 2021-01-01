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
#include "acr_quest_i"

void main()
{
    object oPerceived = GetLastPerceived();
	object oMarp = GetObjectByTag("abr_cr_hu_marpenoth", 0);
	object oMinotaur = GetObjectByTag("flbtr_plc_minotaur_statue", 0);
	object oAmnestria = GetObjectByTag("003_cr_elf_sun_amnestria", 0);
	int nEndure = GetHasSpell(SPELL_ENDURE_ELEMENTS, OBJECT_SELF);
	int nArrows = GetHasSpell(SPELL_PROTECTION_FROM_ARROWS, OBJECT_SELF);
	int nGlobeLess = GetHasSpell(SPELL_LESSER_GLOBE_OF_INVULNERABILITY, OBJECT_SELF);
	int nMirror = GetHasSpell(SPELL_MIRROR_IMAGE, OBJECT_SELF);
	int nMageArmor = GetHasSpell(SPELL_MAGE_ARMOR, OBJECT_SELF);
	int nStoneskin = GetHasSpell(SPELL_STONESKIN, OBJECT_SELF);
	int nBless = GetHasSpell(SPELL_BLESS, OBJECT_SELF);
	int nPrayer = GetHasSpell(SPELL_PRAYER, OBJECT_SELF);
	
	int nCleric = GetLevelByClass(CLASS_TYPE_CLERIC, OBJECT_SELF);
	int nBard = GetLevelByClass(CLASS_TYPE_BARD, OBJECT_SELF);
	int nDruid = GetLevelByClass(CLASS_TYPE_DRUID, OBJECT_SELF);
	int nPaladin = GetLevelByClass(CLASS_TYPE_PALADIN, OBJECT_SELF);
	int nRanger = GetLevelByClass(CLASS_TYPE_RANGER, OBJECT_SELF);
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
	
	if(((GetIsPC(oPerceived)) || (GetIsDMPossessed(oPerceived))) && (GetLocalInt(OBJECT_SELF, "PerceiveFired") != 1))
		{ActionSpeakString(GetName(oPerceived));
		 SetLocalInt(OBJECT_SELF, "PerceiveFired", 1);
		 ClearAllActions(TRUE);
		 if(GetTag(OBJECT_SELF) == "003_cr_circus_magician")
			 {
			 ActionCastSpellAtObject(SPELL_PROTECTION_FROM_ARROWS, OBJECT_SELF, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
			 DelayCommand(5.0, ClearAllActions(TRUE));
			 DelayCommand(6.0, ActionCastSpellAtObject(SPELL_PROTECTION_FROM_ARROWS, oMarp, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
			}
			
		 if(nCleric > 0){
		 	if(Random(3) == 1)
		 		{ActionCastSpellAtObject(SPELL_MAGIC_CIRCLE_AGAINST_GOOD, OBJECT_SELF, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
			 	}
			}
		
		if((nPrayer > 0) && (Random(3) == 1))
		 		{ActionCastSpellAtObject(SPELL_PRAYER, OBJECT_SELF, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
			 	}
		else if((nBless > 0) && (Random(3) == 1))
		 		{ActionCastSpellAtObject(SPELL_BLESS, OBJECT_SELF, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
			 	}
			
	
		if((Random(3) == 1) && (nStoneskin > 0))
		 	{ActionCastSpellAtObject(SPELL_STONESKIN, OBJECT_SELF, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
			 }
		else if((Random(3) == 1) && (nGlobeLess > 0))
		 	{ActionCastSpellAtObject(SPELL_LESSER_GLOBE_OF_INVULNERABILITY, OBJECT_SELF, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
			 }
		else if((Random(3) == 1) && (nMageArmor > 0))
		 	{ActionCastSpellAtObject(SPELL_MAGE_ARMOR, OBJECT_SELF, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
			 }
		else if((Random(3) == 1) && (nMirror > 0))
		 	{ActionCastSpellAtObject(SPELL_MIRROR_IMAGE, OBJECT_SELF, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
			 }
		
		}
		
	DelayCommand(10.0, ChangeToStandardFaction(OBJECT_SELF, STANDARD_FACTION_HOSTILE));	 
	
}