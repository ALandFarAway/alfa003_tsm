//
//     Filename : tsm_cr_tworc_onspawn
//      Version : 0.1
//         Date : 7/18/22
//       Author : Wynna
//
//  Description
//  This script handles onspawn functions for twisted orcs.
//	It is not updated in ACR updates.
//
//  Revision History
////////////////////////////////////////////////////////////////////////////////

//	Wynna - 7/8/2022

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////

#include "acr_spawn_i"

void ActionCreateWynCreature(string sCreature, location lLocCreature)
{
    CreateObject(OBJECT_TYPE_CREATURE, sCreature, lLocCreature);
}

void main() {

	object oCrystal = GetObjectByTag("rr_crystal_green_door", 0);
	effect eBeamGreen = EffectBeam(VFX_BEAM_GREEN_DRAGON_ACID, oCrystal, BODY_NODE_CHEST, FALSE);
	effect eFreeze = EffectCutsceneParalyze();
	effect eDeath = EffectDeath(TRUE, TRUE, TRUE, TRUE);
	object oTrigger = GetObjectByTag("rr_trg_onenter_script", 0);
		
	if(GetTag(OBJECT_SELF) == "003_cr_ud_swwraith_orc"){
		 effect eRise = EffectVisualEffect(VFX_FNF_SUMMON_EPIC_UNDEAD, FALSE);
		 ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRise, OBJECT_SELF, 5.0);
		 SpeakString("*A shape shimmers out of the dead orc", TALKVOLUME_TALK);
		}	
		
	if(GetTag(OBJECT_SELF) == "003_cr_twisted_hang"){
		 effect eParalyze = EffectCutsceneParalyze();
		 ApplyEffectToObject(DURATION_TYPE_PERMANENT, eParalyze, OBJECT_SELF);
  		 }		 
		 
	if(GetTag(OBJECT_SELF) == "003_cr_twisted_orc_kill"){
		 effect eDamage = EffectDamage(GetCurrentHitPoints(OBJECT_SELF), DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_NORMAL, TRUE);
		 ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, OBJECT_SELF);
  		 }			 		 		 
}