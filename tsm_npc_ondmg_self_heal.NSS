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

    object oArea = GetArea(OBJECT_SELF);
	object oAttacker = GetLastDamager(OBJECT_SELF);
	int nCurrentHP = GetCurrentHitPoints(OBJECT_SELF);
	int nMaxHP = GetMaxHitPoints(OBJECT_SELF);
	int nCLWMem = GetHasSpell(SPELL_CURE_LIGHT_WOUNDS, OBJECT_SELF);
	int nCMWMem = GetHasSpell(SPELL_CURE_MODERATE_WOUNDS, OBJECT_SELF);
	int nCSWMem = GetHasSpell(SPELL_CURE_SERIOUS_WOUNDS, OBJECT_SELF);
	int nCCWMem = GetHasSpell(SPELL_CURE_CRITICAL_WOUNDS, OBJECT_SELF);
	int nMCLWMem = GetHasSpell(SPELL_MASS_CURE_LIGHT_WOUNDS, OBJECT_SELF);
	int nMCMWMem = GetHasSpell(SPELL_MASS_CURE_MODERATE_WOUNDS, OBJECT_SELF);
	int nMCSWMem = GetHasSpell(SPELL_MASS_CURE_SERIOUS_WOUNDS, OBJECT_SELF);
	int nMCCWMem = GetHasSpell(SPELL_MASS_CURE_CRITICAL_WOUNDS, OBJECT_SELF);
	
	 	
	object oCLWS = GetItemPossessedBy(OBJECT_SELF, "abr_scroll_1_clw");
	object oCMWS = GetItemPossessedBy(OBJECT_SELF, "abr_scroll_2_cmw");
	object oCSWS = GetItemPossessedBy(OBJECT_SELF, "abr_scroll_3_csw");
	object oCCWS = GetItemPossessedBy(OBJECT_SELF, "abr_scroll_4_ccw");
	
	object oMCLWS = GetItemPossessedBy(OBJECT_SELF, "abr_scroll_5_curelightmass");
	object oMCMWS = GetItemPossessedBy(OBJECT_SELF, "abr_scroll_6_curemodemass");
	object oMCSWS = GetItemPossessedBy(OBJECT_SELF, "abr_scroll_7_cureseriousmass");
	object oMCCWS = GetItemPossessedBy(OBJECT_SELF, "abr_scroll_8_curecritmass");
	
	object oCLW = GetItemPossessedBy(OBJECT_SELF, "abr_it_mpotion01");
	object oCMW = GetItemPossessedBy(OBJECT_SELF, "abr_it_mpotion02");
	object oCSW = GetItemPossessedBy(OBJECT_SELF, "abr_it_mpotion03");
	object oCCW = GetItemPossessedBy(OBJECT_SELF, "abr_it_mpotion04");
	
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
	
	int nCLWHeal = Random(8) + nDomainLevel;
	effect eCLW = EffectHeal(nCLWHeal);
	int nCMWHeal = Random(8) + Random(8) + nDomainLevel;
	effect eCMW = EffectHeal(nCMWHeal);
	int nCSWHeal = Random(8) + Random(8) + Random(8) + nDomainLevel;
	effect eCSW = EffectHeal(nCSWHeal);
	int nCCWHeal = Random(8) + Random(8) + Random(8) + Random(8) + nDomainLevel;
	effect eCCW = EffectHeal(nCCWHeal);
	effect eCLWFX = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);

		
	float fRange = 25.0 + 5.0*(IntToFloat(nDomainLevel/2));
	int nTargets = nDomainLevel;
	
	object oNearestPatient = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC, OBJECT_SELF, 1); 
	object oPatientCircle = GetFirstObjectInShape(SHAPE_SPHERE, fRange,GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);	
	int nLoop = 1;

	if(((nCurrentHP < nMaxHP/2) && (Random(4) == 1)) || ((nCurrentHP < nMaxHP/3) && (Random(3) == 1)) || ((nCurrentHP < nMaxHP/4) )) 
		{ if(nCLWMem > 0)
				{ActionCastSpellAtObject(SPELL_CURE_LIGHT_WOUNDS, OBJECT_SELF, METAMAGIC_ANY, FALSE, nDomainLevel,PROJECTILE_PATH_TYPE_DEFAULT, FALSE);
				 ActionSpeakString("Casts a spell.", TALKVOLUME_TALK);
				 }
		  else if(oCLW != OBJECT_INVALID)
		  		{ActionSpeakString("Drinks a potion", TALKVOLUME_TALK);
				 ApplyEffectToObject(DURATION_TYPE_INSTANT, eCLW, OBJECT_SELF); 
				 ApplyEffectToObject(DURATION_TYPE_INSTANT, eCLWFX, OBJECT_SELF); 
				 DelayCommand(1.0, AssignCommand(OBJECT_SELF, ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK, 1.0, 2.0)));
				 DestroyObject(oCLW, 0.0, TRUE);
				 }
		  else if(oCLWS != OBJECT_INVALID)
		  		{ActionSpeakString("Uses a scroll", TALKVOLUME_TALK);
				 ApplyEffectToObject(DURATION_TYPE_INSTANT, eCLW, OBJECT_SELF); 
				 ApplyEffectToObject(DURATION_TYPE_INSTANT, eCLWFX, OBJECT_SELF); 
				 DelayCommand(1.0, AssignCommand(OBJECT_SELF, ActionPlayAnimation(ANIMATION_FIREFORGET_READ, 1.0, 2.0)));
				 DestroyObject(oCLWS, 0.0, TRUE);
				 }
		  else if(nMCLWMem > 0)
				{ActionSpeakString("Casts a spell.", TALKVOLUME_TALK);
				 ActionCastSpellAtObject(SPELL_MASS_CURE_LIGHT_WOUNDS, OBJECT_SELF, METAMAGIC_ANY, FALSE, nDomainLevel,PROJECTILE_PATH_TYPE_DEFAULT, FALSE);
				 }
		  else if(oMCLWS != OBJECT_INVALID)
		  		{ActionSpeakString("Uses a scroll", TALKVOLUME_TALK);
				 ActionCastSpellAtObject(SPELL_MASS_CURE_LIGHT_WOUNDS, OBJECT_SELF, METAMAGIC_ANY, FALSE, nDomainLevel,PROJECTILE_PATH_TYPE_DEFAULT, FALSE);
				 DelayCommand(1.0, AssignCommand(OBJECT_SELF, ActionPlayAnimation(ANIMATION_FIREFORGET_READ, 1.0, 2.0)));
				 DestroyObject(oMCLWS, 0.0, TRUE);
				 }
		 else if(nCMWMem > 0)
				{ActionCastSpellAtObject(SPELL_CURE_MODERATE_WOUNDS, OBJECT_SELF, METAMAGIC_ANY, FALSE, nDomainLevel,PROJECTILE_PATH_TYPE_DEFAULT, FALSE);
				 ActionSpeakString("Casts a spell.", TALKVOLUME_TALK);
				 }
		  else if(oCMW != OBJECT_INVALID)
		  		{ActionSpeakString("Drinks a potion", TALKVOLUME_TALK);
				 ApplyEffectToObject(DURATION_TYPE_INSTANT, eCMW, OBJECT_SELF); 
				 ApplyEffectToObject(DURATION_TYPE_INSTANT, eCLWFX, OBJECT_SELF); 
				 DelayCommand(1.0, AssignCommand(OBJECT_SELF, ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK, 1.0, 2.0)));
				 DestroyObject(oCMW, 0.0, TRUE);
				 }
		  else if(oCMWS != OBJECT_INVALID)
		  		{ActionSpeakString("Uses a scroll", TALKVOLUME_TALK);
				 ApplyEffectToObject(DURATION_TYPE_INSTANT, eCMW, OBJECT_SELF); 
				 ApplyEffectToObject(DURATION_TYPE_INSTANT, eCLWFX, OBJECT_SELF); 
				 DelayCommand(1.0, AssignCommand(OBJECT_SELF, ActionPlayAnimation(ANIMATION_FIREFORGET_READ, 1.0, 2.0)));
				 DestroyObject(oCMWS, 0.0, TRUE);
				 }
		  else if(nMCMWMem > 0)
				{ActionCastSpellAtObject(SPELL_MASS_CURE_MODERATE_WOUNDS, OBJECT_SELF, METAMAGIC_ANY, FALSE, nDomainLevel,PROJECTILE_PATH_TYPE_DEFAULT, FALSE);
				 ActionSpeakString("Casts a spell.", TALKVOLUME_TALK);
				 }
		  else if(oMCMWS != OBJECT_INVALID)
		  		{ActionSpeakString("Uses a scroll", TALKVOLUME_TALK);
				 ActionCastSpellAtObject(SPELL_MASS_CURE_MODERATE_WOUNDS, OBJECT_SELF, METAMAGIC_ANY, FALSE, nDomainLevel,PROJECTILE_PATH_TYPE_DEFAULT, FALSE);
				 DelayCommand(1.0, AssignCommand(OBJECT_SELF, ActionPlayAnimation(ANIMATION_FIREFORGET_READ, 1.0, 2.0)));
				 DestroyObject(oMCMWS, 0.0, TRUE);
				 }
		 
		  else if(nCSWMem > 0)
				{ActionCastSpellAtObject(SPELL_CURE_SERIOUS_WOUNDS, OBJECT_SELF, METAMAGIC_ANY, FALSE, nDomainLevel,PROJECTILE_PATH_TYPE_DEFAULT, FALSE);
				 ActionSpeakString("Casts a spell.", TALKVOLUME_TALK);
				 }
		  else if(oCSW != OBJECT_INVALID)
		  		{ActionSpeakString("Drinks a potion", TALKVOLUME_TALK);
				 ApplyEffectToObject(DURATION_TYPE_INSTANT, eCSW, OBJECT_SELF); 
				 ApplyEffectToObject(DURATION_TYPE_INSTANT, eCLWFX, OBJECT_SELF); 
				 DelayCommand(1.0, AssignCommand(OBJECT_SELF, ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK, 1.0, 2.0)));
				 DestroyObject(oCSW, 0.0, TRUE);
				 }
		  else if(oCSWS != OBJECT_INVALID)
		  		{ActionSpeakString("Uses a scroll", TALKVOLUME_TALK);
				 ApplyEffectToObject(DURATION_TYPE_INSTANT, eCSW, OBJECT_SELF); 
				 ApplyEffectToObject(DURATION_TYPE_INSTANT, eCLWFX, OBJECT_SELF); 
				 DelayCommand(1.0, AssignCommand(OBJECT_SELF, ActionPlayAnimation(ANIMATION_FIREFORGET_READ, 1.0, 2.0)));
				 DestroyObject(oCSWS, 0.0, TRUE);
				 }
		  else if(nMCSWMem > 0)
				{ActionCastSpellAtObject(SPELL_MASS_CURE_SERIOUS_WOUNDS, OBJECT_SELF, METAMAGIC_ANY, FALSE, nDomainLevel,PROJECTILE_PATH_TYPE_DEFAULT, FALSE);
				 ActionSpeakString("Casts a spell.", TALKVOLUME_TALK);
				 }
		  else if(oMCSWS != OBJECT_INVALID)
		  		{ActionSpeakString("Uses a scroll", TALKVOLUME_TALK);
				 ActionCastSpellAtObject(SPELL_MASS_CURE_SERIOUS_WOUNDS, OBJECT_SELF, METAMAGIC_ANY, FALSE, nDomainLevel,PROJECTILE_PATH_TYPE_DEFAULT, FALSE);
				 DelayCommand(1.0, AssignCommand(OBJECT_SELF, ActionPlayAnimation(ANIMATION_FIREFORGET_READ, 1.0, 2.0)));
				 DestroyObject(oMCSWS, 0.0, TRUE);
				 }
		 
		  else if(nCCWMem > 0)
				{ActionCastSpellAtObject(SPELL_CURE_CRITICAL_WOUNDS, OBJECT_SELF, METAMAGIC_ANY, FALSE, nDomainLevel,PROJECTILE_PATH_TYPE_DEFAULT, FALSE);
				 ActionSpeakString("Casts a spell.", TALKVOLUME_TALK);
				 }
		  else if(oCCW != OBJECT_INVALID)
		  		{ActionSpeakString("Drinks a potion", TALKVOLUME_TALK);
				 ApplyEffectToObject(DURATION_TYPE_INSTANT, eCCW, OBJECT_SELF); 
				 ApplyEffectToObject(DURATION_TYPE_INSTANT, eCLWFX, OBJECT_SELF); 
				 DelayCommand(1.0, AssignCommand(OBJECT_SELF, ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK, 1.0, 2.0)));
				 DestroyObject(oCCW, 0.0, TRUE);
				 }
		  else if(oCCWS != OBJECT_INVALID)
		  		{ActionSpeakString("Uses a scroll", TALKVOLUME_TALK);
				 ApplyEffectToObject(DURATION_TYPE_INSTANT, eCCW, OBJECT_SELF); 
				 ApplyEffectToObject(DURATION_TYPE_INSTANT, eCLWFX, OBJECT_SELF); 
				 DelayCommand(1.0, AssignCommand(OBJECT_SELF, ActionPlayAnimation(ANIMATION_FIREFORGET_READ, 1.0, 2.0)));
				 DestroyObject(oCCWS, 0.0, TRUE);
				 }
		  else if(nMCCWMem > 0)
				{ActionCastSpellAtObject(SPELL_MASS_CURE_CRITICAL_WOUNDS, OBJECT_SELF, METAMAGIC_ANY, FALSE, nDomainLevel,PROJECTILE_PATH_TYPE_DEFAULT, FALSE);
				 ActionSpeakString("Casts a spell.", TALKVOLUME_TALK);
				 }
		  else if(oMCCWS != OBJECT_INVALID)
		  		{ActionSpeakString("Uses a scroll", TALKVOLUME_TALK);
				 ActionCastSpellAtObject(SPELL_MASS_CURE_CRITICAL_WOUNDS, OBJECT_SELF, METAMAGIC_ANY, FALSE, nDomainLevel,PROJECTILE_PATH_TYPE_DEFAULT, FALSE);
				 DelayCommand(1.0, AssignCommand(OBJECT_SELF, ActionPlayAnimation(ANIMATION_FIREFORGET_READ, 1.0, 2.0)));
				 DestroyObject(oMCCWS, 0.0, TRUE);
				 }
		 
			}
	
		 ExecuteScript("acf_cre_ondamaged", OBJECT_SELF);
	
}