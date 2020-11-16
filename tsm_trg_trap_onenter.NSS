//Trap Trigger OnEnter. 
//Wynna November 2020


#include "silvy_univ_inc"
#include "silvy_univ_func"
#include "acr_trigger_i"
#include "acr_spawn_i"
#include "acr_tools_i"
#include "acr_quest_i"
 
void main()
{	
	ACR_TriggerOnEnter();
	object oMod = GetModule();
	object oEnterer = GetEnteringObject();
	effect eKnockdown = EffectKnockdown();
	effect eEntangle = EffectEntangle();
	
	if((GetTag(OBJECT_SELF) == "tsm_trap_snare") && (GetLocalInt(OBJECT_SELF, "Sprung") == 0)) {
		if(GetIsSkillSuccessful(oEnterer, SKILL_SEARCH, 23, TRUE)) {
			SendMessageToPC(oEnterer, "You avoid a loop of creeping vine that seems positioned exactly to catch you around your ankle.");
		 	}
		else {
			SetLocalInt(OBJECT_SELF, "Sprung", 1);
			SendMessageToPC(oEnterer, "A fibrous creeper suddenly snakes around your leg and tightens, threatening to jerk you off your feet.");
		 	if(GetAbilityModifier(ABILITY_STRENGTH, oEnterer) + d20(1) > 22)  {
				SendMessageToPC(oEnterer, "Your strength allows you to break free. The snare snaps, falling to the ground in pieces.");
		 		}
			else if (GetIsSkillSuccessful(oEnterer, SKILL_ESCAPE_ARTIST, 23, FALSE)) {
				SendMessageToPC(oEnterer, "Your skill as an escape artist allows you to wriggle out of the snare. It falls slack to the ground.");
		 		}
			else {
				SendMessageToPC(oEnterer, "You are jerked off your feet and fall into the thorny creeper, entangled.");
		 		float fEntangle = 6.0;
				int nRep = 0;
				while((GetAbilityModifier(ABILITY_STRENGTH, oEnterer) + d20(1) < 23) && (!GetIsSkillSuccessful(oEnterer, SKILL_ESCAPE_ARTIST, 23, FALSE)) && (nRep < Random(10)))
					{fEntangle = fEntangle + 6.0;
					 //SendMessageToPC(oEnterer, IntToString(nRep) + " fEntangle = " + FloatToString(fEntangle));
					 nRep++;
					 }
				ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnockdown, oEnterer, fEntangle);  
				SendMessageToPC(oEnterer, "You think you will be able to work your way free in " + IntToString(FloatToInt(fEntangle)) +  " seconds.");
				ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEntangle, oEnterer, fEntangle);  
				DelayCommand(fEntangle, RemoveEffect(oEnterer, eEntangle));
				}
			}	          
	}
   
}