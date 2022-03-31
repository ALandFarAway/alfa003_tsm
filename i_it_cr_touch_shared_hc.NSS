// ACR_TOUCH_ATTACK strings need to be put on the Creature.  Choose the OnHitCast Touch attack on the creature claw/bite item.

#include "x2_inc_spellhook"
#include "x2_inc_switches"
#include "acr_creature_i"
#include "NW_I0_SPELLS"
#include "acr_skills_i"



void main()
{   object oTarget = GetSpellTargetObject();
	SendMessageToAllDMs("On Hit Cast fired. OBJECT_SELF = " + GetName(OBJECT_SELF) + " hit " + GetTag(oTarget));
	
if(GetLocalString(OBJECT_SELF, "ACR_TOUCH_ATTACK") == "WRAITH")
	{SendMessageToAllDMs("Wraith");
	 if(GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
		{int nDamage = d4();
		 int nDrain = d6();
		 SendMessageToAllDMs("nDrain = " + IntToString(nDrain));
		 SendMessageToAllDMs("nDamage = " + IntToString(nDamage));
		 if(!FortitudeSave(oTarget, 14, SAVING_THROW_TYPE_NEGATIVE, OBJECT_SELF))
			{if(nDrain >  GetAbilityScore(oTarget, ABILITY_CONSTITUTION) &&
			 !GetIsImmune(oTarget, IMMUNITY_TYPE_ABILITY_DECREASE))
				{SendMessageToPC(oTarget, GetName(OBJECT_SELF) + " touches you! Exhaustion overwhelms you. Darkness closes in on your vision. You feel yourself falling, as you die.");
				 DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oTarget));
				 }
				else
				{if(!GetIsImmune(oTarget, IMMUNITY_TYPE_ABILITY_DECREASE))
					{effect eEffect = GetFirstEffect(oTarget);
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
				SendMessageToPC(oTarget, GetName(OBJECT_SELF) + " touches you! You feel exhaustion mounting, your stamina fading.");
				}
				ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectTemporaryHitpoints(5)), OBJECT_SELF);
				ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectAbilityDecrease(ABILITY_CONSTITUTION, nDrain)), oTarget);
				ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(nDamage), oTarget);
				ApplyEffectToObject( DURATION_TYPE_INSTANT, EffectVisualEffect( VFX_IMP_PULSE_NEGATIVE ), oTarget );
			}
		}
	}

else if(GetLocalString(OBJECT_SELF, "ACR_TOUCH_ATTACK") == "GHOST")
		{SendMessageToAllDMs("Ghost");
	     if(GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
			{int nDamage = d6();
			 int nDrain = d4();
			 int nLevel = GetTotalLevels(OBJECT_SELF, FALSE);
		     SendMessageToAllDMs("nDamage = " + IntToString(nDamage));
			 SendMessageToAllDMs("nDrain = " + IntToString(nDrain));
			
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
	   
				string sMessage = GetName(OBJECT_SELF) + " touches you!";
				string sMessageAbility;
				if(nAbility == 0) {sMessageAbility = "Your muscles go slack.";}
				else if(nAbility == 1) {sMessageAbility = "Your limbs freeze up.";}
				else if(nAbility == 2) {sMessageAbility = "Your feel faint.";}
				else if(nAbility == 3) {sMessageAbility = "Your mind dulls.";}
				else if(nAbility == 4) {sMessageAbility = "Your panic clouds your judgement.";}
				else if((nAbility == 5) && GetLevelByClass(CLASS_TYPE_BARD, oTarget)) {sMessageAbility = "Your voice stutters.";}
				else if(nAbility == 5) {sMessageAbility = "Your confidence fails.";}
				
				
				if(nDrain >  GetAbilityScore(oTarget, nAbility) &&
				   !GetIsImmune(oTarget, IMMUNITY_TYPE_ABILITY_DECREASE))
					{ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectParalyze(), oTarget, RoundsToSeconds(nLevel));}
				
				SendMessageToPC(oTarget, sMessage);
				SendMessageToPC(oTarget, sMessageAbility);
        		ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(5), OBJECT_SELF);
				ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectAbilityDecrease(nAbility, nDrain)), oTarget);
				ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(nDamage), oTarget);
				ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect( VFX_IMP_PULSE_NEGATIVE ), oTarget );
		}
	}
	
