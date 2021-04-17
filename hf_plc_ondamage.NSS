//OnDamage for all Silvy Uni placeables outside the classrooms
//Wynna February 2008


#include "acr_placeable_i"

void main()
{
	ACR_PlaceableOnDamaged();
    object oDamager = GetLastDamager();
    effect eKnockdown = EffectKnockdown();
	effect eStruck = EffectDamage(1, DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_NORMAL, FALSE);			
	effect eSpark = EffectVisualEffect( VFX_IMP_FLAME_M, FALSE);
    effect eFireball = EffectVisualEffect ( VFX_FNF_FIREBALL, FALSE);
    effect eExplosion = EffectVisualEffect ( VFX_FNF_GAS_EXPLOSION_FIRE, FALSE);
    effect eShake = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE, FALSE);

	
       

}			 			 