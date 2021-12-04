//OnDamage for all Silvy Uni placeables outside the classrooms
//Wynna February 2008


#include "acr_placeable_i"

void main()
{
	ACR_PlaceableOnDamaged();
    object oDamager = GetLastDamager();
	object oPCOne = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, OBJECT_SELF, 1);
    object oPCTwo = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, OBJECT_SELF, 2);
    object oPCThree = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, OBJECT_SELF, 3);
    object oPCFour = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, OBJECT_SELF, 4);
    object oPCFive = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, OBJECT_SELF, 5);
    effect eKnockdown = EffectKnockdown();
	effect eStruck = EffectDamage(1, DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_NORMAL, FALSE);			
	effect eSpark = EffectVisualEffect( VFX_IMP_FLAME_M, FALSE);
    effect eFireball = EffectVisualEffect ( VFX_FNF_FIREBALL, FALSE);
    effect eExplosion = EffectVisualEffect ( VFX_FNF_GAS_EXPLOSION_FIRE, FALSE);
    effect eShake = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE, FALSE);

	
    if(GetTag(OBJECT_SELF) == "giant_crystal_source")
		{ApplyEffectToObject(DURATION_TYPE_INSTANT,eStruck, oDamager, 3.0); 
	     ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSpark, OBJECT_SELF, 3.0); 
	     ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eFireball, OBJECT_SELF, 5.0); 
	     ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eExplosion, OBJECT_SELF, 3.0); 
	     ActionSpeakString("The light within the giant crystal pulses. Cracks spread, and shards fly!", TALKVOLUME_TALK);
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
		 
		
		}
}			 			 