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

string GetCompassDirectionOfBearing(float fDegrees);
string GetCompassDirectionOfAngle(float fAngle);

void ActionCreateWynCreature(string sCreature, location lLocCreature)
{
    CreateObject(OBJECT_TYPE_CREATURE, sCreature, lLocCreature);
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
	
	//Detect Magic
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
		
		int nConcentration = ACR_SkillCheck(SKILL_CONCENTRATION, oCaster, 0, TRUE, TRUE, 0);
		SendMessageToAllDMs("nConcentration = " + IntToString(nConcentration));
		if(nConcentration - GetSkillRank(SKILL_CONCENTRATION, oCaster, FALSE)<= 1) {
			nConcentration = 1;
			DelayCommand(3.0, SendMessageToAllDMs(GetName(oCaster) + " cannot concentrate at all and learns nothing."));
			DelayCommand(3.0, SendMessageToPC(oCaster, "You cannot concentrate at all and learn nothing."));
			return;		
			}
		object oDetected = GetFirstObjectInShape( SHAPE_SPELLCONE, 10.0, GetSpellTargetLocation(), TRUE, OBJECT_TYPE_ALL );
		string sSchool = "";
		string sSchool2 = "";
		string sSchool3 = "";
		string sACRSubSchool = "";
		string sACRSubSchool2 = "";
		string sACRSubSchool3 = "";
		int nAuraCount = 0;
		int nAuraPowerHigh = 0;
		int nAuraPower = 0;
		int nAuraPower2 = 0;
		int nAuraPower3 = 0;
		string sAuraPowerHigh = "";
		string sAuraPower = "";
		string sAuraStrength = "";
		string sAuraStrength2 = "";
		string sAuraStrength3 = "";
		int nItemCounted = 0;
		SetLocalInt(oCaster, "nSummary", 0); 
		int nCreatureCount = 0;
																
		while (GetIsObjectValid(oDetected)) {
		//SendMessageToAllDMs("Top oDetected: Object Type = " + IntToString(GetObjectType(oDetected)) + ", Name = " + GetName(oDetected) + ", Tag = " + GetTag(oDetected) + ", ResRef = " + GetResRef(oDetected));
		if((oDetected != oCaster) && ((GetObjectType(oDetected) == OBJECT_TYPE_CREATURE) || (GetObjectType(oDetected) == OBJECT_TYPE_PLACEABLE)  || (GetObjectType(oDetected) == OBJECT_TYPE_ITEM) || (GetObjectType(oDetected) == OBJECT_TYPE_TRIGGER)|| (GetObjectType(oDetected) == OBJECT_TYPE_WAYPOINT) || (GetObjectType(oDetected) == OBJECT_TYPE_PLACED_EFFECT)  || (GetObjectType(oDetected) == OBJECT_TYPE_DOOR))){
			
			if(GetObjectType(oDetected) == OBJECT_TYPE_PLACED_EFFECT) {
				//SendMessageToAllDMs("Placed Effect oDetected: Object Type = " + IntToString(GetObjectType(oDetected)) + ", Name = " + GetName(oDetected) + ", Tag = " + GetTag(oDetected) + ", ResRef = " + GetResRef(oDetected));
				string sName = GetName(oDetected);
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
				if(FindSubString(GetTag(oDetected), "_ioun_stone_") != -1){
						 nAuraCount++;
						 nAuraPower = 5;
						 sAuraStrength = "moderate";
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
						 if(FindSubString(GetTag(oDetected), "_conj") != -1) {sSchool = " of <color=tan>Conjuration</color>";}
						 if(FindSubString(GetTag(oDetected), "_divi") != -1) {sSchool = " of <color=green>Divination</color>";}
						 if(FindSubString(GetTag(oDetected), "_ench") != -1) {sSchool = " of <color=magenta>Enchantment</color>";}
						 if(FindSubString(GetTag(oDetected), "_evoc") != -1) {sSchool = " of <color=red>Evocation</color>";}
						 if(FindSubString(GetTag(oDetected), "_illus") != -1) {sSchool = " of <color=purple>Illusion</color>";}
						 if(FindSubString(GetTag(oDetected), "_necro") != -1) {sSchool = " of <color=white>Necromancy</color>";}
						 if(FindSubString(GetTag(oDetected), "_trans") != -1) {sSchool = " of <color=orange>Transmutation</color>";}
						 if(GetIsSkillSuccessful(oCaster, SKILL_SPELLCRAFT, 15 + nAuraPower, FALSE) == FALSE) {sSchool = "";}
						 }	 
				if((FindSubString(GetTag(oDetected), "_gem_energy_") != -1)||(FindSubString(GetTag(oDetected), "_light_") != -1)||(FindSubString(GetTag(oDetected), "_psychic_") != -1)|| (FindSubString(GetTag(oDetected), "_sparkle") != -1)){
						 nAuraCount++;
						 nAuraPower = 1;
						 sAuraStrength = "faint";
						 sName = "A shaft of light";
						 if(GetIsSkillSuccessful(oCaster, SKILL_SPELLCRAFT, 15 + nAuraPower, FALSE)) {sSchool = " of <color=red>Evocation</color>";}
					}	 
					
				nAuraPowerHigh = GetLocalInt(oCaster, "nAuraPowerHigh");
				if(nAuraPower > nAuraPowerHigh) {
					SetLocalInt(oCaster, "nAuraPowerHigh", nAuraPower);
					SetLocalString(oCaster, "sAuraPowerHigh", sAuraStrength);
					}
				sAuraPowerHigh = GetLocalString(oCaster, "sAuraPowerHigh");
						
				if((nAuraCount == 1)  && (nAuraPower > 0)){
					DelayCommand(6.0, SendMessageToAllDMs(GetTag(oDetected) + " " + GetName(oCaster) + " concentrates for one round and learns that there is magic within range."));
					DelayCommand(6.0, SendMessageToPC(oCaster, "You concentrate for one round and learn that there is magic within range."));
					}
						
				float fDistance = GetDistanceBetween(oDetected, oCaster);
				int nDistance = FloatToInt(fDistance);
				string sDistance = IntToString(nDistance);
				float fAngle = GetAngleBetweenObjects(oDetected, oCaster);
				string sAngle = GetCompassDirectionOfAngle(fAngle);
							
				if((nConcentration > 13) && (nAuraPower > 0)) {
					DelayCommand(21.0, SendMessageToAllDMs( sName + " --" + GetTag(oDetected) +  "-- " + sDistance + "m to the " + sAngle + " has a " + sAuraStrength + " aura" + sSchool));
					DelayCommand(21.0, SendMessageToPC(oCaster, sName + " " + sDistance + "m to the " + sAngle + " has a " + sAuraStrength + " aura" + sSchool));
					}
			}		
			sSchool = "";
			sSchool2 = "";
			nAuraPower = 0;
			nAuraPower2 = 0;
				
			
			if(GetObjectType(oDetected) == OBJECT_TYPE_DOOR) {
				if(GetLocalInt(oDetected, "ACR_SPELLSCHOOL") > 0) {
					nAuraCount++;
					int nACRSpellSchool = GetLocalInt(oDetected, "ACR_SPELLSCHOOL");
					int nAuraPower = GetLocalInt(oDetected, "ACR_SPELLPOWER");
					int nACRSpellSchool2 = GetLocalInt(oDetected, "ACR_SPELLSCHOOL2");
					int nAuraPower2 = GetLocalInt(oDetected, "ACR_SPELLPOWER2");
					if(nAuraPower > 0) {sAuraStrength = "faint";}
					if(nAuraPower > 3) {sAuraStrength = "moderate";}
					if(nAuraPower > 6) {sAuraStrength = "strong";}
					if(nAuraPower > 9) {sAuraStrength = "overwhelming";}
					if(nAuraPower2 > 0) {sAuraStrength2 = "faint";}
					if(nAuraPower2 > 3) {sAuraStrength2 = "moderate";}
					if(nAuraPower2 > 6) {sAuraStrength2 = "strong";}
					if(nAuraPower2 > 9) {sAuraStrength2 = "overwhelming";}
					if(nACRSpellSchool == 1) {sSchool = " of <color=lightblue>Abjuration </color>";}
					if(nACRSpellSchool == 2) {sSchool = " of <color=tan>Conjuration </color>";}
					if(nACRSpellSchool == 3) {sSchool = " of <color=green>Divination </color>";}
					if(nACRSpellSchool == 4) {sSchool = " of <color=magenta>Enchantment </color>";}
					if(nACRSpellSchool == 5) {sSchool = " of <color=red>Evocation </color>";}
					if(nACRSpellSchool == 6) {sSchool = " of <color=purple>Illusion </color>";}
					if(nACRSpellSchool == 7) {sSchool = " of <color=white>Necromancy </color>";}
					if(nACRSpellSchool == 8) {sSchool = " of <color=orange>Transmutation </color>";}
					if(nACRSpellSchool == 9) {sSchool = " of <color=#FFFF00>Universal arcanity</color>";}
					//if(nACRSpellSchool == 9) {sSchool = " of <color=white>Holiness </color>";}
					if(nACRSpellSchool2 == 1) {sSchool2 = " of <color=lightblue>Abjuration </color>";}
					if(nACRSpellSchool2 == 2) {sSchool2 = " of <color=tan>Conjuration </color>";}
					if(nACRSpellSchool2 == 3) {sSchool2 = " of <color=green>Divination </color>";}
					if(nACRSpellSchool2 == 4) {sSchool2 = " of <color=magenta>Enchantment </color>";}
					if(nACRSpellSchool2 == 5) {sSchool2 = " of <color=red>Evocation </color>";}
					if(nACRSpellSchool2 == 6) {sSchool2 = " of <color=purple>Illusion </color>";}
					if(nACRSpellSchool2 == 7) {sSchool2 = " of <color=white>Necromancy </color>";}
					if(nACRSpellSchool2 == 8) {sSchool2 = " of <color=orange>Transmutation </color>";}
					if(nACRSpellSchool2 == 9) {sSchool2 = " of <color=#FFFF00>Universal arcanity</color>";}
					//if(nACRSpellSchool2 == 9) {sSchool2 = " of <color=white>Holiness </color>";}
					
					if(sSchool2 != "") {sSchool2 = " and a " + sAuraStrength2 + " aura " + sSchool2;}
					SetLocalInt(oItem, "ACR_SPELLSCHOOL", -1);
					
					
					if(GetIsSkillSuccessful(oCaster, SKILL_SPELLCRAFT, 15 + nAuraPower, FALSE) == FALSE) {sSchool = "";}
						
						string sName = GetName(oDetected);
						float fDistance = GetDistanceBetween(oDetected, oCaster);
						int nDistance = FloatToInt(fDistance);
						string sDistance = IntToString(nDistance);
						float fAngle = GetAngleBetweenObjects(oDetected, oCaster);
						string sAngle = GetCompassDirectionOfAngle(fAngle);
							
						if(nConcentration > 13) {
							DelayCommand(21.0, SendMessageToAllDMs(GetName(oDetected) + " --" +sName + "-- " + sDistance + "m to the " + sAngle + " has a " + sAuraStrength + " aura" + sSchool + sSchool2));
							DelayCommand(21.0, SendMessageToPC(oCaster, sName + " " + sDistance + "m to the " + sAngle + " has a " + sAuraStrength + " aura" + sSchool + sSchool2));
							}
						
				nAuraPowerHigh = GetLocalInt(oCaster, "nAuraPowerHigh");
				if(nAuraPower > nAuraPowerHigh) {
					SetLocalInt(oCaster, "nAuraPowerHigh", nAuraPower);
					SetLocalString(oCaster, "sAuraPowerHigh", sAuraStrength);
					}
				sAuraPowerHigh = GetLocalString(oCaster, "sAuraPowerHigh");
						
				if((nAuraCount == 1)  && (nAuraPower > 0)){
					DelayCommand(6.0, SendMessageToAllDMs(GetTag(oDetected) + " " + GetName(oCaster) + " concentrates for one round and learns that there is magic within range."));
					DelayCommand(6.0, SendMessageToPC(oCaster, "You concentrate for one round and learn that there is magic within range."));
					}
				}
			}
			sSchool = "";
			sSchool2 = "";
			nAuraPower = 0;
			nAuraPower2 = 0;
					
			
			if(GetObjectType(oDetected) == OBJECT_TYPE_PLACEABLE) {
				
				if(FindSubString(GetTag(oDetected), "alfa_portal")!= -1) {
				    nAuraCount++;
					nAuraPower = 5;
					if(GetIsSkillSuccessful(oCaster, SKILL_SPELLCRAFT, 15 + nAuraPower, FALSE)) {sSchool = " of <color=tan>Conjuration</color>";}
					sAuraStrength = "moderate";
					string sName = GetName(oDetected);
					if(GetUseableFlag(oDetected) != 1) {sName = "Something";}
					nAuraPowerHigh = GetLocalInt(oCaster, "nAuraPowerHigh");
					if(nAuraPower > nAuraPowerHigh) {
						SetLocalInt(oCaster, "nAuraPowerHigh", nAuraPower);
						SetLocalString(oCaster, "sAuraPowerHigh", sAuraStrength);
						}
					sAuraPowerHigh = GetLocalString(oCaster, "sAuraPowerHigh");
					float fDistance = GetDistanceBetween(oDetected, oCaster);
					int nDistance = FloatToInt(fDistance);
					string sDistance = IntToString(nDistance);
					float fAngle = GetAngleBetweenObjects(oDetected, oCaster);
					string sAngle = GetCompassDirectionOfAngle(fAngle);
					if(nAuraCount == 1){
						DelayCommand(6.0, SendMessageToAllDMs(GetTag(oDetected) + " " + GetName(oCaster) + " concentrates for one round and learns that there is magic within range."));
						DelayCommand(6.0, SendMessageToPC(oCaster, "You concentrate for one round and learn that there is magic within range."));
						}
					if(nConcentration > 13) {
						DelayCommand(21.0, SendMessageToAllDMs(GetName(oDetected) + " --" +sName + "-- " + sDistance + "m to the " + sAngle + " has a " + sAuraStrength + " aura" + sSchool));
						DelayCommand(21.0, SendMessageToPC(oCaster, sName + " " + sDistance + "m to the " + sAngle + " has a " + sAuraStrength + " aura" + sSchool));
						}
					}
				sSchool = "";
				sSchool2 = "";
				nAuraPower = 0;
				nAuraPower2 = 0;
				
				if((FindSubString(GetTag(oDetected), "_glyph_ward") != -1) || (FindSubString(GetTag(oDetected), "_symbol_") != -1)) {
					if(FindSubString(GetTag(oDetected), "_glyph_") != -1) {sSchool = "of Abjuration"; nAuraPower = 3;}
					if((FindSubString(GetTag(oDetected), "_symbol_fear") != -1) || (FindSubString(GetTag(oDetected), "_symbol_pers") != -1) || (FindSubString(GetTag(oDetected), "_symbol_sleep") != -1) || (FindSubString(GetTag(oDetected), "_symbol_stun") != -1)) {sSchool = " of <color=magenta>Enchantment</color>";}
					if((FindSubString(GetTag(oDetected), "_symbol_weakness") != -1) || (FindSubString(GetTag(oDetected), "_symbol_pain") != -1) || (FindSubString(GetTag(oDetected), "_symbol_death") != -1)) {sSchool = " of <color=white>Necromancy</color>";}
					if((FindSubString(GetTag(oDetected), "_symbol_pain") != -1) || (FindSubString(GetTag(oDetected), "_symbol_sleep") != -1)) {nAuraPower = 5;}
					if((FindSubString(GetTag(oDetected), "_symbol_pers") != -1) || (FindSubString(GetTag(oDetected), "_symbol_fear") != -1)) {nAuraPower = 6;}
					if((FindSubString(GetTag(oDetected), "_symbol_stun") != -1) || (FindSubString(GetTag(oDetected), "_symbol_weakness") != -1)) {nAuraPower = 7;}
					if((FindSubString(GetTag(oDetected), "_symbol_insanity") != -1) || (FindSubString(GetTag(oDetected), "_symbol_death") != -1)) {nAuraPower = 8;}
									
					nAuraCount++;
					nAuraPowerHigh = GetLocalInt(oCaster, "nAuraPowerHigh");
					if(nAuraPower > 0) {sAuraStrength = "faint";}
					if(nAuraPower > 3) {sAuraStrength = "moderate";}
					if(nAuraPower > 6) {sAuraStrength = "strong";}
					if(nAuraPower > 9) {sAuraStrength = "overwhelming";}
					
					if(!GetIsSkillSuccessful(oCaster, SKILL_SPELLCRAFT, 15 + nAuraPower, FALSE)){sSchool = "";}
					nAuraPowerHigh = GetLocalInt(oCaster, "nAuraPowerHigh");
					if(nAuraPower > nAuraPowerHigh) {
						SetLocalInt(oCaster, "nAuraPowerHigh", nAuraPower);
						SetLocalString(oCaster, "sAuraPowerHigh", sAuraStrength);
						}
					sAuraPowerHigh = GetLocalString(oCaster, "sAuraPowerHigh");
					string sSymbolName = GetName(oDetected);			
					float fDistance = GetDistanceBetween(oDetected, oCaster);
					int nDistance = FloatToInt(fDistance);
					string sDistance = IntToString(nDistance);
					float fAngle = GetAngleBetweenObjects(oDetected, oCaster);
					string sAngle = GetCompassDirectionOfAngle(fAngle);
						
					if(nAuraCount == 1){
						DelayCommand(6.0, SendMessageToAllDMs(GetTag(oDetected) + " " + GetName(oCaster) + " concentrates for one round and learns that there is magic within range."));
						DelayCommand(6.0, SendMessageToPC(oCaster, "You concentrate for one round and learn that there is magic within range."));
						}
					if(nConcentration > 13) {
						DelayCommand(21.0, SendMessageToAllDMs("Glyph or Symbol " + sSymbolName + " --" + GetName(oDetected) + "-- centered on a spot " + sDistance + "m " + sAngle + " of " + GetName(oCaster) + " gives off a " + sAuraStrength + " aura " + sSchool));
						DelayCommand(21.0, SendMessageToPC(oCaster, sSymbolName + " centered on a spot " + sDistance + "m " + sAngle + " of " + GetName(oCaster) + " gives off a " + sAuraStrength + " aura " + sSchool));
						}
					}
				sSchool = "";
				sSchool2 = "";
				nAuraPower = 0;
				nAuraPower2 = 0;
						
				if((FindSubString(GetName(oDetected), "Forcefield") != -1) || (FindSubString(GetTag(oDetected), "forcefield") != -1)){
				 	nAuraCount++;
					nAuraPower = 5;
					sAuraStrength = "moderate";
					if(GetIsSkillSuccessful(oCaster, SKILL_SPELLCRAFT, 15 + nAuraPower, FALSE)) {sSchool = " of <color=red>Evocation</color>";}
					nAuraPowerHigh = GetLocalInt(oCaster, "nAuraPowerHigh");
					if(nAuraPower > nAuraPowerHigh) {
						SetLocalInt(oCaster, "nAuraPowerHigh", nAuraPower);
						SetLocalString(oCaster, "sAuraPowerHigh", sAuraStrength);
						}
					sAuraPowerHigh = GetLocalString(oCaster, "sAuraPowerHigh");
					string sName = GetName(oDetected);
					float fDistance = GetDistanceBetween(oDetected, oCaster);
					int nDistance = FloatToInt(fDistance);
					string sDistance = IntToString(nDistance);
					float fAngle = GetAngleBetweenObjects(oDetected, oCaster);
					string sAngle = GetCompassDirectionOfAngle(fAngle);
							
					if(nAuraCount == 1){
						DelayCommand(6.0, SendMessageToAllDMs(GetTag(oDetected) + " " + GetName(oCaster) + " concentrates for one round and learns that there is magic within range."));
						DelayCommand(6.0, SendMessageToPC(oCaster, "You concentrate for one round and learn that there is magic within range."));
						}
					if(nConcentration > 13) {
						DelayCommand(21.0, SendMessageToAllDMs(GetName(oDetected) + " --" +sName + "-- " + sDistance + "m to the " + sAngle + " has a " + sAuraStrength + " aura" + sSchool));
						DelayCommand(21.0, SendMessageToPC(oCaster, sName + " " + sDistance + "m to the " + sAngle + " has a " + sAuraStrength + " aura" + sSchool));
						}
					}
				sSchool = "";
				sSchool2 = "";
				nAuraPower = 0;
				nAuraPower2 = 0;
				
				if(GetLocalInt(oDetected, "ACR_SPELLSCHOOL") > 0) {
					nAuraCount++;
					int nACRSpellSchool = GetLocalInt(oDetected, "ACR_SPELLSCHOOL");
					string sACRSubSchool = GetLocalString(oDetected, "ACR_SUBSCHOOL");
					int nAuraPower = GetLocalInt(oDetected, "ACR_SPELLPOWER");
					int nACRSpellSchool2 = GetLocalInt(oDetected, "ACR_SPELLSCHOOL2");
					string sACRSubSchool2 = GetLocalString(oDetected, "ACR_SUBSCHOOL2");
					int nAuraPower2 = GetLocalInt(oDetected, "ACR_SPELLPOWER2");
					int nACRSpellSchool3 = GetLocalInt(oDetected, "ACR_SPELLSCHOOL3");
					SendMessageToAllDMs("nACRSpellSchool3 = " + IntToString(nACRSpellSchool3));
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
					//if(nACRSpellSchool == 9) {sSchool = " of <color=white>Holiness </color>";}
					if(nACRSpellSchool2 == 1) {sSchool2 = " of <color=lightblue>Abjuration </color>";}
					if(nACRSpellSchool2 == 2) {sSchool2 = " of <color=tan>Conjuration </color>";}
					if(nACRSpellSchool2 == 3) {sSchool2 = " of <color=green>Divination </color>";}
					if(nACRSpellSchool2 == 4) {sSchool2 = " of <color=magenta>Enchantment </color>";}
					if(nACRSpellSchool2 == 5) {sSchool2 = " of <color=red>Evocation </color>";}
					if(nACRSpellSchool2 == 6) {sSchool2 = " of <color=purple>Illusion </color>";}
					if(nACRSpellSchool2 == 7) {sSchool2 = " of <color=white>Necromancy </color>";}
					if(nACRSpellSchool2 == 8) {sSchool2 = " of <color=orange>Transmutation </color>";}
					if(nACRSpellSchool2 == 9) {sSchool2 = " of <color=white>Holiness </color>";}
					//if(nACRSpellSchool2 == 9) {sSchool2 = " of <color=#FFFF00>Universal arcanity</color>";}
					if(nACRSpellSchool3 == 1) {sSchool3 = " of <color=lightblue>Abjuration </color>";}
					if(nACRSpellSchool3 == 2) {sSchool3 = " of <color=tan>Conjuration </color>";}
					if(nACRSpellSchool3 == 3) {sSchool3 = " of <color=green>Divination </color>";}
					if(nACRSpellSchool3 == 4) {sSchool3 = " of <color=magenta>Enchantment </color>";}
					if(nACRSpellSchool3 == 5) {sSchool3 = " of <color=red>Evocation </color>";}
					if(nACRSpellSchool3 == 6) {sSchool3 = " of <color=purple>Illusion </color>";}
					if(nACRSpellSchool3 == 7) {sSchool3 = " of <color=white>Necromancy </color>";}
					if(nACRSpellSchool3 == 8) {sSchool3 = " of <color=orange>Transmutation </color>";}
					if(nACRSpellSchool3 == 9) {sSchool3 = " of <color=#FFFF00>Universal arcanity</color>";}
					//if(nACRSpellSchool3 == 9) {sSchool3 = " of <color=white>Holiness </color>";}
					SendMessageToAllDMs("2. nACRSpellSchool3 = " + IntToString(nACRSpellSchool3) + ": " + sAuraStrength3 + " - " + sSchool3);
					
					if(sACRSubSchool != "") {sSchool = sSchool + "(" + sACRSubSchool + ")";}
					if(sSchool2 != "") {sSchool2 = " and " + sAuraStrength2 + " aura " + sSchool2;}
					if(sACRSubSchool2 != "") {sSchool2 = sSchool2 + "(" + sACRSubSchool2 + ")";}
					if(sSchool3 != "") {sSchool3 = "inside that outer layer. Both surround " +sAuraStrength3 + " amount " + sSchool3;}
					if(sACRSubSchool3 != "") {sSchool3 = sSchool3 + "(" + sACRSubSchool3 + ")";}
					SetLocalInt(oItem, "ACR_SPELLSCHOOL", -1);
					
					if(GetIsSkillSuccessful(oCaster, SKILL_SPELLCRAFT, 15 + nAuraPower, FALSE) == FALSE) {sSchool = "";}
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
					sAuraPowerHigh = GetLocalString(oCaster, "sAuraPowerHigh");
					
					string sName = GetName(oDetected);
					float fDistance = GetDistanceBetween(oDetected, oCaster);
					int nDistance = FloatToInt(fDistance);
					string sDistance = IntToString(nDistance);
					float fAngle = GetAngleBetweenObjects(oDetected, oCaster);
					string sAngle = GetCompassDirectionOfAngle(fAngle);
							
					if(nAuraCount == 1){
						DelayCommand(6.0, SendMessageToAllDMs(GetTag(oDetected) + " " + GetName(oCaster) + " concentrates for one round and learns that there is magic within range."));
						DelayCommand(6.0, SendMessageToPC(oCaster, "You concentrate for one round and learn that there is magic within range."));
						}
					if(nConcentration > 13) {
							DelayCommand(21.0, SendMessageToAllDMs(GetName(oDetected) + " --" +sName + "-- " + sDistance + "m to the " + sAngle + " has " + sAuraStrength + " aura" + sSchool + sSchool2 + sSchool3));
							DelayCommand(21.0, SendMessageToPC(oCaster, sName + " " + sDistance + "m to the " + sAngle + " has " + sAuraStrength + " aura" + sSchool + sSchool2 + sSchool3));
							}
						}
				}
					
				sSchool = "";
				sSchool2 = "";
				sSchool3 = ""; 
				sACRSubSchool = "";
				sACRSubSchool2 = "";
				sACRSubSchool3 = "";
				nAuraPower = 0;
				nAuraPower2 = 0;
					
			if(GetObjectType(oDetected) == OBJECT_TYPE_TRIGGER) {
				//SendMessageToAllDMs("Trigger oDetected: " + ", Name = " + GetName(oDetected) + ", Tag = " + GetTag(oDetected) + ", ResRef = " + GetResRef(oDetected));
				if(FindSubString(GetTag(oDetected), "_portal_") != -1){
				    //SendMessageToAllDMs("Portal oDetected: " + ", Name = " + GetName(oDetected) + ", Tag = " + GetTag(oDetected) + ", ResRef = " + GetResRef(oDetected));
					nAuraCount++;
					nAuraPower = 5;
					if(GetIsSkillSuccessful(oCaster, SKILL_SPELLCRAFT, 15 + nAuraPower, FALSE)) {sSchool = " of <color=tan>Conjuration</color>";}
					sAuraStrength = "moderate";
					
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
					sAuraPowerHigh = GetLocalString(oCaster, "sAuraPowerHigh");
						
					if(nAuraCount == 1){
						DelayCommand(6.0, SendMessageToAllDMs(GetTag(oDetected) + " " + GetName(oCaster) + " concentrates for one round and learns that there is magic within range."));
						DelayCommand(6.0, SendMessageToPC(oCaster, "You concentrate for one round and learn that there is magic within range."));
						}
						
					string sName = "Something";
					float fDistance = GetDistanceBetween(oDetected, oCaster);
					int nDistance = FloatToInt(fDistance);
					string sDistance = IntToString(nDistance);
					float fAngle = GetAngleBetweenObjects(oDetected, oCaster);
					string sAngle = GetCompassDirectionOfAngle(fAngle);
					
					if(nConcentration > 13) {
						DelayCommand(21.0, SendMessageToAllDMs(GetName(oDetected) + " --" +sName + "-- " + sDistance + "m to the " + sAngle + " has a " + sAuraStrength + " aura" + sSchool));
						DelayCommand(21.0, SendMessageToPC(oCaster, sName + " " + sDistance + "m to the " + sAngle + " has a " + sAuraStrength + " aura" + sSchool));
						}
					}
				
				if(((FindSubString(GetTag(oDetected), "_glyph_warding") != -1) || (FindSubString(GetTag(oDetected), "_symbol_") != -1)) && (FindSubString(GetTag(oDetected), "_det") == -1)) {
					if(FindSubString(GetTag(oDetected), "_glyph_") != -1) {sSchool = "of Abjuration"; nAuraPower = 3;}
					if((FindSubString(GetTag(oDetected), "_symbol_fear") != -1) || (FindSubString(GetTag(oDetected), "_symbol_pers") != -1) || (FindSubString(GetTag(oDetected), "_symbol_sleep") != -1) || (FindSubString(GetTag(oDetected), "_symbol_stun") != -1)) {sSchool = " of <color=magenta>Enchantment</color>";}
					if((FindSubString(GetTag(oDetected), "_symbol_weakness") != -1) || (FindSubString(GetTag(oDetected), "_symbol_pain") != -1) || (FindSubString(GetTag(oDetected), "_symbol_death") != -1)) {sSchool = " of <color=white>Necromancy</color>";}
					if((FindSubString(GetTag(oDetected), "_symbol_pain") != -1) || (FindSubString(GetTag(oDetected), "_symbol_sleep") != -1)) {nAuraPower = 5;}
					if((FindSubString(GetTag(oDetected), "_symbol_pers") != -1) || (FindSubString(GetTag(oDetected), "_symbol_fear") != -1)) {nAuraPower = 6;}
					if((FindSubString(GetTag(oDetected), "_symbol_stun") != -1) || (FindSubString(GetTag(oDetected), "_symbol_weakness") != -1)) {nAuraPower = 7;}
					if((FindSubString(GetTag(oDetected), "_symbol_insanity") != -1) || (FindSubString(GetTag(oDetected), "_symbol_death") != -1)) {nAuraPower = 8;}
									
					nAuraCount++;
					nAuraPowerHigh = GetLocalInt(oCaster, "nAuraPowerHigh");
					if(nAuraPower > 0) {sAuraStrength = "faint";}
					if(nAuraPower > 3) {sAuraStrength = "moderate";}
					if(nAuraPower > 6) {sAuraStrength = "strong";}
					if(nAuraPower > 9) {sAuraStrength = "overwhelming";}
					
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
					sAuraPowerHigh = GetLocalString(oCaster, "sAuraPowerHigh");
						
					if(nAuraCount == 1){
						DelayCommand(6.0, SendMessageToAllDMs(GetTag(oDetected) + " " + GetName(oCaster) + " concentrates for one round and learns that there is magic within range."));
						DelayCommand(6.0, SendMessageToPC(oCaster, "You concentrate for one round and learn that there is magic within range."));
						}
					
					if(!GetIsSkillSuccessful(oCaster, SKILL_SPELLCRAFT, 15 + nAuraPower, FALSE)){sSchool = "";}
					string sSymbolName = GetName(oDetected);			
					if((GetObjectType(oDetected) == OBJECT_TYPE_TRIGGER) && (GetLocalInt(oDetected, "Fired") != 1));{sSymbolName = "Something";}
					float fDistance = GetDistanceBetween(oDetected, oCaster);
					int nDistance = FloatToInt(fDistance);
					string sDistance = IntToString(nDistance);
					float fAngle = GetAngleBetweenObjects(oDetected, oCaster);
					string sAngle = GetCompassDirectionOfAngle(fAngle);
						
					if((nConcentration > 13) && (GetLocalInt(oDetected, "Fired") != 1)) {
						DelayCommand(21.0, SendMessageToAllDMs("Glyph or Symbol " + sSymbolName + " --" + GetName(oDetected) + "-- centered on a spot " + sDistance + "m " + sAngle + " of " + GetName(oCaster) + " gives off a " + sAuraStrength + " aura " + sSchool));
						DelayCommand(21.0, SendMessageToPC(oCaster, sSymbolName + " centered on a spot " + sDistance + "m " + sAngle + " of " + GetName(oCaster) + " gives off a " + sAuraStrength + " aura " + sSchool));
						}
					}
				
					if(GetLocalInt(oDetected, "ACR_SPELLSCHOOL") > 0) {
						nAuraCount++;
						int nACRSpellSchool = GetLocalInt(oDetected, "ACR_SPELLSCHOOL");
						int nAuraPower = GetLocalInt(oDetected, "ACR_SPELLPOWER");
						int nACRSpellSchool2 = GetLocalInt(oDetected, "ACR_SPELLSCHOOL2");
						int nAuraPower2 = GetLocalInt(oDetected, "ACR_SPELLPOWER2");
						if(nAuraPower > 0) {sAuraStrength = "faint";}
						if(nAuraPower > 3) {sAuraStrength = "moderate";}
						if(nAuraPower > 6) {sAuraStrength = "strong";}
						if(nAuraPower > 9) {sAuraStrength = "overwhelming";}
						if(nAuraPower2 > 0) {sAuraStrength2 = "faint";}
						if(nAuraPower2 > 3) {sAuraStrength2 = "moderate";}
						if(nAuraPower2 > 6) {sAuraStrength2 = "strong";}
						if(nAuraPower2 > 9) {sAuraStrength2 = "overwhelming";}
						if(nACRSpellSchool == 1) {sSchool = " of <color=lightblue>Abjuration </color>";}
						if(nACRSpellSchool == 2) {sSchool = " of <color=tan>Conjuration </color>";}
						if(nACRSpellSchool == 3) {sSchool = " of <color=green>Divination </color>";}
						if(nACRSpellSchool == 4) {sSchool = " of <color=magenta>Enchantment </color>";}
						if(nACRSpellSchool == 5) {sSchool = " of <color=red>Evocation </color>";}
						if(nACRSpellSchool == 6) {sSchool = " of <color=purple>Illusion </color>";}
						if(nACRSpellSchool == 7) {sSchool = " of <color=white>Necromancy </color>";}
						if(nACRSpellSchool == 8) {sSchool = " of <color=orange>Transmutation </color>";}
						if(nACRSpellSchool == 9) {sSchool = " of <color=#FFFF00>Universal arcanity</color>";}
						//if(nACRSpellSchool == 9) {sSchool = " of <color=white>Holiness </color>";}
						if(nACRSpellSchool2 == 1) {sSchool2 = " of <color=lightblue>Abjuration </color>";}
						if(nACRSpellSchool2 == 2) {sSchool2 = " of <color=tan>Conjuration </color>";}
						if(nACRSpellSchool2 == 3) {sSchool2 = " of <color=green>Divination </color>";}
						if(nACRSpellSchool2 == 4) {sSchool2 = " of <color=magenta>Enchantment </color>";}
						if(nACRSpellSchool2 == 5) {sSchool2 = " of <color=red>Evocation </color>";}
						if(nACRSpellSchool2 == 6) {sSchool2 = " of <color=purple>Illusion </color>";}
						if(nACRSpellSchool2 == 7) {sSchool2 = " of <color=white>Necromancy </color>";}
						if(nACRSpellSchool2 == 8) {sSchool2 = " of <color=orange>Transmutation </color>";}
						if(nACRSpellSchool2 == 9) {sSchool2 = " of <color=#FFFF00>Universal arcanity</color>";}
						//if(nACRSpellSchool2 == 9) {sSchool2 = " of <color=white>Holiness </color>";}
						
						if(sSchool2 != "") {sSchool2 = " and a " + sAuraStrength2 + " aura " + sSchool2;}
						SetLocalInt(oItem, "ACR_SPELLSCHOOL", -1);
						
						if(GetIsSkillSuccessful(oCaster, SKILL_SPELLCRAFT, 15 + nAuraPower, FALSE) == FALSE) {sSchool = "";}
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
						sAuraPowerHigh = GetLocalString(oCaster, "sAuraPowerHigh");
							
						if(nAuraCount == 1){
							DelayCommand(6.0, SendMessageToAllDMs(GetTag(oDetected) + " " + GetName(oCaster) + " concentrates for one round and learns that there is magic within range."));
							DelayCommand(6.0, SendMessageToPC(oCaster, "You concentrate for one round and learn that there is magic within range."));
							}	
						string sName = "Something";
						float fDistance = GetDistanceBetween(oDetected, oCaster);
						int nDistance = FloatToInt(fDistance);
						string sDistance = IntToString(nDistance);
						float fAngle = GetAngleBetweenObjects(oDetected, oCaster);
						string sAngle = GetCompassDirectionOfAngle(fAngle);
									
						if(nConcentration > 13) {
							DelayCommand(21.0, SendMessageToAllDMs(GetName(oDetected) + " --" +sName + "-- " + sDistance + "m to the " + sAngle + " has a " + sAuraStrength + " aura" + sSchool + sSchool2));
							DelayCommand(21.0, SendMessageToPC(oCaster, sName + " " + sDistance + "m to the " + sAngle + " has a " + sAuraStrength + " aura" + sSchool + sSchool2));
							}
						}
							
							
				
					//SendMessageToAllDMs("After oDetected: Object Type = " + IntToString(GetObjectType(oDetected)) + " " + sSchool + ", Name = " + GetName(oDetected) + ", Tag = " + GetTag(oDetected) + ", ResRef = " + GetResRef(oDetected));
					
					}
				
				sSchool = "";
				sSchool2 = "";
				nAuraPower = 0;
				nAuraPower2 = 0;
							
				if(GetObjectType(oDetected) == OBJECT_TYPE_WAYPOINT)  {
						
					if((FindSubString(GetName(oDetected), "Trap: Spell") != -1) || (FindSubString(GetTag(oDetected), "trap_spell_")) != -1)  {
						int nSpellID = GetLocalInt(oDetected, "ACR_TRAP_SPELL_ID");
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
						nAuraCount++;
						sAuraPower = Get2DAString("spells", "Innate", nSpellID);
						nAuraPower = StringToInt(sAuraPower);
						sAuraStrength = "an indeterminately powerful";
						if(nAuraPower > 0) {sAuraStrength = "a faint";}
						if(nAuraPower > 3) {sAuraStrength = "a moderate";}
						if(nAuraPower > 6) {sAuraStrength = "a strong";}
						if(nAuraPower > 9) {sAuraStrength = "an overwhelming";}
							
						nAuraPowerHigh = GetLocalInt(oCaster, "nAuraPowerHigh");
						if(nAuraPower > nAuraPowerHigh) {
							SetLocalInt(oCaster, "nAuraPowerHigh", nAuraPower);
							SetLocalString(oCaster, "sAuraPowerHigh", sAuraStrength);
						    }
						sAuraPowerHigh = GetLocalString(oCaster, "sAuraPowerHigh");
														
						if(nAuraCount == 1) {
							DelayCommand(6.0, SendMessageToAllDMs(GetTag(oDetected) + " " + GetName(oCaster) + " concentrates for one round and learns that there is magic within range."));
							DelayCommand(6.0, SendMessageToPC(oCaster, "You concentrate for one round and learn that there is magic within range."));
							}
						
						if(!GetIsSkillSuccessful(oCaster, SKILL_SPELLCRAFT, 15 + nAuraPower, FALSE)){sSchool = "";}
						object oOrigin = GetNearestObjectByTag("TRAP_ORIGIN", oDetected, 1);
						float fDistance = GetDistanceBetween(oDetected, oOrigin);
						int nDistance = FloatToInt(fDistance);
						string sDistance = IntToString(nDistance);
						float fAngle = GetAngleBetweenObjects(oDetected, oOrigin);
						string sAngle = GetCompassDirectionOfAngle(fAngle);
						if((nConcentration > 13) && (oOrigin != OBJECT_INVALID)) {
							DelayCommand(21.0, SendMessageToAllDMs("Trap origin --" + GetName(oOrigin) + "-- and " + GetName(oDetected) + " centered on a spot " + sDistance + "m " + sAngle + " of " + GetName(oOrigin) + " give off " + sAuraStrength + " aura" + sSchool));
							DelayCommand(21.0, SendMessageToPC(oCaster, GetName(oOrigin) + " and a circle centered on a spot " + sDistance + "m " + sAngle + " of " + GetName(oOrigin) + " gives off " + sAuraStrength + " aura" + sSchool));
							}
						}
						
						sSchool = "";
						sSchool2 = "";
						nAuraPower = 0;
						nAuraPower2 = 0;
						
						if(GetLocalInt(oDetected, "ACR_SPELLSCHOOL") > 0) {
							nAuraCount++;
							int nACRSpellSchool = GetLocalInt(oDetected, "ACR_SPELLSCHOOL");
						int nAuraPower = GetLocalInt(oDetected, "ACR_SPELLPOWER");
						int nACRSpellSchool2 = GetLocalInt(oDetected, "ACR_SPELLSCHOOL2");
						int nAuraPower2 = GetLocalInt(oDetected, "ACR_SPELLPOWER2");
						if(nAuraPower > 0) {sAuraStrength = "faint";}
						if(nAuraPower > 3) {sAuraStrength = "moderate";}
						if(nAuraPower > 6) {sAuraStrength = "strong";}
						if(nAuraPower > 9) {sAuraStrength = "overwhelming";}
						if(nAuraPower2 > 0) {sAuraStrength2 = "faint";}
						if(nAuraPower2 > 3) {sAuraStrength2 = "moderate";}
						if(nAuraPower2 > 6) {sAuraStrength2 = "strong";}
						if(nAuraPower2 > 9) {sAuraStrength2 = "overwhelming";}
						if(nACRSpellSchool == 1) {sSchool = " of <color=lightblue>Abjuration </color>";}
						if(nACRSpellSchool == 2) {sSchool = " of <color=tan>Conjuration </color>";}
						if(nACRSpellSchool == 3) {sSchool = " of <color=green>Divination </color>";}
						if(nACRSpellSchool == 4) {sSchool = " of <color=magenta>Enchantment </color>";}
						if(nACRSpellSchool == 5) {sSchool = " of <color=red>Evocation </color>";}
						if(nACRSpellSchool == 6) {sSchool = " of <color=purple>Illusion </color>";}
						if(nACRSpellSchool == 7) {sSchool = " of <color=white>Necromancy </color>";}
						if(nACRSpellSchool == 8) {sSchool = " of <color=orange>Transmutation </color>";}
						if(nACRSpellSchool == 9) {sSchool = " of <color=#FFFF00>Universal arcanity</color>";}
						//if(nACRSpellSchool == 9) {sSchool = " of <color=white>Holiness </color>";}
						if(nACRSpellSchool2 == 1) {sSchool2 = " of <color=lightblue>Abjuration </color>";}
						if(nACRSpellSchool2 == 2) {sSchool2 = " of <color=tan>Conjuration </color>";}
						if(nACRSpellSchool2 == 3) {sSchool2 = " of <color=green>Divination </color>";}
						if(nACRSpellSchool2 == 4) {sSchool2 = " of <color=magenta>Enchantment </color>";}
						if(nACRSpellSchool2 == 5) {sSchool2 = " of <color=red>Evocation </color>";}
						if(nACRSpellSchool2 == 6) {sSchool2 = " of <color=purple>Illusion </color>";}
						if(nACRSpellSchool2 == 7) {sSchool2 = " of <color=white>Necromancy </color>";}
						if(nACRSpellSchool2 == 8) {sSchool2 = " of <color=orange>Transmutation </color>";}
						if(nACRSpellSchool2 == 9) {sSchool2 = " of <color=#FFFF00>Universal arcanity</color>";}
						//if(nACRSpellSchool2 == 9) {sSchool2 = " of <color=white>Holiness </color>";}
						
						if(sSchool2 != "") {sSchool2 = " and a " + sAuraStrength2 + " aura " + sSchool2;}
						SetLocalInt(oItem, "ACR_SPELLSCHOOL", -1);
						
							if(GetIsSkillSuccessful(oCaster, SKILL_SPELLCRAFT, 15 + nAuraPower, FALSE) == FALSE) {sSchool = "";}
								
								string sName = GetName(oDetected);
								float fDistance = GetDistanceBetween(oDetected, oCaster);
								int nDistance = FloatToInt(fDistance);
								string sDistance = IntToString(nDistance);
								float fAngle = GetAngleBetweenObjects(oDetected, oCaster);
								string sAngle = GetCompassDirectionOfAngle(fAngle);
									
								if(nConcentration > 13) {
									DelayCommand(21.0, SendMessageToAllDMs(GetName(oDetected) + " --" +sName + "-- " + sDistance + "m to the " + sAngle + " has a " + sAuraStrength + " aura" + sSchool +sSchool2));
									DelayCommand(21.0, SendMessageToPC(oCaster, sName + " " + sDistance + "m to the " + sAngle + " has a " + sAuraStrength + " aura" + sSchool + sSchool2));
									}
								
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
						sAuraPowerHigh = GetLocalString(oCaster, "sAuraPowerHigh");
								
						if(nAuraCount == 1){
							DelayCommand(6.0, SendMessageToAllDMs(GetTag(oDetected) + " " + GetName(oCaster) + " concentrates for one round and learns that there is magic within range."));
							DelayCommand(6.0, SendMessageToPC(oCaster, "You concentrate for one round and learn that there is magic within range."));
							}
						}
					}
					
				sSchool = "";
				sSchool2 = "";
				nAuraPower = 0;
				nAuraPower2 = 0;
							
				if((GetObjectType(oDetected) == OBJECT_TYPE_CREATURE) && (GetIsDM(oDetected) == FALSE)) {
					string sName = GetName(oDetected);
					int nRace = GetRacialType(oDetected);
					string sRace = "";
					if(nRace == 10) {sRace = "Construct"; sSchool = "<color=orange>Transmutation</color>";}
					if(nRace == 16) {sRace = "Elemental"; sSchool = "<color=tan>Conjuration</color>";}
					if(nRace == 17) {sRace = "Fey";  sSchool = "<color=magenta>Enchantment</color>";}
					if(nRace == 19) {sRace = "Magical Beast"; sSchool = "<color=#D3D3D3>Innate Magic</color>";}
					if(nRace == 20) {sRace = "Outsider"; sSchool = "<color=tan>Conjuration</color>";}
					if(nRace == 23) {sRace = "Shapechanger"; sSchool = "<color=orange>Transmutation</color>";}
					if(nRace == 24) {sRace = "Undead"; sSchool = "<color=white>Necromancy</color>";}
					if(FindSubString(GetTag(oDetected), "003_cr_scry_sen") != -1) {sName = "Something"; sRace = "Scrying Sensor"; sSchool = "<color=green>Divination</color>";} 
					if((GetHasSpellEffect(SPELL_INVISIBILITY, oDetected)) || (GetHasSpellEffect(SPELL_INVISIBILITY_SPHERE, oDetected)) || (GetHasSpellEffect(SPELL_GREATER_INVISIBILITY, oDetected))  || (GetHasSpellEffect(SPELL_MASS_INVISIBILITY, oDetected))) {
							sName = "Invisible Presence";
							}  
					//SendMessageToAllDMs("sRace = " + sRace);
					if(sRace != ""){
						nAuraCount++;
						float fAuraPower = GetChallengeRating(oDetected);
						nAuraPower = FloatToInt(fAuraPower)/2;
						SendMessageToAllDMs("nAuraPower = " + IntToString(nAuraPower));
					    if(nAuraPower > 0) {sAuraStrength = "a faint";}
						if(nAuraPower > 3) {sAuraStrength = "a moderate";}
						if(nAuraPower > 6) {sAuraStrength = "a strong";}
						if(nAuraPower > 9) {sAuraStrength = "an overwhelming";}
						SendMessageToAllDMs("sAuraStrength = " + sAuraStrength);
					    nAuraPowerHigh = GetLocalInt(oCaster, "nAuraPowerHigh");
						if(nAuraPower > nAuraPowerHigh) {
							SetLocalInt(oCaster, "nAuraPowerHigh", nAuraPower);
							SetLocalString(oCaster, "sAuraPowerHigh", sAuraStrength);
							}
						sAuraPowerHigh = GetLocalString(oCaster, "sAuraPowerHigh");
						DelayCommand(6.0, SendMessageToAllDMs(GetTag(oDetected) + " " + GetName(oCaster) + " concentrates for one round and learns that there is magic within range."));
						DelayCommand(6.0, SendMessageToPC(oCaster, "You concentrate for one round and learn that there is magic within range."));
						
						if(GetIsSkillSuccessful(oCaster, SKILL_SPELLCRAFT, 15 + nAuraPower, FALSE)) {sSchool = " of " + sSchool;}
						if(nConcentration > 13) {
							DelayCommand(21.0, SendMessageToAllDMs(sName + " has a " + sAuraStrength + " lingering aura of " + sSchool));
							DelayCommand(21.1, SendMessageToPC(oCaster, sName + " has a " + sAuraStrength + " lingering aura" + sSchool));
							}
						}
					
					sSchool = "";
					sSchool2 = "";
					nAuraPower = 0;
					nAuraPower2 = 0;
				
					if(GetHasAnySpellEffect(oDetected)) {
						if(nConcentration > 13) {
							DelayCommand(20.0, SendMessageToAllDMs("**********"));
							DelayCommand(20.1, SendMessageToAllDMs("FUNCTIONING SPELLS: " + GetName(oDetected)));
								DelayCommand(20.0, SendMessageToPC(oCaster, "**********"));
								DelayCommand(20.1, SendMessageToPC(oCaster, "FUNCTIONING SPELLS: " + GetName(oDetected)));
						}	
						effect eEffect = GetFirstEffect(oDetected);
						int nEffectSchool = 0;
							
						while (GetIsEffectValid(eEffect)) {
							int nEffect = GetEffectSpellId(eEffect); 
							string sEffect = Get2DAString("spells", "Label", nEffect);
							sAuraPower = Get2DAString("spells", "Innate", nEffect);
							nAuraPower = StringToInt(sAuraPower);
							sAuraStrength = "an";
							if(nAuraPower > 0) {sAuraStrength = "a faint";}
							if(nAuraPower > 3) {sAuraStrength = "a moderate";}
							if(nAuraPower > 6) {sAuraStrength = "a strong";}
							if(nAuraPower > 9) {sAuraStrength = "an overwhelming";}
							nAuraPowerHigh = GetLocalInt(oCaster, "nAuraPowerHigh");
							if(nAuraPower > nAuraPowerHigh) {
								SetLocalInt(oCaster, "nAuraPowerHigh", nAuraPower);
								SetLocalString(oCaster, "sAuraPowerHigh", sAuraStrength);
								   }
							sAuraPowerHigh = GetLocalString(oCaster, "sAuraPowerHigh");
							string sEffectSchool = Get2DAString("spells", "School", nEffect);
							nEffectSchool = GetLocalInt(oDetected, "sEffectSchool_" + sEffectSchool);
							
							if((nEffect != -1) && (nEffectSchool == 0)) {
								SetLocalInt(oDetected, "sEffectSchool_" + sEffectSchool, nEffect);
								
								nAuraCount++;
								if(nAuraCount == 1) {
									DelayCommand(6.0, SendMessageToAllDMs(GetTag(oDetected) + " " + GetName(oCaster) + " concentrates for one round and learns that there is magic within range."));
									DelayCommand(6.0, SendMessageToPC(oCaster, "You concentrate for one round and learn that there is magic within range."));
									}
								if(GetIsSkillSuccessful(oCaster, SKILL_SPELLCRAFT, 15 + nAuraPower, FALSE)){
									if(sEffectSchool == "A") {sSchool = " of <color=lightblue>Abjuration </color>";}
									if(sEffectSchool == "C") {sSchool = " of <color=tan>Conjuration </color>";}
									if(sEffectSchool == "D") {sSchool = " of <color=green>Divination </color>";}
									if(sEffectSchool == "E") {sSchool = " of <color=magenta>Enchantment </color>";}
									if(sEffectSchool == "H") {sSchool = " of <color=white>Holiness </color>";}
									if(sEffectSchool == "I") {sSchool = " of <color=purple>Illusion </color>";}
									if(sEffectSchool == "N") {sSchool = " of <color=white>Necromancy </color>";}
									if(sEffectSchool == "T") {sSchool = " of <color=orange>Transmutation </color>";}
									if(sEffectSchool == "V") {sSchool = " of <color=red>Evocation </color>";}
									if(sEffectSchool == "G") {sSchool = " of <color=#FFFF00>Universal arcanity</color>";}
									}
									
								if(nConcentration > 13) {
									DelayCommand(20.5, SendMessageToAllDMs("<color=#71716F>" + GetName(oDetected) + " has " + sAuraStrength + " --" + IntToString(nAuraPower) + "-- aura</color>" + sSchool + " --" + sEffect ));
									DelayCommand(20.5, SendMessageToPC(oCaster, "<color=#666666>" + GetName(oDetected) + " has " + sAuraStrength + " aura</color>" + sSchool));
									}	
								}
							eEffect = GetNextEffect(oDetected);
							}
						}
					}
				
					sSchool = "";
					sSchool2 = "";
					nAuraPower = 0;
					nAuraPower2 = 0;
					int nSlot = 0;
					string sSlot = "";
					float fAngle = GetAngleBetweenObjects(oDetected, oCaster);
					string sAngle = GetCompassDirectionOfAngle(fAngle);
						
					if(((GetObjectType(oDetected) == OBJECT_TYPE_PLACEABLE) && (GetHasInventory(oDetected))) || ((GetObjectType(oDetected) == OBJECT_TYPE_CREATURE) && (GetIsDM(oDetected) == FALSE)) || (GetObjectType(oDetected) == OBJECT_TYPE_ITEM)){
						if(GetObjectType(oDetected) == OBJECT_TYPE_ITEM) {oItem = oDetected; nSlot = 14; sSlot = IntToString(FloatToInt(GetDistanceBetween(oCaster, oDetected))) + " meters to the " + sAngle;}
						else {oItem = GetFirstItemInInventory(oDetected);}
						int nFirst = 0;
						int nGen = 0;
						int nAbj = 0;
						int nCon = 0;
						int nDiv = 0;
						int nEnc = 0;
						int nEvo = 0;
						int nHoly = 0;
						int nIll = 0;
						int nNec = 0;
						int nTra = 0;
						int nSomething = 0;
						while (nSlot < 15) {
							if(GetObjectType(oDetected) == OBJECT_TYPE_PLACEABLE) {nSlot = 14;}		
							if((nFirst == 0) && (GetObjectType(oDetected) == OBJECT_TYPE_CREATURE)) {nFirst = 1; sSlot = "in the inventory of " + GetName(oDetected);}
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
								
							if(GetLocalInt(oItem, "ACR_SPELLSCHOOL") > 0) {
									int nACRSpellSchool = GetLocalInt(oItem, "ACR_SPELLSCHOOL");
									int nAuraPower = GetLocalInt(oItem, "ACR_SPELLPOWER");
									int nACRSpellSchool2 = GetLocalInt(oDetected, "ACR_SPELLSCHOOL2");
									int nAuraPower2 = GetLocalInt(oDetected, "ACR_SPELLPOWER2");
									//if((FindSubString(GetTag(oItem), "_mask_circus") != -1) || (FindSubString(GetTag(oItem), "_it_phalorm_") != -1)) {nACRSpellSchool = 2;}
									int nSpell = IP_CONST_CASTSPELL_UNIQUE_POWER_SELF_ONLY;
									int nNumberUses = IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY;
									itemproperty ipSpellSchool = ItemPropertyCastSpell(nSpell, nNumberUses);
									IPSafeAddItemProperty(oItem, ipSpellSchool, 5.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, FALSE);
									if(nACRSpellSchool == 9) {sSchool = " of <color=#FFFF00>Universal arcanity</color>"; nGen++;}
									if(nACRSpellSchool == 1) {sSchool = " of <color=lightblue>Abjuration </color>"; nAbj++;}
									if(nACRSpellSchool == 2) {sSchool = " of <color=tan>Conjuration </color>"; nCon++;}
									if(nACRSpellSchool == 3) {sSchool = " of <color=green>Divination </color>"; nDiv++;}
									if(nACRSpellSchool == 4) {sSchool = " of <color=magenta>Enchantment </color>"; nEnc++;}
									if(nACRSpellSchool == 5) {sSchool = " of <color=red>Evocation </color>"; nEvo++;}
									if(nACRSpellSchool == 6) {sSchool = " of <color=purple>Illusion </color>"; nIll++;}
									if(nACRSpellSchool == 7) {sSchool = " of <color=white>Necromancy </color>"; nNec++;}
									if(nACRSpellSchool == 8) {sSchool = " of <color=orange>Transmutation </color>"; nTra++;}
									if(nACRSpellSchool == 9) {sSchool = " of <color=white>Holiness </color>";nHoly++;}
									SetLocalInt(oItem, "ACR_SPELLSCHOOL", -1);
									}
																		
							itemproperty ipItem = GetFirstItemProperty(oItem);
							if(((GetBaseItemType(oItem) < 69) || (GetBaseItemType(oItem) > 73))
							
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
								&& (FindSubString(GetTag(oItem), "acr_dc") == -1)
								&& (FindSubString(GetTag(oItem), "abr_dm") == -1)
								&& (FindSubString(GetTag(oItem), "abr_spawn") == -1)
								&& (FindSubString(GetTag(oItem), "003_it_loot_token") == -1)
								&& (FindSubString(GetTag(oItem), "dye_") == -1)
								&& (FindSubString(GetTag(oItem), "it_cassi") == -1)
								&& (FindSubString(GetTag(oItem), "it_nararoo") == -1)
								) || (GetLocalInt(oItem, "ACR_SPELLSCHOOL") == -1)) {
												
									int nBaseItem = GetBaseItemType(oItem);
									string sBaseItem = IntToString(nBaseItem);
									string sItemName = GetName(oItem);
									int nSpot = 0;
									string sSpot = "";
									if(nBaseItem == 19) {sBaseItem = "An amulet"; nSpot = 10;}
									if(nBaseItem == 16) {sBaseItem = "Armor"; nSpot = -5;}
									if((nBaseItem == 16) && (FindSubString(GetName(oItem), "Robe") != -1)) {sBaseItem = "A robe"; nSpot = 5;}
									if(nBaseItem == 20) {sBaseItem = "Arrows"; nSpot = 0;}
									if(nBaseItem == 3) {sBaseItem = "A bastard sword"; nSpot = -5;}
									if(nBaseItem == 2) {sBaseItem = "A battle axe"; nSpot = -10;}
									if(nBaseItem == 21) {sBaseItem = "A belt"; nSpot = 10;}
									if(nBaseItem == 101) {sBaseItem = "A bottle"; nSpot = 0;}
									if(nBaseItem == 25) {sBaseItem = "Bolts"; nSpot = 0;}
									if(nBaseItem == 74) {sBaseItem = "A book"; nSpot = 5;}
									if(nBaseItem == 26) {sBaseItem = "A pair of boots"; nSpot = 5;}
									if(nBaseItem == 78) {sBaseItem = "A pair of bracers"; nSpot = 10;}
									if(nBaseItem == 27) {sBaseItem = "A pouch of bullets"; nSpot = 10;}
									if(nBaseItem == 80) {sBaseItem = "A cloak"; nSpot = 5;}
									if(nBaseItem == 28) {sBaseItem = "A club"; nSpot = 0;}
									if(nBaseItem == 22) {sBaseItem = "A dagger"; nSpot = 10;}
									if(nBaseItem == 31) {sBaseItem = "A set of darts"; nSpot = 10;}
									if(nBaseItem == 33) {sBaseItem = "A double axe";  nSpot = -10;}
									if(nBaseItem == 128) {sBaseItem = "A drum"; nSpot = 0;}
									if(nBaseItem == 108) {sBaseItem = "A dwarven war axe"; nSpot = -10;}
									if(nBaseItem == 114) {sBaseItem = "A falchion"; nSpot = 0;}
									if(nBaseItem == 116) {sBaseItem = "A flail"; nSpot = 0;}
									if(nBaseItem == 129) {sBaseItem = "A flute"; nSpot = 5;}
									if(nBaseItem == 77) {sBaseItem = "A gem"; nSpot = 10;}
									if(nBaseItem == 36) {sBaseItem = "A pair of gloves"; nSpot = 0;}
									if(nBaseItem == 18) {sBaseItem = "A great axe"; nSpot = -10;}
									if(nBaseItem == 120) {sBaseItem = "A great club"; nSpot = -10;}
									if(nBaseItem == 13) {sBaseItem = "A great sword"; nSpot = -10;}
									if(nBaseItem == 81) {sBaseItem = "A grenade"; nSpot = 5;}
									if(nBaseItem == 10) {sBaseItem = "A halberd"; nSpot = -10;}
									if(nBaseItem == 38) {sBaseItem = "A hand axe"; nSpot = 5;}
									if(nBaseItem == 6) {sBaseItem = "A heavy crossbow"; nSpot = -5;}
									if(nBaseItem == 35) {sBaseItem = "A heavy flail"; nSpot = -5;}
									if(nBaseItem == 17) {sBaseItem = "A helmet or other headgear"; nSpot = 5;}
									if((nBaseItem == 17) && (FindSubString(GetName(oItem), "Mask") != -1)) {sBaseItem = "A mask"; nSpot = 5;}
									if((nBaseItem == 17) && (FindSubString(GetName(oItem), "Headband") != -1)) {sBaseItem = "A headband"; nSpot = 5;}
									if(nBaseItem == 40) {sBaseItem = "A kama"; nSpot = 0;}
									if(nBaseItem == 41) {sBaseItem = "A katana"; nSpot = 0;}
									if(nBaseItem == 65) {sBaseItem = "A key"; nSpot = 10;}
									if(nBaseItem == 42) {sBaseItem = "A kukri"; nSpot = 0;}
									if(nBaseItem == 66) {sBaseItem = "A large box"; nSpot = -10;}
									if(nBaseItem == 56) {sBaseItem = "A large shield"; nSpot = -10;}
									if(nBaseItem == 7) {sBaseItem = "A light crossbow"; nSpot = 0;}
									if(nBaseItem == 4) {sBaseItem = "A light flail"; nSpot = 0;}
									if(nBaseItem == 37) {sBaseItem = "A light hammer"; nSpot = 0;}
									if(nBaseItem == 9) {sBaseItem = "A light mace"; nSpot = 0;}
									if(nBaseItem == 1) {sBaseItem = "A longsword"; nSpot = 0;}
									if(nBaseItem == 8) {sBaseItem = "A longbow"; nSpot = 0;}
									if(nBaseItem == 132) {sBaseItem = "A lute"; nSpot = 5;}
									if(nBaseItem == 113) {sBaseItem = "A mace"; nSpot = 0;}
									if(nBaseItem == 44) {sBaseItem = "A rod"; nSpot = 5;}
									if(nBaseItem == 45) {sBaseItem = "A staff"; nSpot = -10;}
									if(nBaseItem == 46) {sBaseItem = "A wand"; nSpot = 5;}
									if(nBaseItem == 34) {sBaseItem = "A large item"; nSpot = -5;}
									if(nBaseItem == 29) {sBaseItem = "A medium item"; nSpot = 0;}
									if(nBaseItem == 24) {sBaseItem = "A small item"; nSpot = 10;}
									if(nBaseItem == 103) {sBaseItem = "A small item"; nSpot = 10;}
									if(nBaseItem == 43) {sBaseItem = "A tall item"; nSpot = -5;}
									if(nBaseItem == 79) {sBaseItem = "A thin item"; nSpot = 5;}
									if(nBaseItem == 68) {sBaseItem = "A wide item"; nSpot = -5;}
									if(nBaseItem == 47) {sBaseItem = "A morningstar"; nSpot = 0;}
									if(nBaseItem == 49) {sBaseItem = "A potion"; nSpot = 5;}
									if(nBaseItem == 96) {sBaseItem = "A potion"; nSpot = 5;}
									if(nBaseItem == 50) {sBaseItem = "A quarterstaff"; nSpot = -10;}
									if(nBaseItem == 51) {sBaseItem = "A rapier"; nSpot = 0;}
									if(nBaseItem == 52) {sBaseItem = "A ring"; nSpot = 10;}
									if(nBaseItem == 53) {sBaseItem = "A scimitar"; nSpot = 0;}
									if(nBaseItem == 75) {sBaseItem = "A scroll"; nSpot = 5;}
									if(nBaseItem == 55) {sBaseItem = "A scythe"; nSpot = -10;}
									if(nBaseItem == 11) {sBaseItem = "A short bow"; nSpot = 0;}
									if(nBaseItem == 58) {sBaseItem = "A short spear"; nSpot = -5;}
									if(nBaseItem == 0) {sBaseItem = "A shortsword"; nSpot = 0;}
									if(nBaseItem == 59) {sBaseItem = "A set of shuriken";}
									if(nBaseItem == 60) {sBaseItem = "A sickle"; nSpot = -5;}
									if(nBaseItem == 61) {sBaseItem = "A sling"; nSpot = 10;}
									if(nBaseItem == 14) {sBaseItem = "A small shield"; nSpot = -5;}
									if(nBaseItem == 119) {sBaseItem = "A spear"; nSpot = -10;}
									if(nBaseItem == 63) {sBaseItem = "A set of throwing axes"; nSpot = 5;}
									if(nBaseItem == 62) {sBaseItem = "A set of thieves tools"; nSpot = 5;}
									if(nBaseItem == 200) {sBaseItem = "A small item"; nSpot = 0;}
									if(nBaseItem == 72) {sBaseItem = "A small item"; nSpot = 0;}
									if(nBaseItem == 57) {sBaseItem = "A tower shield"; nSpot = -10;}
									if(nBaseItem == 5) {sBaseItem = "A war hammer"; nSpot = -5;}
									if(nBaseItem == 126) {sBaseItem = "A war mace"; nSpot = -5;}
									if(nBaseItem == 111) {sBaseItem = "A whip"; nSpot = 5;}
									
									if(nSpot == -10) {sSpot = sBaseItem;}
									if(nSpot == -5) {sSpot = "A medium sized item";}
									if(nSpot == 5) {sSpot = "A small item";}
									if(nSpot == 10) {sSpot = "A tiny item";}
																	
									if((GetHasSpellEffect(SPELL_INVISIBILITY, oDetected)) || (GetHasSpellEffect(SPELL_INVISIBILITY_SPHERE, oDetected)) || (GetHasSpellEffect(SPELL_GREATER_INVISIBILITY, oDetected))  || (GetHasSpellEffect(SPELL_MASS_INVISIBILITY, oDetected))) {
										sBaseItem = ""; sSlot = IntToString(FloatToInt(GetDistanceBetween(oCaster, oDetected))) + " meters away "; sSpot = "";
										}
									
									while (GetIsItemPropertyValid(ipItem)) {
										int nItemProperty = GetItemPropertyType(ipItem);
										string sItemProperty = "";
										int nItemSubType = GetItemPropertySubType(ipItem);
										string sItemSubType = IntToString(nItemSubType);
										int nItemCost = GetItemPropertyCostTableValue(ipItem);
										string sSpellIndex = "";
										string sSchool = "";
										if(nItemProperty == 0) {sItemProperty = "Ability Bonus"; sSchool = "T"; nAuraPower = nItemCost;}
										if((nItemProperty >= 1) && (nItemProperty <=5)) {sItemProperty = "AC Bonus"; sSchool = "A"; nAuraPower = nItemCost;}
										if((nItemProperty >= 56) && (nItemProperty <=59)) {sItemProperty = "Attack Bonus"; sSchool = "V"; nAuraPower = nItemCost;}
										if(nItemProperty == 12) {sItemProperty = "Bonus Feat"; sSchool = "T"; nAuraPower = 2;}
										if(nItemProperty == 66) {sItemProperty = "Bonus HP"; sSchool = "T"; nAuraPower = 2;}
										if(nItemProperty == 13) {sItemProperty = "Bonus Spell Slot"; sSchool = "T"; nAuraPower = nItemCost;}
										if(nItemProperty == 15) {
											sItemProperty = "Cast Spell";
											sSpellIndex = Get2DAString("iprp_spells", "SpellIndex", nItemSubType); 
											sSchool = Get2DAString("spells", "School", StringToInt(sSpellIndex));
											sAuraPower = Get2DAString("spells", "Innate", StringToInt(sSpellIndex));
											nAuraPower = StringToInt(sAuraPower);
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
											nAuraCount++;
											if(GetObjectType(oDetected) == OBJECT_TYPE_CREATURE) {SetLocalInt(oCaster, "nItemCount", 1);}
											if((sItemSubType == "125") || (sItemSubType == "329") || (sItemSubType == "335")) 
												{sSchool = " of arcanity too complex to unravel ";
												if(GetTag(oItem) == "abr_it_holysymbol") {sSchool = "A"; nAuraPower = 1;}
												//if(FindSubString(GetTag(oItem), "abr_it_scry_") != -1) {sSchool = "D"; nAuraPower = 4;}
												if(GetTag(oItem) == "abr_it_scry_kit") {sSchool = "G"; nAuraPower = 1;}
												if(FindSubString(GetTag(oItem), "it_slv_telepor") != -1) {sSchool = "C"; nAuraPower = 5;}
												if(FindSubString(GetTag(oItem), "_earring_msg") != -1) {sSchool = "T"; nAuraPower = 1;}
												//if(FindSubString(GetTag(oItem), "_mask_circus") != -1) {sSchool = "C"; nAuraPower = 1;}
												if(FindSubString(GetTag(oItem), "003_it_diadem") != -1) {sSchool = "N"; nAuraPower = 7;}
												}
												
											//SendMessageToAllDMs("sBaseItem = " + sBaseItem + "; sSlot = " + sSlot); 
											if((FindSubString(sSlot, "inventory") != -1) && (GetIsSkillSuccessful(oCaster, SKILL_SPOT, 10+nSpot, FALSE) == FALSE)) {sBaseItem = sSpot; nSomething++;}
										    if(GetIdentified(oItem) == FALSE) {sBaseItem = sSpot; nSomething++;}
											if((GetObjectType(oDetected) == OBJECT_TYPE_PLACEABLE)&& (GetIsOpen(oDetected) == FALSE)) {sBaseItem = "Something"; nSomething++;}
											
											if(!GetIsSkillSuccessful(oCaster, SKILL_SPELLCRAFT, 15 + nAuraPower, FALSE)){sSchool = "";}
												
											if(sSchool == "A") {sSchool = " of <color=lightblue>Abjuration </color>"; nAbj++;}
											if(sSchool == "C") {sSchool = " of <color=tan>Conjuration </color>"; nCon++;}
											if(sSchool == "D") {sSchool = " of <color=green>Divination </color>"; nDiv++;}
											if(sSchool == "E") {sSchool = " of <color=magenta>Enchantment </color>"; nEnc++;}
											if(sSchool == "H") {sSchool = " of <color=white>Holiness </color>"; nHoly++;}
											if(sSchool == "I") {sSchool = " of <color=purple>Illusion </color>"; nIll++;}
											if(sSchool == "N") {sSchool = " of <color=white>Necromancy </color>"; nNec++;}
											if(sSchool == "T") {sSchool = " of <color=orange>Transmutation </color>"; nTra++;}
											if(sSchool == "V") {sSchool = " of <color=red>Evocation </color>"; nEvo++;}
											if(sSchool == "G") {sSchool = " of <color=#FFFF00>Universal arcanity</color>"; nGen++;}
											
											if(nAuraPower > 0) {sAuraStrength = "faint";}
											if(nAuraPower > 3) {sAuraStrength = "moderate";}
											if(nAuraPower > 6) {sAuraStrength = "strong";}
											if(nAuraPower > 9) {sAuraStrength = "overwhelming";}
											nAuraPowerHigh = GetLocalInt(oCaster, "nAuraPowerHigh");
											if(nAuraPower > nAuraPowerHigh) {
												SetLocalInt(oCaster, "nAuraPowerHigh", nAuraPower);
												SetLocalString(oCaster, "sAuraPowerHigh", sAuraStrength);
							    				}
											sAuraPowerHigh = GetLocalString(oCaster, "sAuraPowerHigh");
												
											if(nAuraCount == 1) {
												DelayCommand(6.0, SendMessageToAllDMs(GetTag(oDetected) + " " + GetName(oCaster) + " concentrates for one round and learns that there is magic within range."));
												DelayCommand(6.0, SendMessageToPC(oCaster, "You concentrate for one round and learn that there is magic within range."));
												}
							
									 		float fDelay = 24.0;
											if(GetObjectType(oDetected) == OBJECT_TYPE_CREATURE) {nCreatureCount++;fDelay = 48.0 + IntToFloat(nSlot/10) +IntToFloat(nCreatureCount);}
											//if((nSlot > 13) ||((nSlot == 0) && (oItem == GetFirstItemInInventory(oDetected)))) {fDelay = 36.0 + IntToFloat(nAuraCount/10);}
											if(((GetObjectType(oDetected) == OBJECT_TYPE_CREATURE) && (nSlot > 0) && (nSlot <= 13)) || (GetObjectType(oDetected) == OBJECT_TYPE_PLACEABLE) || (GetObjectType(oDetected) == OBJECT_TYPE_ITEM)){
												if(nConcentration > 13) {
													DelayCommand(fDelay, SendMessageToAllDMs(GetName(oItem) + ", " + sBaseItem  +  " " + sSlot + ", gives off a " + sAuraStrength + " --" + IntToString(nAuraPower) + "-- aura" + sSchool));
													DelayCommand(fDelay, SendMessageToPC(oCaster, sBaseItem  +  " " + sSlot + " gives off a " + sAuraStrength + " aura" + sSchool));
													}
												}
											
											}
											
										ipItem = GetNextItemProperty(oItem);
									}
								}
								
							if(GetObjectType(oDetected) == OBJECT_TYPE_ITEM) {nSlot++;}
							 }
							
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
							if(nHoly < 5) {sHoly = IntToString(nHoly);} else if(nHoly < 8) {sHoly = "around half a dozen";} else if(nHoly < 13) {sHoly = "close to ten";}  else if(nHoly > 12) {sHoly = "more than a dozen";}
							if(nSomething < 5) {sSomething = IntToString(nSomething);} else if(nSomething < 8) {sSomething = "around half a dozen";} else if(nSomething < 13) {sSomething = "close to ten";}  else if(nSomething > 12) {sSomething = "more than a dozen";}
							if((GetObjectType(oDetected) == OBJECT_TYPE_CREATURE) && (GetLocalInt(oCaster, "nItemCount") > 0)) {
								if(GetLocalInt(oCaster, "nSummary") == 0) {
									DelayCommand(24.0, SendMessageToAllDMs(" "));
									DelayCommand(24.1, SendMessageToAllDMs("EQUIPPED AND CARRIED SUMMARY: "));
									}
								if(nAbj>0) {DelayCommand(20.2 + IntToFloat(nCreatureCount), SendMessageToAllDMs(GetName(oDetected) + "<color=lightblue>: " + sAbj + " Abjuration</color> auras"));}
								if(nCon>0) {DelayCommand(20.3 + IntToFloat(nCreatureCount), SendMessageToAllDMs(GetName(oDetected) + "<color=tan>:" + sCon + " Conjuration</color> auras"));}
								if(nDiv>0) {DelayCommand(20.4 + IntToFloat(nCreatureCount), SendMessageToAllDMs(GetName(oDetected) + "<color=green>: " + sDiv + " Divination</color> auras"));}
								if(nEnc>0) {DelayCommand(20.5 + IntToFloat(nCreatureCount), SendMessageToAllDMs(GetName(oDetected) + "<color=magenta>: " + sEnc + " Enchantment</color> auras"));}
								if(nEvo>0) {DelayCommand(20.6 + IntToFloat(nCreatureCount), SendMessageToAllDMs(GetName(oDetected) + "<color=red>: " + sEvo + " Evocation</color> auras"));}
								if(nIll>0) {DelayCommand(20.7 + IntToFloat(nCreatureCount), SendMessageToAllDMs(GetName(oDetected) + "<color=purple>: " + sIll + " Illusion</color> auras"));}
								if(nNec>0) {DelayCommand(20.8 + IntToFloat(nCreatureCount), SendMessageToAllDMs(GetName(oDetected) + "<color=white>: " + sNec + " Necromancy</color> auras"));}
								if(nTra>0) {DelayCommand(20.9 + IntToFloat(nCreatureCount), SendMessageToAllDMs(GetName(oDetected) + "<color=orange>: " + sTra + " Transmutation</color> auras"));}
								if(nGen>0) {DelayCommand(21.0 + IntToFloat(nCreatureCount), SendMessageToAllDMs(GetName(oDetected) + "<color=#FFFF00>: " + sGen + " Universal</color> auras"));}
								if(nHoly>0) {DelayCommand(21.1 + IntToFloat(nCreatureCount), SendMessageToAllDMs(GetName(oDetected) + "<color=white>: " + sHoly + " Holy</color> auras"));}
								if(nSomething>0) {DelayCommand(21.2 + IntToFloat(nCreatureCount), SendMessageToAllDMs(GetName(oDetected) + ": " + sSomething + " auras you can't classify"));}
								if(GetLocalInt(oCaster, "nSummary") == 0) {
									DelayCommand(36.3 + IntToFloat(nCreatureCount), SendMessageToAllDMs(" "));
									DelayCommand(36.4 + IntToFloat(nCreatureCount), SendMessageToAllDMs("**********"));
									DelayCommand(37.1 + IntToFloat(nCreatureCount), SendMessageToAllDMs("EQUIPPED DETAIL: "));
									DelayCommand(52.0 + IntToFloat(nCreatureCount), SendMessageToAllDMs(" "));
									}
								DelayCommand(52.1 + IntToFloat(nCreatureCount), SendMessageToAllDMs("The rest of the auras on " + GetName(oDetected) + " are in inventory."));
								 
									if(GetLocalInt(oCaster, "nSummary") == 0) {
										DelayCommand(24.0, SendMessageToPC(oCaster, " "));
										DelayCommand(24.1, SendMessageToPC(oCaster, "EQUIPPED AND CARRIED SUMMARY: "));
										}
									if(nAbj>0) {DelayCommand(20.2 + IntToFloat(nCreatureCount), SendMessageToPC(oCaster, GetName(oDetected) + "<color=lightblue>: " + sAbj + " Abjuration</color> auras"));}
									if(nCon>0) {DelayCommand(20.3 + IntToFloat(nCreatureCount), SendMessageToPC(oCaster, GetName(oDetected) + "<color=tan>: " + sCon + " Conjuration</color> auras"));}
									if(nDiv>0) {DelayCommand(20.4 + IntToFloat(nCreatureCount), SendMessageToPC(oCaster, GetName(oDetected) + "<color=green>: " + sDiv + " Divination</color> auras"));}
									if(nEnc>0) {DelayCommand(20.5 + IntToFloat(nCreatureCount), SendMessageToPC(oCaster, GetName(oDetected) + "<color=magenta>: " + sEnc + " Enchantment</color> auras"));}
									if(nEvo>0) {DelayCommand(20.6 + IntToFloat(nCreatureCount), SendMessageToPC(oCaster, GetName(oDetected) + "<color=red>: " + sEvo + " Evocation</color> auras"));}
									if(nIll>0) {DelayCommand(20.7 + IntToFloat(nCreatureCount), SendMessageToPC(oCaster, GetName(oDetected) + "<color=purple>: " + sIll + " Illusion</color> auras"));}
									if(nNec>0) {DelayCommand(20.8 + IntToFloat(nCreatureCount), SendMessageToPC(oCaster, GetName(oDetected) + "<color=white>: " + sNec + " Necromancy</color> auras"));}
									if(nTra>0) {DelayCommand(20.9 + IntToFloat(nCreatureCount), SendMessageToPC(oCaster, GetName(oDetected) + "<color=orange>: " + sTra + " Transmutation</color> auras"));}
									if(nGen>0) {DelayCommand(21.0 + IntToFloat(nCreatureCount), SendMessageToPC(oCaster, GetName(oDetected) + "<color=#FFFF00>: " + sGen + " Universal</color> auras"));}
									if(nHoly>0) {DelayCommand(21.1 + IntToFloat(nCreatureCount), SendMessageToPC(oCaster, GetName(oDetected) + "<color=white>: " + sHoly + " Holy</color> auras"));}
									if(nSomething>0) {DelayCommand(21.2 + IntToFloat(nCreatureCount), SendMessageToPC(oCaster, GetName(oDetected) + ": " + sSomething + " auras you can't classify"));}
								 	if(GetLocalInt(oCaster, "nSummary") == 0) {
										SetLocalInt(oCaster, "nSummary",1);
										DelayCommand(36.3 + IntToFloat(nCreatureCount), SendMessageToPC(oCaster, " "));
										DelayCommand(36.4 + IntToFloat(nCreatureCount), SendMessageToPC(oCaster, "**********"));
										DelayCommand(37.1 + IntToFloat(nCreatureCount), SendMessageToPC(oCaster, "EQUIPPED DETAIL: "));
										DelayCommand(52.0 + IntToFloat(nCreatureCount), SendMessageToPC(oCaster, " "));
										}
									DelayCommand(52.1 + IntToFloat(nCreatureCount), SendMessageToPC(oCaster, "The rest of the auras on " + GetName(oDetected) + " are in inventory."));
								}
							}
						
						sSchool = "";
						sSchool2 = "";
						nAuraPower = 0;
						nAuraPower2 = 0;
				
					}
				}
						
				oDetected = GetNextObjectInShape( SHAPE_SPELLCONE, 10.0, GetSpellTargetLocation(), TRUE, OBJECT_TYPE_ALL );
			}
			
		nAuraPowerHigh = GetLocalInt(oCaster, "nAuraPowerHigh");
		sAuraPowerHigh = GetLocalString(oCaster, "sAuraPowerHigh");
				
		if(nAuraPowerHigh >= 0) {sAuraPowerHigh = "faint";}
		if(nAuraPowerHigh > 3) {sAuraPowerHigh = "moderate";}
		if(nAuraPowerHigh > 6) {sAuraPowerHigh = "strong";}
		if(nAuraPowerHigh > 9) {sAuraPowerHigh = "overwhelming";}
							
		string sAuraCount = "";
		string sS = "";
		if(nAuraCount > 0) {sS = "s";}
		if(nAuraCount < 5) {sAuraCount = IntToString(nAuraCount);} else if(nAuraCount < 8) {sAuraCount = "around half a dozen";} else if(nAuraCount < 13) {sAuraCount = "close to ten";}  else if(nAuraCount < 15) {sAuraCount = "more than a dozen";} else if(nAuraCount < 24) {sAuraCount = "twenty or so";}else if(nAuraCount < 37) {sAuraCount = "dozens of";}else if(nAuraCount >= 37) {sAuraCount = "scores of";}
							
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
		
		if((nAuraCount > 0) && (nConcentration > 13)) {
			float fDelay = 24.0;
			nItemCounted = GetLocalInt(oCaster, "nItemCount");
			//SendMessageToAllDMs("nItemCounted = " + IntToString(nItemCounted));
			if(nItemCounted == 1) {fDelay = 72.0;}
			DelayCommand(19.0, SendMessageToAllDMs("**********"));
			DelayCommand(19.1, SendMessageToAllDMs(GetName(oCaster) + " concentrates for three rounds and learns:"));
			DelayCommand(fDelay, SendMessageToAllDMs("**********"));
			DelayCommand(fDelay + 0.1, SendMessageToAllDMs("That is all you learn."));
				
			DelayCommand(19.0, SendMessageToPC(oCaster, "**********"));
			DelayCommand(19.1, SendMessageToPC(oCaster, "You concentrate for three rounds and learn:"));
			
			DelayCommand(fDelay, SendMessageToPC(oCaster, "**********"));
			DelayCommand(fDelay + 0.1, SendMessageToPC(oCaster, "That is all you learn."));
			
			SetLocalInt(oCaster, "nItemCount", 0);
			}
		else if (nAuraCount > 0){
			DelayCommand(19.0, SendMessageToAllDMs("**********"));
			DelayCommand(19.1, SendMessageToAllDMs(GetName(oCaster) + "'s concentration breaks."));
			DelayCommand(19.0, SendMessageToPC(oCaster, "**********"));
			DelayCommand(19.1, SendMessageToPC(oCaster, "Your concentration breaks."));
			}
		
		if(nAuraCount == 0) {
			DelayCommand(6.0, SendMessageToAllDMs(GetName(oCaster) + " detects 0 auras."));
			DelayCommand(6.0, SendMessageToPC(oCaster, "You detect 0 auras."));
			}	
			
		SetLocalInt(oCaster, "nAuraPowerHigh", 0);
		SetLocalString(oCaster, "sAuraPowerHigh", "");
		}
				
	
	//Dismissal
	if(GetSpellId() == 40) {
		SendMessageToAllDMs("Dismissal");
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
			//SendMessageToPC(oCaster, "nRunningTab discharges to zero: " + IntToString(nRunningTab));
			//SendMessageToPC(oCaster, "You discharge CrystalCon with a wild casting of " + IntToString(nSpell) + " on " + GetName(oTarget));
			SendMessageToAllDMs(GetName(oCaster) + " CrysCon is at " + IntToString(nRunningTab));
			
		}
	
	} 
}

