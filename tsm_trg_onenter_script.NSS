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
//  This script calls the ACR's onenter event handler for a 
//	script sequence. It is not updated in ACR updates.
//
//  Revision History
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#include "acr_trigger_i"

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
	object oPhaedra = GetObjectByTag("003_cr_bane_bp_elthonds", 0);
	object oCrystal = GetObjectByTag("rr_crystal_green_door", 0);
	effect eBeamGreen = EffectBeam(VFX_BEAM_GREEN_DRAGON_ACID, oCrystal, BODY_NODE_CHEST, FALSE);
	effect eHowl = EffectVisualEffect(VFX_FNF_HOWL_MIND, FALSE);
	effect eQuake = EffectVisualEffect(VFX_SPELL_HIT_EARTHQUAKE, FALSE);
	effect eShake = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE, FALSE);
	effect eSummonGreen = EffectVisualEffect(VFX_DUR_ENTANGLE, FALSE);
	object oOrc = GetWaypointByTag("rr_ext_orc_spawn");
	object oGS = GetWaypointByTag("rr_ext_gs_spawn");
	object oXav = GetWaypointByTag("rr_ext_xav_spawn");
	effect eFreeze = EffectCutsceneParalyze();
	effect eKnockdown = EffectKnockdown();
	effect eDeath = EffectDeath(TRUE, TRUE, TRUE, TRUE);
	effect eFear = EffectFrightened();
	
	//SendMessageToAllDMs(GetName(oEntered) + " entered" + GetName(OBJECT_SELF));
	if ((GetIsPC(oEntered)) || (GetIsDMPossessed(oEntered))) {
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eShake, oEntered, 20.0);
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eQuake, oEntered, 20.0);
		if(ReflexSave(oEntered, 20, SAVING_THROW_TYPE_DIVINE, oCrystal) == 0) {
			ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnockdown, oEntered, 20.0);
			}
		
				 
		if(GetLocalInt(OBJECT_SELF, "Fired") == 0) {
			SendMessageToAllDMs(GetName(OBJECT_SELF) + " firing.");
			SetLocalInt(OBJECT_SELF, "Fired", 1);
			object oHin = GetFirstPC();
			while(oHin != OBJECT_INVALID) {
			if(GetHitDice(oHin) < 5) {
				ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFear, oHin, 30.0);
				SendMessageToPC(oHin, "You are frightened! You turn and run.");
				object oRunAway = GetWaypointByTag("Run_Away");
				AssignCommand(oHin, ActionForceMoveToObject(oRunAway, TRUE, 5.0));
				}
			oHin = GetNextPC();
			}
			object oSayen = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_slv_gyasisayen", GetLocation(oGS));
			 ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFreeze, oSayen, 30.0);
			 SetFirstName(oCrystal, "Gyasi Sayen,");
			 SetLastName(oCrystal, "Lich");
			 DelayCommand(3.0, AssignCommand(oCrystal, ActionSpeakString("I WAS GYASI SAYEN. ALL...ALL IS LOST. ALL IS DEATH.", TALKVOLUME_TALK)));
			 DelayCommand(6.0, ActionCreateWynCreature("abr_cr_hu_orc_hieroq", GetLocation(oOrc)));	   
			 DelayCommand(7.0, ActionCreateWynCreature("abr_cr_hu_orc_hiero2",  GetLocation(oOrc)));	   
			 DelayCommand(7.0, ActionCreateWynCreature("abr_cr_hu_orc_twisted",  GetLocation(oOrc)));	   
			 DelayCommand(7.0, ActionCreateWynCreature("abr_cr_hu_orc_twisted",  GetLocation(oOrc)));	   
			 DelayCommand(6.0, SetFirstName(oCrystal, "Twisted Orc,"));
			 DelayCommand(6.0, SetLastName(oCrystal, "Subchief"));
			 DelayCommand(8.0, AssignCommand(oCrystal, ActionSpeakString("De-Khan Thar!", TALKVOLUME_TALK)));
			 DelayCommand(10.0, AssignCommand(oCrystal, ActionSpeakString("*Orcish* The Khan commands us!", TALKVOLUME_TALK)));
			 DelayCommand(12.0, AssignCommand(oCrystal, ActionSpeakString("*Orcish* We die for you, great lord Khan!", TALKVOLUME_TALK)));
			 DelayCommand(14.0, AssignCommand(oCrystal, ActionSpeakString("De-Khan Thar!", TALKVOLUME_TALK)));
			 DelayCommand(15.0, SetFirstName(oCrystal, "Gyasi Sayen,"));
			 DelayCommand(15.0, SetLastName(oCrystal, "Lich"));
			 
			 DelayCommand(16.0, AssignCommand(oCrystal, ActionSpeakString("You are reborn in crystal. I will have what is mine. The rest belongs to SET!", TALKVOLUME_TALK)));
			 DelayCommand(17.0, ActionCreateWynEffect("tsm_afx_black_fog_large", GetLocation(oCrystal)));
			 DelayCommand(24.0, AssignCommand(oCrystal, ActionSpeakString("*A green light flares then gradually fades, darkening, darkening, until it is sucking light from the surroundings instead of illuminating.", TALKVOLUME_TALK)));
			 DelayCommand(24.0, ActionCreateWynPlaceable("abr_plc_crystal_dm_blc", GetLocation(oCrystal)));
			 DestroyObject(oCrystal, 25.0);
			 
			 //DelayCommand(26.0, ActionCreateWynCreature("003_cr_firegen_xavier", GetLocation(oXav)));	   
			 //DelayCommand(40.0, AssignCommand(oCrystal, ActionSpeakString("Giggling INFIDEL! Run from me! *Vanishes", TALKVOLUME_TALK)));
			 
			 DestroyObject(oSayen, 26.0);
			 
			 object oPC = GetFirstPC(TRUE);
			object oJhessi = GetObjectByTag("003_pc_jhessi_2", 0);
			object oNio = GetObjectByTag("003_pc_nioniel_2", 0);;
			object oSaerela = GetObjectByTag("003_pc_saerela_2", 0);
			object oBertilak = GetObjectByTag("003_pc_bertilak_2", 0);
			object oBellie = GetObjectByTag("003_pc_bellie_2", 0);
			object oBae = GetObjectByTag("003_pc_baeithra_2", 0);
			object oZova = GetObjectByTag("003_pc_zova", 0);
			object oRiki = GetObjectByTag("003_pc_riki", 0);
			object oDerry = GetObjectByTag("003_pc_riki", 0);
			while(oPC != OBJECT_INVALID) {
				string sPCName = GetName(oPC);
				if(FindSubString(sPCName, "Jhess") != -1) {
					oJhessi = oPC;
				}
				if(FindSubString(sPCName, "Nio") != -1) {
					oNio = oPC;
				}
				if(FindSubString(sPCName, "Saerel") != -1) {
					oSaerela = oPC;
				}
				if(FindSubString(sPCName, "Bert") != -1) {
					oBertilak = oPC;
				}
				if(FindSubString(sPCName, "Bell") != -1) {
					oBellie = oPC;
				}
				
				if(FindSubString(sPCName, "Zov") != -1) {
					oZova = oPC;
				}
				if(FindSubString(sPCName, "Rik") != -1) {
					oRiki = oPC;
				}
				if(FindSubString(sPCName, "Derr") != -1) {
					oDerry = oPC;
				}
			oPC = GetNextPC(TRUE);
			}
			 
				
			DelayCommand(20.0, SendMessageToPC(oJhessi, "You see horrible figments flickering around Sayen: Bertilak's flesh melting away from his face, leaving a skull with blazing eyes; Ostelle engulfed in black fire; a harpy with rotting flesh flaring her wings over a bloodied Aedelvana."));
			DelayCommand(20.0, SendMessageToPC(oBertilak, "You see horrible figments flickering around Sayen: Jhessi chained to a wall in a Banite cell with Phaedra's hand around her throat; Lord Elthondsson upon a funeral pyre, but still alive, screaming; yourself hanging in a cage over snow, watching as a barbarian cleric brings Jhessi back to life."));
			DelayCommand(20.0, SendMessageToPC(oSaerela, "You see horrible figments flickering around Sayen: A baelnorn's laughing reflection in a cracked mirror; Yeshelne calling down a flamestrike upon your head; Nioniel falling into an abyss."));
			DelayCommand(20.0, SendMessageToPC(oZova, "You see horrible figments flickering around Sayen: Saerela screaming as she is consumed by a black fire emanating from a crystal globe; twin scimitars slitting Derry's throat; Aglaril's death in the Temple of Isis."));
			DelayCommand(20.0, SendMessageToPC(oRiki, "You saw a figment flickering around Sayen: A coin, golden on one side and corroded on the other, flipping in slow motion. (Please roll d100 and tell Wynna the result.)"));
			DelayCommand(20.0, SendMessageToPC(oDerry, "You saw horrible figments flickering around Sayen: Zova, with pupil-less eyes of red and hands around your neck; Riki, a corpse frozen within a block of ice; a great golden dragon battering down the keep of Olostin's Hold while townspeople scream and flee."));
			
			 }
	    }
}