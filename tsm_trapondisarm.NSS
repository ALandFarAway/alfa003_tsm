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
   
   
}