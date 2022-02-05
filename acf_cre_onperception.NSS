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
		object oMaster = GetLocalObject(OBJECT_SELF, "oMaster");
		location lSafe = CalcSafeLocation(OBJECT_SELF, GetLocation(oMaster), 1.0, TRUE,FALSE);
		if((oMaster == oPerceived) && (GetLastPerceptionVanished())) {
			ActionForceFollowObject(oMaster, 1.0, 0);
			ActionForceMoveToObject(oMaster, TRUE, 1.0, 30.0);
			}
		if(GetTag(oPerceived) == "003_cr_bane_bp_elthonds") {
			ClearAllActions(TRUE);
			ActionAttack(oPerceived, FALSE);
			
			}
	}
	
	if(GetTag(OBJECT_SELF) == "003_cr_un_ghost_moan") {
		if((!GetIsPC(oPerceived)) && (!GetIsDMPossessed(oPerceived)))
			{return;}
		else if((Random(5) <= 1) && (GetDistanceBetween(OBJECT_SELF, oPerceived) < 30.0))
		   {int nProxy = GetLocalInt(OBJECT_SELF, "Proxy");
		    SendMessageToAllDMs("Moaning ghost firing. Proxy = " + IntToString(nProxy));
		    SendMessageToPC(oPerceived, "Proxy = " + IntToString(nProxy));
		    ClearAllActions(TRUE);
		    effect eSonic = EffectVisualEffect(VFX_DUR_CONE_SONIC, FALSE);
		    PlaySound("as_hr_x2ghost1", FALSE);
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
		else if((GetLocalInt(OBJECT_SELF, GetName(oPerceived)) != 1) && ((GetIsPC(oPerceived)) || (GetIsDMPossessed(oPerceived)))) {
				SetLocalInt(OBJECT_SELF, GetName(oPerceived), 1);
		   		int nDC = 10 + (GetHitDice(OBJECT_SELF)/2) + GetAbilityModifier(ABILITY_CHARISMA, OBJECT_SELF); 
				SendMessageToPC(oPerceived, "You get a good look at a horrific ghost...");
		   		if(FortitudeSave(oPerceived, nDC, SAVING_THROW_TYPE_FEAR, OBJECT_SELF) != 0) 
					{SendMessageToPC(oPerceived, "...and are able to resist the effects of fear.");
		   		}
				else {SendMessageToPC(oPerceived, "...and feel your knees weaken, your limbs freeze, and your blood run cold.");
				ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectAbilityDecrease(ABILITY_STRENGTH, d4(1))), oPerceived);
				ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectAbilityDecrease(ABILITY_DEXTERITY, d4(1))), oPerceived);
				ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectAbilityDecrease(ABILITY_CONSTITUTION, d4(1))), oPerceived);
				}
			}
		}
		    
}