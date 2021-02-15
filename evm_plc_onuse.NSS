//OnUse for all Evermoor placeables 
//Wynna February 2021


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
	 
	 
	 

if(GetTag(OBJECT_SELF) == "6b_ext_lizard_cave_enter")
	{effect eSwimDmg = EffectDamage(Random(4), DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_NORMAL, FALSE);
	 object oSwimExit = GetObjectByTag("6b_ext_lizard_cave_enter_wp");
	 SendMessageToPC(oUser, "You wade into the reeds and dive into a murky hole.");		 
	 if(GetIsSkillSuccessful(GetEnteringObject(), SKILL_SWIM, 15))
	 	{SendMessageToPC(oUser, "Your superior swimming skills allow you to find your way through a tunnel of soft mud walls and roots, onto a dark, rocky shore.");
		}
	 else {ApplyEffectToObject(DURATION_TYPE_INSTANT,eSwimDmg, oUser);
		   SendMessageToPC(oUser, "The swim is is much harder than your swimming skills are up to. You finally claw your way to the surface, bruised and battered.");
		}
	DelayCommand(3.0, AssignCommand(oUser, ActionJumpToLocation(GetLocation(oSwimExit))));
		
		}

if(GetTag(OBJECT_SELF) == "6b_int_lizard_cave_exit") 
	{effect eSwimDmg = EffectDamage(Random(4), DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_NORMAL, FALSE);
	 object oSwimExit = GetObjectByTag("6b_int_lizard_cave_exit_wp");
	 SendMessageToPC(oUser, "You swim down through murky water");		 
	 if(GetIsSkillSuccessful(GetEnteringObject(), SKILL_SWIM, 15))
	 	{SendMessageToPC(oUser, "Your superior swimming skills allow you to find your way to the surface, dragging yourself out into hip deep water amid reeds.");
		}
	 else {ApplyEffectToObject(DURATION_TYPE_INSTANT,eSwimDmg, oUser);
		   SendMessageToPC(oUser, "The swim is is much harder than your swimming skills are up to. You finally find your way to the surface, bruised and battered.");
		}
	DelayCommand(3.0, AssignCommand(oUser, ActionJumpToLocation(GetLocation(oSwimExit))));
		
		}			
											
}