else if(GetLocalString(OBJECT_SELF, "ACR_TOUCH_ATTACK") == "ALLIP")
	{SendMessageToAllDMs("Allip");
	 if(GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
		{int nDrain = d4();
		 int nLevel = GetTotalLevels(OBJECT_SELF, FALSE);
		 SendMessageToAllDMs("nDrain = " + IntToString(nDrain));
		 if(nDrain >  GetAbilityScore(oTarget, ABILITY_WISDOM) &&
				   !GetIsImmune(oTarget, IMMUNITY_TYPE_ABILITY_DECREASE))
					{ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSleep(), oTarget, 18.0 + RoundsToSeconds(nLevel));
					 SendMessageToPC(oTarget, GetName(OBJECT_SELF) + " touches you! You feel safe, cozy, and so sleepy....");
					}
				else
				{if(!GetIsImmune(oTarget, IMMUNITY_TYPE_ABILITY_DECREASE))
					{effect eEffect = GetFirstEffect(oTarget);
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
				SendMessageToPC(oTarget, GetName(OBJECT_SELF) + " touches you! Panic clouds your judgement.");
				}
				ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectTemporaryHitpoints(5)), OBJECT_SELF);
				ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectAbilityDecrease(ABILITY_WISDOM, nDrain)), oTarget);
				ApplyEffectToObject( DURATION_TYPE_INSTANT, EffectVisualEffect( VFX_IMP_PULSE_NEGATIVE ), oTarget );
		}
	}
	 
