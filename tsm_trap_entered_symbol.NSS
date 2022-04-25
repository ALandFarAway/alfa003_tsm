////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ACR Configuration File
//     Filename : acf_trg_onenter.nss
//    $Revision:: 236        $ current version of the file
//        $Date:: 2007-01-21#$ date the file was created or modified
//       Author : Cipher
//
//    Var Prefix:
//  Dependencies:
//
//  Description
//  This script calls the ACR's OnEnter code for triggers, and any
//  custom code a server may need. It is not updated in ACR updates.
//
//  Revision History
//  2007/01/20  Cipher  Inception
//  Feb 2021 -- Wynna symbol trap onenters
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#include "acr_trigger_i"
#include "acr_quest_i"
#include "acr_spawn_i"
#include "dmfi_inc_langexe" 



void main()
{
    ACR_TriggerOnEnter();

    // Custom code goes here.
	effect eExplode = EffectVisualEffect(VFX_FNF_MYSTICAL_EXPLOSION, FALSE);
	effect eExplode2 = EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_MIND, FALSE);
	effect eFireExplosion = EffectVisualEffect(564, FALSE);
	effect eSteamExplosion = EffectVisualEffect(569, FALSE);
	effect eElectric = EffectVisualEffect(74, FALSE);
	effect eImplode = EffectVisualEffect(736, FALSE);
	effect eCircle = EffectVisualEffect(700, FALSE);
	effect eSonicImplode = EffectVisualEffect(1009, FALSE);
	effect eSoundBurst = EffectVisualEffect(VFX_FNF_SOUND_BURST, FALSE);
	effect eDust = EffectVisualEffect(VFX_IMP_DUST_EXPLOSION, FALSE);
	
    	
if((GetTag(OBJECT_SELF) == "trg_symbol_pers_det") && (GetIsPC(GetEnteringObject()))  && (GetLocalInt(OBJECT_SELF, "Fired") != 1)) 
	{
	object oGlyphWP = GetNearestObjectByTag("plc_symbol_pers_wp", OBJECT_SELF, 1);
	object oPC = GetEnteringObject();
	
	if(GetIsSkillSuccessful(oPC, SKILL_SEARCH, 28, FALSE))
		{SendMessageToPC(oPC, "Your careful searching reveals an arcane design brushed onto the ground!");
		 object oGlyph = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_symbol_pers", GetLocation(oGlyphWP));
		 DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eCircle, oGlyph, 5.0));
	     SetLocalInt(OBJECT_SELF, "Fired", 1);
		}
	}
	
	if((GetTag(OBJECT_SELF) == "trg_symbol_pers") && (GetIsPC(GetEnteringObject()))) {
	object oGlyphWP = GetNearestObjectByTag("plc_symbol_pers_wp", OBJECT_SELF, 1);
	object oPC = GetEnteringObject();
	
		if(GetLocalInt(OBJECT_SELF, "Fired") == 0)
	        {object oGlyph = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_symbol_pers", GetLocation(oGlyphWP));
			 DelayCommand(2.0, SetUseableFlag(oGlyph, TRUE));
		     SetLocalObject(oGlyph, "MyTrigger", OBJECT_SELF);
		     DestroyObject(oGlyph, 6000.0);
			 SetLocalInt(OBJECT_SELF, "Fired", 1);
			 SetLocalInt(OBJECT_SELF, "Ticking", 1);
			 DelayCommand(6000.0, SetLocalInt(OBJECT_SELF, "Ticking", 0));
			 }
				   	  	   
		 if((GetLocalInt(OBJECT_SELF, "Ticking") == 1) && (GetLocalString(OBJECT_SELF, GetName(oPC)) != GetName(oPC))) {
		 	SetLocalString(OBJECT_SELF, GetName(oPC), GetName(oPC));
			if(WillSave(oPC,17, SAVING_THROW_TYPE_MIND_SPELLS, OBJECT_SELF))
				{SendMessageToPC(oPC, "A strange sensation passes through you, the absolute certainty of a friend's voice heard unexpectedly, or a familiar profile caught out of the corner of your eye. A moment later that joy fades, as if you'd turned and against that certainty, found no familiar face." );
				}
			else 
				{SendMessageToAllDMs(GetName(oPC) + " is charmed by " + GetName(OBJECT_SELF));
				  SendMessageToPC(oPC, "A strange sensation passes through you, the absolute certainty of a friend's voice heard unexpectedly, or a familiar profile caught out of the corner of your eye. You *feel* an upwelling of warmth for this friend, a connection based on trust and unshakable loyalty. You can't bring the face of this person to mind immediately, but it doesn't matter. You know him or her on the inside, and will know him or her when you meet again." );
				 }
			}	 	
	}
	
