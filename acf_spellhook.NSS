/////////////////////////////////////////////////////////////////////////////
//
//  System Name : ALFA Core Rules
//     Filename : acr_spellhook.nss
//    $Revision:: 336        $ current version of the file
//        $Date:: 2010-09-22#$ date the file was created or modified
//       Author : Cipher
//
//    Var Prefix: ACR_SHK
//  Dependencies: None
//
//  Description
//  This is the ALFA spellhook script. This script runs before all spell 
//  scripts fire.
//////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

#include "acr_spellhook_i"
#include "x0_i0_position"
#include "acr_skills_i"
#include "x0_i0_spells"
#include "acr_scry_i"
#include "NW_I0_SPELLS"    
#include "x2_inc_itemprop"
#include "x2_inc_toollib"
#include "acr_db_persist_i"

////////////////////////////////////////////////////////////////////////////////
// Constants ///////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

const float NUMBER_OF_COMPASS_DIRECTIONS = 16.0;
const float HALF_COMPASS_ANGLE = 360.0/(NUMBER_OF_COMPASS_DIRECTIONS * 2.0);

////////////////////////////////////////////////////////////////////////////////
// Structures //////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Global Variables ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Function Prototypes /////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

//string GetCompassDirectionOfBearing(float fDegrees);
//string GetCompassDirectionOfAngle(float fAngle);

void ActionCreateWynCreature(string sCreature, location lLocCreature)
{
    CreateObject(OBJECT_TYPE_CREATURE, sCreature, lLocCreature);
}

void ActionCreatePlaceable(string sPlaceable, location lLocPlaceable)
{
    CreateObject(OBJECT_TYPE_PLACEABLE, sPlaceable, lLocPlaceable);
}

////////////////////////////////////////////////////////////////////////////////
// Function Definitions ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

string GetCompassDirectionOfBearing(float fDegrees)
{
    /* Takes a bearing from degrees (0.0 -> 360.0)
     * where 0.0 is North and 90.0 is West and
     * returns its corresponding compass direction
     */

    // Handle cases when the caller is lazy
    while (fDegrees < 0.0) {
        fDegrees += 360.0;
    }
    while (fDegrees > 360.0) {
        fDegrees -= 360.0;
    }
	int nDegrees = FloatToInt(fDegrees);
	string sDegrees = IntToString(nDegrees);
	 // Do the mapping
    if ((fDegrees > 22.5) && (fDegrees < 67.5)) {
        return "southwest";
    }
    else if ((fDegrees > 67.5) && (fDegrees < 112.5)) {
        return "west";
    }
   else if ((fDegrees > 112.5) && (fDegrees < 157.5)) {
        return "northwest";
    }
    else if ((fDegrees > 157.5) && (fDegrees < 202.5)) {
        return "north";
    }
    else if ((fDegrees > 202.5) && (fDegrees < 247.5)) {
        return "northeast";
    }
    else if ((fDegrees > 247.5) && (fDegrees < 292.5)) {
        return "east";
    }
    else if ((fDegrees > 292.5) && (fDegrees < 337.5)) {
        return "southeast";
    }
   
    else return "south";
}


string GetCompassDirectionOfAngle(float fAngle)
{
    /* Takes an angle from degrees (0.0 -> 360.0)
     * where 0.0 is the positive X-axis and 90.0
     * is the positive Y-axis and returns its
     * corresponding compass direction
     */
    return GetCompassDirectionOfBearing(-fAngle + 90.0);
}


