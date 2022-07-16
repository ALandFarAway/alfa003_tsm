
//Wynna April 2022


#include "acr_trigger_i"
#include "acr_spawn_i"
#include "acr_tools_i"
#include "acr_creature_i"

void main()
{	
	ACR_TriggerOnEnter();
	object oPC = GetEnteringObject();
	object oArea = GetArea(oPC);
	object oAntipathy = GetNearestObjectByTag("rr_temple_WP", OBJECT_SELF, 1);
    int nCleric = GetClassPosition(oPC, CLASS_TYPE_CLERIC);
	int nDruid = GetClassPosition(oPC, CLASS_TYPE_DRUID);
    int nRanger = GetClassPosition(oPC, CLASS_TYPE_RANGER);
    int nPaladin = GetClassPosition(oPC, CLASS_TYPE_PALADIN);
    object oNonDivineWP = GetWaypointByTag("phalorm_earth_down_wp");
	object oDivineEnterWP = GetWaypointByTag("rr_temple_in_WP");
	object oDivineExitWP = GetWaypointByTag("rr_temple_out_WP");
	object oJumpTo;
	
	if((GetTag(OBJECT_SELF) == "rr_temple_ward_out") || (GetTag(OBJECT_SELF) == "rr_temple_ward_in")) {
		if((nCleric <= 0) && (nDruid <= 0) && (nRanger <= 0) && (nPaladin <= 0))
		oJumpTo = oNonDivineWP;
	}
	
	if(GetTag(OBJECT_SELF) == "rr_temple_ward_out") {
		if((nCleric >= 1) || (nDruid >= 1) || (nRanger >= 1) || (nPaladin || 1))
		oJumpTo = oDivineExitWP;
	}
	
	if(GetTag(OBJECT_SELF) == "rr_temple_ward_in") {
		if((nCleric >= 1) || (nDruid >= 1) || (nRanger >= 1) || (nPaladin || 1))
		oJumpTo = oDivineEnterWP;
	}
		
	AssignCommand(oPC, ActionJumpToObject(oJumpTo, FALSE));
	
	if(GetTag(OBJECT_SELF) == "rr_temple_ward")
        {AssignCommand(oPC, ActionMoveToObject(oAntipathy, TRUE, 1.0));
         SendMessageToPC(oPC, "You feel physically repelled from going further.  You are driven back.");
        }

}