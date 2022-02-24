////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ACR Configuration File
//     Filename : acf_plc_ondamaged.nss
//    $Revision:: 188        $ current version of the file
//        $Date:: 2006-12-21#$ date the file was created or modified
//       Author : Ronan
//
//  Local Variable Prefix =
//
//  Dependencies external of nwscript:
//
//  Description
//  This script calls the ACR's OnDamaged code for placeables, and any
//  custom code a server may need. It is not updated in ACR updates.
//
//  Revision History
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

#include "acr_placeable_i"

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

// The main event handler.

void ActionCreateCreature(string sCreature, location lLocPlace)
{
    CreateObject(OBJECT_TYPE_CREATURE, sCreature, lLocPlace, FALSE);
}

void main();

////////////////////////////////////////////////////////////////////////////////
// Function Definitions ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

void main() {
    ACR_PlaceableOnDamaged();

    	//Glacier melting snow/ice
	if(GetTag(OBJECT_SELF)== "plc_snow_melt")
		{effect eSteamDmg = EffectDamage(d6(1),DAMAGE_TYPE_FIRE, DAMAGE_POWER_NORMAL, FALSE);
	     effect eSteam = EffectVisualEffect(VFX_DUR_SPELL_SHROUDING_FOG, FALSE);
         int nOldFireDmg = GetLocalInt(OBJECT_SELF, "FireDmg");
		 int nNewFireDmg = GetDamageDealtByType(DAMAGE_TYPE_FIRE);
		 if(nNewFireDmg > nOldFireDmg) {
		 	SetLocalInt(OBJECT_SELF, "FireDmg", nNewFireDmg);
		   	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSteam, OBJECT_SELF, 10.0);
			SpeakString("*Scalding hot steam boils up.", TALKVOLUME_TALK);
				 object oCreature = GetFirstObjectInShape(SHAPE_SPHERE, 10.0, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
				 while (oCreature != OBJECT_INVALID) {
				 	if(!ReflexSave(oCreature,12,SAVING_THROW_TYPE_FIRE, OBJECT_SELF)) {
						ApplyEffectToObject(DURATION_TYPE_INSTANT, eSteamDmg, oCreature);
						}
				 oCreature = GetNextObjectInShape(SHAPE_SPHERE, 10.0, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
				 }	 
			}	
		}
			
	if(GetTag(OBJECT_SELF) == "abr_plc_snow_melt_pillar") {
		effect eBurst = EffectVisualEffect(VFX_FNF_SOUND_BURST, FALSE);
        effect eExplode = EffectVisualEffect(VFX_IMP_DUST_EXPLOSION, FALSE);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eExplode, OBJECT_SELF, 3.0);
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBurst, OBJECT_SELF, 5.0);
		SpeakString("*Ice shatters and a withered creature with ice-blackened skin claws its way out!", TALKVOLUME_TALK);
		DelayCommand(2.0, ActionCreateCreature("abr_cr_un_zombie_frostmourngiant", GetLocation(OBJECT_SELF)));
		DestroyObject(OBJECT_SELF, 3.0);
		} 
	
}