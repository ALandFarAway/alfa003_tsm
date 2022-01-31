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
	    
	   if(GetObjectType(oSpellTarget) == OBJECT_TYPE_CREATURE)
		{
			int nTouch = TouchAttackMelee(oSpellTarget);
			int nDamage = d4();
			if(nTouch == 2) nDamage += d4();
			if(nTouch)
			{
				if(nDamage >  GetAbilityScore(oSpellTarget, ABILITY_WISDOM) &&
				   !GetIsImmune(oSpellTarget, IMMUNITY_TYPE_ABILITY_DECREASE))
				{
					ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectSleep(), oSpellTarget);
				}
				else
				{
					effect eEffect = GetFirstEffect(oSpellTarget);
					while(GetIsEffectValid(eEffect))
					{
						if(GetEffectSpellId(eEffect) == GetSpellId() &&
						   GetEffectCreator(eEffect) == OBJECT_SELF)
						{
							nDamage += GetEffectInteger(eEffect, 1);
							RemoveEffect(oTarget, eEffect);
						}
						eEffect = GetNextEffect(oSpellTarget);
					}
				}
				
				string sMessage = GetName(OBJECT_SELF) + " touches you! Panic clouds your judgement.";
				SendMessageToPC(oSpellTarget, sMessage);
				SendMessageToAllDMs(GetName(oSpellTarget) +  " got: " + sMessage);
				
				ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectAbilityDecrease(ABILITY_WISDOM, nDamage)), oSpellTarget);
				ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectTemporaryHitpoints(5)), oPossessor);
				ApplyEffectToObject( DURATION_TYPE_INSTANT, EffectVisualEffect( VFX_IMP_PULSE_NEGATIVE ), oSpellTarget );
			}
		}		
	
}			  		  