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
			while (oPickInventory != OBJECT_INVALID) {
			if(GetPickpocketableFlag(oPickInventory) == TRUE) {
				nPickCount++;
				if(nPickCount == nPickRand) {
					break;
					}
				}
			oPickInventory = GetNextItemInInventory(oTarget);
			}
			
			SendMessageToPC(oScryer, "oPickInventory = " + GetName(oPickInventory));
			
			int nSleightCheck = d20(1) + nSleightRank;
			
			if(nSleightCheck >= 25) {
				oToken = CreateItemOnObject("abr_it_scry_body", oScryer, 1);
				SetFirstName(oToken, GetName(oTarget) + "'s Body Part");
			}
			else if(nSleightCheck >= 20) {
				oToken = CreateItemOnObject("abr_it_scry_possess", oScryer, 1);
				SetFirstName(oToken, GetName(oTarget) + "'s Possession");
			}
			else {AssignCommand(oTarget, ActionSpeakString("Hey! What are you doing?", TALKVOLUME_TALK));}
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