void main()
{
	// Call core ACR function.
	ACR_Spellhook();
	
	// Custom code goes below this line.
	
	int nSpellId = GetSpellId();
	string sSpellID = Get2DAString("spells", "Label", nSpellId);
    object oCaster = OBJECT_SELF;
    object oStudent = OBJECT_SELF;
    object oItem = GetSpellCastItem();
    object oTarget = GetSpellTargetObject();
	location lTarget = GetSpellTargetLocation();
	float fTargetDist = GetDistanceBetweenLocations(lTarget, GetLocation(oCaster));
	string sTarget = GetName(oTarget);
	if(oTarget == OBJECT_INVALID) {sTarget = IntToString(FloatToInt(fTargetDist)) + "m away";}
    int nItemType = GetBaseItemType(oItem);
	effect eFailure = EffectSpellFailure(100);
	string sArea = GetTag(GetArea(oCaster));
	effect eSpellFail = EffectSpellFailure(100, SPELL_SCHOOL_GENERAL);
	
	SendMessageToAllDMs(GetName(GetLastSpellCaster()) + " casting " + sSpellID + " in " + sArea + " at " + sTarget);
	
	/*Detect Magic
	
	A caster can detect the magical auras of objects within a spellcone. 
	The information learned is based on a Concentration Check for the Caster and individual Spellcraft Checks against every magical item in range.
	
	Concentration Check = Concentration Roll
	1 = Failure
	2-6 = 1 Round: There is magic within range.
	7-13 = 2 Rounds: The number of auras and the power of the strongest aura.
	14+ = 3 Rounds: The location of each aura and a Spellcraft Check against the magic item's power to determine the school of magic.
	
	School of Magic = Integer
	Abjuration = 1
	Conjuration = 2
	Divination = 3
	Enchantment = 4
	Evocation = 5
	Illusion = 6
	Necromancy = 7
	Transmutation = 8
	Universal = 9
	
	Power of Magic = Integer
	Faint = 1-3
	Moderate = 4-6
	Strong = 7-9
	Overwhelming = 10+
	*/
	
	if(GetSpellId() == 3004) {
		
		object oCaster = OBJECT_SELF;
		int nMetaMagic = GetMetaMagicFeat();
		float fDur = TurnsToSeconds( GetCasterLevel(oCaster ));
		if ( nMetaMagic == METAMAGIC_EXTEND ) {
			fDur = fDur * 2;
			} 
		else if ( nMetaMagic == METAMAGIC_PERSISTENT ) {
			fDur = HoursToSeconds( 24 );
			}
		
		//nConcentration determines how many rounds of information a PC Caster gets. 
		int nConcentration = ACR_SkillCheck(SKILL_CONCENTRATION, oCaster, 0, TRUE, FALSE, 0);
		string sRounds = " 1 round.";
		if(nConcentration > 6) {sRounds = " 2 rounds.";} 
		if(nConcentration > 13) {sRounds = " 3 rounds.";} 
		if(nConcentration - GetSkillRank(SKILL_CONCENTRATION, oCaster, FALSE)<= 1) {
			nConcentration = 1;
			DelayCommand(3.0, SendMessageToAllDMs(GetName(oCaster) + " cannot concentrate at all and learns nothing."));
			DelayCommand(3.0, SendMessageToPC(oCaster, "You cannot concentrate at all and learn nothing."));
			return;		
			}
		SendMessageToAllDMs(GetName(oCaster) + "'s Concentration = " + IntToString(nConcentration) + " earns" + sRounds);
		
		//Declare loop variables	
		int nAuraCount;
		int nCreatureCount;
		int nItemCounted;
		int nArcaneMark;
		//Begin looping through all objects in the spellcone
		object oDetected = GetFirstObjectInShape( SHAPE_SPELLCONE, 10.0, GetSpellTargetLocation(), TRUE, OBJECT_TYPE_ALL );
		while (GetIsObjectValid(oDetected)) {
		SignalEvent( oDetected, EventSpellCastAt( OBJECT_SELF, GetSpellId(), FALSE ) );
		
		//Zero out variables common to all objects, for each valid oDetected loop iteration.
		string sAuraPower = "";
		int nAuraPower = 0;
		int nAuraPowerHigh = 0;
		string sAuraPowerHigh = "";
		string sAuraStrength = "";
		string sAuraStrength2 = "";
		string sAuraStrength3 = "";
		string sSchool = "";
		string sSchool2 = "";
		string sSchool3 = "";
		//Let's look at Creatures, Doors, Items, Placeables, Placed Effects, Waypoints, Area of Effect Objects 
			if((oDetected != oCaster) && ((GetObjectType(oDetected) == OBJECT_TYPE_CREATURE) || (GetObjectType(oDetected) == OBJECT_TYPE_DOOR)  || (GetObjectType(oDetected) == OBJECT_TYPE_ITEM) || (GetObjectType(oDetected) == OBJECT_TYPE_PLACEABLE)|| (GetObjectType(oDetected) == OBJECT_TYPE_PLACED_EFFECT) || (GetObjectType(oDetected) == OBJECT_TYPE_TRIGGER) || (GetObjectType(oDetected) == OBJECT_TYPE_AREA_OF_EFFECT)  || (GetObjectType(oDetected) == OBJECT_TYPE_WAYPOINT))){
			
			//Distance and direction per detected object
			string sName = GetName(oDetected);
			float fDistance = GetDistanceBetween(oDetected, oCaster);
			int nDistance = FloatToInt(fDistance);
			string sDistance = IntToString(nDistance);
			float fAngle = GetAngleBetweenObjects(oDetected, oCaster);
			string sAngle = GetCompassDirectionOfAngle(fAngle);
			
			//Let's get Placed Effects out of the way. They can't have variables and have so few properties
			//to hook onto that we have to call out school and power by individual tag.
			if(GetObjectType(oDetected) == OBJECT_TYPE_PLACED_EFFECT) {
				if((FindSubString(GetTag(oDetected), "_containment") != -1) || (FindSubString(GetTag(oDetected), "_encase") != -1)  || (FindSubString(GetTag(oDetected), "_barrier") != -1) || (FindSubString(GetTag(oDetected), "_trap") != -1) || (FindSubString(GetTag(oDetected), "_imprison") != -1)){
						 nAuraCount++;
						 nAuraPower = 3;
						 sAuraStrength = "faint";
						 sName = "A containment field";
						 if(GetIsSkillSuccessful(oCaster, SKILL_SPELLCRAFT, 15 + nAuraPower, FALSE)) {sSchool = " of <color=lightblue>Abjuration</color>";}
					}
				if(FindSubString(GetTag(oDetected), "force") != -1){
						 nAuraCount++;
						 nAuraPower = 5;
						 sAuraStrength = "moderate";
						 sName = "A wall of force";
						 if(GetIsSkillSuccessful(oCaster, SKILL_SPELLCRAFT, 15 + nAuraPower, FALSE)) {sSchool = " of <color=red>Evocation</color>";}
					}	 
				if(FindSubString(GetTag(oDetected), "_ioun_") != -1){
						 nAuraCount++;
						 nAuraPower = 5;
						 sAuraStrength = "strong";
						 object oOwner = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, CREATURE_ALIVE_TRUE, oDetected, 1);
						 string sOwner = GetName(oOwner) + "'s head";
						 if(GetDistanceBetween(oDetected, oOwner) > 2.0) {sOwner = "something";}
						 sName = "A gem spinning around " + sOwner;
						 if(GetIsSkillSuccessful(oCaster, SKILL_SPELLCRAFT, 15 + nAuraPower, FALSE)) {sSchool = " of <color=orange>Transmutation</color>";}
					}	 
				if(FindSubString(GetTag(oDetected), "_elemental") != -1){
						 nAuraCount++;
						 nAuraPower = 5;
						 sAuraStrength = "moderate";
						 sName = "An elemental manifestation";
						 if(GetIsSkillSuccessful(oCaster, SKILL_SPELLCRAFT, 15 + nAuraPower, FALSE)) {sSchool = " of <color=tan>Conjuration</color>";}
					}	 
				if(FindSubString(GetTag(oDetected), "_proj") != -1){
						 nAuraCount++;
						 nAuraPower = 3;
						 sAuraStrength = "faint";
						 sName = "An arcane symbol";
						 if(FindSubString(GetTag(oDetected), "_abj") != -1) {sSchool = " of <color=lightblue>Abjuration</color>";}
						 if(FindSubString(GetTag(oDetected), "_con") != -1) {sSchool = " of <color=tan>Conjuration</color>";}
						 if(FindSubString(GetTag(oDetected), "_div") != -1) {sSchool = " of <color=green>Divination</color>";}
						 if(FindSubString(GetTag(oDetected), "_enc") != -1) {sSchool = " of <color=magenta>Enchantment</color>";}
						 if(FindSubString(GetTag(oDetected), "_evo") != -1) {sSchool = " of <color=red>Evocation</color>";}
						 if(FindSubString(GetTag(oDetected), "_ill") != -1) {sSchool = " of <color=purple>Illusion</color>";}
						 if(FindSubString(GetTag(oDetected), "_nec") != -1) {sSchool = " of <color=white>Necromancy</color>";}
						 if(FindSubString(GetTag(oDetected), "_tra") != -1) {sSchool = " of <color=orange>Transmutation</color>";}
						 if(GetIsSkillSuccessful(oCaster, SKILL_SPELLCRAFT, 15 + nAuraPower, FALSE) == FALSE) {sSchool = "";}
						 }	 
				if((FindSubString(GetTag(oDetected), "_arcane_lamp_") != -1) ||(FindSubString(GetTag(oDetected), "gem_energy") != -1) ||(FindSubString(GetTag(oDetected), "_psychic_") != -1)|| (FindSubString(GetTag(oDetected), "_sparkle") != -1)){
						 nAuraCount++;
						 nAuraPower = 1;
						 sAuraStrength = "faint";
						 sName = "A light";
						 if(GetIsSkillSuccessful(oCaster, SKILL_SPELLCRAFT, 15 + nAuraPower, FALSE)) {sSchool = " of <color=red>Evocation</color>";}
						}	 
				if(GetTag(oDetected) == "abr_afx_gem_energy_blue"){
						 nAuraCount++;
						 nAuraPower = 7;
						 sAuraStrength = "strong";
						 sName = "A teleport field";
						 if(GetIsSkillSuccessful(oCaster, SKILL_SPELLCRAFT, 15 + nAuraPower, FALSE)) {sSchool = " of <color=tan>Conjuration</color>";}
						}	 
				
				//Flag Round 1 Message 	
				SetLocalInt(oCaster, "nMessage1", 1);
					
				//Queue up report to caster if Round 3 achieved
				if((nConcentration > 13) && (nAuraPower > 0)) {
					DelayCommand(21.0, SendMessageToAllDMs( sName + " --" + GetTag(oDetected) +  "-- " + sDistance + "m to the " + sAngle + " has a " + sAuraStrength + " --" + IntToString(nAuraPower) + "-- aura" + sSchool));
					DelayCommand(21.0, SendMessageToPC(oCaster, sName + " " + sDistance + "m to the " + sAngle + " has a " + sAuraStrength + " aura" + sSchool));
					}
			}
				
			//Doors, Placeables, Triggers and Waypoints can carry variables that identify them as magical. 
			if((GetObjectType(oDetected) == OBJECT_TYPE_DOOR) || (GetObjectType(oDetected) == OBJECT_TYPE_PLACEABLE) || (GetObjectType(oDetected) == OBJECT_TYPE_TRIGGER)|| (GetObjectType(oDetected) == OBJECT_TYPE_WAYPOINT)) {
				//Place up to two pairs of ACR_SPELLSCHOOL and ACR_SPELLPOWER integers onto any placeable to have it report school and power to caster. 
				//A third pair of variables reports with a different message structure, but can be used to represent "stored power" inside the other two schools, if you desire.
				//There are also subschools defined here. They are optional, to allow (for instance) Evocation (Sonic) to be discriminated from Evocation (Cold).
				if(GetLocalInt(oDetected, "ACR_SPELLSCHOOL") > 0) {
					nAuraCount++;
					int nACRSpellSchool = GetLocalInt(oDetected, "ACR_SPELLSCHOOL");
					string sACRSubSchool = GetLocalString(oDetected, "ACR_SUBSCHOOL");
					int nAuraPower = GetLocalInt(oDetected, "ACR_SPELLPOWER");
					int nACRSpellSchool2 = GetLocalInt(oDetected, "ACR_SPELLSCHOOL2");
					string sACRSubSchool2 = GetLocalString(oDetected, "ACR_SUBSCHOOL2");
					int nAuraPower2 = GetLocalInt(oDetected, "ACR_SPELLPOWER2");
					int nACRSpellSchool3 = GetLocalInt(oDetected, "ACR_SPELLSCHOOL3");
					string sACRSubSchool3 = GetLocalString(oDetected, "ACR_SUBSCHOOL3");
					int nAuraPower3 = GetLocalInt(oDetected, "ACR_SPELLPOWER3");
					
					if(nAuraPower > 0) {sAuraStrength = "a faint";}
					if(nAuraPower > 3) {sAuraStrength = "a moderate";}
					if(nAuraPower > 6) {sAuraStrength = "a strong";}
					if(nAuraPower > 9) {sAuraStrength = "an overwhelming";}
					if(nAuraPower2 > 0) {sAuraStrength2 = "a faint";}
					if(nAuraPower2 > 3) {sAuraStrength2 = "a moderate";}
					if(nAuraPower2 > 6) {sAuraStrength2 = "a strong";}
					if(nAuraPower2 > 9) {sAuraStrength2 = "an overwhelming";}
					if(nAuraPower3 > 0) {sAuraStrength3 = "a faint";}
					if(nAuraPower3 > 3) {sAuraStrength3 = "a moderate";}
					if(nAuraPower3 > 6) {sAuraStrength3 = "a strong";}
					if(nAuraPower3 > 9) {sAuraStrength3 = "an overwhelming";}
					if(nACRSpellSchool == 1) {sSchool = " of <color=lightblue>Abjuration </color>";}
					if(nACRSpellSchool == 2) {sSchool = " of <color=tan>Conjuration </color>";}
					if(nACRSpellSchool == 3) {sSchool = " of <color=green>Divination </color>";}
					if(nACRSpellSchool == 4) {sSchool = " of <color=magenta>Enchantment </color>";}
					if(nACRSpellSchool == 5) {sSchool = " of <color=red>Evocation </color>";}
					if(nACRSpellSchool == 6) {sSchool = " of <color=purple>Illusion </color>";}
					if(nACRSpellSchool == 7) {sSchool = " of <color=white>Necromancy </color>";}
					if(nACRSpellSchool == 8) {sSchool = " of <color=orange>Transmutation </color>";}
					if(nACRSpellSchool == 9) {sSchool = " of <color=#FFFF00>Universal arcanity</color>";}
					if(nACRSpellSchool2 == 1) {sSchool2 = " of <color=lightblue>Abjuration </color>";}
					if(nACRSpellSchool2 == 2) {sSchool2 = " of <color=tan>Conjuration </color>";}
					if(nACRSpellSchool2 == 3) {sSchool2 = " of <color=green>Divination </color>";}
					if(nACRSpellSchool2 == 4) {sSchool2 = " of <color=magenta>Enchantment </color>";}
					if(nACRSpellSchool2 == 5) {sSchool2 = " of <color=red>Evocation </color>";}
					if(nACRSpellSchool2 == 6) {sSchool2 = " of <color=purple>Illusion </color>";}
					if(nACRSpellSchool2 == 7) {sSchool2 = " of <color=white>Necromancy </color>";}
					if(nACRSpellSchool2 == 8) {sSchool2 = " of <color=orange>Transmutation </color>";}
					if(nACRSpellSchool2 == 9) {sSchool = " of <color=#FFFF00>Universal arcanity</color>";}
					if(nACRSpellSchool3 == 1) {sSchool3 = " of <color=lightblue>Abjuration </color>";}
					if(nACRSpellSchool3 == 2) {sSchool3 = " of <color=tan>Conjuration </color>";}
					if(nACRSpellSchool3 == 3) {sSchool3 = " of <color=green>Divination </color>";}
					if(nACRSpellSchool3 == 4) {sSchool3 = " of <color=magenta>Enchantment </color>";}
					if(nACRSpellSchool3 == 5) {sSchool3 = " of <color=red>Evocation </color>";}
					if(nACRSpellSchool3 == 6) {sSchool3 = " of <color=purple>Illusion </color>";}
					if(nACRSpellSchool3 == 7) {sSchool3 = " of <color=white>Necromancy </color>";}
					if(nACRSpellSchool3 == 8) {sSchool3 = " of <color=orange>Transmutation </color>";}
					if(nACRSpellSchool3 == 9) {sSchool3 = " of <color=#FFFF00>Universal arcanity</color>";}
					if(sACRSubSchool != "") {sSchool = sSchool + "(" + sACRSubSchool + ")";}
					if(sSchool2 != "") {sSchool2 = " and " + sAuraStrength2 + " aura " + sSchool2;}
					if(sACRSubSchool2 != "") {sSchool2 = sSchool2 + "(" + sACRSubSchool2 + ")";}
					if(sSchool3 != "") {sSchool3 = " inside that outer layer. Both surround " +sAuraStrength3 + " amount " + sSchool3;}
					if(sACRSubSchool3 != "") {sSchool3 = sSchool3 + "(" + sACRSubSchool3 + ")";}
					
					//Does the caster learn the school?
					if(GetIsSkillSuccessful(oCaster, SKILL_SPELLCRAFT, 15 + nAuraPower, FALSE) == FALSE) {sSchool = "";}
					
					//Are any of the three pairs of variables the highest power aura encountered thus far? If so, store it.	
					nAuraPowerHigh = GetLocalInt(oCaster, "nAuraPowerHigh");
					if(nAuraPower > nAuraPowerHigh) {
						SetLocalInt(oCaster, "nAuraPowerHigh", nAuraPower);
						SetLocalString(oCaster, "sAuraPowerHigh", sAuraStrength);
						}
					nAuraPowerHigh = GetLocalInt(oCaster, "nAuraPowerHigh");
					if(nAuraPower2 > nAuraPowerHigh) {
						SetLocalInt(oCaster, "nAuraPowerHigh", nAuraPower2);
						SetLocalString(oCaster, "sAuraPowerHigh", sAuraStrength2);
						}
					nAuraPowerHigh = GetLocalInt(oCaster, "nAuraPowerHigh");
					if(nAuraPower3 > nAuraPowerHigh) {
						SetLocalInt(oCaster, "nAuraPowerHigh", nAuraPower3);
						SetLocalString(oCaster, "sAuraPowerHigh", sAuraStrength3);
						}
					
					//Flag Round 1 Message 	
					SetLocalInt(oCaster, "nMessage1", 1);
				
					//Queue up report to caster if Round 3 achieved
					if(nConcentration > 13) {
						if((GetObjectType(oDetected) == OBJECT_TYPE_TRIGGER) || (GetObjectType(oDetected) == OBJECT_TYPE_WAYPOINT)) {sName = "Something";}
						DelayCommand(21.0, SendMessageToAllDMs(GetName(oDetected) + " --" +sName + "-- " + sDistance + "m to the " + sAngle + " has " + sAuraStrength + " --" + IntToString(nAuraPower) + "-- aura" + sSchool + sSchool2 + sSchool3));
						DelayCommand(21.0, SendMessageToPC(oCaster, sName + " " + sDistance + "m to the " + sAngle + " has " + sAuraStrength + " aura" + sSchool + sSchool2 + sSchool3));
						}
						
					//SpellSchools done. Zero out all variables because these variables can also be needed by any of the specific use cases below
					sSchool = "";
					sSchool2 = "";
					sSchool3 = ""; 
					sACRSubSchool = "";
					sACRSubSchool2 = "";
					sACRSubSchool3 = "";
					nAuraPower = 0;
					nAuraPower2 = 0;
					}
				}
		
			//Multi-type objects with standardized tags or variables
			if((GetObjectType(oDetected) == OBJECT_TYPE_DOOR) || (GetObjectType(oDetected) == OBJECT_TYPE_PLACEABLE) || (GetObjectType(oDetected) == OBJECT_TYPE_ITEM) || (GetObjectType(oDetected) == OBJECT_TYPE_CREATURE)|| (GetObjectType(oDetected) == OBJECT_TYPE_TRIGGER) || (GetObjectType(oDetected) == OBJECT_TYPE_WAYPOINT)) {
				//Arcane Mark
				//SendMessageToAllDMs("Arcane Mark");
				int nMarked = 0;
				int nAM = 0;
				if(nArcaneMark != 1) {
					nArcaneMark = 1;
					object oMarked = GetArea(oCaster);
					while (nAM < 5) {
					//SendMessageToAllDMs(IntToString(nAM) + " " + GetTag(oMarked));
				
						nAM++;
						if(ACR_GetPersistentString(oMarked, "ACR_ARCANEMARK" + IntToString(nAM)) != "") {
							location lMarked = ACR_GetPersistentLocation(oMarked, "ACR_ARCANEMARKLoc" + IntToString(nAM));
							location lFacing = GetAheadLocation(oCaster, GetDistanceBetweenLocations(lMarked, GetLocation(oCaster)));
							float fDistanceFace = GetDistanceBetweenLocations(lMarked, lFacing);
							
							if(fDistanceFace < 5.0) {
								sName = "A nearby location";
								object oMark = GetFirstObjectInShape(SHAPE_SPHERE, 1.0, lMarked, TRUE, OBJECT_TYPE_PLACEABLE);
								while (oMark != OBJECT_INVALID) {
									//SendMessageToAllDMs("DM" + IntToString(nAM) + " " + GetTag(oMark));
				    				if(GetTag(oMark) == "ipoint_arcane_mark") {nMarked = 1;}
									if(oMark != GetNextObjectInShape(SHAPE_SPHERE, 1.0, lMarked, TRUE, OBJECT_TYPE_PLACEABLE)) {
										oMark = GetNextObjectInShape(SHAPE_SPHERE, 1.0, lMarked, TRUE, OBJECT_TYPE_PLACEABLE);
										}
									else {break;}
									}
								if(nMarked != 1) {DelayCommand(6.0, ActionCreatePlaceable("ipoint_arcane_mark", lMarked));}
			
								nAuraCount++;
								nAuraPower = 1;
								sAuraStrength = "faint";
								if(GetIsSkillSuccessful(oCaster, SKILL_SPELLCRAFT, 15 + nAuraPower, FALSE)) {sSchool = " of <color=#FFFF00>Universal arcanity</color>";}
									
								//Flag Round 1 Message 	
								SetLocalInt(oCaster, "nMessage1", 1);
								
								//Queue up report to caster if Round 3 achieved
								if(nConcentration > 13) {
									DelayCommand(21.0, SendMessageToAllDMs(sName + " --" +sName + " has an arcane mark that glows with a " + sAuraStrength + " --" + IntToString(nAuraPower) + "-- aura" + sSchool));
									DelayCommand(21.0, SendMessageToPC(oCaster, sName + " has an arcane mark that glows with a " + sAuraStrength + " aura" + sSchool));
									}
								}
							}
						}
					}
					
				nMarked = 0;
				nAM = 0;
				while (nAM < 5) {
					nAM++;
					//SendMessageToAllDMs(IntToString(nAM) + " " + GetTag(oDetected));
				    if(ACR_GetPersistentString(oDetected, "ACR_ARCANEMARK" + IntToString(nAM)) != "") {
						//SendMessageToAllDMs(IntToString(nAM) + " " + ACR_GetPersistentString(oDetected, "ACR_ARCANEMARK" + IntToString(nAM)));
				    	location lMarked = ACR_GetPersistentLocation(oDetected, "ACR_ARCANEMARKLoc" + IntToString(nAM));
						string sMarked = ACR_LocationToString(lMarked);
						//SendMessageToAllDMs(IntToString(nAM) + " " + sMarked);
				    	string sMarkedProxy = ACR_LocationToString(GetLocation(oDetected));
						int nXStart = FindSubString(sMarked, "#X#", 0);
						string sXYMarked = GetSubString(sMarked, nXStart, 30);
						string sXYMarkedProxy = GetSubString(sMarkedProxy, nXStart, 30);
						sName = GetName(oDetected);
						if(sXYMarked != sXYMarkedProxy) {sName = "A nearby location";}
						object oMark = GetFirstObjectInShape(SHAPE_SPHERE, 1.0, lMarked, TRUE, OBJECT_TYPE_PLACEABLE);
						while (oMark != OBJECT_INVALID) {
						//SendMessageToAllDMs("DM" + IntToString(nAM) + " " + GetTag(oMark));
				    		if(GetTag(oMark) == "ipoint_arcane_mark") {nMarked = 1;}
							if(oMark != GetNextObjectInShape(SHAPE_SPHERE, 1.0, lMarked, TRUE, OBJECT_TYPE_PLACEABLE)) {
								oMark = GetNextObjectInShape(SHAPE_SPHERE, 1.0, lMarked, TRUE, OBJECT_TYPE_PLACEABLE);
								}
							else {break;}
							}
						if(nMarked != 1) {DelayCommand(6.0, ActionCreatePlaceable("ipoint_arcane_mark", lMarked));}
			
						nAuraCount++;
						nAuraPower = 1;
						sAuraStrength = "faint";
						if(GetIsSkillSuccessful(oCaster, SKILL_SPELLCRAFT, 15 + nAuraPower, FALSE)) {sSchool = " of <color=#FFFF00>Universal arcanity</color>";}
							
						//Flag Round 1 Message 	
						SetLocalInt(oCaster, "nMessage1", 1);
						
						//Queue up report to caster if Round 3 achieved
						if(nConcentration > 13) {
							DelayCommand(21.0, SendMessageToAllDMs(sName + " has an arcane mark that glows with a " + sAuraStrength + " --" + IntToString(nAuraPower) + "-- aura" + sSchool));
							DelayCommand(21.0, SendMessageToPC(oCaster, sName + " has an arcane mark that glows with a " + sAuraStrength + " aura" + sSchool));
							}
						}
					}
				}
			
		//Detect Magic: Glyph of Warding
		if(GetObjectType(oDetected) == OBJECT_TYPE_AREA_OF_EFFECT) {
			int nAOESpell = GetAreaOfEffectSpellId(oDetected);
			if(nAOESpell == 549) {
				nAuraCount++;
				nAuraPower = 3;
				sAuraStrength = "faint";
				if(GetIsSkillSuccessful(oCaster, SKILL_SPELLCRAFT, 15 + nAuraPower, FALSE)) {sSchool = " of <color=lightblue>Abjuration</color>";}
										
				//Flag Round 1 Message 	
				SetLocalInt(oCaster, "nMessage1", 1);
									
				//Queue up report to caster if Round 3 achieved
				if(nConcentration > 13) {
					DelayCommand(21.0, SendMessageToAllDMs("A nearby location has a glyph that glows with a " + sAuraStrength + " --" + IntToString(nAuraPower) + "-- aura" + sSchool));
					DelayCommand(21.0, SendMessageToPC(oCaster, "A nearby location has a glyph that glows with a " + sAuraStrength + " aura" + sSchool));
					}
				}
			}
				
			//Portals
			if((GetObjectType(oDetected) == OBJECT_TYPE_PLACEABLE) || (GetObjectType(oDetected) == OBJECT_TYPE_TRIGGER)) {
				//If they are tagged as per the line below, DM is automatic for them and they will register as Strong Conjuration.
				 if(FindSubString(GetTag(oDetected), "_portal")!= -1) {
				    nAuraCount++;
					nAuraPower = 7;
					sAuraStrength = "strong";
					if(GetIsSkillSuccessful(oCaster, SKILL_SPELLCRAFT, 15 + nAuraPower, FALSE)) {sSchool = " of <color=tan>Conjuration</color>";}
					
					//Flag Round 1 Message 	
					SetLocalInt(oCaster, "nMessage1", 1);
				
					//Queue up report to caster if Round 3 achieved
					if(nConcentration > 13) {
						DelayCommand(21.0, SendMessageToAllDMs(GetName(oDetected) + " --" +sName + "-- " + sDistance + "m to the " + sAngle + " has a " + sAuraStrength + " --" + IntToString(nAuraPower) + "-- aura" + sSchool));
						DelayCommand(21.0, SendMessageToPC(oCaster, sName + " " + sDistance + "m to the " + sAngle + " has a " + sAuraStrength + " aura" + sSchool));
						}
					}
				
				//Glyph and symbol traps after they've fired, and the triggers that fire them.
				//If they are tagged correctly as below, DM is automatic for them. They will report as follows:
				/*
				Glyph of Warding = Faint Abjuration
				Symbol of Pain = Moderate Necromancy
				Symbol of Sleep = Moderate Enchantment
				Symbol of Fear = Moderate Necromancy
				Symbol of Persuasion = Moderate Enchantment
				Symbol of Weakness = Strong Necromancy
				Symbol of Stunning = Strong Enchantment
				Symbol of Death = Strong Necromancy
				Symbol of Insanity = Strong Enchantment
				*/
				
				 if(((FindSubString(GetTag(oDetected), "_glyph_ward") != -1) || (FindSubString(GetTag(oDetected), "_symbol_") != -1)) && (FindSubString(GetTag(oDetected), "_det") == -1) && (GetLocalInt(oDetected, "Fired") != 1)) {
					nAuraCount++;
					if(FindSubString(GetTag(oDetected), "_glyph_") != -1) {sSchool = "of Abjuration"; nAuraPower = 3;}
					if((FindSubString(GetTag(oDetected), "_symbol_fear") != -1) || (FindSubString(GetTag(oDetected), "_symbol_pers") != -1) || (FindSubString(GetTag(oDetected), "_symbol_sleep") != -1) || (FindSubString(GetTag(oDetected), "_symbol_stun") != -1)) {sSchool = " of <color=magenta>Enchantment</color>";}
					if((FindSubString(GetTag(oDetected), "_symbol_weakness") != -1) || (FindSubString(GetTag(oDetected), "_symbol_pain") != -1) || (FindSubString(GetTag(oDetected), "_symbol_death") != -1)) {sSchool = " of <color=white>Necromancy</color>";}
					if((FindSubString(GetTag(oDetected), "_symbol_pain") != -1) || (FindSubString(GetTag(oDetected), "_symbol_sleep") != -1)) {nAuraPower = 5;}
					if((FindSubString(GetTag(oDetected), "_symbol_pers") != -1) || (FindSubString(GetTag(oDetected), "_symbol_fear") != -1)) {nAuraPower = 6;}
					if((FindSubString(GetTag(oDetected), "_symbol_stun") != -1) || (FindSubString(GetTag(oDetected), "_symbol_weakness") != -1)) {nAuraPower = 7;}
					if((FindSubString(GetTag(oDetected), "_symbol_insanity") != -1) || (FindSubString(GetTag(oDetected), "_symbol_death") != -1)) {nAuraPower = 8;}
					if(nAuraPower > 0) {sAuraStrength = "faint";}
					if(nAuraPower > 3) {sAuraStrength = "moderate";}
					if(nAuraPower > 6) {sAuraStrength = "strong";}
					if(nAuraPower > 9) {sAuraStrength = "overwhelming";}
					
					//Does the caster learn the school?
					if(!GetIsSkillSuccessful(oCaster, SKILL_SPELLCRAFT, 15 + nAuraPower, FALSE)){sSchool = "";}
					
					//Flag Round 1 Message 	
					SetLocalInt(oCaster, "nMessage1", 1);
				
					//Queue up report to caster if Round 3 achieved
					string sSymbolName = GetName(oDetected);	
					if(GetObjectType(oDetected) == OBJECT_TYPE_TRIGGER) {sSymbolName = "Something";}		
					if(nConcentration > 13) {
						DelayCommand(21.0, SendMessageToAllDMs("Glyph or Symbol " + sSymbolName + " --" + GetName(oDetected) + "-- centered on a spot " + sDistance + "m " + sAngle + " of " + GetName(oCaster) + " gives off a " + sAuraStrength + " --" + IntToString(nAuraPower) + "-- aura " + sSchool));
						DelayCommand(21.0, SendMessageToPC(oCaster, sSymbolName + " centered on a spot " + sDistance + "m " + sAngle + " of " + GetName(oCaster) + " gives off a " + sAuraStrength + " aura " + sSchool));
						}
					}
				}	
						
			//Walls of Force tagged or named with "Forcefield" will register automatically as Moderate Evocation
			if((FindSubString(GetName(oDetected), "Forcefield") != -1) || (FindSubString(GetTag(oDetected), "forcefield") != -1)){
				nAuraCount++;
				nAuraPower = 5;
				sAuraStrength = "moderate";
					
				//Does the caster learn the school?
				if(GetIsSkillSuccessful(oCaster, SKILL_SPELLCRAFT, 15 + nAuraPower, FALSE)) {sSchool = " of <color=red>Evocation</color>";}
					
				//Flag Round 1 Message 	
				SetLocalInt(oCaster, "nMessage1", 1);
				
				//Queue up report to caster if Round 3 achieved
				if(nConcentration > 13) {
					DelayCommand(21.0, SendMessageToAllDMs(GetName(oDetected) + " --" +sName + "-- " + sDistance + "m to the " + sAngle + " has a " + sAuraStrength + " --" + IntToString(nAuraPower) + "-- aura" + sSchool));
					DelayCommand(21.0, SendMessageToPC(oCaster, sName + " " + sDistance + "m to the " + sAngle + " has a " + sAuraStrength + " aura" + sSchool));
					}
				}
					
			//Specific Waypoint use cases include traps 		
			if(GetObjectType(oDetected) == OBJECT_TYPE_WAYPOINT)  {
				//Traps, if placed, already have the ACR_TRAP_SPELL_ID on them. If spawned, they do not.
				//To have a spawning trap report to the caster, put the ACR_TRAP_SPELL_ID spell integer onto the spawnpoint itself.
				if(GetLocalInt(oDetected, "ACR_TRAP_SPELL_ID") > 0) {
					nAuraCount++;
					int nSpellID = GetLocalInt(oDetected, "ACR_TRAP_SPELL_ID");
					//Pull the spell school from the spells 2DA for the ACR_TRAP_SPELL_ID spell integer.
					sSchool = Get2DAString("spells", "School", nSpellID);
					if(sSchool == "A") {sSchool = " of <color=lightblue>Abjuration</color>";}
					if(sSchool == "C") {sSchool = " of <color=tan>Conjuration</color>";}
					if(sSchool == "D") {sSchool = " of <color=green>Divination</color>";}
					if(sSchool == "E") {sSchool = " of <color=magenta>Enchantment</color>";}
					if(sSchool == "H") {sSchool = " of <color=white>Holy</color>";}
					if(sSchool == "I") {sSchool = " of <color=purple>Illusion</color>";}
					if(sSchool == "N") {sSchool = " of <color=white>Necromancy</color>";}
					if(sSchool == "T") {sSchool = " of <color=orange>Transmutation</color>";}
					if(sSchool == "V") {sSchool = " of <color=red>Evocation</color>";}
					if(sSchool == "G") {sSchool = " of <color=#FFFF00>Universal arcanity</color>";}
					//Pull the spell level from the spells 2DA.
					sAuraPower = Get2DAString("spells", "Innate", nSpellID);
					nAuraPower = StringToInt(sAuraPower);
					sAuraStrength = "an indeterminately powerful";
					if(nAuraPower > 0) {sAuraStrength = "a faint";}
					if(nAuraPower > 3) {sAuraStrength = "a moderate";}
					if(nAuraPower > 6) {sAuraStrength = "a strong";}
					if(nAuraPower > 9) {sAuraStrength = "an overwhelming";}
					
					//Does the caster learn the school?		
					if(!GetIsSkillSuccessful(oCaster, SKILL_SPELLCRAFT, 15 + nAuraPower, FALSE)){sSchool = "";}
					
					//Flag Round 1 Message 	
					SetLocalInt(oCaster, "nMessage1", 1);
													
					//Check for trap origin and distance and direction from Origin to trap
					object oOrigin = GetNearestObjectByTag("TRAP_ORIGIN", oDetected, 1);
					float fDistance = GetDistanceBetween(oCaster, oOrigin);
					int nDistance = FloatToInt(fDistance);
					float fAngle = GetAngleBetweenObjects(oCaster, oOrigin);
					string sAngle = GetCompassDirectionOfAngle(fAngle);
					string sDistance = ", " + IntToString(nDistance) + "m " + sAngle + ",";
					float fSeparate = GetDistanceBetween(oDetected, oOrigin);
					int nSeparate = FloatToInt(fSeparate);
					string sSeparate = IntToString(nSeparate);
					float fAngleSeparate = GetAngleBetweenObjects(oDetected, oOrigin);
					string sAngleSeparate = GetCompassDirectionOfAngle(fAngleSeparate);
					string sSeparated = " and a circle centered on a spot" + sSeparate + "m " + sAngleSeparate + " of " + GetName(oOrigin);
					if(nDistance = 0) {sSeparated = "";}
					
					//If there is a valid Origin placeable and the caster earned a Round 3, queue up the report.
					if((nConcentration > 13) && (oOrigin != OBJECT_INVALID)) {
						DelayCommand(21.0, SendMessageToAllDMs("Trap origin --" + GetName(oOrigin) + sSeparated + " gives off " + sAuraStrength + " --" + IntToString(nAuraPower) + "--  aura" + sSchool));
						DelayCommand(21.0, SendMessageToPC(oCaster, GetName(oOrigin) + sDistance + sSeparated + " gives off " + sAuraStrength + " aura" + sSchool));
						}
					}
				}
					
				//Creatures are the most complicated use case. Creatures can have innate magic, and effects, and inventory.
				if((GetObjectType(oDetected) == OBJECT_TYPE_CREATURE) && (GetIsDM(oDetected) == FALSE)) {
					int nRace = GetRacialType(oDetected);
					//Certain races have a lingering magic about them because of their nature, or how they were created/summoned
					string sRace = "";
					if(nRace == 10) {sRace = "Construct"; sSchool = "<color=orange> Transmutation</color>";}
					if(nRace == 16) {sRace = "Elemental"; sSchool = "<color=tan> Conjuration</color>";}
					if(nRace == 17) {sRace = "Fey";  sSchool = "<color=magenta> Enchantment</color>";}
					if(nRace == 19) {sRace = "Magical Beast"; sSchool = "<color=#D3D3D3> Innate Magic</color>";}
					if(nRace == 20) {sRace = "Outsider"; sSchool = "<color=tan> Conjuration</color>";}
					if(nRace == 23) {sRace = "Shapechanger"; sSchool = "<color=orange> Transmutation</color>";}
					if(nRace == 24) {sRace = "Undead"; sSchool = "<color=white> Necromancy</color>";}
					//Scrying sensors are creatures. They spawn invisible, but when detected, become visible.
					if(FindSubString(GetTag(oDetected), "003_cr_scry_sen") != -1) {sName = "A scrying sensor"; sRace = "Scrying Sensor"; sSchool = "<color=green>Divination</color>";
						effect eEffect = GetFirstEffect(oDetected);
						int nRep = 0;
						int nInvis = 0;
						while ((GetIsEffectValid(eEffect)) && (nRep < 10)) { 
							 if(GetEffectType(eEffect) == 56) {sName = "Something"; SetLocalInt(oDetected, "nInvis", 1);}
							 nInvis = GetLocalInt(oDetected, "nInvis");
							 eEffect = GetNextEffect(oDetected);
							 nRep ++;
							}
						} 
						
					//Does the caster learn the school?	
					if(GetIsSkillSuccessful(oCaster, SKILL_SPELLCRAFT, 15 + nAuraPower, FALSE)) {sSchool = " of " + sSchool;}
					
					//Sometimes creatures are invisible, in which case we don't want their name being bandied about willy-nilly.
					if((GetHasSpellEffect(SPELL_INVISIBILITY, oDetected)) || (GetHasSpellEffect(SPELL_INVISIBILITY_SPHERE, oDetected)) || (GetHasSpellEffect(SPELL_GREATER_INVISIBILITY, oDetected))  || (GetHasSpellEffect(SPELL_MASS_INVISIBILITY, oDetected))) {sName = "Something"; SetLocalInt(oDetected, "nInvis", 1);int nInvis = GetLocalInt(oDetected, "nInvis");}  
					
					//If the critter is innately magical, let's define its power as one half its CR, to fit within the base 10 scale.
					if(sRace != ""){
						nAuraCount++;
						float fAuraPower = GetChallengeRating(oDetected);
						nAuraPower = FloatToInt(fAuraPower)/2;
						if(nAuraPower > 0) {sAuraStrength = "a faint";}
						if(nAuraPower > 3) {sAuraStrength = "a moderate";}
						if(nAuraPower > 6) {sAuraStrength = "a strong";}
						if(nAuraPower > 9) {sAuraStrength = "an overwhelming";}
						
						//Flag Round 1 Message 	
						SetLocalInt(oCaster, "nMessage1", 1);
				
						//Queue up report to caster if Round 3 achieved
						if(nConcentration > 13) {
							DelayCommand(21.0, SendMessageToAllDMs(sName + " has a " + sAuraStrength + " lingering aura of " + sSchool));
							DelayCommand(21.1, SendMessageToPC(oCaster, sName + " has a " + sAuraStrength + " lingering aura" + sSchool));
							}
						}
					
					//Start looping through effects and cross-referencing their spell, school, and power from the 2da by the Effect Spell ID
					effect eEffect = GetFirstEffect(oDetected);
					int nEffect = 0; 
					string sEffect = "";
					string sEffectSchool = "";
					string sEffectStrength = "";
					int nEffectSchool = 0;
					int nEffectCount = 0;
					int nEffectSpell = 0;
					int nEffectSchoolHigh = 0;
					while (GetIsEffectValid(eEffect)) {
						//Invisibility is sometimes not a spell effect but should always be one, so force it.
						if(GetEffectType(eEffect) == 56) {
							nEffectCount++; 
							nAuraCount++; 
							SetLocalString(oDetected, "sEffectStrength_I", "a moderate"); 
							SetLocalInt(oDetected, "nEffectSchoolHigh_I", 4); 
							SetLocalString(oDetected, "sEffectSpell_I" , GetLocalString(oDetected, "sEffectSpell_I") + ", Invisibility" );
							SetLocalInt(oDetected, "nInvis", 1);
							}
						nEffect = GetEffectSpellId(eEffect); 
						//If this is a valid spell aura, increment auras and effects in total as well as auras by school on this creature
						if(nEffect != -1) {
							sEffect = Get2DAString("spells", "Label", nEffect);
							//Weed out spell duplicates because effects report multiple times without this
							if(GetLocalString(oDetected, "sEffect_" + sEffect) != sEffect) {
								SetLocalString(oDetected, "sEffect_" + sEffect, sEffect);
								nAuraCount++;
								nEffectCount++;
								sEffectSchool = Get2DAString("spells", "School", nEffect);
								sAuraPower = Get2DAString("spells", "Innate", nEffect);
								nAuraPower = StringToInt(sAuraPower);
								if(nAuraPower > 0) {sEffectStrength = "a faint";}
								if(nAuraPower > 3) {sEffectStrength = "a moderate";}
								if(nAuraPower > 6) {sEffectStrength = "a strong";}
								if(nAuraPower > 9) {sEffectStrength = "an overwhelming";}
									
								//Store highest aura, total and by school
								nAuraPowerHigh = GetLocalInt(oCaster, "nAuraPowerHigh");
								if(nAuraPower > nAuraPowerHigh) {
									SetLocalInt(oCaster, "nAuraPowerHigh", nAuraPower);
									SetLocalString(oCaster, "sAuraPowerHigh", sEffectStrength);
									}
								nEffectSchoolHigh = GetLocalInt(oDetected, "nEffectSchoolHigh_" + sEffectSchool);
								if(nAuraPower > nEffectSchoolHigh) {
									SetLocalInt(oDetected, "nEffectSchoolHigh_" + sEffectSchool, nAuraPower);
									SetLocalString(oDetected, "sEffectStrength_" + sEffectSchool, sEffectStrength);
									}
									
								//Keep track of all active spells by school for DM information, just because we can	
								SetLocalString(oDetected, "sEffectSpell_" + sEffectSchool, GetLocalString(oDetected, "sEffectSpell_" + sEffectSchool) + ", " + sEffect);
										
								//Flag Round 1 Message 	
								SetLocalInt(oCaster, "nMessage1", 1);
								
								//Queue up headers for report to caster if first effect and Round 3 achieved.
								if((nConcentration > 13) && (nEffectCount == 1) && (GetLocalInt(oDetected, "nInvis")== 0)) {
									DelayCommand(23.5, SendMessageToAllDMs("**********"));
									DelayCommand(23.6, SendMessageToAllDMs("FUNCTIONING SPELLS: " + GetName(oDetected) + " --" + sName ));
									DelayCommand(23.5, SendMessageToPC(oCaster, "**********"));
									DelayCommand(23.6, SendMessageToPC(oCaster, "FUNCTIONING SPELLS: " + sName));
									}
								}
							}
						eEffect = GetNextEffect(oDetected);
						}	
								
						int nInvis = GetLocalInt(oDetected, "nInvis");
						string sColor = "<color=#666666>";
						if(nInvis == 1) {sColor = "<color=#FFFF00>";sName = "Something "  + IntToString(FloatToInt(GetDistanceBetween(oCaster, oDetected))) + "m to the " + sAngle;}
						
						//Queue up report to caster if Round 3 achieved
						if(nConcentration > 13) {
							float fSummaryDelay = 24.5;
							if(GetLocalInt(oDetected, "nEffectSchoolHigh_A") > 0) {DelayCommand(fSummaryDelay, SendMessageToAllDMs(GetName(oDetected) + sColor + " --" + sName + "-- has " + GetLocalString(oDetected, "sEffectStrength_A") + " --" + IntToString(nAuraPower) + "</color>-- aura of <color=lightblue>Abjuration </color> --" + GetLocalString(oDetected, "sEffectSpell_A")));}
							if(GetLocalInt(oDetected, "nEffectSchoolHigh_C") > 0) {DelayCommand(fSummaryDelay, SendMessageToAllDMs(GetName(oDetected) + sColor + " --" + sName + "-- has " + GetLocalString(oDetected, "sEffectStrength_C") + " --" + IntToString(nAuraPower) + "</color>-- aura of <color=tan>Conjuration </color> --" + GetLocalString(oDetected, "sEffectSpell_C")));}
							if(GetLocalInt(oDetected, "nEffectSchoolHigh_D") > 0) {DelayCommand(fSummaryDelay, SendMessageToAllDMs(GetName(oDetected) + sColor + " --" + sName + "-- has " + GetLocalString(oDetected, "sEffectStrength_D") + " --" + IntToString(nAuraPower) + "</color>-- aura of <color=green>Divination </color> --" + GetLocalString(oDetected, "sEffectSpell_D")));}
							if(GetLocalInt(oDetected, "nEffectSchoolHigh_E") > 0) {DelayCommand(fSummaryDelay, SendMessageToAllDMs(GetName(oDetected) + sColor + " --" + sName + "-- has " + GetLocalString(oDetected, "sEffectStrength_E") + " --" + IntToString(nAuraPower) + "</color>-- aura of <color=magenta>Enchantment </color> --" + GetLocalString(oDetected, "sEffectSpell_E")));}
							if(GetLocalInt(oDetected, "nEffectSchoolHigh_V") > 0) {DelayCommand(fSummaryDelay, SendMessageToAllDMs(GetName(oDetected) + sColor + " --" + sName + "-- has " + GetLocalString(oDetected, "sEffectStrength_V") + " --" + IntToString(nAuraPower) + "</color>-- aura of <color=red>Evocation </color> --" + GetLocalString(oDetected, "sEffectSpell_V")));}
							if(GetLocalInt(oDetected, "nEffectSchoolHigh_I") > 0) {DelayCommand(fSummaryDelay, SendMessageToAllDMs(GetName(oDetected) + sColor + " --" + sName + "-- has " + GetLocalString(oDetected, "sEffectStrength_I") + " --" + IntToString(nAuraPower) + "</color>-- aura of <color=purple>Illusion </color> --" + GetLocalString(oDetected, "sEffectSpell_I")));}
							if(GetLocalInt(oDetected, "nEffectSchoolHigh_N") > 0) {DelayCommand(fSummaryDelay, SendMessageToAllDMs(GetName(oDetected) + sColor + " --" + sName + "-- has " + GetLocalString(oDetected, "sEffectStrength_N") + " --" + IntToString(nAuraPower) + "</color>-- aura of <color=white>Necromancy </color> --" + GetLocalString(oDetected, "sEffectSpell_N")));}
							if(GetLocalInt(oDetected, "nEffectSchoolHigh_T") > 0) {DelayCommand(fSummaryDelay, SendMessageToAllDMs(GetName(oDetected) + sColor + " --" + sName + "-- has " + GetLocalString(oDetected, "sEffectStrength_T") + " --" + IntToString(nAuraPower) + "</color>-- aura of <color=orange>Transmutation </color> --" + GetLocalString(oDetected, "sEffectSpell_T")));}
							if(GetLocalInt(oDetected, "nEffectSchoolHigh_G") > 0) {DelayCommand(fSummaryDelay, SendMessageToAllDMs(GetName(oDetected) + sColor + " --" + sName + "-- has " + GetLocalString(oDetected, "sEffectStrength_G") + " --" + IntToString(nAuraPower) + "</color>-- aura of <color=yellow>Universal arcanity </color> --" + GetLocalString(oDetected, "sEffectSpell_G")));}
								
							if(GetLocalInt(oDetected, "nEffectSchoolHigh_A") > 0) {DelayCommand(fSummaryDelay, SendMessageToPC(oCaster, sColor + sName + " has " + GetLocalString(oDetected, "sEffectStrength_A")  + "</color> aura of <color=lightblue>Abjuration </color>"));}
							if(GetLocalInt(oDetected, "nEffectSchoolHigh_C") > 0) {DelayCommand(fSummaryDelay, SendMessageToPC(oCaster, sColor + sName + " has " + GetLocalString(oDetected, "sEffectStrength_C")  + "</color> aura of <color=tan>Conjuration </color>"));}
							if(GetLocalInt(oDetected, "nEffectSchoolHigh_D") > 0) {DelayCommand(fSummaryDelay, SendMessageToPC(oCaster, sColor + sName + " has " + GetLocalString(oDetected, "sEffectStrength_D")  + "</color> aura of <color=green>Divination </color>"));}
							if(GetLocalInt(oDetected, "nEffectSchoolHigh_E") > 0) {DelayCommand(fSummaryDelay, SendMessageToPC(oCaster, sColor + sName + " has " + GetLocalString(oDetected, "sEffectStrength_E")  + "</color> aura of <color=magenta>Enchantment </color>"));}
							if(GetLocalInt(oDetected, "nEffectSchoolHigh_V") > 0) {DelayCommand(fSummaryDelay, SendMessageToPC(oCaster, sColor + sName + " has " + GetLocalString(oDetected, "sEffectStrength_V")  + "</color> aura of <color=red>Evocation </color>"));}
							if(GetLocalInt(oDetected, "nEffectSchoolHigh_I") > 0) {DelayCommand(fSummaryDelay, SendMessageToPC(oCaster, sColor + sName + " has " + GetLocalString(oDetected, "sEffectStrength_I")  + "</color> aura of <color=purple>Illusion </color>"));}
							if(GetLocalInt(oDetected, "nEffectSchoolHigh_N") > 0) {DelayCommand(fSummaryDelay, SendMessageToPC(oCaster, sColor + sName + " has " + GetLocalString(oDetected, "sEffectStrength_N")  + "</color> aura of <color=white>Necromancy </color>"));}
							if(GetLocalInt(oDetected, "nEffectSchoolHigh_T") > 0) {DelayCommand(fSummaryDelay, SendMessageToPC(oCaster, sColor + sName + " has " + GetLocalString(oDetected, "sEffectStrength_T")  + "</color> aura of <color=orange>Transmutation </color>"));}
							if(GetLocalInt(oDetected, "nEffectSchoolHigh_G") > 0) {DelayCommand(fSummaryDelay, SendMessageToPC(oCaster, sColor + sName + " has " + GetLocalString(oDetected, "sEffectStrength_G")  + "</color> aura of <color=yellow>Universal arcanity </color>"));}
							}	
					}
				
				//Zero out effect specific variables.
				SetLocalInt(oDetected, "nEffectSchoolHigh_A", 0);
				SetLocalInt(oDetected, "nEffectSchoolHigh_C", 0);
				SetLocalInt(oDetected, "nEffectSchoolHigh_D", 0);
				SetLocalInt(oDetected, "nEffectSchoolHigh_E", 0);
				SetLocalInt(oDetected, "nEffectSchoolHigh_V", 0);
				SetLocalInt(oDetected, "nEffectSchoolHigh_I", 0);
				SetLocalInt(oDetected, "nEffectSchoolHigh_N", 0);
				SetLocalInt(oDetected, "nEffectSchoolHigh_T", 0);
				SetLocalInt(oDetected, "nEffectSchoolHigh_G", 0);
					
				nAuraPowerHigh = GetLocalInt(oCaster, "nAuraPowerHigh");
				if(nAuraPower > nAuraPowerHigh) {
					SetLocalInt(oCaster, "nAuraPowerHigh", nAuraPower);
					SetLocalString(oCaster, "sAuraPowerHigh", sAuraStrength);
					}
				
				//Creature race and effects done.
				//Zero out variables needed for this creature's items, which are about to be determined.
				sSchool = "";
				nAuraPower = 0;
				
				//Begin items, in creature or placeable inventory, or loose.	
				//Declare item variables
				object oItem;
				int nSlot;
				string sSlot;
				
				//Placeables and creatures can have items, and items can also be found outside of inventories. We have to deal with all of that.
				if(((GetObjectType(oDetected) == OBJECT_TYPE_PLACEABLE) && (GetHasInventory(oDetected))) || ((GetObjectType(oDetected) == OBJECT_TYPE_CREATURE) && (GetIsDM(oDetected) == FALSE)) || (GetObjectType(oDetected) == OBJECT_TYPE_ITEM)){
					//We're going to check every slot in a creature, and every inventory slot in a creature or placeable.
					//If oDetected is a loose item, on the other hand, we don't need slots or inventory, so set the upcoming loop to its last iteration.
					if(GetObjectType(oDetected) == OBJECT_TYPE_ITEM) {oItem = oDetected; nSlot = 14; sSlot = IntToString(FloatToInt(GetDistanceBetween(oCaster, oDetected))) + "m to the " + sAngle;}
						else {oItem = GetFirstItemInInventory(oDetected);}
						//Zero out the schools of magic counts before item loops.
						int nFirst = 0;
						int nGen = 0;
						int nAbj = 0;
						int nCon = 0;
						int nDiv = 0;
						int nEnc = 0;
						int nEvo = 0;
						int nIll = 0;
						int nNec = 0;
						int nTra = 0;
						int nSomething = 0;
						//Loop through inventory slots, starting with equipped items. If a placeable, just loop through inventory.
						while (nSlot < 15) {
							if(GetObjectType(oDetected) == OBJECT_TYPE_PLACEABLE) {nSlot = 14;}		
							if((nFirst == 0) && (GetObjectType(oDetected) == OBJECT_TYPE_CREATURE)) {nCreatureCount++;nFirst = 1; sSlot = "in the inventory of " + GetName(oDetected);}
							else if (nSlot < 14) {
								oItem = GetItemInSlot(nSlot, oDetected); 
								if(nSlot == 0) {sSlot = "on the head of";}
								if(nSlot == 1) {sSlot = "worn by";}
								if(nSlot == 2) {sSlot = "on the feet of";}
								if(nSlot == 3) {sSlot = "on the arms of";}
								if(nSlot == 4) {sSlot = "in the right hand of";}
								if(nSlot == 5) {sSlot = "in the left hand of";}
								if(nSlot == 6) {sSlot = "on the back of";}
								if(nSlot == 7) {sSlot = "on a finger on the left hand of";}
								if(nSlot == 8) {sSlot = "on a finger on the right hand of";}
								if(nSlot == 9) {sSlot = "around the neck of";}
								if(nSlot == 10) {sSlot = "around the waist of";}
								if(nSlot == 11) {sSlot = "in the quiver of";}
								if(nSlot == 12) {sSlot = "carried by";}
								if(nSlot == 13) {sSlot = "in the quiver of";}
								sSlot = sSlot + " " + GetName(oDetected);
								nSlot++;
								}
							else if(GetObjectType(oDetected) != OBJECT_TYPE_ITEM) {
								oItem = GetNextItemInInventory(oDetected); 
								if(oItem == OBJECT_INVALID) {nSlot++;}
								else {sSlot = "in the inventory of " + GetName(oDetected);}
								}
							
							//First, check the item for SpellSchool variables. 	
							//If found, assign a temporary item property that gives it a ticket into the item property loop below. 
							if((GetLocalInt(oItem, "ACR_SPELLSCHOOL") > 0)|| (GetLocalInt(oItem, "ACR_SPELLSCHOOL2") > 0) || (GetLocalInt(oItem, "ACR_SPELLSCHOOL3") > 0)) { 
								int nSpell = IP_CONST_CASTSPELL_UNIQUE_POWER_SELF_ONLY;
								int nNumberUses = IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY;
								itemproperty ipSpellSchool = ItemPropertyCastSpell(nSpell, nNumberUses);
								IPSafeAddItemProperty(oItem, ipSpellSchool, 5.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING, FALSE, FALSE);
								SetLocalInt(oItem, "ACR_SPELLADDED", 1);
								}
																						
							itemproperty ipItem = GetFirstItemProperty(oItem);
							//Exclude creature items
							if(((GetBaseItemType(oItem) < 69) || (GetBaseItemType(oItem) > 73))
							//Exclude items with OOC or non-magical item properties
							&& ((GetIsItemPropertyValid(ipItem))
								&& (GetTag(oItem) != "omega_wand")
								&& (GetTag(oItem) != "slv_wand")
								&& (GetTag(oItem) != "tsm_builder_wand")
								&& (GetTag(oItem) != "abr_it_mi_body")
								&& (GetTag(oItem) != "dmfi_exe_tool")
								&& (GetTag(oItem) != "03_it_food")
								&& (GetTag(oItem) != "it_elderberry")
								&& (GetTag(oItem) != "kemoportablechair")
								&& (GetTag(oItem) != "abr_it_firstaid")
								&& (FindSubString(GetTag(oItem), "_ooc_") == -1)
								&& (FindSubString(GetTag(oItem), "abr_it_dm") == -1)
								&& (FindSubString(GetTag(oItem), "acr_dm") == -1)
								&& (FindSubString(GetTag(oItem), "acr_dc") == -1)
								&& (FindSubString(GetTag(oItem), "abr_dm") == -1)
								&& (FindSubString(GetTag(oItem), "abr_spawn") == -1)
								&& (FindSubString(GetTag(oItem), "_loot_token") == -1)
								&& (FindSubString(GetTag(oItem), "dye_") == -1)
								&& (FindSubString(GetTag(oItem), "it_cassi") == -1)
								&& (FindSubString(GetTag(oItem), "it_nararoo") == -1)
								)) {
									//Establish base item, a base item string, and a spot modifier based on size to go with it			
									int nBaseItem = GetBaseItemType(oItem);
									string sBaseItem = IntToString(nBaseItem);
									string sItemName = GetName(oItem);
									
									//If it's unidentified, say so
									string sIdentified = " ";
									string sIdentifiedN = " ";
									string sIdentifiedCap = " ";
									if(GetIdentified(oItem) == FALSE) {sIdentified = "unidentified ";sIdentifiedCap = "Unidentified ";sIdentifiedN = "n unidentified ";} 
											
									if(nBaseItem == 19) {sBaseItem = "An" + sIdentified + "amulet";}
									if(nBaseItem == 16) {sBaseItem = sIdentifiedCap + "Armor";}
									if((nBaseItem == 16) && (FindSubString(GetName(oItem), "Robe") != -1)) {sBaseItem = "A" + sIdentifiedN + "robe";}
									if(nBaseItem == 20) {sBaseItem = sIdentifiedCap + "Arrows";}
									if(nBaseItem == 3) {sBaseItem = "A" + sIdentifiedN + "bastard sword";}
									if(nBaseItem == 2) {sBaseItem = "A" + sIdentifiedN + "battle axe";}
									if(nBaseItem == 21) {sBaseItem = "A" + sIdentifiedN + "belt";}
									if(nBaseItem == 101) {sBaseItem = "A" + sIdentifiedN + "bottle";}
									if(nBaseItem == 25) {sBaseItem = sIdentifiedCap + "Bolts";}
									if(nBaseItem == 74) {sBaseItem = "A" + sIdentifiedN + "book";}
									if(nBaseItem == 26) {sBaseItem = "A" + sIdentifiedN + "pair of boots";}
									if(nBaseItem == 78) {sBaseItem = "A" + sIdentifiedN + "pair of bracers";}
									if(nBaseItem == 27) {sBaseItem = "A" + sIdentifiedN + "pouch of bullets";}
									if(nBaseItem == 80) {sBaseItem = "A" + sIdentifiedN + "cloak";}
									if(nBaseItem == 28) {sBaseItem = "A" + sIdentifiedN + "club";}
									if(nBaseItem == 22) {sBaseItem = "A" + sIdentifiedN + "dagger";}
									if(nBaseItem == 31) {sBaseItem = "A" + sIdentifiedN + "set of darts";}
									if(nBaseItem == 33) {sBaseItem = "A" + sIdentifiedN + "double axe"; }
									if(nBaseItem == 128) {sBaseItem = "A" + sIdentifiedN + "drum";}
									if(nBaseItem == 108) {sBaseItem = "A" + sIdentifiedN + "dwarven war axe";}
									if(nBaseItem == 114) {sBaseItem = "A" + sIdentifiedN + "falchion";}
									if(nBaseItem == 116) {sBaseItem = "A" + sIdentifiedN + "flail";}
									if(nBaseItem == 129) {sBaseItem = "A" + sIdentifiedN + "flute";}
									if(nBaseItem == 77) {sBaseItem = "A" + sIdentifiedN + "gem";}
									if(nBaseItem == 36) {sBaseItem = "A" + sIdentifiedN + "pair of gloves";}
									if(nBaseItem == 18) {sBaseItem = "A" + sIdentifiedN + "great axe";}
									if(nBaseItem == 120) {sBaseItem = "A" + sIdentifiedN + "great club";}
									if(nBaseItem == 13) {sBaseItem = "A" + sIdentifiedN + "great sword";}
									if(nBaseItem == 81) {sBaseItem = "A" + sIdentifiedN + "grenade";}
									if(nBaseItem == 10) {sBaseItem = "A" + sIdentifiedN + "halberd";}
									if(nBaseItem == 38) {sBaseItem = "A" + sIdentifiedN + "hand axe";}
									if(nBaseItem == 6) {sBaseItem = "A" + sIdentifiedN + "heavy crossbow";}
									if(nBaseItem == 35) {sBaseItem = "A" + sIdentifiedN + "heavy flail";}
									if(nBaseItem == 17) {sBaseItem = "A" + sIdentifiedN + "helmet or other headgear";}
									if((nBaseItem == 17) && (FindSubString(GetName(oItem), "Mask") != -1)) {sBaseItem = "A" + sIdentifiedN + "mask";}
									if((nBaseItem == 17) && (FindSubString(GetName(oItem), "Headband") != -1)) {sBaseItem = "A" + sIdentifiedN + "headband";}
									if(nBaseItem == 40) {sBaseItem = "A" + sIdentifiedN + "kama";}
									if(nBaseItem == 41) {sBaseItem = "A" + sIdentifiedN + "katana";}
									if(nBaseItem == 65) {sBaseItem = "A" + sIdentifiedN + "key";}
									if(nBaseItem == 42) {sBaseItem = "A" + sIdentifiedN + "kukri";}
									if(nBaseItem == 66) {sBaseItem = "A" + sIdentifiedN + "large box";}
									if(nBaseItem == 56) {sBaseItem = "A" + sIdentifiedN + "large shield";}
									if(nBaseItem == 7) {sBaseItem = "A" + sIdentifiedN + "light crossbow";}
									if(nBaseItem == 4) {sBaseItem = "A" + sIdentifiedN + "light flail";}
									if(nBaseItem == 37) {sBaseItem = "A" + sIdentifiedN + "light hammer";}
									if(nBaseItem == 9) {sBaseItem = "A" + sIdentifiedN + "light mace";}
									if(nBaseItem == 1) {sBaseItem = "A" + sIdentifiedN + "longsword";}
									if(nBaseItem == 8) {sBaseItem = "A" + sIdentifiedN + "longbow";}
									if(nBaseItem == 132) {sBaseItem = "A" + sIdentifiedN + "lute";}
									if(nBaseItem == 113) {sBaseItem = "A" + sIdentifiedN + "mace";}
									if(nBaseItem == 44) {sBaseItem = "A" + sIdentifiedN + "rod";}
									if(nBaseItem == 45) {sBaseItem = "A" + sIdentifiedN + "staff";}
									if(nBaseItem == 46) {sBaseItem = "A" + sIdentifiedN + "wand";}
									if(nBaseItem == 34) {sBaseItem = "A" + sIdentifiedN + "large item";}
									if(nBaseItem == 29) {sBaseItem = "A" + sIdentifiedN + "medium item";}
									if(nBaseItem == 24) {sBaseItem = "A" + sIdentifiedN + "small item";}
									if(nBaseItem == 103) {sBaseItem = "A" + sIdentifiedN + "small item";}
									if(nBaseItem == 43) {sBaseItem = "A" + sIdentifiedN + "tall item";}
									if(nBaseItem == 79) {sBaseItem = "A" + sIdentifiedN + "thin item";}
									if(nBaseItem == 68) {sBaseItem = "A" + sIdentifiedN + "wide item";}
									if(nBaseItem == 47) {sBaseItem = "A" + sIdentifiedN + "morningstar";}
									if(nBaseItem == 49) {sBaseItem = "A" + sIdentifiedN + "potion";}
									if(nBaseItem == 96) {sBaseItem = "A" + sIdentifiedN + "potion";}
									if(nBaseItem == 50) {sBaseItem = "A" + sIdentifiedN + "quarterstaff";}
									if(nBaseItem == 51) {sBaseItem = "A" + sIdentifiedN + "rapier";}
									if(nBaseItem == 52) {sBaseItem = "A" + sIdentifiedN + "ring";}
									if(nBaseItem == 53) {sBaseItem = "A" + sIdentifiedN + "scimitar";}
									if(nBaseItem == 75) {sBaseItem = "A" + sIdentifiedN + "scroll";}
									if(nBaseItem == 55) {sBaseItem = "A" + sIdentifiedN + "scythe";}
									if(nBaseItem == 11) {sBaseItem = "A" + sIdentifiedN + "short bow";}
									if(nBaseItem == 58) {sBaseItem = "A" + sIdentifiedN + "short spear";}
									if(nBaseItem == 0) {sBaseItem = "A" + sIdentifiedN + "shortsword";}
									if(nBaseItem == 59) {sBaseItem = "A" + sIdentifiedN + "set of shuriken";}
									if(nBaseItem == 60) {sBaseItem = "A" + sIdentifiedN + "sickle";}
									if(nBaseItem == 61) {sBaseItem = "A" + sIdentifiedN + "sling";}
									if(nBaseItem == 14) {sBaseItem = "A" + sIdentifiedN + "small shield";}
									if(nBaseItem == 119) {sBaseItem = "A" + sIdentifiedN + "spear";}
									if(nBaseItem == 63) {sBaseItem = "A" + sIdentifiedN + "set of throwing axes";}
									if(nBaseItem == 62) {sBaseItem = "A" + sIdentifiedN + "set of thieves tools";}
									if(nBaseItem == 200) {sBaseItem = "A" + sIdentifiedN + "small item";}
									if(nBaseItem == 72) {sBaseItem = "A" + sIdentifiedN + "small item";}
									if(nBaseItem == 57) {sBaseItem = "A" + sIdentifiedN + "tower shield";}
									if(nBaseItem == 5) {sBaseItem = "A" + sIdentifiedN + "war hammer";}
									if(nBaseItem == 126) {sBaseItem = "A" + sIdentifiedN + "war mace";}
									if(nBaseItem == 111) {sBaseItem = "A" + sIdentifiedN + "whip";}
									
									//Start looping through item properties on each item
									while (GetIsItemPropertyValid(ipItem)) {
										int nItemProperty = GetItemPropertyType(ipItem);
										int nItemSubType = GetItemPropertySubType(ipItem);
										string sItemSubType = IntToString(nItemSubType);
										int nItemCost = GetItemPropertyCostTableValue(ipItem);
										string sItemProperty = "";
										string sSpellIndex = "";
										
										/*  SRD under Magic Items and Detect Magic
										    Armor and protection items = Abjuration
											Weapons or offensive items = Evocation
											Bonus to ability score, on skill check, etc. = Transmutation
											*/
										if(nItemProperty == 0) {sItemProperty = "Ability Bonus"; sSchool = "T"; nAuraPower = nItemCost;}
										if((nItemProperty >= 1) && (nItemProperty <=5)) {sItemProperty = "AC Bonus"; sSchool = "A"; nAuraPower = nItemCost;}
										if((nItemProperty >= 56) && (nItemProperty <=59)) {sItemProperty = "Attack Bonus"; sSchool = "V"; nAuraPower = nItemCost;}
										if(nItemProperty == 12) {sItemProperty = "Bonus Feat"; sSchool = "T"; nAuraPower = 2;}
										if(nItemProperty == 66) {sItemProperty = "Bonus HP"; sSchool = "T"; nAuraPower = 2;}
										if(nItemProperty == 13) {sItemProperty = "Bonus Spell Slot"; sSchool = "T"; nAuraPower = nItemCost;}
										//We don't want to override values already set on items currently checking Cast Spell: Unique added by SpellSchool variables
										if(nItemProperty == 15){
											sItemProperty = "Cast Spell";
											if(GetLocalInt(oItem, "ACR_SPELLADDED") == 0) {
												sSpellIndex = Get2DAString("iprp_spells", "SpellIndex", nItemSubType); 
												sSchool = Get2DAString("spells", "School", StringToInt(sSpellIndex));
												sAuraPower = Get2DAString("spells", "Innate", StringToInt(sSpellIndex));
												nAuraPower = StringToInt(sAuraPower);
												}
											}
										if((nItemProperty >= 16) && (nItemProperty <=19)) {sItemProperty = "Damage Bonus"; sSchool = "V"; nAuraPower = nItemCost;}
										if(nItemProperty == 90) {sItemProperty = "Damage Reduction"; sSchool = "T"; nAuraPower = nItemCost;}
										if(nItemProperty == 23) {sItemProperty = "Damage Resistance"; sSchool = "A"; nAuraPower = nItemCost;}
										if(nItemProperty == 24) {sItemProperty = "Damage Vulnerability"; sSchool = "T"; nAuraPower = nItemCost;}
										if(nItemProperty == 26) {sItemProperty = "Darkvision"; sSchool = "T"; nAuraPower = 2;}
										if(nItemProperty == 27) {sItemProperty = "Decreased Ability"; sSchool = "T"; nAuraPower = nItemCost;}
										if(nItemProperty == 28) {sItemProperty = "Decreased AC"; sSchool = "T"; nAuraPower = nItemCost;}
										if(nItemProperty == 29) {sItemProperty = "Decreased Skill"; sSchool = "T"; nAuraPower = nItemCost;}
										if(nItemProperty == 10) {sItemProperty = "Decreased Enhancement Modifier"; sSchool = "T"; nAuraPower = nItemCost;}
										if(nItemProperty == 60) {sItemProperty = "Decreased Attack Modifier"; sSchool = "T"; nAuraPower = nItemCost;}
										if(nItemProperty == 21) {sItemProperty = "Decreased Damage"; sSchool = "T"; nAuraPower = nItemCost;}
										if(nItemProperty == 49) {sItemProperty = "Decreased Saving Throw"; sSchool = "T"; nAuraPower = nItemCost;}
										if((nItemProperty >= 6) && (nItemProperty <=9)) {sItemProperty = "Enhancement Bonus"; sSchool = "V"; nAuraPower = nItemCost;}
										if((nItemProperty >= 33) && (nItemProperty <=34)) {sItemProperty = "Extra Damage"; sSchool = "V"; nAuraPower = nItemCost;}
										if(nItemProperty == 75) {sItemProperty = "Freedom of Movement"; sSchool = "T"; nAuraPower = 4;}
										if(nItemProperty == 35) {sItemProperty = "Haste"; sSchool = "T"; nAuraPower = 3;}
										if(nItemProperty == 20) {sItemProperty = "Immunity Damage Type"; sSchool = "A"; nAuraPower = 7;}
										if(nItemProperty == 37) {sItemProperty = "Immunity Misc"; sSchool = "A"; nAuraPower = 7;}
										if((nItemProperty >= 53) && (nItemProperty <=54)) {sItemProperty = "Immunity Spell/s"; sSchool = "A"; nAuraPower = 7;}
										if(nItemProperty == 78) {sItemProperty = "Immunity Spell Level"; sSchool = "A"; nAuraPower = 7;}
										if(nItemProperty == 38) {sItemProperty = "Improved Evasion"; sSchool = "T"; nAuraPower = 7;}
										if(nItemProperty == 44) {sItemProperty = "Light"; sSchool = "V"; nAuraPower = 1;}
										if(nItemProperty == 82) {
											sItemProperty = "On Hit Cast Spell";
											sSpellIndex = Get2DAString("iprp_spells", "SpellIndex", nItemSubType); 
											sSchool = Get2DAString("spells", "School", StringToInt(sSpellIndex));
											sAuraPower = Get2DAString("spells", "Innate", StringToInt(sSpellIndex));
											nAuraPower = StringToInt(sAuraPower);
											}
										if(nItemProperty == 51) {sItemProperty = "Regeneration"; sSchool = "T"; nAuraPower = 7;}
										if((nItemProperty >= 40) && (nItemProperty <=41)) {sItemProperty = "Saving Throw Bonus"; sSchool = "T"; nAuraPower = nItemCost;}
										if(nItemProperty == 52) {sItemProperty = "Skill Bonus"; sSchool = "T"; nAuraPower = nItemCost;}
										if(nItemProperty == 39) {sItemProperty = "Spell Resistance"; sSchool = "A"; nAuraPower = 5;}
										if(nItemProperty == 71) {sItemProperty = "True Seeing"; sSchool = "T"; nAuraPower = 5;}
										
										if(sItemProperty != "") {
											if(GetObjectType(oDetected) == OBJECT_TYPE_CREATURE) {SetLocalInt(oCaster, "nItemCount", 1);}
											//If no SpellSchool variables on Cast Unique subtypes
											if((GetLocalInt(oItem, "ACR_SPELLADDED") == 0) && ((sItemSubType == "125") || (sItemSubType == "329") || (sItemSubType == "335"))) 
												{sSchool = " of complex arcanity "; nAuraPower = 0; sAuraStrength = "magic";
												if(GetTag(oItem) == "abr_it_holysymbol") {sSchool = "A"; nAuraPower = 1;}
												if(GetTag(oItem) == "abr_it_scry_kit") {sSchool = "G"; nAuraPower = 1;}
												}
											//SpellSchool variables for the Cast Unique property that was added before the loop	
											if(GetLocalInt(oItem, "ACR_SPELLADDED") == 1) {
												int nACRSpellSchool = GetLocalInt(oItem, "ACR_SPELLSCHOOL");
												int nAuraPower = GetLocalInt(oItem, "ACR_SPELLPOWER");
												string sACRSubSchool = GetLocalString(oItem, "ACR_SUBSCHOOL");
												if(sACRSubSchool != "") {sACRSubSchool = "(" + sACRSubSchool + ")";}
												if(nACRSpellSchool == 1) {sSchool = " of <color=lightblue>Abjuration " + sACRSubSchool + "</color>"; nAbj++;}
												if(nACRSpellSchool == 2) {sSchool = " of <color=tan>Conjuration " + sACRSubSchool + "</color>"; nCon++;}
												if(nACRSpellSchool == 3) {sSchool = " of <color=green>Divination " + sACRSubSchool + "</color>"; nDiv++;}
												if(nACRSpellSchool == 4) {sSchool = " of <color=magenta>Enchantment " + sACRSubSchool + "</color>"; nEnc++;}
												if(nACRSpellSchool == 5) {sSchool = " of <color=red>Evocation " + sACRSubSchool + "</color>"; nEvo++;}
												if(nACRSpellSchool == 6) {sSchool = " of <color=purple>Illusion " + sACRSubSchool + "</color>"; nIll++;}
												if(nACRSpellSchool == 7) {sSchool = " of <color=white>Necromancy " + sACRSubSchool + "</color>"; nNec++;}
												if(nACRSpellSchool == 8) {sSchool = " of <color=orange>Transmutation " + sACRSubSchool + "</color>"; nTra++;}
												if(nACRSpellSchool == 9) {sSchool = " of <color=#FFFF00>Universal arcanity" + sACRSubSchool + "</color>"; nGen++;}
												
												int nACRSpellSchool2 = GetLocalInt(oItem, "ACR_SPELLSCHOOL2");
												int nAuraPower2 = GetLocalInt(oItem, "ACR_SPELLPOWER2");
												string sACRSubSchool2 = GetLocalString(oItem, "ACR_SUBSCHOOL2");
												if(sACRSubSchool2 != "") {sACRSubSchool2 = "(" + sACRSubSchool2 + ")";}
												if(nACRSpellSchool2 == 1) {sSchool2 = " of <color=lightblue>Abjuration " + sACRSubSchool2 + "</color>"; nAbj++;}
												if(nACRSpellSchool2 == 2) {sSchool2 = " of <color=tan>Conjuration " + sACRSubSchool2 + "</color>"; nCon++;}
												if(nACRSpellSchool2 == 3) {sSchool2 = " of <color=green>Divination " + sACRSubSchool2 + "</color>"; nDiv++;}
												if(nACRSpellSchool2 == 4) {sSchool2 = " of <color=magenta>Enchantment " + sACRSubSchool2 + "</color>"; nEnc++;}
												if(nACRSpellSchool2 == 5) {sSchool2 = " of <color=red>Evocation " + sACRSubSchool2 + "</color>"; nEvo++;}
												if(nACRSpellSchool2 == 6) {sSchool2 = " of <color=purple>Illusion " + sACRSubSchool2 + "</color>"; nIll++;}
												if(nACRSpellSchool2 == 7) {sSchool2 = " of <color=white>Necromancy " + sACRSubSchool2 + "</color>"; nNec++;}
												if(nACRSpellSchool2 == 8) {sSchool2 = " of <color=orange>Transmutation " + sACRSubSchool2 + "</color>"; nTra++;}
												if(nACRSpellSchool2 == 9) {sSchool2 = " of <color=#FFFF00>Universal arcanity" + sACRSubSchool2 + "</color>"; nGen++;}
												int nACRSpellSchool3 = GetLocalInt(oItem, "ACR_SPELLSCHOOL3");
												int nAuraPower3 = GetLocalInt(oItem, "ACR_SPELLPOWER3");
												string sACRSubSchool3 = GetLocalString(oItem, "ACR_SUBSCHOOL3");
												if(sACRSubSchool3 != "") {sACRSubSchool3 = "(" + sACRSubSchool3 + ")";}
												if(nACRSpellSchool3 == 1) {sSchool3 = " of <color=lightblue>Abjuration " + sACRSubSchool3 + "</color>"; nAbj++;}
												if(nACRSpellSchool3 == 2) {sSchool3 = " of <color=tan>Conjuration " + sACRSubSchool3 + "</color>"; nCon++;}
												if(nACRSpellSchool3 == 3) {sSchool3 = " of <color=green>Divination " + sACRSubSchool3 + "</color>"; nDiv++;}
												if(nACRSpellSchool3 == 4) {sSchool3 = " of <color=magenta>Enchantment " + sACRSubSchool3 + "</color>"; nEnc++;}
												if(nACRSpellSchool3 == 5) {sSchool3 = " of <color=red>Evocation " + sACRSubSchool3 + "</color>"; nEvo++;}
												if(nACRSpellSchool3 == 6) {sSchool3 = " of <color=purple>Illusion " + sACRSubSchool3 + "</color>"; nIll++;}
												if(nACRSpellSchool3 == 7) {sSchool3 = " of <color=white>Necromancy " + sACRSubSchool3 + "</color>"; nNec++;}
												if(nACRSpellSchool3 == 8) {sSchool3 = " of <color=orange>Transmutation " + sACRSubSchool3 + "</color>"; nTra++;}
												if(nACRSpellSchool3 == 9) {sSchool3 = " of <color=#FFFF00>Universal arcanity" + sACRSubSchool3 + "</color>"; nGen++;}
												
												if(nAuraPower > 0) {sAuraStrength = "faint";}
												if(nAuraPower > 3) {sAuraStrength = "moderate";}
												if(nAuraPower > 6) {sAuraStrength = "strong";}
												if(nAuraPower > 9) {sAuraStrength = "overwhelming";}
												if(nAuraPower2 > 0) {sAuraStrength2 = "faint";}
												if(nAuraPower2 > 3) {sAuraStrength2 = "moderate";}
												if(nAuraPower2 > 6) {sAuraStrength2 = "strong";}
												if(nAuraPower2 > 9) {sAuraStrength2 = "overwhelming";}
												if(nAuraPower3 > 0) {sAuraStrength3 = "faint";}
												if(nAuraPower3 > 3) {sAuraStrength3 = "moderate";}
												if(nAuraPower3 > 6) {sAuraStrength3 = "strong";}
												if(nAuraPower3 > 9) {sAuraStrength3 = "overwhelming";}
												
												nAuraPowerHigh = GetLocalInt(oCaster, "nAuraPowerHigh");
												if(nAuraPower > nAuraPowerHigh) {
													SetLocalInt(oCaster, "nAuraPowerHigh", nAuraPower);
													SetLocalString(oCaster, "sAuraPowerHigh", sAuraStrength);
								    				}
												nAuraPowerHigh = GetLocalInt(oCaster, "nAuraPowerHigh");
												if(nAuraPower2 > nAuraPowerHigh) {
													SetLocalInt(oCaster, "nAuraPowerHigh", nAuraPower2);
													SetLocalString(oCaster, "sAuraPowerHigh", sAuraStrength2);
								    				}
												nAuraPowerHigh = GetLocalInt(oCaster, "nAuraPowerHigh");
												if(nAuraPower3 > nAuraPowerHigh) {
													SetLocalInt(oCaster, "nAuraPowerHigh", nAuraPower3);
													SetLocalString(oCaster, "sAuraPowerHigh", sAuraStrength3);
								    				}	
												
												//Extra reports for items with SpellSchool variables.
												float fDelay = 22.1;
												//If this is part of a Creature message stack, that takes longer, with more messages spread over a minute.
										 		//Due to the magic of fDelay, this message stack arrives in the chat window after Round 2 and its own Round 3 Headers
												if(GetObjectType(oDetected) == OBJECT_TYPE_CREATURE) {fDelay = 42.1 + IntToFloat(nSlot/10) +IntToFloat(nCreatureCount * 2);}
												//Only report equipped items for Creatures.
												if(((GetObjectType(oDetected) == OBJECT_TYPE_CREATURE) && (nSlot > 0) && (nSlot <= 13)) || (GetObjectType(oDetected) == OBJECT_TYPE_PLACEABLE) || (GetObjectType(oDetected) == OBJECT_TYPE_ITEM)){
													//Queue up SpellSchool reports to caster if Round 3 achieved and creature is not invisible
													if((nConcentration > 13) && (GetLocalInt(oDetected, "nInvis") == 0)) {
														if(nACRSpellSchool > 0) {
															nAuraCount++;
															DelayCommand(fDelay, SendMessageToAllDMs("ItemSubtype = " + sItemSubType + ", " + GetName(oItem) + ", " + sBaseItem  +  " " + sSlot + ", gives off a " + sAuraStrength + " --" + IntToString(nAuraPower) + "-- aura" + sSchool));
															DelayCommand(fDelay, SendMessageToPC(oCaster, sBaseItem  +  " " + sSlot + " gives off a " + sAuraStrength + " aura" + sSchool));
															}
														if(nACRSpellSchool2 > 0) {
															nAuraCount++;
															DelayCommand(fDelay, SendMessageToAllDMs("ItemSubtype = " + sItemSubType + ", " + GetName(oItem) + ", " + sBaseItem  +  " " + sSlot + ", gives off a " + sAuraStrength2 + " --" + IntToString(nAuraPower2) + "-- aura" + sSchool2));
															DelayCommand(fDelay, SendMessageToPC(oCaster, sBaseItem  +  " " + sSlot + " gives off a " + sAuraStrength2 + " aura" + sSchool2));
															}
														if(nACRSpellSchool3 > 0) {
															nAuraCount++;
															DelayCommand(fDelay, SendMessageToAllDMs("ItemSubtype = " + sItemSubType + ", " + GetName(oItem) + ", " + sBaseItem  +  " " + sSlot + ", gives off a " + sAuraStrength3 + " --" + IntToString(nAuraPower3) + "-- aura" + sSchool3));
															DelayCommand(fDelay, SendMessageToPC(oCaster, sBaseItem  +  " " + sSlot + " gives off a " + sAuraStrength3 + " aura" + sSchool3));
															}
														}
													}
													
												} 
											
											//If it's in a closed container, no soup for you.
											if((GetObjectType(oDetected) == OBJECT_TYPE_PLACEABLE)&& (GetIsOpen(oDetected) == FALSE)) {sBaseItem = "Something"; nSomething++;}
												
											if(sSchool == "A") {sSchool = " of <color=lightblue>Abjuration </color>"; nAbj++;}
											if(sSchool == "C") {sSchool = " of <color=tan>Conjuration </color>"; nCon++;}
											if(sSchool == "D") {sSchool = " of <color=green>Divination </color>"; nDiv++;}
											if(sSchool == "E") {sSchool = " of <color=magenta>Enchantment </color>"; nEnc++;}
											if(sSchool == "I") {sSchool = " of <color=purple>Illusion </color>"; nIll++;}
											if(sSchool == "N") {sSchool = " of <color=white>Necromancy </color>"; nNec++;}
											if(sSchool == "T") {sSchool = " of <color=orange>Transmutation </color>"; nTra++;}
											if(sSchool == "V") {sSchool = " of <color=red>Evocation </color>"; nEvo++;}
											if(sSchool == "G") {sSchool = " of <color=#FFFF00>Universal arcanity</color>"; nGen++;}
											
											//If caster fails Spellcraft, no school for you, either.
											if(!GetIsSkillSuccessful(oCaster, SKILL_SPELLCRAFT, 15 + nAuraPower, FALSE)){sSchool = "";sSchool2 = "";sSchool3 = "";}
											
											if(nAuraPower > 0) {sAuraStrength = "faint";}
											if(nAuraPower > 3) {sAuraStrength = "moderate";}
											if(nAuraPower > 6) {sAuraStrength = "strong";}
											if(nAuraPower > 9) {sAuraStrength = "overwhelming";}
											
											//Is this the highest power aura encountered thus far? If so, store it.	
											nAuraPowerHigh = GetLocalInt(oCaster, "nAuraPowerHigh");
											if(nAuraPower > nAuraPowerHigh) {
												SetLocalInt(oCaster, "nAuraPowerHigh", nAuraPower);
												SetLocalString(oCaster, "sAuraPowerHigh", sAuraStrength);
							    				}
												
											//If the caster gets a Round 3, most objects report at 24 seconds into the report.
											float fDelay = 22.0;
											//If this is part of a Creature message stack, that takes longer, with more messages spread over a minute.
									 		//Due to the magic of fDelay, this message stack arrives in the chat window after Round 2 and its own Round 3 Headers
											if(GetObjectType(oDetected) == OBJECT_TYPE_CREATURE) {fDelay = 42.0 + IntToFloat(nSlot/10) +IntToFloat(nCreatureCount * 2);}
											//Only report equipped items for Creatures.
											if(((GetObjectType(oDetected) == OBJECT_TYPE_CREATURE) && (nSlot > 0) && (nSlot <= 13)) || (GetObjectType(oDetected) == OBJECT_TYPE_PLACEABLE) || (GetObjectType(oDetected) == OBJECT_TYPE_ITEM)){
												//Queue up Detail Equipped report to caster if Round 3 achieved and creature is not invisible and it wasn't sent as a SpellSchool message before this
												if((nConcentration > 13) && (GetLocalInt(oDetected, "nInvis") == 0) && (GetLocalInt(oDetected, "ACR_SPELLADDED") == 0)) {
													if((GetLocalInt(oItem, "ACR_SPELLSCHOOL") == 0) && (GetLocalInt(oItem, "ACR_SPELLSCHOOL2") == 0) && (GetLocalInt(oItem, "ACR_SPELLSCHOOL3") == 0)) {
														nAuraCount++;
														DelayCommand(fDelay, SendMessageToAllDMs("ItemSubtype = " + sItemSubType + ", " + GetName(oItem) + ", " + sBaseItem  +  " " + sSlot + ", gives off a " + sAuraStrength + " --" + IntToString(nAuraPower) + "-- aura" + sSchool));
														DelayCommand(fDelay, SendMessageToPC(oCaster, sBaseItem  +  " " + sSlot + " gives off a " + sAuraStrength + " aura" + sSchool));
														}
													}
												SetLocalInt(oItem, "ACR_SPELLADDED", 0); 
												
												}
											
										//Flag Round 1 Message 	
										SetLocalInt(oCaster, "nMessage1", 1);
										}
										string sSchool = "";
										ipItem = GetNextItemProperty(oItem);
									}
								}
							
							if(GetObjectType(oDetected) == OBJECT_TYPE_ITEM) {nSlot++;}
							 }
						
						//If the caster gets a Round 3, generalize the quantities of auras by school, for a summary report.	
						if(nConcentration > 13) {
							string sAbj;
							string sCon;
							string sDiv;
							string sEnc;
							string sEvo;
							string sIll;
							string sNec;
							string sTra;
							string sGen;
							string sHoly;
							string sSomething;	
									
							if(nAbj < 5) {sAbj = IntToString(nAbj);} else if(nAbj < 8) {sAbj = "around half a dozen";} else if(nAbj < 13) {sAbj = "close to ten";}  else if(nAbj > 12) {sAbj = "more than a dozen";}
							if(nCon < 5) {sCon = IntToString(nCon);} else if(nCon < 8) {sCon = "around half a dozen";} else if(nCon < 13) {sCon = "close to ten";}  else if(nCon > 12) {sCon = "more than a dozen";}
							if(nDiv < 5) {sDiv = IntToString(nDiv);} else if(nDiv < 8) {sDiv = "around half a dozen";} else if(nDiv < 13) {sDiv = "close to ten";}  else if(nDiv > 12) {sDiv = "more than a dozen";}
							if(nEnc < 5) {sEnc = IntToString(nEnc);} else if(nEnc < 8) {sEnc = "around half a dozen";} else if(nEnc < 13) {sEnc = "close to ten";}  else if(nEnc > 12) {sEnc = "more than a dozen";}
							if(nEvo < 5) {sEvo = IntToString(nEvo);} else if(nEvo < 8) {sEvo = "around half a dozen";} else if(nEvo < 13) {sEvo = "close to ten";}  else if(nEvo > 12) {sEvo = "more than a dozen";}
							if(nIll < 5) {sIll = IntToString(nIll);} else if(nIll < 8) {sIll = "around half a dozen";} else if(nIll < 13) {sIll = "close to ten";}  else if(nIll > 12) {sIll = "more than a dozen";}
							if(nNec < 5) {sNec = IntToString(nNec);} else if(nNec < 8) {sNec = "around half a dozen";} else if(nNec < 13) {sNec = "close to ten";}  else if(nNec > 12) {sNec = "more than a dozen";}
							if(nTra < 5) {sTra = IntToString(nTra);} else if(nTra < 8) {sTra = "around half a dozen";} else if(nTra < 13) {sTra = "close to ten";}  else if(nTra > 12) {sTra = "more than a dozen";}
							if(nGen < 5) {sGen = IntToString(nGen);} else if(nGen < 8) {sGen = "around half a dozen";} else if(nGen < 13) {sGen = "close to ten";}  else if(nGen > 12) {sGen = "more than a dozen";}
							if(nSomething < 5) {sSomething = IntToString(nSomething);} else if(nSomething < 8) {sSomething = "around half a dozen";} else if(nSomething < 13) {sSomething = "close to ten";}  else if(nSomething > 12) {sSomething = "more than a dozen";}
							//If it's a Creature, send the Equipped and Carried Summary and the Equipped Detail Header
							if((GetObjectType(oDetected) == OBJECT_TYPE_CREATURE) && (GetLocalInt(oCaster, "nItemCount") > 0)) {
								if(GetLocalInt(oDetected, "nInvis")== 1) {sName = "Something " + IntToString(FloatToInt(GetDistanceBetween(oCaster, oDetected))) + "m to the " + sAngle;}
								float fSumDelay = 26.0;
								if((GetLocalInt(oCaster, "nSummary") == 0) && (GetLocalInt(oDetected, "nInvis")== 0)){
									DelayCommand(fSumDelay, SendMessageToAllDMs(" "));
									DelayCommand(fSumDelay + 0.1, SendMessageToAllDMs("EQUIPPED AND CARRIED SUMMARY: "));
									}
								
								if(nAbj>0) {DelayCommand(fSumDelay + 0.2 + IntToFloat(nCreatureCount), SendMessageToAllDMs(sName + " -- " + GetName(oDetected) + "-- <color=lightblue>: " + sAbj + " Abjuration</color> auras"));}
								if(nCon>0) {DelayCommand(fSumDelay + 0.3 + IntToFloat(nCreatureCount), SendMessageToAllDMs(sName + " -- " + GetName(oDetected) + "-- <color=tan>: " + sCon + " Conjuration</color> auras"));}
								if(nDiv>0) {DelayCommand(fSumDelay + 0.4 + IntToFloat(nCreatureCount), SendMessageToAllDMs(sName + " -- " + GetName(oDetected) + "-- <color=green>: " + sDiv + " Divination</color> auras"));}
								if(nEnc>0) {DelayCommand(fSumDelay + 0.5 + IntToFloat(nCreatureCount), SendMessageToAllDMs(sName + " -- " + GetName(oDetected) + "-- <color=magenta>: " + sEnc + " Enchantment</color> auras"));}
								if(nEvo>0) {DelayCommand(fSumDelay + 0.6 + IntToFloat(nCreatureCount), SendMessageToAllDMs(sName + " -- " + GetName(oDetected) + "-- <color=red>: " + sEvo + " Evocation</color> auras"));}
								if(nIll>0) {DelayCommand(fSumDelay + 0.7 + IntToFloat(nCreatureCount), SendMessageToAllDMs(sName + " -- " + GetName(oDetected) + "-- <color=purple>: " + sIll + " Illusion</color> auras"));}
								if(nNec>0) {DelayCommand(fSumDelay + 0.8 + IntToFloat(nCreatureCount), SendMessageToAllDMs(sName + " -- " + GetName(oDetected) + "-- <color=white>: " + sNec + " Necromancy</color> auras"));}
								if(nTra>0) {DelayCommand(fSumDelay + 0.9 + IntToFloat(nCreatureCount), SendMessageToAllDMs(sName + " -- " + GetName(oDetected) + "-- <color=orange>: " + sTra + " Transmutation</color> auras"));}
								if(nGen>0) {DelayCommand(fSumDelay + 1.0 + IntToFloat(nCreatureCount), SendMessageToAllDMs(sName + " -- " + GetName(oDetected) + "-- <color=#FFFF00>: " + sGen + " Universal</color> auras"));}
								if(nSomething>0) {DelayCommand(fSumDelay + 1.2 + IntToFloat(nCreatureCount), SendMessageToAllDMs(sName + " -- " + GetName(oDetected) + "-- : " + sSomething + " auras you can't classify"));}
								
								if((GetLocalInt(oCaster, "nSummary") == 0) && (GetLocalInt(oDetected, "nInvis")== 0)){
									DelayCommand(fSumDelay + 2.1 + IntToFloat(nCreatureCount), SendMessageToAllDMs(" "));
									DelayCommand(fSumDelay + 2.2 + IntToFloat(nCreatureCount), SendMessageToAllDMs("**********"));
									DelayCommand(fSumDelay + 2.3 + IntToFloat(nCreatureCount), SendMessageToAllDMs("EQUIPPED DETAIL: "));
									DelayCommand(50.0 + IntToFloat(nCreatureCount * 2), SendMessageToAllDMs(" "));
									}
								if(GetLocalInt(oDetected, "nInvis")== 0) {DelayCommand(50.1 + IntToFloat(nCreatureCount *2 ), SendMessageToAllDMs("The rest of the auras on " + sName + " are in inventory."));}
								 
									if((GetLocalInt(oCaster, "nSummary") == 0) && (GetLocalInt(oDetected, "nInvis")== 0)) {
										DelayCommand(fSumDelay, SendMessageToPC(oCaster, " "));
										DelayCommand(fSumDelay + 0.1, SendMessageToPC(oCaster, "EQUIPPED AND CARRIED SUMMARY: "));
										}
									if(nAbj>0) {DelayCommand(fSumDelay + 0.2 + IntToFloat(nCreatureCount), SendMessageToPC(oCaster, sName + "<color=lightblue>: " + sAbj + " Abjuration</color> auras"));}
									if(nCon>0) {DelayCommand(fSumDelay + 0.3 + IntToFloat(nCreatureCount), SendMessageToPC(oCaster, sName + "<color=tan>: " + sCon + " Conjuration</color> auras"));}
									if(nDiv>0) {DelayCommand(fSumDelay + 0.4 + IntToFloat(nCreatureCount), SendMessageToPC(oCaster, sName + "<color=green>: " + sDiv + " Divination</color> auras"));}
									if(nEnc>0) {DelayCommand(fSumDelay + 0.5 + IntToFloat(nCreatureCount), SendMessageToPC(oCaster, sName + "<color=magenta>: " + sEnc + " Enchantment</color> auras"));}
									if(nEvo>0) {DelayCommand(fSumDelay + 0.6 + IntToFloat(nCreatureCount), SendMessageToPC(oCaster, sName + "<color=red>: " + sEvo + " Evocation</color> auras"));}
									if(nIll>0) {DelayCommand(fSumDelay + 0.7 + IntToFloat(nCreatureCount), SendMessageToPC(oCaster, sName + "<color=purple>: " + sIll + " Illusion</color> auras"));}
									if(nNec>0) {DelayCommand(fSumDelay + 0.8 + IntToFloat(nCreatureCount), SendMessageToPC(oCaster, sName + "<color=white>: " + sNec + " Necromancy</color> auras"));}
									if(nTra>0) {DelayCommand(fSumDelay + 0.9 + IntToFloat(nCreatureCount), SendMessageToPC(oCaster, sName + "<color=orange>: " + sTra + " Transmutation</color> auras"));}
									if(nGen>0) {DelayCommand(fSumDelay + 1.0 + IntToFloat(nCreatureCount), SendMessageToPC(oCaster, sName + "<color=#FFFF00>: " + sGen + " Universal</color> auras"));}
									if(nSomething>0) {DelayCommand(fSumDelay + 1.2 + IntToFloat(nCreatureCount), SendMessageToPC(oCaster, sName + ": " + sSomething + " auras you can't classify"));}
								 	if((GetLocalInt(oCaster, "nSummary") == 0) && (GetLocalInt(oDetected, "nInvis")== 0)) {
										SetLocalInt(oCaster, "nSummary",1);
										DelayCommand(fSumDelay + 2.1 + IntToFloat(nCreatureCount), SendMessageToPC(oCaster, " "));
										DelayCommand(fSumDelay + 2.2 + IntToFloat(nCreatureCount), SendMessageToPC(oCaster, "**********"));
										DelayCommand(fSumDelay + 2.3 + IntToFloat(nCreatureCount), SendMessageToPC(oCaster, "EQUIPPED DETAIL: "));
										DelayCommand(50.0 + IntToFloat(nCreatureCount * 2), SendMessageToPC(oCaster, " "));
										}
									if(GetLocalInt(oDetected, "nInvis")== 0) {DelayCommand(50.1 + IntToFloat(nCreatureCount * 2), SendMessageToPC(oCaster, "The rest of the auras on " + sName + " are in inventory."));}
								}
							}
						
						//Zero out the variables needed by the next item in inventory of this object, or the next object detected in the spellcone
						sSchool = "";
						nAuraPower = 0;
					}
				}
					
				if(nAuraPower > 0) {sAuraStrength = "a faint";}
				if(nAuraPower > 3) {sAuraStrength = "a moderate";}
				if(nAuraPower > 6) {sAuraStrength = "a strong";}
				if(nAuraPower > 9) {sAuraStrength = "an overwhelming";}
					
				nAuraPowerHigh = GetLocalInt(oCaster, "nAuraPowerHigh");
				if(nAuraPower > nAuraPowerHigh) {
					SetLocalInt(oCaster, "nAuraPowerHigh", nAuraPower);
					SetLocalString(oCaster, "sAuraPowerHigh", sAuraStrength);
					}
				
				oDetected = GetNextObjectInShape( SHAPE_SPELLCONE, 10.0, GetSpellTargetLocation(), TRUE, OBJECT_TYPE_ALL );
			}
			
		//Any one of the valid aura situations above could have flagged the release of the first round message
		if(GetLocalInt(oCaster, "nMessage1") == 1) {
			DelayCommand(6.0, SendMessageToAllDMs(GetTag(oDetected) + " " + GetName(oCaster) + " concentrates for one round and learns that there is magic within range."));
			DelayCommand(6.0, SendMessageToPC(oCaster, "You concentrate for one round and learn that there is magic within range."));
			SetLocalInt(oCaster, "nMessage1", 2);
			}
		
															
		//We've had Round 1 reported by whichever of the objects had the first magic aura detected.
		//Now see what we've got stored as the strongest aura for Round 2
		int nAuraPowerHigh = GetLocalInt(oCaster, "nAuraPowerHigh");
		string sAuraPowerHigh = GetLocalString(oCaster, "sAuraPowerHigh");
				
		if(nAuraPowerHigh >= 0) {sAuraPowerHigh = "faint";}
		if(nAuraPowerHigh > 3) {sAuraPowerHigh = "moderate";}
		if(nAuraPowerHigh > 6) {sAuraPowerHigh = "strong";}
		if(nAuraPowerHigh > 9) {sAuraPowerHigh = "overwhelming";}
		
		//Also for Round 2, in general how many auras has the caster detected?					
		string sAuraCount = "";
		string sS = "";
		if(nAuraCount > 0) {sS = "s";}
		if(nAuraCount < 5) {sAuraCount = IntToString(nAuraCount);} else if(nAuraCount < 8) {sAuraCount = "around half a dozen";} else if(nAuraCount < 13) {sAuraCount = "close to ten";}  else if(nAuraCount < 15) {sAuraCount = "more than a dozen";} else if(nAuraCount < 24) {sAuraCount = "twenty or so";}else if(nAuraCount < 37) {sAuraCount = "dozens of";}else if(nAuraCount >= 37) {sAuraCount = "scores of";}
		
		//Report Round 2			
		if((nAuraCount > 0) && (nConcentration > 6)) {
			DelayCommand(11.0, SendMessageToAllDMs("**********"));
			DelayCommand(12.0, SendMessageToAllDMs(GetName(oCaster) + " concentrates for two rounds."));
			DelayCommand(13.0, SendMessageToAllDMs(GetName(oCaster) + " senses " + sAuraCount + " --" + IntToString(nAuraCount) + "-- aura"+ sS ));
			DelayCommand(14.0, SendMessageToAllDMs("The most powerful aura " + GetName(oCaster) + " detects is " + sAuraPowerHigh));
			
				DelayCommand(11.0, SendMessageToPC(oCaster, "**********"));
				DelayCommand(12.0, SendMessageToPC(oCaster, "You concentrate for two rounds."));
				DelayCommand(13.0, SendMessageToPC(oCaster, "You sense " + sAuraCount + " aura" +sS));
				DelayCommand(14.0, SendMessageToPC(oCaster, "The most powerful aura you detect is " + sAuraPowerHigh));
			}
		
		//Introduce Round 3. Headers generated above come after this. Details on equipped items generated even further above come after that.
		if((nAuraCount > 0) && (nConcentration > 13)) {
			float fDelay = 26.0;
			nItemCounted = GetLocalInt(oCaster, "nItemCount");
			int nInvis = GetLocalInt(oDetected, "nInvis");
			if((nItemCounted == 1)&& (nInvis== 0)) {fDelay = 60.0;}
			DelayCommand(19.0, SendMessageToAllDMs("**********"));
			DelayCommand(19.1, SendMessageToAllDMs(GetName(oCaster) + " concentrates for three rounds and learns:"));
			DelayCommand(fDelay + IntToFloat(nCreatureCount * 2), SendMessageToAllDMs("**********"));
			DelayCommand(fDelay + IntToFloat(nCreatureCount * 2)+ 0.1, SendMessageToAllDMs("That is all you learn."));
				
			DelayCommand(19.0, SendMessageToPC(oCaster, "**********"));
			DelayCommand(19.1, SendMessageToPC(oCaster, "You concentrate for three rounds and learn:"));
			
			/*
			This is where info learned in Round 3 because of Concentration > 13 will show in chat box
			Function Spells Header: starts Line 639
			FS Detail: starts Line 655
			E&C Summary: starts Line 1049
			E Detail: starts Line 1006
			*/
			
			//The last thing sent, after Round 3 equipped details finish. 
			DelayCommand(fDelay + IntToFloat(nCreatureCount * 2), SendMessageToPC(oCaster, "**********"));
			DelayCommand(fDelay + IntToFloat(nCreatureCount * 2) + 0.1, SendMessageToPC(oCaster, "That is all you learn."));
			SetLocalInt(oCaster, "nItemCount", 0);
			}
		
		//If the caster didn't roll over a 13 Concentration, they don't get any of that lovely Round 3 info above at all.
		else if (nAuraCount > 0){
			DelayCommand(19.0, SendMessageToAllDMs("**********"));
			DelayCommand(19.1, SendMessageToAllDMs(GetName(oCaster) + "'s concentration breaks."));
			DelayCommand(19.0, SendMessageToPC(oCaster, "**********"));
			DelayCommand(19.1, SendMessageToPC(oCaster, "Your concentration breaks."));
			}
		
		//If there's nothing magic in the spell cone.
		if(nAuraCount == 0) {
			DelayCommand(6.0, SendMessageToAllDMs(GetName(oCaster) + " detects 0 auras."));
			DelayCommand(6.0, SendMessageToPC(oCaster, "You detect 0 auras."));
			}	
		
		//Unset local variables	
		SetLocalInt(oCaster, "nAuraPowerHigh", 0);
		SetLocalString(oCaster, "sAuraPowerHigh", "");
		SetLocalInt(oCaster, "nSummary", 0);
		}
				
	
		 
	//Stopping summons by non Banites in a Banite UnHallowed Area
	if(FindSubString(GetTag(GetArea(GetLastSpellCaster())), "rauvin_ruins") != -1) {
		if((nSpellId == SPELL_SUMMON_CREATURE_I) || (nSpellId == SPELL_SUMMON_CREATURE_II) || (nSpellId == SPELL_SUMMON_CREATURE_III) || (nSpellId == SPELL_SUMMON_CREATURE_IV) || (nSpellId == SPELL_SUMMON_CREATURE_V) || (nSpellId == SPELL_SUMMON_CREATURE_VI))
			{SetModuleOverrideSpellScriptFinished();
			 ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSpellFail, oCaster, 6.0);
			 SendMessageToPC(oCaster, "You feel something harsh and evil suppress your summoning spell.");
			 SendMessageToAllDMs(GetName(oCaster) + "'s Summons  spell fizzled in " + sArea + ".");		
		}
	}
	

	
