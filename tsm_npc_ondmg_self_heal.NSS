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
	int nUndead = GetRacialType(OBJECT_SELF);
	object oOrb = GetObjectByTag("phalorm_orb_black", 0);
	object oGlobe = GetObjectByTag("phalorm_globe_black", 0);
	object oPC = GetFirstPC(TRUE);
	object oJhessi = GetObjectByTag("003_pc_jhessi_2", 0);
	object oNio = GetObjectByTag("003_pc_nioniel_2", 0);;
	object oSaerela = GetObjectByTag("003_pc_saerela_2", 0);
	object oBertilak = GetObjectByTag("003_pc_bertilak_2", 0);
	object oBellie = GetObjectByTag("003_pc_bellie_2", 0);
	object oBae = GetObjectByTag("003_pc_baeithra_2", 0);
	object oAsh = GetObjectByTag("003_pc_asheeleaf_2", 0);
	while(oPC != OBJECT_INVALID) {
		string sPCName = GetName(oPC);
		if(FindSubString(sPCName, "Jhessi") != -1) {
			oJhessi = oPC;
		}
		if(FindSubString(sPCName, "Nio") != -1) {
			oNio = oPC;
		}
		if(FindSubString(sPCName, "Saerel") != -1) {
			oSaerela = oPC;
		}
		if(FindSubString(sPCName, "Bert") != -1) {
			oBertilak = oPC;
		}
		if(FindSubString(sPCName, "Bell") != -1) {
			oBellie = oPC;
		}
		if(FindSubString(sPCName, "Bae") != -1) {
			oBae = oPC;
		}
		if(FindSubString(sPCName, "Ash") != -1) {
			oAsh = oPC;
		}
	oPC = GetNextPC(TRUE);
	}

	object oRelayblackA = GetObjectByTag("rauvin_crystal_relay_black_a", 0);
	object oRelayblackB = GetObjectByTag("rauvin_crystal_relay_black_b", 0);
	object oRelayblackC = GetObjectByTag("rauvin_crystal_relay_black_c", 0);
	object oRelayblackD = GetObjectByTag("rauvin_crystal_relay_black_d", 0);
	object oRelay = oRelayblackA;
	int nRand = Random(4);
	if(nRand == 3) {
		oRelay = oRelayblackD;
	}
	if(nRand == 2) {
		oRelay = oRelayblackC;
	}
	if(nRand == 1) {
		oRelay = oRelayblackB;
	}
		
	SendMessageToAllDMs("Damage firing. " + GetName(OBJECT_SELF) + " hp is " + IntToString(nCurrentHP));
				 
	if(GetTag(OBJECT_SELF) == "abr_cr_ou_efreet_lord") {
		if(nCurrentHP < nMaxHP/2)
				{int nDimD = GetHasSpell(3026, OBJECT_SELF);
				 if (nDimD) {SendMessageToAllDMs("Efreet damage firing. Jumping to " + GetTag(oRelay));
						 DecrementRemainingSpellUses(OBJECT_SELF, 3026);
						 ClearAllActions(TRUE);
						 ActionCastSpellAtObject(3026, OBJECT_SELF, METAMAGIC_NONE, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
					 	 DelayCommand(1.5, ClearAllActions(TRUE));
						 DelayCommand(2.0, ActionJumpToLocation(GetLocation(oRelay)));
						 DelayCommand(3.0, ActionSpeakString("Disappears and reappears in another location.", TALKVOLUME_TALK));
						 }
				}
	return;
	}
	
	if(nUndead = RACIAL_TYPE_UNDEAD) {
		if(((nCurrentHP < nMaxHP/2) && (Random(4) == 1)) || ((nCurrentHP < nMaxHP/3) && (Random(3) == 1)) || ((nCurrentHP < nMaxHP/4) )) 
				{int nHealL = d8(1) +10;
				 int nHealM = d8(2) +10;
				 int nHealS = d8(3) +10;
				 int nHealC = d8(4) +10;
				 effect eHeal = EffectHeal(nHealL);
				 effect eHealVis = EffectVisualEffect(VFX_HIT_SPELL_INFLICT_4, FALSE);
				 int nILWMem = GetHasSpell(SPELL_INFLICT_LIGHT_WOUNDS, OBJECT_SELF);
				 int nIMWMem = GetHasSpell(SPELL_INFLICT_MODERATE_WOUNDS, OBJECT_SELF);
				 int nISWMem = GetHasSpell(SPELL_INFLICT_SERIOUS_WOUNDS, OBJECT_SELF);
				 int nICWMem = GetHasSpell(SPELL_INFLICT_CRITICAL_WOUNDS, OBJECT_SELF);
				 if (nICWMem) {
				 	eHeal = EffectHeal(nHealC);
					ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, OBJECT_SELF);
				 	DecrementRemainingSpellUses(OBJECT_SELF, SPELL_INFLICT_CRITICAL_WOUNDS);
					}	
				 else if (nISWMem) {
				 	eHeal = EffectHeal(nHealS);
					ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, OBJECT_SELF);
				 	DecrementRemainingSpellUses(OBJECT_SELF, SPELL_INFLICT_SERIOUS_WOUNDS);
					}	
				 else if (nIMWMem) {
				 	eHeal = EffectHeal(nHealM);
					ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, OBJECT_SELF);
				 	DecrementRemainingSpellUses(OBJECT_SELF, SPELL_INFLICT_MODERATE_WOUNDS);
					}	
				 else if (nILWMem) {
				 	eHeal = EffectHeal(nHealL);
					ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, OBJECT_SELF);
				 	DecrementRemainingSpellUses(OBJECT_SELF, SPELL_INFLICT_LIGHT_WOUNDS);
					}	
				 
				ApplyEffectToObject(DURATION_TYPE_INSTANT, eHealVis, OBJECT_SELF);
				ActionSpeakString("Casts a spell.", TALKVOLUME_TALK);
				 }
	return;
	}
	
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