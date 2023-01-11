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

    // Do the mapping
    if (fDegrees < HALF_COMPASS_ANGLE || fDegrees > HALF_COMPASS_ANGLE * 31) {
        return "north";
    }
    else if (fDegrees < HALF_COMPASS_ANGLE * 3) {
        return "north-northeast";
    }
    else if (fDegrees < HALF_COMPASS_ANGLE * 5) {
        return "northeast";
    }
    else if (fDegrees < HALF_COMPASS_ANGLE * 7) {
        return "east-northeast";
    }
    else if (fDegrees < HALF_COMPASS_ANGLE * 9) {
        return "east";
    }
    else if (fDegrees < HALF_COMPASS_ANGLE * 11) {
        return "east-southeast";
    }
    else if (fDegrees < HALF_COMPASS_ANGLE * 13) {
        return "southeast";
    }
    else if (fDegrees < HALF_COMPASS_ANGLE * 15) {
        return "south-southeast";
    }
    else if (fDegrees < HALF_COMPASS_ANGLE * 17) {
        return "south";
    }
    else if (fDegrees < HALF_COMPASS_ANGLE * 19) {
        return "south-southwest";
    }
    else if (fDegrees < HALF_COMPASS_ANGLE * 21) {
        return "southwest";
    }
    else if (fDegrees < HALF_COMPASS_ANGLE * 23) {
        return "west-southwest";
    }
    else if (fDegrees < HALF_COMPASS_ANGLE * 25) {
        return "west";
    }
    else if (fDegrees < HALF_COMPASS_ANGLE * 27) {
        return "west-northwest";
    }
    else if (fDegrees < HALF_COMPASS_ANGLE * 29) {
        return "northwest";
    }
    return "north-northwest";
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
    object oCaster = OBJECT_SELF;
    object oStudent = OBJECT_SELF;
    object oItem = GetSpellCastItem();
    object oTarget = GetSpellTargetObject();
	string sTarget = GetName(oTarget);
    location lTarget = GetSpellTargetLocation();
	int nItemType = GetBaseItemType(oItem);
	effect eFailure = EffectSpellFailure(100);
	string sArea = GetTag(GetArea(oCaster));
	effect eSpellFail = EffectSpellFailure(100, SPELL_SCHOOL_GENERAL);
	
	SendMessageToAllDMs(GetName(GetLastSpellCaster()) + " casting " + IntToString(nSpellId) + " in " + sArea + " at " + sTarget);
	//SendMessageToPC(OBJECT_SELF, GetName(GetLastSpellCaster()) + " casting " + IntToString(nSpellId) + " in " + sArea);
	
	//Detect Magic
	if(GetSpellId() == 3004) {
		SendMessageToAllDMs(GetName(GetLastSpellCaster()) + " casting Detect Magic in " + sArea + " at " + sTarget);
		
		object oCaster = OBJECT_SELF;
		int nMetaMagic = GetMetaMagicFeat();
		float fDur = TurnsToSeconds( GetCasterLevel( oCaster ) );
		if ( nMetaMagic == METAMAGIC_EXTEND ) {
			fDur = fDur * 2;
			} 
		else if ( nMetaMagic == METAMAGIC_PERSISTENT ) {
			fDur = HoursToSeconds( 24 );
			}
		
		object oDetected = GetFirstObjectInShape( SHAPE_SPELLCONE, 10.0, GetSpellTargetLocation(), TRUE, OBJECT_TYPE_ALL );
		string sSchool = "";
		int nAuraCount = 0;
		while (GetIsObjectValid(oDetected)) {
			SendMessageToAllDMs(GetName(oDetected) + " detected");
			if((oDetected != oCaster) && ((GetObjectType(oDetected) == OBJECT_TYPE_CREATURE) || (GetObjectType(oDetected) == OBJECT_TYPE_PLACEABLE)  || (GetObjectType(oDetected) == OBJECT_TYPE_ITEM) || (GetObjectType(oDetected) == OBJECT_TYPE_TRIGGER)|| (GetObjectType(oDetected) == OBJECT_TYPE_WAYPOINT))){
				
				if(GetObjectType(oDetected) == OBJECT_TYPE_CREATURE) {
					int nRace = GetRacialType(oDetected);
					string sRace = "";
					if(nRace == 10) {sRace = "Construct"; sSchool = "Transmutation"; nAuraCount++;}
					if(nRace == 16) {sRace = "Elemental"; sSchool = "Conjuration"; nAuraCount++;}
					if(nRace == 17) {sRace = "Fey";  sSchool = "Enchantment"; nAuraCount++;}
					if(nRace == 19) {sRace = "Magical Beast"; sSchool = "Innate"; nAuraCount++;}
					if(nRace == 20) {sRace = "Outsider"; sSchool = "Conjuration"; nAuraCount++;}
					if(nRace == 23) {sRace = "Shapechanger"; sSchool = "Transmutation"; nAuraCount++;}
					if(nRace == 24) {sRace = "Undead"; sSchool = "Necromancy"; nAuraCount++;}
					if(sRace != ""){SendMessageToAllDMs(GetName(oDetected) + " has a racial aura of " + sSchool);}
					}
					
				sSchool = "";
				string sEffectSchool = "";
				if((GetObjectType(oDetected) == OBJECT_TYPE_PLACEABLE) || (GetObjectType(oDetected) == OBJECT_TYPE_TRIGGER)){
					if((GetTag(oDetected) == "ACR_SCRY_OBJECT") || (GetTag(oDetected) == "TSM_PLC_SCRY_MIRROR"))
						{SendMessageToAllDMs("1. " + GetName(oDetected) + " has a Divination aura.");
						}
					}
					
				if(GetObjectType(oDetected) == OBJECT_TYPE_CREATURE) {
					if(GetHasAnySpellEffect(oDetected)) {
						int nEffect = GetEffectSpellId(GetFirstEffect(oDetected)); 
						SendMessageToAllDMs("1. " + GetName(oDetected) + " has effect " + IntToString(nEffect));
						if(nEffect != -1) {
							nAuraCount++;
							sEffectSchool = Get2DAString("spells", "School", nEffect);
							SendMessageToAllDMs(IntToString(nEffect) + " is " + sEffectSchool);
							SendMessageToAllDMs(GetName(oDetected) + " has an aura of " + sEffectSchool);
							}
						else {SendMessageToAllDMs(IntToString(nEffect) + " is not from a spell");}
						
						if(GetIsEffectValid(GetNextEffect(oDetected))) { 
							nAuraCount++;
							nEffect = GetEffectSpellId(GetNextEffect(oDetected)); 
							SendMessageToAllDMs("2. " + GetName(oDetected) + " has effect " + IntToString(nEffect));
							if(nEffect != -1) {
								sEffectSchool = Get2DAString("spells", "School", nEffect);
								SendMessageToAllDMs(IntToString(nEffect) + " is " + sEffectSchool);
								SendMessageToAllDMs(GetName(oDetected) + " has an aura of " + sEffectSchool);
								}
							else {SendMessageToAllDMs(IntToString(nEffect) + " is not from a spell");}
							}
							
						if(GetIsEffectValid(GetNextEffect(oDetected))) { 
							nAuraCount++;
							nEffect = GetEffectSpellId(GetNextEffect(oDetected)); 
							SendMessageToAllDMs("3. " + GetName(oDetected) + " has effect " + IntToString(nEffect));
							if(nEffect != -1) {
								sEffectSchool = Get2DAString("spells", "School", nEffect);
								SendMessageToAllDMs(IntToString(nEffect) + " is " + sEffectSchool);
								SendMessageToAllDMs(GetName(oDetected) + " has an aura of " + sEffectSchool);
								}
							else {SendMessageToAllDMs(IntToString(nEffect) + " is not from a spell");}
							}
							
						if(GetIsEffectValid(GetNextEffect(oDetected))) { 
							nAuraCount++;
							nEffect = GetEffectSpellId(GetNextEffect(oDetected)); 
							SendMessageToAllDMs("4. " + GetName(oDetected) + " has effect " + IntToString(nEffect));
							if(nEffect != -1) {
								sEffectSchool = Get2DAString("spells", "School", nEffect);
								SendMessageToAllDMs(IntToString(nEffect) + " is " + sEffectSchool);
								SendMessageToAllDMs(GetName(oDetected) + " has an aura of " + sEffectSchool);
								}
							else {SendMessageToAllDMs(IntToString(nEffect) + " is not from a spell");}
							}
							
						if(GetIsEffectValid(GetNextEffect(oDetected))) { 
							nAuraCount++;
							nEffect = GetEffectSpellId(GetNextEffect(oDetected)); 
							SendMessageToAllDMs("5. " + GetName(oDetected) + " has effect " + IntToString(nEffect));
							if(nEffect != -1) {
								sEffectSchool = Get2DAString("spells", "School", nEffect);
								SendMessageToAllDMs(IntToString(nEffect) + " is " + sEffectSchool);
								SendMessageToAllDMs(GetName(oDetected) + " has an aura of " + sEffectSchool);
								}
							else {SendMessageToAllDMs(IntToString(nEffect) + " is not from a spell");}
								}
							}
						}
						
						string sSlot = "";
						if((GetObjectType(oDetected) == OBJECT_TYPE_PLACEABLE) || (GetObjectType(oDetected) == OBJECT_TYPE_CREATURE) || (GetObjectType(oDetected) == OBJECT_TYPE_ITEM)){
							if(GetObjectType(oDetected) == OBJECT_TYPE_ITEM) {oItem = oDetected; sSlot = IntToString(FloatToInt(GetDistanceBetween(oCaster, oDetected))) + "meters from " + GetName(oCaster);}
							else {oItem = GetFirstItemInInventory(oDetected);}
							int nSlot = 0;
							int nFirst = 0;
							while ((GetIsObjectValid(oItem)) || (nSlot < 15)) {
								SendMessageToAllDMs("nSlot = " + IntToString(nSlot));
								if(GetObjectType(oDetected) == OBJECT_TYPE_PLACEABLE) {nSlot = 14;}		
								if(nFirst == 0) {nFirst = 1; sSlot = "in the inventory of ";}
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
									nSlot++;
									}
								else {
								oItem = GetNextItemInInventory(oDetected); 
								if(oItem == OBJECT_INVALID) {nSlot++;}
								else {SendMessageToAllDMs("GetNextItemInInventory = " +GetName(oItem)); 
									sSlot = "in the inventory of ";
									}
								}
								
								sSlot = sSlot + " " + GetName(oDetected);
								
								if((GetObjectType(oDetected) == OBJECT_TYPE_PLACEABLE) || (GetObjectType(oDetected) == OBJECT_TYPE_CREATURE)) {
									SendMessageToAllDMs(GetName(oItem) + " is " + sSlot);
									}	
								itemproperty ipItem = GetFirstItemProperty(oItem);
								if(GetIsItemPropertyValid(ipItem)) {
									nAuraCount++;
									int nBaseItem = GetBaseItemType(oItem);
									string sBaseItem = "";
									string sItemName = GetName(oItem);
									string sItemDescription = GetDescription(oItem);
									if(nBaseItem == 19) {sBaseItem = "n Amulet";}
									if(nBaseItem == 16) {sBaseItem = "suit of Armor";}
									if(nBaseItem == 20) {sBaseItem = "quiver of Arrows";}
									if(nBaseItem == 3) {sBaseItem = "Bastard Sword";}
									if(nBaseItem == 2) {sBaseItem = "Battle Axe";}
									if(nBaseItem == 101) {sBaseItem = "Belt";}
									if(nBaseItem == 25) {sBaseItem = "quiver of Bolts";}
									if(nBaseItem == 74) {sBaseItem = "Book";}
									if(nBaseItem == 26) {sBaseItem = "pair of Boots";}
									if(nBaseItem == 78) {sBaseItem = "pair of Bracers";}
									if(nBaseItem == 27) {sBaseItem = "pouch of Bullets";}
									if(nBaseItem == 80) {sBaseItem = "Cloak";}
									if(nBaseItem == 28) {sBaseItem = "Club";}
									if(nBaseItem == 22) {sBaseItem = "Dagger";}
									if(nBaseItem == 31) {sBaseItem = "set of Darts";}
									if(nBaseItem == 33) {sBaseItem = "Double Axe";}
									if(nBaseItem == 128) {sBaseItem = "Drum";}
									if(nBaseItem == 108) {sBaseItem = "Dwarven War Axe";}
									if(nBaseItem == 114) {sBaseItem = "Falchion";}
									if(nBaseItem == 116) {sBaseItem = "Flail";}
									if(nBaseItem == 129) {sBaseItem = "Flute";}
									if(nBaseItem == 77) {sBaseItem = "Gem";}
									if(nBaseItem == 36) {sBaseItem = "pair of Gloves";}
									if(nBaseItem == 18) {sBaseItem = "Great Axe";}
									if(nBaseItem == 120) {sBaseItem = "Great Club";}
									if(nBaseItem == 13) {sBaseItem = "Great Sword";}
									if(nBaseItem == 81) {sBaseItem = "Grenade";}
									if(nBaseItem == 10) {sBaseItem = "Halberd";}
									if(nBaseItem == 38) {sBaseItem = "Hand Axe";}
									if(nBaseItem == 6) {sBaseItem = "Heavy Crossbow";}
									if(nBaseItem == 35) {sBaseItem = "Heavy Flail";}
									if(nBaseItem == 17) {sBaseItem = "Helmet or Hat";}
									if(nBaseItem == 40) {sBaseItem = "Kama";}
									if(nBaseItem == 41) {sBaseItem = "Katana";}
									if(nBaseItem == 65) {sBaseItem = "Key";}
									if(nBaseItem == 42) {sBaseItem = "Kukri";}
									if(nBaseItem == 66) {sBaseItem = "Large Box";}
									if(nBaseItem == 56) {sBaseItem = "Large Shield";}
									if(nBaseItem == 7) {sBaseItem = "Light Crossbow";}
									if(nBaseItem == 4) {sBaseItem = "Light Flail";}
									if(nBaseItem == 37) {sBaseItem = "Light Hammer";}
									if(nBaseItem == 9) {sBaseItem = "Light Mace";}
									if(nBaseItem == 1) {sBaseItem = "Longsword";}
									if(nBaseItem == 8) {sBaseItem = "Longbow";}
									if(nBaseItem == 113) {sBaseItem = "Mace";}
									if(nBaseItem == 44) {sBaseItem = "Magic Rod";}
									if(nBaseItem == 45) {sBaseItem = "Magic Staff";}
									if(nBaseItem == 46) {sBaseItem = "Magic Wand";}
									if(nBaseItem == 34) {sBaseItem = "Large Item";}
									if(nBaseItem == 29) {sBaseItem = "Medium Item";}
									if(nBaseItem == 24) {sBaseItem = "Small Item";}
									if(nBaseItem == 43) {sBaseItem = "Tall Item";}
									if(nBaseItem == 79) {sBaseItem = "Thin Item";}
									if(nBaseItem == 68) {sBaseItem = "Wide Item";}
									if(nBaseItem == 47) {sBaseItem = "Morningstar";}
									if(nBaseItem == 49) {sBaseItem = "Magic Potion";}
									if(nBaseItem == 50) {sBaseItem = "Quarterstaff";}
									if(nBaseItem == 51) {sBaseItem = "Rapier";}
									if(nBaseItem == 52) {sBaseItem = "Ring";}
									if(nBaseItem == 53) {sBaseItem = "Scimitar";}
									if(nBaseItem == 54) {sBaseItem = "Magic Scroll";
										if(FindSubString(sItemDescription, "Abjuration") != -1) {sSchool = "Abjuration";}
										if(FindSubString(sItemDescription, "Conjuration") != -1) {sSchool = "Conjuration";}
										if(FindSubString(sItemDescription, "Divination") != -1) {sSchool = "Divination";}
										if(FindSubString(sItemDescription, "Enchantment") != -1) {sSchool = "Enchantment";}
										if(FindSubString(sItemDescription, "Evocation") != -1) {sSchool = "Evocation";}
										if(FindSubString(sItemDescription, "Illusion") != -1) {sSchool = "Illusion";}
										if(FindSubString(sItemDescription, "Necromancy") != -1) {sSchool = "Necromancy";}
										if(FindSubString(sItemDescription, "Transmutation") != -1) {sSchool = "Transmutation";}
										}
									if(nBaseItem == 55) {sBaseItem = "Scythe";}
									if(nBaseItem == 11) {sBaseItem = "Short Bow";}
									if(nBaseItem == 58) {sBaseItem = "Short Spear";}
									if(nBaseItem == 0) {sBaseItem = "Shortsword";}
									if(nBaseItem == 59) {sBaseItem = "set of Shuriken";}
									if(nBaseItem == 60) {sBaseItem = "Sickle";}
									if(nBaseItem == 61) {sBaseItem = "Sling";}
									if(nBaseItem == 14) {sBaseItem = "Small Shield";}
									if(nBaseItem == 119) {sBaseItem = "Spear";}
									if(nBaseItem == 63) {sBaseItem = "set of Throwing Axes";}
									if(nBaseItem == 57) {sBaseItem = "Tower Shield";}
									if(nBaseItem == 5) {sBaseItem = "War Hammer";}
									if(nBaseItem == 126) {sBaseItem = "War Mace";}
									if(nBaseItem == 111) {sBaseItem = "Whip";}
									
									while (GetIsItemPropertyValid(ipItem)) {
										int nItemProperty = GetItemPropertyType(ipItem);
										string sItemProperty = "";
										int nItemSubType = GetItemPropertySubType(ipItem);
										string sItemSubType = IntToString(nItemSubType);
										string sSpellIndex = "";
										string sSchool = "";
										if(nItemProperty == 0) {sItemProperty = "Ability Bonus"; sSchool = "Transmutation";}
										if((nItemProperty >= 1) && (nItemProperty <=5)) {sItemProperty = "AC Bonus"; sSchool = "Abjuration";}
										if((nItemProperty >= 56) && (nItemProperty <=59)) {sItemProperty = "Attack Bonus"; sSchool = "Evocation";}
										if(nItemProperty == 12) {sItemProperty = "Bonus Feat"; sSchool = "Transmutation";}
										if(nItemProperty == 66) {sItemProperty = "Bonus HP"; sSchool = "Transmutation";}
										if(nItemProperty == 13) {sItemProperty = "Bonus Spell Slot"; sSchool = "Transmutation";}
										if(nItemProperty == 15) {
											sItemProperty = "Cast Spell";
											sSpellIndex = Get2DAString("iprp_spells", "SpellIndex", nItemSubType); 
											sSchool = Get2DAString("spells", "School", StringToInt(sSpellIndex));
											SendMessageToAllDMs("sSchool = " + sSchool);}
										if((nItemProperty >= 16) && (nItemProperty <=19)) {sItemProperty = "Damage Bonus"; sSchool = "Evocation";}
										if(nItemProperty == 90) {sItemProperty = "Damage Reduction"; sSchool = "Transmutation";}
										if(nItemProperty == 23) {sItemProperty = "Damage Resistance"; sSchool = "Abjuration";}
										if(nItemProperty == 24) {sItemProperty = "Damage Vulnerability"; sSchool = "Transmutation";}
										if(nItemProperty == 26) {sItemProperty = "Darkvision"; sSchool = "Transmutation";}
										if(nItemProperty == 27) {sItemProperty = "Decreased Ability"; sSchool = "Transmutation";}
										if(nItemProperty == 28) {sItemProperty = "Decreased AC"; sSchool = "Transmutation";}
										if(nItemProperty == 29) {sItemProperty = "Decreased Skill"; sSchool = "Transmutation";}
										if(nItemProperty == 10) {sItemProperty = "Decreased Enhancement Modifier"; sSchool = "Transmutation";}
										if(nItemProperty == 60) {sItemProperty = "Decreased Attack Modifier"; sSchool = "Transmutation";}
										if(nItemProperty == 21) {sItemProperty = "Decreased Damage"; sSchool = "Transmutation";}
										if(nItemProperty == 49) {sItemProperty = "Decreased Saving Throw"; sSchool = "Transmutation";}
										if((nItemProperty >= 6) && (nItemProperty <=9)) {sItemProperty = "Enhancement Bonus"; sSchool = "Evocation";}
										if((nItemProperty >= 33) && (nItemProperty <=34)) {sItemProperty = "Extra Damage"; sSchool = "Evocation";}
										if(nItemProperty == 75) {sItemProperty = "Freedom of Movement"; sSchool = "Transmutation";}
										if(nItemProperty == 35) {sItemProperty = "Haste"; sSchool = "Transmutation";}
										if(nItemProperty == 20) {sItemProperty = "Immunity Damage Type"; sSchool = "Abjuration";}
										if(nItemProperty == 37) {sItemProperty = "Immunity Misc"; sSchool = "Abjuration";}
										if((nItemProperty >= 53) && (nItemProperty <=54)) {sItemProperty = "Immunity Spell/s"; sSchool = "Abjuration";}
										if(nItemProperty == 78) {sItemProperty = "Immunity Spell Level"; sSchool = "Abjuration";}
										if(nItemProperty == 38) {sItemProperty = "Improved Evasion"; sSchool = "Transmutation";}
										if(nItemProperty == 44) {sItemProperty = "Light"; sSchool = "Evocation";}
										if(nItemProperty == 82) {
											sItemProperty = "On Hit Cast Spell";
											sSpellIndex = Get2DAString("iprp_spells", "SpellIndex", nItemSubType); 
											sSchool = Get2DAString("spells", "School", StringToInt(sSpellIndex));
											SendMessageToAllDMs("sSchool = " + sSchool);}
										if(nItemProperty == 51) {sItemProperty = "Regeneration"; sSchool = "Transmutation";}
										if((nItemProperty >= 40) && (nItemProperty <=41)) {sItemProperty = "Saving Throw Bonus"; sSchool = "Transmutation";}
										if(nItemProperty == 52) {sItemProperty = "Skill Bonus"; sSchool = "Transmutation";}
										if(nItemProperty == 39) {sItemProperty = "Spell Resistance"; sSchool = "Abjuration";}
										if(nItemProperty == 71) {sItemProperty = "True Seeing"; sSchool = "Transmutation";}
										if(sSchool == "A") {sSchool = "Abjuration";}
										if(sSchool == "C") {sSchool = "Conjuration";}
										if(sSchool == "D") {sSchool = "Divination";}
										if(sSchool == "E") {sSchool = "Enchantment";}
										if(sSchool == "I") {sSchool = "Illusion";}
										if(sSchool == "N") {sSchool = "Necromancy";}
										if(sSchool == "T") {sSchool = "Transmutation";}
										if(sSchool == "V") {sSchool = "Evocation";}
										if(sSchool == "G") {sSchool = "General";}
										if(sItemProperty != "") {
											SendMessageToAllDMs(GetName(oItem) + " has sItemProperty " + sItemProperty + " which is " + sSchool + ". The sItemSubType is " + sItemSubType  + " which is " + sSchool ); 
											SendMessageToAllDMs(GetName(oItem) + ", a " + sBaseItem + ", gives off an aura of " + sSchool + " " + sSlot );
											}
										ipItem = GetNextItemProperty(oItem);
										}
								}
							}
						if(GetObjectType(oDetected) == OBJECT_TYPE_ITEM) {break;}
						else if((nSlot >= 0) && (nFirst = 1)) {oItem = GetItemInSlot(nSlot, oDetected);}	
						}
						
						if(GetObjectType(oDetected) == OBJECT_TYPE_TRIGGER) {
							if((FindSubString(GetTag(oDetected), "trg_glyph") != -1) || (FindSubString(GetTag(oDetected), "trg_symbol") != -1)) {
								if(FindSubString(GetTag(oDetected), "trg_glyph") != -1) {sSchool = "Abjuration";}
								if((GetTag(oDetected) == "trg_symbol_fear") || (GetTag(oDetected) == "trg_symbol_pers") || (GetTag(oDetected) == "trg_symbol_sleep") || (GetTag(oDetected) == "trg_symbol_stun")) {sSchool = "Enchantment";}
								if((GetTag(oDetected) == "trg_symbol_weakness") || (GetTag(oDetected) == "trg_symbol_pain") || (GetTag(oDetected) == "trg_symbol_death")) {sSchool = "Necromancy";}
								
								
							SendMessageToAllDMs("Trigger " + GetName(oDetected) + " gives off an aura of " + sSchool + ".");
							}
						}
						
						if(GetObjectType(oDetected) == OBJECT_TYPE_WAYPOINT) {
							if(FindSubString(GetTag(oDetected), "trap_spell") != -1) {
								sSchool = "";
								int nSpellID = GetLocalInt(oDetected, "ACR_TRAP_SPELL_ID");
								sSchool = Get2DAString("spells", "School", nSpellID);
								SendMessageToAllDMs("Trap " + GetName(oDetected) + " gives off an aura of " + sSchool + ".");
								}
							}
						
					}
				oDetected = GetNextObjectInShape( SHAPE_SPELLCONE, 10.0, GetSpellTargetLocation(), TRUE, OBJECT_TYPE_ALL );
			
			}	
		SendMessageToAllDMs("Aura count is " + IntToString(nAuraCount));			
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
			
						

			
				