//Arcane Mark
if(GetSpellId() == 3066) {


	object oMarked = GetSpellTargetObject();
	string sName = GetName(oMarked);
	location lMarked = GetLocation(oMarked);
	int nExpire = 0;
	if(oMarked == OBJECT_INVALID) {
		lMarked = GetSpellTargetLocation();
		oMarked = GetFirstObjectInShape(SHAPE_SPHERE, 2.5, lMarked, TRUE, OBJECT_TYPE_ALL); 
		sName = "This location";
		while(oMarked != OBJECT_INVALID) {
			if((GetObjectType(oMarked) == OBJECT_TYPE_PLACEABLE) || (GetObjectType(oMarked) == OBJECT_TYPE_DOOR) ||  (GetObjectType(oMarked) == OBJECT_TYPE_TRIGGER) || (GetObjectType(oMarked) == OBJECT_TYPE_WAYPOINT)) {break;} 
			oMarked = GetNextObjectInShape(SHAPE_SPHERE, 2.5, lMarked, TRUE, OBJECT_TYPE_ALL); 
			}
		}
	if(oMarked == OBJECT_INVALID) {
		oMarked = GetArea(oCaster);
		}
	
	if(GetObjectType(oMarked) == OBJECT_TYPE_CREATURE) {nExpire = 30;}
	int nAM = 1;
	while (nAM < 5) {
		if((ACR_GetPersistentString(oMarked, "ACR_ARCANEMARK" + IntToString(nAM)) == GetName(oCaster)) && (ACR_GetPersistentLocation(oMarked, "ACR_ARCANEMARKLoc" + IntToString(nAM)) == lMarked)) {
			SendMessageToPC(oCaster, sName + " already bears your arcane mark."); 
			return;
			}
		if(ACR_GetPersistentString(oMarked, "ACR_ARCANEMARK" + IntToString(nAM)) == "") {
			SendMessageToPC(oCaster, sName + " now bears your arcane mark."); 
			ACR_SetPersistentString(oMarked, "ACR_ARCANEMARK" + IntToString(nAM), GetName(oCaster), nExpire);
			ACR_SetPersistentLocation(oMarked, "ACR_ARCANEMARKLoc" + IntToString(nAM), lMarked, nExpire);
			object oMark = CreateObject(OBJECT_TYPE_PLACEABLE, "ipoint_arcane_mark", lMarked, TRUE);
			return;
			}
		nAM ++;
		}
			
	SendMessageToPC(oCaster, "This " + sName + " cannot hold any more arcane marks.");
	} 
	  
	
