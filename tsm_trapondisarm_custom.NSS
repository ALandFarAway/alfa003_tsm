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
	if(GetObjectType(OBJECT_SELF) == OBJECT_TYPE_PLACEABLE) {oTrapPlc = OBJECT_SELF;}
	object oTrapTrg = GetNearestObjectByTag(sTrapTrg, OBJECT_SELF, 1);
	if(GetObjectType(OBJECT_SELF) == OBJECT_TYPE_TRIGGER) {oTrapTrg = OBJECT_SELF;}
	string sTrapDoor = GetLocalString(OBJECT_SELF, "TRAP_DOOR_TAG");
	object oTrapDoor = GetNearestObjectByTag(sTrapDoor, OBJECT_SELF, 1);
	string sDisarmSucceed = GetLocalString(OBJECT_SELF, "MSG_DISARM_SUCCEED");
   		
   SetTrapActive(oTrapPlc, FALSE);
   SetTrapActive(oTrapTrg, FALSE);
   DelayCommand(1800.0, SetTrapActive(oTrapPlc, FALSE));
   DelayCommand(1800.0, SetTrapActive(oTrapTrg, FALSE));
   
   SendMessageToPC(oDisarmer, sDisarmSucceed);
   SendMessageToAllDMs(GetName(oDisarmer) + " got " + sDisarmSucceed);
   if(GetTag(OBJECT_SELF) == "rr_door_ritual_plc") {
  		 AssignCommand(oTrapPlc, ActionSpeakString("*Slides down out of the way, revealing a hallway beyond. The noise of chanting swelling to a triumphant finish is suddenly audible." , TALKVOLUME_TALK));
		 AssignCommand(oTrapPlc, ActionPlayAnimation(ANIMATION_PLACEABLE_OPEN, 1.0, 4.0));
		 DestroyObject(OBJECT_SELF, 2.0);
		 DestroyObject(oTrapDoor, 2.0); 
   	}		
}