//Arcane Mark
if(GetSpellId() == 3066) {
	object oMarked = GetSpellTargetObject();
	effect eMark = EffectVisualEffect(VFX_HIT_AOE_DIVINATION, FALSE);	
	ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eMark, GetLocation(oMarked), 3.0);
}
 
//Summon Instrument
if(GetSpellId() == 3071) {
	object oScryer = OBJECT_SELF;
	location lTarget = GetLocation(oScryer);
	object oScry = GetFirstObjectInShape(SHAPE_SPHERE, 5.0, lTarget, FALSE, OBJECT_TYPE_PLACEABLE);
	string sPlaceableTag = GetTag(oScry);
		while(oScry != OBJECT_INVALID) {
			sPlaceableTag = GetTag(oScry);
			if(FindSubString(sPlaceableTag, "_SCRY_") != -1) {
				object oFocus = CreateItemOnObject("abr_it_scry_focus", oScryer, 1);
				SetFirstName(oFocus, "Scrying Shard");
				SendMessageToPC(oScryer, "A shard shaped like your instrument of choice shimmers into your hand, out of the " + GetName(oScry) + ", leaving the glass unblemished.");
			 }
			oScry = GetNextObjectInShape(SHAPE_SPHERE, 5.0, lTarget, FALSE, OBJECT_TYPE_PLACEABLE);
			}		
}

