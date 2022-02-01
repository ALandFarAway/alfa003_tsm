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
			int nDamage = d6();
			if(nTouch == 2) nDamage += d6();
			int nDrain = d4();
			if(nTouch)
			{
				/*effect eEffect = GetFirstEffect(oSpellTarget);
				while(GetIsEffectValid(eEffect))
				{
					if(GetEffectSpellId(eEffect) == GetSpellId() &&
					   GetEffectCreator(eEffect) == OBJECT_SELF)
					{
						nDrain += GetEffectInteger(eEffect, 1);
						RemoveEffect(oSpellTarget, eEffect);
					}
					eEffect = GetNextEffect(oSpellTarget);
				}*/
				
				int nAbility = Random(6);
				
				if(GetLevelByClass(CLASS_TYPE_SORCERER, oSpellTarget) ||
				   GetLevelByClass(CLASS_TYPE_FAVORED_SOUL, oSpellTarget) ||
				   GetLevelByClass(CLASS_TYPE_BARD, oSpellTarget))
				{  
				    if(Random(4) == 1) {nAbility = ABILITY_CHARISMA;}
				}
				if(GetLevelByClass(CLASS_TYPE_CLERIC, oSpellTarget) ||
				   GetLevelByClass(CLASS_TYPE_DRUID, oSpellTarget) ||
				   GetLevelByClass(CLASS_TYPE_SPIRIT_SHAMAN, oSpellTarget))
				{
					if(Random(4) == 1) {nAbility = ABILITY_WISDOM;}
				}
				if(GetLevelByClass(CLASS_TYPE_WIZARD, oSpellTarget))
				{
					if(Random(4) == 1) {nAbility = ABILITY_INTELLIGENCE;}
				}
				
				string sMessage = GetName(OBJECT_SELF) + " touches you!";
				string sMessageAbility;
				if(nAbility == 0) {sMessageAbility = "Your muscles go slack.";}
				else if(nAbility == 1) {sMessageAbility = "Your limbs freeze up.";}
				else if(nAbility == 2) {sMessageAbility = "Your feel faint.";}
				else if(nAbility == 3) {sMessageAbility = "Your mind dulls.";}
				else if(nAbility == 4) {sMessageAbility = "Your panic clouds your judgement.";}
				else if((nAbility == 5) && GetLevelByClass(CLASS_TYPE_BARD, oSpellTarget)) {sMessageAbility = "Your voice stutters.";}
				else if(nAbility == 5) {sMessageAbility = "Your confidence fails.";}
				
				SendMessageToPC(oSpellTarget, sMessage);
				SendMessageToPC(oSpellTarget, sMessageAbility);
				SendMessageToAllDMs(GetName(oSpellTarget) + " touched by " + GetTag(OBJECT_SELF) + " got " + sMessageAbility);
				if(nDrain >  GetAbilityScore(oSpellTarget, nAbility) &&
				   !GetIsImmune(oSpellTarget, IMMUNITY_TYPE_ABILITY_DECREASE))
				{
					ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectParalyze(), oSpellTarget);
				}
        	    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(5), oPossessor);
				ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectAbilityDecrease(nAbility, nDrain)), oSpellTarget);
				ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(nDamage), oSpellTarget);
				ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect( VFX_IMP_PULSE_NEGATIVE ), oSpellTarget );
			}
		}		
}			  		  