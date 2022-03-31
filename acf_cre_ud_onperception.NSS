////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ACR Configuration File
//     Filename : acf_cre_onperception
//     Date:: 2022-03-27#$ date the file was created or modified
//     Author : Wynna
//
//    Var Prefix:
//  Dependencies:
//
//  Description
//  This script controls the results of PCs perceiving undead with special onperceived effects
//  Uses creature perceiving PC as proxy for PC perceiving creature where needed.
//
//  Revision History
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#include "acr_creature_i"

////////////////////////////////////////////////////////////////////////////////
// Constants ///////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Structures //////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Global Variables ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Function Prototypes /////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Function Definitions ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

void main()
{
    ACR_CreatureOnPerception();

    // Custom code goes here.
	object oPerceived = GetLastPerceived();
	if((GetIsPC(oPerceived)) || (GetIsDMPossessed(oPerceived))) {
		
		// Horrific Appearance, Corrupting Gaze and Frightful Moan are possible abilities of any ghost. Each ghost can have one or all of the abilities. 
		// Place as many of the three variables on the ghost as are desired.
		// Horrific Appearance fires only once for each PC, the first time the PC is perceived by the ghost. Save or fail, it won't affect them again. 
		if(GetLocalInt(OBJECT_SELF, "ACR_PERCEIVE_HORRIFIC") == 1) {
			if((GetLocalInt(OBJECT_SELF, GetName(oPerceived)) != 1) && (GetLastPerceptionSeen()) && (GetDistanceBetween(OBJECT_SELF, oPerceived) <= 60.0)) {
				SetLocalInt(OBJECT_SELF, GetName(oPerceived), 1);
			   	int nDC = 10 + (GetHitDice(OBJECT_SELF)/2) + GetAbilityModifier(ABILITY_CHARISMA, OBJECT_SELF); 
				SendMessageToPC(oPerceived, "You get a mere glimpse of a horrific ghost...");
			   	if(FortitudeSave(oPerceived, nDC, SAVING_THROW_TYPE_FEAR, OBJECT_SELF) != 0) 
					{SendMessageToPC(oPerceived, "...and are able to resist the effects of fear.");}
				else {SendMessageToPC(oPerceived, "...and feel your knees weaken, your limbs freeze, and your blood run cold.");
					ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectAbilityDecrease(ABILITY_STRENGTH, d4(1))), oPerceived);
					ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectAbilityDecrease(ABILITY_DEXTERITY, d4(1))), oPerceived);
					ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectAbilityDecrease(ABILITY_CONSTITUTION, d4(1))), oPerceived);
					}
				}
			}
			
		//Corrupting Gaze has a 20% chance of firing on a PC each time the PC moves into sight of the ghost. 
		//The ghost has to stop any combat it's involved in to launch the Corrupting Gaze attack at the newly perceived PC.
		if((GetLocalInt(OBJECT_SELF, "ACR_PERCEIVE_CORRUPT") == 1) && (Random(5) <= 1)) {
			if((GetLastPerceptionSeen()) && (GetDistanceBetween(OBJECT_SELF, oPerceived) < 30.0)){
				ClearAllActions(TRUE);
				int nDC = 10 + (GetHitDice(OBJECT_SELF)/2) + GetAbilityModifier(ABILITY_CHARISMA, OBJECT_SELF); 
				SendMessageToPC(oPerceived, "You feel the corrupting gaze of something undead...");
		   		if(FortitudeSave(oPerceived, nDC, SAVING_THROW_TYPE_FEAR, OBJECT_SELF) != 0) 
					{SendMessageToPC(oPerceived, "...and are able to resist the effects of fear.");
		   		}
				else {SendMessageToPC(oPerceived, "...and feel your heart stutter and seize painfully, and your confidence falter.");
					ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectAbilityDecrease(ABILITY_CHARISMA, d4(1))), oPerceived);
					effect eDamage = EffectDamage(d10(2), DAMAGE_TYPE_NEGATIVE, DAMAGE_POWER_NORMAL, FALSE);
					ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oPerceived);
					}
				return;
				}
			
			}		    
	
		//Frightful Moan has a 20% chance of firing on a PC each time the PC moves into sight of the ghost. 
		//The ghost has to stop any combat it's involved in to launch the Frightful Moan attack triggered by the newly perceived PC, effecting all PCs within a 30 foot radius of the ghost.
		if((GetLocalInt(OBJECT_SELF, "ACR_PERCEIVE_MOAN") == 1) && (Random(5) <= 1)){
			if((GetLastPerceptionSeen()) && (GetDistanceBetween(OBJECT_SELF, oPerceived) < 30.0)) {
			    ClearAllActions(TRUE);
				effect eSonic = EffectVisualEffect(VFX_DUR_CONE_SONIC, FALSE);
				PlaySound("as_hr_x2ghost1", FALSE);
				ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSonic, OBJECT_SELF, 3.0);
				int nDC = 10 + (GetHitDice(OBJECT_SELF)/2) + GetAbilityModifier(ABILITY_CHARISMA, OBJECT_SELF); 
				effect eFear = EffectFrightened();
				object oPC = GetFirstObjectInShape(SHAPE_SPHERE, 30.0, GetLocation(OBJECT_SELF), FALSE, OBJECT_TYPE_CREATURE);
				while(oPC != OBJECT_INVALID) {
					if(GetLocalInt(OBJECT_SELF, GetName(oPC)) != 1) {
						SetLocalInt(OBJECT_SELF, GetName(oPC), 1);
						if(WillSave(oPC, nDC, SAVING_THROW_TYPE_FEAR, OBJECT_SELF) != 0)
							{SendMessageToPC(oPC, "A ghost's moan sends a chill down your spine but you stand your ground.");}
						else {SendMessageToPC(oPC, "A ghost's moan strikes fear into your heart. You are under a fear effect.");
							  ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFear, oPC, d4(2)*6.0);
							 }
						oPC = GetNextObjectInShape(SHAPE_SPHERE, 30.0, GetLocation(OBJECT_SELF), FALSE, OBJECT_TYPE_CREATURE);
						}
					}
				}
			}			
		
		//Banshees have Horrific Appearance that drains Str/Dex/Con and a Wail attack with a Death Save.
		//Wail only fires at night, with d4 rounds between wails, and can only be used by a given banshee 3x.
		if(GetLocalInt(OBJECT_SELF, "ACR_PERCEIVE_BANSHEE") == 1) {
			int nDC = 26; 
			if((GetLocalInt(OBJECT_SELF, GetName(oPerceived)) != 1) && (GetLastPerceptionSeen()) && (GetDistanceBetween(OBJECT_SELF, oPerceived) <= 60.0)) {
				SetLocalInt(OBJECT_SELF, GetName(oPerceived), 1);
				SendMessageToPC(oPerceived, "You see the horrific appearance of a banshee...");
				if(FortitudeSave(oPerceived, nDC, SAVING_THROW_TYPE_FEAR, OBJECT_SELF) != 0) 
					{SendMessageToPC(oPerceived, "...and are able to resist the debilitating terror.");}
				else {SendMessageToPC(oPerceived, "...and feel your knees weaken, your limbs freeze, and your blood run cold.");
					ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectAbilityDecrease(ABILITY_STRENGTH, d4(1))), oPerceived);
					ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectAbilityDecrease(ABILITY_DEXTERITY, d4(1))), oPerceived);
					ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectAbilityDecrease(ABILITY_CONSTITUTION, d4(1))), oPerceived);
					}
				}
			
			int nNight = GetIsNight();
			int nWail = GetLocalInt(OBJECT_SELF, "nWail");
		    if((nNight == 1) && (nWail < 3) && (Random(5) <= 1) && (GetLastPerceptionSeen()) && (GetDistanceBetween(OBJECT_SELF, oPerceived) <= 30.0))
			   {SetLocalInt(OBJECT_SELF, "nWail", nWail +1);
			    ActionSpeakString(GetName(OBJECT_SELF) + " wails!", TALKVOLUME_TALK);
			    ClearAllActions(TRUE);
				effect eSonic = EffectVisualEffect(VFX_DUR_CONE_SONIC, FALSE);
				PlaySound("as_hr_x2ghost1", FALSE);
				ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSonic, OBJECT_SELF, 3.0);
				effect eDeath = EffectDeath(FALSE, TRUE, FALSE, TRUE);
				object oPC = GetFirstObjectInShape(SHAPE_SPHERE, 30.0, GetLocation(OBJECT_SELF), FALSE, OBJECT_TYPE_CREATURE);
				while(oPC != OBJECT_INVALID) {
					SendMessageToPC(oPC, "Your heart stops beating at the sound of a terrifying wail...");
					if(FortitudeSave(oPC, nDC, SAVING_THROW_TYPE_DEATH, OBJECT_SELF) != 0)
						{SendMessageToPC(oPC, "...and then starts again.");}
					else {SendMessageToPC(oPC, "... and does not start again. The last sound you hear is that wail, sending you to the afterlife.");
						 ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDeath, oPC);
						}
					oPC = GetNextObjectInShape(SHAPE_SPHERE, 30.0, GetLocation(OBJECT_SELF), FALSE, OBJECT_TYPE_CREATURE);
					}
				}
			}
		}
	
		    
}