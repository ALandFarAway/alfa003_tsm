//
//  System Name : Scrying
//     Filename : i_abr_scry_kit_ac
//      Version : 0.1
//         Date : 7/8/22
//       Author : Wynna
//
//  Description
//  This script handles the on activate actions for a scrying kit used in the scrying system. 
//	The kit should be made available in applicable stores for PCs to purchase
//  Use the kit on yourself to generate a body part to give to others to provide a strong connection for scrying
//  Use the kit on an item to generate a possession to give to others to provide an average connection for scrying
//  Use the kit on another creature for a chance to steal a body part or possession
//    to give to others to provide a strong or average connection for scrying. User must have sleight of hand ranks.
//   
//	It is not updated in ACR updates.
//
//  Revision History
////////////////////////////////////////////////////////////////////////////////

//	Wynna - 7/8/2022

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////

#include "acr_scry_i"
#include "x0_i0_stringlib"

/*const string HAIR_TEMPORARY_DATABASE_NAME = "hairDB";
const string HAIR_VARIABLE_NAME = "hairCreature";
const string HAIR_ROADMAP = "Appearance_Hair";

int GetHairStyle(object oCreature) {
    if (GetObjectType(oCreature)!=OBJECT_TYPE_CREATURE) return -1;
    if (!StoreCampaignObject(HAIR_TEMPORARY_DATABASE_NAME,HAIR_VARIABLE_NAME,oCreature)) return -2;
    int nHair = StringToInt(NWNXGetString("CRAFTER", "GetValue|"+HAIR_TEMPORARY_DATABASE_NAME, HAIR_ROADMAP, 0));
    DestroyCampaignDatabase(HAIR_TEMPORARY_DATABASE_NAME);
    return nHair;
}
*/
void main()
{
    object oScryer = GetItemActivator();
	string sScryer = GetName(oScryer);
	object oTarget = GetItemActivatedTarget();
	string sTarget = GetName(oTarget);
	object oKit = GetItemActivated();
	object oToken;
	//int nHair = GetHairStyle(oTarget);
	//SendMessageToPC(oScryer, "nHairStyle = " + IntToString(nHair));
	//Bald Dwarf = 17, Facial Hair 0;
	//Bald Human = 17, Facial Hair 0;
	if(oScryer == oTarget) {
		oToken = CreateItemOnObject("abr_it_scry_body", oScryer, 1);
		SendMessageToPC(oScryer, "A brief shimmer envelopes your hand and the " + GetName(oToken));
		SetFirstName(oToken, GetName(oScryer) + "'s Body Part");
		}
		
	else if((oScryer != oTarget) && (GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)) {
		int nPickDC = 20;
		if(GetIsEnemy(oScryer, oTarget)) {
			nPickDC = 30;
		}
		
		int nSleightRank = GetSkillRank(SKILL_SLEIGHT_OF_HAND, oScryer, FALSE);
			
		if(nSleightRank > 0) {
			int nSleightRoll = d20(1);
			int nSleightCheck = nSleightRoll + nSleightRank;
			string sSuccess = "success";
			if (nSleightCheck < nPickDC) {
				sSuccess = "failure";
				}
				
			SendMessageToPC(oScryer,  "<color=cyan>" + GetName(oScryer) + ":</color> <color=lightblue>Sleight of Hand: *" + sSuccess + "*: " + IntToString(nSleightRoll) + " + " + IntToString(nSleightRank) + " = " + IntToString(nSleightCheck) + " vs DC" + IntToString(nPickDC) + "</color>");
			
			if(nSleightCheck >= nPickDC + 5) {
				oToken = CreateItemOnObject("abr_it_scry_body", oScryer, 1);
				SendMessageToPC(oScryer, "You snip a lock of hair from " + GetName(oTarget) + ". A brief shimmer envelopes your hand and the lock of hair.");
				SetFirstName(oToken, "Lock of " + GetName(oTarget) + "'s Hair");
				SetStolenFlag(oToken, TRUE);
				DelayCommand(1.0, SendMessageToPC(oTarget, "You catch a brief shimmer near your head out of the corner of your eye."));
				}
			else if(nSleightCheck >= nPickDC) {
				DelayCommand(1.0, SendMessageToPC(oTarget, "A brief shimmer near your gear catches your eye."));
				object oInventory = GetFirstItemInInventory(oTarget);
				int nPickable = 0;
				while (oInventory != OBJECT_INVALID) {
				if(GetPickpocketableFlag(oInventory) == TRUE) {
					nPickable++;
					}
				oInventory = GetNextItemInInventory(oTarget);
				}
				
				if(nPickable > 0) {
					int nPickRand = Random(nPickable);
					int nPickCount = 0;
					object oPickInventory = GetFirstItemInInventory(oTarget);
					string sPickInventory = GetName(oPickInventory);
					while (oPickInventory != OBJECT_INVALID) {
					if(GetPickpocketableFlag(oPickInventory) == TRUE) {
						nPickCount++;
						if(nPickCount == nPickRand) {
							break;
							}
						}
					oPickInventory = GetNextItemInInventory(oTarget);
					}
					
					sPickInventory = GetName(oPickInventory);
					SendMessageToPC(oScryer, "You snip " + GetArticle(sPickInventory) + " " + sPickInventory + " from " + GetName(oTarget) + ". A brief shimmer envelopes your hand and the " + sPickInventory + ".");
					oToken = CopyObject(oPickInventory, GetLocation(oScryer), oScryer, "abr_it_scry_possess");
					SetFirstName(oToken, GetName(oTarget) + "'s " + sPickInventory);
					SetStolenFlag(oToken, TRUE);
					DestroyObject(oPickInventory);
					}
					
				else {
					SendMessageToPC(oScryer, "You snip away a fragment of clothing from " + GetName(oTarget) + ".");
					oToken = CreateItemOnObject("abr_it_scry_possess", oScryer, 1);
					SetFirstName(oToken, "Fragment of " + GetName(oTarget) + "'s Clothing.");
					SetStolenFlag(oToken, TRUE);
					}
				}
				 
			int nSpotBonus = 0;
			if(nSleightRoll == 1) 	{
				nSpotBonus = 5;
				}
			int nSpotRank = GetSkillRank(SKILL_SPOT, oTarget, FALSE);
			int nSpotCheck = d20(1) + nSpotRank + nSpotBonus;
			if(nSpotCheck >= nSleightCheck) {
				int nRace = GetRacialType(oScryer);
				string sRace = "human";
				if(nRace == RACIAL_TYPE_DWARF) {
					sRace = "dwarf";
					}
				if(nRace == RACIAL_TYPE_ELF) {
					sRace = "elf";
					}
				if(nRace == RACIAL_TYPE_GNOME) {
					sRace = "gnome";
					}
				if(nRace == RACIAL_TYPE_HALFELF) {
					sRace = "half elf";
					}
				if(nRace == RACIAL_TYPE_HALFLING) {
					sRace = "halfling";
					}
				if(nRace == RACIAL_TYPE_HALFORC) {
					sRace = "half orc";
					}
				
				int nGender = GetGender(oScryer);
				string sGender = "male";
				if(nGender == GENDER_FEMALE) {
					sGender = "female";
					}
				SendMessageToPC(oScryer, "You have been detected!");
				SendMessageToPC(oTarget, "You detect a " +sGender + " " + sRace + " trying to steal from you!");
				if(GetIsPC(oTarget) == FALSE) {
					SetIsTemporaryEnemy(oScryer, oTarget, TRUE, 10.0);
					AdjustReputation(oScryer, oTarget, -10);
					int nEnmity = GetIsEnemy(oScryer, oTarget);
					SendMessageToPC(oScryer, "Enmity = " + IntToString(nEnmity));
					int nReputation = GetReputation(oScryer, oTarget);
					SendMessageToPC(oScryer, "nReputation = " + IntToString(nReputation));
					
					//if(GetStealthMode(oScryer) == STEALTH_MODE_DISABLED) {
					if(GetIsEnemy(oScryer, oTarget)) {
						AssignCommand(oTarget, ActionAttack(oScryer));
						}
					}
				}
			}
			
		else {
			SendMessageToPC(oScryer, "Snipping a purse takes skill. Snipping a body part takes even more skill. If the target won't give a personal token to you out of friendship, you'll need those skills to get it otherwise.");
		}
		
		SignalEvent(oTarget, EventUserDefined(EVENT_DISTURBED));
		}
	
	if(GetObjectType(oTarget) == OBJECT_TYPE_ITEM) {
		oToken = CreateItemOnObject("abr_it_scry_possess", oScryer, 1);
		SendMessageToPC(oScryer, "A brief shimmer envelopes your hand and the " + GetName(oTarget));
		SetFirstName(oToken, GetName(oScryer) + "'s " + GetName(oTarget));
		DestroyObject(oTarget);
		}
		
	if(FindSubString(sScryer, "'") != -1) {
		int nPos = FindSubString(sScryer, "'", 0);
		ACR_SetPersistentString(oToken, "sPScryerName", SpliceString(sScryer, nPos, 1));
		SendMessageToPC(oScryer, "Kit: sScryerName = " + sScryer);
		SendMessageToPC(oScryer, "Kit: sPScryerName = " + ACR_GetPersistentString(oToken, "sPScryerName"));
		}
		
	if(FindSubString(sTarget, "'") != -1) {
		int nPosTarget = FindSubString(sTarget, "'", 0);
		ACR_SetPersistentString(oToken, "sPScryerName", SpliceString(sTarget, nPosTarget, 1));
		SendMessageToPC(oScryer, "Kit: sTargetName = " + sTarget);
		SendMessageToPC(oScryer, "Kit: sPTargetName = " + ACR_GetPersistentString(oToken, "sPTargetName"));
		}
	}