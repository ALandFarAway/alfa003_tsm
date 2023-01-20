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
    

if((GetTag(OBJECT_SELF) == "phlm_glacier_teleport_enter") || (GetTag(OBJECT_SELF) == "phlm_rr_teleport_enter")) {
		object oThereWP;
		object oHereWP;
		object oGoThere;
		if(GetTag(OBJECT_SELF) == "phalorm_rr_enter") {
			 oThereWP = GetWaypointByTag("WP_phalorm_rr_platform_exit");
			 oHereWP = GetWaypointByTag("WP_phalorm_rr_platform_enter");
			 oGoThere = GetWaypointByTag("WP_phalorm_rr_enter");
			}
		else {
		     oThereWP = GetWaypointByTag("WP_phalorm_glacier_platform_exit");
			 oHereWP = GetWaypointByTag("WP_phalorm_glacier_platform_enter");
			 oGoThere = GetWaypointByTag("WP_phalorm_glacier_enter");
			}
			
			location lThere = GetLocation(oThereWP);
			location lHere = GetLocation(oHereWP);
			location lGoThere = GetLocation(oGoThere);
			
		if(((GetItemPossessedBy(oPC, "003_it_phalorm_diamond")!= OBJECT_INVALID) || ((GetTag(OBJECT_SELF) == "phalorm_glacier_enter") && (GetItemPossessedBy(oPC, "003_it_phalorm_sapphire")!= OBJECT_INVALID))  || ((GetTag(OBJECT_SELF) == "phalorm_rr_enter") && (GetItemPossessedBy(oPC, "003_it_phalorm_emerald")!= OBJECT_INVALID))) && (GetLocalInt(OBJECT_SELF, "Activated") != 1)) {
			SetLocalInt(OBJECT_SELF, "Activated", 1); 
			object oThereBeam = CreateObject(OBJECT_TYPE_PLACED_EFFECT, "fx_spirit_trap_barrier02", lThere);
			object oPlatformHere = CreateObject(OBJECT_TYPE_PLACEABLE,"phalorm_platform_active", lHere);
			object oPlatformThere = CreateObject(OBJECT_TYPE_PLACEABLE,"phalorm_platform_active", lThere);
			DelayCommand(1.0, SendMessageToPC(oPC, "A rune lights beneath your feet. A pale blue light rises around you. You feel yourself shift suddenly and find yourself in another place."));
			DelayCommand(2.0, ActionCreateWynPlacedEffect("fx_spirit_trap_barrier02", lHere));
			DelayCommand(3.0, AssignCommand(oPC, ActionJumpToLocation(lGoThere)));	 
			}
		
		else if(GetLocalInt(OBJECT_SELF, "Activated") == 1) {
			DelayCommand(1.0, SendMessageToPC(oPC, "You feel yourself shift and find yourself in another place."));
			DelayCommand(3.0, AssignCommand(oPC, ActionJumpToLocation(lGoThere)));	 
			}
	}
		
	if((GetTag(OBJECT_SELF) == "phlm_glacier_teleport_exit") || (GetTag(OBJECT_SELF) == "phlm_rr_teleport_exit")) {
		object oThereWP;
		object oHereWP;
		object oGoThere;
		
		if(GetTag(OBJECT_SELF) == "phalorm_rr_exit") {
		 oThereWP = GetWaypointByTag("WP_phalorm_rr_platform_enter");
		 oHereWP = GetWaypointByTag("WP_phalorm_rr_platform_exit");
		 oGoThere = GetWaypointByTag("WP_phalorm_rr_exit");
		}
		 
		else {
		 oThereWP = GetWaypointByTag("WP_phalorm_glacier_platform_enter");
		 oHereWP = GetWaypointByTag("WP_phalorm_glacier_platform_exit");
		 oGoThere = GetWaypointByTag("WP_phalorm_glacier_exit");
		}
		
		location lThere = GetLocation(oThereWP);
		location lHere = GetLocation(oHereWP);
		location lGoThere = GetLocation(oGoThere);
		
	  if(((GetItemPossessedBy(oPC, "003_it_phalorm_diamond")!= OBJECT_INVALID) || ((GetTag(OBJECT_SELF) == "phalorm_glacier_exit") && (GetItemPossessedBy(oPC, "003_it_phalorm_sapphire")!= OBJECT_INVALID))  || ((GetTag(OBJECT_SELF) == "phalorm_rr_exit") && (GetItemPossessedBy(oPC, "003_it_phalorm_emerald")!= OBJECT_INVALID))) && (GetLocalInt(OBJECT_SELF, "Activated") != 1)) {
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