if((GetTag(OBJECT_SELF) == "trg_symbol_sleep_det") && (GetIsPC(GetEnteringObject()))  && (GetLocalInt(OBJECT_SELF, "Fired") != 1)) 
	{
	object oGlyphWP = GetNearestObjectByTag("plc_symbol_sleep_wp", OBJECT_SELF, 1);
	object oPC = GetEnteringObject();
	
	
	if(GetIsSkillSuccessful(oPC, SKILL_SEARCH, 28, FALSE))
		{SendMessageToPC(oPC, "Your careful searching reveals an arcane design inscribed onto the ground!");
		 object oGlyph = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_symbol_sleep", GetLocation(oGlyphWP));
		 DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eCircle, oGlyph, 5.0));
	     SetLocalInt(OBJECT_SELF, "Fired", 1);
		}

	
	}
	
	if((GetTag(OBJECT_SELF) == "trg_symbol_pers") && (GetIsPC(GetEnteringObject()))) {
	object oGlyphWP = GetNearestObjectByTag("plc_symbol_pers_wp", OBJECT_SELF, 1);
	object oPC = GetEnteringObject();
	
		if(GetLocalInt(OBJECT_SELF, "Fired") == 0)
	        {object oGlyph = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_symbol_pers", GetLocation(oGlyphWP));
			 SetLocalObject(oGlyph, "MyTrigger", OBJECT_SELF);
		     DelayCommand(2.0, SetUseableFlag(oGlyph, TRUE));
		     DestroyObject(oGlyph, 6000.0);
			 SetLocalInt(OBJECT_SELF, "Fired", 1);
			 SetLocalInt(OBJECT_SELF, "Ticking", 1);
			 DelayCommand(6000.0, SetLocalInt(OBJECT_SELF, "Ticking", 0));
			 }
				   	  	   
		 if((GetLocalInt(OBJECT_SELF, "Ticking") == 1) && (GetLocalString(OBJECT_SELF, GetName(oPC)) != GetName(oPC))) {
		 	SetLocalString(OBJECT_SELF, GetName(oPC), GetName(oPC));
			if(WillSave(oPC,17, SAVING_THROW_TYPE_MIND_SPELLS, OBJECT_SELF))
				{SendMessageToPC(oPC, "You hear a soothing sound you can't identify. Somewhere between white noise and a lullaby. You shake it off, realizing you were seconds away from falling asleep." );
				}
			else 
				{SendMessageToAllDMs(GetName(oPC) + " has been put to sleep by " + GetName(OBJECT_SELF));
				  SendMessageToPC(oPC, "You hear a soothing sound you can't identify. Somewhere between white noise and a lullaby. Before you can work it out, you are asleep." );
				 }
			}	 	
	}
	

	
	if((GetTag(OBJECT_SELF) == "trg_glyph_warding_det") && (GetIsPC(GetEnteringObject()))  && (GetLocalInt(OBJECT_SELF, "Fired") != 1)) 
	{object oGlyphWP = GetNearestObjectByTag("plc_glyph_warding_wp", OBJECT_SELF, 1);
	 object oPC = GetEnteringObject();
	//SendMessageToPC(oPC, "Entered Detect");
		
	if(GetIsSkillSuccessful(oPC, SKILL_SEARCH, 28, FALSE))
		{SendMessageToPC(oPC, "Your careful searching reveals an arcane design carved onto the ground!");
		 object oGlyph = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_glyph_ward_flr", GetLocation(oGlyphWP));
		 DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eCircle, oGlyph, 5.0));
	     DelayCommand(2.0, SetUseableFlag(oGlyph, TRUE));
		 SetLocalInt(OBJECT_SELF, "Fired", 1);
		}	
	}
	
	if((GetTag(OBJECT_SELF) == "trg_glyph_warding") && (GetIsPC(GetEnteringObject()))) 
	{object oGlyphWP = GetNearestObjectByTag("plc_glyph_warding_wp", OBJECT_SELF, 1);
	 object oPC = GetEnteringObject();
	 object oGlyph = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_glyph_ward_flr", GetLocation(oGlyphWP));
	 SetLocalObject(oGlyph, "MyTrigger", OBJECT_SELF);
		     
	 if(GetLocalInt(OBJECT_SELF, "Fired") == 0) 
	        {DelayCommand(1.0, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSonicImplode, GetLocation(oGlyph), 3.0));
			 DestroyObject(oGlyph, 6000.0);
			 SetLocalInt(OBJECT_SELF, "Fired", 1);
			 int nDamage = d8(5);
			 if(ReflexSave(oPC, 15, SAVING_THROW_TYPE_TRAP, OBJECT_SELF)) {
			 	nDamage = nDamage/2;
			 	}
			 effect eDamage = EffectDamage(nDamage, DAMAGE_TYPE_SONIC, DAMAGE_POWER_NORMAL, FALSE);
			 ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oPC);
			 
			 int nParty = 0;
			 while (nParty < 6) {
				 nParty = nParty + 1;
				 object oParty = GetNearestObject(OBJECT_TYPE_CREATURE, oPC, nParty);
				 int nPartyDmg = d8(5);
				 if(GetDistanceBetween(oPC, oParty) < 5.0)
				 	{if(ReflexSave(oParty, 15, SAVING_THROW_TYPE_TRAP, OBJECT_SELF)) {
					    nPartyDmg = nPartyDmg/2;
					 	}
				     effect eDamageParty = EffectDamage(nPartyDmg, DAMAGE_TYPE_SONIC, DAMAGE_POWER_NORMAL, FALSE);
				 	 ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamageParty, oParty);
				 	}
				 }
			 
			 }
	}
 

}