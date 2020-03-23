#include "silvy_univ_inc"
#include "silvy_univ_func"
#include "acr_quest_i"



void main()
{
    object oDM = GetItemActivator();
	if(oDM == OBJECT_INVALID)
		{oDM = OBJECT_SELF;
		}
    
    object oPC = GetItemActivatedTarget();
	int nStaticInc = GetLocalInt(oDM, "wand_static_inc");
	int nStaticDec = GetLocalInt(oDM, "wand_static_dec");
	string sStaticQuestTag = GetLocalString(oDM, "wand_static_change");
	

//University Rod Change Dean's Quest States
	
if(nStaticInc != 0)
		 {if((GetIsDM(oDM)) || (GetIsDMPossessed(oDM)) || (FindSubString(GetName(oDM), "Wynna", 0) != -1))
			{int nQuestState= ACR_RetrieveQuestState(sStaticQuestTag, oPC);
			 SendMessageToPC(oDM, sStaticQuestTag + " = " + IntToString(ACR_RetrieveQuestState(sStaticQuestTag, oPC)) + " for " + GetName(oPC));
			 ACR_AddPersistentJournalQuestEntry(sStaticQuestTag, nQuestState +1, oPC, 0, 0, 0, 0);
			 SendMessageToPC(oDM, sStaticQuestTag + " changed to " + IntToString(ACR_RetrieveQuestState(sStaticQuestTag, oPC)) + " for " + GetName(oPC));
			 SetLocalInt(oDM, "wand_static_inc", 0);
			 }
		}
			
	else if(nStaticDec != 0)
		 {if((GetIsDM(oDM)) || (GetIsDMPossessed(oDM))  || (FindSubString(GetName(oDM), "Wynna", 0) != -1))
			{int nQuestState= ACR_RetrieveQuestState(sStaticQuestTag,  oPC);
			 int nNewState = nQuestState-1;
			 SendMessageToPC(oDM, sStaticQuestTag + " = " + IntToString(ACR_RetrieveQuestState(sStaticQuestTag, oPC)) + " for " + GetName(oPC));
			 ACR_RemovePersistentJournalQuestEntry(sStaticQuestTag, oPC, 0, 0);
			 DelayCommand(1.0, ACR_AddPersistentJournalQuestEntry(sStaticQuestTag, nNewState, oPC, 0, 0, 0, 0));
			 DelayCommand(2.0, SendMessageToPC(oDM, sStaticQuestTag + " changed to " + IntToString(ACR_RetrieveQuestState(sStaticQuestTag, oPC)) + " for " + GetName(oPC)));
			 DelayCommand(3.0, SetLocalInt(oDM, "wand_static_dec", 0));
			}
		}
	
	
		
}