////////////////////////////////////////////////////////////////////////////////
//
//  System Name : Portals
//     Filename : tsm_portal_plc_onuse.nss
//        $Date:: 2022-08-01 
//       Author : Wynna
//
//  This script looks for a variable upon a portal object that identifies the portal
//  key and destination, with options for keys that are items in the traveller's 
//  inventory or worn, and multiple possible destinations. 
//  It is not updated in ACR updates.
//

#include "acr_placeable_i"
#include "dmfi_inc_langexe" 
#include "acr_quest_i"

void main() {
 
	if (!GetIsObjectValid(OBJECT_SELF))
		return;

	ACR_PlaceableOnUsed();


	if(FindSubString(GetTag(OBJECT_SELF), "_portal") != -1)
	{object oTraveller = GetLastUsedBy();
    
	//SendMessageToPC(oTraveller, "Portal Used");
		 
	string sKeyTag = GetLocalString(OBJECT_SELF, "PORTAL_KEY");
	string sKeyTagTwo = GetLocalString(OBJECT_SELF, "PORTAL_KEY_2");
	string sKeyTagThree = GetLocalString(OBJECT_SELF, "PORTAL_KEY_3");
	string sKeyTagFour = GetLocalString(OBJECT_SELF, "PORTAL_KEY_4");
	string sKeyTagFive = GetLocalString(OBJECT_SELF, "PORTAL_KEY_5");
	string sKeyTagSix = GetLocalString(OBJECT_SELF, "PORTAL_KEY_6");
	string sMyTarget = GetLocalString(OBJECT_SELF, "PORTAL_TARGET_WP");
	string sMyTargetTwo = GetLocalString(OBJECT_SELF, "PORTAL_TARGET_WP2");
	string sMyTargetThree = GetLocalString(OBJECT_SELF, "PORTAL_TARGET_WP3");
	string sMyTargetFour = GetLocalString(OBJECT_SELF, "PORTAL_TARGET_WP4");
	string sMyTargetFive = GetLocalString(OBJECT_SELF, "PORTAL_TARGET_WP5");
	string sMyTargetSix = GetLocalString(OBJECT_SELF, "PORTAL_TARGET_WP6");
	object oMyWaypoint = GetWaypointByTag(sMyTarget);
	effect eVis = EffectVisualEffect(VFX_IMP_TORNADO);
    effect eAoe = EffectVisualEffect(VFX_HIT_AOE_CONJURATION);
    effect eCessate = EffectVisualEffect(VFX_DUR_CESSATE_NEUTRAL);
    
//	SendMessageToPC(oTraveller, "1. oMyWaypoint = " + GetName(oMyWaypoint));
//	oMyWaypoint = GetObjectByTag(sMyTarget, 0);	 
	//SendMessageToPC(oTraveller, "2. oMyWaypoint = " + GetName(oMyWaypoint));
	if(GetLocalInt(OBJECT_SELF, "Activated") == 1) {
		 oMyWaypoint = GetLocalObject(OBJECT_SELF, "sCurrent_WP");
		 ApplyEffectToObject(DURATION_TYPE_INSTANT, eAoe, OBJECT_SELF);
    	 ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTraveller);
         DelayCommand(2.0, AssignCommand(oTraveller, ActionJumpToObject(oMyWaypoint)));
		 }
	
	else if(GetLocalInt(OBJECT_SELF, "Activated") == 0) {
		object oMask = GetItemInSlot(INVENTORY_SLOT_HEAD, oTraveller);
		object oKey = GetItemPossessedBy(oTraveller, sKeyTag);
		
		if((sKeyTag == "") || ((sKeyTag != "" ) && (oKey != OBJECT_INVALID))) {
			SetLocalInt(OBJECT_SELF, "Activated", 1);
		    oMyWaypoint = GetWaypointByTag(sMyTarget);
			}
		
		//Custom coding for campaign Mask objects
		else if((GetTag(oMask) == sKeyTag) || (GetTag(oMask) == sKeyTagTwo)  || (GetTag(oMask) == sKeyTagThree) || (GetTag(oMask) == sKeyTagFour) || (GetTag(oMask) == sKeyTagFive) || (GetTag(oMask) == sKeyTagSix)){
		 //SendMessageToPC(oTraveller, "Activated");
		 	SetLocalInt(OBJECT_SELF, "Activated", 1);
		 
			 if(GetTag(oMask) == sKeyTag)
			 	{//SendMessageToPC(oTraveller, "1 " + sKeyTag + "..." + sMyTarget);
			      oMyWaypoint = GetWaypointByTag(sMyTarget);}
			 else if(GetTag(oMask) == sKeyTagTwo)
			 	{//SendMessageToPC(oTraveller, "2 " + sKeyTagTwo + "..." + sMyTargetTwo);
			      oMyWaypoint = GetWaypointByTag(sMyTargetTwo);
				  //SendMessageToPC(oTraveller, "2b. oMyWaypoint = " + GetName(oMyWaypoint)); 
				  }
			 else if(GetTag(oMask) == sKeyTagThree)
			 	{//SendMessageToPC(oTraveller, "3 " + sKeyTagThree + "..." + sMyTargetThree);
			      oMyWaypoint = GetWaypointByTag(sMyTargetThree);}
			 else if(GetTag(oMask) == sKeyTagFour)
			 	{//SendMessageToPC(oTraveller, "4 " + sKeyTagFour + "..." + sMyTargetFour);
			      oMyWaypoint = GetWaypointByTag(sMyTargetFour);}
			 else if(GetTag(oMask) == sKeyTagFive)
			 	{//SendMessageToPC(oTraveller, "5 " + sKeyTagFive + "..." + sMyTargetFive);
			      oMyWaypoint = GetWaypointByTag(sMyTargetFive);}
			 else if(GetTag(oMask) == sKeyTagSix)
			 	{//SendMessageToPC(oTraveller, "6 " + sKeyTagSix + "..." + sMyTargetSix);
			      oMyWaypoint = GetWaypointByTag(sMyTargetSix);}
				}	
		 
		//SendMessageToPC(oTraveller, "Waypoint = " + GetName(oMyWaypoint));
		 SetLocalObject(OBJECT_SELF, "sCurrent_WP", oMyWaypoint);
		 object oFinalWaypoint = GetLocalObject(OBJECT_SELF, "sCurrent_WP");
		 //SendMessageToPC(oTraveller, "FinalWaypoint = " + GetName(oFinalWaypoint));
		 if(GetLocalInt(OBJECT_SELF, "Activated") == 1) {
			 ApplyEffectToObject(DURATION_TYPE_INSTANT, eAoe, OBJECT_SELF);
	    	 DelayCommand(2.0, AssignCommand(oTraveller, ActionJumpToObject(oFinalWaypoint)));
			 DelayCommand(60.0, SetLocalInt(OBJECT_SELF, "Activated", 0));
			 ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTraveller);
   		  	 DelayCommand(57.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eCessate, OBJECT_SELF, 3.0));
   		  }
		  else { ApplyEffectToObject(DURATION_TYPE_INSTANT, eAoe, OBJECT_SELF);
	    	     SendMessageToPC(oTraveller, "Nothing happens.");
				 if((d20(1) + GetAbilityModifier(ABILITY_WISDOM, oTraveller)) >= 10) {
				 	SendMessageToPC(oTraveller, "You sense the potential power in this object");
					}
		  } 
	}
	
	
	     
	}	
	
		
}