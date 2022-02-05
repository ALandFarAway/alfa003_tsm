//TSM individual item onHit cast.  
// Wynna /  Arri 2022

 #include "acr_spawn_i"
 #include "x2_inc_spellhook"


void main()
	{  object oTarget; // On a weapon: The one being hit. On an armor: The one hitting the armor
	   object oItem        = GetSpellCastItem();    // The item casting that triggered this spellscript
   	   object oSpellOrigin = OBJECT_SELF ;
	   object oSpellTarget = GetSpellTargetObject();
	   object oPossessor   = GetItemPossessor(oItem);  //On a weapon: The one wielding the weapon. On an armor: The one wearing an armor
	    
	   if(GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
		{
			int nTouch = TouchAttackMelee(oTarget);
			int nDamage = d4();
			//if(nTouch == 2) nDamage += d4();
			int nDrain = d6();
			if(nTouch && !FortitudeSave(oTarget, 14, SAVING_THROW_TYPE_NEGATIVE, OBJECT_SELF))
			{
				if(nDrain >  GetAbilityScore(oTarget, ABILITY_CONSTITUTION) &&
				   !GetIsImmune(oTarget, IMMUNITY_TYPE_ABILITY_DECREASE))
				{
					ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oTarget);
				}
				/*else
				{
					effect eEffect = GetFirstEffect(oTarget);
					while(GetIsEffectValid(eEffect))
					{
						if(GetEffectSpellId(eEffect) == GetSpellId() &&
						   GetEffectCreator(eEffect) == OBJECT_SELF)
						{
							nDrain += GetEffectInteger(eEffect, 1);
							RemoveEffect(oTarget, eEffect);
						}
						eEffect = GetNextEffect(oTarget);
					}
				}*/
				ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectTemporaryHitpoints(5)), OBJECT_SELF);
				ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectAbilityDecrease(ABILITY_CONSTITUTION, nDrain)), oTarget);
				ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(nDamage), oTarget);
				ApplyEffectToObject( DURATION_TYPE_INSTANT, EffectVisualEffect( VFX_IMP_PULSE_NEGATIVE ), oTarget );
			}
		}	
}			  		  