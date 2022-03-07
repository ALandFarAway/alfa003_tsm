//Custom Traps Trigger Enter
// Wynna 03/05/22


#include "acr_trigger_i"
#include "x0_i0_spells"
#include "acr_traps_i"


void main()
{
    ACR_TriggerOnEnter();
	SendMessageToAllDMs("trapentered_custom called");
	SetLocalObject(OBJECT_SELF, "oVictim", GetEnteringObject());
	ExecuteScript("tsm_traptriggered_custom", OBJECT_SELF);
	
   	
}