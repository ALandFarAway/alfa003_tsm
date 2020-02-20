//Circus Trigger OnEnter. All triggers.
//Wynna May 2015


#include "acr_trigger_i"
#include "acr_spawn_i"
#include "acr_tools_i"
#include "acr_quest_i"
#include "acr_hazards_i"

void main()
{	
	ACR_TriggerOnEnter();
	object oPC = GetEnteringObject();
    
		  
	//Will Save to see through illusions on displays in circus. 
	if((GetTag(OBJECT_SELF) == "circus_illusion_trg") && (GetLocalInt(OBJECT_SELF, GetName(oPC)) != 1) && ((GetIsPC(oPC))|| (GetIsDMPossessed(oPC))))
		{SetLocalInt(OBJECT_SELF, GetName(oPC), 1);
		 string sDisplayMsg = GetLocalString(OBJECT_SELF, "circus_display_message");
		 string sIllusionMsg = GetLocalString(OBJECT_SELF, "circus_illusion_message");
		 string sIllusionMsg2 = GetLocalString(OBJECT_SELF, "circus_illusion_message2");
		 string sIllusionMsg3 = GetLocalString(OBJECT_SELF, "circus_illusion_message3");
		 int nIllusionDC = GetLocalInt(OBJECT_SELF, "circus_illusion_dc");
		 SendMessageToPC(oPC, sDisplayMsg);
		 if(WillSave(oPC, nIllusionDC, SAVING_THROW_TYPE_MIND_SPELLS, OBJECT_SELF))
		 	{DelayCommand(6.0, SendMessageToPC(oPC, sIllusionMsg));
			 DelayCommand(8.0, SendMessageToPC(oPC, sIllusionMsg2));
			 DelayCommand(10.0, SendMessageToPC(oPC, sIllusionMsg3));
			}
		}	
	
	//Will Save to see through illusions on displays in circus. 
	if((GetTag(OBJECT_SELF) == "circus_illusion_trg_fey") && (GetLocalInt(OBJECT_SELF, GetTag(oPC)) != 1) && ((GetIsPC(oPC))|| (GetIsDMPossessed(oPC))))
		{SetLocalInt(OBJECT_SELF, GetTag(oPC), 1);
		 string sDisplayMsg = GetLocalString(OBJECT_SELF, "circus_display_message");
		 string sIllusionMsg = GetLocalString(OBJECT_SELF, "circus_illusion_message");
		 string sIllusionMsg2 = GetLocalString(OBJECT_SELF, "circus_illusion_message2");
		 string sIllusionMsg3 = GetLocalString(OBJECT_SELF, "circus_illusion_message3");
		 int nIllusionDC = GetLocalInt(OBJECT_SELF, "circus_illusion_dc");
		 SendMessageToPC(oPC, sDisplayMsg);
		 if(WillSave(oPC, nIllusionDC, SAVING_THROW_TYPE_MIND_SPELLS, OBJECT_SELF))
		 	{DelayCommand(6.0, SendMessageToPC(oPC, sIllusionMsg));
			 DelayCommand(8.0, SendMessageToPC(oPC, sIllusionMsg2));
			 DelayCommand(10.0, SendMessageToPC(oPC, sIllusionMsg3));
			 location lGlassNorth = GetLocation(GetWaypointByTag("circus_fey_glass_north"));
			 object oGlassNorth = CreateObject(OBJECT_TYPE_PLACEABLE, "003_plc_circus_feycage", lGlassNorth);
			 object oCollisionNorth=GetObjectByTag("003_plc_circus_cb_feynorth");
			 DelayCommand(2.0, SetLocalObject(oGlassNorth, "oCollision", oCollisionNorth));
			 
			 location lGlassSouth = GetLocation(GetWaypointByTag("circus_fey_glass_south"));
			 object oGlassSouth = CreateObject(OBJECT_TYPE_PLACEABLE, "003_plc_circus_feycage", lGlassSouth);
 			 object oCollisionSouth=GetObjectByTag("003_plc_circus_cb_feysouth");
			 DelayCommand(2.0, SetLocalObject(oGlassSouth, "oCollision", oCollisionSouth));
			 
			 location lGlassEast = GetLocation(GetWaypointByTag("circus_fey_glass_east"));
			 object oGlassEast = CreateObject(OBJECT_TYPE_PLACEABLE, "003_plc_circus_feycage", lGlassEast);
			 object oCollisionEast=GetObjectByTag("003_plc_circus_cb_feyeast");
			 DelayCommand(2.0, SetLocalObject(oGlassEast, "oCollision", oCollisionEast));
			 
			 location lGlassWest = GetLocation(GetWaypointByTag("circus_fey_glass_west"));
			 object oGlassWest = CreateObject(OBJECT_TYPE_PLACEABLE, "003_plc_circus_feycage", lGlassWest);
			 object oCollisionWest=GetObjectByTag("003_plc_circus_cb_feywest");
			 DelayCommand(2.0, SetLocalObject(oGlassWest, "oCollision", oCollisionWest));
			 
			 }
		}	
				
	//Destroys escaped creatures running from PCs	 
	if((GetTag(OBJECT_SELF) == "circus_animal_escape_trg") && (GetLocalInt(oPC, "Freed")==1))
		{AssignCommand(oPC, ActionSpeakString("Escapes into the trees surrounding the circus and is instantly out of sight", TALKVOLUME_TALK));
		 DestroyObject(oPC, 2.0);
		}	
		
		
		//Dex Checks for PCs on highwire	 
	if((GetTag(OBJECT_SELF) == "circus_aerial_trg") && ((GetIsPC(oPC)) || (GetIsDMPossessed(oPC))))
		{location lFallBreak=GetLocation(GetWaypointByTag("circus_aerial_fall_break_wp"));
		 location lFall=GetLocation(GetWaypointByTag("circus_aerial_fall_wp"));
		 effect eKnockdown=EffectKnockdown();
		 effect eFallingDamage=EffectDamage(Random(10), DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_NORMAL, FALSE); 
		SendMessageToPC(oPC, "It would be easy to fall from this highwire!");
		 int nDexCheck = Random(21) + (GetAbilityModifier(ABILITY_DEXTERITY, oPC)) + (GetSkillRank(SKILL_BALANCE, oPC, FALSE));
		 if (nDexCheck >= 10)
		 	{SendMessageToPC(oPC, "The wire wobbles but you maintain your balance!");}
		 else
		 	{if(ReflexSave(oPC, 15, SAVING_THROW_TYPE_NONE, OBJECT_SELF))
				{SendMessageToPC(oPC, "You start to fall, but catch yourself!");}
			 else
			 	{SendMessageToPC(oPC, "You are falling!");
				 DelayCommand(1.0, ACR_FallToLocation(oPC, 16, lFallBreak, FALSE, -1, 1));
				 DelayCommand(2.0, ACR_FallToLocation(oPC, 16, lFall, FALSE, -1, -1));
				 DelayCommand(2.0, SendMessageToPC(oPC, "The tent breaks your fall! You roll the rest of the way down."));
				 DelayCommand(3.5, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnockdown, oPC, 5.0));
				 //DelayCommand(3.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFallingDamage, oPC));
				 }
			}
		}	
		
	if((GetTag(OBJECT_SELF) == "circus_highwire_trg") && ((GetIsPC(oPC)) || (GetIsDMPossessed(oPC))))
		{location lFall=GetLocation(GetWaypointByTag("circus_highwire_fall_wp"));
		 effect eKnockdown=EffectKnockdown();
		 //effect eFallingDamage=EffectDamage(Random(10), DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_NORMAL, FALSE); 
		 //effect eFallingDamageHalf=EffectDamage(Random(5), DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_NORMAL, FALSE); 
		 
		SendMessageToPC(oPC, "It would be easy to fall from this highwire!");
		 int nDexCheck = Random(21) + (GetAbilityModifier(ABILITY_DEXTERITY, oPC)) + (GetSkillRank(SKILL_BALANCE, oPC, FALSE));
		 if (nDexCheck >= 10)
		 	{SendMessageToPC(oPC, "The wire wobbles but you maintain your balance!");}
		 else
		 	{if(ReflexSave(oPC, 15, SAVING_THROW_TYPE_NONE, OBJECT_SELF))
				{SendMessageToPC(oPC, "You start to fall, but catch yourself!");}
			 else
			 	{SendMessageToPC(oPC, "You are falling!");
				 if(ReflexSave(oPC, 15, SAVING_THROW_TYPE_NONE, OBJECT_SELF))
					{DelayCommand(2.0, ACR_FallToLocation(oPC, 30, lFall, FALSE, -1, 1));
					 DelayCommand(2.0, SendMessageToPC(oPC, "You catch at some ropes that slow your fall! Breaking free, you hit the ground not quite as hard as you could have."));
					 DelayCommand(3.5, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnockdown, oPC, 5.0));
					 //DelayCommand(3.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFallingDamageHalf, oPC));
					}
				 else
				 	{DelayCommand(2.0, ACR_FallToLocation(oPC, 30, lFall, FALSE, -1, 1));
					 DelayCommand(3.5, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnockdown, oPC, 5.0));
					 //DelayCommand(3.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFallingDamage, oPC));
					}
				}
			}
		}	
	
	if((GetTag(OBJECT_SELF) == "circus_crosswire_trg") && ((GetIsPC(oPC)) || (GetIsDMPossessed(oPC))))
		{location lFall=GetLocation(GetWaypointByTag("circus_crosswire_fall_wp"));
		 effect eKnockdown=EffectKnockdown();
		 //effect eFallingDamage=EffectDamage(Random(10), DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_NORMAL, FALSE); 
		 //effect eFallingDamageHalf=EffectDamage(Random(5), DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_NORMAL, FALSE); 
		 SendMessageToPC(oPC, "It would be easy to fall from this highwire!");
		 int nDexCheck = Random(21) + (GetAbilityModifier(ABILITY_DEXTERITY, oPC)) + (GetSkillRank(SKILL_BALANCE, oPC, FALSE));
		 if (nDexCheck >= 10)
		 	{SendMessageToPC(oPC, "The wire wobbles but you maintain your balance!");}
		 else
		 	{if(ReflexSave(oPC, 15, SAVING_THROW_TYPE_NONE, OBJECT_SELF))
				{SendMessageToPC(oPC, "You start to fall, but catch yourself!");}
			 else
			 	{SendMessageToPC(oPC, "You are falling!");
				 DelayCommand(2.0,ACR_FallToLocation(oPC, 39, lFall, FALSE, 1, -1));;
				 DelayCommand(3.5, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnockdown, oPC, 5.0));
				 //DelayCommand(3.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFallingDamageHalf, oPC));
					
				}
			}
		}	
			

}