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
	
	SendMessageToAllDMs(GetName(GetLastSpellCaster()) + " casting " + IntToString(nSpellId) + " in " + sArea);
	//SendMessageToPC(OBJECT_SELF, GetName(GetLastSpellCaster()) + " casting " + IntToString(nSpellId) + " in " + sArea);
	
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

if(GetSpellId() == 3066) {
	SendMessageToPC(OBJECT_SELF, "Arcane Mark cast on " + GetTag(oTarget));
}

if(GetSpellId() == 3058) {
	SetLocalInt(OBJECT_SELF, "nDetectScrying", 1);
    object oSensor = GetFirstObjectInShape(SHAPE_SPHERE, 40.0, GetLocation(OBJECT_SELF), FALSE, OBJECT_TYPE_CREATURE);
	int nInc = 0;
	while((oSensor != OBJECT_INVALID) && (nInc < 50)) {
	if(FindSubString(GetTag(oSensor), "scry_send") != -1)
		{SendMessageToPC(OBJECT_SELF, "You see a small glowing orb floating in the air.");
		 object oScryer = GetLocalObject(oSensor, "oScryer");
		 string sScryerDesc = GetDescription(oScryer);
		 object oScryerArea = GetArea(oScryer);
		 string sScryerArea = GetName(oScryerArea);
		 int nCasterLevel = GetLocalInt(oSensor, "nCasterLevel");
		 int nCasterRoll = d20(1);
		 int nCasterOpposed = nCasterLevel + nCasterRoll;
		 int nDetectorLevel = GetCasterLevel(OBJECT_SELF);
		 int nDetectorRoll = d20(1);
		 int nDetectorOpposed = nDetectorLevel + nDetectorRoll;
		 if(nDetectorOpposed >= nCasterOpposed) {
		  	SendMessageToPC(OBJECT_SELF, "You feel your Detect Scrying spell best the defences of the person scrying you.");
			SendMessageToPC(OBJECT_SELF, "You get a visual image of the scryer: " + sScryerDesc);
			SendMessageToPC(OBJECT_SELF, "You know that this person is located at the direction and distance of " + sScryerArea );
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

if(GetSpellId() == 3056)
	{//Define Scryer and Scrying Object
	 object oScryer = OBJECT_SELF;
	 object oScry = GetFirstObjectInShape(SHAPE_SPHERE, 3.0, GetLocation(oScryer), TRUE, OBJECT_TYPE_PLACEABLE);
	 while((oScry != OBJECT_INVALID) && (FindSubString(GetTag(oScry), "_SCRY") == -1)) {
	 	  SendMessageToPC(oScryer, "oScry = " + GetTag(oScry));
	 	  oScry = GetNextObjectInShape(SHAPE_SPHERE, 3.0, GetLocation(oScryer), TRUE, OBJECT_TYPE_PLACEABLE);
	   	}
	 if(oScry == OBJECT_INVALID) {
	 	 oScry = GetFirstObjectInShape(SHAPE_SPHERE, 5.0, GetLocation(oScryer), TRUE, OBJECT_TYPE_TRIGGER);
		 while((oScry != OBJECT_INVALID) && (FindSubString(GetTag(oScry), "_SCRY") == -1)) {
		 	   SendMessageToPC(oScryer, "oScry = " + GetTag(oScry));
	 	       oScry = GetNextObjectInShape(SHAPE_SPHERE, 5.0, GetLocation(oScryer), TRUE, OBJECT_TYPE_TRIGGER);
		   	}
	 	}
	 //Usage, range, and class restrictions
	 if(GetLocalInt(oScry, "nScryActive") == 1) {
	 	SendMessageToPC(oScryer, GetName(oScry) + " is already being used as the focus of a Scry spell.");
		}
	 else if(oScry == OBJECT_INVALID) {
		SendMessageToPC(oScryer, "You must be near enough to touch a scrying object for your spell to activate it.");
		}
		
	 else if((GetLastSpellCastClass()== CLASS_TYPE_WIZARD) && (GetResRef(oScry) != "abr_pl_so_mirror") && (GetResRef(oScry) != "tsm_plc_scry_mirror")) {
	 	SendMessageToPC(oScryer, "There is no scrying mirror within range.");
		}
	 else if((GetLastSpellCastClass()== CLASS_TYPE_CLERIC) && ((GetResRef(oScry) != "abr_pl_so_holyfont") || (GetResRef(oScry) != "abr_trg_so_water"))) {
	 	SendMessageToPC(oScryer, "There is no holy font suitable for scrying within range.");
		}
	 else if((GetLastSpellCastClass()== CLASS_TYPE_DRUID) && ((GetResRef(oScry) != "abr_pl_so_pool") || (GetResRef(oScry) != "abr_trg_so_water"))) {
	 	SendMessageToPC(oScryer, "There is no natural pool of water suitable for scrying within range.");
		}
	 else {//Get Scrying Object's location and calculate Scryer's spell DC and spell duration
			string sScryName = GetName(oScry);
			location lHere = GetLocation(oScry);
			int nScryerLevel = GetCasterLevel(oScryer);
	 	 	int nSpellLevel = GetSpellLevel(GetSpellId());
			int nAbilityMod = GetAbilityModifier(ABILITY_INTELLIGENCE);
			if(GetLastSpellCastClass()== CLASS_TYPE_BARD || CLASS_TYPE_SORCERER || CLASS_TYPE_PALADIN) {
				nAbilityMod = GetAbilityModifier(ABILITY_CHARISMA);
				}
			if(GetLastSpellCastClass()== CLASS_TYPE_CLERIC || CLASS_TYPE_DRUID || CLASS_TYPE_RANGER) {
				nAbilityMod = GetAbilityModifier(ABILITY_WISDOM);
				}
			int nDC = 10 + nSpellLevel + nAbilityMod;
			
			//Create undetectable OOC Scrying Listener at location of Scrying Object to receive scrying information about future scrying target
			object oScryListen = GetLocalObject(oScry, "oScryListen");
			if(oScryListen == OBJECT_INVALID) {
				oScryListen = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_scry_listen", lHere);
            	SetLocalObject(oScry, "oScryListen", oScryListen);
				}
			
			//Set all objects on each other
			SetLocalObject(oScryListen, "oScry", oScry);
			SetLocalObject(oScryListen, "oScryer", oScryer);
			SetLocalObject(oScry, "oScryer", oScryer);
			SetLocalObject(oScryer, "oScryListen", oScryListen);
			SetLocalObject(oScryer, "oScry", oScry);
			
			//Set all other variables on ScryListen
			SetLocalInt(oScryListen, "nScryDC", nDC);
			SetLocalInt(oScryListen, "nCasterLevel", nScryerLevel);
			SetLocalFloat(oScryListen, "fScryTimer", 60.0 * nScryerLevel);
			SetFirstName(oScryListen, sScryName);
			
			//Over to ScryListener's onspawn: tsm_scry_npc_onspawn
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
			
						

			
				