else if(GetLocalString(OBJECT_SELF, "ACR_TOUCH_ATTACK") == "WISP")
		{SendMessageToAllDMs("Wisp");
	     if(GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
			{int nDamage = d8(2);
				ApplyEffectToObject( DURATION_TYPE_INSTANT, EffectDamage( nDamage, DAMAGE_TYPE_ELECTRICAL ), oTarget );
			     SendMessageToPC(oTarget, GetName(OBJECT_SELF) + " touches you! You feel a jolt run through your body");
				 ApplyEffectToObject( DURATION_TYPE_TEMPORARY, EffectBeam( VFX_BEAM_SHOCKING_GRASP, OBJECT_SELF, BODY_NODE_CHEST, FALSE ), oTarget, 1.0f );
			}
  		 }
    
   
else if(GetLocalString(OBJECT_SELF, "ACR_TOUCH_ATTACK") == "GREATER_SHADOW")
		{SendMessageToAllDMs("Greater Shadow");
	     if(GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
		   {int nDrain =  d8();
			SendMessageToAllDMs("nDrain = " + IntToString(nDrain));
			  
			if(nDrain >  GetAbilityScore(oTarget, ABILITY_STRENGTH) &&
				   !GetIsImmune(oTarget, IMMUNITY_TYPE_ABILITY_DECREASE))
					{SendMessageToPC(oTarget, GetName(OBJECT_SELF) + " touches you! Death closes over you as the last of your strength leaves your limbs.");
					 DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oTarget));
					 }
				else
				{if(!GetIsImmune(oTarget, IMMUNITY_TYPE_ABILITY_DECREASE))
					{effect eEffect = GetFirstEffect(oTarget);
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
				SendMessageToPC(oTarget, GetName(OBJECT_SELF) + " touches you! Your muscles go slack, your strength failing.");
				}
				ApplyEffectToObject(DURATION_TYPE_PERMANENT, ExtraordinaryEffect(EffectAbilityDecrease(ABILITY_STRENGTH, nDrain)), oTarget);
				ApplyEffectToObject( DURATION_TYPE_INSTANT, EffectVisualEffect( VFX_IMP_PULSE_NEGATIVE ), oTarget );
			}
		}
		
else if(GetLocalString(OBJECT_SELF, "ACR_TOUCH_ATTACK") == "CRIMSON_DEATH")
		{SendMessageToAllDMs("Crimson Death");
		 object oTarget = GetLocalObject(OBJECT_SELF, "oTarget");
		 if((oTarget != OBJECT_INVALID) && (oTarget != GetSpellTargetObject())) {
		 	SendMessageToPC(GetSpellTargetObject(), GetName(OBJECT_SELF) + " floats a tendril at you, but misses.");
			SendMessageToAllDMs(GetName(OBJECT_SELF) + " attacked " + GetName(GetSpellTargetObject()) + " but was engaged with " + GetName(oTarget) + " at the time. Touch attack truncated on " + GetName(GetSpellTargetObject()));
			return;
		 }
		 if(oTarget == OBJECT_INVALID) {
		 	oTarget = GetSpellTargetObject();
			SetLocalObject(OBJECT_SELF, "oTarget", oTarget);
		 	}
	     if(GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
			{int nDrain = d4(1);
			 if(nDrain >  GetAbilityScore(oTarget, ABILITY_CONSTITUTION) &&
			 !GetIsImmune(oTarget, IMMUNITY_TYPE_ABILITY_DECREASE))
				{SendMessageToPC(oTarget, GetName(OBJECT_SELF) + " touches you! You see the last of your blood rising out of you in a mist as you fall, drained and dead.");
				 DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oTarget));
				 }
			else
				{if(!GetIsImmune(oTarget, IMMUNITY_TYPE_ABILITY_DECREASE))
					{effect eEffect = GetFirstEffect(oTarget);
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
				}
					 
			 int nInc = GetLocalInt(OBJECT_SELF, "nInc");
			 if(nInc == 0) {	 
				 SendMessageToPC(oTarget, GetName(OBJECT_SELF) + " touches you! Wounds open on your skin and blood rises out of them into the crimson fog that surrounds you, reducing your stamina.");
				 SendMessageToAllDMs(GetName(OBJECT_SELF) + " touches " + GetName(oTarget) + "! Wounds open on the PC's skin and blood rises out of them, reducing the PC's stamina.");
				 ApplyEffectToObject(DURATION_TYPE_PERMANENT, ExtraordinaryEffect(EffectAbilityDecrease(ABILITY_CONSTITUTION, nDrain)), oTarget);
			 	 ApplyEffectToObject( DURATION_TYPE_INSTANT, EffectVisualEffect( VFX_IMP_PULSE_NEGATIVE ), oTarget );
				}
			 else if ((nInc > 0) && (nInc < 4)) {	
				 int nStrCD = GetAbilityModifier(ABILITY_STRENGTH, OBJECT_SELF);
				 int nStrPC = GetAbilityModifier(ABILITY_STRENGTH, oTarget);
				 int nBABCD = GetTRUEBaseAttackBonus(OBJECT_SELF);
				 int nBABPC = GetTRUEBaseAttackBonus(oTarget);
				 int nGrappleBonusCD = 11;
				 int nGrappleCD = d20(1);
				 int nGrapplePC = d20(1);
				
				 if((nInc > 1)&& (nGrappleCD + nStrCD + nBABCD + nGrappleBonusCD > nGrapplePC + nStrPC + nBABPC)) {
					effect eKnockdown = EffectKnockdown();
					ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnockdown, oTarget, 6.0);
					SendMessageToPC(oTarget, "You are lifted into the air by a telekinetic force!");
					SendMessageToAllDMs(GetName(OBJECT_SELF) + " lifts " + GetName(oTarget) + " telekinetically.");
					ClearAllActions(TRUE);
					ActionSpeakString(GetName(oTarget) + " is lifted into the air by foggy red tendrils.", TALKVOLUME_TALK);
					}
					
				if((GetIsSkillSuccessful(oTarget, 35, nGrappleCD + nStrCD + nBABCD + nGrappleBonusCD, FALSE)) || (nGrappleCD + nStrCD + nBABCD + nGrappleBonusCD < nGrapplePC + nStrPC + nBABPC)) {
					ClearAllActions(FALSE);
				    SetLocalInt(OBJECT_SELF, "nInc", 0);
				    SetLocalObject(OBJECT_SELF, "oTarget", OBJECT_INVALID);
		 	        SendMessageToPC(oTarget, "You break free of " + GetName(OBJECT_SELF) + ".");
					SendMessageToAllDMs(GetName(oTarget) + " breaks free of " + GetName(OBJECT_SELF) + ".");
					return;
					}
				 else {
					SendMessageToPC(oTarget, GetName(OBJECT_SELF) + " wraps you in tendrils of fog and continues to feed.");
					SendMessageToAllDMs(GetName(OBJECT_SELF) + " wraps " + GetName(oTarget) + " in tendrils of fog and continues to feed.");
					ApplyEffectToObject(DURATION_TYPE_PERMANENT, ExtraordinaryEffect(EffectAbilityDecrease(ABILITY_CONSTITUTION, nDrain)), oTarget);
			     	ApplyEffectToObject( DURATION_TYPE_INSTANT, EffectVisualEffect( VFX_IMP_PULSE_NEGATIVE ), oTarget );
		            ActionForceFollowObject(oTarget, 0.5);
					ActionWait(6.0);
					DelayCommand(6.0, ExecuteScript("acr_touchattack_wyn", OBJECT_SELF)); 
					}
				 }
				 
			if(nInc == 4) {
				 SetLocalInt(OBJECT_SELF, "nInc", 0);
				 SetLocalObject(OBJECT_SELF, "oTarget", OBJECT_INVALID);
		 	     SendMessageToPC(oTarget, "The " + GetName(OBJECT_SELF) + " looses you, temporarily sated.");
				 SendMessageToAllDMs(GetName(OBJECT_SELF) + " looses " + GetName(oTarget) + "temporarily sated.");
				 ClearAllActions(TRUE);
				 return;
				 }	
			else if(nInc < 4) {
				SetLocalInt(OBJECT_SELF, "nInc", nInc+1);
				}
			}
		}
  	
	
