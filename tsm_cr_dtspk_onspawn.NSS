//
//     Filename : tsm_cr_dt_onspawn
//      Version : 0.1
//         Date : 7/18/22
//       Author : Wynna
//
//  Description
//  This script creates an onspawn script for a secret door listener waiting on a password.
//	It is not updated in ACR updates.
//
//  Revision History
////////////////////////////////////////////////////////////////////////////////

//	Wynna - 7/8/2022

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////

#include "acr_spawn_i"

void ActionCreateWynCreature(string sCreature, location lLocCreature)
{
    CreateObject(OBJECT_TYPE_CREATURE, sCreature, lLocCreature);
}
void ActionCreateWynPlaceable(string sPlaceable, location lLocPlaceable)
{
    CreateObject(OBJECT_TYPE_PLACEABLE, sPlaceable, lLocPlaceable);
}
void ActionCreateWynPlacedEffect(string sPlaceable, location lLocPlaceable)
{
    CreateObject(OBJECT_TYPE_PLACEABLE, sPlaceable, lLocPlaceable);
}
void main() {
		
	effect eCutScene = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);
	effect eFreeze = EffectCutsceneImmobilize();
	
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutScene,OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eFreeze,OBJECT_SELF);
    SetListenPattern(OBJECT_SELF, "**Tozguk Nrhah**", 4000);
    SetListening(OBJECT_SELF, TRUE);
         
		 		
			
}