//OnUse for all Silvy Uni placeables 
//Wynna September 2007


#include "acr_placeable_i"
#include "acr_xp_i"
#include "acr_skills_i"
#include "acr_hazards_i"
#include "acr_movement_i"


// float GetNormalizedDirection(float fDirection):
// * This script returns a direction normalized to the range 0.0 - 360.0
// * Copyright (c) 2002 Floodgate Entertainment
// * Created By: Naomi Novik
// * Created On: 11/08/2002


void main()
{
	ACR_PlaceableOnUsed();
     object oUser = GetLastUsedBy();
	 
	 
	
if(GetTag(OBJECT_SELF) == "hf_aq_plc_crack_exit")
	{effect eSwimDmg = EffectDamage(Random(4), DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_NORMAL, FALSE);
	 object oSwimExit = GetObjectByTag("hf_aq_plc_crack_enter_WP");
	 int nSurvival = ACR_SkillCheck(SKILL_SURVIVAL, oUser);
	 if(nSurvival >= 5) {
	 	 AssignCommand(oUser, ActionJumpToLocation(GetLocation(oSwimExit)));
	     SendMessageToPC(oUser, "You squeeze out into the glimmering blue-lit cave of the aquatic fey.");		 
	     }
	else {
	 	   ApplyEffectToObject(DURATION_TYPE_INSTANT,eSwimDmg, oUser);
	       SendMessageToPC(oUser, "Your attempts to force yourself through the crack are unsuccessful. Blood rises in tendrils from painful scrapes on your skin.");		 
	       }
	}
	
if(GetTag(OBJECT_SELF) == "hf_aq_plc_crack_enter")
	{effect eSwimDmg = EffectDamage(Random(4), DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_NORMAL, FALSE);
	 object oSwimExit = GetObjectByTag("hf_aq_plc_crack_exit_WP");
	 object oWellSpawnWP = GetWaypointByTag("hf_aq_plc_well_exit_spawn");
	 int nSurvival = ACR_SkillCheck(SKILL_SURVIVAL, oUser);
	 if(nSurvival >= 15) {
	 	 AssignCommand(oUser, ActionJumpToLocation(GetLocation(oSwimExit)));
	     SendMessageToPC(oUser, "You find your way easily through the crack and immediately encounter a wall of stone before you. It is too narrow to turn around. You are wedged!");		 
	     CreateObject(OBJECT_TYPE_PLACEABLE, "hf_aq_plc_well_exit", GetLocation(oWellSpawnWP));
		 DelayCommand(5.0, SendMessageToPC(oUser, "A glimmering light triggers your survival skills. You are wedged into a rock-walled column of water but there is light thirty feet above you. The light comes through a crack in the ceiling that you could fit through."));
		 }
	 else if(nSurvival >= 10) {
	 	   AssignCommand(oUser, ActionJumpToLocation(GetLocation(oSwimExit)));
	       ApplyEffectToObject(DURATION_TYPE_INSTANT,eSwimDmg, oUser);
	       SendMessageToPC(oUser, "You squeeze with difficulty into the crack, feeling skin scrape and blundering painfully into a wall of stone. It is too narrow to turn around. You are wedged!");		 
	       if(Random(2)==1) {
		   	CreateObject(OBJECT_TYPE_PLACEABLE, "hf_aq_plc_well_exit", GetLocation(oWellSpawnWP));
		    DelayCommand(5.0, SendMessageToPC(oUser, "A glimmering light triggers your survival skills. You are wedged into a rock-walled column of water but there is light thirty feet above you. The light comes through a crack in the ceiling that you could fit through."));
		 	}
		   }
 	else {
	 	   ApplyEffectToObject(DURATION_TYPE_INSTANT,eSwimDmg, oUser);
	       SendMessageToPC(oUser, "Your attempts to force yourself through the crack are unsuccessful. Blood rises in tendrils from painful scrapes on your skin.");		 
	       }
	}
	
if(GetTag(OBJECT_SELF) == "hf_aq_plc_well_enter")
	{effect eSwimDmg = EffectDamage(Random(4), DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_NORMAL, FALSE);
	 object oSwimExit = GetObjectByTag("hf_aq_plc_well_enter_WP");
	 object oSwimEnter = GetObjectByTag("hf_aq_plc_well_exit_WP");
	 int nSwim = ACR_SkillCheck(SKILL_SWIM, oUser);
	 if(nSwim >= 5) {
	 	 AssignCommand(oUser, ActionJumpToLocation(GetLocation(oSwimExit)));
	     SendMessageToPC(oUser, "You swim down into the inky blackness of the well.");		 
	     }
	else {
	 	   AssignCommand(oUser, ActionJumpToLocation(GetLocation(oSwimExit)));
	       ApplyEffectToObject(DURATION_TYPE_INSTANT,eSwimDmg, oUser);
	       SendMessageToPC(oUser, "You lose your way, blundering along the stone inside the well and surface back where you began.");		 
	       DelayCommand(2.0, AssignCommand(oUser, ActionJumpToLocation(GetLocation(oSwimEnter))));
	     }
	}
	
if(GetTag(OBJECT_SELF) == "hf_aq_plc_well_exit")
	{effect eSwimDmg = EffectDamage(Random(4), DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_NORMAL, FALSE);
	 object oSwimExit = GetObjectByTag("hf_aq_plc_well_exit_WP");
	 object oSwimEnter = GetObjectByTag("hf_aq_plc_well_enter_WP");
	 int nSwim = ACR_SkillCheck(SKILL_SWIM, oUser);
	 if(nSwim >= 10) {
	 	 AssignCommand(oUser, ActionJumpToLocation(GetLocation(oSwimExit)));
	     SendMessageToPC(oUser, "You swim up towards the glimmering light and haul yourself out onto a dirty marble floor.");		 
	     }
	else {
	 	   ApplyEffectToObject(DURATION_TYPE_INSTANT,eSwimDmg, oUser);
	       SendMessageToPC(oUser, "You lose your sense of up and down, blundering along the stone walls of the crack, losing air until you find yourself back where you began.");		 
	       }
	}
	

												
}