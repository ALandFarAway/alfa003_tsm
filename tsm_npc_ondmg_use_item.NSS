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

    object oAttacker = GetLastDamager(OBJECT_SELF);
	int nCurrentHP = GetCurrentHitPoints(OBJECT_SELF);
	int nMaxHP = GetMaxHitPoints(OBJECT_SELF);
	int nCLWMem = GetHasSpell(SPELL_CURE_LIGHT_WOUNDS, OBJECT_SELF);
	int nCMWMem = GetHasSpell(SPELL_CURE_MODERATE_WOUNDS, OBJECT_SELF);
	int nCLWRemaining = GetLocalInt(OBJECT_SELF, "CLWRemaining");
	
    if(GetLocalInt(OBJECT_SELF, "CLWSpellsInit") == 0)
		{SetLocalInt(OBJECT_SELF, "CLWSpellsInit", 1);
		 nCLWRemaining = nCLWMem;
		 SetLocalInt(OBJECT_SELF, "CLWRemaining", nCLWRemaining);
		 ActionSpeakString("Init CLW", TALKVOLUME_TALK);
		 ActionSpeakString("CLWMem =" + IntToString(nCLWMem), TALKVOLUME_TALK);
		 ActionSpeakString("CLWRemaining =" + IntToString(GetLocalInt(OBJECT_SELF, "CLWRemaining")), TALKVOLUME_TALK);
		 }
		
	object oCLW = GetItemPossessedBy(OBJECT_SELF, "abr_it_mpotion01");
	object oCMW = GetItemPossessedBy(OBJECT_SELF, "abr_it_mpotion02");
	effect eCLW = EffectHeal(Random(8));
	int nCleric = GetLevelByClass(CLASS_TYPE_CLERIC, OBJECT_SELF);
	int nBard = GetLevelByClass(CLASS_TYPE_BARD, OBJECT_SELF);
	int nDruid = GetLevelByClass(CLASS_TYPE_DRUID, OBJECT_SELF);
	int nPaladin = GetLevelByClass(CLASS_TYPE_PALADIN, OBJECT_SELF);
	int nRanger = GetLevelByClass(CLASS_TYPE_RANGER, OBJECT_SELF);
	int nDomainLevel;
	if((nCleric > 0) && (nCleric >= nPaladin) && (nCleric >= nDruid) && (nCleric >= nRanger) && (nCleric >= nBard))
		{nDomainLevel = nCleric;}
	else if((nPaladin  > 0) && (nPaladin >= nCleric) && (nPaladin >= nDruid) && (nPaladin >= nRanger) && (nPaladin >= nBard))
		{nDomainLevel = nPaladin;}
	else if((nDruid  > 0) && (nDruid >= nCleric) && (nDruid >= nPaladin) && (nDruid >= nRanger) && (nDruid >= nBard))
		{nDomainLevel = nDruid;}
	else if((nBard  > 0) && (nBard >= nCleric) && (nBard >= nPaladin) && (nBard >= nRanger) && (nBard >= nDruid))
		{nDomainLevel = nBard;}
	else if((nRanger  > 0) && (nRanger >= nCleric) && (nRanger >= nPaladin) && (nRanger >= nBard) && (nRanger >= nDruid))
		{nDomainLevel = nRanger;}
	
	
	if(nCurrentHP < nMaxHP/2)
		{ if(nCLWRemaining > 0)
				{ActionCastSpellAtObject(SPELL_CURE_LIGHT_WOUNDS, OBJECT_SELF, METAMAGIC_ANY, FALSE, nDomainLevel,PROJECTILE_PATH_TYPE_DEFAULT, FALSE);
				 ActionSpeakString("Casts Cure Light Wounds " + IntToString(nCLWMem) + " Memorized/" + IntToString(nCLWRemaining) + " Remaining", TALKVOLUME_TALK);
				 SetLocalInt(OBJECT_SELF, "CLW_Remaining", nCLWRemaining - 1);
				 }
		  else if(oCLW != OBJECT_INVALID)
		  		{EventActivateItem(oCLW, GetLocation(OBJECT_SELF), OBJECT_SELF);
 				 ActionSpeakString("Drinks a Cure Light Wounds Potion", TALKVOLUME_TALK);
				 DestroyObject(oCLW, 0.0, TRUE);
				 ApplyEffectToObject(DURATION_TYPE_INSTANT, eCLW, OBJECT_SELF); 
				 ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK, 1.0, 1.0);
				 }
		  else if(nCMWMem > 0)
				{ActionCastSpellAtObject(SPELL_CURE_MODERATE_WOUNDS, OBJECT_SELF, METAMAGIC_ANY, FALSE, nDomainLevel,PROJECTILE_PATH_TYPE_DEFAULT, FALSE);
				 ActionSpeakString("Casts Cure Moderate Wounds", TALKVOLUME_TALK);
				}
		 else if(oCMW != OBJECT_INVALID)
		  		{EventActivateItem(oCMW, GetLocation(OBJECT_SELF), OBJECT_SELF);
				 ActionSpeakString("Drinks a Cure Moderate Wounds Potion", TALKVOLUME_TALK);
				}
		  
			}
	
		 
	
}