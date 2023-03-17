//::///////////////////////////////////////////////
//
//  System Name : Glyph of Warding
//  Filename : acr_s0_glyph_hb
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
    Dummy heartbeat for glyph of warding object

*/

#include "acr_spells_i"
#include "acr_trigger_i"

void main () {

ACR_TriggerOnHeartbeat();
string sCaster = GetLocalString(OBJECT_SELF, "ACR_CASTER_RESREF");
SendMessageToAllDMs("sCaster = " + sCaster);
		
}
