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
void ActionCreateWynItem(string sItem, location lLocCItem)
{
    CreateObject(OBJECT_TYPE_ITEM, sItem, lLocCItem);
}
void main()
{
    ACR_CreatureOnDamaged();
	
	//Zombie creatures spill parasitic moths
	
		if(GetTag(OBJECT_SELF) == "abr_un_wyv_twisted")
		{int nCurrentHP = GetCurrentHitPoints(OBJECT_SELF);
		 int nMaxHP = GetMaxHitPoints(OBJECT_SELF);
		 object oPortal = GetObjectByTag("alfa_portal_plc_wyv");
		 object oMoveA = GetWaypointByTag("wyvern_movea_wp");
	     object oMoveB = GetWaypointByTag("wyvern_moveb_wp");
	     object oMoveC = GetWaypointByTag("wyvern_movec_wp");
	     object oMoveD = GetWaypointByTag("wyvern_moved_wp");
	     object oMoveE = GetWaypointByTag("wyvern_movee_wp");
	     object oMoveF = GetWaypointByTag("wyvern_movef_wp");
	     object oMoveG = GetWaypointByTag("wyvern_moveg_wp");
	     object oMoveH = GetWaypointByTag("wyvern_moveh_wp");
	     object oCreateA = GetWaypointByTag("cave_wyvern_spawn_wp");
		 object oCreateB = GetWaypointByTag("cave_wyvern_spawnb_wp");
		 object oCreateC = GetWaypointByTag("cave_wyvern_spawnc_wp");
		 location lSpawn;
		 object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, OBJECT_SELF, 1);
		 if(GetDistanceBetween(oPC, OBJECT_SELF) < 5.0) {lSpawn = GetLocation(oPortal);}
		 if(GetDistanceBetween(oPC, OBJECT_SELF) < 2.0) {lSpawn = GetLocation(OBJECT_SELF);}
		 object oMothOne = CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_mb_deathmoth", GetLocation(OBJECT_SELF));
		 if(Random(3)==1) {object oMothTwo = CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_mb_deathmoth", GetLocation(OBJECT_SELF));}
		 if(Random(3)==1) {object oMothThree = CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_mb_deathmoth", GetLocation(OBJECT_SELF));}
		 if(Random(3)==1) {object oMothFour = CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_mb_deathmoth_lva", lSpawn);}
		 if(Random(3)==1) {object oMothFive = CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_mb_deathmoth_lva", lSpawn);}
		 if(Random(3)==1) {object oMothSix = CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_mb_deathmoth_lva", lSpawn);}
		 if(Random(3)==1) {object oMothSeven = CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_mb_deathmoth", GetLocation(OBJECT_SELF));}
		 if(Random(3)==1) {object oMothEight = CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_mb_deathmoth", GetLocation(OBJECT_SELF));}
		 if(Random(3)==1) {object oMothNine = CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_mb_deathmoth_lva", lSpawn);}
		 if(Random(3)==1) {object oMothTen = CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_mb_deathmoth_lva", lSpawn);}
		 if(Random(3)==1) {object oMothEleven = CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_mb_deathmoth_lva", lSpawn);}
		 if(Random(8) == 1) {DelayCommand(3.0, AssignCommand(oMothOne, ActionSpeakString("Squirming larvae and moths with markings like skulls spill out of a wound.", TALKVOLUME_TALK)));}
		 
		 if((nCurrentHP < nMaxHP/5) && (GetLocalInt(GetModule(), "BaeCreate") != 1)) {
		 	SetLocalInt(GetModule(), "BaeCreate", 1);
			ActionSpeakString("*Leaps into the air, swooping around for an attack.", TALKVOLUME_TALK);
			AssignCommand(OBJECT_SELF, ActionJumpToLocation(GetLocation(oMoveH)));
			object oBluePortal = CreateObject(OBJECT_TYPE_PLACED_EFFECT, "003_fx_portal_blue_lrg", GetLocation(OBJECT_SELF));				
		    object oBae = CreateObject(OBJECT_TYPE_CREATURE, "003_pc_bae'ithra_drg", GetLocation(OBJECT_SELF));
			effect eLight = EffectVisualEffect(VFX_DUR_GLOW_WHITE, FALSE);
			ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLight, oBae);
			AssignCommand(oBae, ActionSpeakString("*Appears in a flash of light above the wyvern, slamming into its back feet first, sending it tumbling.", TALKVOLUME_TALK));
			AssignCommand(oBae, ActionAttack(OBJECT_SELF));
			ClearAllActions(TRUE);
			ActionAttack(oBae, FALSE);
			DelayCommand(10.0, ActionSpeakString("*Screeches in rage and whips around in mid-air, tail lashing at Bae'ithra, a surprise entrant into the fight.", TALKVOLUME_TALK));
			DelayCommand(19.0, AssignCommand(oBae, ActionJumpToLocation(GetLocation(OBJECT_SELF))));
			DelayCommand(20.0, AssignCommand(oBae, ActionSpeakString("*Darts across the wyvern's back and lands astride its neck.", TALKVOLUME_TALK)));
			DelayCommand(34.0, AssignCommand(oBae, ActionJumpToLocation(GetLocation(OBJECT_SELF))));
			DelayCommand(35.0, AssignCommand(oBae, ActionSpeakString("*Using a dagger hilt, hammers at the crystal collar around the wyvern's neck until it breaks off in his hand.", TALKVOLUME_TALK)));
			DestroyObject(oBluePortal, 30.0);	
			DelayCommand(49.0, AssignCommand(oBae, ActionJumpToLocation(GetLocation(OBJECT_SELF))));
			DelayCommand(50.0, AssignCommand(OBJECT_SELF, ActionSpeakString("*Swings jaws around, snatching its own collar from Bae's hand and flinging it away, then sets wings and dives, with Bae on his back.", TALKVOLUME_TALK)));
			DelayCommand(55.0, ActionCreateWynItem("003_it_collar_msg", GetLocation(oMoveF)));
			DelayCommand(64.0, AssignCommand(oBae, ActionJumpToLocation(GetLocation(OBJECT_SELF))));
			DelayCommand(65.0, AssignCommand(oBae, ActionSpeakString("*As he rides the wyvern down into the depths and out of sight, he shouts: 'Get out of here, my friends!'", TALKVOLUME_TALK)));
			DestroyObject(oBae, 70.0);
			DestroyObject(GetObjectByTag("tsm_afx_area_fog_red", 1), 73.0);
			DestroyObject(GetObjectByTag("tsm_afx_dthgod_lt_red", 1), 73.0);
			DestroyObject(OBJECT_SELF, 75.0);
			}
		 if(GetDistanceBetween(OBJECT_SELF, GetLastDamager(OBJECT_SELF)) < 5.0) {
		 	ClearAllActions(TRUE);
			object oDamager = GetLastDamager(OBJECT_SELF);
			ActionSpeakString("*Lunges at " + GetName(oDamager), TALKVOLUME_TALK);
			int nGrapple = 15;
			int nBABFoe = GetTRUEBaseAttackBonus(oDamager);
			int nStrFoe = GetAbilityModifier(ABILITY_STRENGTH, oDamager);
			AssignCommand(oDamager, ActionSpeakString("*Attack of Opportunity on Wyvern Zombie", TALKVOLUME_TALK));
			AssignCommand(oDamager, ActionAttack(OBJECT_SELF, FALSE));
			if(TouchAttackMelee(oDamager, TRUE, 0) > 0) {
				int nAttack = d20(1);
				int nAttackFoe = d20(1);
				int nWyvGrapple = nAttack + nGrapple;
				int nFoeGrapple = nAttackFoe + nBABFoe + nStrFoe;
				effect eKnockdown = EffectKnockdown();
				int nFallDmg = d6(4);
				effect eFallDmg = EffectDamage(nFallDmg, DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_NORMAL, FALSE);
				SendMessageToAllDMs("Wyvern: " + IntToString(nAttack) + " + " + IntToString(nGrapple) + " = " + IntToString(nWyvGrapple));
				SendMessageToAllDMs(GetName(oDamager) + ": " + IntToString(nAttackFoe) + " + " + IntToString(nBABFoe) + " + " + IntToString(nStrFoe) + " = " + IntToString(nFoeGrapple));
			    SendMessageToPC(oDamager, "Opposed Grapple Rolls:");
				SendMessageToPC(oDamager, "Wyvern: " + IntToString(nAttack) + " + " + IntToString(nGrapple) + " = " + IntToString(nWyvGrapple));
				SendMessageToPC(oDamager, GetName(oDamager) + ": " + IntToString(nAttackFoe) + " + " + IntToString(nBABFoe) + " + " + IntToString(nStrFoe) + " = " + IntToString(nFoeGrapple));
			    if(nFoeGrapple > nWyvGrapple) {SendMessageToPC(oDamager, "You break free!");}
				if(nWyvGrapple > nFoeGrapple) {
					SendMessageToPC(oDamager, "You are grappled!");
					ClearAllActions(TRUE);
					SpeakString("*Launches into the air with " + GetName(oDamager) + " in its claws and drops " + GetName(oDamager) + " from a height!", TALKVOLUME_TALK);
					int nRandomLoc = Random(5);
					object oRandom = oPortal;
					if(nRandomLoc == 1) {oRandom = oMoveE;}
					else if(nRandomLoc == 2) {oRandom = oMoveF;}
					else if(nRandomLoc == 3) {oRandom = oMoveG;}
					int nRandomFlight = Random(5);
					object oRandomFlight = oMoveC;
					object oDistance = oMoveA;
					if(nRandomLoc == 1) {oRandom = oMoveA;}
					else if(nRandomLoc == 2) {oRandom = oMoveB;}
					else if(nRandomLoc == 3) {oRandom = oCreateA;}
					else if(nRandomLoc == 4) {oRandom = oCreateB; oDistance = oMoveD;}
					else if(nRandomLoc == 4) {oRandom = oMoveH; oDistance = oMoveD;}
					AssignCommand(oDamager, ActionJumpToLocation(GetLocation(oRandom)));
					AssignCommand(OBJECT_SELF, ActionJumpToLocation(GetLocation(oDamager)));
					ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnockdown, oDamager, 10.0);
					ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFallDmg, oDamager, 10.0);
					AssignCommand(OBJECT_SELF, ActionJumpToLocation(GetLocation(oRandomFlight)));
					ClearAllActions(TRUE);
					AssignCommand(OBJECT_SELF, ActionForceMoveToObject(oDistance));
					AssignCommand(OBJECT_SELF, ActionForceMoveToObject(oRandomFlight));
					AssignCommand(OBJECT_SELF, ActionJumpToObject(GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, OBJECT_SELF, 1)));
					
					}
				}
		 	}
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