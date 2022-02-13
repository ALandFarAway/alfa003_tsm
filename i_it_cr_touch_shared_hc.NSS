// Variables need to be put on the creatures claw/slam and the Creature.  Choose the OnHitCast Touch attack on the item.

#include "x2_inc_spellhook"
#include "x2_inc_switches"
#include "acr_creature_i"
#include "NW_I0_SPELLS"


void main()
{   object oTarget = GetSpellTargetObject();
	object oItem        = GetSpellCastItem();    // The item casting that triggered this spellscript
   	object oPossessor   = GetItemPossessor(oItem);  //On a weapon: The one wielding the weapon. On an armor: The one wearing an armor
	   
	SendMessageToAllDMs("On Hit Cast fired. oPossessor = " + GetName(oPossessor) + " hit " + GetTag(oTarget));
	//int SaveDC = GetHitDice(OBJECT_SELF) / 2 + GetAbilityModifier(ABILITY_CHARISMA, OBJECT_SELF) + 10;

if(FindSubString(GetTag(oPossessor), "_cr_un_wraith")!= -1)
	{SendMessageToAllDMs("Wraith");
	 if(GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
		{//int nTouch = TouchAttackMelee(oTarget);
		//ActionUseFeat(2179, oTarget);
		int nDamage = d4();
		 //if(nTouch == 2) nDamage += d4();
		 int nDrain = d6();
		 SendMessageToAllDMs("nDrain = " + IntToString(nDrain));
		 if(!FortitudeSave(oTarget, 14, SAVING_THROW_TYPE_NEGATIVE, oPossessor))
			{if(nDrain >  GetAbilityScore(oTarget, ABILITY_CONSTITUTION) &&
			 !GetIsImmune(oTarget, IMMUNITY_TYPE_ABILITY_DECREASE))
				{ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oTarget);}
				else
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
				}
				ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectTemporaryHitpoints(5)), oPossessor);
				ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectAbilityDecrease(ABILITY_CONSTITUTION, nDrain)), oTarget);
				SendMessageToPC(oTarget, GetName(oPossessor) + " touches you! You feel more frail.");
				ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(nDamage), oTarget);
				ApplyEffectToObject( DURATION_TYPE_INSTANT, EffectVisualEffect( VFX_IMP_PULSE_NEGATIVE ), oTarget );
			}
		}
	}

else if(FindSubString(GetTag(oPossessor), "_cr_un_ghost")!= -1)
		{SendMessageToAllDMs("Ghost");
	     if(GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
			{//int nTouch = TouchAttackMelee(oTarget);
			 int nDamage = d6();
			 //if(nTouch == 2) nDamage += d6();
			 int nDrain = d4();
			 SendMessageToAllDMs("nDamage = " + IntToString(nDamage));
			 SendMessageToAllDMs("nDrain = " + IntToString(nDrain));
			// if(nTouch)
			//	{
				/*effect eEffect = GetFirstEffect(oTarget);
				//while(GetIsEffectValid(eEffect))
				{
					if(GetEffectSpellId(eEffect) == GetSpellId() &&
					   GetEffectCreator(eEffect) == OBJECT_SELF)
					{
						nDrain += GetEffectInteger(eEffect, 1);
						RemoveEffect(oTarget, eEffect);
					}
					eEffect = GetNextEffect(oTarget);
				}*/
				
				int nAbility = Random(6);
				
				if(GetLevelByClass(CLASS_TYPE_FIGHTER, oTarget) ||
				   GetLevelByClass(CLASS_TYPE_RANGER, oTarget))
				{  
				    if(Random(3) == 1) {nAbility = ABILITY_STRENGTH;}
				}
				
				if(GetLevelByClass(CLASS_TYPE_ROGUE, oTarget))
				{
					if(Random(3) == 1) {nAbility = ABILITY_DEXTERITY;}
				}
				
				if(GetLevelByClass(CLASS_TYPE_SORCERER, oTarget) ||
				   GetLevelByClass(CLASS_TYPE_FAVORED_SOUL, oTarget) ||
				   GetLevelByClass(CLASS_TYPE_BARD, oTarget))
				{  
				    if(Random(3) == 1) {nAbility = ABILITY_CHARISMA;}
				}
				if(GetLevelByClass(CLASS_TYPE_CLERIC, oTarget) ||
				   GetLevelByClass(CLASS_TYPE_DRUID, oTarget) ||
				   GetLevelByClass(CLASS_TYPE_SPIRIT_SHAMAN, oTarget))
				{
					if(Random(3) == 1) {nAbility = ABILITY_WISDOM;}
				}
				if(GetLevelByClass(CLASS_TYPE_WIZARD, oTarget))
				{
					if(Random(3) == 1) {nAbility = ABILITY_INTELLIGENCE;}
				}
				
				SendMessageToAllDMs(GetName(oTarget) + " loses " + IntToString(nDrain) + " points of ability " + IntToString(nAbility));
	   
				string sMessage = GetName(oPossessor) + " touches you!";
				string sMessageAbility;
				if(nAbility == 0) {sMessageAbility = "Your muscles go slack.";}
				else if(nAbility == 1) {sMessageAbility = "Your limbs freeze up.";}
				else if(nAbility == 2) {sMessageAbility = "Your feel faint.";}
				else if(nAbility == 3) {sMessageAbility = "Your mind dulls.";}
				else if(nAbility == 4) {sMessageAbility = "Your panic clouds your judgement.";}
				else if((nAbility == 5) && GetLevelByClass(CLASS_TYPE_BARD, oTarget)) {sMessageAbility = "Your voice stutters.";}
				else if(nAbility == 5) {sMessageAbility = "Your confidence fails.";}
				
				SendMessageToPC(oTarget, sMessage);
				SendMessageToPC(oTarget, sMessageAbility);
				//SendMessageToAllDMs(GetName(oTarget) + " touched by " + GetTag(oPossessor) + " got " + sMessageAbility);
				
				if(nDrain >  GetAbilityScore(oTarget, nAbility) &&
				   !GetIsImmune(oTarget, IMMUNITY_TYPE_ABILITY_DECREASE))
				{
					ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectParalyze(), oTarget);
				}
				
        		ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(5), oPossessor);
				ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectAbilityDecrease(nAbility, nDrain)), oTarget);
				ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(nDamage), oTarget);
				ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect( VFX_IMP_PULSE_NEGATIVE ), oTarget );
			//}
		}
	}
	
