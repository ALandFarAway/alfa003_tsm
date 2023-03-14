/////////////////////////////////////////////////////////////////////////////
//
//  System Name : ALFA Core Rules
//     Filename : acr_s0_readmagic.nss
//    $Revision:: 1        $ current version of the file
//        $Date:: 2023-03-15 date the file was created or modified
//       Author : Wynna 
//
//
//  Description
//  Read Magic as per FRCS. Reads and reveals Arcane Marks and Glyphs of Warding.
//
//
//////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#include "acr_spells_i"


////////////////////////////////////////////////////////////////////////////////
// Function Definitions ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

void main() {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell.
	if ( !ACR_PrecastEvent() ) {
		return;
	}

	// Casting information.
	object oCaster = OBJECT_SELF;
	float fDuration = ACR_GetSpellDuration( oCaster, ACR_DURATION_TYPE_PER_CL, ACR_DURATION_10M );

	// Apply the dummy effect.
	ApplyEffectToObject( DURATION_TYPE_TEMPORARY, EffectVisualEffect( VFX_DUR_SPELL_READ_MAGIC ), oCaster, fDuration);
	
	object oTarget = GetSpellTargetObject();
	object oReadMagic = GetFirstObjectInShape(SHAPE_SPHERE, 6.0, GetLocation(oTarget), TRUE, OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_ITEM |OBJECT_TYPE_DOOR | OBJECT_TYPE_TRIGGER | OBJECT_TYPE_WAYPOINT | OBJECT_TYPE_AREA_OF_EFFECT);
	int nMarked = 0;
	int nGlyph = 0;
	string sName;
	while(oReadMagic != OBJECT_INVALID) {
		sName = GetName(oReadMagic);
		
		//Read Magic: Glyph of Warding
		if(GetObjectType(oReadMagic) == OBJECT_TYPE_AREA_OF_EFFECT) {
		int nAOESpell = GetAreaOfEffectSpellId(oReadMagic);
		if(nAOESpell == 549) {
			int nReadGlyph = GetLocalInt(oReadMagic, "nReadGlyph");
			if(nReadGlyph != 1) {
				SetLocalInt(oReadMagic, "nReadGlyph", 1); 
				if(ACR_SkillCheck(SKILL_SPELLCRAFT, oCaster, 13, TRUE)) {
					object oGlyphCaster = GetAreaOfEffectCreator(oReadMagic);
					int nGlyphCasterLvl = GetCasterLevel(oGlyphCaster);
					if(nGlyphCasterLvl >= 10){nGlyphCasterLvl = 10;}
					int nDam = 8 * (nGlyphCasterLvl /2 );
					int nAlign = GetAlignmentGoodEvil(oGlyphCaster);
					string sAlignDmg = "Divine";
					if (nAlign == ALIGNMENT_GOOD) {sAlignDmg = "Divine";}
					else if (nAlign == ALIGNMENT_EVIL) {sAlignDmg = "Negative";}
					else {sAlignDmg = "Sonic";}
					if(GetObjectType(oReadMagic) == OBJECT_TYPE_AREA_OF_EFFECT) { sName = "A nearby location";}
					SendMessageToPC(oCaster, sName + " bears a Blasting Glyph of Warding that will do up to " + IntToString(nDam) + " points of " + sAlignDmg + " damage to anybody who enters it.");
					}
				else {SendMessageToPC(oCaster, sName + " has a glyph on it.");}
				}
			}
		}
		
		//Read Magic: Arcane Mark directly on an object or on the object as a proxy for a location
		int nRM = 0;
		while (nRM < 5) {
			nRM++;
			if(ACR_GetPersistentString(oReadMagic, "ACR_ARCANEMARK" + IntToString(nRM)) != "") {
				location lMarked = ACR_GetPersistentLocation(oReadMagic, "ACR_ARCANEMARKLoc" + IntToString(nRM));
				if(GetDistanceBetweenLocations(lMarked, GetLocation(oCaster)) < 5.0) {
					object oMark = GetFirstObjectInShape(SHAPE_SPHERE, 1.0, lMarked, TRUE, OBJECT_TYPE_PLACEABLE);
					while (oMark != OBJECT_INVALID) {
						if(GetTag(oMark) == "ipoint_arcane_mark") {nMarked = 1;}
						oMark = GetNextObjectInShape(SHAPE_SPHERE, 1.0, lMarked, TRUE, OBJECT_TYPE_PLACEABLE);
						}
					if(nMarked != 1) {CreateObject(OBJECT_TYPE_PLACEABLE, "ipoint_arcane_mark", lMarked, TRUE);}
					string sMarked = ACR_LocationToString(lMarked);
					string sMarkedProxy = ACR_LocationToString(GetLocation(oReadMagic));
					int nXStart = FindSubString(sMarked, "#X#", 0);
					string sXYMarked = GetSubString(sMarked, nXStart, 30);
					string sXYMarkedProxy = GetSubString(sMarkedProxy, nXStart, 30);
					if(sXYMarked != sXYMarkedProxy) {sName = "A nearby location";}
					SendMessageToPC(oCaster, sName + " bears an Arcane Mark which reads " + ACR_GetPersistentString(oReadMagic, "ACR_ARCANEMARK" + IntToString(nRM)));
					}
				}
			}
		if(oReadMagic != GetNextObjectInShape(SHAPE_SPHERE, 6.0, GetLocation(oTarget), TRUE, OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_ITEM |OBJECT_TYPE_DOOR | OBJECT_TYPE_TRIGGER | OBJECT_TYPE_WAYPOINT | OBJECT_TYPE_AREA_OF_EFFECT))
			{oReadMagic = GetNextObjectInShape(SHAPE_SPHERE, 6.0, GetLocation(oTarget), TRUE, OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_ITEM |OBJECT_TYPE_DOOR | OBJECT_TYPE_TRIGGER | OBJECT_TYPE_WAYPOINT | OBJECT_TYPE_AREA_OF_EFFECT);}
		else {break;}
		}
	
	//Read Magic: Arcane Mark on the area as a proxy for a location	
	 nMarked = 0;	
	 oReadMagic = GetArea(oCaster);
	 	
	 int nRM = 0;
	 while (nRM < 5) {
		nRM++;
		if(ACR_GetPersistentString(oReadMagic, "ACR_ARCANEMARK" + IntToString(nRM)) != "") {
			location lMarked = ACR_GetPersistentLocation(oReadMagic, "ACR_ARCANEMARKLoc" + IntToString(nRM));
			if(GetDistanceBetweenLocations(lMarked, GetLocation(oCaster)) < 5.0) {
				sName = "A nearby location";
				object oMark = GetFirstObjectInShape(SHAPE_SPHERE, 1.0, lMarked, TRUE, OBJECT_TYPE_PLACEABLE);
				while (oMark != OBJECT_INVALID) {
					if(GetTag(oMark) == "ipoint_arcane_mark") {nMarked = 1;}
					oMark = GetNextObjectInShape(SHAPE_SPHERE, 1.0, lMarked, TRUE, OBJECT_TYPE_PLACEABLE);
					}
				if(nMarked != 1) {CreateObject(OBJECT_TYPE_PLACEABLE, "ipoint_arcane_mark", lMarked, TRUE);}
				SendMessageToPC(oCaster, sName + " bears an arcane mark that reads: " + ACR_GetPersistentString(oReadMagic, "ACR_ARCANEMARK" + IntToString(nRM)));
				}
			}
		}
	
	// Post-cast event.
	ACR_PostcastEvent();
}