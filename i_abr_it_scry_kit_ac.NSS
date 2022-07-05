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
			object oInventory = GetFirstItemInInventory(oTarget);
			int nPickable = 0;
			while (oInventory != OBJECT_INVALID) {
			if(GetPickpocketableFlag(oInventory) == TRUE) {
				nPickable++;
				}
			oInventory = GetNextItemInInventory(oTarget);
			}
			SendMessageToPC(oScryer, "nPickable = " + IntToString(nPickable));
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
			SendMessageToPC(oScryer, "oPickInventory = " + sPickInventory);
			
			int nSleightRoll = d20(1);
			int nSleightCheck = nSleightRoll + nSleightRank;
			string sSuccess = "success";
			if (nSleightCheck < nPickDC) {
				sSuccess = "failure";
			}
			
			SendMessageToPC(oScryer,  "<color=cyan>" + GetName(oScryer) + "</color><color=blue>Sleight of Hand: *" + sSuccess + "*: " + IntToString(nSleightRoll) + " + " + IntToString(nSleightRank) + " = " + IntToString(nSleightCheck) + " vs DC" + IntToString(nPickDC) + "</color>");
			
			
			if(nSleightCheck >= nPickDC + 5) {
				oToken = CreateItemOnObject("abr_it_scry_body", oScryer, 1);
				SetFirstName(oToken, GetName(oTarget) + "'s Body Part");
			}
			else if(nSleightCheck >= nPickDC) {
				oToken = CreateItemOnObject("abr_it_scry_possess", oScryer, 1);
				SetFirstName(oToken, "Fragment of " + GetName(oTarget) + "'s " + sPickInventory);
			}
			
			int nSpotRank = GetSkillRank(SKILL_SPOT, oTarget, FALSE);
			int nSpotCheck = d20(1) + nSpotRank;
			if(nSpotCheck >= nSleightCheck) {
				SendMessageToPC(oScryer, "You have been detected!");
			}
			
		}
		
		SignalEvent(oTarget, EventUserDefined(EVENT_DISTURBED));
		
		}
	
	if(GetObjectType(oTarget) == OBJECT_TYPE_ITEM) {
		oToken = CreateItemOnObject("abr_it_scry_possess", oScryer, 1);
		SetFirstName(oToken, GetName(oScryer) + "'s Possession");
		}
		
	//ACR_SetPersistentString(oToken, "sPScryerName", sScryer);
	//ACR_SetPersistentString(oToken, "sPTargetName", sTarget);
									
}