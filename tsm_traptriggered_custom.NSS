//Custom Traps Triggered 
// Wynna 03/05/22

#include "acr_trigger_i"
#include "x0_i0_spells"
#include "acr_traps_i"

void main()
{
    ACR_TriggerOnTrapTriggered();
	SendMessageToAllDMs("traptriggered_custom called");
	
   	object oVictim = GetLocalObject(OBJECT_SELF, "oVictim");
	if(oVictim != OBJECT_INVALID) 
		{SendMessageToAllDMs("oVictim is Local Valid");
		 }
	else if(GetEnteringObject() != OBJECT_INVALID) 
		{oVictim = GetEnteringObject();
		 SendMessageToAllDMs("oVictim set to EnteringObject");
		 }
	else if(GetClickingObject() != OBJECT_INVALID) 
		{oVictim = GetClickingObject();
		 SendMessageToAllDMs("oVictim set to ClickingObject");
		 }
	else if(GetPlaceableLastClickedBy() != OBJECT_INVALID) 
		{oVictim = GetPlaceableLastClickedBy();
		 SendMessageToAllDMs("oVictim set to PlaceableLastClickedBy"); 
		}
	else {SendMessageToAllDMs("oVictim is Invalid");}
	

	
	if((GetIsPC(oVictim)) || (FindSubString(GetName(oVictim), "Bert") != -1)|| (FindSubString(GetName(oVictim), "Bell") != -1)|| (FindSubString(GetName(oVictim), "Nio") != -1)|| (FindSubString(GetName(oVictim), "Jhess") != -1)){
		string sPlaceableString=GetLocalString(OBJECT_SELF, "PLACEABLE_TAG");
		object oPlaceable = GetNearestObjectByTag(sPlaceableString, OBJECT_SELF,1);
	    string sEntered = GetLocalString(OBJECT_SELF, "MSG_ENTERED");
		string sDisarmFail = GetLocalString(OBJECT_SELF, "MSG_DISARM_FAIL");
		string sDmgSuccess=GetLocalString(OBJECT_SELF, "MSG_DMG_FAIL");
		string sDmgFail=GetLocalString(OBJECT_SELF, "MSG_DMG_SUCCEED");
			 
		int nReflexDC = GetLocalInt(OBJECT_SELF, "ACR_TRAP_SAVE_DC");
		int nDiceType = GetLocalInt(OBJECT_SELF, "ACR_TRAP_DICE_TYPE");
		int nDiceNumber = GetLocalInt(OBJECT_SELF, "ACR_TRAP_DICE_NUMBER");
		
		int nDamage;
		if(nDiceType == 4)
			{nDamage = d4(nDiceNumber);} 
		if(nDiceType == 6)
			{nDamage = d6(nDiceNumber);} 
		if(nDiceType == 8)
			{nDamage = d8(nDiceNumber);} 
		if(nDiceType == 10)
			{nDamage = d10(nDiceNumber);} 
		if(nDiceType == 12)
			{nDamage = d12(nDiceNumber);} 
		if(nDiceType == 20)
			{nDamage = d20(nDiceNumber);} 
		
		SendMessageToAllDMs(GetName(OBJECT_SELF) + " trap readiness is " + IntToString(GetLocalInt(OBJECT_SELF, "Trap_Readiness")));	
		//Trap readiness: 0 = Set and ready to spring; 1 = Unsprung and on a thirty minute delay timer; 2 = Sprung and on thirty minute reset timer;
		
		//Spike Traps
		if((FindSubString(GetTag(OBJECT_SELF), "003_trap_custom_spike") != -1) && (GetLocalInt(OBJECT_SELF, "Trap_Readiness") == 0))
			{SetLocalInt(OBJECT_SELF, "Trap_Readiness", 2);
			 SendMessageToAllDMs(GetName(oVictim) + " got: " + sDisarmFail + " from " + GetTag(OBJECT_SELF));
			 SendMessageToPC(oVictim, sDisarmFail);
			 DelayCommand(1800.0, SetLocalInt(OBJECT_SELF, "Trap_Readiness", 0));
			 effect eTrapDamage = EffectDamage(nDamage, DAMAGE_TYPE_PIERCING, DAMAGE_POWER_NORMAL, FALSE);
			 effect eKnockdown = EffectKnockdown();
			 AssignCommand(oPlaceable, ActionPlayAnimation(ANIMATION_PLACEABLE_OPEN, 1.0, 1.0));
			 oVictim = GetFirstObjectInShape(SHAPE_SPHERE, 2.0, GetLocation(OBJECT_SELF), FALSE, OBJECT_TYPE_CREATURE);
			 while(oVictim != OBJECT_INVALID) {
			 int nAC = GetAC(oVictim, 0);
			 int nAttack = d20() + 8;
			 if(nAttack < nAC) {
				 	SendMessageToPC(oVictim, sDmgSuccess);
					SendMessageToAllDMs("Spike trap fails attack on " + GetName(oVictim) + ". " + IntToString(nAttack) + " vs " + IntToString(nAC));
			 		}
			 else {
					//ApplyEffectToObject(DURATION_TYPE_INSTANT, eTrapDamage, oVictim); 
					SendMessageToPC(oVictim, sDmgFail);
					SendMessageToAllDMs("Spike trap hits " + GetName(oVictim) + ". " + IntToString(nAttack) + " vs " + IntToString(nAC));
			 		if(ReflexSave(oVictim, 20, SAVING_THROW_TYPE_TRAP, OBJECT_SELF) == 0) {
						ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnockdown, oVictim, 3.0);
					    SendMessageToAllDMs(GetName(oVictim) + " knocked down.");
			 		    }				  
					  }
				 oVictim = GetNextObjectInShape(SHAPE_SPHERE, 2.0, GetLocation(OBJECT_SELF), FALSE, OBJECT_TYPE_CREATURE);
				}
			if(FindSubString(GetName(OBJECT_SELF), "Locked") == -1) { 
				AssignCommand(oPlaceable, ActionPlayAnimation(ANIMATION_PLACEABLE_CLOSE, 1.0, 4.0));
			 	}
			else {SetLocalObject(OBJECT_SELF, "oCollision", CreateObject(OBJECT_TYPE_PLACEABLE, "plc_spike_trap_collision", GetLocation(OBJECT_SELF), FALSE));
				  DelayCommand(1800.0, DestroyObject(GetLocalObject(OBJECT_SELF, "oCollision")));
			      DelayCommand(1801.0, AssignCommand(oPlaceable, ActionPlayAnimation(ANIMATION_PLACEABLE_CLOSE, 1.0, 4.0)));
			 	
				}
			}
			
		//Snare Trap	
		if((GetTag(OBJECT_SELF) == "003_trap_custom_snare") && (GetLocalInt(OBJECT_SELF, "Trap_Readiness") == 0)) {
			object oMod = GetModule();
			effect eKnockdown = EffectKnockdown();
			effect eEntangle = EffectEntangle();
			if(GetIsSkillSuccessful(oVictim, SKILL_SEARCH, 23, TRUE)) {
				SendMessageToPC(oVictim, "You avoid a loop of creeping vine that seems positioned exactly to catch you around your ankle.");
			 	}
			else {
				SetLocalInt(OBJECT_SELF, "Trap_Readiness", 2);
				SendMessageToPC(oVictim, "A fibrous creeper suddenly snakes around your leg and tightens, threatening to jerk you off your feet.");
			 	if(GetAbilityModifier(ABILITY_STRENGTH, oVictim) + d20(1) > 22)  {
					SendMessageToPC(oVictim, "Your strength allows you to break free. The snare snaps, falling to the ground in pieces.");
			 		}
				else if (GetIsSkillSuccessful(oVictim, SKILL_ESCAPE_ARTIST, 23, FALSE)) {
					SendMessageToPC(oVictim, "Your skill as an escape artist allows you to wriggle out of the snare. It falls slack to the ground.");
			 		}
				else {
					SendMessageToPC(oVictim, "You are jerked off your feet and fall into the thorny creeper, entangled.");
			 		float fEntangle = 6.0;
					int nRep = 0;
					while((GetAbilityModifier(ABILITY_STRENGTH, oVictim) + d20(1) < 23) && (!GetIsSkillSuccessful(oVictim, SKILL_ESCAPE_ARTIST, 23, FALSE)) && (nRep < Random(10)))
						{fEntangle = fEntangle + 6.0;
						 //SendMessageToPC(oEnterer, IntToString(nRep) + " fEntangle = " + FloatToString(fEntangle));
						 nRep++;
						 }
					ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnockdown, oVictim, fEntangle);  
					SendMessageToPC(oVictim, "You think you will be able to work your way free in " + IntToString(FloatToInt(fEntangle)) +  " seconds.");
					ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEntangle, oVictim, fEntangle);  
					DelayCommand(fEntangle, RemoveEffect(oVictim, eEntangle));
					}
				}	          
			}		
	}	 
}