else if(GetLocalString(OBJECT_SELF, "ACR_TOUCH_ATTACK") == "BANSHEE")
	{SendMessageToAllDMs("Banshee");
	 if(GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
		{int nDrain = d4();
		 int nLevel = GetTotalLevels(OBJECT_SELF, FALSE);
		 SendMessageToAllDMs("nDrain = " + IntToString(nDrain));
		 if(nDrain >  GetAbilityScore(oTarget, ABILITY_CHARISMA) &&
				   !GetIsImmune(oTarget, IMMUNITY_TYPE_ABILITY_DECREASE))
					{ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectParalyze(), oTarget, RoundsToSeconds(nLevel));
					SendMessageToPC(oTarget, GetName(OBJECT_SELF) + " touches you! You are paralyzed with self-doubt, your muscles locking into place.");
					}
		 else
			{if(!GetIsImmune(oTarget, IMMUNITY_TYPE_ABILITY_DECREASE))
				{effect eEffect = GetFirstEffect(oTarget);
				 while(GetIsEffectValid(eEffect))
					{if(GetEffectSpellId(eEffect) == GetSpellId() &&
						GetEffectCreator(eEffect) == OBJECT_SELF)
							{
								nDrain += GetEffectInteger(eEffect, 1);
								RemoveEffect(oTarget, eEffect);
							}
							eEffect = GetNextEffect(oTarget);
						}
					}
				SendMessageToPC(oTarget, GetName(OBJECT_SELF) + " touches you! Your confidence falters.");
				}
				
				ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(5), OBJECT_SELF);
				ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectAbilityDecrease(ABILITY_CHARISMA, nDrain)), oTarget);
				ApplyEffectToObject( DURATION_TYPE_INSTANT, EffectVisualEffect( VFX_IMP_PULSE_NEGATIVE ), oTarget );
		}
	}
	
else if(GetLocalString(OBJECT_SELF, "ACR_TOUCH_ATTACK") == "EFFIGY")
	{SendMessageToAllDMs("Effigy");
	 if(GetObjectType(oTarget) == OBJECT_TYPE_CREATURE) {
		SendMessageToAllDMs("Will drain 2 levels from " + GetName(oTarget));
		SendMessageToPC(oTarget, GetName(OBJECT_SELF) + " touches you!");
		effect eNegative = EffectNegativeLevel(2, FALSE);
		if((!FortitudeSave(oTarget, 26, SAVING_THROW_TYPE_NEGATIVE, OBJECT_SELF)) 
		 && (!GetIsImmune(oTarget, IMMUNITY_TYPE_NEGATIVE_LEVEL))) {
		 	 if(GetTotalLevels(oTarget, FALSE) <= 2) {
				SendMessageToPC(oTarget, "You feel your life, the sum of all your experiences fading from memory as you die.");
				DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oTarget));
				}
			 else {
				 SendMessageToPC(oTarget, "You feel skills stemming from hard-won experience wiped from memory.");
				 }
		ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(10), OBJECT_SELF);
		ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(eNegative), oTarget);
		ApplyEffectToObject( DURATION_TYPE_INSTANT, EffectVisualEffect( VFX_IMP_PULSE_NEGATIVE ), oTarget );
		}	 
		else {SendMessageToPC(oTarget, "You feel your grasp of skills stemming from hard-won experience falter...then resurge undamaged.");}
		}
	}
	
