//Secondary script for all Dean's Exam Static(deandragon) creatures 
//Wynna February 2009


#include "acr_creature_i"
#include "acr_xp_i"
#include "acr_quest_i"







void ACR_ApplyNLDDamageToCreature(object oTarget, int nSubdualDamage);


void ACR_ApplyNLDDamageToCreature(object oTarget, int nSubdualDamage)
{
    int nNLDTotal = _GetNLDTotal(oTarget);
    int nHPMax = GetMaxHitPoints(oTarget);
    int nCap = nHPMax + 10;
    nNLDTotal = ((nNLDTotal + nSubdualDamage) > nCap) ? nCap :
            nNLDTotal + nSubdualDamage;
    _SetNLDTotal(oTarget, nNLDTotal);
    ACR_ApplyNLDEffects(oTarget, nNLDTotal);
}

void main()
{
	//deandragon_e_air cold damage loop
	
			if(GetLocalInt(OBJECT_SELF, "ColdRep") == 1)
				{float fTimeLoop = 91.0;
				 int nRepCold = GetLocalInt(OBJECT_SELF, "nRepCold");
				 object oMyListener = GetLocalObject(OBJECT_SELF, "oMyListener");
					 if(oMyListener == OBJECT_INVALID)
						 	{if(ACR_RetrieveQuestState("slv_deansphinx_e_air", OBJECT_SELF) >= 1)
								{oMyListener = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_slv_deanvoice_sphinx", GetLocation(OBJECT_SELF));}
	   						 if(ACR_RetrieveQuestState("slv_deandragon_e_air", OBJECT_SELF) >= 1)
								{oMyListener = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_slv_deanvoice_phoenix", GetLocation(OBJECT_SELF));}
	   						 SetLocalObject(OBJECT_SELF, "oMyListener", oMyListener);
							 }
					 if(nRepCold == 3) {
						 object oGoTo2 = GetLocalObject(OBJECT_SELF, "oGoTo2");
						 if(oGoTo2 == OBJECT_INVALID)
							 	{oGoTo2 = GetWaypointByTag("slv_el_air_wp2");
								 SetLocalObject(OBJECT_SELF, "oGoTo2", oGoTo2);
								}
						 object oGoTo3 = GetLocalObject(OBJECT_SELF, "oGoTo3");
						 if(oGoTo3 == OBJECT_INVALID)
							 	{oGoTo3 = GetWaypointByTag("slv_el_air_wp3");
								 SetLocalObject(OBJECT_SELF, "oGoTo3", oGoTo3);
								}
						 object oGoTo4 = GetLocalObject(OBJECT_SELF, "oGoTo4");
						 if(oGoTo4 == OBJECT_INVALID)
							 	{oGoTo4 = GetWaypointByTag("slv_el_air_wp4");
								 SetLocalObject(OBJECT_SELF, "oGoTo4", oGoTo4);
								}
						 location lGoTo2 = GetLocation(oGoTo2);
						 location lGoTo3 = GetLocation(oGoTo3);
						 location lGoTo4 = GetLocation(oGoTo4);
				 		 object oCollWP = GetLocalObject(OBJECT_SELF, "oCollWP");
						 if(oCollWP == OBJECT_INVALID)
						 	{oCollWP = GetWaypointByTag("slv_deansphinx_e_air_collboxWP");
							 SetLocalObject(OBJECT_SELF, "oCollWP", oCollWP);
							}
						 object oMyCollisionBox = GetLocalObject(oCollWP, "oMyCollisionBox");
						 if(oMyCollisionBox == OBJECT_INVALID)
						 	{oMyCollisionBox = GetObjectByTag("slv_deansphinx_e_air_collbox");
							 SetLocalObject(oCollWP, "oMyCollisionBox", oMyCollisionBox);
							}
						 object oEndWP = GetLocalObject(OBJECT_SELF, "oEndWP");
						 if(oEndWP == OBJECT_INVALID)
						 	{oEndWP = GetWaypointByTag("slv_deansphinx_e_flight_WP");
							 SetLocalObject(OBJECT_SELF, "oEndWP", oEndWP);
							}
				 
						 DestroyObject(oMyCollisionBox);
						 SetLocalObject(oCollWP, "oMyCollisionBox", OBJECT_INVALID);
						 DelayCommand(5.0, AssignCommand(OBJECT_SELF, ActionJumpToLocation(lGoTo3)));
				 	     DelayCommand(10.0, SendMessageToPC(OBJECT_SELF, "Gravity rights itself. It seems the antigravity spell has ended and you begin a plunge towards the icy glacier!"));
						 DelayCommand(15.0, AssignCommand(OBJECT_SELF, ActionJumpToLocation(lGoTo2)));
				 	     DelayCommand(20.0, SendMessageToPC(OBJECT_SELF, "At the height of two tall men above the ice, however, your descent abruptly slows. You land upon the glacier with the gentleness of a falling snowflake."));
				 		 DelayCommand(25.0, AssignCommand(OBJECT_SELF, ActionJumpToLocation(GetLocation(oEndWP))));
					}
							 
					if(FindSubString(GetName(GetItemInSlot(INVENTORY_SLOT_CLOAK, OBJECT_SELF)), "Greatcloak") != -1)
						{//SendMessageToPC(OBJECT_SELF, "Cloak Slot = " +  GetName(GetItemInSlot(INVENTORY_SLOT_CLOAK, OBJECT_SELF)));
						 fTimeLoop = 300.0;
						}
					if(GetIsSkillSuccessful(OBJECT_SELF, SKILL_SURVIVAL, 12, TRUE))
						{SetLocalInt(OBJECT_SELF, "Survival", 4);
						SendMessageToPC(OBJECT_SELF, "Your ability to survive in the wilderness keeps you from succumbing to the worst of the cold.");
						}
					if ((!GetHasSpellEffect(SPELL_ENDURE_ELEMENTS, OBJECT_SELF)) && (!GetHasSpellEffect(SPELL_RESIST_ENERGY, OBJECT_SELF))&& (!GetHasSpellEffect(SPELL_PROTECTION_FROM_ENERGY, OBJECT_SELF)))
				         {int nSurvival = GetLocalInt(OBJECT_SELF, "Survival");
						  int nDC = 12 + nRepCold - nSurvival;
						  if(!FortitudeSave(OBJECT_SELF, nDC, SAVING_THROW_TYPE_COLD, OBJECT_SELF))
							{ACR_ApplyNLDDamageToCreature(OBJECT_SELF, d6());
							 SendMessageToPC(OBJECT_SELF, "The bitter cold takes its toll!");
							 ACR_NLD_ReportTotal(OBJECT_SELF, OBJECT_SELF, 0);
							 }
						 }
					else {SendMessageToPC(OBJECT_SELF, "You feel your elemental protection spell keeping the worst of the cold at bay.");
					     }
					
					SetLocalInt(OBJECT_SELF, "Survival", 0);
					nRepCold++;
					SetLocalInt(OBJECT_SELF, "nRepCold", nRepCold);
					if(GetTag(GetArea(OBJECT_SELF)) == "5b_ext_frosthills_glacier")
						{DelayCommand(fTimeLoop, ExecuteScript("slv_static_voice_cr_pc", OBJECT_SELF));}
					}
				 else {SetLocalInt(OBJECT_SELF, "ColdRep", 0);
				 	   SetLocalInt(OBJECT_SELF, "nRepCold", 0);
					  }
					
				
				
		//deandragon_e_fire heat damage loop
	 	if(GetLocalInt(OBJECT_SELF, "HeatRep") == 1)
				{float fTimeLoop = 91.0;
					 if(GetIsSkillSuccessful(OBJECT_SELF, SKILL_SURVIVAL, 15, TRUE))
							{SetLocalInt(OBJECT_SELF, "Survival", 4);}
						int nRep = GetLocalInt(OBJECT_SELF, "nRepHot");
						if ((!GetHasSpellEffect(SPELL_ENDURE_ELEMENTS, OBJECT_SELF)) && (!GetHasSpellEffect(SPELL_RESIST_ENERGY, OBJECT_SELF))&& (!GetHasSpellEffect(SPELL_PROTECTION_FROM_ENERGY, OBJECT_SELF)))
					         {
							 if(!FortitudeSave(OBJECT_SELF, 15 + nRep - GetLocalInt(OBJECT_SELF, "Survival"), SAVING_THROW_TYPE_FIRE, OBJECT_SELF))
								{ACR_ApplyNLDDamageToCreature(OBJECT_SELF, d6());
								 SendMessageToPC(OBJECT_SELF, "The excrutiating heat takes its toll!");
								 ACR_NLD_ReportTotal(OBJECT_SELF, OBJECT_SELF, 0);
								 }
							 }
						else {SendMessageToPC(OBJECT_SELF, "You feel your elemental protection spell keeping the worst of the heat at bay.");
							}
						
						SetLocalInt(OBJECT_SELF, "Survival", 0);
						nRep++;
						SetLocalInt(OBJECT_SELF, "nRepHot", nRep);
							if(FindSubString(GetTag(GetArea(OBJECT_SELF)), "everfire", 0))
								{DelayCommand(fTimeLoop, ExecuteScript("slv_static_voice_cr_pc", OBJECT_SELF));}
						}
			
				 else {SetLocalInt(OBJECT_SELF, "HeatRep", 0);
				 	   SetLocalInt(OBJECT_SELF, "nRepHot", 0);
					  }
					
			 
			
}