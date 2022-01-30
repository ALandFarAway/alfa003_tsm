//TSM individual item onHit cast.  
// Wynna /  Arri 2022

 #include "acr_spawn_i"
 #include "x2_inc_spellhook"


void main()
	{  object oTarget; // On a weapon: The one being hit. On an armor: The one hitting the armor
	   SendMessageToAllDMs("allip item firing");
	   //SendMessageToAllDMs("oTarget = " + GetTag(oTarget));
	   object oItem        = GetSpellCastItem();    // The item casting that triggered this spellscript
   	   //SendMessageToAllDMs("oItem = " + GetTag(oItem));
	   object oSpellOrigin = OBJECT_SELF ;
	   //SendMessageToAllDMs("oSpellOrigin = " + GetTag(oSpellOrigin));
	   object oSpellTarget = GetSpellTargetObject();
	   //SendMessageToAllDMs("oSpellTarget = " + GetTag(oSpellTarget));
	   object oPossessor   = GetItemPossessor(oItem);  //On a weapon: The one wielding the weapon. On an armor: The one wearing an armor
	   //SendMessageToAllDMs("oPossessor = " + GetTag(oPossessor));
	   
	   if(GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
		{
			int nTouch = TouchAttackMelee(oSpellTarget);
			int nDamage = d4();
			SendMessageToAllDMs("nDamage = " + IntToString(nDamage));
	   		SendMessageToPC(oSpellTarget, "nDamage = " + IntToString(nDamage));
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
				ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectTemporaryHitpoints(5)), oPossessor);
				ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectAbilityDecrease(ABILITY_WISDOM, nDamage)), oSpellTarget);
				ApplyEffectToObject( DURATION_TYPE_INSTANT, EffectVisualEffect( VFX_IMP_PULSE_NEGATIVE ), oSpellTarget );
			}
		}		
}			  		  