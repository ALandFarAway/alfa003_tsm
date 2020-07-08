//Circus Trigger OnEnter. All triggers.
//Wynna May 2015


#include "acr_trigger_i"
#include "acr_spawn_i"
#include "acr_tools_i"
#include "acr_quest_i"
#include "acr_hazards_i"

void main()
{	
	ACR_TriggerOnEnter();
	object oPC = GetEnteringObject();
    
		  

		
		//Dex Checks for PCs on beam	 
	if((GetTag(OBJECT_SELF) == "ruin_beam_trg") && ((GetIsPC(oPC)) || (GetIsDMPossessed(oPC))))
		{location lFallBreak=GetLocation(GetWaypointByTag("ruin_beam_fall_break_wp"));
		 location lFall=GetLocation(GetWaypointByTag("ruin_beam_fall_wp"));
		 effect eKnockdown=EffectKnockdown();
		 effect eFallingDamage=EffectDamage(Random(10), DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_NORMAL, FALSE); 
		SendMessageToPC(oPC, "It would be easy to fall from this beam!");
		 int nDexCheck = Random(21) + (GetAbilityModifier(ABILITY_DEXTERITY, oPC)) + (GetSkillRank(SKILL_BALANCE, oPC, FALSE));
		 if (nDexCheck >= 10)
		 	{SendMessageToPC(oPC, "The beam shifts but you maintain your balance!");}
		 else
		 	{if(ReflexSave(oPC, 15, SAVING_THROW_TYPE_NONE, OBJECT_SELF))
				{SendMessageToPC(oPC, "You start to fall, but catch yourself!");}
			 else
			 	{SendMessageToPC(oPC, "You are falling!");
				 DelayCommand(1.0, ACR_FallToLocation(oPC, 16, lFallBreak, FALSE, -1, 1));
				 DelayCommand(2.0, ACR_FallToLocation(oPC, 16, lFall, FALSE, -1, -1));
				 DelayCommand(2.0, SendMessageToPC(oPC, "You catch yourself on a narrow, rocky ledge and roll the rest of the way down."));
				 DelayCommand(3.5, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnockdown, oPC, 5.0));
				 DelayCommand(3.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFallingDamage, oPC));
				 }
			}
		}	
		
}