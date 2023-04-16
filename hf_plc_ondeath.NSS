//OnDamage for all High Forest placeables 
//Wynna February 2022

#include "acr_placeable_i"

void ActionCreateWynPlacedEffect(string sPlacedEffect, location lLocPlaceEffect)
{
    CreateObject(OBJECT_TYPE_PLACED_EFFECT, sPlacedEffect, lLocPlaceEffect);
}

void main() {
    ACR_PlaceableOnDeath();
    object oKiller = GetLastKiller();
    effect eKnockdown = EffectKnockdown();
	effect eStruck = EffectDamage(d10(1), DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_NORMAL, FALSE);			
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
    object oPCSix = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, OBJECT_SELF, 6);
    object oPCSeven = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, OBJECT_SELF, 7);
    string sCreateCr = "";
	
  		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eExplosion, OBJECT_SELF, 5.0);
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHowl, OBJECT_SELF, 5.0);
		if((GetDistanceBetween(oPCOne, OBJECT_SELF) <= 30.0) && (ReflexSave(oPCOne,15, SAVING_THROW_TYPE_TRAP, OBJECT_SELF) == 0)) {
			 ApplyEffectToObject(DURATION_TYPE_INSTANT,eStruck, oPCOne); 
	    	 ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eKnockdown, oPCOne, 3.0); 
		     ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eShake, oPCOne, 3.0); 
	     }
		if((GetDistanceBetween(oPCTwo, OBJECT_SELF) <= 30.0)  && (ReflexSave(oPCTwo,15, SAVING_THROW_TYPE_TRAP, OBJECT_SELF) == 0)) {
			 ApplyEffectToObject(DURATION_TYPE_INSTANT,eStruck, oPCTwo); 
	         ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eKnockdown, oPCTwo, 10.0); 
		     ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eShake, oPCTwo, 10.0); 
	     }
		if((GetDistanceBetween(oPCThree, OBJECT_SELF) <= 30.0)  && (ReflexSave(oPCThree,15, SAVING_THROW_TYPE_TRAP, OBJECT_SELF) == 0)) {
			 ApplyEffectToObject(DURATION_TYPE_INSTANT,eStruck, oPCThree); 
	         ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eKnockdown, oPCThree, 10.0); 
		     ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eShake, oPCThree, 10.0); 
	     }
		
		if((GetDistanceBetween(oPCFour, OBJECT_SELF) <= 30.0)  && (ReflexSave(oPCFour,15, SAVING_THROW_TYPE_TRAP, OBJECT_SELF) == 0)) {
			 ApplyEffectToObject(DURATION_TYPE_INSTANT,eStruck, oPCFour); 
	         ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eKnockdown, oPCFour, 10.0); 
		     ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eShake, oPCFour, 10.0); 
	     }
		if((GetDistanceBetween(oPCFive, OBJECT_SELF) <= 30.0)  && (ReflexSave(oPCFive,15, SAVING_THROW_TYPE_TRAP, OBJECT_SELF) == 0)) {
			 ApplyEffectToObject(DURATION_TYPE_INSTANT,eStruck, oPCFive); 
	         ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eKnockdown, oPCFive, 10.0); 
		     ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eShake, oPCFive, 10.0); 
	     }
		if((GetDistanceBetween(oPCSix, OBJECT_SELF) <= 30.0)  && (ReflexSave(oPCSix,15, SAVING_THROW_TYPE_TRAP, OBJECT_SELF) == 0)) {
			 ApplyEffectToObject(DURATION_TYPE_INSTANT,eStruck, oPCSix); 
	    	 ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eKnockdown, oPCSix, 10.0); 
		     ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eShake, oPCSix, 10.0); 
	     }
		if((GetDistanceBetween(oPCSeven, OBJECT_SELF) <= 30.0)  && (ReflexSave(oPCSeven,15, SAVING_THROW_TYPE_TRAP, OBJECT_SELF) == 0)) {
			 ApplyEffectToObject(DURATION_TYPE_INSTANT,eStruck, oPCSeven); 
	         ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eKnockdown, oPCSeven, 10.0); 
		     ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eShake, oPCSeven, 10.0); 
	     }
		 
		DelayCommand(5.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eImplosion, OBJECT_SELF, 5.0));
		DestroyObject(OBJECT_SELF, 10.0);
		
		
}