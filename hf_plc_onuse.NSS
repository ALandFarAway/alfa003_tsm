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
	 
	 
	 if(GetTag(OBJECT_SELF) == "rm_winch_bucket_use")
	 	{int nSandbag = GetLocalInt(OBJECT_SELF, "nSandbag");
		 object oMyWP = GetLocalObject(OBJECT_SELF, "MyWP");
		 if(oMyWP == OBJECT_INVALID)
		 	{oMyWP = GetNearestObject(OBJECT_TYPE_WAYPOINT, OBJECT_SELF, 1);
			 SetLocalObject(OBJECT_SELF, "oMyWP", oMyWP);
			 }
		
			 
			 vector vPosition = GetPosition(oMyWP);
			 float vX = vPosition.x + 2.0;
			 float vY = vPosition.y;
			 float vZ = vPosition.z + IntToFloat(nSandbag / 2);
			 vector vHigher = Vector(vX, vY, vZ);
			 location lSandbag = Location(GetArea(OBJECT_SELF), vHigher, IntToFloat(Random(360)));
			 
		 if(nSandbag <= 4)
		 	{object oSandbag = CreateObject(OBJECT_TYPE_PLACEABLE, "rm_winch_sandbags", lSandbag, FALSE, "rm_winch_sandbag_" + IntToString(nSandbag));
			 SendMessageToPC(oUser, "You fill sacks full of sand.");
			 SetLocalInt(OBJECT_SELF, "nSandbag", nSandbag + 1);
			 SetLocalObject(OBJECT_SELF, "oSandbag_" + IntToString(nSandbag), oSandbag);
			 }
		 
		 else if(nSandbag > 4)
		 	{object oSandbag_0 = GetLocalObject(OBJECT_SELF, "oSandbag_0");
			 object oSandbag_1 = GetLocalObject(OBJECT_SELF, "oSandbag_1");
			 object oSandbag_2 = GetLocalObject(OBJECT_SELF, "oSandbag_2");
			 object oSandbag_3 = GetLocalObject(OBJECT_SELF, "oSandbag_3");
			 object oSandbag_4 = GetLocalObject(OBJECT_SELF, "oSandbag_4");
			 DestroyObject(oSandbag_1);
			 DestroyObject(oSandbag_2);
			 DestroyObject(oSandbag_3);
			 DestroyObject(oSandbag_4);
			 DestroyObject(oSandbag_0);
			 SendMessageToPC(oUser, "You have used up all the sand and stack the bags out of the way for later use.");
			 SetLocalInt(oUser, "RM_Sandbags", 2);
			 DestroyObject(OBJECT_SELF, 1.0);
			}
		
		}	 

		
	 if(GetTag(OBJECT_SELF) == "rm_winch_ditches")
	 	{int nWinch = GetLocalInt(OBJECT_SELF, "nWinch");
		 object oMyWP = GetLocalObject(OBJECT_SELF, "MyWP");
		 if(oMyWP == OBJECT_INVALID)
		 	{oMyWP = GetNearestObject(OBJECT_TYPE_WAYPOINT, OBJECT_SELF, 1);
			 SetLocalObject(OBJECT_SELF, "oMyWP", oMyWP);
			 }
		 object oBucketWP = GetLocalObject(OBJECT_SELF, "MyBucketWP");
		 if(oBucketWP == OBJECT_INVALID)
		 	{oBucketWP = GetWaypointByTag(GetTag(oMyWP) + "_bucket");
			 SetLocalObject(OBJECT_SELF, "MyBucketWP", oBucketWP);
			 }
		 object oBucket = GetLocalObject(OBJECT_SELF, "MyBucket");
		 if(oBucket != OBJECT_INVALID)
		 	{DestroyObject(oBucket);
			 SetLocalObject(OBJECT_SELF, "MyBucket", OBJECT_INVALID);
			 SendMessageToPC(oUser, "You winch the bucket down into the waterside trench.");
				 if(nWinch >= 9)
				{SendMessageToPC(oUser, "You find the trench clear and roll the winch out of the way.");
				 SetLocalInt(oUser, "RM_Trenches", 2);
				 DestroyObject(OBJECT_SELF);
				}
			}
		 else if(oBucket == OBJECT_INVALID)
		 	{SetLocalInt(OBJECT_SELF, "nWinch" , nWinch +1);
			 oBucket = CreateObject(OBJECT_TYPE_PLACEABLE, "rm_winch_bucket", GetLocation(oBucketWP));
			 SetLocalObject(OBJECT_SELF, "MyBucket", oBucket);
			 SendMessageToPC(oUser, "You winch a bucket of sand up from the waterside trench.");
			 }  
		}	 

if(GetTag(OBJECT_SELF) == "wands_cave_pool_rocks")
	{effect eSwimDmg = EffectDamage(Random(4), DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_NORMAL, FALSE);
	 object oSwimExit = GetObjectByTag("wands_cave_underground_river_wp");
	 SendMessageToPC(oUser, "You wade into the pool and dive into a deceptively strong current that pours into a hole! This pool is a backwater of a much larger underground reservoir and you are swept down into it!");		 
	 if(GetIsSkillSuccessful(GetEnteringObject(), SKILL_SWIM, 15))
	 	{SendMessageToPC(oUser, "Your superior swimming skills allow you to find your way to a pocket of air, treading water.");
		}
	 else {ApplyEffectToObject(DURATION_TYPE_INSTANT,eSwimDmg, oUser);
		   SendMessageToPC(oUser, "The swim is is much harder than your swimming skills are up to. Tumbling in a lightless cavern filled with water, you finally bob to the surface, bruised and battered.");
		}
	DelayCommand(3.0, AssignCommand(oUser, ActionJumpToLocation(GetLocation(oSwimExit))));
		
		}

if(GetTag(OBJECT_SELF) == "wands_cave_reservoir_enter") 
	{effect eSwimDmg = EffectDamage(Random(4), DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_NORMAL, FALSE);
	 object oSwimExit = GetObjectByTag("6b_int_wands_cave_river_exit_wp");
	 SendMessageToPC(oUser, "You swim up against a strong current that pushes against you!");		 
	 if(GetIsSkillSuccessful(GetEnteringObject(), SKILL_SWIM, 15))
	 	{SendMessageToPC(oUser, "Your superior swimming skills allow you to find your way to the surface, dragging yourself out of a lapping pool.");
		}
	 else {ApplyEffectToObject(DURATION_TYPE_INSTANT,eSwimDmg, oUser);
		   SendMessageToPC(oUser, "The swim is is much harder than your swimming skills are up to. You finally find your way to the surface, bruised and battered.");
		}
	DelayCommand(3.0, AssignCommand(oUser, ActionJumpToLocation(GetLocation(oSwimExit))));
		
		}			
											
}