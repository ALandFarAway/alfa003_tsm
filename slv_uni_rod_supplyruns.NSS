#include "silvy_univ_inc"
#include "silvy_univ_func"
#include "acr_quest_i"
#include "acr_db_persist_i"



void main()
{
    object oDM = GetItemActivator();
	if(oDM == OBJECT_INVALID)
		{oDM = OBJECT_SELF;
		}
    
    object oPC = GetItemActivatedTarget();
	int nSupplyInc = GetLocalInt(oDM, "wand_supply_inc");
	int nSupplyDec = GetLocalInt(oDM, "wand_supply_dec");
	string sSupplyQuestTag = GetLocalString(oDM, "wand_supply_change");
	int nQuestState = ACR_GetPersistentInt(oPC, sSupplyQuestTag);
	int nALSupply = ACR_GetPersistentInt(oPC, "alsupply");
	int nRMSupply = ACR_GetPersistentInt(oPC, "rm_supply");
	int nHHSupply = ACR_GetPersistentInt(oPC, "hh_supply");
	int nQVSupply = ACR_GetPersistentInt(oPC, "qv_supply");
	int nWESupply = ACR_GetPersistentInt(oPC, "we_supply");
	string sALSupply = IntToString(nALSupply);
	string sRMSupply = IntToString(nRMSupply);
	string sHHSupply = IntToString(nHHSupply);
	string sQVSupply = IntToString(nQVSupply);
	string sWESupply = IntToString(nWESupply);
	
//University Rod Change TSM Supply Quest States
	
 if((nSupplyInc == 0) && (nSupplyDec == 0)) {
	SendMessageToPC(oDM, GetName(oPC) + " alsupply = " + sALSupply + "." );
	SendMessageToPC(oDM, GetName(oPC) + " rm_supply = " + sRMSupply + "." );
	SendMessageToPC(oDM, GetName(oPC) + " hh_supply = " + sHHSupply + "." );
	SendMessageToPC(oDM, GetName(oPC) + " qv_supply = " + sQVSupply + "." );
	SendMessageToPC(oDM, GetName(oPC) + " we_supply = " + sWESupply + "." );
}




	if(nSupplyInc != 0)
			 {if((GetIsDM(oDM)) || (GetIsDMPossessed(oDM)) || (FindSubString(GetName(oDM), "Wynna", 0) != -1))
				{SendMessageToPC(oDM, sSupplyQuestTag + " = " + IntToString(nQuestState) + " for " + GetName(oPC));
				 ACR_SetPersistentInt(oPC, sSupplyQuestTag, nQuestState +1);
				 SendMessageToPC(oDM, sSupplyQuestTag + " changed to " + IntToString(ACR_GetPersistentInt(oPC, sSupplyQuestTag)) + " for " + GetName(oPC));
				 SetLocalInt(oDM, "wand_supply_inc", 0);
				 }
			}
				
		else if(nSupplyDec != 0)
			 {if((GetIsDM(oDM)) || (GetIsDMPossessed(oDM))  || (FindSubString(GetName(oDM), "Wynna", 0) != -1))
				{SendMessageToPC(oDM, sSupplyQuestTag + " = " + IntToString(nQuestState) + " for " + GetName(oPC));
				 ACR_SetPersistentInt(oPC, sSupplyQuestTag, nQuestState - 1);
				 SendMessageToPC(oDM, sSupplyQuestTag + " changed to " + IntToString(ACR_GetPersistentInt(oPC, sSupplyQuestTag)) + " for " + GetName(oPC));
				 DelayCommand(3.0, SetLocalInt(oDM, "wand_supply_dec", 0));
				}
			}
	
	
		
}