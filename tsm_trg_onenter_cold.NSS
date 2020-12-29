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
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#include "acr_trigger_i"
#include "acr_quest_i"
#include "acr_spawn_i"



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

////////////////////////////////////////////////////////////////////////////////
// Function Definitions ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
void ACR_ApplyNLDDamageToCreature(object oTarget, int nSubdualDamage)
{
    int nNLDTotal = _GetNLDTotal(oTarget);
    int nHPMax = GetMaxHitPoints(oTarget);
    int nCap = nHPMax + 10;
    nNLDTotal = ((nNLDTotal + nSubdualDamage) > nCap) ? nCap :
            nNLDTotal + nSubdualDamage;
    _SetNLDTotal(oTarget, nNLDTotal);
    ACR_ApplyNLDEffects(oTarget, nNLDTotal);
}

void main()
{
    ACR_TriggerOnEnter();

    // Custom code goes here.
	object oPC = GetEnteringObject();

 if(GetLocalInt(oPC, "ColdRep") == 0)
		{//SetLocalInt(oPC, "ColdRep", 1);
		 //DelayCommand(61.0, ExecuteScript("slv_static_voice_cr_pc", oPC));
		}

if(GetLocalString(OBJECT_SELF, GetName(oPC)) != GetName(oPC))  {
SetLocalString(OBJECT_SELF, GetName(oPC), GetName(oPC));				
if(GetLocalInt(oPC, "nRepCold") <25)
				{
				float fTimeLoop = 91.0;
				 int nRepCold = GetLocalInt(oPC, "nRepCold");
				 if(nRepCold > 0) { 
				 DelayCommand(1.0, ACR_ApplyNLDDamageToCreature(oPC, d6()));
				  DelayCommand(2.0, ACR_NLD_ReportTotal(oPC, oPC, 0));
					}		
						 
							 
					if(FindSubString(GetName(GetItemInSlot(INVENTORY_SLOT_CLOAK, oPC)), "Greatcloak") != -1)
						{//SendMessageToPC(OBJECT_SELF, "Cloak Slot = " +  GetName(GetItemInSlot(INVENTORY_SLOT_CLOAK, OBJECT_SELF)));
						 SendMessageToPC(oPC, "Your warm cloak will certainly insulate you from some of the cold.");
						fTimeLoop = 300.0;
						}
					if(GetHasSkill(SKILL_SURVIVAL, oPC))
						{SetLocalInt(oPC, "Survival", 4);
						SendMessageToPC(oPC, "Your ability to survive in the wilderness keeps you from succumbing to the worst of the cold.");
						}
					if ((!GetHasSpellEffect(SPELL_ENDURE_ELEMENTS, oPC)) && (!GetHasSpellEffect(SPELL_RESIST_ENERGY, OBJECT_SELF))&& (!GetHasSpellEffect(SPELL_PROTECTION_FROM_ENERGY, OBJECT_SELF)))
				         {int nSurvival = GetLocalInt(oPC, "Survival");
						  int nDC = 15 + nRepCold - nSurvival;
						  if(!FortitudeSave(oPC, nDC, SAVING_THROW_TYPE_COLD, oPC))
							{ACR_ApplyNLDDamageToCreature(oPC, d6());
							 SendMessageToPC(oPC, "The bitter cold takes its toll!");
							 ACR_NLD_ReportTotal(oPC, oPC, 0);
							 }
						 }
					else {SendMessageToPC(oPC, "You feel your elemental protection spell keeping the worst of the cold at bay.");
					     }
					
					SetLocalInt(oPC, "Survival", 0);
					nRepCold++;
					SetLocalInt(oPC, "nRepCold", nRepCold);
					if((GetTag(GetArea(oPC)) == "5g_ext_felbarr_trail")&& (nRepCold < 25))
						{DelayCommand(fTimeLoop, ExecuteScript("tsm_trg_onenter_cold", oPC));}
					if(GetTag(GetArea(oPC)) != "5g_ext_felbarr_trail")
						{SetLocalInt(oPC, "nRepCold", 0);
						 SendMessageToPC(oPC, "The last of the bitter cold shakes itself from your bones.");
							 
						}
				}
				 else {SetLocalInt(oPC, "nRepCold", 0);
				 	   SetLocalInt(oPC, "nRepCold", 0);
					  }	
				 
	  } 
}