// NonDetection
if(GetSpellId() == 3092) {
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
	 
//Create Water
if(GetSpellId() == 3068) {
	object oScryer = OBJECT_SELF;
	int nCasterType = GetLastSpellCastClass();
	object oTarget = GetSpellTargetObject();
	SetLocalInt(oScryer, "nSpellCasterType", nCasterType);
	//SendMessageToAllDMs("Spellhook: nSpellCasterType = " + IntToString(nCasterType));
	object oScry;
	if((GetObjectType(oTarget) != OBJECT_TYPE_PLACEABLE) && (nCasterType == CLASS_TYPE_DRUID)) {
		location lTarget = GetLocation(oScryer);
		oScry = GetFirstObjectInShape(SHAPE_SPHERE, 5.0, lTarget, FALSE, OBJECT_TYPE_TRIGGER);
		string sTriggerTag = GetTag(oScry);
		while(oScry != OBJECT_INVALID) {
			sTriggerTag = GetTag(oScry);
			if(FindSubString(sTriggerTag, "_SCRY_") != -1) {
				object oFocus = CreateItemOnObject("abr_it_scry_focus", oScryer, 1);
				SetLocalInt(oScryer, "abr_scry_trig", 1);
				SetFirstName(oFocus, "Scrying Droplet");
				SendMessageToPC(oScryer, "You call forth a droplet of water vapor, catching it in a vial as it rises from the " + GetName(oScry) + ".");
			    SetItemIcon(oFocus, 1896);
				return;
				}
			oScry = GetNextObjectInShape(SHAPE_SPHERE, 5.0, lTarget, FALSE, OBJECT_TYPE_TRIGGER);
			}
		}
	else if((GetObjectType(oTarget) == OBJECT_TYPE_PLACEABLE) && ((nCasterType == CLASS_TYPE_DRUID) || (nCasterType == CLASS_TYPE_CLERIC)) && (FindSubString(GetTag(oTarget), "_SCRY_") != -1)) 
		{SetLocalInt(oScryer, "abr_scry_trig", 1);}
		
			
	if(GetLocalInt(oScryer, "abr_scry_trig") == 0){
		CreateItemOnObject("abr_it_food_water", oScryer, 1);
		SendMessageToPC(oScryer, "You conjure wholesome, drinkable water into an empty bottle.");
	 	}	
		
	SetLocalInt(oScryer, "abr_scry_trig", 0);
					
}

//Scrying and Greater Scrying
if((GetSpellId() == 3056) || (GetSpellId() == 3057))
	{//Define Scryer and Scrying Object
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
			
						

			
				