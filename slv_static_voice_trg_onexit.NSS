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
//  Feb 2009 -- Wynna All Dean's Exam (deandragon) quest trigger onexits
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#include "acr_trigger_i"
#include "acr_quest_i"


void main()
{
    ACR_TriggerOnExit();

    // Custom code goes here.
	
//deandragon quests
 if((GetTag(OBJECT_SELF) == "fey_chocolate_activate") && (GetLocalInt(OBJECT_SELF, "SpawnedExit") != 1))  
	 {if((ACR_RetrieveQuestState("slv_deansphinx_b", GetExitingObject()) >= 1)|| (ACR_RetrieveQuestState("slv_deansphinx_b", GetExitingObject()) < 7))
	 	{SetLocalInt(OBJECT_SELF, "SpawnedExit", 1);
		 DelayCommand(3600.0, SetLocalInt(OBJECT_SELF, "SpawnedExit", 0));
		 object oWP = GetWaypointByTag("TM_Moonwood_North_Meet_1_WP");
			 
		 object oClown2=CreateObject(OBJECT_TYPE_CREATURE, "003_cr_circus_clown_sling", GetLocation(oWP));
		 object oClown3=CreateObject(OBJECT_TYPE_CREATURE, "003_cr_circus_clown_club", GetLocation(oWP));
		 DelayCommand(5.0, AssignCommand(oClown2, ActionForceMoveToObject(GetExitingObject(), TRUE, 1.0f, 30.0f))); 
		 DelayCommand(5.0, AssignCommand(oClown3, ActionForceMoveToObject(GetExitingObject(), TRUE, 1.0f, 30.0f))); 
		}
	}
	
	if((GetTag(OBJECT_SELF) == "slv_deandragon_b_6") && (GetLocalInt(OBJECT_SELF, "Spawned") != 1)) 
	 {object oWP = GetLocalObject(OBJECT_SELF, "oWP");
	  if(oWP == OBJECT_INVALID)
			{oWP = GetNearestObjectByTag("ACR_SPAWN_WP", OBJECT_SELF);
			 SetLocalObject(OBJECT_SELF, "oWP", oWP);
			}
		 
	  if((ACR_RetrieveQuestState("slv_deansphinx_b", GetExitingObject()) >= 1)&& (ACR_RetrieveQuestState("slv_deansphinx_b", GetExitingObject()) < 7))
	 	{SetLocalInt(OBJECT_SELF, "Spawned", 1);
		 DelayCommand(3600.0, SetLocalInt(OBJECT_SELF, "Spawned", 0));
		 object oFlute = GetLocalObject(OBJECT_SELF, "flute");
	 	 if(oFlute == OBJECT_INVALID)
			{oFlute = GetObjectByTag("fey_dance_flute");
			 SetLocalObject(OBJECT_SELF, "flute", oFlute);
			 }
		 SoundObjectPlay(oFlute);
		 object oJerm1=CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_fy_jermlaine", GetLocation(oWP));
		 object oJerm2=CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_fy_jermlaine", GetLocation(oWP));
		 object oJerm3=CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_fy_jermlaine", GetLocation(oWP));
		 object oJerm4=CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_fy_jermlaine", GetLocation(oWP));
		 object oJerm5=CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_fy_jermlaine", GetLocation(oWP));
		 object oJerm6=CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_fy_jermlaine", GetLocation(oWP));
		 object oJerm7=CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_fy_jermlaine", GetLocation(oWP));
		 object oJerm8=CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_fy_jermlaine", GetLocation(oWP));
		 object oJerm9=CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_fy_jermlaine", GetLocation(oWP));
		 object oJerm10=CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_fy_jermlaine", GetLocation(oWP));
		 DelayCommand(1.0, AssignCommand(oJerm1, ActionSpeakString("*Nasty, giggling jermlaines swarm out of the earth between the roots of the trees!", TALKVOLUME_TALK)));
		 DelayCommand(1.5, AssignCommand(oJerm2, ActionSpeakString("Master says the joke's on you!", TALKVOLUME_TALK)));
		 DelayCommand(2.5, AssignCommand(oJerm3, ActionSpeakString("Master says the joke's on you!", TALKVOLUME_TALK)));
		 DelayCommand(3.5, AssignCommand(oJerm4, ActionSpeakString("Master says the joke's on you!", TALKVOLUME_TALK)));
		 DelayCommand(4.0, SoundObjectPlay(oFlute));
		 DelayCommand(4.0, AssignCommand(oJerm2, ClearAllActions(TRUE)));
		 DelayCommand(4.5, AssignCommand(oJerm2, ActionSpeakString("Pinch!", TALKVOLUME_TALK)));
		 DelayCommand(6.0, AssignCommand(oJerm3, ClearAllActions(TRUE)));
		 DelayCommand(6.5, AssignCommand(oJerm3, ActionSpeakString("Poke!", TALKVOLUME_TALK)));
		 DelayCommand(8.0, SoundObjectPlay(oFlute));
		 DelayCommand(8.0, AssignCommand(oJerm4, ClearAllActions(TRUE)));
		 DelayCommand(8.5, AssignCommand(oJerm4, ActionSpeakString("Prod!", TALKVOLUME_TALK)));
		 DelayCommand(10.0, AssignCommand(oJerm5, ClearAllActions(TRUE)));
		 DelayCommand(10.5, AssignCommand(oJerm5, ActionSpeakString("Punish!", TALKVOLUME_TALK)));
		 DelayCommand(12.0, AssignCommand(oJerm6, ClearAllActions(TRUE)));
		 DelayCommand(12.5, AssignCommand(oJerm6, ActionSpeakString("Master says the joke's on you!", TALKVOLUME_TALK)));
		 }
	}
	 
	 
	
if((GetTag(OBJECT_SELF) == "slv_deandragon_e") && (ACR_RetrieveQuestState("slv_deandragon_e", GetExitingObject()) > 1)&& (ACR_RetrieveQuestState("slv_deandragon_e", GetExitingObject()) < 8))
 	{object oMyIncinder = GetLocalObject(OBJECT_SELF, "oMyIncinder");
	 DestroyObject(oMyIncinder, 30.0);
	SetLocalObject(OBJECT_SELF, "oMyIncinder", OBJECT_INVALID);
	 }

if((GetTag(OBJECT_SELF) == "slv_deandragon_e_ice_activate") && (ACR_RetrieveQuestState("slv_deansphinx_e_air", GetExitingObject()) >= 1))
 	{object oMyIce = GetLocalObject(OBJECT_SELF, "oMyIce");
	 if(oMyIce == OBJECT_INVALID)
	 	{oMyIce = GetObjectByTag("slv_deandragon_e_ice");
		 SetLocalObject(OBJECT_SELF, "oMyIce", oMyIce);
		} 
	 DestroyInventory(oMyIce);
	 SetUseableFlag(oMyIce, FALSE);
	 }
	
if((GetTag(OBJECT_SELF) == "deandragon_firetrap_activate") && (ACR_RetrieveQuestState("slv_deansphinx_e_fire", GetExitingObject()) >= 1))
 	{object oMyTrap = GetLocalObject(OBJECT_SELF, "oMyTrap");
	 if(oMyTrap == OBJECT_INVALID)
	 	{oMyTrap = GetObjectByTag("slv_deandragon_e_firetrap");
		 SetLocalObject(OBJECT_SELF, "oMyTrap", oMyTrap);
		} 
	 DestroyInventory(oMyTrap);
	 SetUseableFlag(oMyTrap, FALSE);
	}
	

if((GetTag(OBJECT_SELF) == "deandragon_heatloop") && ((GetIsPC(GetExitingObject())) || (GetIsDMPossessed(GetExitingObject())))) 
	 	{if(GetLocalInt(GetExitingObject(), "HeatRep") == 1)
				{SetLocalInt(GetExitingObject(), "HeatRep", 0);
				 }
		}
if((GetTag(OBJECT_SELF) == "deandragon_coldloop") && ((GetIsPC(GetExitingObject())) || (GetIsDMPossessed(GetExitingObject())))) 
	 	{if(GetLocalInt(GetExitingObject(), "ColdRep") == 1)
				{SetLocalInt(GetExitingObject(), "ColdRep", 0);
				 }
		}
		
 // Deandragon_K toggle silence
	if((GetTag(OBJECT_SELF) == "deandragon_k_silence") && ((GetIsPC(GetExitingObject())) || (GetIsDMPossessed(GetExitingObject()))))
	 	 {object oPC = GetExitingObject();
		 effect eEffect = GetFirstEffect(oPC);
		  while(GetIsEffectValid(eEffect) != FALSE)
			{if(GetEffectCreator(eEffect) == OBJECT_SELF)
			 	{RemoveEffect(oPC, eEffect);
				}
			  eEffect = GetNextEffect(oPC);
			}
		}
	 
		//deandragon_z_swim stop
if(GetTag(OBJECT_SELF) == "deandragon_z_swim")
	{SetLocalInt(GetExitingObject(), "Swimming", 0);
	  }
		
}