//Read Magic
if(GetSpellId() == 3003) {

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
						//SendMessageToAllDMs("RM" + IntToString(nRM) + " " + GetTag(oMark));
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
					//SendMessageToAllDMs("RM" + IntToString(nRM) + " " + GetTag(oMark));
				    if(GetTag(oMark) == "ipoint_arcane_mark") {nMarked = 1;}
					oMark = GetNextObjectInShape(SHAPE_SPHERE, 1.0, lMarked, TRUE, OBJECT_TYPE_PLACEABLE);
					}
				if(nMarked != 1) {CreateObject(OBJECT_TYPE_PLACEABLE, "ipoint_arcane_mark", lMarked, TRUE);}
				SendMessageToPC(oCaster, sName + " bears an arcane mark that reads: " + ACR_GetPersistentString(oReadMagic, "ACR_ARCANEMARK" + IntToString(nRM)));
				}
			}
		}
	}
	
//Erase

if(GetSpellId() == 3137) {
	object oMarked = GetSpellTargetObject();
	location lMarked = GetLocation(oMarked);
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
	if(oMarked == OBJECT_INVALID) {oMarked = GetArea(oCaster);}
	
	if(oMarked != OBJECT_INVALID) {
		int nCasterLevel = GetCasterLevel(oCaster); 
		int nCLRoll = d20(1);
		SendMessageToPC(oCaster, "Caster level check: " + IntToString(nCLRoll) + " + " + IntToString(nCasterLevel) + " = " + IntToString(nCLRoll + nCasterLevel) + " vs DC15");
		if(nCLRoll <= 2) {SendMessageToPC(oCaster, "A natural 1 or 2 is always a failure on erasing magical writing.");}
		if((nCasterLevel + nCLRoll < 15) || (nCLRoll <= 2)) {
			SendMessageToPC(oCaster, "Your Erase spell fails.");
			if((FindSubString(GetTag(oMarked), "glyph_ward") != -1) || (FindSubString(GetResRef(oMarked), "glyph_ward") != -1)) {
				SendMessageToPC(oCaster, "You activate the " + GetName(oMarked) + "!");
				if((GetObjectType(oMarked) == OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_WAYPOINT) && (FindSubString(GetTag(oMarked), "glyph_ward") != -1)) {SendMessageToAllDMs("1 " + GetTag(oMarked)); AssignCommand(oMarked, ActionCastSpellAtLocation(549, lMarked, METAMAGIC_ANY, TRUE, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));}
				if((GetObjectType(oMarked) == OBJECT_TYPE_AREA_OF_EFFECT) && (FindSubString(GetTag(oMarked), "glyph_ward") != -1)) {SendMessageToAllDMs("2 " + GetTag(oMarked)); SignalEvent( oMarked, EventUserDefined( 2000) );}
				if(GetObjectType(oMarked) == OBJECT_TYPE_PLACEABLE) {SendMessageToAllDMs("3 " + GetTag(oMarked)); SignalEvent( oMarked, EventUserDefined( 2000) );}
				}
			}
		else {
			effect eErase = EffectVisualEffect(VFX_IMP_EVIL_HELP);
			object oMark = GetNearestObjectByTag("ipoint_arcane_mark", oMarked, 1);
			if(oMarked == GetArea(oCaster)) {oMark = GetNearestObjectByTag("ipoint_arcane_mark", oCaster, 1);}
			int nAM = 1;
			int nErased = 0;
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
			if(nErased == 0) {SendMessageToPC(oCaster, "You found no arcane marks to erase.");}
			
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
	}
 
		
//Summon Instrument
if(GetSpellId() == 3071) {
	SignalEvent( GetSpellTargetObject(), EventSpellCastAt( OBJECT_SELF, GetSpellId(), FALSE ) );
	object oCaster = OBJECT_SELF;
	effect eBardSong = EffectVisualEffect(VFX_DUR_BARD_SONG, 0);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBardSong, oCaster, 3.0);
	ActionPlayAnimation(ANIMATION_FIREFORGET_BARDSONG, 1.0, 3.0);
	int nPerform = ACR_GetHighestPerformSkill(oCaster, FALSE);
	SendMessageToAllDMs("nPerform =" + IntToString(nPerform));
	string sPerform = "abr_it_msc_lute";
	string sPerformScry = "lute";
	if(nPerform == 60) {sPerform = "abr_it_msc_drum"; sPerformScry = "drum";}
	if(nPerform == 62) {sPerform = "abr_it_msc_flute"; sPerformScry = "flute";}
	object oPerform = CreateItemOnObject(sPerform, oCaster, 1);
	DelayCommand(2.0, ActionEquipItem(oPerform, INVENTORY_SLOT_RIGHTHAND)); 
	int nBardLevel = GetCasterLevel(oCaster);
	float nDuration = nBardLevel * 60.0;
	DestroyObject(oPerform, nDuration);
	
	object oScryer = oCaster;
	location lTarget = GetLocation(oScryer);
	object oScry = GetFirstObjectInShape(SHAPE_SPHERE, 5.0, lTarget, FALSE, OBJECT_TYPE_PLACEABLE);
	string sPlaceableTag = GetTag(oScry);
		while(oScry != OBJECT_INVALID) {
			sPlaceableTag = GetTag(oScry);
			if(FindSubString(sPlaceableTag, "_SCRY_") != -1) {
				object oFocus = CreateItemOnObject("abr_it_scry_focus", oScryer, 1);
				SetFirstName(oFocus, "Scrying Shard");
				SendMessageToPC(oScryer, "A shard shaped like a " + sPerformScry + " shimmers into your hand, out of the " + GetName(oScry) + ", leaving the glass unblemished.");
			 }
			oScry = GetNextObjectInShape(SHAPE_SPHERE, 5.0, lTarget, FALSE, OBJECT_TYPE_PLACEABLE);
			}	
}

//Create Water
if(GetSpellId() == 3068) {
	ActionPlayAnimation(ANIMATION_LOOPING_WORSHIP, 1.0, 3.0);
	object oScryer = OBJECT_SELF;
	effect eCreateWater = EffectVisualEffect(VFX_DUR_PROT_PREMONITION, 0);
	effect eCreateWater2 = EffectVisualEffect(VFX_IMP_MAGIC_PROTECTION, 0);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eCreateWater, oScryer, 3.0);
	DelayCommand(3.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eCreateWater2, oScryer));
	TLChangeAreaGroundTiles(GetArea(oScryer), 401,3,3,1.5);
	int nCasterType = GetLastSpellCastClass();
	SetLocalInt(oScryer, "nSpellCasterType", nCasterType);
	SendMessageToAllDMs("Spellhook: nSpellCasterType = " + IntToString(nCasterType));
	object oScry = GetSpellTargetObject();
	location lTarget = GetLocation(oScryer);
	if(nCasterType == CLASS_TYPE_DRUID) {
		lTarget = GetSpellTargetLocation();
		oScry = GetFirstObjectInShape(SHAPE_SPHERE, 5.0, lTarget, FALSE, OBJECT_TYPE_TRIGGER);
		string sTriggerTag = GetTag(oScry);
		while(oScry != OBJECT_INVALID) {
			sTriggerTag = GetTag(oScry);
			if(FindSubString(sTriggerTag, "_SCRY_") != -1) {
				SignalEvent(oScry, EventSpellCastAt( OBJECT_SELF, GetSpellId(), FALSE ) );
				object oFocus = CreateItemOnObject("abr_it_scry_focus", oScryer, 1);
				SetFirstName(oFocus, "Scrying Droplet");
				SendMessageToPC(oScryer, "You call forth a droplet of water vapor, catching it in a vial as it rises from the " + GetName(oScry) + ".");
			    SetItemIcon(oFocus, 1896);
				return;
				}
			oScry = GetNextObjectInShape(SHAPE_SPHERE, 5.0, lTarget, FALSE, OBJECT_TYPE_TRIGGER);
			}
		}
	 	
	if(GetTag(oScry) != "ACR_SCRY_OBJECT") 
		{CreateItemOnObject("abr_it_food_water", oScryer, 1);
		 SendMessageToPC(oScryer, "Water vapor forms in the air around you, and condenses into a small bottle you have ready for it.");
		}
	}

