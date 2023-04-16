////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ACR Configuration File
//     Filename : acf_cr_onperception_tworcsc
//    $Revision:: 280        $ current version of the file
//        $Date:: 2023-04-10#$ date the file was created or modified
//       Author : Wynna
//
//    Var Prefix:
//  Dependencies:
//
//  Description
//  This script calls the ACR's OnPerception event handler for a twisted orc subchief's
//	script sequence. It is not updated in ACR updates.
//
//  Revision History
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#include "acr_trigger_i"
#include "acr_creature_i"

////////////////////////////////////////////////////////////////////////////////
// Constants ///////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Structures //////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Global Variables ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Function Prototypes /////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
void ActionCreateWynCreature(string sCreature, location lLocCreature)
{
    CreateObject(OBJECT_TYPE_CREATURE, sCreature, lLocCreature);
}
void ActionCreateWynEffect(string sEffect, location lLocEffect)
{
    CreateObject(OBJECT_TYPE_PLACED_EFFECT, sEffect, lLocEffect);
}
void ActionCreateWynPlaceable(string sPlaceable, location lLocPlaceable)
{
    CreateObject(OBJECT_TYPE_PLACEABLE, sPlaceable, lLocPlaceable);
}
////////////////////////////////////////////////////////////////////////////////
// Function Definitions ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

