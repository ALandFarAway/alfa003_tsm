////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ACR Configuration File
//     Filename : acf_cre_onspawnin
//    $Revision:: 280        $ current version of the file
//        $Date:: 2007-03-20#$ date the file was created or modified
//       Author : Cipher
//
//    Var Prefix:
//  Dependencies:
//
//  Description
//  This script calls the ACR's OnSpawnIn event handler for creatures
//  and any custom code a server may need. It is not updated in ACR updates.
//
//  Revision History
//    2010/11/17  AcadiusLost - Autodisabled flocking on creatures without a "parent" spawn point.
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#include "acr_creature_i"
#include "x0_i0_position" 
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
void ActionCreateWynCreature(string sCreature, location lLocCreature)
{
    CreateObject(OBJECT_TYPE_CREATURE, sCreature, lLocCreature);
}

void main()
{
    ACR_CreatureOnSpawnIn();
	
	SetLocalString(OBJECT_SELF, "sMyTag", GetTag(OBJECT_SELF));
	
	//animation code
	if (GetLocalInt(OBJECT_SELF,"USE_IMMOBILE_AMBIENT_ANIM")==1)
		{
		float fRand=IntToFloat(d6(3));
		DelayCommand(fRand,ExecuteScript("dpss_ambient_anim",OBJECT_SELF));
		}
		
	//Temp. Remove after session
	if(GetTag(OBJECT_SELF) == "003_cr_un_spirit_evenwood") {
	
		object oJhessi = GetObjectByTag("003_pc_jhessi_2", 0);
		object oPC = GetFirstPC(TRUE);
		while(oPC != OBJECT_INVALID) {
			string sPCName = GetName(oPC);
			if(FindSubString(sPCName, "Jhessi") != -1) {
				oJhessi = oPC;
				}
			
		oPC = GetNextPC(TRUE);
		}
 		
		object oAloisusWP = GetWaypointByTag("aloisus_wp");
		object oSiWP = GetWaypointByTag("si_wp");
		object oValbraceWP = GetWaypointByTag("valbrace_wp");
		
		DelayCommand(5.0, ActionForceMoveToObject(oJhessi, FALSE, 0.5, 20.0));
		DelayCommand(7.0, ActionForceFollowObject(oJhessi, 0.5));
		DelayCommand(8.0, ActionSpeakString("Jhessi. *Ghostly tears falling on ethereal cheeks.", TALKVOLUME_TALK));
	 	
		DelayCommand(60.0, ActionCreateWynCreature("003_cr_un_ghost_aloisus", GetLocation(oAloisusWP)));
		DelayCommand(60.0, ActionCreateWynCreature("003_cr_un_ghost_si", GetLocation(oSiWP)));
		DelayCommand(60.0, ActionCreateWynCreature("003_cr_un_ghost_valbrace", GetLocation(oValbraceWP)));
		
		}
	
	//Temp. Remove after session.	
    if(FindSubString(GetTag(OBJECT_SELF), "ghost") != -1) {
		effect eFreeze = EffectCutsceneImmobilize();
		effect eInvis = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY, FALSE);
		effect eAppear = EffectVisualEffect(VFX_HIT_AOE_ILLUSION, FALSE);
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFreeze, OBJECT_SELF, 2.0);
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eInvis, OBJECT_SELF, 2.0);
	
		ClearAllActions(TRUE);
		ChangeToStandardFaction(OBJECT_SELF, STANDARD_FACTION_COMMONER);	
		
		DestroyObject(OBJECT_SELF, IntToFloat(Random(180)));
		DelayCommand(IntToFloat(Random(120)) + 60.0, ChangeToStandardFaction(OBJECT_SELF, STANDARD_FACTION_HOSTILE));
		
	}
		
	//Hydra's extra attacks
	if(GetTag(OBJECT_SELF) == "abr_cr_mb_hydra5") {
	SetBaseAttackBonus(5, OBJECT_SELF);
	int nBAB = GetBaseAttackBonus(OBJECT_SELF);
	}
	
	//Unhallowed Turn Resistance Increase
	if(FindSubString(GetTag(GetArea(OBJECT_SELF)), "rauvin_ruins") != -1) {
		if((GetRacialType(OBJECT_SELF) == RACIAL_TYPE_UNDEAD) || (GetSubRace(OBJECT_SELF) == RACIAL_SUBTYPE_UNDEAD)) {
		 effect eTurnInc = EffectTurnResistanceIncrease(4);
		 int nBefore = GetTurnResistanceHD(OBJECT_SELF);
		 ApplyEffectToObject(DURATION_TYPE_PERMANENT, eTurnInc, OBJECT_SELF);
		 }
	
	}
				
}