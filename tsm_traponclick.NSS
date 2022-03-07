//Wynna 03/05/22

#include "acr_trigger_i"
#include "acr_traps_i"


void main()
{
   SendMessageToAllDMs("TrapDisarmAttempt called");
   TrapDisarmAttempt();
   object oDisarmer = GetLastDisarmed();
   string sDisarmer = GetName(oDisarmer);
   if(oDisarmer == OBJECT_INVALID)
   	{sDisarmer = "INVALID";}
   
   SendMessageToAllDMs("GetLastDisarmed is " + sDisarmer);
   


}