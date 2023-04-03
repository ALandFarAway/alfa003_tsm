//Silvy Uni Trigger OnEnter. All triggers.
//Wynna September 2007


#include "acr_trigger_i"
#include "acr_spawn_i"
#include "acr_tools_i"
#include "acr_quest_i"

void main()
{	
	ACR_TriggerOnEnter();
	

if(FindSubString(GetTag(OBJECT_SELF), "_portal") != -1)
	{
	object oTraveller = GetEnteringObject();
    
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
	
	object oMask = GetItemInSlot(INVENTORY_SLOT_HEAD, oTraveller);
	string sMask = GetTag(oMask);
	
	object oMyWaypoint = GetWaypointByTag(sMyTarget);
	effect eVis = EffectVisualEffect(VFX_IMP_TORNADO);
    effect eAoe = EffectVisualEffect(VFX_HIT_AOE_CONJURATION);
    effect eCessate = EffectVisualEffect(VFX_DUR_CESSATE_NEUTRAL);
    
	
	SendMessageToAllDMs("nActivated = " + IntToString(GetLocalInt(OBJECT_SELF, "Activated")));
	
	if((oMask != OBJECT_INVALID) && (GetLocalInt(OBJECT_SELF, "Activated") != 1) && 
		((sMask == sKeyTag) || (sMask == sKeyTagTwo) || (sMask == sKeyTagThree) || (sMask == sKeyTagFour) || (sMask == sKeyTagFive) || (sMask == sKeyTagSix)))	{
		
			if(sMask == sKeyTag){oMyWaypoint = GetWaypointByTag(sMyTarget);}
			else if(sMask == sKeyTagTwo){oMyWaypoint = GetWaypointByTag(sMyTargetTwo);}
			else if(sMask == sKeyTagThree){oMyWaypoint = GetWaypointByTag(sMyTargetThree);}
			else if(sMask == sKeyTagFour){oMyWaypoint = GetWaypointByTag(sMyTargetFour);}
			else if(sMask == sKeyTagFive){oMyWaypoint = GetWaypointByTag(sMyTargetFive);}
			else if(sMask == sKeyTagSix){oMyWaypoint = GetWaypointByTag(sMyTargetSix);}
				
			SendMessageToAllDMs(GetName(oTraveller) + " is wearing " + sMask + " and is jumping to " + GetTag(oMyWaypoint));
			ApplyEffectToObject(DURATION_TYPE_INSTANT, eAoe, OBJECT_SELF);
		    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTraveller);
	   		if(GetIsDM(oTraveller) == FALSE) {DelayCommand(1.0, AssignCommand(oTraveller, ActionJumpToObject(oMyWaypoint)));}
			 
		}

	}	
}