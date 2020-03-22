////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ACR Configuration File
//     Filename : acf_cre_onperception
//    $Revision:: 280        $ current version of the file
//        $Date:: 2007-03-20#$ date the file was created or modified
//       Author : Cipher
//
//    Var Prefix:
//  Dependencies:
//
//  Description
//  This script calls the ACR's OnPerception event handler for creatures
//  and any custom code a server may need. It is not updated in ACR updates.
//
//  Revision History
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
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

////////////////////////////////////////////////////////////////////////////////
// Function Definitions ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
void ACR_ApplyNLDDamageToCreature(object oTarget, int nSubdualDamage);


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
    ACR_CreatureOnPerception();
	//Quest B
	if(((GetTag(OBJECT_SELF) == "003_slv_dq_b_creature") || (GetTag(OBJECT_SELF) == "003_cr_fy_jermlaine_quest")) && (GetIsPC(GetLastPerceived())))
		{SpeakString("Flee! Take the ripe pods!", TALKVOLUME_TALK);
		 DelayCommand(2.0, SpeakString("The fey dash for the large tree, collecting fallen pods, then vanish!", TALKVOLUME_TALK));
		 SendMessageToPC(GetLastPerceived(), "The fey dash for the large tree, collecting fallen pods, then vanish!");
		 DestroyObject(OBJECT_SELF, 4.0);
		 object oFlute = GetLocalObject(OBJECT_SELF, "flute");
		 if(oFlute == OBJECT_INVALID)
			{oFlute = GetObjectByTag("fey_dance_flute");
			 SetLocalObject(OBJECT_SELF, "flute", oFlute);
			 }
		 SoundObjectStop(oFlute);
		 object oMyTree = GetLocalObject(OBJECT_SELF, "oMyTree");
			 if(oMyTree == OBJECT_INVALID)
			 	{oMyTree = GetObjectByTag("fey_chocolate_tree");
				 SetLocalObject(OBJECT_SELF, "oMyTree", oMyTree);
				} 
			 SetUseableFlag(oMyTree, FALSE);
		}
		
		
		//Quest E_Fire
		 
		if(GetTag(OBJECT_SELF) == "003_cr_sundabar_vigilant") 
			{if(GetIsPC(GetLastPerceived()))
				{object oArrest = GetLastPerceived();
				 ActionForceMoveToObject(oArrest, TRUE, 0.0);
				 if(GetLocalInt(OBJECT_SELF, "Intruder") != 1)
				 	{SpeakString("Intruder!", TALKVOLUME_TALK);
					 SetLocalInt(OBJECT_SELF, "Intruder", 1);
					 DelayCommand(IntToFloat(Random(60)), SetLocalInt(OBJECT_SELF, "Intruder", 0));
					 }
				 if(GetLocalInt(OBJECT_SELF, "NLD") == 0)
				 	{ACR_ToggleNLDMode(OBJECT_SELF);
					 SetLocalInt(OBJECT_SELF, "NLD", 1);
					 }
				  
				 if(_GetNLDState(oArrest) != 2)
				  	{ActionAttack(GetLastPerceived(), FALSE);
					 }
			     else{DelayCommand(5.0, ExecuteScript("slv_static_voice_cr_onperception", OBJECT_SELF));
					 	}
					}
			else
				{if(GetIsEnemy(GetLastPerceived()))
					{ClearAllActions(FALSE);
					 object oEnemy = GetLastPerceived();
					 ACR_ToggleNLDMode(OBJECT_SELF);
					 SetLocalInt(OBJECT_SELF, "NLD", 0);
					 ActionAttack(oEnemy, FALSE);
					 }
				}
			}
	//Quest X Deanphoenix Xorn
	
	if(GetTag(OBJECT_SELF)== "003_cr_deanphoenix_earth") 
		{if(GetIsPC(GetLastPerceived()))
			{if(GetCurrentHitPoints(OBJECT_SELF) != GetMaxHitPoints(OBJECT_SELF))
				{ActionMoveAwayFromObject(GetLastPerceived(), TRUE);}
			 else
			 	{ActionForceFollowObject(GetLastPerceived(), 2.0f);}
			}
				
		}
		
 // Deckon Thar Sky Pony
 
 	if((GetTag(OBJECT_SELF) == "003_cr_uthgardt_skypony")|| (GetTag(OBJECT_SELF) == "003_cr_uthgardt_skypony_shaman"))
		{if(GetIsPC(GetLastPerceived()))
			{if(GetTag(GetItemInSlot(INVENTORY_SLOT_NECK, GetLastPerceived())) == "slv_deandragon_u_necklace")
				{ChangeToStandardFaction(OBJECT_SELF, STANDARD_FACTION_DEFENDER);
				 ActionSpeakString("Sky tamer!", TALKVOLUME_TALK);
				}
			
			}
		}
			
    // Custom code goes here.
}