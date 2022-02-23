//High Forest Trigger OnEnter. All triggers.
//Wynna July 2020


#include "acr_trigger_i"
#include "acr_spawn_i"
#include "acr_tools_i"
#include "acr_quest_i"
#include "acr_hazards_i"


void ActionCreateWynPlacedEffect(string sPlacedEffect, location lLocPlaceEffect)
{
    CreateObject(OBJECT_TYPE_PLACED_EFFECT, sPlacedEffect, lLocPlaceEffect);
}

void main()
{	
	ACR_TriggerOnEnter();
	object oPC = GetEnteringObject();
    

if(GetTag(OBJECT_SELF) == "phalorm_glacier_enter") {
		object oThereWP = GetWaypointByTag("WP_phalorm_glacier_platform_exit");
		object oHereWP = GetWaypointByTag("WP_phalorm_glacier_platform_enter");
		object oGoThere = GetWaypointByTag("WP_phalorm_glacier_enter");
		location lThere = GetLocation(oThereWP);
		location lHere = GetLocation(oHereWP);
		location lGoThere = GetLocation(oGoThere);
		
		if(((GetItemPossessedBy(oPC, "003_it_phalorm_diamond")!= OBJECT_INVALID) || (GetItemPossessedBy(oPC, "003_it_phalorm_sapphire")!= OBJECT_INVALID)) && (GetLocalInt(OBJECT_SELF, "Activated") != 1)) {
			SetLocalInt(OBJECT_SELF, "Activated", 1); 
			object oThereBeam = CreateObject(OBJECT_TYPE_PLACED_EFFECT, "fx_spirit_trap_barrier02", lThere);
			object oPlatformHere = CreateObject(OBJECT_TYPE_PLACEABLE,"phalorm_platform_active", lHere);
			object oPlatformThere = CreateObject(OBJECT_TYPE_PLACEABLE,"phalorm_platform_active", lThere);
			DelayCommand(1.0, SendMessageToPC(oPC, "A light blinks on beneath your feet. A clear white light rises around you. You feel yourself shift suddenly and find yourself in another place."));
			DelayCommand(2.0, ActionCreateWynPlacedEffect("fx_spirit_trap_barrier02", lHere));
			}
		
		else if(GetLocalInt(OBJECT_SELF, "Activated") == 1) {
			DelayCommand(1.0, SendMessageToPC(oPC, "You feel yourself shift and find yourself in another place."));
			DelayCommand(3.0, AssignCommand(oPC, ActionJumpToLocation(lGoThere)));	 
			}
	}
		
	if(GetTag(OBJECT_SELF) == "phalorm_glacier_exit") {
		object oThereWP = GetWaypointByTag("WP_phalorm_glacier_platform_enter");
		object oHereWP = GetWaypointByTag("WP_phalorm_glacier_platform_exit");
		object oGoThere = GetWaypointByTag("WP_phalorm_glacier_exit");
		location lThere = GetLocation(oThereWP);
		location lHere = GetLocation(oHereWP);
		location lGoThere = GetLocation(oGoThere);
		
	if((GetItemPossessedBy(oPC, "003_it_phalorm_diamond")!= OBJECT_INVALID)  && (GetLocalInt(OBJECT_SELF, "Activated") != 1)) {
			SetLocalInt(OBJECT_SELF, "Activated", 1); 
			DelayCommand(3.0, AssignCommand(oPC, ActionJumpToLocation(lGoThere)));	 
			object oThereBeam = CreateObject(OBJECT_TYPE_PLACED_EFFECT, "fx_spirit_trap_barrier02", lThere);
			object oPlatformHere = CreateObject(OBJECT_TYPE_PLACEABLE,"phalorm_platform_active", lHere);
			object oPlatformThere = CreateObject(OBJECT_TYPE_PLACEABLE,"phalorm_platform_active", lThere);
			DelayCommand(1.0, SendMessageToPC(oPC, "A light blinks on beneath your feet. A clear white light rises around you. You feel yourself shift suddenly and find yourself in another place."));
			DelayCommand(2.0, ActionCreateWynPlacedEffect("fx_spirit_trap_barrier02", lHere));
			}
		else if(GetLocalInt(OBJECT_SELF, "Activated") == 1) {
			DelayCommand(1.0, SendMessageToPC(oPC, "You feel yourself shift and find yourself in another place."));
			DelayCommand(3.0, AssignCommand(oPC, ActionJumpToLocation(lGoThere)));	 
			}
	}
}