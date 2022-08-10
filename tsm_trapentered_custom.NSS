//Custom Traps Trigger Enter
// Wynna 03/05/22


#include "acr_trigger_i"
#include "x0_i0_spells"
#include "acr_traps_i"

void ActionCreateCreature(string sCreature, location lLocPlace)
{
    CreateObject(OBJECT_TYPE_CREATURE, sCreature, lLocPlace, FALSE);
}

void main()
{
    ACR_TriggerOnEnter();
	SendMessageToAllDMs("trapentered_custom called");
	object oVictim = GetEnteringObject();
	SetLocalObject(OBJECT_SELF, "oVictim", GetEnteringObject());
	
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
				 SendMessageToAllDMs(GetName(oVictim) + " entered " + GetName(OBJECT_SELF));
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
	
	
	else {
	ExecuteScript("tsm_traptriggered_custom", OBJECT_SELF);
	}
	
   	
}