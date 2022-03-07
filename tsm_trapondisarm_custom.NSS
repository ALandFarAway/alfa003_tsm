//Wynna 03/05/22
#include "acr_trigger_i"
#include "acr_traps_i"
#include "acr_placeable_i"


void main()
{
    ACR_TriggerOnDisarm();
	ACR_PlaceableOnDisarm();

   SendMessageToAllDMs(GetName(OBJECT_SELF) + " called trap_ondisarm.");
   
   object oDisarmer = GetLastDisarmed();
   string sDisarmer = GetName(oDisarmer);
   if(oDisarmer == OBJECT_INVALID)
   	{sDisarmer = "INVALID";}
   
   SendMessageToAllDMs("GetLastDisarmed is " + sDisarmer);
   
   string sTrapPlc = GetLocalString(OBJECT_SELF, "TRAP_PLC_TAG");
   string sTrapTrg = GetLocalString(OBJECT_SELF, "TRAP_TRG_TAG");
   object oTrapPlc = GetNearestObjectByTag(sTrapPlc, OBJECT_SELF, 1);
   object oTrapTrg = GetNearestObjectByTag(sTrapTrg, OBJECT_SELF, 1);
   string sDisarmSucceed = GetLocalString(OBJECT_SELF, "MSG_DISARM_SUCCEED");
   		
   SetTrapDisabled(oTrapPlc);
   SetTrapDisabled(oTrapTrg);
   SendMessageToPC(oDisarmer, sDisarmSucceed);
   SendMessageToAllDMs(GetName(oDisarmer) + " got " + sDisarmSucceed);
			
}