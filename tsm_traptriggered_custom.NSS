//Custom Traps Triggered 
// Wynna 03/05/22

#include "acr_trigger_i"
#include "x0_i0_spells"
#include "acr_traps_i"



void ActionCreateCreature(string sCreature, location lLocPlace)
{
    CreateObject(OBJECT_TYPE_CREATURE, sCreature, lLocPlace, FALSE);
}

void main()
{if(FindSubString(GetName(GetEnteringObject()), "Ghost") == -1) {
    ACR_TriggerOnTrapTriggered();
	SendMessageToAllDMs("traptriggered_custom called");
	string sTrapPlc = GetLocalString(OBJECT_SELF, "TRAP_PLC_TAG");
	string sTrapTrg = GetLocalString(OBJECT_SELF, "TRAP_TRG_TAG");
	string sTrapDoor = GetLocalString(OBJECT_SELF, "TRAP_DOOR_TAG");
	string sTrapWP = GetLocalString(OBJECT_SELF, "TRAP_WP_TAG");
	object oTrapPlc = GetNearestObjectByTag(sTrapPlc, OBJECT_SELF, 1);
	if(GetObjectType(OBJECT_SELF) == OBJECT_TYPE_PLACEABLE) {oTrapPlc = OBJECT_SELF;}
	object oTrapTrg = GetNearestObjectByTag(sTrapTrg, OBJECT_SELF, 1);
	if(GetObjectType(OBJECT_SELF) == OBJECT_TYPE_TRIGGER) {oTrapTrg = OBJECT_SELF;}
	object oTrapWP = GetNearestObjectByTag(sTrapWP, OBJECT_SELF, 1);
	object oTrapDoor = GetNearestObjectByTag(sTrapDoor, OBJECT_SELF, 1);
	string sTrapSafetyWP = GetLocalString(OBJECT_SELF, "TRAP_SAFETY_WP_TAG");
	object oTrapSafetyWP = GetNearestObjectByTag(sTrapSafetyWP, OBJECT_SELF, 1);
	string sDmgFail=GetLocalString(OBJECT_SELF, "MSG_DMG_FAIL");
	string sDmgSuccess=GetLocalString(OBJECT_SELF, "MSG_DMG_SUCCEED");
	int nBlocking = GetLocalInt(OBJECT_SELF, "TRAP_BLOCKING");
	int nReflexDC = GetLocalInt(OBJECT_SELF, "ACR_TRAP_SAVE_DC");
	int nDiceType = GetLocalInt(OBJECT_SELF, "ACR_TRAP_DICE_TYPE");
	int nDiceNumber = GetLocalInt(OBJECT_SELF, "ACR_TRAP_DICE_NUMBER");
	string sEntered = GetLocalString(oTrapTrg, "MSG_ENTER");
	string sDisarmFail = GetLocalString(OBJECT_SELF, "MSG_DISARM_FAIL");
	string sSprung = sDisarmFail;
			
   	object oVictim = GetEnteringObject();
	if(GetObjectType(OBJECT_SELF) == OBJECT_TYPE_TRIGGER)
		{sSprung = sEntered;}
	else if(GetObjectType(OBJECT_SELF) == OBJECT_TYPE_PLACEABLE)
		{sSprung = sDisarmFail;}
	
	//SendMessageToAllDMs("sSprung set to " + sSprung);
	SendMessageToAllDMs(GetName(oVictim) + " is oVictim");

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
		
		
		
		//Axe Traps
		
		if((GetTag(OBJECT_SELF)== "003_trap_custom_axe_on") && (GetLocalInt(OBJECT_SELF, "Trap_Readiness") == 2))
			{SendMessageToAllDMs(GetName(oVictim) + " entered axe sweep area of " + GetName(OBJECT_SELF));
			 effect eTrapDamage = EffectDamage(nDamage, DAMAGE_TYPE_SLASHING, DAMAGE_POWER_NORMAL, FALSE);
			 effect eKnockdown = EffectKnockdown();
			 object oVictimDmg = GetFirstObjectInShape(SHAPE_CUBE, 3.0, GetLocation(oTrapWP), FALSE, OBJECT_TYPE_CREATURE);
			 int nInc;
			 for(nInc = 0; nInc < 20; nInc ++)  {
			 oTrapSafetyWP = GetNearestObjectByTag(sTrapSafetyWP, oVictimDmg, 1);
			 float fDistance = GetDistanceBetween(oTrapWP, oVictimDmg);
			 int nAC = GetAC(oVictimDmg, 0);
			 int nAttack = d20() + 8;
			 if(GetLocalInt(OBJECT_SELF, GetName(oVictimDmg)) != 1) {
				 if(nAttack < nAC) {
						 	SendMessageToPC(oVictimDmg, sDmgSuccess);
							SendMessageToAllDMs(GetName(OBJECT_SELF) + " fails attack on " + GetName(oVictimDmg) + " at " + FloatToString(fDistance) + " distance. " + IntToString(nAttack) + " vs " + IntToString(nAC));
					 		AssignCommand(oVictimDmg, ActionJumpToLocation(GetLocation(oTrapSafetyWP)));
							}
					 else if((GetRacialType(oVictimDmg) == RACIAL_TYPE_INCORPOREAL) || (GetSubRace(oVictimDmg) == RACIAL_SUBTYPE_INCORPOREAL)) {
					 		  SendMessageToAllDMs(GetName(OBJECT_SELF) + " skips attack on " + GetName(oVictimDmg) + " at " + FloatToString(fDistance) + " distance. " + IntToString(nAttack) + " vs " + IntToString(nAC));
					 		}
					 else {
							SendMessageToPC(oVictimDmg, sDmgFail);
							SendMessageToAllDMs(GetName(OBJECT_SELF) + " hits " + GetName(oVictimDmg) + " at " + FloatToString(fDistance) + " distance for " + IntToString(nDamage) + ". " + IntToString(nAttack) + " vs " + IntToString(nAC));
					 		ApplyEffectToObject(DURATION_TYPE_INSTANT, eTrapDamage, oVictimDmg); 
							AssignCommand(oVictimDmg, ActionJumpToLocation(GetLocation(oTrapSafetyWP)));
							if(ReflexSave(oVictimDmg, nReflexDC, SAVING_THROW_TYPE_TRAP, OBJECT_SELF) == 0) {
								ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnockdown, oVictimDmg, 6.0);
							    SendMessageToAllDMs(GetName(oVictimDmg) + " knocked down.");
					 		    }				  
						  }
						  
					 SetLocalInt(OBJECT_SELF, GetName(oVictimDmg), 1);
					 }
			 oVictimDmg = GetNextObjectInShape(SHAPE_CUBE, 3.0, GetLocation(oTrapWP), FALSE, OBJECT_TYPE_CREATURE);
			 SendMessageToAllDMs(GetName(oVictimDmg) + " is name oVictimDmg");
			 if(oVictimDmg == OBJECT_INVALID) {break;}
			 }
			}
			
			
		if((GetTag(OBJECT_SELF)== "003_trap_custom_axe_major") && (GetLocalInt(OBJECT_SELF, "Trap_Readiness") == 0))
			{sTrapTrg = GetLocalString(OBJECT_SELF, "TRAP_TRG_TAG");
			 oTrapTrg = GetNearestObjectByTag(sTrapTrg, OBJECT_SELF, 1);
	 		 SetLocalInt(oTrapTrg, "Trap_Readiness", 2);
			 SetLocalInt(OBJECT_SELF, "Trap_Readiness", 2);
			 SendMessageToAllDMs(GetName(oVictim) + " got: " + sSprung + " from " + GetName(OBJECT_SELF));
			 SendMessageToPC(oVictim, sSprung);
			 DelayCommand(1800.0, SetLocalInt(oTrapTrg, "Trap_Readiness", 0));
			 effect eTrapDamage = EffectDamage(nDamage, DAMAGE_TYPE_SLASHING, DAMAGE_POWER_NORMAL, FALSE);
			 effect eKnockdown = EffectKnockdown();
			 //AssignCommand(oTrapPlc, ActionPlayAnimation(ANIMATION_PLACEABLE_OPEN, 1.0, 4.0));
			 if(GetLocalInt(OBJECT_SELF, "Create") !=1) {
			 	object oTrapPlc = CreateObject(OBJECT_TYPE_PLACEABLE, "003_trap_custom_axe_major_plc", GetLocation(oTrapWP), FALSE);
			 	SetLocalInt(OBJECT_SELF, "Create", 1);
				}
			 DestroyObject(oTrapPlc, 1800.0); 
			 object oVictimDmg = GetFirstObjectInShape(SHAPE_CUBE, 3.0, GetLocation(oTrapWP), FALSE, OBJECT_TYPE_CREATURE);
			 int nInc;
			 for(nInc = 0; nInc < 20; nInc ++)  {
			 oTrapSafetyWP = GetNearestObjectByTag(sTrapSafetyWP, oVictimDmg, 1);
			 float fDistance = GetDistanceBetween(oTrapWP, oVictimDmg);
			 int nAC = GetAC(oVictimDmg, 0);
			 int nAttack = d20() + 8;
			 if(GetLocalInt(OBJECT_SELF, GetName(oVictimDmg)) != 1) {
				 if(nAttack < nAC) {
						 	SendMessageToPC(oVictimDmg, sDmgSuccess);
							SendMessageToAllDMs(GetName(OBJECT_SELF) + " fails attack on " + GetName(oVictimDmg) + " at " + FloatToString(fDistance) + " distance. " + IntToString(nAttack) + " vs " + IntToString(nAC));
					 		AssignCommand(oVictimDmg, ActionJumpToLocation(GetLocation(oTrapSafetyWP)));
							}
					 else if((GetRacialType(oVictimDmg) == RACIAL_TYPE_INCORPOREAL) || (GetSubRace(oVictimDmg) == RACIAL_SUBTYPE_INCORPOREAL)) {
					 		  SendMessageToAllDMs(GetName(OBJECT_SELF) + " skips attack on " + GetName(oVictimDmg) + " at " + FloatToString(fDistance) + " distance. " + IntToString(nAttack) + " vs " + IntToString(nAC));
					 		}
					 else {
							SendMessageToPC(oVictimDmg, sDmgFail);
							SendMessageToAllDMs(GetName(OBJECT_SELF) + " hits " + GetName(oVictimDmg) + " at " + FloatToString(fDistance) + " distance for " + IntToString(nDamage) + ". " + IntToString(nAttack) + " vs " + IntToString(nAC));
					 		ApplyEffectToObject(DURATION_TYPE_INSTANT, eTrapDamage, oVictimDmg); 
							AssignCommand(oVictimDmg, ActionJumpToLocation(GetLocation(oTrapSafetyWP)));
							if(ReflexSave(oVictimDmg, nReflexDC, SAVING_THROW_TYPE_TRAP, OBJECT_SELF) == 0) {
								ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnockdown, oVictimDmg, 6.0);
							    SendMessageToAllDMs(GetName(oVictimDmg) + " knocked down.");
					 		    }				  
						  }
						  
					 SetLocalInt(OBJECT_SELF, GetName(oVictimDmg), 1);
					 }
			 oVictimDmg = GetNextObjectInShape(SHAPE_CUBE, 3.0, GetLocation(oTrapWP), FALSE, OBJECT_TYPE_CREATURE);
			 SendMessageToAllDMs(GetName(oVictimDmg) + " is name oVictimDmg");
			 if(oVictimDmg == OBJECT_INVALID) {break;}
			 }
				
			 DestroyObject(OBJECT_SELF, 6.0);		
			}
		
			
		//Spike Traps
		if((FindSubString(GetTag(OBJECT_SELF), "003_trap_custom_spike") != -1) && (GetLocalInt(OBJECT_SELF, "Trap_Readiness") == 0))
			{SetLocalInt(OBJECT_SELF, "Trap_Readiness", 2);
			 SendMessageToAllDMs(GetName(oVictim) + " got: " + sSprung + " from " + GetName(OBJECT_SELF));
			 SendMessageToPC(oVictim, sSprung);
			 DelayCommand(1800.0, SetLocalInt(OBJECT_SELF, "Trap_Readiness", 0));
			 effect eTrapDamage = EffectDamage(nDamage, DAMAGE_TYPE_PIERCING, DAMAGE_POWER_NORMAL, FALSE);
			 effect eKnockdown = EffectKnockdown();
			 AssignCommand(oTrapPlc, ActionPlayAnimation(ANIMATION_PLACEABLE_OPEN, 1.0, 4.0));
			 object oVictimDmg = GetFirstObjectInShape(SHAPE_CUBE, 2.5, GetLocation(oTrapWP), FALSE, OBJECT_TYPE_CREATURE);
			 int nInc;
			 for(nInc = 0; nInc < 20; nInc ++)  {
			 oTrapSafetyWP = GetNearestObjectByTag(sTrapSafetyWP, oVictimDmg, 1);
			 float fDistance = GetDistanceBetween(oTrapWP, oVictimDmg);
			 int nAC = GetAC(oVictimDmg, 0);
			 int nAttack = d20() + 8;
			 if(GetLocalInt(OBJECT_SELF, GetName(oVictimDmg)) != 1) {
				 if(nAttack < nAC) {
						 	SendMessageToPC(oVictimDmg, sDmgSuccess);
							SendMessageToAllDMs(GetName(OBJECT_SELF) + " fails attack on " + GetName(oVictimDmg) + " at " + FloatToString(fDistance) + " distance. " + IntToString(nAttack) + " vs " + IntToString(nAC));
					 		AssignCommand(oVictimDmg, ActionJumpToLocation(GetLocation(oTrapSafetyWP)));
							}
					 else if((GetRacialType(oVictimDmg) == RACIAL_TYPE_INCORPOREAL) || (GetSubRace(oVictimDmg) == RACIAL_SUBTYPE_INCORPOREAL)) {
					 		  SendMessageToAllDMs(GetName(OBJECT_SELF) + " skips attack on " + GetName(oVictimDmg) + " at " + FloatToString(fDistance) + " distance. " + IntToString(nAttack) + " vs " + IntToString(nAC));
					 		}
					 else {
							SendMessageToPC(oVictimDmg, sDmgFail);
							SendMessageToAllDMs(GetName(OBJECT_SELF) + " hits " + GetName(oVictimDmg) + " at " + FloatToString(fDistance) + " distance for " + IntToString(nDamage) + ". " + IntToString(nAttack) + " vs " + IntToString(nAC));
					 		ApplyEffectToObject(DURATION_TYPE_INSTANT, eTrapDamage, oVictimDmg); 
							AssignCommand(oVictimDmg, ActionJumpToLocation(GetLocation(oTrapSafetyWP)));
							if(ReflexSave(oVictimDmg, nReflexDC, SAVING_THROW_TYPE_TRAP, OBJECT_SELF) == 0) {
								ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnockdown, oVictimDmg, 30.0);
							    SendMessageToAllDMs(GetName(oVictimDmg) + " knocked down.");
					 		    }				  
						  }
						  
					 SetLocalInt(OBJECT_SELF, GetName(oVictimDmg), 1);
					 }
			 oVictimDmg = GetNextObjectInShape(SHAPE_CUBE, 2.5, GetLocation(oTrapWP), FALSE, OBJECT_TYPE_CREATURE);
			 SendMessageToAllDMs(GetName(oVictimDmg) + " is name oVictimDmg");
			 if(oVictimDmg == OBJECT_INVALID) {break;}
			 }
				
			 DestroyObject(oTrapPlc, 2.0);
   			 DestroyObject(oTrapTrg, 2.0);
   			 	
			 if(nBlocking == 1) { 
			 	SendMessageToAllDMs("Locking Found");
				CreateObject(OBJECT_TYPE_PLACEABLE, "003_trap_custom_spike_closed_plc", GetLocation(oTrapPlc), FALSE);
				}	
			}
			
		//Pit Trap	
		 if((GetTag(OBJECT_SELF) == "tsm_trigger_pit_trap") && ((GetIsPC(oVictim)) || (GetIsDMPossessed(oVictim))))
			{string sMessage=GetLocalString(OBJECT_SELF, "ACR_MESSAGE");
			 string sSpeak=GetLocalString(OBJECT_SELF, "ACR_SPEAK");
			 string sJumpTo = GetLocalString(OBJECT_SELF, "ACR_WP_JUMP_TO");
			 object oJumpTo = GetWaypointByTag(sJumpTo);
			 int nDC = GetLocalInt(OBJECT_SELF, "ACR_REFLEX_DC");
			 float fFall = GetLocalFloat(OBJECT_SELF, "ACR_FALL_HEIGHT")/10;
			 int nFallRounded = FloatToInt(fFall);
			 effect eFallDmg = EffectDamage(d6(nFallRounded), DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_NORMAL, FALSE);  
			 string sPLCDestroy = GetLocalString(OBJECT_SELF, "ACR_DESTROY_PLC");
			 string sPLCDestroyB = GetLocalString(OBJECT_SELF, "ACR_DESTROY_PLC_B");
			 string sPLCDestroyC = GetLocalString(OBJECT_SELF, "ACR_DESTROY_PLC_C");
			 string sPLCDestroyD = GetLocalString(OBJECT_SELF, "ACR_DESTROY_PLC_D");
			 object oPLCDestroy = GetNearestObjectByTag(sPLCDestroy, OBJECT_SELF, 1);
			 object oPLCDestroyB = GetNearestObjectByTag(sPLCDestroyB, OBJECT_SELF, 1);
			 object oPLCDestroyC = GetNearestObjectByTag(sPLCDestroyC, OBJECT_SELF, 1);
			 object oPLCDestroyD = GetNearestObjectByTag(sPLCDestroyD, OBJECT_SELF, 1);
			 string sGender = "her";
			 if(GetGender(oVictim) == GENDER_MALE) {sGender = "him";}
			 string sSpawn = GetLocalString(OBJECT_SELF, "ACR_SPAWN_CREATURE");
			 string sSpawnWP = GetLocalString(OBJECT_SELF, "ACR_SPAWN_WP");
			 object oSpawnWP = GetWaypointByTag(sSpawnWP);
			 float fDelaySpawnOne = GetLocalFloat(OBJECT_SELF, "ACR_SPAWN_DELAY");
			 float fDelayVFXOne = GetLocalFloat(OBJECT_SELF, "ACR_VFX_DELAY");
			 int nVFX = GetLocalInt(OBJECT_SELF, "ACR_SPAWN_VFX");
			 effect eOne = EffectVisualEffect(nVFX);
		     int nDurationType = GetLocalInt(OBJECT_SELF, "ACR_SPAWN_VFX_DUR_TYPE");
		     float fDurationLength = GetLocalFloat(OBJECT_SELF, "ACR_SPAWN_VFX_LENGTH");
			 int nFlying = GetLocalInt(oVictim, "ACR_CREATURE_FLYING");
			 int nIncorporeal = GetLocalInt(oVictim, "X2_L_IS_INCORPOREAL");
			 int nRunOnce = GetLocalInt(OBJECT_SELF, "RUN_ONCE");
		      
			 if((nRunOnce == 0) && (oPLCDestroy != OBJECT_INVALID) && (nFlying == 0) && (nIncorporeal == 0)) {
			 	 SetLocalInt(OBJECT_SELF, "RUN_ONCE", 1);
				 AssignCommand(oPLCDestroy, ActionSpeakString(sSpeak, TALKVOLUME_TALK));
				 SendMessageToAllDMs(GetName(oVictim) + " triggered " + GetName(OBJECT_SELF));
				 SendMessageToPC(oVictim, sMessage);
				 ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SCREEN_SHAKE), oVictim);
	             AssignCommand(oVictim, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_BACK, 1.0, 5.0));
				 ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_SPELL_HIT_EARTHQUAKE), oVictim, 5.0);
				 DestroyObject(oPLCDestroy, 2.0);
				 DestroyObject(oPLCDestroyB, 2.0);
				 DestroyObject(oPLCDestroyC, 2.0);
				 DestroyObject(oPLCDestroyD, 2.0);
				 if(ReflexSave(oVictim, nDC, SAVING_THROW_TYPE_TRAP, OBJECT_SELF) < 1) { 
			 		DelayCommand(3.0, SendMessageToPC(oVictim, "You are falling!"));
					DelayCommand(3.1, AssignCommand(oVictim, ActionSpeakString("*" + GetName(oVictim) + " is unable to save " + sGender + "self from falling!", TALKVOLUME_TALK)));
				    DelayCommand(4.0, AssignCommand(oVictim, ActionJumpToObject(oJumpTo, FALSE)));
					DelayCommand(4.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFallDmg, oVictim)); 
					if(sSpawn != "") {
						DelayCommand(fDelaySpawnOne - 5.0, SendMessageToPC(oVictim, "Something stirs down here in the pit with you."));
						DelayCommand(fDelaySpawnOne, ActionCreateCreature(sSpawn, GetLocation(oSpawnWP)));
						}
					}
				else {DelayCommand(3.0, SendMessageToPC(oVictim, "You stop yourself in time from falling."));
					  DelayCommand(3.1, AssignCommand(oVictim, ActionSpeakString("*" + GetName(oVictim) + " stops " + sGender + "self from falling.", TALKVOLUME_TALK)));
				     }
				 }  
			}
		   
			//Poison Gas Trap
			if((GetTag(OBJECT_SELF) == "rr_door_ritual_plc") && (GetLocalInt(OBJECT_SELF, "Trap_Readiness") == 0)) {
			 SetLocalInt(OBJECT_SELF, "Trap_Readiness", 2);
			 SendMessageToAllDMs(GetName(oVictim) + " got: " + sSprung + " from " + GetName(OBJECT_SELF));
			 SendMessageToPC(oVictim, sSprung);
			 DelayCommand(1800.0, SetLocalInt(OBJECT_SELF, "Trap_Readiness", 0));
			 effect eTrapDamage = EffectDamage(nDamage, DAMAGE_TYPE_ACID, DAMAGE_POWER_NORMAL, FALSE);
			 AssignCommand(oTrapPlc, ActionSpeakString("*Slides down out of the way, revealing a hallway beyond. The noise of chanting swelling to a triumphant finish is suddenly audible." , TALKVOLUME_TALK));
			 effect eGas = EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_ACID, FALSE);
			 ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGas, oVictim, 3.0);
			 object oVictimDmg = GetFirstObjectInShape(SHAPE_SPHERE, 5.0, GetLocation(oTrapWP), FALSE, OBJECT_TYPE_CREATURE);
			 int nInc;
			 for(nInc = 0; nInc < 20; nInc ++)  {
			 oTrapSafetyWP = GetNearestObjectByTag(sTrapSafetyWP, oVictimDmg, 1);
			 float fDistance = GetDistanceBetween(oTrapWP, oVictimDmg);
			 if(GetLocalInt(OBJECT_SELF, GetName(oVictimDmg)) != 1) {
				 if(ReflexSave(oVictimDmg, nReflexDC, SAVING_THROW_TYPE_ACID, OBJECT_SELF) != 0) {
						 	SendMessageToPC(oVictimDmg, sDmgSuccess);
							SendMessageToAllDMs(GetName(oVictimDmg) + " succeeds on reflex against " + GetName(OBJECT_SELF) + " at " + FloatToString(fDistance) + " distance against " + IntToString(nReflexDC));
					 		AssignCommand(oVictimDmg, ActionJumpToLocation(GetLocation(oTrapSafetyWP)));
							}
					 else if((GetRacialType(oVictimDmg) == RACIAL_TYPE_INCORPOREAL) || (GetSubRace(oVictimDmg) == RACIAL_SUBTYPE_INCORPOREAL)) {
					 		  SendMessageToAllDMs(GetName(OBJECT_SELF) + " skips attack on " + GetName(oVictimDmg) + " at " + FloatToString(fDistance) + " distance. ");
					 		}
					 else {
							SendMessageToPC(oVictimDmg, sDmgFail);
							SendMessageToAllDMs(GetName(oVictimDmg) + " fails a reflex against " + GetName(OBJECT_SELF) + " at " + FloatToString(fDistance) + " distance against " + IntToString(nReflexDC));
					 		ApplyEffectToObject(DURATION_TYPE_INSTANT, eTrapDamage, oVictimDmg); 
							AssignCommand(oVictimDmg, ActionJumpToLocation(GetLocation(oTrapSafetyWP)));
							}
						  
					 SetLocalInt(OBJECT_SELF, GetName(oVictimDmg), 1);
					 }
			 oVictimDmg = GetNextObjectInShape(SHAPE_SPHERE, 5.0, GetLocation(oTrapWP), FALSE, OBJECT_TYPE_CREATURE);
			 SendMessageToAllDMs(GetName(oVictimDmg) + " is name oVictimDmg");
			 if(oVictimDmg == OBJECT_INVALID) {break;}
			 }
				
			 DestroyObject(oTrapPlc, 2.0);
   			 DestroyObject(oTrapDoor, 2.0);

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
}