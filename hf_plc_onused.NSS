//OnUse for all HF placeables 
//Wynna September 2021


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
	 
	 
	 
	
if(GetTag(OBJECT_SELF) == "hf_crate_down")
	{object oExit = GetObjectByTag("hf_crate_down_wp");
	 	 ActionSpeakString("Descends out of sight.", TALKVOLUME_TALK);
		 AssignCommand(oUser, ActionJumpToLocation(GetLocation(oExit)));
	   	}
	 
if(GetTag(OBJECT_SELF) == "hf_crate_up")
	{object oExit = GetObjectByTag("hf_crate_up_wp");
	 	 ActionSpeakString("Ascends out of sight.", TALKVOLUME_TALK);
		 AssignCommand(oUser, ActionJumpToLocation(GetLocation(oExit)));
	   	}
	 
	 
if(GetTag(OBJECT_SELF) == "hf_aq_plc_crack_exit")
	{effect eSwimDmg = EffectDamage(Random(4), DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_NORMAL, FALSE);
	 object oSwimExit = GetObjectByTag("hf_aq_plc_crack_enter_WP");
	 if(ACR_SkillCheck(SKILL_SURVIVAL, oUser, 5, TRUE)) {
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
	 object oCrackSpawnWP = GetWaypointByTag("hf_aq_plc_crack_exit_spawn");
	 int nSurvival = ACR_SkillCheck(SKILL_SURVIVAL, oUser);
	 if(nSurvival >= 5) {
	     if(GetLocalObject(OBJECT_SELF, "oCrackExit") == OBJECT_INVALID) {
		 	object oCrackExit = CreateObject(OBJECT_TYPE_PLACEABLE, "hf_aq_plc_crack_exit", GetLocation(oCrackSpawnWP));
		 	SetLocalObject(OBJECT_SELF, "oCrackExit", oCrackExit);
			}
	 	 AssignCommand(oUser, ActionJumpToLocation(GetLocation(oSwimExit)));
	     SendMessageToPC(oUser, "You find your way easily through the crack into a well of still, cold water, and immediately encounter a wall of stone before you. You are blocked!");		 
	     if(GetLocalObject(OBJECT_SELF, "oWell") == OBJECT_INVALID) {
		 	object oWellExit = CreateObject(OBJECT_TYPE_PLACEABLE, "hf_aq_plc_well_exit", GetLocation(oWellSpawnWP));
		 	SetLocalObject(OBJECT_SELF, "oWell", oWellExit);
			}
		 DelayCommand(5.0, SendMessageToPC(oUser, "The faintest of light triggers your survival skills. You are in a rock-walled column of glacially cold water but there are a few faintly lit cracks in the rocks around you. Maybe you could fit through a crack to go deeper into the rock...if you choose?"));
		 }
	 else if(nSurvival >= 1) {
	 	   AssignCommand(oUser, ActionJumpToLocation(GetLocation(oSwimExit)));
	       ApplyEffectToObject(DURATION_TYPE_INSTANT,eSwimDmg, oUser);
	       SendMessageToPC(oUser, "You squeeze with difficulty into the crack, feeling skin scrape. The water is colder, cold enough to numb the bruising impact of bumbling into a wall of stone. You are blocked!");		 
	     if(GetLocalObject(OBJECT_SELF, "oCrackExit") == OBJECT_INVALID) {
		 	object oCrackExit = CreateObject(OBJECT_TYPE_PLACEABLE, "hf_aq_plc_crack_exit", GetLocation(oCrackSpawnWP));
		 	SetLocalObject(OBJECT_SELF, "oCrackExit", oCrackExit);
			}
	 	 if(Random(2)==1) {
		   	 if(GetLocalObject(OBJECT_SELF, "oWell") == OBJECT_INVALID) {
		 		object oWellExit = CreateObject(OBJECT_TYPE_PLACEABLE, "hf_aq_plc_well_exit", GetLocation(oWellSpawnWP));
		 		SetLocalObject(OBJECT_SELF, "oWell", oWellExit);
				}
			DelayCommand(5.0, SendMessageToPC(oUser, "The faintest of light triggers your survival skills. You are in a rock-walled column of glacially cold water but there are a few faintly lit cracks in the rocks around you. Maybe you could fit through a crack to go deeper into the rock...if you choose?"));
		 	}
		   }
 	else {
	 	   ApplyEffectToObject(DURATION_TYPE_INSTANT,eSwimDmg, oUser);
	       SendMessageToPC(oUser, "Your attempts to force yourself through the crack are unsuccessful. Blood rises in tendrils from painful scrapes on your skin.");		 
	       }
	}
	
if(GetTag(OBJECT_SELF) == "hf_aq_plc_well_enter")
	{effect eSwimDmg = EffectDamage(Random(4), DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_NORMAL, FALSE);
	 object oSwimExit = GetObjectByTag("hf_aq_plc_crack_swim3_WP");
	 object oSwimEnter = GetObjectByTag("hf_aq_plc_well_exit_WP");
	 if(ACR_SkillCheck(SKILL_SWIM, oUser, 5, TRUE)) {
	 	 AssignCommand(oUser, ActionJumpToLocation(GetLocation(oSwimExit)));
	     SendMessageToPC(oUser, "You swim down into the blue glow of the well.");		 
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
	 object oSwimOne = GetObjectByTag("hf_aq_plc_crack_swim1_WP");
	 object oSwimTwo = GetObjectByTag("hf_aq_plc_crack_swim2_WP");
	 object oSwimThree = GetObjectByTag("hf_aq_plc_crack_swim3_WP");
	 object oSwimEnter = GetObjectByTag("hf_aq_plc_well_enter_WP");
	 if(ACR_SkillCheck(SKILL_SWIM, oUser, 5, TRUE)) {
	 	 SendMessageToPC(oUser, "You swim along the rock walls, seeking the widest crack.");		 
	     AssignCommand(oUser, ActionJumpToLocation(GetLocation(oSwimOne)));
		 //DelayCommand(1.0, SendMessageToPC(oUser, "You swim along the edge of the wall, seeking a way in."));		 
	     
	     DelayCommand(6.0, AssignCommand(oUser, ActionJumpToLocation(GetLocation(oSwimTwo))));
		 //DelayCommand(7.0, SendMessageToPC(oUser, "You swim higher, reaching for a high crack in the wall."));		 
	     
	     DelayCommand(11.0, AssignCommand(oUser, ActionSpeakString("*Hauls self up into a crack in the corner of the ceiling and out of sight.", TALKVOLUME_TALK)));
		 DelayCommand(11.0, SendMessageToPC(oUser, "You haul yourself up through a crack in the corner of the ceiling into a wider column of even colder water with a light shining down from thirty feet above."));		 
	     DelayCommand(12.0, AssignCommand(oUser, ActionJumpToLocation(GetLocation(oSwimThree))));
	     }
	else {
	 	   ApplyEffectToObject(DURATION_TYPE_INSTANT,eSwimDmg, oUser);
	        AssignCommand(oUser, ActionJumpToLocation(GetLocation(oSwimOne)));
			//DelayCommand(1.0, SendMessageToPC(oUser, "*You swim along the edge of the wall, seeking a way in."));		 
	     	DelayCommand(5.0, SendMessageToPC(oUser, "You lose your sense of up and down, blundering along the mossy walls, and end up back where you began."));		 
	        DelayCommand(5.0, AssignCommand(oUser, ActionSpeakString("*Seems unable to find a way onward.", TALKVOLUME_TALK)));
		    DelayCommand(6.0, AssignCommand(oUser, ActionJumpToLocation(GetLocation(oSwimEnter))));
		}
		}
	
if(GetTag(OBJECT_SELF) == "hf_aq_plc_well_up")
	{effect eSwimDmg = EffectDamage(Random(4), DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_NORMAL, FALSE);
	 effect eColdDmg = EffectDamage(Random(6), DAMAGE_TYPE_COLD, DAMAGE_POWER_NORMAL, FALSE);
	 object oSwimExit = GetObjectByTag("hf_aq_plc_well_exit_WP");
	 object oSwimEnter = GetObjectByTag("hf_aq_plc_well_enter_WP");
	 int nSwimCheck = ACR_SkillCheck(SKILL_SWIM, oUser);
	 
	 if(ACR_SkillCheck(SKILL_SWIM, oUser, 5, TRUE)) {
	 	 SendMessageToPC(oUser, "You swim up strongly and break the surface into a room faintly lit with the glow of phosphorescent moss.");		 
	     AssignCommand(oUser, ActionJumpToLocation(GetLocation(oSwimExit)));
		}
		
	 else if(nSwimCheck <= 2) {
	     SendMessageToPC(oUser, "You lose your sense of up and down, blundering along the mossy walls, and end up back where you began.");		 
	     AssignCommand(oUser, ActionJumpToLocation(GetLocation(oSwimEnter)));
	}
	
	else{SendMessageToPC(oUser, "You lose your sense of up and down, blundering along the mossy walls, and make no progress.");		 
	     ApplyEffectToObject(DURATION_TYPE_INSTANT,eSwimDmg, oUser);
	     }
	
	if(((GetHasSpellEffect(SPELL_ENDURE_ELEMENTS)) || (GetHasSpellEffect(SPELL_ELEMENTAL_SHIELD)))|| (GetHasSpellEffect(SPELL_PROTECTION_FROM_ENERGY))){	
		 SendMessageToPC(oUser, "You feel the comforting warmth of your elemental protections keeping the cold of the water at bay.");		 
	     AssignCommand(oUser, ActionJumpToLocation(GetLocation(oSwimExit)));
		}
	
	else{ApplyEffectToObject(DURATION_TYPE_INSTANT,eColdDmg, oUser);
	     SendMessageToPC(oUser, "The cold water saps your strength.");		 
	     }
	}
  	
if(GetTag(OBJECT_SELF) == "hf_aq_plc_well_down")
	{effect eSwimDmg = EffectDamage(Random(4), DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_NORMAL, FALSE);
	 effect eColdDmg = EffectDamage(Random(6), DAMAGE_TYPE_COLD, DAMAGE_POWER_NORMAL, FALSE);
	 object oSwimExit = GetObjectByTag("hf_aq_plc_crack_exit_WP");
	 object oSwimEnter = GetObjectByTag("hf_aq_plc_crack_swim3_WP");
	 
	 
	 int nSwimCheck = ACR_SkillCheck(SKILL_SWIM, oUser);
	 
	 if(ACR_SkillCheck(SKILL_SWIM, oUser, 5, TRUE)) {
	 	 SendMessageToPC(oUser, "You swim down strongly and wiggle through the cracks into the area adjacent to the nixie cave.");		 
	     AssignCommand(oUser, ActionJumpToLocation(GetLocation(oSwimExit)));
		}
		
	 else if(nSwimCheck <= 2) {
	     SendMessageToPC(oUser, "You lose your sense of up and down, blundering along the mossy walls, and end up back where you began.");		 
	     AssignCommand(oUser, ActionJumpToLocation(GetLocation(oSwimEnter)));
	}
	
	else{SendMessageToPC(oUser, "You lose your sense of up and down, blundering along the mossy walls, and make no progress.");		 
	     ApplyEffectToObject(DURATION_TYPE_INSTANT,eSwimDmg, oUser);
	     }
	
	if(((GetHasSpellEffect(SPELL_ENDURE_ELEMENTS)) || (GetHasSpellEffect(SPELL_ELEMENTAL_SHIELD)))|| (GetHasSpellEffect(SPELL_PROTECTION_FROM_ENERGY))){	
		 SendMessageToPC(oUser, "You feel the comforting warmth of your elemental protections keeping the cold of the water at bay.");		 
	     AssignCommand(oUser, ActionJumpToLocation(GetLocation(oSwimExit)));
		}
	
	else{ApplyEffectToObject(DURATION_TYPE_INSTANT,eColdDmg, oUser);
	     SendMessageToPC(oUser, "The cold water saps your strength.");		 
	     }
	}										
}