else if(GetLocalString(OBJECT_SELF, "ACR_TOUCH_ATTACK") == "SIRINE")
	{SendMessageToAllDMs("Sirine");
	 if(GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
		{int nDrain = d4();
		 int nLevel = GetTotalLevels(OBJECT_SELF, FALSE);
		 SendMessageToAllDMs("nDrain = " + IntToString(nDrain));
		 if(nDrain >  GetAbilityScore(oTarget, ABILITY_INTELLIGENCE) &&
				   !GetIsImmune(oTarget, IMMUNITY_TYPE_ABILITY_DECREASE))
					{ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectStunned(), oTarget, RoundsToSeconds(nLevel));
					 SendMessageToPC(oTarget, GetName(OBJECT_SELF) + " touches you! Your mind dulls to the point that you can only stand there without conscious thought.");
					}
		 else
			{if(!GetIsImmune(oTarget, IMMUNITY_TYPE_ABILITY_DECREASE))
				{effect eEffect = GetFirstEffect(oTarget);
				 while(GetIsEffectValid(eEffect))
					{if(GetEffectSpellId(eEffect) == GetSpellId() &&
						GetEffectCreator(eEffect) == OBJECT_SELF)
							{
								nDrain += GetEffectInteger(eEffect, 1);
								RemoveEffect(oTarget, eEffect);
							}
							eEffect = GetNextEffect(oTarget);
						}
					}
				SendMessageToPC(oTarget, GetName(OBJECT_SELF) + " touches you! Your mind dulls.");
				}
				
				ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectAbilityDecrease(ABILITY_INTELLIGENCE, nDrain)), oTarget);
				ApplyEffectToObject( DURATION_TYPE_INSTANT, EffectVisualEffect( VFX_IMP_PULSE_NEGATIVE ), oTarget );
		}
	}
	
else if(GetLocalString(OBJECT_SELF, "ACR_TOUCH_ATTACK") == "CINDERSPAWN")
	{SendMessageToAllDMs("Cinderspawn");
	 if(GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
		{int nDrain = d6();
		int nLevel = GetTotalLevels(OBJECT_SELF, FALSE);
		SendMessageToAllDMs("nDrain = " + IntToString(nDrain));
		 if(!FortitudeSave(oTarget, 18, SAVING_THROW_TYPE_NEGATIVE, OBJECT_SELF))
			{if(nDrain >  GetAbilityScore(oTarget, ABILITY_CHARISMA) &&
			 !GetIsImmune(oTarget, IMMUNITY_TYPE_ABILITY_DECREASE))
				{ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectParalyze(), oTarget, RoundsToSeconds(nLevel));
				 SendMessageToPC(oTarget, GetName(OBJECT_SELF) + " touches you! You are paralyzed with self-doubt, your muscles locking into place.");
				}
				else
				{if(!GetIsImmune(oTarget, IMMUNITY_TYPE_ABILITY_DECREASE))
					{effect eEffect = GetFirstEffect(oTarget);
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
				SendMessageToPC(oTarget, GetName(OBJECT_SELF) + " touches you! Your confidence falters.");
				}
				ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(5), OBJECT_SELF);
				ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectAbilityDecrease(ABILITY_CHARISMA, nDrain)), oTarget);
				ApplyEffectToObject( DURATION_TYPE_INSTANT, EffectVisualEffect( VFX_IMP_PULSE_NEGATIVE ), oTarget );
			}
		}
	}
	