// NonDetection
if(GetSpellId() == 3092) {
	SignalEvent( GetSpellTargetObject(), EventSpellCastAt( OBJECT_SELF, GetSpellId(), FALSE ) );
	object oCaster = OBJECT_SELF;
	object oTarget = GetSpellTargetObject();
	int nCL = GetCasterLevel(OBJECT_SELF);
	float fDuration = nCL * 60.0 * 60.0;
	effect eIcon = EffectEffectIcon(52);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eIcon, oTarget, fDuration);
	int nDC = 15 + nCL;
	if(oCaster != oTarget) {
		nDC = 11 + nCL;
		}
	SetLocalInt(oTarget, "abr_sp_nondetect", nDC);
	SendMessageToPC(OBJECT_SELF, "You feel protections cloaking your mind from external prying.");
	effect eSanctuary = EffectVisualEffect(VFX_DUR_SANCTUARY, TRUE);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSanctuary, oTarget, 5.0);
	DelayCommand(fDuration, SetLocalInt(OBJECT_SELF, "abr_sp_nondetect", 0));
}
		
// Mage's Private Sanctum
if(GetSpellId() == 3157) {
	SignalEvent( GetSpellTargetObject(), EventSpellCastAt( OBJECT_SELF, GetSpellId(), FALSE ) );
	object oCaster = OBJECT_SELF;
	float fDuration = 24 * 60.0 * 60.0;
	effect eIcon = EffectEffectIcon(52);
	effect eAOE = EffectAreaOfEffect(AOE_PER_GLYPH_OF_WARDING, "tsm_sanctum_onenter", "tsm_sanctum_onhb", "tsm_sanctum_onexit", "aoe_sanctum");
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, GetLocation(oCaster), fDuration);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eIcon, oCaster, fDuration);
	//SendMessageToPC(oCaster, "You feel protections cloaking your mind from external prying.");
 	SetLocalInt(oCaster, "abr_sp_sanctum", 1);
	}

