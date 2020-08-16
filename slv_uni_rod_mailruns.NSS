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
	int nTSMMail = ACR_GetPersistentInt(oPC, "tsmmail_delivery");
	int nHHMail = ACR_GetPersistentInt(oPC, "mailhh1_d");
	int nQVMail = ACR_GetPersistentInt(oPC, "mailqv0_d");
	int nRMMail = ACR_GetPersistentInt(oPC, "mailrm2_d");
	int nKHMail = ACR_GetPersistentInt(oPC, "mailkh3_d");
	int nCFMail = ACR_GetPersistentInt(oPC, "mailcf4_d");
	int nSBMail = ACR_GetPersistentInt(oPC, "mailsb5_d");
	int nAVMail = ACR_GetPersistentInt(oPC, "mailav6_d");
	int nWEMail = ACR_GetPersistentInt(oPC, "mailwe7_d");
	int nSSMail = ACR_GetPersistentInt(oPC, "mailss8_d");
	string sTSMMail = IntToString(nTSMMail);
	string sHHMail = IntToString(nHHMail);
	string sQVMail = IntToString(nQVMail);
	string sRMMail = IntToString(nRMMail);
	string sKHMail = IntToString(nKHMail);
	string sCFMail = IntToString(nCFMail);
	string sSBMail = IntToString(nSBMail);
	string sWEMail = IntToString(nWEMail);
	string sAVMail = IntToString(nAVMail);
	string sSSMail = IntToString(nSSMail);
	
	
//University Rod List TSM Mail Quest States
	
 
	SendMessageToPC(oDM, GetName(oPC) + " tsmmail_delivery = " + sTSMMail + "." );
	SendMessageToPC(oDM, GetName(oPC) + " mailqv0_d = " + sQVMail + "." );
	SendMessageToPC(oDM, GetName(oPC) + " mailhh1_d = " + sHHMail + "." );
	SendMessageToPC(oDM, GetName(oPC) + " mailrm2_d = " + sRMMail + "." );
	SendMessageToPC(oDM, GetName(oPC) + " mailkh3_d = " + sKHMail + "." );
	SendMessageToPC(oDM, GetName(oPC) + " mailcf4_d = " + sCFMail + "." );
	SendMessageToPC(oDM, GetName(oPC) + " mailsb5_d = " + sSBMail + "." );
	SendMessageToPC(oDM, GetName(oPC) + " mailav6_d = " + sWEMail + "." );
	SendMessageToPC(oDM, GetName(oPC) + " mailwe7_d = " + sAVMail + "." );
	SendMessageToPC(oDM, GetName(oPC) + " mailss8_d = " + sSSMail + "." );

	
	
	
		
}