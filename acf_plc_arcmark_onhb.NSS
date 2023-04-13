//::///////////////////////////////////////////////
//
//  System Name : Glyph of Warding
//  Filename : acr_s0_glyph_plc_hb
//    
//  Description
//  This script handles on heartbeat actions for the placeable Glyph of Warding.
//  It is not updated in ACR updates.
//
//  Revision History
////////////////////////////////////////////////////////////////////////////////
//:: 
//:: Georg Zoeller - created x2_o0_glyphhb - 2003-09-02
//	 Wynna - Updated for a placeable glyph - 3/17/2023

////////////////////////////////////////////////////////////////////////////////

/*
    Heartbeat for arcane mark object

    Place an arcane mark object from the pallet and manually add 
	ACR_CASTER_RESREF as a string with the resref of the creature you  
	want to be its 'caster' through the toolset.

    On the first heartbeat, the arcane mark creates the arcane mark visual
    effect on itself for the duration of the spell.

    
*/

// Includes //////////////////////////////////////

#include "x2_inc_switches"
#include "acr_spells_i"
#include "acr_placeable_i"

void main()
{
	ACR_PlaceableOnHeartbeat();
    int bSetup = GetLocalInt(OBJECT_SELF,"ACR_PLC_ARCMARK_INIT");
    if (bSetup == 0)
    {   
		SetLocalInt(OBJECT_SELF,"ACR_PLC_ARCMARK_INIT",1);
        string sCaster = GetLocalString(OBJECT_SELF, "ACR_CASTER_RESREF");
		SendMessageToAllDMs("acf_plc_arcmark_onhb sCaster = " + sCaster);
		object oInvisoCaster = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_invis_caster", GetLocation(OBJECT_SELF));
		ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(445),OBJECT_SELF);
        DelayCommand(3.0, AssignCommand(oInvisoCaster, ActionCastSpellAtLocation(3066, GetLocation(OBJECT_SELF), METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
        }
}