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
#include "acr_quest_i"

void main()
{
    ACR_CreatureOnPerception();
	object oPerceived = GetLastPerceived();
	
	if((GetTag(OBJECT_SELF) == "abr_cr_hu_duergarsap_03") || (GetTag(OBJECT_SELF) == "abr_cr_hu_duergarsap_03b"))  {
		SendMessageToAllDMs("Debug: Duergar Sapper = " + GetTag(OBJECT_SELF));
		object oBomb = GetItemPossessedBy(OBJECT_SELF, "abr_it_msc_firebomb");
		object oAlchFire = GetItemPossessedBy(OBJECT_SELF, "abr_it_msc_alchfire");
	    if(((GetIsPC(oPerceived) || (GetIsDMPossessed(oPerceived))))  && (GetLocalString(OBJECT_SELF, GetName(oPerceived)) != "Bombed")) {
			SetLocalString(OBJECT_SELF, GetName(oPerceived), "Bombed");
			SendMessageToAllDMs("Debug: " + GetTag(OBJECT_SELF) + " perceives " + GetName(oPerceived));
		    if(oBomb != OBJECT_INVALID) {
			    SendMessageToAllDMs("Debug: " + GetTag(OBJECT_SELF) + " has bomb ");
				SpawnSpellProjectile(OBJECT_SELF, oPerceived, GetLocation(OBJECT_SELF), GetLocation(oPerceived), 744, PROJECTILE_PATH_TYPE_DEFAULT);
				DelayCommand(1.0, DoGrenade(d6(10),1, VFX_IMP_FLAME_M, VFX_FNF_FIREBALL,DAMAGE_TYPE_FIRE,RADIUS_SIZE_HUGE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE));
	            ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectAreaOfEffect(AOE_PER_FOGFIRE), GetLocation(oPerceived), RoundsToSeconds(5));
	    		DestroyObject(oBomb);
				}
			else if(oAlchFire != OBJECT_INVALID) {
				SendMessageToAllDMs("Debug: " + GetTag(OBJECT_SELF) + " has alchemist's fire ");
				SpawnSpellProjectile(OBJECT_SELF, oPerceived, GetLocation(OBJECT_SELF), GetLocation(oPerceived), 744, PROJECTILE_PATH_TYPE_DEFAULT);
				DelayCommand(1.0, DoGrenade(d6(2),1, VFX_IMP_FLAME_M, VFX_FNF_FIREBALL,DAMAGE_TYPE_FIRE,RADIUS_SIZE_HUGE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE));
	            ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectAreaOfEffect(AOE_PER_FOGFIRE), GetLocation(oPerceived), RoundsToSeconds(5));
	    		DestroyObject(oAlchFire);
				}
			}
		}
	
	
		//KiS Static_03		 
		if(GetTag(OBJECT_SELF) == "003_cr_kis_atarms_parade") 
			{if((GetIsPC(GetLastPerceived())) && (ACR_RetrieveQuestState("kis_combat_03", GetLastPerceived()) == 2))
				{object oSubdue = GetLastPerceived();
				 ActionForceMoveToObject(oSubdue, TRUE, 0.0);
				 if(_GetNLDMode(OBJECT_SELF) == FALSE)
				 	{ACR_ToggleNLDMode(OBJECT_SELF);
					 }
			 if((_GetNLDState(oSubdue) != 2) && (GetLocalInt(oSubdue, "kis_combat_03_win") < 5))
				  	{ActionMoveToObject(oSubdue, TRUE, 1.0);
					 ActionAttack(oSubdue, FALSE);
					 }
				}
			 
			else
				{if(GetIsEnemy(GetLastPerceived()))
					{ClearAllActions(FALSE);
					 object oEnemy = GetLastPerceived();
					 if(_GetNLDMode(OBJECT_SELF) == FALSE)
					 	{ACR_ToggleNLDMode(OBJECT_SELF);
						 }
			 		ActionAttack(oEnemy, FALSE);
					 }
				}
			}
	
 if((Random(10)==1) && ((FindSubString(GetTag(OBJECT_SELF), "deneir") != -1) || (FindSubString(GetTag(OBJECT_SELF), "vos_scribe") != -1)) && (GetIsEnemy(oPerceived)) && (GetIsPC(oPerceived))) 
	{string sLibrary = "";
	 int nRandLib = Random(4);
	 if(nRandLib == 1) {
	  	sLibrary = "Shhhh!";
		}
	 else if(nRandLib == 2) {
	  	sLibrary = "You have overdue scribing fees!";
		}
	 else if(nRandLib == 3) {
	  	sLibrary = "No materials may be taken from the Vault!";
		}
	  else if(nRandLib == 4) {
	  	sLibrary = "I said, keep your voice down!";
		}
	
	}			
			
			
  if((Random(3)==1) && (GetLocalInt(oPerceived, "Perceived" + GetTag(OBJECT_SELF)) != 1) && (FindSubString(GetTag(OBJECT_SELF), "03_silvy_commoner") != -1) && (GetIsPC(oPerceived))) 
	{
	
	object oNearest = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC, OBJECT_SELF, 1);
	 if((!GetIsDM(oNearest)) && (!GetIsPC(oNearest)) &&(GetDistanceBetween(OBJECT_SELF, oNearest) < 20.0 ) )
		 {ActionForceMoveToObject(oNearest, FALSE, 1.0, 30.0);
		  DelayCommand(3.0, AssignCommand(oNearest, SetFacingPoint(GetPositionFromLocation(GetLocation(OBJECT_SELF)))));
		  DelayCommand(3.2, SetFacingPoint(GetPositionFromLocation(GetLocation(oNearest))));
	      DelayCommand(10.0, AssignCommand(oNearest, SetFacingPoint(GetPositionFromLocation(GetLocation(OBJECT_SELF)))));
		  DelayCommand(10.2, SetFacingPoint(GetPositionFromLocation(GetLocation(oNearest))));
	      DelayCommand(11.0, ActionWait(30.0));
		  }
		int nRandomPerception = Random(200);
		string sDay;
	    if(GetIsDay())
	     {sDay = "day.";}
	    else
	     {sDay = "evening.";}
    	
		string sHeardFrom = "He";
		int nRandomHeardFrom = Random(21);
		if(nRandomHeardFrom == 1)
			{sHeardFrom = "She";}
		if(nRandomHeardFrom == 2)
			{sHeardFrom = "My son";}
		if(nRandomHeardFrom == 3)
			{sHeardFrom = "My daughter";}
		if(nRandomHeardFrom == 4)
			{sHeardFrom = "My sister";}
		if(nRandomHeardFrom == 5)
			{sHeardFrom = "My brother";}
		if(nRandomHeardFrom == 6)
			{sHeardFrom = "My mother";}
		if(nRandomHeardFrom == 7)
			{sHeardFrom = "My father";}
		if(nRandomHeardFrom == 8)
			{sHeardFrom = "My grandmother";}
		if(nRandomHeardFrom == 9)
			{sHeardFrom = "My grandfather";}
		if(nRandomHeardFrom == 10)
			{sHeardFrom = "My children";}
		if(nRandomHeardFrom == 11)
			{sHeardFrom = "The constables";}
		if(nRandomHeardFrom == 12)
			{sHeardFrom = "A Knight in Silver";}
		if(nRandomHeardFrom == 13)
			{sHeardFrom = "A spellguard";}
		if(nRandomHeardFrom == 14)
			{sHeardFrom = "A shopkeeper";}
		if(nRandomHeardFrom == 15)
			{sHeardFrom = "Katrinia";}
		if(nRandomHeardFrom == 16)
			{sHeardFrom = "Myra";}
		if(nRandomHeardFrom == 17)
			{sHeardFrom = "A scribe at the Vault of Sages";}
		if(nRandomHeardFrom == 18)
			{sHeardFrom = "A student at the Lady's College";}
		if(nRandomHeardFrom == 19)
			{sHeardFrom = "Someone who works at the Palace";}
		if(nRandomHeardFrom == 20)
			{sHeardFrom = "A guard at the city gate over there";}
		
		string sRandomMonster = "monsters";
		int nRandomMonster = Random(20);
		if(nRandomMonster == 1)
			{sRandomMonster = "orcs";}
		if(nRandomMonster == 2)
			{sRandomMonster = "kobolds";}
		if(nRandomMonster == 3)
			{sRandomMonster = "goblins";}
		if(nRandomMonster == 4)
			{sRandomMonster = "wolves";}
		if(nRandomMonster == 5)
			{sRandomMonster = "little devils";}
		if(nRandomMonster == 6)
			{sRandomMonster = "little demons";}
		if(nRandomMonster == 7)
			{sRandomMonster = "a dragon";}
		if(nRandomMonster == 8)
			{sRandomMonster = "a man that was half horse";}
		if(nRandomMonster == 9)
			{sRandomMonster = "something that was half bull";}
		if(nRandomMonster == 10)
			{sRandomMonster = "drow";}
		if(nRandomMonster == 11)
			{sRandomMonster = "a bloody great tree that could walk";}
		if(nRandomMonster == 12)
			{sRandomMonster = "werewolves";}
		if(nRandomMonster == 13)
			{sRandomMonster = "little winged people";}
		if(nRandomMonster == 14)
			{sRandomMonster = "something made of water";}
		if(nRandomMonster == 15)
			{sRandomMonster = "something that healed him";}
		if(nRandomMonster == 16)
			{sRandomMonster = "gigantic winged women";}
		if(nRandomMonster == 17)
			{sRandomMonster = "a unicorn";}
		if(nRandomMonster == 18)
			{sRandomMonster = "something that shrieked so loud the blood ran cold and froze anybody in hearing";}
		if(nRandomMonster == 19)
			{sRandomMonster = "a bird made of fire";}
		if(nRandomMonster == 20)
			{sRandomMonster = "something made entirely of stone, but moving";}
		
		string sRandomCity = "Silverymoon";
		int nRandomCity = Random(20);
		if(nRandomCity == 1)
			{sRandomCity = "the Mulgate";}
		if(nRandomCity == 2)
			{sRandomCity = "the Blacklar Gate";}
		if(nRandomCity == 3)
			{sRandomCity = "the Moorgate";}
		if(nRandomCity == 4)
			{sRandomCity = "Rivermoot";}
		if(nRandomCity == 5)
			{sRandomCity = "High Hold";}
		if(nRandomCity == 6)
			{sRandomCity = "Sundabar";}
		if(nRandomCity == 7)
			{sRandomCity = "Everlund";}
		if(nRandomCity == 8)
			{sRandomCity = "the Evermoors";}
		if(nRandomCity == 9)
			{sRandomCity = "Quaervar";}
		if(nRandomCity == 10)
			{sRandomCity = "the edge of the High Forest";}
		if(nRandomCity == 11)
			{sRandomCity = "the lake in the Moonwood";}
		if(nRandomCity == 12)
			{sRandomCity = "Winter's Edge";}
		if(nRandomCity == 13)
			{sRandomCity = "Settlestone";}
		if(nRandomCity == 14)
			{sRandomCity = "Fourthpeak";}
		if(nRandomCity == 15)
			{sRandomCity = "Citadel Felbarr";}
		if(nRandomCity == 16)
			{sRandomCity = "the north part of the Moonwood";}
		if(nRandomCity == 17)
			{sRandomCity = "the Silverwood";}
		if(nRandomCity == 18)
			{sRandomCity = "Khelb";}
		if(nRandomCity == 19)
			{sRandomCity = "Silverymoon Pass";}
		if(nRandomCity == 20)
			{sRandomCity = "the high peaks of the Nether Mountains";}
		
		if(nRandomPerception < 69) {
			SetLocalInt(oPerceived, "Perceived" + GetTag(OBJECT_SELF), 1);
			if(nRandomPerception < 10)
				{ActionPlayAnimation(ANIMATION_FIREFORGET_GREETING, 1.0);
				 }
			else if(nRandomPerception < 30)
				{DelayCommand(IntToFloat(Random(5)), ActionSpeakString("Hello.", TALKVOLUME_TALK));
				 }
			else if(nRandomPerception < 50)
				{DelayCommand(IntToFloat(Random(5)), ActionSpeakString("Good " + sDay + ".", TALKVOLUME_TALK));
				 }
			else if(nRandomPerception < 55)
				{DelayCommand(IntToFloat(Random(5)), ActionSpeakString("Did you hear? " + sHeardFrom + " said somebody saw " + sRandomMonster + " near " + sRandomCity, TALKVOLUME_TALK));
				 }
			else if(nRandomPerception < 60)
				{DelayCommand(IntToFloat(Random(5)), ActionSpeakString(sHeardFrom + " got hired on at the circus.", TALKVOLUME_TALK));
				 }
			else if(nRandomPerception < 65)
				{DelayCommand(IntToFloat(Random(5)), ActionSpeakString(sHeardFrom + " saw some of those acts when it was passing through " + sRandomCity + ".", TALKVOLUME_TALK));
				 }
			else if(nRandomPerception < 67)
				{DelayCommand(IntToFloat(Random(5)), ActionSpeakString("I heard an imp escaped from the circus last night and is loose in the city!", TALKVOLUME_TALK));
				 }
			else if(nRandomPerception < 69)
				{DelayCommand(IntToFloat(Random(5)), ActionSpeakString(sHeardFrom + " said that the Palace sent investigators to the circus for some reason!", TALKVOLUME_TALK));
				 }
			} 
		
	}			
			
}