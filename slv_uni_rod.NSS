#include "silvy_univ_inc"
#include "silvy_univ_func"
#include "acr_quest_i"



void main()
{
    object oDM = GetItemActivator();
	if(oDM == OBJECT_INVALID)
		{oDM = OBJECT_SELF;
		}
    
    object oStudent = GetItemActivatedTarget();
	location lStudent = GetItemActivatedTargetLocation();
    location lCreate = GetLocalLocation(oDM, "lCreate");
	
	

    //University Rod
	
	

 if((GetIsDM(oDM)) || (GetIsDMPossessed(oDM)) || (FindSubString(GetName(oDM), "Wynna", 0) != -1) )
		{if((IsStudentEnrolledInSilvyUniversity(oStudent)) && (GetIsPC(oStudent)) || (FindSubString(GetName(oDM), "Wynna", 0) != -1))
		    {SendMessageToPC(oDM, "***");
			SendMessageToPC(oDM, "ALL COURSE INFO FOR " + GetName(oStudent) + ":");
			SendMessageToPC(oDM, "Elementary Abjuration = " + GetCampaignString("SLV_UNI", "Elementary AbjurationInfo", oStudent));
			SendMessageToPC(oDM, "Elementary Conjuration = " + GetCampaignString("SLV_UNI", "Elementary ConjurationInfo", oStudent));
			SendMessageToPC(oDM, "Elementary Divination = " + GetCampaignString("SLV_UNI", "Elementary DivinationInfo", oStudent));
			SendMessageToPC(oDM, "Elementary Enchantment = " + GetCampaignString("SLV_UNI", "Elementary EnchantmentInfo", oStudent));
			SendMessageToPC(oDM, "Elementary Evocation = " + GetCampaignString("SLV_UNI", "Elementary EvocationInfo", oStudent));
			SendMessageToPC(oDM, "Elementary Illusion = " + GetCampaignString("SLV_UNI", "Elementary IllusionInfo", oStudent));
			SendMessageToPC(oDM, "Elementary Necromancy = " + GetCampaignString("SLV_UNI", "Elementary NecromancyInfo", oStudent));
			SendMessageToPC(oDM, "Elementary Transmutation = " + GetCampaignString("SLV_UNI", "Elementary TransmutationInfo", oStudent));
			SendMessageToPC(oDM, "Standard Abjuration = " + GetCampaignString("SLV_UNI", "Standard AbjurationInfo", oStudent));
			SendMessageToPC(oDM, "Standard Conjuration = " + GetCampaignString("SLV_UNI", "Standard ConjurationInfo", oStudent));
			SendMessageToPC(oDM, "Standard Divination = " + GetCampaignString("SLV_UNI", "Standard DivinationInfo", oStudent));
			SendMessageToPC(oDM, "Standard Enchantment = " + GetCampaignString("SLV_UNI", "Standard EnchantmentInfo", oStudent));
			SendMessageToPC(oDM, "Standard Evocation = " + GetCampaignString("SLV_UNI", "Standard EvocationInfo", oStudent));
			SendMessageToPC(oDM, "Standard Illusion = " + GetCampaignString("SLV_UNI", "Standard IllusionInfo", oStudent));
			SendMessageToPC(oDM, "Standard Necromancy = " + GetCampaignString("SLV_UNI", "Standard NecromancyInfo", oStudent));
			SendMessageToPC(oDM, "Standard Transmutation = " + GetCampaignString("SLV_UNI", "Standard TransmutationInfo", oStudent));
			SendMessageToPC(oDM, "Advanced Abjuration = " + GetCampaignString("SLV_UNI", "Advanced AbjurationInfo", oStudent));
			SendMessageToPC(oDM, "Advanced Conjuration = " + GetCampaignString("SLV_UNI", "Advanced ConjurationInfo", oStudent));
			SendMessageToPC(oDM, "Advanced Divination = " + GetCampaignString("SLV_UNI", "Advanced DivinationInfo", oStudent));
			SendMessageToPC(oDM, "Advanced Enchantment = " + GetCampaignString("SLV_UNI", "Advanced EnchantmentInfo", oStudent));
			SendMessageToPC(oDM, "Advanced Evocation = " + GetCampaignString("SLV_UNI", "Advanced EvocationInfo", oStudent));
			SendMessageToPC(oDM, "Advanced Illusion = " + GetCampaignString("SLV_UNI", "Advanced IllusionInfo", oStudent));
			SendMessageToPC(oDM, "Advanced Necromancy = " + GetCampaignString("SLV_UNI", "Advanced NecromancyInfo", oStudent));
			SendMessageToPC(oDM, "Advanced Transmutation = " + GetCampaignString("SLV_UNI", "Advanced TransmutationInfo", oStudent));
			SendMessageToPC(oDM, "Senior Abjuration =" + GetCampaignString("SLV_UNI", "Senior AbjurationInfo", oStudent));
			SendMessageToPC(oDM, "Senior Conjuration = " + GetCampaignString("SLV_UNI", "Senior ConjurationInfo", oStudent));
			SendMessageToPC(oDM, "Senior Divination = " + GetCampaignString("SLV_UNI", "Senior DivinationInfo", oStudent));
			SendMessageToPC(oDM, "Senior Enchantment = " + GetCampaignString("SLV_UNI", "Senior EnchantmentInfo", oStudent));
			SendMessageToPC(oDM, "Senior Evocation = " + GetCampaignString("SLV_UNI", "Senior EvocationInfo", oStudent));
			SendMessageToPC(oDM, "Senior Illusion = " + GetCampaignString("SLV_UNI", "Senior IllusionInfo", oStudent));
			SendMessageToPC(oDM, "Senior Necromancy = " + GetCampaignString("SLV_UNI", "Senior NecromancyInfo", oStudent));
			SendMessageToPC(oDM, "Senior Transmutation = " + GetCampaignString("SLV_UNI", "Senior TransmutationInfo", oStudent));
			SendMessageToPC(oDM, "Abjuration Graduation =" + GetCampaignString("SLV_UNI", "Graduation AbjurationInfo", oStudent));
			SendMessageToPC(oDM, "Conjuration Graduation = " + GetCampaignString("SLV_UNI", "Graduation ConjurationInfo", oStudent));
			SendMessageToPC(oDM, "Divination Graduation  = " + GetCampaignString("SLV_UNI", "Graduation DivinationInfo", oStudent));
			SendMessageToPC(oDM, "Enchantment Graduation = " + GetCampaignString("SLV_UNI", "Graduation EnchantmentInfo", oStudent));
			SendMessageToPC(oDM, "Evocation Graduation = " + GetCampaignString("SLV_UNI", "Graduation EvocationInfo", oStudent));
			SendMessageToPC(oDM, "Illusion Graduation  = " + GetCampaignString("SLV_UNI", "Graduation IllusionInfo", oStudent));
			SendMessageToPC(oDM, "Necromancy Graduation = " + GetCampaignString("SLV_UNI", "Graduation NecromancyInfo", oStudent));
			SendMessageToPC(oDM, "Transmutation Graduation = " + GetCampaignString("SLV_UNI", "Graduation TransmutationInfo", oStudent));
			}
			
			
		//Retrieve Dean's Quest quest states
			int iABC = 0;
	        string sCapitals = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
	        string sSmalls = "abcdefghijklmnopqrstuvwxyz";
	        string sCapitalLetter = GetSubString(sCapitals, iABC, 1);
	        string sSmallLetter = GetSubString(sSmalls, iABC, 1);
	        while(iABC < 27)
	         	{if(ACR_RetrieveQuestState("slv_deansphinx_" + sSmallLetter,  oStudent) > 0)
					{SendMessageToPC(oDM, "DeanSphinx " + sCapitalLetter + " = " + IntToString(ACR_RetrieveQuestState("slv_deansphinx_" + sSmallLetter, oStudent)));
					}
				iABC++;
				sCapitalLetter = GetSubString(sCapitals, iABC, 1);
	        	sSmallLetter = GetSubString(sSmalls, iABC, 1);
	        	}
			
		//Toggle walk off/on for NPCs	
		float fDistance = GetDistanceBetweenLocations(lStudent, GetLocation(oDM));
		SendMessageToPC(oDM, "Distance to " + GetName(oStudent) + " = " + FloatToString(fDistance));
		SendMessageToPC(oDM, "Time-- " + IntToString(GetTimeHour()) + ":" + IntToString(GetTimeMinute()));
		if((GetIsPC(oStudent) != TRUE) && (GetLocalInt(oStudent, "Walk_Off") == 0))
			{AssignCommand(oStudent, ClearAllActions(TRUE));
			 SetLocalInt(oStudent, "Walk_Off", 1);
			 SendMessageToPC(oDM, GetName(oStudent) + ": My walk patterns are now off.");
			 if(GetLocalInt(oDM, "Group_Walk") == 1)
				{object oNext = GetFirstObjectInShape(SHAPE_SPHERE, 25.0, GetLocation(oStudent), FALSE, OBJECT_TYPE_CREATURE);
				 while (oNext != OBJECT_INVALID)
				 	{if(GetIsPC(oNext) != TRUE)
						{AssignCommand(oNext, ClearAllActions(TRUE));
				         SetLocalInt(oNext, "Walk_Off", 1);
				 		 SendMessageToPC(oDM, GetName(oNext) + ": My walk patterns are now off.");
				 		}
					 oNext = GetNextObjectInShape(SHAPE_SPHERE, 25.0, GetLocation(oStudent), FALSE, OBJECT_TYPE_CREATURE);
				    }
				}
			}
		else if(GetLocalInt(oStudent, "Walk_Off") == 1)
			{SetLocalInt(oStudent, "Walk_Off", 0);
			 SendMessageToPC(oDM, GetName(oStudent) + ": My walk patterns are now back on.");
			 ExecuteScript("slv_uni_walk", oStudent);
			 if(GetLocalInt(oDM, "Group_Walk") == 1)
				{object oNext = GetFirstObjectInShape(SHAPE_SPHERE, 25.0, GetLocation(oStudent), FALSE, OBJECT_TYPE_CREATURE);
				 while (oNext != OBJECT_INVALID)
				 	{if(GetIsPC(oNext) != TRUE)
						{SetLocalInt(oNext, "Walk_Off", 0);
				 		 SendMessageToPC(oDM, GetName(oNext) + ": My walk patterns are now back on.");
				 		 ExecuteScript("slv_uni_walk", oNext);
					   }
					 oNext = GetNextObjectInShape(SHAPE_SPHERE, 25.0, GetLocation(oStudent), FALSE, OBJECT_TYPE_CREATURE);
				    }
			
	 			}
			}
		
		
		SetLocalInt(oDM, "Group_Walk", 0);

		
		//Create NPCs that are not slaved to their Uni spawn times but will self destroy in two hours.
		if(GetIsLocationValid(lCreate) == TRUE)
		{string sResRef;
		 int iResRef = GetLocalInt(oDM, "Uni_NPC");
		 if(iResRef != 0)
		 	{if(iResRef == 1)
				{sResRef = "003_cr_slv_registrar";
				}
			 if(iResRef == 2)
				{sResRef = "003_cr_slv_dean";
				}
			 if(iResRef == 3)
				{sResRef = "003_cr_slv_librarian";
				}
			 if(iResRef == 4)
				{sResRef = "003_cr_slv_scribe";
				}
			 if(iResRef == 5)
				{sResRef = "003_cr_slv_augustine";
				}
			 if(iResRef == 6)
				{sResRef = "003_cr_slv_spellguard";
				}
			 if(iResRef == 7)
				{sResRef = "003_cr_slv_miresk";
				}
			 if(iResRef == 8)
				{sResRef = "003_cr_slv_arken";
				}
			 if(iResRef == 9)
				{sResRef = "003_cr_slv_belad";
				}
			  if(iResRef == 10)
				{sResRef = "003_cr_slv_incinder2";
				}
			 if(iResRef == 21)
				{sResRef = "003_cr_slv_profabj";
				}
			 if(iResRef == 22)
				{sResRef = "003_cr_slv_profcon";
				}
			 if(iResRef == 23)
				{sResRef = "003_cr_slv_profdiv";
				}
			 if(iResRef == 24)
				{sResRef = "003_cr_slv_profenc";
				}
			 if(iResRef == 25)
				{sResRef = "003_cr_slv_profevo";
				}
			 if(iResRef == 26)
				{sResRef = "003_cr_slv_profill";
				}
			 if(iResRef == 27)
				{sResRef = "003_cr_slv_profnec";
				}
			 if(iResRef == 28)
				{sResRef = "003_cr_slv_proftra";
				}
			 if(iResRef == 31)
				{sResRef = "003_cr_slv_procabj";
				}
			 if(iResRef == 32)
				{sResRef = "003_cr_slv_proccon";
				}
			 if(iResRef == 33)
				{sResRef = "003_cr_slv_procdiv";
				}
			 if(iResRef == 34)
				{sResRef = "003_cr_slv_procenc";
				}
			 if(iResRef == 342)
				{sResRef = "003_cr_slv_procenc2";
				}
			 if(iResRef == 35)
				{sResRef = "003_cr_slv_procevo";
				}
			 if(iResRef == 36)
				{sResRef = "003_cr_slv_procill";
				}
			 if(iResRef == 37)
				{sResRef = "003_cr_slv_procnec";
				}
			 if(iResRef == 38)
				{sResRef = "003_cr_slv_proctra";
				}	
			 if(iResRef == 39)
				{sResRef = "003_cr_slv_studabj";
				}	
			 if(iResRef == 40)
				{sResRef = "003_cr_slv_studdiv";
				}	
			 if(iResRef == 41)
				{sResRef = "003_cr_slv_studevo";
				}	
			 if(iResRef == 42)
				{sResRef = "003_cr_slv_studnec";
				}	
			  if(iResRef == 43)
				{sResRef = "003_cr_slv_studtra";
				}	
			 if(iResRef == 44)
				{sResRef = "003_cr_slv_evelyn";
				}	
			  	
			 object oCreate = CreateObject(OBJECT_TYPE_CREATURE, sResRef, lCreate, FALSE, sResRef + "_Wand");
			 SetLocalInt(oDM, "Uni_NPC", 0);
			 DelayCommand(7200.0, SendMessageToPC(oDM, GetTag(oCreate) + " will self-destroy in 1 minute"));
			 DestroyObject(oCreate, 7260.0);
			 }
		}
	}
  
}