else if(FindSubString(GetTag(oPossessor), "_cr_un_allip")!= -1)
	{SendMessageToAllDMs("Allip");
	 if(GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
		{//int nTouch = TouchAttackMelee(oTarget);
         int nDrain = d4();
		 SendMessageToAllDMs("nDrain = " + IntToString(nDrain));
			//if(nTouch == 2) nDamage += d4();
		 //if(nTouch)
			//{
			if(nDrain >  GetAbilityScore(oTarget, ABILITY_WISDOM) &&
				   !GetIsImmune(oTarget, IMMUNITY_TYPE_ABILITY_DECREASE))
					{ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectSleep(), oTarget);}
				else
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
				}
				ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectTemporaryHitpoints(5)), oPossessor);
				ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectAbilityDecrease(ABILITY_WISDOM, nDrain)), oTarget);
				SendMessageToPC(oTarget, GetName(oPossessor) + " touches you! Panic clouds your judgement.");
				ApplyEffectToObject( DURATION_TYPE_INSTANT, EffectVisualEffect( VFX_IMP_PULSE_NEGATIVE ), oTarget );
			//}
		}
	}
	 
else if(FindSubString(GetTag(oPossessor), "_cr_ab_willowisp")!= -1)
		{SendMessageToAllDMs("Wisp");
	     if(GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
			{//int nTouch = TouchAttackMelee(oTarget);
			 int nDamage = d8(2);
			 //if(nTouch == 2) nDamage += d8(2);
		 	// if(nTouch)
				//{
				ApplyEffectToObject( DURATION_TYPE_INSTANT, EffectDamage( nDamage, DAMAGE_TYPE_ELECTRICAL ), oTarget );
			     SendMessageToPC(oTarget, GetName(oPossessor) + " touches you! You feel a jolt run through your body");
				 ApplyEffectToObject( DURATION_TYPE_TEMPORARY, EffectBeam( VFX_BEAM_SHOCKING_GRASP, oPossessor, BODY_NODE_CHEST, FALSE ), oTarget, 1.0f );
			//}
		}
   }
    
   
else if(FindSubString(GetTag(oPossessor), "_cr_un_shadow_greater")!= -1)
		{SendMessageToAllDMs("Greater Shadow");
	     if(GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
		   {//int nTouch = TouchAttackMelee(oTarget);
			int nDrain =  d8();
			SendMessageToAllDMs("nDrain = " + IntToString(nDrain));
			  
		//if(nTouch == 2) nDamage += d8();
		//if(nTouch)
		//	{
			if(nDrain >  GetAbilityScore(oTarget, ABILITY_STRENGTH) &&
				   !GetIsImmune(oTarget, IMMUNITY_TYPE_ABILITY_DECREASE))
					{ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oTarget);}
				else
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
				}
				ApplyEffectToObject(DURATION_TYPE_PERMANENT, ExtraordinaryEffect(EffectAbilityDecrease(ABILITY_STRENGTH, nDrain)), oTarget);
				SendMessageToPC(oTarget, GetName(oPossessor) + " touches you! Your muscles go slack, your strength failing.");
				ApplyEffectToObject( DURATION_TYPE_INSTANT, EffectVisualEffect( VFX_IMP_PULSE_NEGATIVE ), oTarget );
			//	}		
	 		}
		}
	
else if(FindSubString(GetTag(oPossessor), "_cr_un_shadow")!= -1)
	{SendMessageToAllDMs("Shadow");
	 if(GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
		{int nTouch = TouchAttackMelee(oTarget);
		 int nDrain = d6();
		
        //if(nTouch == 2) nDamage += d6();
		SendMessageToAllDMs("nDrain = " + IntToString(nDrain));
		if(nTouch)
			{if(nDrain >  GetAbilityScore(oTarget, ABILITY_STRENGTH) &&
				   !GetIsImmune(oTarget, IMMUNITY_TYPE_ABILITY_DECREASE))
					{ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oTarget);}
				else
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
				}
				ApplyEffectToObject(DURATION_TYPE_PERMANENT, ExtraordinaryEffect(EffectAbilityDecrease(ABILITY_STRENGTH, nDrain)), oTarget);
				SendMessageToPC(oTarget, GetName(oPossessor) + " touches you! Strength goes out of your limbs.");
				ApplyEffectToObject( DURATION_TYPE_INSTANT, EffectVisualEffect( VFX_IMP_PULSE_NEGATIVE ), oTarget );
			}		
	 	}
   }
 

}