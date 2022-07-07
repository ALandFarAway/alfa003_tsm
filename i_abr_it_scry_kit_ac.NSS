#include "acr_scry_i"

void main()
{
    object oScryer = GetItemActivator();
	string sScryer = GetName(oScryer);
	object oTarget = GetItemActivatedTarget();
	string sTarget = GetName(oTarget);
	object oKit = GetItemActivated();
	object oToken;
	
	if(oScryer == oTarget) {
		oToken = CreateItemOnObject("abr_it_scry_body", oScryer, 1);
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
				SetFirstName(oToken, "Lock of " + GetName(oTarget) + "'s Hair");
				SetStolenFlag(oToken, TRUE);
				}
			else if(nSleightCheck >= nPickDC) {
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
					SendMessageToPC(oScryer, "You steal " + sPickInventory + " from " + GetName(oTarget) + ".");
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
				SendMessageToPC(oScryer, "You have been detected!");
				SendMessageToPC(oTarget, "You detect somebody trying to steal from you!");
				if(GetIsPC(oTarget) == FALSE) {
					AssignCommand(oTarget, ActionSpeakString("Thief!", TALKVOLUME_TALK));
					if(GetStealthMode(oScryer) == STEALTH_MODE_DISABLED) {
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
		SetFirstName(oToken, GetName(oScryer) + "'s Possession");
		}
		
	ACR_SetPersistentString(oToken, "sPScryerName", sScryer);
	ACR_SetPersistentString(oToken, "sPTargetName", sTarget);
									
}