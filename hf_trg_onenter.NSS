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
    
if((GetTag(OBJECT_SELF) == "phalorm_light_green_up_trg") && (GetIsPC(oPC)) && (GetLocalInt(OBJECT_SELF, "RUN_ONCE") == 0))
		{SetLocalInt(OBJECT_SELF, "RUN_ONCE", 1);
		 object oOrb = GetObjectByTag("phalorm_orb_green_up", 1); 
		 object oLight = GetObjectByTag("fx_phalorm_light_green_up", 1); 
		 AssignCommand(oOrb, ActionSpeakString("Drops suddenly into the pit and descends, its light quickly fading.", TALKVOLUME_TALK));	
		 DestroyObject(oOrb, 2.0);
		 DestroyObject(oLight, 3.0);
		}
	
	

if(GetTag(OBJECT_SELF) == "phalorm_archive_enter") {
		object oThereWP = GetWaypointByTag("WP_phalorm_archive_platform_exit");
		object oHereWP = GetWaypointByTag("WP_phalorm_archive_platform_enter");
		object oGoThere = GetWaypointByTag("WP_phalorm_archive_enter");
		location lThere = GetLocation(oThereWP);
		location lHere = GetLocation(oHereWP);
		location lGoThere = GetLocation(oGoThere);
		
		if((GetItemPossessedBy(oPC, "003_it_phalorm_diamond")!= OBJECT_INVALID) && (GetLocalInt(OBJECT_SELF, "Activated") != 1)) {
			SetLocalInt(OBJECT_SELF, "Activated", 1); 
			object oThereBeam = CreateObject(OBJECT_TYPE_PLACED_EFFECT, "fx_spirit_trap_barrier02", lThere);
			object oPlatformHere = CreateObject(OBJECT_TYPE_PLACEABLE,"phalorm_platform_active", lHere);
			object oPlatformThere = CreateObject(OBJECT_TYPE_PLACEABLE,"phalorm_platform_active", lThere);
			DelayCommand(1.0, SendMessageToPC(oPC, "A light blinks on beneath your feet. A clear white light rises around you. You feel your heart drop as if rising suddenly and find yourself in another place."));
			DelayCommand(2.0, ActionCreateWynPlacedEffect("fx_spirit_trap_barrier02", lHere));
			}
		
		if(GetLocalInt(OBJECT_SELF, "Activated") == 1) {
			DelayCommand(1.0, SendMessageToPC(oPC, "You feel your heart drop as if rising suddenly and find yourself in another place."));
			DelayCommand(3.0, AssignCommand(oPC, ActionJumpToLocation(lGoThere)));	 
			}
		}
		
	if(GetTag(OBJECT_SELF) == "phalorm_archive_exit") {
		object oGoThere = GetWaypointByTag("WP_phalorm_archive_exit");
		location lGoThere = GetLocation(oGoThere);
		DelayCommand(1.0, AssignCommand(oPC, ActionJumpToLocation(lGoThere)));	 
		}
	
	if(GetTag(OBJECT_SELF) == "phalorm_vault_enter") {
		object oThereWP = GetWaypointByTag("WP_phalorm_vault_platform_exit");
		object oHereWP = GetWaypointByTag("WP_phalorm_vault_platform_enter");
		object oGoThere = GetWaypointByTag("WP_phalorm_vault_enter");
		location lThere = GetLocation(oThereWP);
		location lHere = GetLocation(oHereWP);
		location lGoThere = GetLocation(oGoThere);
		
		if((GetItemPossessedBy(oPC, "003_it_phalorm_diamond")!= OBJECT_INVALID) && (GetLocalInt(OBJECT_SELF, "Activated") != 1)) {
			SetLocalInt(OBJECT_SELF, "Activated", 1); 
			object oThereBeam = CreateObject(OBJECT_TYPE_PLACED_EFFECT, "fx_spirit_trap_barrier02", lThere);
			object oPlatformHere = CreateObject(OBJECT_TYPE_PLACEABLE,"phalorm_platform_active", lHere);
			object oPlatformThere = CreateObject(OBJECT_TYPE_PLACEABLE,"phalorm_platform_active", lThere);
			DelayCommand(1.0, SendMessageToPC(oPC, "A cascade of rainbow lights blink on beneath your feet. You feel your heart rise as if your body is falling, and you find yourself in another place."));
			DelayCommand(2.0, ActionCreateWynPlacedEffect("fx_spirit_trap_barrier02", lHere));
			}
		
		if(GetLocalInt(OBJECT_SELF, "Activated") == 1) {
			DelayCommand(1.0, SendMessageToPC(oPC, "You find yourself in another place."));
			DelayCommand(5.0, AssignCommand(oPC, ActionJumpToLocation(lGoThere)));	 
			}
		}
		
	if(GetTag(OBJECT_SELF) == "phalorm_vault_exit") {
		object oGoThere = GetWaypointByTag("WP_phalorm_vault_exit");
		location lGoThere = GetLocation(oGoThere);
		DelayCommand(3.0, AssignCommand(oPC, ActionJumpToLocation(lGoThere)));	 
		}
			
		//Dex Checks for PCs on beam	 
	if((GetTag(OBJECT_SELF) == "ruin_beam_trg") && ((GetIsPC(oPC)) || (GetIsDMPossessed(oPC))))
		{location lFallBreak=GetLocation(GetWaypointByTag("ruin_beam_fall_break_wp"));
		 location lFall=GetLocation(GetWaypointByTag("ruin_beam_fall_wp"));
		 effect eKnockdown=EffectKnockdown();
		 SendMessageToPC(oPC, "It would be easy to fall from this beam!");
		 int nDexCheck = Random(21) + (GetAbilityModifier(ABILITY_DEXTERITY, oPC)) + (GetSkillRank(SKILL_BALANCE, oPC, FALSE));
		 if (nDexCheck >= 10)
		 	{SendMessageToPC(oPC, "The beam is narrow but you maintain your balance!");}
		 else
		 	{if(ReflexSave(oPC, 15, SAVING_THROW_TYPE_NONE, OBJECT_SELF))
				{SendMessageToPC(oPC, "You start to fall, but catch yourself!");}
			 else
			 	{SendMessageToPC(oPC, "You are falling!");
				 if(Random(2) ==1) 
					{DelayCommand(1.0, ACR_FallToLocation(oPC, 10, lFallBreak, FALSE, -1, 1));
					 DelayCommand(2.0, ACR_FallToLocation(oPC, 15, lFall, FALSE, -1, -1));
					 DelayCommand(2.5, SendMessageToPC(oPC, "You catch yourself on a narrow, rocky ledge and roll the rest of the way down."));
					 DelayCommand(3.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnockdown, oPC, 5.0));
					 }
					else
					{DelayCommand(1.0, ACR_FallToLocation(oPC, 30, lFall, FALSE, -1, -1));
					 DelayCommand(2.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnockdown, oPC, 5.0));
					 DelayCommand(2.5, SendMessageToPC(oPC, "You hit the ground hard."));
					 }
				  
				}
			}
		}	
		
}