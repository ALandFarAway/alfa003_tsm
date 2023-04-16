////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ACR Configuration File
//     Filename : acf_cre_ondeath
//    $Revision:: 280        $ current version of the file
//        $Date:: 2007-03-20#$ date the file was created or modified
//       Author : Cipher
//
//    Var Prefix:
//  Dependencies:
//
//  Description
//  This script calls the ACR's OnDeath event handler for creatures and
//  any custom code a server may need. It is not updated in ACR updates.
//
//  Revision History
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#include "acr_creature_i"
#include "acr_db_persist_i"

void ActionCreateWynCreature(string sCreature, location lLocCreature)
{
    CreateObject(OBJECT_TYPE_CREATURE, sCreature, lLocCreature);
}

void ActionCreateWynPlacedEffect(string sPlacedEffect, location lLocPlaceEffect)
{
    CreateObject(OBJECT_TYPE_PLACED_EFFECT, sPlacedEffect, lLocPlaceEffect);
}

void main()
{
    ACR_CreatureOnDeath();

    
	//slv_deandragon_q Phoenix
	
	if(GetTag(OBJECT_SELF) == "abr_cr_mb_phoenix")
		{CreateObject(OBJECT_TYPE_ITEM, "003_it_harvest_phx_feather", GetLocation(GetLastKiller()));
		 CreateObject(OBJECT_TYPE_ITEM, "003_it_harvest_phx_feather", GetLocation(GetLastKiller()));
		 SendMessageToPC(GetLastKiller(), "Feathers flutter to your feet.");
		 effect ePhoenix = EffectVisualEffect(VFX_FNF_SUNBEAM, FALSE);
		 effect eImplode = EffectVisualEffect(VFX_FNF_IMPLOSION, FALSE);
		 DelayCommand(20.0, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, ePhoenix, GetLocation(OBJECT_SELF),  10.0));
		 DelayCommand(27.0, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, ePhoenix, GetLocation(OBJECT_SELF),  10.0));
		 DelayCommand(30.0, SendMessageToPC(GetLastKiller(), "When the dazzle clears from your eyes, you are just in time to see a streak of fiery gold vanishing into the sky. The phoenix has risen...and is gone."));
		 DestroyObject(OBJECT_SELF, 30.0);		  	 	 
		}
	
	if(GetTag(OBJECT_SELF) == "abr_cr_pla_treant_uncryst")
		{object oMothOne = CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_mb_deathmoth", GetLocation(OBJECT_SELF));
		 if(Random(2)==1) {object oMothTwo = CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_mb_deathmoth", GetLocation(OBJECT_SELF));}
		 if(Random(2)==1) {object oMothThree = CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_mb_deathmoth", GetLocation(OBJECT_SELF));}
		 if(Random(2)==1) {object oMothFour = CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_mb_deathmoth", GetLocation(OBJECT_SELF));}
		 if(Random(2)==1) {object oMothFive = CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_mb_deathmoth", GetLocation(OBJECT_SELF));}
		 if(Random(2)==1) {object oMothSix = CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_mb_deathmoth", GetLocation(OBJECT_SELF));}
		 DelayCommand(3.0, AssignCommand(oMothOne, ActionSpeakString("Moths burst out of the toppled treant!", TALKVOLUME_TALK)));
		 effect eImplode = EffectVisualEffect(VFX_FNF_IMPLOSION, FALSE);
		 DelayCommand(2.0, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eImplode, GetLocation(OBJECT_SELF)));
		 DelayCommand(4.0, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eImplode, GetLocation(oMothOne)));
		 }	
		
	if(FindSubString(GetTag(OBJECT_SELF), "cr_hu_orc_hiero") != -1)
		{object oSwordwraith = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_ud_swwraith_orc", GetLocation(OBJECT_SELF));
		 effect eRise = EffectVisualEffect(VFX_FNF_SUMMON_EPIC_UNDEAD, FALSE);
		 ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRise, oSwordwraith, 5.0);
		}	
		
		
	//KiS Bravery
	
	if(GetTag(OBJECT_SELF) == "003_cr_kis_atarms_parade")
		{object oPC = GetLastKiller();
		 object oKiS1 = GetLocalObject(OBJECT_SELF, "oKiS1");
		 if(oKiS1 == OBJECT_INVALID)
		 	{oKiS1 = GetNearestObjectByTag("003_cr_kis_atarms", OBJECT_SELF, 1);
			 SetLocalObject(OBJECT_SELF, "oKiS1", oKiS1);
			 }
		 object oKiS2 = GetLocalObject(OBJECT_SELF, "oKiS2");
		 if(oKiS2 == OBJECT_INVALID)
		 	{oKiS2 = GetNearestObjectByTag("003_cr_kis_atarms", OBJECT_SELF, 2);
			 SetLocalObject(OBJECT_SELF, "oKiS2", oKiS2);
			 }
		 object oKiS3 = GetLocalObject(OBJECT_SELF, "oKiS3");
		 if(oKiS3 == OBJECT_INVALID)
		 	{oKiS3 = GetNearestObjectByTag("003_cr_kis_atarms", OBJECT_SELF, 3);
			 SetLocalObject(OBJECT_SELF, "oKiS3", oKiS3);
			 }
		 object oKiS4 = GetLocalObject(OBJECT_SELF, "oKiS4");
		 if(oKiS4 == OBJECT_INVALID)
		 	{oKiS4 = GetNearestObjectByTag("003_cr_kis_atarms", OBJECT_SELF, 4);
			 SetLocalObject(OBJECT_SELF, "oKiS4", oKiS4);
			 }
		 object oKiS5 = GetLocalObject(OBJECT_SELF, "oKiS5");
		 if(oKiS5 == OBJECT_INVALID)
		 	{oKiS5 = GetNearestObjectByTag("003_cr_kis_atarms", OBJECT_SELF, 5);
			 SetLocalObject(OBJECT_SELF, "oKiS5", oKiS5);
			 }
		 object oKiSXBow1 = GetLocalObject(OBJECT_SELF, "oKiSXBow1");
		 if(oKiSXBow1 == OBJECT_INVALID)
		 	{oKiSXBow1 = GetNearestObjectByTag("003_cr_kis_xbow", OBJECT_SELF, 1);
			 SetLocalObject(OBJECT_SELF, "oKiSXBow1", oKiSXBow1);
			 }
		 object oKiSXBow2 = GetLocalObject(OBJECT_SELF, "oKiSXBow2");
		 if(oKiSXBow2 == OBJECT_INVALID)
		 	{oKiSXBow2 = GetNearestObjectByTag("003_cr_kis_xbow", OBJECT_SELF, 2);
			 SetLocalObject(OBJECT_SELF, "oKiSXBow2", oKiSXBow2);
			 }
		 object oKiSSgt = GetLocalObject(OBJECT_SELF, "oKiSSgt");
		 if(oKiSSgt == OBJECT_INVALID)
		 	{oKiSSgt = GetNearestObjectByTag("003_cr_kis_sgt_parade", OBJECT_SELF, 1);
			 SetLocalObject(OBJECT_SELF, "oKiSSgt", oKiSSgt);
			 }
		 	 	 
		
		ACR_SetPersistentInt(oPC, "KilledKiS", 1);
			 
		if(_GetNLDMode(oKiS1) == FALSE)  
		 	{ACR_ToggleNLDMode(oKiS1);
			 }
		AssignCommand(oKiS1, ActionAttack(oPC, FALSE));
		
		if(_GetNLDMode(oKiS2) == FALSE)  
		 	{ACR_ToggleNLDMode(oKiS2);
			 }
		AssignCommand(oKiS1, ActionAttack(oPC, FALSE));
		
		if(_GetNLDMode(oKiS3) == FALSE)  
		 	{ACR_ToggleNLDMode(oKiS1);
			 }
		AssignCommand(oKiS3, ActionAttack(oPC, FALSE));
		
		if(_GetNLDMode(oKiS4) == FALSE)  
		 	{ACR_ToggleNLDMode(oKiS4);
			 }
		AssignCommand(oKiS4, ActionAttack(oPC, FALSE));
		
		if(_GetNLDMode(oKiS5) == FALSE)  
		 	{ACR_ToggleNLDMode(oKiS5);
			 }
		AssignCommand(oKiS5, ActionAttack(oPC, FALSE));
		
		if(_GetNLDMode(oKiSXBow1) == FALSE)  
		 	{ACR_ToggleNLDMode(oKiSXBow1);
			 }
		AssignCommand(oKiSXBow1, ActionAttack(oPC, FALSE));
		
		if(_GetNLDMode(oKiSXBow2) == FALSE)  
		 	{ACR_ToggleNLDMode(oKiSXBow2);
			 }
		AssignCommand(oKiSXBow2, ActionAttack(oPC, FALSE));
		
		if(_GetNLDMode(oKiSSgt) == FALSE)  
		 	{ACR_ToggleNLDMode(oKiSSgt);
			 }
		AssignCommand(oKiSSgt, ActionAttack(oPC, FALSE));
		
	
		}
		
}