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
    Heartbeat for glyph of warding object

    Short rundown:

    Place a glyph of warding object from the palette and manually add 
	ACR_CASTER_RESREF as a string with the resref of the creature you  
	want to be its 'caster' through the toolset.

    On the first heartbeat, the glyph creates the glyph visual
    effect on itself for the duration of the spell.

    Each subsequent heartbeat the glyph checks if the effect
    is still there. If it is no longer there, it has either been
    dispelled or removed, and the glyph will terminate itself.

    Also on the first heartbeat, this object creates an AOE object
    around itself, which, when getting the OnEnter Event will signal 
    User Defined Event 2000 to the glyph placeable which will fire
    the spell stored on a variable on itself on the intruder

    Note that not all spells might work because this is a placeable
    object casting them, but the more popular ones are working.

    The default spell cast is id 549, which is the script for
    the standard glyph of warding.

    Check the comments on the Glyph of Warding object on the palette
    for more information

*/

// Includes //////////////////////////////////////

#include "x2_inc_switches"
#include "acr_spells_i"
void main()
{

    int bSetup = GetLocalInt(OBJECT_SELF,"ACR_PLC_GLYPH_INIT");
    if (bSetup == 0)
    {
        SetLocalInt(OBJECT_SELF,"ACR_PLC_GLYPH_INIT",1);
        string sCaster = GetLocalString(OBJECT_SELF, "ACR_CASTER_RESREF");
		ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(445),OBJECT_SELF);
        
        effect eAOE = EffectAreaOfEffect(38, "acr_s0_glyph_onenter", "acr_s0_glyph_onhb", "acr_s0_glyph_onexit", "alfa_glyph_warding");
        ApplyEffectAtLocation(DURATION_TYPE_PERMANENT, eAOE, GetLocation(OBJECT_SELF));
		DelayCommand(3.0, SetLocalString(GetNearestObjectByTag("alfa_glyph_warding", OBJECT_SELF, 1), "ACR_CASTER_RESREF", sCaster));
		}
    else
    {
        effect e1 = GetFirstEffect(OBJECT_SELF);
        int bGood = FALSE;
        while (GetIsEffectValid(e1))
        {
            if (GetEffectType(e1) == EFFECT_TYPE_VISUALEFFECT)
            {
                if (GetEffectCreator(e1) == OBJECT_SELF)
                {
                    bGood = TRUE;
                }
            }
            e1 = GetNextEffect(OBJECT_SELF);
        }

        if (!bGood)
        {
            DestroyObject(OBJECT_SELF);
            return;
        }

    }

 }