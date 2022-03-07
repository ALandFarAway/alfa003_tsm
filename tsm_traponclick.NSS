//Wynna 03/05/22

#include "acr_trigger_i"
#include "acr_traps_i"


void main()
{
   SendMessageToAllDMs(GetName(OBJECT_SELF) + " calls traponclick.");
   TrapDisarmAttempt();
   
    string sPlaceableString=GetLocalString(OBJECT_SELF, "PLACEABLE_TAG");
	object oPlaceable = GetNearestObjectByTag(sPlaceableString, OBJECT_SELF,1);
	
	string sTriggerString=GetLocalString(OBJECT_SELF, "TRIGGER_TAG");
	object oTrigger = GetNearestObjectByTag(sTriggerString, OBJECT_SELF,1);
	
	
	string sEntered = GetLocalString(oTrigger, "MSG_ENTERED");
	string sDisarmFail = GetLocalString(oTrigger, "MSG_DISARM_FAIL");
	string sDisarmSucceed = GetLocalString(oTrigger, "MSG_DISARM_SUCCEED");
	string sDmgSuccess=GetLocalString(oTrigger, "MSG_DMG_FAIL");
	string sDmgFail=GetLocalString(oTrigger, "MSG_DMG_SUCCEED");
			 
	int nReflexDC = GetLocalInt(oTrigger, "ACR_TRAP_SAVE_DC");
	int nDiceType = GetLocalInt(oTrigger, "ACR_TRAP_DICE_TYPE");
	int nDiceNumber = GetLocalInt(oTrigger, "ACR_TRAP_DICE_NUMBER");
		
   


}