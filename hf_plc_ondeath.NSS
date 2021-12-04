////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ACR Configuration File
//     Filename : acf_plc_ondeath.nss
//    $Revision:: 188        $ current version of the file
//        $Date:: 2006-12-21#$ date the file was created or modified
//       Author : Ronan
//
//  Local Variable Prefix =
//
//  Dependencies external of nwscript:
//
//  Description
//  This script calls the ACR's OnDeath code for placeables, and any
//  custom code a server may need. It is not updated in ACR updates.
//
//  Revision History
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

#include "acr_placeable_i"

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

// The main event handler.
void main();

////////////////////////////////////////////////////////////////////////////////
// Function Definitions ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

void main() {
    ACR_PlaceableOnDeath();
    object oKiller = GetLastKiller();
    effect eKnockdown = EffectKnockdown();
	effect eStruck = EffectDamage(1, DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_NORMAL, FALSE);			
	effect eSpark = EffectVisualEffect( VFX_IMP_FLAME_M, FALSE);
    effect eFireball = EffectVisualEffect ( VFX_FNF_FIREBALL, FALSE);
    effect eExplosion = EffectVisualEffect ( VFX_FNF_ELECTRIC_EXPLOSION, FALSE);
    effect eShake = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE, FALSE);
    effect eImplosion = EffectVisualEffect(VFX_FNF_IMPLOSION, FALSE);
	effect eHowl = EffectVisualEffect(VFX_FNF_HOWL_MIND, FALSE);
	effect eSoundSpike = EffectVisualEffect(VFX_SOUND_SPIKE, FALSE);
	effect eChunk = EffectVisualEffect(VFX_COM_CHUNK_STONE_MEDIUM, FALSE);
    object oPCOne = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, OBJECT_SELF, 1);
    object oPCTwo = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, OBJECT_SELF, 2);
    object oPCThree = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, OBJECT_SELF, 3);
    object oPCFour = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, OBJECT_SELF, 4);
    object oPCFive = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, OBJECT_SELF, 5);
        
    // Custom code goes here.
	
if(GetTag(OBJECT_SELF) == "giant_crystal_source")
{object oForceDown = GetObjectByTag("giant_crystal_source_static", 0);
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eExplosion, OBJECT_SELF, 5.0);
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eExplosion, oForceDown, 5.0);
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHowl, OBJECT_SELF, 5.0);
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHowl, oForceDown, 5.0);
		ActionSpeakString("The giant crystal's pulsing in lights both visible and aurific reaches a crescendo, for a moment blazing on all frequencies as a brilliant white. Runes composed of denser black crystal are backlit, encrusted all over the cleaner lines of shafts of crystal at the heart. For a moment, you see names, flashburned onto your retinas, names in a dozen common racial languages.  Then the giant crystal explodes in a burst of power of all types: physical, sonic, arcane, and divine.", TALKVOLUME_TALK);
		if(GetDistanceBetween(oPCOne, OBJECT_SELF) <= 30.0) {
			 ApplyEffectToObject(DURATION_TYPE_INSTANT,eStruck, oPCOne, 3.0); 
	    	 ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eKnockdown, oPCOne, 3.0); 
		     ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eShake, oPCOne, 3.0); 
	     }
		if(GetDistanceBetween(oPCTwo, OBJECT_SELF) <= 30.0) {
			 ApplyEffectToObject(DURATION_TYPE_INSTANT,eStruck, oPCTwo, 3.0); 
	         ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eKnockdown, oPCTwo, 3.0); 
		     ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eShake, oPCTwo, 3.0); 
	     }
		if(GetDistanceBetween(oPCThree, OBJECT_SELF) <= 30.0) {
			 ApplyEffectToObject(DURATION_TYPE_INSTANT,eStruck, oPCThree, 3.0); 
	         ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eKnockdown, oPCThree, 3.0); 
		     ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eShake, oPCThree, 3.0); 
	     }
		
		if(GetDistanceBetween(oPCFour, OBJECT_SELF) <= 30.0) {
			 ApplyEffectToObject(DURATION_TYPE_INSTANT,eStruck, oPCFour, 3.0); 
	         ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eKnockdown, oPCFour, 3.0); 
		     ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eShake, oPCFour, 3.0); 
	     }
		if(GetDistanceBetween(oPCFive, OBJECT_SELF) <= 30.0) {
			 ApplyEffectToObject(DURATION_TYPE_INSTANT,eStruck, oPCFive, 3.0); 
	         ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eKnockdown, oPCFive, 3.0); 
		     ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eShake, oPCFive, 3.0); 
	     }
		 
		 DelayCommand(5.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eImplosion, OBJECT_SELF, 5.0));
		DelayCommand(5.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eImplosion, oForceDown, 5.0));
		DestroyObject(oForceDown, 10.0);
		
		}
}