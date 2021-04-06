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
    location lTarget = GetSpellTargetLocation();
	int nItemType = GetBaseItemType(oItem);
	effect eFailure = EffectSpellFailure(100);
	string sArea = GetTag(GetArea(oCaster));
	
//Campaign consequences for DeanSphinx 2021

object oOlivusCast;
if(FindSubString(GetName(oCaster), "Olivu") != -1)
	{oOlivusCast = oCaster;}
object oJhessiCast;
if(FindSubString(GetName(oCaster), "Jhess") != -1)
	{oJhessiCast = oCaster;}

object oOlivusTarget;
if(FindSubString(GetName(oTarget), "Olivu") != -1)
	{oOlivusTarget = oTarget;}
object oJhessiTarget;
if(FindSubString(GetName(oTarget), "Jhess") != -1)
	{oJhessiTarget = oTarget;}

if((oCaster == oOlivusCast) || (oCaster == oJhessiCast) || (oTarget == oOlivusTarget) || (oTarget == oJhessiTarget)) {	
	int nSpellcraft = GetSkillRank(SKILL_SPELLCRAFT, oCaster);
	int nFail = Random(5);
	int nSpellLevel = GetSpellLevel(nSpellId);
	int nDC = d20(1) + nSpellcraft;
	int nRunningTab = GetCampaignInt("DeanSphinx", "CrystalCharge", oCaster);
	if((nRunningTab < 5) && ((oCaster == oOlivusCast) || (oCaster == oJhessiCast))) {
		if(nFail == 1) {
		SetModuleOverrideSpellScriptFinished();
		SendMessageToPC(oCaster, "Your spell fizzles. You feel the arcane power of the Weave dissipate as if spent, but without apparent effect.");
		nRunningTab = nRunningTab + nSpellLevel;
		SetCampaignInt("DeanSphinx", "CrystalCharge", nRunningTab, oCaster);			
		nRunningTab = GetCampaignInt("DeanSphinx", "CrystalCharge", oCaster);
		SendMessageToPC(oCaster, GetName(oCaster) + " charges to CrystalCon " + IntToString(nRunningTab));
		SendMessageToAllDMs(GetName(oCaster) + " charges to CrystalCon " + IntToString(nRunningTab));
		}
	if(nRunningTab >= 5) {
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
			int nSpell;
			
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
					nSpellThree = 3168;
					nSpellFour = SPELL_WEB;
					nSpellFive = 3182;
					nSpellSix = SPELL_SUMMON_CREATURE_II;
					nSpellSeven = SPELL_MELFS_ACID_ARROW;
					nSpellEight = 3168;
					nSpellNine = SPELL_WEB;
					nSpellTen = 3182;
					}	
				else if(nSpellLevel==3) {
					nSpellOne = SPELL_FLAME_ARROW;
					nSpellTwo = SPELL_STINKING_CLOUD;
					nSpellThree = SPELL_IMPROVED_MAGE_ARMOR;
					nSpellFour = SPELL_MESTILS_ACID_BREATH;
					nSpellFive = SPELL_SUMMON_CREATURE_III;
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
		
			AssignCommand(oCaster, ActionCastSpellAtObject(nSpell, oTarget, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
			nRunningTab = 0;
			SetCampaignInt("DeanSphinx", "CrystalCharge", nRunningTab, oCaster);			
			nRunningTab = GetCampaignInt("DeanSphinx", "CrystalCharge", oCaster);
			SendMessageToPC(oCaster, GetName(oCaster) + " charges to CrystalCon " + IntToString(nRunningTab));
			SendMessageToAllDMs(GetName(oCaster) + " charges to CrystalCon " + IntToString(nRunningTab));
			
			}
		}
	
	} 
}


if((FindSubString(GetTag(GetArea(oCaster)), "5f_") != -1) || (FindSubString(GetTag(GetArea(oCaster)), "5h_") != -1)|| (FindSubString(GetTag(GetArea(oCaster)), "6f_") != -1) || ((FindSubString(GetTag(GetArea(oCaster)), "5g_") != -1) && (FindSubString(GetTag(GetArea(oCaster)), "felbarr") == -1))  )
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
			
						

			
				