//Detect Scrying
if(GetSpellId() == 3058) {
	SignalEvent( GetSpellTargetObject(), EventSpellCastAt( OBJECT_SELF, GetSpellId(), FALSE ) );
	SetLocalInt(OBJECT_SELF, "abr_sp_detectScry", 1);
    float fDuration = 24 * 60.0 * 60.0;
	effect eIcon = EffectEffectIcon(54);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eIcon, oTarget, fDuration);
	DelayCommand(fDuration, SetLocalInt(OBJECT_SELF, "abr_sp_detectScry", 0));
    object oSensor = GetFirstObjectInShape(SHAPE_SPHERE, 40.0, GetLocation(OBJECT_SELF), FALSE, OBJECT_TYPE_CREATURE);
	int nInc = 0;
	while((oSensor != OBJECT_INVALID) && (nInc < 50)) {
	if(FindSubString(GetTag(oSensor), "scry_send") != -1)
		{SendMessageToPC(OBJECT_SELF, "You see a small glowing orb floating in the air.");
		 object oScryer = GetLocalObject(oSensor, "oScryer");
		 object oScry = GetLocalObject(oScryer, "oScry");
		 object oScrySelf = GetLocalObject(oSensor, "oScrySelf");
		 object oScrySpeak = GetLocalObject(oSensor, "oScrySpeak");
		 if(oScrySelf != OBJECT_INVALID)
		 	{oScryer = oScrySelf;
			 }
		 object oScryerArea = GetArea(oScryer);
		 string sScryerArea = GetName(oScryerArea);
		 int nCasterLevel = GetLocalInt(oSensor, "nCasterLevel");
		 int nCasterRoll = d20(1);
		 int nCasterOpposed = nCasterLevel + nCasterRoll;
		 int nDetectorLevel = GetCasterLevel(OBJECT_SELF);
		 int nDetectorRoll = d20(1);
		 int nDetectorOpposed = nDetectorLevel + nDetectorRoll;
		 if(nDetectorOpposed >= nCasterOpposed) {
		  	SendMessageToPC(OBJECT_SELF, "You feel your Detect Scrying spell best the defences of the caster of the scrying sensor.");
			SendMessageToPC(OBJECT_SELF, "You get a visual image of the scryer. They look like " + GetName(oScryer));
			SendMessageToPC(OBJECT_SELF, "You know that this person is located at the direction and distance of " + sScryerArea );
			SendMessageToPC(OBJECT_SELF, "A moment later, the scrying sensor vanishes.");
			SetLocalObject(oScry, "oScried", OBJECT_INVALID);
			SetLocalObject(oScry, "oScrySpeak", OBJECT_INVALID);
			SetLocalObject(oScry, "oScryer", OBJECT_INVALID);
			SetLocalObject(oScry, "oScrySend", OBJECT_INVALID);
			SetLocalObject(oScryer, "oScried", OBJECT_INVALID);
			SetLocalObject(oScryer, "oScrySpeak", OBJECT_INVALID);
			SetLocalObject(oScryer, "oScrySend", OBJECT_INVALID);
			SetLocalObject(oScryer, "oScry", OBJECT_INVALID);
			SetLocalObject(OBJECT_SELF, "oScrySpeak", OBJECT_INVALID);
			SetLocalObject(OBJECT_SELF, "oScryer", OBJECT_INVALID);
			SetLocalObject(OBJECT_SELF, "oScry", OBJECT_INVALID);
			SetLocalObject(OBJECT_SELF, "oScrySend", OBJECT_INVALID);
			SetLocalInt(oScry, "nScryActive", 0);
			DestroyObject(oScrySpeak, 2.0);		
			DestroyObject(oSensor, 6.0);
			}
		 else {SendMessageToPC(OBJECT_SELF, "You feel your Detect Scrying spell attempt to identify the person scrying you, but fail.");}
		 effect eEffect = GetFirstEffect(oSensor);
		 int nRep = 0;
		 while ((GetIsEffectValid(eEffect)) && (nRep < 10)) { 
			 RemoveEffect(oSensor, eEffect);
			 eEffect = GetNextEffect(oSensor);
			 nRep ++;
			}
		}
	oSensor = GetNextObjectInShape(SHAPE_SPHERE, 40.0, GetLocation(OBJECT_SELF), FALSE, OBJECT_TYPE_CREATURE);
	nInc++;
		}
	}
	 