void main()
{
    ACR_TriggerOnEnter();

    object oEntered = GetEnteringObject();
	effect eDeath = EffectDeath(TRUE, TRUE, TRUE, FALSE);
	object oLieDown = GetObjectByTag("abr_cr_hu_orc_twist_fs", 0);
	object oLieDownB = GetObjectByTag("abr_cr_hu_orc_twist_fsB", 0);
	effect eQuake = EffectVisualEffect(VFX_SPELL_HIT_EARTHQUAKE, FALSE);
	effect eShake = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE, FALSE);
	effect eParalyze = EffectCutsceneParalyze();
		 
	effect eKnockdown = EffectKnockdown();
	
	object oSayen = GetNearestObjectByTag("003_cr_invis_caster", OBJECT_SELF, 1);
			if(oSayen == OBJECT_INVALID) {
				oSayen = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_invis_caster", GetLocation(OBJECT_SELF));
				SetFirstName(oSayen, "Gyasi");
				SetLastName(oSayen, "Sayen");
				DestroyObject(oSayen, 30.0);
				}
			
	if((GetIsPC(oEntered)) || (GetIsDMPossessed(oEntered))) {
		if(GetLocalString(OBJECT_SELF, GetName(oEntered)) != GetName(oEntered)) {
			SetLocalString(OBJECT_SELF, GetName(oEntered), GetName(oEntered));
			ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eShake, oEntered, 20.0);
			ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eQuake, oEntered, 20.0);
			if(ReflexSave(oEntered, 20, SAVING_THROW_TYPE_DIVINE, oSayen) == 0) {
				ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnockdown, oEntered, 20.0);
				}		 
			}
			
		if(GetTag(OBJECT_SELF) == "tsm_trg_onenter_script_a") {
			object oSpeared = GetObjectByTag("003_cr_twisted_hang", 0);
			AssignCommand(oSpeared, ActionSpeakString("*Raises head and smiles beneath bloody tusks.* De...khan...thar.... *Rams body forward onto the sword.", TALKVOLUME_TALK));
			DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oSpeared));
			ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnockdown, oLieDown, 60000.0);
			ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnockdown, oLieDownB, 60000.0);
			ApplyEffectToObject(DURATION_TYPE_PERMANENT, eParalyze, oLieDown);
  			ApplyEffectToObject(DURATION_TYPE_PERMANENT, eParalyze, oLieDownB);
  			}
			
		if(GetTag(OBJECT_SELF) == "tsm_trg_onenter_script_b") {
			object oDedicated = GetObjectByTag("abr_cr_hu_orc_twist_fs", 0);
			AssignCommand(oDedicated, ActionSpeakString("*Rolls over and reveals a scroll beneath its body.*", TALKVOLUME_TALK));
			AssignCommand(oDedicated, ActionSpeakString("*Orcish* I die for the god of Deckon Thar!", TALKVOLUME_TALK));
			DelayCommand(2.0, AssignCommand(oDedicated, ActionCastSpellAtObject(SPELL_FLAME_STRIKE, oDedicated, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
			ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnockdown, oLieDown, 60000.0);
			ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnockdown, oLieDownB, 60000.0);
			}
		
		if(GetTag(OBJECT_SELF) == "tsm_trg_onenter_script_d") {
			object oSafety = GetObjectByTag("trap_wp_custom_safety", 0);
			object oAxes = GetObjectByTag("003_trap_custom_axe_major_plc", 0);
			
			
			ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnockdown, oLieDown, 60000.0);
			ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnockdown, oLieDownB, 60000.0);
			}
		
		
		if(GetTag(OBJECT_SELF) == "tsm_trg_onenter_script_c") {
			object oCrystal = GetObjectByTag("rauvin_crystal_black", 0);
			effect eBeamblack = EffectBeam(VFX_BEAM_NECROMANCY, oCrystal, BODY_NODE_CHEST, FALSE);
			string sList = ACR_GetSpellList(oEntered, 1);
			SendMessageToAllDMs(sList);
			DelayCommand(1.0, AssignCommand(oCrystal, ActionCastSpellAtObject(SPELL_DISPEL_MAGIC, oEntered, METAMAGIC_EMPOWER, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
			if((GetLocalInt(oEntered, "MJSaved") != 1) && (FindSubString(sList, "Protection from Evil") == -1)) {
				if(WillSave(oEntered, 18, SAVING_THROW_TYPE_SPELL, oSayen)==0) {
					SendMessageToPC(oEntered, "An overwhelming dizziness strikes you. Your thoughts teeter on the edge of an abyss...and then you are falling into that abyss, feeling your soul pushed out of your physical being by a malevolent force.");
					DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamblack, oEntered, 10.0));
					object oEvilMe = CopyObject(oEntered, GetLocation(oEntered), OBJECT_INVALID);
					int nGold = GetGold(oEvilMe);
					ChangeToStandardFaction(oEvilMe, STANDARD_FACTION_HOSTILE);
					TakeGoldFromCreature(nGold, oEvilMe, TRUE, FALSE);
					SendMessageToAllDMs(GetName(oEntered) + " has been possessed by Magic Jar in " + GetName(GetArea(oEntered)));
					object oInventory = GetFirstItemInInventory(oEvilMe);
					while (oInventory != OBJECT_INVALID) {
						SetDroppableFlag(oInventory, FALSE);
						oInventory = GetNextItemInInventory(oEvilMe);
						}
					int nEquipped = 0;
					while (nEquipped <18) {
						object oEquipped = GetItemInSlot(nEquipped, oEvilMe);
						SetDroppableFlag(oEquipped, FALSE);
						nEquipped++;
						}
					object oMagicJar = GetWaypointByTag("abr_wp_magic_jar");	
					DelayCommand(2.0, AssignCommand(oEntered, ActionJumpToObject(oMagicJar)));
					DelayCommand(6.0, AssignCommand(oEvilMe, SpeakString("*Mulhorandi* This vessel shall serve.", TALKVOLUME_TALK)));
					DelayCommand(12.0, AssignCommand(oEvilMe, ActionAttack(GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, OBJECT_SELF))));
					}
						
				else {
					SendMessageToPC(oEntered, "An overwhelming dizziness strikes you. Your thoughts teeter on the edge of an abyss...and then pull away. Your knees buckle, and you fall, but with a sense that this is the *better* result rather than what *could* have happened.");
					ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnockdown, oEntered, 6.0);
					SetLocalInt(oEntered, "MJSaved", 1) ;
					}
				}
			else {SendMessageToPC(oEntered, "You feel something evil and empty tugging at your soul, but your willpower and wards fend it off.");SetLocalInt(oEntered, "MJSaved", 1) ;}
				
			
						
			if(GetLocalInt(OBJECT_SELF, "Fired") != 1) {
				SetLocalInt(OBJECT_SELF, "Fired", 1);
				object oDoor = GetObjectByTag("rr_door_target_wp", 0);
				object oPortalA = GetObjectByTag("fx_portal_gen_small_a", 0);
				object oPortalB = GetObjectByTag("fx_portal_gen_small_b", 0);
				object oPortalC = GetObjectByTag("fx_portal_gen_small_c", 0);
				object oPortalD = GetObjectByTag("fx_portal_gen_small_d", 0);
				object oCrystalA = GetObjectByTag("rauvin_crystal_relay_green_a", 0);
				object oCrystalB = GetObjectByTag("rauvin_crystal_relay_green_b", 0);
				object oCrystalC = GetObjectByTag("rauvin_crystal_relay_green_c", 0);
				object oCrystalD = GetObjectByTag("rauvin_crystal_relay_green_d", 0);
				object oTworcAnkh = CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_hu_orc_hieroq", GetLocation(oPortalA));	   
				object oTworcCobra = CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_hu_orc_hiero2",  GetLocation(oPortalB));	   
				object oTworcPriest = CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_hu_orc_hiero4",  GetLocation(oPortalC));	   
				object oTworcSphinx = CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_hu_orc_hieron",  GetLocation(oPortalD));	   
				effect eBeamblack = EffectBeam(VFX_BEAM_NECROMANCY, oCrystal, BODY_NODE_CHEST, FALSE);
				effect eBeamblackA = EffectBeam(VFX_BEAM_NECROMANCY, oCrystalA, BODY_NODE_CHEST, FALSE);
				effect eBeamblackB = EffectBeam(VFX_BEAM_NECROMANCY, oCrystalB, BODY_NODE_CHEST, FALSE);
				effect eBeamblackC = EffectBeam(VFX_BEAM_NECROMANCY, oCrystalC, BODY_NODE_CHEST, FALSE);
				effect eBeamblackD = EffectBeam(VFX_BEAM_NECROMANCY, oCrystalD, BODY_NODE_CHEST, FALSE);
				effect eAOE = EffectAreaOfEffect(AOE_PER_WALLBLADE);
				effect eRise = EffectVisualEffect(VFX_FNF_SUMMON_EPIC_UNDEAD, FALSE);
				ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRise, oCrystalA, 5.0);
				ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRise, oCrystalB, 5.0);
				ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRise, oCrystalC, 5.0);
				ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRise, oCrystalD, 5.0);
				DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamblackA, oCrystalB, 600.0));
				DelayCommand(2.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamblackA, oCrystalC, 600.0));
				DelayCommand(3.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamblackB, oCrystalD, 600.0));
				DelayCommand(4.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamblackC, oCrystalA, 600.0));
				AssignCommand(oTworcAnkh, ClearAllActions(TRUE));
				AssignCommand(oTworcCobra, ClearAllActions(TRUE));
				AssignCommand(oTworcPriest, ClearAllActions(TRUE));
				AssignCommand(oTworcSphinx, ClearAllActions(TRUE));
				DelayCommand(1.0, AssignCommand(oTworcAnkh, ActionSpeakString("De-Khan Thar!", TALKVOLUME_TALK)));
				DelayCommand(2.0, AssignCommand(oTworcPriest, ActionSpeakString("*Orcish* Return the Khan's property!", TALKVOLUME_TALK)));
				DelayCommand(3.0, AssignCommand(oTworcCobra, ActionSpeakString("*Orcish* There they are! As the Khan foretold!", TALKVOLUME_TALK)));
				DelayCommand(4.0, AssignCommand(oTworcSphinx, ActionSpeakString("*Orcish* Freed from enslavement by the Khan!", TALKVOLUME_TALK)));
				DelayCommand(12.0, AssignCommand(oCrystal, ActionCastSpellAtObject(SPELL_BLADE_BARRIER_WALL, oDoor, METAMAGIC_EMPOWER, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
				DelayCommand(18.0, AssignCommand(oCrystal, ActionCastSpellAtObject(SPELL_BLADE_BARRIER_WALL, oCrystalA, METAMAGIC_EMPOWER, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
				DelayCommand(24.0, AssignCommand(oCrystal, ActionCastSpellAtObject(SPELL_BLADE_BARRIER_WALL, oCrystalB, METAMAGIC_EMPOWER, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
				DelayCommand(30.0, AssignCommand(oCrystal, ActionCastSpellAtObject(SPELL_BLADE_BARRIER_WALL, oCrystalC, METAMAGIC_EMPOWER, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
				DelayCommand(36.0, AssignCommand(oCrystal, ActionCastSpellAtObject(SPELL_BLADE_BARRIER_WALL, oCrystalD, METAMAGIC_EMPOWER, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
			}
		}
	}
}