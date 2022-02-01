////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ACR Configuration File
//     Filename : acf_cre_onperception
//    $Revision:: 280        $ current version of the file
//        $Date:: 2007-03-20#$ date the file was created or modified
//       Author : Cipher
//
//    Var Prefix:
//  Dependencies:
//
//  Description
//  This script calls the ACR's OnPerception event handler for creatures
//  and any custom code a server may need. It is not updated in ACR updates.
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
	
	if(GetTag(OBJECT_SELF) == "003_cr_slv_profnec") {
		if(GetTag(oPerceived) == "003_cr_bane_bp_elthonds") {
			ClearAllActions(TRUE);
			ActionAttack(oPerceived, FALSE);
			}
	}
	
	if(GetTag(OBJECT_SELF) == "003_cr_un_ghost_moan") {
		if((!GetIsPC(oPerceived)) && (!GetIsDMPossessed(oPerceived)))
			{return;}
		else if((Random(5) == 1) && (GetDistanceBetween(OBJECT_SELF, oPerceived) < 30.0))
		   {SendMessageToAllDMs("Moaning Ghost firing.");
		    ClearAllActions(TRUE);
		    PlaySound("as_hr_x2ghost1", FALSE);
			effect eSonic = EffectVisualEffect(VFX_DUR_CONE_SONIC, FALSE);
		    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSonic, OBJECT_SELF, 3.0);
			int nDC = 10 + (GetHitDice(OBJECT_SELF)/2) + GetAbilityModifier(ABILITY_CHARISMA, OBJECT_SELF); 
			effect eFear = EffectFrightened();
			object oPC = GetFirstObjectInShape(SHAPE_SPHERE, 30.0, GetLocation(OBJECT_SELF), FALSE, OBJECT_TYPE_CREATURE);
		    while(oPC != OBJECT_INVALID) {
				if((GetLocalInt(OBJECT_SELF, GetName(oPC)) != 1) && ((GetIsPC(oPC)) || (GetIsDMPossessed(oPC)))) {
					SetLocalInt(OBJECT_SELF, GetName(oPC), 1);
					if(WillSave(oPC, nDC, SAVING_THROW_TYPE_FEAR, OBJECT_SELF) != 0)
						{SendMessageToPC(oPC, "A ghost's moan sends a chill down your spine but you stand your ground.");}
					else {SendMessageToPC(oPC, "A ghost's moan strikes fear into your heart. You are under a fear effect.");
						  SendMessageToAllDMs(GetName(oPerceived) + "failed willsave against Moaning Ghost. Frightened.");
				          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFear, oPC, d4(2)*6.0);
					}
				oPC = GetNextObjectInShape(SHAPE_SPHERE, 30.0, GetLocation(OBJECT_SELF), FALSE, OBJECT_TYPE_CREATURE);
				}
			}
		}
	}
	
	
	if(GetTag(OBJECT_SELF) == "003_cr_un_ghost_horrific") {
		if((!GetIsPC(oPerceived)) && (!GetIsDMPossessed(oPerceived)))
			{return;}
		else if(GetLocalInt(OBJECT_SELF, GetName(oPerceived)) != 1) {
				SendMessageToAllDMs("Horrific Ghost firing.");
		        SetLocalInt(OBJECT_SELF, GetName(oPerceived), 1);
		   		effect eHorrific = EffectVisualEffect(VFX_DUR_NAUSEA, FALSE);
		        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHorrific, OBJECT_SELF, 3.0);
			    int nDC = 10 + (GetHitDice(OBJECT_SELF)/2) + GetAbilityModifier(ABILITY_CHARISMA, OBJECT_SELF); 
				SendMessageToPC(oPerceived, "You get a good look at a horrific ghost...");
		   		if(FortitudeSave(oPerceived, nDC, SAVING_THROW_TYPE_FEAR, OBJECT_SELF) != 0) 
					{SendMessageToPC(oPerceived, "...and are able to resist the effects of the terrifying countenance.");
		   		}
				else {SendMessageToPC(oPerceived, "...and feel your knees weaken, your limbs freeze, and your blood run cold.");
					  SendMessageToAllDMs(GetName(oPerceived) + "failed willsave against Horrific Ghost. d4 STR/DEX/CON drain.");
					  ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectAbilityDecrease(ABILITY_STRENGTH, d4(1))), oPerceived);
					  ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectAbilityDecrease(ABILITY_DEXTERITY, d4(1))), oPerceived);
					  ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectAbilityDecrease(ABILITY_CONSTITUTION, d4(1))), oPerceived);
						}
			}
		}
		
	
	if(GetTag(OBJECT_SELF) == "003_cr_un_ghost_corrupt") {
		if((!GetIsPC(oPerceived)) && (!GetIsDMPossessed(oPerceived)))
			{return;}
		else if((Random(5) == 1) && (GetDistanceBetween(OBJECT_SELF, oPerceived) < 30.0))
		   {SendMessageToAllDMs("Corrupting Ghost firing.");
		    ClearAllActions(TRUE);
		    int nDC = 10 + (GetHitDice(OBJECT_SELF)/2) + GetAbilityModifier(ABILITY_CHARISMA, OBJECT_SELF); 
			effect eDamage = EffectDamage(d10(2), DAMAGE_TYPE_NEGATIVE, DAMAGE_POWER_NORMAL,FALSE);
			if(GetLocalInt(OBJECT_SELF, GetName(oPerceived)) != 1)  {
					effect eBeam = EffectBeam(VFX_BEAM_NECROMANCY, OBJECT_SELF, BODY_NODE_MONSTER_0, FALSE);
		    		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam, oPerceived, 5.0);
					SetLocalInt(OBJECT_SELF, GetName(oPerceived), 1);
					SendMessageToPC(oPerceived, "You see the glowing eyes of a ghost turn your way...");
					if(WillSave(oPerceived, nDC, SAVING_THROW_TYPE_FEAR, OBJECT_SELF) != 0)
						{SendMessageToPC(oPerceived, "...but the baleful power of that corrupting gaze passes over you without harm!");}
					else {SendMessageToPC(oPerceived, "...and the baleful power of that corrupting gaze withers your confidence. Your heart siezes painfully.");
						  SendMessageToAllDMs(GetName(oPerceived) + "Failed willsave against Corrupting Ghost. 2d10 dmg/d4 CHR drain.");
						  ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oPerceived);
						  ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectAbilityDecrease(ABILITY_CHARISMA, d4(1))), oPerceived);
				
						  }
				}
			
			}
		}	    
		    
}