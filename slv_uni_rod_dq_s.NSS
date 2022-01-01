#include "silvy_univ_inc"
#include "silvy_univ_func"
#include "acr_quest_i"



void main()
{
    object oDM = GetItemActivator();
	if(oDM == OBJECT_INVALID)
		{oDM = OBJECT_SELF;
		}
    
    object oStudent = GetItemActivatedTarget();
	string sDQInc = GetLocalString(oDM, "deanquest_inc");
	string sDQDec = GetLocalString(oDM, "deanquest_dec");
	int nDQParty = GetLocalInt(oDM, "deanquest_party");
	string sDQParty = "";
	if(nDQParty == 1)
		{string sDQParty = " Party";}
	
	

//University Rod Change Dean's Quest States
	
if(sDQInc != "")
		 {if((GetIsDM(oDM)) || (GetIsDMPossessed(oDM)) || (FindSubString(GetName(oDM), "Wynna", 0) != -1))
			{int nQuestState= ACR_RetrieveQuestState("slv_deansphinx_" + sDQInc,  oStudent);
			 SendMessageToPC(oDM, "deansphinx " + sDQInc + " = " + IntToString(ACR_RetrieveQuestState("slv_deansphinx_" + sDQInc, oStudent)) + " for " + GetName(oStudent) + sDQParty);
			 ACR_AddPersistentJournalQuestEntry("slv_deansphinx_" + sDQInc, nQuestState +1, oStudent, nDQParty, 0, 0, 0);
			 SendMessageToPC(oDM, "deansphinx " + sDQInc + " changed to " + IntToString(ACR_RetrieveQuestState("slv_deansphinx_" + sDQInc, oStudent)) + " for " + GetName(oStudent));
			 SetLocalString(oDM, "deanquest_inc", "");
			 SetLocalInt(oDM, "deanquest_party", 0);
			}
		}
			
	else if(sDQDec != "")
		 {if((GetIsDM(oDM)) || (GetIsDMPossessed(oDM))  || (FindSubString(GetName(oDM), "Wynna", 0) != -1))
			{int nQuestState= ACR_RetrieveQuestState("slv_deansphinx_" + sDQDec,  oStudent);
			 int nNewState = nQuestState-1;
			 SendMessageToPC(oDM, "deansphinx " + sDQDec + " = " + IntToString(ACR_RetrieveQuestState("slv_deansphinx_" + sDQDec, oStudent)) + " for " + GetName(oStudent));
			 ACR_RemovePersistentJournalQuestEntry("slv_deansphinx_" + sDQDec, oStudent, 0, 0);
			 DelayCommand(1.0, ACR_AddPersistentJournalQuestEntry("slv_deansphinx_" + sDQDec, nNewState, oStudent, nDQParty, 0, 0, 0));
			 DelayCommand(2.0, SendMessageToPC(oDM, "deansphinx " + sDQDec + " changed to " + IntToString(ACR_RetrieveQuestState("slv_deansphinx_" + sDQDec, oStudent)) + " for " + GetName(oStudent) + sDQParty));
			 DelayCommand(3.0, SetLocalString(oDM, "deanquest_dec", ""));
			 SetLocalInt(oDM, "deanquest_party", 0);
			}
		}
	
	if((FindSubString(GetName(oDM), "Wynna", 0) != -1)&&  (FindSubString(GetName(oStudent), "Wynna", 0) != -1))
		{int nGiveGold = GetLocalInt(oDM, "TestPCGold");
		 int nGiveXP = GetLocalInt(oDM, "TestPCXP");
		 if(nGiveGold == 1)
		 	{GiveGoldToCreature(oStudent, 1000, TRUE);
			 SetLocalInt(oDM, "TestPCGold", 0);}
		 if(nGiveXP == 1)
		 	{GiveXPToCreature(oStudent, 5000);
			 SetLocalInt(oDM, "TestPCXP", 0);
			 }
		 }
		
}