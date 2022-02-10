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
			{int nTouch = TouchAttackMelee(oTarget);
			 int nDrain = d6();
			
			SendMessageToAllDMs(GetName(oTarget) + " nDrain = " + IntToString(nDrain));
			SendMessageToPC(oTarget, "nDrain = " + IntToString(nDrain));
			if(nTouch)
				{if(nDrain >  GetAbilityScore(oTarget, ABILITY_STRENGTH) &&
				   !GetIsImmune(oTarget, IMMUNITY_TYPE_ABILITY_DECREASE))
					{ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oTarget);}
				
				ApplyEffectToObject(DURATION_TYPE_PERMANENT, ExtraordinaryEffect(EffectAbilityDecrease(ABILITY_STRENGTH, nDrain)), oTarget);
				SendMessageToPC(oTarget, GetName(OBJECT_SELF) + " touches you! Strength goes out of your limbs.");
				ApplyEffectToObject( DURATION_TYPE_INSTANT, EffectVisualEffect( VFX_IMP_PULSE_NEGATIVE ), oTarget );
				}	
			}
	}
	 
	  		  