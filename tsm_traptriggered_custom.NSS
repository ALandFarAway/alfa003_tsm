//Custom Traps Triggered 
// Wynna 03/05/22

#include "acr_trigger_i"
#include "x0_i0_spells"
#include "acr_traps_i"

void main()
{
    ACR_TriggerOnTrapTriggered();
	SendMessageToAllDMs("traptriggered_custom called");
	string sTrapPlc = GetLocalString(OBJECT_SELF, "TRAP_PLC_TAG");
	string sTrapTrg = GetLocalString(OBJECT_SELF, "TRAP_TRG_TAG");
	string sTrapWP = GetLocalString(OBJECT_SELF, "TRAP_WP_TAG");
	object oTrapPlc = GetNearestObjectByTag(sTrapPlc, OBJECT_SELF, 1);
	object oTrapTrg = GetNearestObjectByTag(sTrapTrg, OBJECT_SELF, 1);
	object oTrapWP = GetNearestObjectByTag(sTrapWP, OBJECT_SELF, 1);
	string sDmgFail=GetLocalString(oTrapTrg, "MSG_DMG_FAIL");
	string sDmgSuccess=GetLocalString(oTrapTrg, "MSG_DMG_SUCCEED");
			 
	int nReflexDC = GetLocalInt(oTrapTrg, "ACR_TRAP_SAVE_DC");
	int nDiceType = GetLocalInt(oTrapTrg, "ACR_TRAP_DICE_TYPE");
	int nDiceNumber = GetLocalInt(oTrapTrg, "ACR_TRAP_DICE_NUMBER");
	string sEntered = GetLocalString(oTrapTrg, "MSG_ENTER");
	string sDisarmFail = GetLocalString(oTrapTrg, "MSG_DISARM_FAIL");
	string sSprung = sDisarmFail;
			
   	object oVictim = GetLocalObject(OBJECT_SELF, "oVictim");
	if(oVictim != OBJECT_INVALID) 
		{SendMessageToAllDMs("oVictim is Local Valid");
		 }
	else if(GetEnteringObject() != OBJECT_INVALID) 
		{oVictim = GetEnteringObject();
		 SendMessageToAllDMs("oVictim set to EnteringObject " + GetName(oVictim));
		 sSprung = sEntered;
		 SendMessageToAllDMs("sSprung set to " + sSprung);
		}
	else if(GetClickingObject() != OBJECT_INVALID) 
		{oVictim = GetClickingObject();
		 SendMessageToAllDMs("oVictim set to ClickingObject " + GetName(oVictim));
		 }
	else if(GetPlaceableLastClickedBy() != OBJECT_INVALID) 
		{oVictim = GetPlaceableLastClickedBy();
		 SendMessageToAllDMs("oVictim set to PlaceableLastClickedBy " + GetName(oVictim)); 
		}
	else {SendMessageToAllDMs("oVictim is Invalid");}
	

	
	if((GetIsPC(oVictim)) || (FindSubString(GetName(oVictim), "Bert") != -1)|| (FindSubString(GetName(oVictim), "Bae") != -1)|| (FindSubString(GetName(oVictim), "Bell") != -1)|| (FindSubString(GetName(oVictim), "Nio") != -1)|| (FindSubString(GetName(oVictim), "Jhess") != -1)){
		
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
			 SendMessageToAllDMs(GetName(oVictim) + " got: " + sSprung + " from " + GetTag(OBJECT_SELF));
			 SendMessageToPC(oVictim, sSprung);
			 DestroyObject(oTrapPlc);
   			 DestroyObject(oTrapTrg);
   			 DelayCommand(1800.0, SetLocalInt(OBJECT_SELF, "Trap_Readiness", 0));
			 effect eTrapDamage = EffectDamage(nDamage, DAMAGE_TYPE_PIERCING, DAMAGE_POWER_NORMAL, FALSE);
			 effect eKnockdown = EffectKnockdown();
			 AssignCommand(oTrapPlc, ActionPlayAnimation(ANIMATION_PLACEABLE_OPEN, 1.0, 1.0));
			 object oVictimDmg = GetFirstObjectInShape(SHAPE_SPHERE, 5.0, GetLocation(oTrapWP), FALSE, OBJECT_TYPE_CREATURE);
			 while((oVictimDmg != OBJECT_INVALID) && (GetLastAttacker(oVictimDmg) != OBJECT_SELF))  {
			 float fDistance = GetDistanceBetween(oTrapWP, oVictimDmg);
			 int nAC = GetAC(oVictimDmg, 0);
			 int nAttack = d20() + 8;
			 if(nAttack < nAC) {
				 	SendMessageToPC(oVictimDmg, sDmgSuccess);
					SendMessageToAllDMs("Spike trap fails attack on " + GetName(oVictimDmg) + " at " + FloatToString(fDistance) + " distance. " + IntToString(nAttack) + " vs " + IntToString(nAC));
			 		}
			 else {
					SendMessageToPC(oVictimDmg, sDmgFail);
					SendMessageToAllDMs("Spike trap hits " + GetName(oVictimDmg) + " at " + FloatToString(fDistance) + " distance for " + IntToString(nDamage) + ". " + IntToString(nAttack) + " vs " + IntToString(nAC));
			 		ApplyEffectToObject(DURATION_TYPE_INSTANT, eTrapDamage, oVictimDmg); 
					if(ReflexSave(oVictimDmg, 20, SAVING_THROW_TYPE_TRAP, OBJECT_SELF) == 0) {
						ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnockdown, oVictimDmg, 3.0);
					    SendMessageToAllDMs(GetName(oVictimDmg) + " knocked down.");
			 		    }				  
					  }
				 oVictimDmg = GetNextObjectInShape(SHAPE_SPHERE, 5.0, GetLocation(oTrapWP), FALSE, OBJECT_TYPE_CREATURE);
				}
			if(FindSubString(GetName(OBJECT_SELF), "Locked") != -1) { 
				  SetLocalObject(OBJECT_SELF, "oCollision", CreateObject(OBJECT_TYPE_PLACEABLE, "003_trap_custom_spike_closed_plc", GetLocation(OBJECT_SELF), FALSE));
				  DelayCommand(1800.0, DestroyObject(GetLocalObject(OBJECT_SELF, "oCollision")));
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