else if(GetLocalString(OBJECT_SELF, "ACR_TOUCH_ATTACK") == "BRIDGE_HAUNT")
		{SendMessageToAllDMs("Bridge Haunt");
	     if(GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
			{int nDamage = d6(3);
				ApplyEffectToObject( DURATION_TYPE_INSTANT, EffectDamage( nDamage, DAMAGE_TYPE_NEGATIVE ), oTarget );
			     SendMessageToPC(oTarget, GetName(OBJECT_SELF) + " touches you! You feel the chill of the grave.");
				 ApplyEffectToObject( DURATION_TYPE_TEMPORARY, EffectBeam( VFX_BEAM_BLACK, OBJECT_SELF, BODY_NODE_CHEST, FALSE ), oTarget, 1.0f );
			}
  		 }
else if(GetLocalString(OBJECT_SELF, "ACR_TOUCH_ATTACK") == "FOREST_HAUNT")
	{SendMessageToAllDMs("Forest Haunt");
	 if(GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
		{int nDrain = d4();
		 int nLevel = GetTotalLevels(OBJECT_SELF, FALSE);
		 SendMessageToAllDMs("nDrain = " + IntToString(nDrain));
		 if(nDrain >  GetAbilityScore(oTarget, ABILITY_CHARISMA) &&
				   !GetIsImmune(oTarget, IMMUNITY_TYPE_ABILITY_DECREASE))
					{ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectParalyze(), oTarget, RoundsToSeconds(nLevel));
					 SendMessageToPC(oTarget, GetName(OBJECT_SELF) + " touches you! You are paralyzed with self-doubt, your muscles locking into place.");
					}
		 else
			{if(!GetIsImmune(oTarget, IMMUNITY_TYPE_ABILITY_DECREASE))
				{effect eEffect = GetFirstEffect(oTarget);
				 while(GetIsEffectValid(eEffect))
					{if(GetEffectSpellId(eEffect) == GetSpellId() &&
						GetEffectCreator(eEffect) == OBJECT_SELF)
							{
								nDrain += GetEffectInteger(eEffect, 1);
								RemoveEffect(oTarget, eEffect);
							}
							eEffect = GetNextEffect(oTarget);
						}
					}
				SendMessageToPC(oTarget, GetName(OBJECT_SELF) + " touches you! Your confidence falters.");
				}
				
				ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectAbilityDecrease(ABILITY_CHARISMA, nDrain)), oTarget);
				ApplyEffectToObject( DURATION_TYPE_INSTANT, EffectVisualEffect( VFX_IMP_PULSE_NEGATIVE ), oTarget );
		}
	}
   
else if(GetLocalString(OBJECT_SELF, "ACR_TOUCH_ATTACK") == "TAUNTING_HAUNT")
	{SendMessageToAllDMs("Taunting Haunt");
	 if(GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
		{int nDrain = 1;
		 int nLevel = GetTotalLevels(OBJECT_SELF, FALSE);
		 SendMessageToAllDMs("nDrain = " + IntToString(nDrain));
		 if(nDrain >  GetAbilityScore(oTarget, ABILITY_CHARISMA) &&
				   !GetIsImmune(oTarget, IMMUNITY_TYPE_ABILITY_DECREASE))
					{ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectParalyze(), oTarget, RoundsToSeconds(nLevel));
					SendMessageToPC(oTarget, GetName(OBJECT_SELF) + " touches you! You are paralyzed with self-doubt, your muscles locking into place.");
					}
		 else
			{if(!GetIsImmune(oTarget, IMMUNITY_TYPE_ABILITY_DECREASE))
				{effect eEffect = GetFirstEffect(oTarget);
				 while(GetIsEffectValid(eEffect))
					{if(GetEffectSpellId(eEffect) == GetSpellId() &&
						GetEffectCreator(eEffect) == OBJECT_SELF)
							{
								nDrain += GetEffectInteger(eEffect, 1);
								RemoveEffect(oTarget, eEffect);
							}
							eEffect = GetNextEffect(oTarget);
						}
					}
				SendMessageToPC(oTarget, GetName(OBJECT_SELF) + " touches you! Your confidence falters.");
				}
				
				ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectAbilityDecrease(ABILITY_CHARISMA, nDrain)), oTarget);
				ApplyEffectToObject( DURATION_TYPE_INSTANT, EffectVisualEffect( VFX_IMP_PULSE_NEGATIVE ), oTarget );
		}
	}
}