/////////////////////////////////////////////////////////////////////////////
//
//  System Name : ALFA Core Rules
//     Filename : acr_s0_erase.nss
//    $Revision:: 1        $ current version of the file
//        $Date:: 2023-02-24 date the file was created or modified
//       Author : Wynna 
//
//
//  Description
//  Erase as per FRCS. Looks for Arcane Marks to erase first, then checks to 
//	see if oTarget is a magic scroll, and removes its item properties if so.
//////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#include "acr_spells_i"


////////////////////////////////////////////////////////////////////////////////
// Function Definitions ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

void main()
{		
	if (!ACR_PrecastEvent())
    {
        return;
    }

	SignalEvent( GetSpellTargetObject(), EventSpellCastAt( OBJECT_SELF, GetSpellId(), FALSE ) );
	object oCaster = OBJECT_SELF;
	object oMarked = GetSpellTargetObject();
	location lMarked = GetLocation(oMarked);
	//Looking for Arcane Marks. First, do any exist on objects within radius 5.0 of target location
	if(oMarked == OBJECT_INVALID) {
		lMarked = GetSpellTargetLocation();
		oMarked = GetFirstObjectInShape(SHAPE_SPHERE, 5.0, lMarked, TRUE, OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_DOOR | OBJECT_TYPE_TRIGGER | OBJECT_TYPE_WAYPOINT); 
		int nMarked = 0;
		while (oMarked != OBJECT_INVALID) {
			 int nAM = 1;
			 while (nAM < 5) {
				if(ACR_GetPersistentString(oMarked, "ACR_ARCANEMARK" + IntToString(nAM)) != "") {nMarked = 1; break;}
				nAM++;
				}
			if(nMarked == 1) {break;}
			oMarked = GetNextObjectInShape(SHAPE_SPHERE, 5.0, lMarked, TRUE, OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_DOOR | OBJECT_TYPE_TRIGGER | OBJECT_TYPE_WAYPOINT); 
			}
		}
	
	//If none of the objects within radius are Marked, then we check the area, as a proxy for Marks that were placed without an object within 5.0 of the location they were placed.	
	//This is a technical end-around for mechanical limitations.
	if(oMarked == OBJECT_INVALID) {oMarked = GetArea(oCaster);}
	
	//Now that we have an oMarked object, we run a CL check to see if the Mark (if any) is revealed to oCaster
	//DC is always 15.
	if(oMarked != OBJECT_INVALID) {
		int nCasterLevel = GetCasterLevel(oCaster); 
		int nCLRoll = d20(1);
		SendMessageToPC(oCaster, "Caster level check: " + IntToString(nCLRoll) + " + " + IntToString(nCasterLevel) + " = " + IntToString(nCLRoll + nCasterLevel) + " vs DC15");
		if(nCLRoll <= 2) {SendMessageToPC(oCaster, "A natural 1 or 2 is always a failure on erasing magical writing.");}
		//oCaster failed their check.
		if((nCasterLevel + nCLRoll < 15) || (nCLRoll <= 2)) {
			SendMessageToPC(oCaster, "Your Erase spell fails.");
			//oCaster *really* failed, on a glyph of warding. Oops. Boom.
			if((FindSubString(GetTag(oMarked), "glyph_ward") != -1) || (FindSubString(GetResRef(oMarked), "glyph_ward") != -1)) {
				SendMessageToPC(oCaster, "You activate the " + GetName(oMarked) + "!");
				if((GetObjectType(oMarked) == OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_WAYPOINT) && (FindSubString(GetTag(oMarked), "glyph_ward") != -1)) {SendMessageToAllDMs("1 " + GetTag(oMarked)); AssignCommand(oMarked, ActionCastSpellAtLocation(549, lMarked, METAMAGIC_ANY, TRUE, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));}
				if((GetObjectType(oMarked) == OBJECT_TYPE_AREA_OF_EFFECT) && (FindSubString(GetTag(oMarked), "glyph_ward") != -1)) {SendMessageToAllDMs("2 " + GetTag(oMarked)); SignalEvent( oMarked, EventUserDefined( 2000) );}
				if(GetObjectType(oMarked) == OBJECT_TYPE_PLACEABLE) {SendMessageToAllDMs("3 " + GetTag(oMarked)); SignalEvent( oMarked, EventUserDefined( 2000) );}
				}
			}
		//oCaster passed their check. Hooray.
		else {
			effect eErase = EffectVisualEffect(VFX_IMP_EVIL_HELP);
			object oMark = GetNearestObjectByTag("ipoint_arcane_mark", oMarked, 1);
			if(oMarked == GetArea(oCaster)) {oMark = GetNearestObjectByTag("ipoint_arcane_mark", oCaster, 1);}
			int nAM = 1;
			int nErased = 0;
			//Do the actual erasing. 
			while (nAM < 5) {
				if(ACR_GetPersistentString(oMarked, "ACR_ARCANEMARK" + IntToString(nAM)) != "") {
					lMarked = ACR_GetPersistentLocation(oMarked, "ACR_ARCANEMARKLoc" + IntToString(nAM));
					string sName = GetName(oMarked);
					string sMarked = ACR_LocationToString(lMarked);
					string sMarkedProxy = ACR_LocationToString(GetLocation(oMarked));
					int nXStart = FindSubString(sMarked, "#X#", 0);
					string sXYMarked = GetSubString(sMarked, nXStart, 30);
					string sXYMarkedProxy = GetSubString(sMarkedProxy, nXStart, 30);
					
					if(sXYMarked != sXYMarkedProxy) {sName = "a location";}
					if((sXYMarked == sXYMarkedProxy) || ((sXYMarked != sXYMarkedProxy) && (GetSpellTargetObject() == OBJECT_INVALID))) { 
						ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eErase, lMarked, 3.0);
						if(GetDistanceBetween(oMark, oMarked) <= 2.5) {DestroyObject(oMark, 1.0);}
						SendMessageToPC(oCaster, "You have erased an arcane mark drawn on " + sName + ".");
						ACR_SetPersistentString(oMarked, "ACR_ARCANEMARK" + IntToString(nAM), "", 0);
						ACR_SetPersistentLocation(oMarked, "ACR_ARCANEMARKLoc" + IntToString(nAM), ACR_StringToLocation(""), 0);
						nErased++;
						}
					}
				nAM++;
				}
				
			//oCaster passed their check, but no Marks existed to be erased.
			if(nErased == 0) {SendMessageToPC(oCaster, "You found no arcane marks to erase.");}
			
			//Magic scrolls that have been Erased are demagic-ified
			if((GetBaseItemType(oMarked) == 54) || (GetBaseItemType(oMarked) == 75) || (GetBaseItemType(oMarked) == 105)) {
				ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eErase, lMarked, 3.0);
				SendMessageToPC(oCaster, "Both magic and the writing that had encoded it fade from " + GetName(oMarked) + ".");
				SetFirstName(oMarked, "Erased Scroll");
				SetDescription(oMarked, "This scroll has been erased.");
				itemproperty ipRemove = GetFirstItemProperty(oMarked);
				while (GetIsItemPropertyValid(ipRemove)) {
					RemoveItemProperty(oMarked, ipRemove);
						ipRemove = GetNextItemProperty(oMarked);
					} 
				}
			}
		}
	// Post-cast event.
	ACR_PostcastEvent();
	}				