//Scrying and Greater Scrying
if((GetSpellId() == 3056) || (GetSpellId() == 3057))
	{SignalEvent( GetSpellTargetObject(), EventSpellCastAt( OBJECT_SELF, GetSpellId(), FALSE ) );
	//Define Scryer and Scrying Object
	 object oScryer = OBJECT_SELF;
	 object oArea = GetArea(oScryer);
	 int nCasterType = GetLastSpellCastClass();
	 //SendMessageToPC(oScryer, "nCasterType = " + IntToString(nCasterType));
	 SetLocalInt(oScryer, "nSpellCasterType", nCasterType);
	 object oTarget = GetSpellTargetObject();
	 //object oScry;
	 //if(nCasterType != CLASS_TYPE_DRUID) {
	 float fDistancePlc = 0.0;
	 object oScryPlc = GetFirstObjectInShape(SHAPE_SPHERE, 5.0, GetLocation(oScryer), FALSE, OBJECT_TYPE_PLACEABLE);
	 	//SendMessageToPC(oScryer, "0. sScry Name = " + GetName(oScryPlc));
		while(oScryPlc != OBJECT_INVALID) {
	 	   if(FindSubString(GetTag(oScryPlc), "_SCRY") != -1){
			    string sPlcTag = GetTag(oScryPlc);
				//SendMessageToPC(oScryer, "1. sScryPlc Name = " + GetName(oScryPlc));
				//SendMessageToPC(oScryer, "1. sPlcTag = " + sPlcTag);
			    SetLocalObject(oArea, "oScryPlc", oScryPlc);
			    fDistancePlc = GetDistanceBetween(oScryer, oScryPlc);
				//SendMessageToPC(oScryer, "Distance to oScryPlc = " + FloatToString(fDistancePlc));
				}
		  oScryPlc = GetNextObjectInShape(SHAPE_SPHERE, 5.0, GetLocation(oScryer), FALSE, OBJECT_TYPE_PLACEABLE);
	   	}
	//}
	oScryPlc = GetLocalObject(oArea, "oScryPlc");
	object oScry = GetLocalObject(oArea, "oScryPlc");
	SetLocalObject(oArea, "oScry", oScry);
	//SendMessageToAllDMs("1. sScry ResRefPlc = " + GetResRef(oScryPlc));
	int nObjectTypePlc = GetObjectType(oScryPlc);
	//SendMessageToAllDMs("1. nObjectTypePlc = " + IntToString(nObjectTypePlc));
	SetLocalObject(oArea, "oScryPlc", OBJECT_INVALID);
			   
	float fDistanceTrg = 0.0;		
	object oScryTrg = GetFirstObjectInShape(SHAPE_SPHERE, 5.0, lTarget, FALSE, OBJECT_TYPE_TRIGGER);
	if((nCasterType == CLASS_TYPE_DRUID) || (nCasterType == 255)) {
		location lTarget = GetLocation(oScryer);
		while(oScryTrg != OBJECT_INVALID) {
			string sTriggerTagTrg = GetTag(oScryTrg);
			SendMessageToAllDMs("2. oScryTrg Name = " + GetName(oScryTrg));
			//SendMessageToPC(oScryer, "2. sTriggerTagTrg = " + sTriggerTagTrg);
			if(FindSubString(sTriggerTagTrg, "_SCRY_") != -1) {
				 SetLocalObject(oArea, "oScryTrg", oScryTrg);
				 fDistanceTrg = GetDistanceBetween(oScryer, oScryTrg);
				 //SendMessageToPC(oScryer, "Distance to oScryTrg = " + FloatToString(fDistanceTrg));
				 if(((fDistanceTrg > 0.0) && (fDistanceTrg < fDistancePlc)) ||(oScryPlc == OBJECT_INVALID))
				 	{oScry = oScryTrg;
					 SetLocalObject(oArea, "oScry", oScryTrg);
				 	}
				}
			oScryTrg = GetNextObjectInShape(SHAPE_SPHERE, 5.0, lTarget, FALSE, OBJECT_TYPE_TRIGGER);
			}
		 
		 }
	
	oScry = GetLocalObject(oArea, "oScry");
		 
	//SendMessageToPC(oScryer, "2. sScry ResRefTrg = " + GetResRef(oScryTrg));
	int nObjectTypeTrg = GetObjectType(oScryTrg);
	//SendMessageToPC(oScryer, "2. nObjectTypeTrg = " + IntToString(nObjectTypeTrg));
	
	//SendMessageToPC(oScryer, "3. sScry ResRef = " + GetResRef(oScry));
	int nObjectType = GetObjectType(oScry);
	//SendMessageToPC(oScryer, "3. nObjectType = " + IntToString(nObjectType));
	
	
			
	 //Usage, range, and class restrictions
	 if(GetLocalInt(oScry, "nScryActive") == 1) {
	 	SendMessageToPC(oScryer, GetName(oScry) + " is already being used in a Scry spell.");
		}
		
	 if(oScry == OBJECT_INVALID) {
		SendMessageToPC(oScryer, "You must be near enough to touch a scrying object for your spell to activate it.");
		}
		
	 if((nCasterType == CLASS_TYPE_WIZARD) && (GetResRef(oScry) != "abr_pl_so_mirror") && (GetResRef(oScry) != "tsm_plc_scry_mirror")) {
	 	SendMessageToPC(oScryer, "There is no scrying mirror within range.");
		}
	 else if((nCasterType == CLASS_TYPE_BARD) && (GetResRef(oScry) != "abr_pl_so_mirror") && (GetResRef(oScry) != "tsm_plc_scry_mirror")) {
	 	SendMessageToPC(oScryer, "There is no scrying mirror within range.");
		}
	 else if((nCasterType == CLASS_TYPE_CLERIC) && (GetResRef(oScry) != "abr_pl_so_holyfont")) {
	 	SendMessageToPC(oScryer, "There is no holy font suitable for scrying within range.");
		}
	 else if((nCasterType == CLASS_TYPE_DRUID) && (GetResRef(oScry) != "abr_pl_so_pool") && (GetResRef(oScry) != "abr_trg_so_water")) {
	 	SendMessageToPC(oScryer, "There is no natural pool of water suitable for scrying within range.");
		}
	 else {//Get Scrying Object's location and calculate Scryer's spell DC and spell duration
			string sScryName = GetName(oScry);
			location lHere = GetLocation(oScry);
			int nScryerLevel = GetCasterLevel(oScryer);
	 	 	int nSpellLevel = GetSpellLevel(GetSpellId());
			float fScryTimer = nScryerLevel * 60.0;
			if(GetSpellId() == 3057) {
				fScryTimer = nScryerLevel * 60.0 * 60.0;
			}
			int nAbilityMod = GetAbilityModifier(ABILITY_INTELLIGENCE);
			if(GetLastSpellCastClass()== CLASS_TYPE_BARD || CLASS_TYPE_SORCERER || CLASS_TYPE_PALADIN) {
				nAbilityMod = GetAbilityModifier(ABILITY_CHARISMA);
				}
			if(GetLastSpellCastClass()== CLASS_TYPE_CLERIC || CLASS_TYPE_DRUID || CLASS_TYPE_RANGER) {
				nAbilityMod = GetAbilityModifier(ABILITY_WISDOM);
				}
				
			int nDC = 10 + nSpellLevel + nAbilityMod;
						
			//Create undetectable OOC Scrying Speaker at location of Scrying Object to receive scrying information about future scrying target
			object oScrySpeak = GetLocalObject(oScry, "oScrySpeak");
			if(oScrySpeak == OBJECT_INVALID) {
				oScrySpeak = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_scry_speak", lHere);
            	SetLocalObject(oScry, "oScrySpeak", oScrySpeak);
				}
				
			//SendMessageToPC(oScryer, "oScrySpeak = " + GetName(oScrySpeak));
			//Set all objects on each other
			SetLocalObject(oScrySpeak, "oScry", oScry);
			SetLocalObject(oScrySpeak, "oScryer", oScryer);
			SetLocalObject(oScry, "oScryer", oScryer);
			SetLocalObject(oScryer, "oScrySpeak", oScrySpeak);
			SetLocalObject(oScryer, "oScry", oScry);
			
			//Set all other variables on ScryListen
			SetLocalInt(oScrySpeak, "nScryDC", nDC);
			SetLocalInt(oScrySpeak, "nCasterLevel", nScryerLevel);
			SetLocalFloat(oScrySpeak, "fScryTimer", fScryTimer);
			SetFirstName(oScrySpeak, sScryName);
			
			SetLocalObject(oArea, "oScry", OBJECT_INVALID);
	
			//Over to ScrySpeaker's onspawn: tsm_scry_npc_onspawn
		}
	}
	
	if(FindSubString(GetTag(GetArea(GetLastSpellCaster())), "nw_cave_aq") != -1) 
	{//SendMessageToAllDMs(GetName(GetLastSpellCaster()) + " is in Aquatic Cave");
	 object oSwimTrg = GetNearestObject(OBJECT_TYPE_TRIGGER, oCaster, 1);
	 string sTrgTag = GetTag(oSwimTrg);
	 if((FindSubString(sTrgTag, "Walkmesh") == -1) && (FindSubString(sTrgTag, "archive") == -1)) {
	 //SendMessageToAllDMs(sTrgTag + " is the nearest trigger. Spell ID is " + IntToString(nSpellId));
	
	   if(nSpellId == 1199 ||nSpellId == 1208 || nSpellId == SPELL_COMBUST || nSpellId ==  SPELL_DELAYED_BLAST_FIREBALL  || nSpellId == SPELL_ELEMENTAL_SHIELD || nSpellId == SPELL_FIRE_STORM || nSpellId == SPELL_FLAME_ARROW || nSpellId == SPELL_FLAME_LASH || nSpellId == SPELL_FLAME_WEAPON || nSpellId == SPELL_FIREBALL || nSpellId == SPELL_FIREBRAND || nSpellId == SPELL_FIREBURST 
		|| nSpellId == SPELL_BURNING_HANDS || nSpellId == SPELL_FLAME_STRIKE || nSpellId == SPELL_GREATER_FIREBURST  || nSpellId == SPELL_INCENDIARY_CLOUD ||nSpellId == SPELL_INFERNO || nSpellId == SPELL_INFINITE_RANGE_FIREBALL 
		|| nSpellId == 1056 || nSpellId == 1057 || nSpellId == SPELL_METEOR_SWARM || nSpellId == SPELL_METEOR_SWARM_TARGET_CREATURE || nSpellId == SPELL_METEOR_SWARM_TARGET_LOCATION || nSpellId == SPELL_METEOR_SWARM_TARGET_SELF
		|| nSpellId == SPELL_SHROUD_OF_FLAME || nSpellId == SPELL_WALL_OF_FIRE)
			{ SetModuleOverrideSpellScriptFinished();
			  ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSpellFail, oCaster, 6.0);
			  SendMessageToPC(oCaster, "Your fire spell fizzles.");
			  SendMessageToAllDMs(GetName(oCaster) + "'s Fire based spell fizzled in " + sArea + ".");
			}
		}
		
		if(nSpellId == SPELL_SHOCKING_GRASP || nSpellId == SPELL_ELECTRIC_JOLT || nSpellId == SPELL_GEDLEES_ELECTRIC_LOOP || nSpellId == SPELL_LESSER_ORB_OF_ELECTRICITY || nSpellId == SPELL_ORB_OF_ELECTRICITY ||nSpellId == SPELL_BALL_LIGHTNING ||nSpellId == SPELL_CALL_LIGHTNING |nSpellId == SPELL_CALL_LIGHTNING_STORM || nSpellId == SPELL_CHAIN_LIGHTNING || nSpellId == SPELL_LIGHTNING_BOLT)
			{ SetModuleOverrideSpellScriptFinished();
			  ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSpellFail, oCaster, 6.0);
			  SendMessageToPC(oCaster, "Your lightning spell sends an electric shock through you...and conducts it throughout the water!");
			  SendMessageToAllDMs(GetName(oCaster) + "'s Lightning based spell ran wild in " + sArea + ".");
			  AssignCommand(oCaster, ActionCastFakeSpellAtObject(SPELL_CALL_LIGHTNING_STORM, oCaster, PROJECTILE_PATH_TYPE_DEFAULT));
			  object oCreatureA = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, CREATURE_ALIVE_BOTH, oCaster, 1);
			  object oCreatureB = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, CREATURE_ALIVE_BOTH, oCaster, 2);
			  object oCreatureC = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, CREATURE_ALIVE_BOTH, oCaster, 3);
			  object oCreatureD = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, CREATURE_ALIVE_BOTH, oCaster, 4);
			  object oCreatureE = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, CREATURE_ALIVE_BOTH, oCaster, 5);
			  object oCreatureF = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, CREATURE_ALIVE_BOTH, oCaster, 6);
			  object oCreatureG = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, CREATURE_ALIVE_BOTH, oCaster, 7);
			  object oCreatureH = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, CREATURE_ALIVE_BOTH, oCaster, 8);
			  ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(d20(), DAMAGE_TYPE_ELECTRICAL, DAMAGE_POWER_NORMAL, FALSE), oCaster);
			  if(GetDistanceBetween(oCaster, oCreatureA) < 40.0) {
			  	ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(d20(), DAMAGE_TYPE_ELECTRICAL, DAMAGE_POWER_NORMAL, FALSE), oCreatureA);
			 	}
			  if(GetDistanceBetween(oCaster, oCreatureB) < 40.0) {
			  	ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(d20(), DAMAGE_TYPE_ELECTRICAL, DAMAGE_POWER_NORMAL, FALSE), oCreatureB);
			 	}
		      if(GetDistanceBetween(oCaster, oCreatureC) < 40.0) {
			  	ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(d20(), DAMAGE_TYPE_ELECTRICAL, DAMAGE_POWER_NORMAL, FALSE), oCreatureC);
			 	}
			  if(GetDistanceBetween(oCaster, oCreatureD) < 40.0) {
			  	ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(d20(), DAMAGE_TYPE_ELECTRICAL, DAMAGE_POWER_NORMAL, FALSE), oCreatureD);
			 	}
			  if(GetDistanceBetween(oCaster, oCreatureE) < 40.0) {
			  	ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(d20(), DAMAGE_TYPE_ELECTRICAL, DAMAGE_POWER_NORMAL, FALSE), oCreatureE);
			 	}
			  if(GetDistanceBetween(oCaster, oCreatureF) < 40.0) {
			  	ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(d20(), DAMAGE_TYPE_ELECTRICAL, DAMAGE_POWER_NORMAL, FALSE), oCreatureF);
			 	}
		      if(GetDistanceBetween(oCaster, oCreatureG) < 40.0) {
			  	ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(d20(), DAMAGE_TYPE_ELECTRICAL, DAMAGE_POWER_NORMAL, FALSE), oCreatureG);
			 	}
			  if(GetDistanceBetween(oCaster, oCreatureH) < 40.0) {
			  	ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(d20(), DAMAGE_TYPE_ELECTRICAL, DAMAGE_POWER_NORMAL, FALSE), oCreatureH);
			 	}
		
		}
	}
	
if((FindSubString(GetTag(GetArea(oCaster)), "5f_") != -1) || (FindSubString(GetTag(GetArea(oCaster)), "5h_") != -1)|| (FindSubString(GetTag(GetArea(oCaster)), "6f_") != -1) || ((FindSubString(GetTag(GetArea(oCaster)), "5g_") != -1) && (FindSubString(GetTag(GetArea(oCaster)), "felbarr") == -1)))
	{if(nSpellId == SPELL_COMBUST ||nSpellId ==  SPELL_DELAYED_BLAST_FIREBALL  || nSpellId == SPELL_ELEMENTAL_SHIELD || nSpellId == SPELL_FIRE_STORM || nSpellId == SPELL_FLAME_ARROW || nSpellId == SPELL_FLAME_LASH || nSpellId == SPELL_FLAME_WEAPON || nSpellId == SPELL_FIREBALL || nSpellId == SPELL_FIREBRAND || nSpellId == SPELL_FIREBURST 
		|| nSpellId == SPELL_BURNING_HANDS || nSpellId == SPELL_FLAME_STRIKE || nSpellId == SPELL_GREATER_FIREBURST  || nSpellId == SPELL_INCENDIARY_CLOUD ||nSpellId == SPELL_INFERNO || nSpellId == SPELL_INFINITE_RANGE_FIREBALL 
		|| nSpellId == 1056 || nSpellId == 1057 || nSpellId == SPELL_METEOR_SWARM || nSpellId == SPELL_METEOR_SWARM_TARGET_CREATURE || nSpellId == SPELL_METEOR_SWARM_TARGET_LOCATION || nSpellId == SPELL_METEOR_SWARM_TARGET_SELF
		|| nSpellId == SPELL_SHROUD_OF_FLAME || nSpellId == SPELL_WALL_OF_FIRE)
			{if(Random(100) < 50)
				{SendMessageToPC(oCaster, "You feel oddly out of touch with your spell.");
				 if(Random(100) < 25)
				 	{SendMessageToPC(oCaster, "The feeling intensifies and your spell goes awry!");
				    int iEffect = Random(5);
					string sNewSpell="";
					object oNewTarget=GetNearestObject(OBJECT_TYPE_CREATURE, oCaster, 1);
					string sNewTarget=GetName(oNewTarget);
					 if(iEffect == 0)
					 	{AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_FLARE, oNewTarget, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
						 sNewSpell="Flare";
						 }
					else if(iEffect == 1)
					 	{AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_LIGHT, oNewTarget, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
						 sNewSpell="Light";
						 }
					else if(iEffect == 2)
					 	{AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_COLOR_SPRAY, oNewTarget, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
						 sNewSpell="Color Spray";
						 }
					else if(iEffect == 3)
					 	{AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_DARKNESS, oNewTarget, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
						 sNewSpell="Darkness";
						 }
					else if(iEffect == 4)
					 	{SetModuleOverrideSpellScriptFinished();
						SendMessageToPC(oCaster, "Your spell fizzles.");
						sNewSpell="Flare";
						 }
					SendMessageToAllDMs(GetName(oCaster) + "'s Fire based spell went wrong in " + sArea + ". Iintended spell: " + IntToString(nSpellId) +". Instead, " + sNewSpell + " cast on " + sNewTarget + ".");
					} 
				}
			}
		}

	
	
	//Silverymoon's Mythal prohibits spells of certain domains, unless one is carrying a ward token
	if((FindSubString(GetTag(GetArea(oCaster)), "6d_int_silvy") != -1)  || (GetLocalInt(GetArea(oCaster), "IS_SILVERYMOON_EXT")))
			{if(nSpellId == SPELL_ANIMATE_DEAD || nSpellId == SPELL_AVASCULATE || nSpellId == SPELL_CIRCLE_OF_DEATH || nSpellId == SPELL_CREATE_GREATER_UNDEAD 
			    || nSpellId == SPELL_CREATE_UNDEAD || nSpellId == SPELL_DEATH_KNELL || nSpellId == SPELL_FINGER_OF_DEATH || nSpellId == SPELL_HORRID_WILTING 
				|| nSpellId == SPELL_PHANTASMAL_KILLER || nSpellId == SPELL_POWER_WORD_KILL || nSpellId == SPELL_RAY_OF_ENFEEBLEMENT || nSpellId == SPELL_SLAY_LIVING || nSpellId == SPELL_WAIL_OF_THE_BANSHEE)
				{if(GetItemPossessedBy(oCaster, "003_it_ward_thelbane") == OBJECT_INVALID)
				
				   {if((GetTag(GetArea(oCaster)) == "6d_int_silvy_ladycol_class_lvl") && (GetItemPossessedBy(oCaster, "slv_studentid") != OBJECT_INVALID) && (nSpellId == SPELL_RAY_OF_ENFEEBLEMENT))
						{SendMessageToAllDMs("Spell caster " + GetName(oCaster) + " possesses a Silvy Uni Student ID and just cast Ray of Enfeeblement inside Silvy Uni's wards.  Although forbidden outside the Uni and/or by non-students, a student dispensation was granted for classwork.");
			 			 SendMessageToPC(oCaster, "Your Ray of Enfeeblement spell functions. A hollow voice speaks softly from no place you can discern: 'Student Dispensation granted'.");
						}
					else {SetModuleOverrideSpellScriptFinished();
							 SendMessageToPC(oCaster, "Your death or evil spell dissipates.");
							 SendMessageToAllDMs("Spell caster " + GetName(oCaster) + " attempted to cast " + IntToString(nSpellId) + " inside Silverymoon's wards.  Evil, death or teleport spell are forbidden unless the caster carries a Thelbane token. The spell failed.");
					 		}
					}
			 	else if(GetItemPossessedBy(oCaster, "003_it_ward_thelbane") != OBJECT_INVALID)
					  	{SendMessageToAllDMs("Spell caster " + GetName(oCaster) + " possesses a Thelbane Ward token and just cast " + IntToString(nSpellId) + " inside Silverymoon's wards.  Even if usually forbidden, the wards were temporarily lifted for any evil, death or teleport spell.");
						 }
				 	
				}
		  	}
	
		
	 if((FindSubString(GetTag(GetArea(oCaster)), "sundabar_maiden") != -1) ||(FindSubString(GetTag(GetArea(oCaster)), "6d_int_silvy") != -1) || (GetLocalInt(GetArea(oCaster), "IS_SILVERYMOON_EXT"))) 
				{if(nSpellId == SPELL_COMBUST ||nSpellId ==  SPELL_DELAYED_BLAST_FIREBALL  || nSpellId == SPELL_ELEMENTAL_SHIELD || nSpellId == SPELL_FIRE_STORM || nSpellId == SPELL_FLAME_ARROW || nSpellId == SPELL_FLAME_LASH || nSpellId == SPELL_FLAME_WEAPON || nSpellId == SPELL_FIREBALL || nSpellId == SPELL_FIREBRAND || nSpellId == SPELL_FIREBURST 
					    || nSpellId == SPELL_BURNING_HANDS || nSpellId == SPELL_FLAME_STRIKE || nSpellId == SPELL_GATE || nSpellId == SPELL_GREATER_FIREBURST || nSpellId == SPELL_GREATER_PLANAR_BINDING || nSpellId == SPELL_INCENDIARY_CLOUD ||nSpellId == SPELL_INFERNO || nSpellId == SPELL_INFINITE_RANGE_FIREBALL 
						|| nSpellId == 1056 || nSpellId == 1057 || nSpellId == SPELL_LESSER_PLANAR_BINDING || nSpellId == SPELL_METEOR_SWARM || nSpellId == SPELL_METEOR_SWARM_TARGET_CREATURE || nSpellId == SPELL_METEOR_SWARM_TARGET_LOCATION || nSpellId == SPELL_METEOR_SWARM_TARGET_SELF || nSpellId == SPELL_PLANAR_ALLY 
						|| nSpellId == SPELL_PLANAR_BINDING || nSpellId == SPELL_SHROUD_OF_FLAME || nSpellId == SPELL_SUMMON_CREATURE_I 
						|| nSpellId == SPELL_SUMMON_CREATURE_II || nSpellId == SPELL_SUMMON_CREATURE_III || nSpellId == SPELL_SUMMON_CREATURE_IV || nSpellId == SPELL_SUMMON_CREATURE_V || nSpellId == SPELL_SUMMON_CREATURE_VI || nSpellId == SPELL_SUMMON_CREATURE_VII || nSpellId == SPELL_SUMMON_CREATURE_VIII 
						|| nSpellId == SPELL_WALL_OF_FIRE)
						{if((GetItemPossessedBy(oCaster, "003_it_ward_adrath") == OBJECT_INVALID) && (GetItemPossessedBy(oCaster, "003_it_ward_lauthaul") == OBJECT_INVALID) && (GetItemPossessedBy(oCaster, "003_it_ward_thelbane") == OBJECT_INVALID))
							{if((FindSubString(GetTag(GetArea(oCaster)), "ladycol") != -1) && (GetItemPossessedBy(oCaster, "slv_studentid") != OBJECT_INVALID) 
								&& (nSpellId == SPELL_SUMMON_CREATURE_I || nSpellId == SPELL_SUMMON_CREATURE_II || nSpellId == SPELL_SUMMON_CREATURE_III))
									{SendMessageToAllDMs("Spell caster " + GetName(oCaster) + " possesses a Silvy Uni Student ID and just cast Summon Creature I, II, or III inside Silvy Uni's wards.  Although forbidden outside the Uni and/or by non-students unless carrying a ward token, a student dispensation was granted for classwork.");
					 			     SendMessageToPC(oCaster, "Your low level summoning spell functions. A hollow voice speaks softly from no place you can discern: 'Student dispensation granted. Call your creature to you.'");
									 DelayCommand(3.0, AssignCommand(GetAssociate(ASSOCIATE_TYPE_SUMMONED, oCaster, 1), ActionMoveAwayFromObject(GetNearestObject(OBJECT_TYPE_PLACEABLE, GetAssociate(ASSOCIATE_TYPE_SUMMONED, oCaster, 1), 1) , TRUE, 20.0)));
									 DelayCommand(5.0, AssignCommand(GetAssociate(ASSOCIATE_TYPE_SUMMONED, oCaster, 1), ActionMoveAwayFromObject(GetNearestObject(OBJECT_TYPE_PLACEABLE, GetAssociate(ASSOCIATE_TYPE_SUMMONED, oCaster, 1), 1) , TRUE, 20.0)));
									 DelayCommand(7.0, AssignCommand(GetAssociate(ASSOCIATE_TYPE_SUMMONED, oCaster, 1), ActionMoveAwayFromObject(GetNearestObject(OBJECT_TYPE_PLACEABLE, GetAssociate(ASSOCIATE_TYPE_SUMMONED, oCaster, 1), 1) , TRUE, 20.0)));
									 }
						    else if((FindSubString(GetTag(GetArea(oCaster)), "ladycol") != -1) && (GetItemPossessedBy(oCaster, "slv_studentid") != OBJECT_INVALID) 
								&& (nSpellId == SPELL_BURNING_HANDS ))
									{SendMessageToAllDMs("Spell caster " + GetName(oCaster) + " possesses a Silvy Uni Student ID and just cast Burning Hands inside Silvy Uni's wards.  Although forbidden outside the Uni and/or by non-students unless carrying a ward token, a student dispensation was granted for classwork.");
					 			     SendMessageToPC(oCaster, "Your low level Evocation [Fire] spell functions. A hollow voice speaks softly from no place you can discern: 'Student dispensation granted.'");
									 }
						   	else 
								{SetModuleOverrideSpellScriptFinished();
								 SendMessageToPC(oCaster, "Your evocation [fire] or conjuration [summoning] spell dissipates.");
								 SendMessageToAllDMs(GetName(oCaster) + "'s Evocation [Fire], or Conjuration [Summoning] spell failed inside Silverymoon's mythal. Spell ID: " + IntToString(nSpellId));
							 	 }
							  }
						 else 
							 {SendMessageToAllDMs("Spell caster " + GetName(oCaster) + " possesses an Adrath, Lauthaul or Thelbane Ward Token and just cast " + IntToString(nSpellId) + " inside Silverymoon's wards.  Even if usually forbidden, the wards were temporarily lifted for any Evocation [Fire], or Conjuration [Summoning] spell.");
							 }
						}
				}	 
	
	//Detect Magic inside the Lady's College						 
	if(FindSubString(GetTag(GetArea(oCaster)), "ladycol") != -1) 
		{if(nSpellId == 930)					 
			{SendMessageToPC(oCaster, "The sense of magic comes from every side and completely overwhelms any individual magical signatures.");}
		 if(nSpellId == 3059) 
		 	{if(FindSubString(GetTag(GetArea(oCaster)), "class") != -1)					 
				{object oMyEvocWindow = GetObjectByTag("slv_evo200_window");
			 	if(GetDistanceBetween(oCaster, oMyEvocWindow) < 10.0f)
					{SendMessageToPC(oCaster, "The vapor rising off the elaborate mechanics inside the Standard Evocation protective circle emanate a sense of poison.");}
				else if(GetDistanceBetween(oCaster, oMyEvocWindow) < 25.0f)
					{SendMessageToPC(oCaster, "You have an awareness of poisonous materials somewhere inside the Evocation rooms.");}
			 	}
			 else 
		 		{SendMessageToPC(oCaster, "You have no awareness of poison in your immediate vicinity.");}
			}
		}
			
	//4thPeak Cave Ruins Lever
	if((GetTag(GetArea(oCaster)) == "5b_int_fourthpeak_caveruins") && (nSpellId == SPELL_GREASE ))
	 	{object oLever = GetObjectByTag("dr_lockdoor_lvr_1");
			 
	    object oLever2 = GetObjectByTag("dr_lockdoor_lvr_2");
			 
	     SetLocalInt(oLever, "Greased", 1);
		 SetLocalInt(oLever2, "Greased", 1);
		 }
		 
	//Deandragon_d_Bless_Weapon
	
	if((GetTag(oTarget)=="003_it_wpn_dragontalon") && (nSpellId==SPELL_BLESS_WEAPON))
		{SendMessageToPC(GetItemPossessor(oTarget), "The edge of the surgical blade grows -- if possible -- even sharper with the blessing.");
		 SetLocalInt(GetItemPossessor(oTarget), "BlessedWeapon", 1);
		}
	
	//Feather Fall over Frost Hills Glacier
	if((GetTag(GetArea(oCaster)) == "5b_ext_frosthills_glacier") && (nSpellId == SPELL_FEATHER_FALL ) && (GetItemPossessedBy(oCaster, "003_it_slv_teleport") != OBJECT_INVALID))
	 	{ object oCollWP = GetWaypointByTag("slv_deansphinx_e_air_collboxWP");
		 object oMyCollisionBox  = GetObjectByTag("slv_deansphinx_e_air_collbox");
		 object oEndWP = GetWaypointByTag("slv_deansphinx_e_flight_WP");
			  
	
			SetLocalInt(oCaster, "Gravity", 1);
			 DelayCommand(600.0, SetLocalInt(oCaster, "Gravity", 0));
			 DestroyObject(oMyCollisionBox);
			 SetLocalObject(oCollWP, "oMyCollisionBox", OBJECT_INVALID);
			 DelayCommand(5.0, SendMessageToPC(oCaster, "Gravity rights itself and you immediately begin dropping towards the glacier at a controlled rate."));
			 DelayCommand(5.0, AssignCommand(oCaster, ActionJumpToLocation(GetLocation(oEndWP))));
			 DelayCommand(10.0, SendMessageToPC(oCaster, "You land upon the glacier with the gentleness of a falling snowflake."));
			  }
	
		
		//Targeting a set of armor that absorbs magic and spits it out in unexpected ways.
	object oArmor = GetItemInSlot(INVENTORY_SLOT_CHEST, oTarget);
	if(GetTag(oArmor) == "003_it_arm_breastplt_petr") {
	   int nCastSize = Random(20);
	   if(nCastSize==1)	{
		  SendMessageToPC(oTarget, "The concentric growth rings of your armor suddenly shrink. For a moment it is horribly tight...and then fits again.");
	      AssignCommand(oTarget, ActionCastSpellAtObject(SPELL_REDUCE_PERSON, oTarget, METAMAGIC_NONE, TRUE, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
		  }		
		else if(nCastSize==2)	{
		  SendMessageToPC(oTarget, "The concentric growth rings of your armor suddenly dilate. For a moment you feel yourself falling out through the bottom of it...and then it fits again.");
	      AssignCommand(oTarget, ActionCastSpellAtObject(SPELL_ENLARGE_PERSON, oTarget, METAMAGIC_NONE, TRUE, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
		  }
		  
		if(GetLocalInt(oTarget, "Piezo")!= 1) {
		 SetLocalInt(oTarget, "Piezo", 1);
		 SendMessageToPC(oTarget, "You suddenly have more understanding blossom in your awareness:");
		 SendMessageToPC(oTarget, "Like all magic armor, it shrinks or expands as necessary to fit the size of its wearer. This was a prototype, and has a small design flaw when the wearer is targeted by magics...either offensive or defensive.");
		 SendMessageToPC(oTarget, "Although the armor is made of crystal tuned to absorb magical attacks, it unfortunately sometimes discharges that power in a piezoarcane reaction. There is a small, random chance that the growth rings on the armor will either suddenly dilate or shrink down, followed a moment later by its wearer performing the same enlargement or reduction.");
		}
	}
	
//Campaign consequences for DeanSphinx 2021

object oOlivusCast;
if(FindSubString(GetName(oCaster), "Olivu") != -1)
	{oOlivusCast = oCaster;}
	
//object oJhessiCast;
//if(FindSubString(GetName(oCaster), "Jhess") != -1)
//	{oJhessiCast = oCaster;}

object oOlivusTarget;
if(FindSubString(GetName(oTarget), "Olivu") != -1)
	{oOlivusTarget = oTarget;}
//object oJhessiTarget;
//if(FindSubString(GetName(oTarget), "Jhess") != -1)
//	{oJhessiTarget = oTarget;}

if((oCaster == oOlivusCast) || (oTarget == oOlivusTarget)) {	
	//SendMessageToPC(oCaster, "oCaster is " + GetName(oCaster));
	int nSpellcraft = GetSkillRank(SKILL_SPELLCRAFT, oCaster);
	//SendMessageToPC(oCaster, "nSpellcraft is " + IntToString(nSpellcraft));
	int nFail = Random(6);
	//SendMessageToPC(oCaster, "nFail is " + IntToString(nFail));
	int nSpellLevel = GetSpellLevel(nSpellId);
	//SendMessageToPC(oCaster, "nSpellLevel is " + IntToString(nSpellLevel));
	int nDC = d20(1) + nSpellcraft;
	//SendMessageToPC(oCaster, "nDC is " + IntToString(nDC));
	int nRunningTab = GetCampaignInt("DeanSphinx", "CrystalCharge", oCaster);
	//SendMessageToPC(oCaster, "nRunningTab is " + IntToString(nRunningTab));
	if(oCaster == oOlivusCast) {
	int nCrystalCast = GetCampaignInt("DeanSphinx", "CrystalCast", oCaster);
	if((nFail == 1)&& (nCrystalCast == 0) && (nSpellId != 32)&& (nSpellId != 33)&& (nSpellId != 31)&& (nSpellId != 34)&& (nSpellId != 35)&& (nSpellId != 1020)&& (nSpellId != 1021)&& (nSpellId != 1)&& (nSpellId != 6)&& (nSpellId != 189)&& (nSpellId != 431)&& (nSpellId != 154)&& (nSpellId != 146)&& (nSpellId != 414)&& (nSpellId != 148)&& (nSpellId != 3159)&& (nSpellId != 3160)&& (nSpellId != 449)&& (nSpellId != 450)&& (nSpellId != 432)&& (nSpellId != 418)) {
		SetModuleOverrideSpellScriptFinished();
		SendMessageToPC(oCaster, "Your spell fizzles. You feel the arcane power of the Weave dissipate as if spent, but without apparent effect.");
		nRunningTab = nRunningTab + nSpellLevel;
		SetCampaignInt("DeanSphinx", "CrystalCharge", nRunningTab, oCaster);			
		nRunningTab = GetCampaignInt("DeanSphinx", "CrystalCharge", oCaster);
		//SendMessageToPC(oCaster, GetName(oCaster) + " charges to CrystalCon " + IntToString(nRunningTab));
		SendMessageToAllDMs(GetName(oCaster) + " crystal failed a casting of SpellID " + IntToString(nSpellId) + " a level " + IntToString(nSpellLevel) + " spell. CrysCon charges to " + IntToString(nRunningTab));
	    //SendMessageToAllDMs(GetName(oCaster) + " CrysCon charges to " + );
	   //SendMessageToPC(oCaster, "New nRunningTab is " + IntToString(nRunningTab));
	   }
	SetCampaignInt("DeanSphinx", "CrystalCast", 0, oCaster);			
		   
	if(nRunningTab >= 6) {
		int nSpell;
		SetModuleOverrideSpellScriptFinished();
		SendMessageToPC(oCaster, "The power of the Weave recoils within you, then lashes out in an unintended spell!");
		if(ACR_SkillCheck(SKILL_SPELLCRAFT, oCaster, nDC, TRUE)) {
			SendMessageToPC(oCaster, "Your facility with Spellcraft allows you to clamp down on your own casting and avoid loosing the unintended spell...this time.");
			}
		else {SendMessageToPC(oCaster, "You are unable to stop your own casting of the unintended spell!");
			
			int nSpellOne;
			int nSpellTwo;
			int nSpellThree;
			int nSpellFour;
			int nSpellFive;
			int nSpellSix;
			int nSpellSeven;
			int nSpellEight;	
			int nSpellNine;
			int nSpellTen;
			
			
		if (nSpellLevel == 1) {
					nSpellOne = SPELL_LESSER_ORB_OF_ACID;
					nSpellTwo = SPELL_LESSER_ORB_OF_COLD;
					nSpellThree = SPELL_LESSER_ORB_OF_ELECTRICITY;
					nSpellFour = SPELL_LESSER_ORB_OF_FIRE;
					nSpellFive = SPELL_LESSER_ORB_OF_SOUND;
					nSpellSix = SPELL_MAGE_ARMOR;
					nSpellSeven = SPELL_BLADES_OF_FIRE;
					nSpellEight = SPELL_GREASE;
					nSpellNine = SPELL_SUMMON_CREATURE_I;
					nSpellTen = SPELL_SUMMON_CREATURE_I;
				}
				else if(nSpellLevel==2) {
					nSpellOne = SPELL_SUMMON_CREATURE_II;
					nSpellTwo = SPELL_MELFS_ACID_ARROW;
					nSpellThree = SPELL_SUMMON_CREATURE_II;
					nSpellFour = SPELL_WEB;
					nSpellFive = SPELL_SUMMON_CREATURE_II;
					nSpellSix = SPELL_SUMMON_CREATURE_II;
					nSpellSeven = SPELL_MELFS_ACID_ARROW;
					nSpellEight = SPELL_SUMMON_CREATURE_II;
					nSpellNine = SPELL_WEB;
					nSpellTen = SPELL_SUMMON_CREATURE_II;
					}	
				else if(nSpellLevel==3) {
					nSpellOne = SPELL_FLAME_ARROW;
					nSpellTwo = SPELL_STINKING_CLOUD;
					nSpellThree = SPELL_IMPROVED_MAGE_ARMOR;
					nSpellFour = SPELL_MESTILS_ACID_BREATH;
					nSpellFive = SPELL_SUMMON_CREATURE_III;
					nSpellSix = SPELL_FLAME_ARROW;
					nSpellSeven = SPELL_STINKING_CLOUD;
					nSpellEight = SPELL_IMPROVED_MAGE_ARMOR;
					nSpellNine = SPELL_MESTILS_ACID_BREATH;
					nSpellTen = SPELL_SUMMON_CREATURE_III;
					}
				else {
					nSpellOne = SPELL_EVARDS_BLACK_TENTACLES;
					nSpellTwo = 3026;
					nSpellThree = SPELL_ORB_OF_SOUND;
					nSpellFour = SPELL_SUMMON_CREATURE_IV;
					nSpellFive = SPELL_ORB_OF_COLD;
					nSpellSix = SPELL_ORB_OF_ELECTRICITY;
					nSpellSeven = SPELL_ORB_OF_FIRE;
					nSpellEight = SPELL_ORB_OF_ACID;
					nSpellNine = SPELL_SUMMON_CREATURE_IV;
					nSpellTen = SPELL_SUMMON_CREATURE_IV;
					
				}
				
				switch(Random(10)) {
		        case 0:
		            nSpell = nSpellTen;
					break;
				case 1:
		            nSpell = nSpellOne;
					break;
				case 2:
		            nSpell = nSpellTwo;
					break;
				case 3:
		            nSpell = nSpellThree;
					break;
				case 4:
		            nSpell = nSpellFour;
					break;
				case 5:
		            nSpell = nSpellFive;
					break;
				case 6:
		            nSpell = nSpellSix;
					break;
				case 7:
		            nSpell = nSpellSeven;
					break;
				case 8:
		            nSpell = nSpellEight;
					break;
				case 9:
		            nSpell = nSpellNine;
					break;
				}
		
			if((nSpell == SPELL_MAGE_ARMOR) || (nSpell == SPELL_IMPROVED_MAGE_ARMOR) || (nSpell == 3026)) {
				AssignCommand(oCaster, ActionCastSpellAtObject(nSpell, oCaster, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
			}
			else if((nSpell == SPELL_GREASE)|| (nSpell == SPELL_WEB) || (nSpell == SPELL_STINKING_CLOUD)|| (nSpell == SPELL_EVARDS_BLACK_TENTACLES)|| (nSpell == SPELL_SUMMON_CREATURE_I)|| (nSpell == SPELL_SUMMON_CREATURE_II)|| (nSpell == SPELL_SUMMON_CREATURE_III)|| (nSpell == SPELL_SUMMON_CREATURE_IV)) {
				AssignCommand(oCaster, ActionCastSpellAtLocation(nSpell, GetLocation(oCaster), METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
			}
			else {
				int nRandomTarget = Random(3);
				if(nRandomTarget == 0) 
					{oTarget = oCaster;}
				if((nRandomTarget == 1) && (oTarget != OBJECT_INVALID)) 
					{oTarget = oTarget;}
				if((nRandomTarget == 1) && (oTarget == OBJECT_INVALID)) 
					{oTarget = oCaster;}
				if(nRandomTarget == 2) 
					{object oRandomCreature = GetFirstObjectInShape(SHAPE_SPHERE, 30.0, GetLocation(oCaster), TRUE, OBJECT_TYPE_CREATURE);
					 int nCount = 0;
					 while ((oRandomCreature != OBJECT_INVALID) && (nCount < 10)) {
					 	 //SendMessageToPC(oCaster, "oRandomCreature = " + IntToString(nCount) + " is " + GetName(oRandomCreature));
						 oRandomCreature = GetNextObjectInShape(SHAPE_SPHERE, 30.0, GetLocation(oCaster), TRUE, OBJECT_TYPE_CREATURE);
						 nCount = nCount +1;
						 }
					 oTarget = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, CREATURE_ALIVE_BOTH, oCaster, Random(nCount));
					}
				
				AssignCommand(oCaster, ActionCastSpellAtObject(nSpell, oTarget, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
				if((nSpell == SPELL_SUMMON_CREATURE_I)|| (nSpell == SPELL_SUMMON_CREATURE_II)|| (nSpell == SPELL_SUMMON_CREATURE_III)|| (nSpell == SPELL_SUMMON_CREATURE_IV)) {
				DelayCommand(5.0, AssignCommand(GetAssociate(ASSOCIATE_TYPE_SUMMONED, oCaster, 1), ActionSpeakString("*Shakes its head in confusion*", TALKVOLUME_TALK)));
				DelayCommand(5.0, ChangeToStandardFaction(GetAssociate(ASSOCIATE_TYPE_SUMMONED, oCaster, 1), STANDARD_FACTION_HOSTILE));
				}
			}
			
			SetCampaignInt("DeanSphinx", "CrystalCast", 1, oCaster);			
			SendMessageToAllDMs(GetName(oCaster) + " discharges a crystal based conjuration spell with a wild casting of " + IntToString(nSpell) + " on " + GetName(oTarget));
			}
			
			nRunningTab = 0;
			SetCampaignInt("DeanSphinx", "CrystalCharge", nRunningTab, oCaster);			
			nRunningTab = GetCampaignInt("DeanSphinx", "CrystalCharge", oCaster);
			SendMessageToAllDMs(GetName(oCaster) + " CrysCon is at " + IntToString(nRunningTab));
			
		}
	
	} 
}

	//Standard Evocation	 
	 if((GetTag(GetArea(oCaster)) == "6d_int_silvy_ladycol_class_lvl") && (nSpellId == SPELL_FLARE) && (GetTag(oTarget) == "slv_evo200_poisoncircle"))
	 	   {object oMyPoisonCircle = GetObjectByTag("slv_evo200_poisoncircle");
			object oWindowWP = GetLocalObject(oMyPoisonCircle, "oWindowWP");
		    if(oWindowWP == OBJECT_INVALID)
			   {oWindowWP = GetWaypointByTag("Evo_All_Quests_Window_WP");
				SetLocalObject(oMyPoisonCircle, "oWindowWP", oWindowWP);
				}
		    object oPictureWP = GetLocalObject(oMyPoisonCircle, "oPictureWP");
		    if(oPictureWP == OBJECT_INVALID)
			   {oPictureWP = GetWaypointByTag("Evo_All_Quests_Picture_WP");
				SetLocalObject(oMyPoisonCircle, "oPictureWP", oPictureWP);
				}
		    object oMyIncinder = GetLocalObject(oMyPoisonCircle, "oMyIncinder");
		    if (oMyIncinder == OBJECT_INVALID)
				{oMyIncinder = GetObjectByTag("003_cr_slv_incinder");
				 SetLocalObject(oMyPoisonCircle, "oMyIncinder", oMyIncinder);
				}
		   object oMirror1 = GetLocalObject(oMyPoisonCircle, "oMirror1");
		   if(oMirror1 == OBJECT_INVALID)
		   		{oMirror1 = GetObjectByTag("slv_evo200_mirror1");
				 SetLocalObject(oMyPoisonCircle, "oMirror1", oMirror1);
				 }
		   object oMirror2 = GetLocalObject(oMyPoisonCircle, "oMirror2");
		   if(oMirror2 == OBJECT_INVALID)
		   		{oMirror2 = GetWaypointByTag("slv_evo200_mirror2");
				 SetLocalObject(oMyPoisonCircle, "oMirror2", oMirror2);
				 }
		   string sGender = "slv_evo200_man";
		   string sGenderPLC = "slv_evo200_plc_man";
		   if(GetGender(oStudent) != GENDER_MALE)
				{sGender = "slv_evo200_woman";
				 sGenderPLC = "slv_evo200_plc_woman";
				 }
		  SendMessageToPC(oStudent, "The metal inlaid symbol of protection beneath your feet reflects with a brilliant flash.");
          DelayCommand(2.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_FNF_ELECTRIC_EXPLOSION), oStudent, 3.0));
          DelayCommand(2.5, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_FNF_ELECTRIC_EXPLOSION), oMirror1, 3.0));
          DelayCommand(2.5, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_FNF_ELECTRIC_EXPLOSION), oMirror2, 3.0));
          DelayCommand(2.8, AssignCommand(oMyIncinder, SpeakString("*Screeches in happiness*  Lovesss thissssss part!", TALKVOLUME_TALK)));
          DelayCommand(2.9, AssignCommand(oMirror1, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectBeam(VFX_BEAM_LIGHTNING, OBJECT_SELF, BODY_NODE_CHEST, FALSE), oWindowWP, 5.0)));
          DelayCommand(2.9, AssignCommand(oMirror2, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectBeam(VFX_BEAM_COLD, OBJECT_SELF, BODY_NODE_CHEST, FALSE), oWindowWP, 5.0)));
          DelayCommand(3.0, SendMessageToPC(oStudent, "The light is taken up by the mirrors and amplified, and magnified beams leap from the mirrors to the oily parchment before you."));
          DelayCommand(5.0, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_FNF_DISPEL_GREATER), GetLocation(oWindowWP), 5.0));
          DelayCommand(6.0, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD), GetLocation(oWindowWP), 5.0));
          object oPLC = CreateObject(OBJECT_TYPE_PLACEABLE, sGenderPLC, GetLocation(oPictureWP), FALSE);
	            object oImage = CreateObject(OBJECT_TYPE_ITEM, sGender, GetLocation(oMyPoisonCircle), FALSE);
	            SetDescription(oImage, "An image of " + GetName(oStudent) + " against a background of flames.");
				DelayCommand(2.0, AssignCommand(oMyIncinder, ActionCastSpellAtObject(SPELL_DISPEL_MAGIC, oMyPoisonCircle, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE )));
	            DelayCommand(9.0, SendMessageToPC(oStudent, "When the dazzle clears from your sight and the smoke from the room, you are left looking at an image in black and white where the Kossuthian window had been....of your own face, startled by the flash."));
	            DelayCommand(10.0, SetCampaignString("SLV_UNI","Standard Evocation", "Standard Evocation", oStudent));
	            if(ACR_RetrieveQuestState("slv_evo200", oStudent) == 1)
					{DelayCommand(10.1, ACR_AddPersistentJournalQuestEntry("slv_evo200", 2, oStudent, 0, 0, 0, 0));
					}
			    DelayCommand(10.5, SetLocalInt(oStudent, "slv_evo200_", 1)); 
	            DelayCommand(11.0, AssignCommand(oMyIncinder, SpeakString("Sssssurprise. Good expossssure. Take pieccccce of sssshadow to Massssster.  *Points to center of protection circle which holds  a smaller image like a lesser copy of the larger on the window.*", TALKVOLUME_TALK)));
	            DestroyObject(oMyIncinder, 16.0);
	            DestroyObject(oPLC, 30.0);
	           if(GetDistanceBetween(oStudent, oMyPoisonCircle) < 15.0)
	                { DelayCommand(30.0, SendMessageToPC(oStudent, "The large image fades.  Only wet parchment speckled with glass remains on the wall."));
	                }
	           SetUseableFlag(oMyPoisonCircle, FALSE);
          		}      
	     		
}
			
						

			
				