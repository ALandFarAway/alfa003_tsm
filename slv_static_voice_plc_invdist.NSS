//Wynna September 2009


#include "acr_placeable_i"
#include "acr_quest_i"

void main()
{
	ACR_PlaceableOnDisturbed();
    object oItem = GetInventoryDisturbItem();
	object oUser = GetLastDisturbed();
	effect eGlimmer = EffectVisualEffect(VFX_DUR_PIXIEDUST, FALSE);
    effect eSoothing = EffectVisualEffect(VFX_DUR_SOOTHING_LIGHT, FALSE);
	    
	
		 
if((GetTag(OBJECT_SELF) == "slv_deandragon_e_ice") && (GetInventoryDisturbType() == INVENTORY_DISTURB_TYPE_REMOVED))
	   {object oMyArrowhawk1 = GetNearestObjectByTag("003_slv_dq_a_creature", oUser, 1);
		object oMyArrowhawk2 = GetNearestObjectByTag("003_slv_dq_a_creature", oUser, 2);
		object oMyArrowhawk3 = GetNearestObjectByTag("003_slv_dq_a_creature", oUser, 3);
		object oMyArrowhawk4 = GetNearestObjectByTag("003_slv_dq_a_creature", oUser, 4);
	    object oMyArrowhawk5 = GetNearestObjectByTag("003_slv_dq_a_creature", oUser, 5);
		object oMyArrowhawk6 = GetNearestObjectByTag("003_slv_dq_a_creature", oUser, 6);
	    AssignCommand(oMyArrowhawk1, ActionSpeakString("*As soon as the eggs are touched, an arrowhawk hurtles from out of the sky!", TALKVOLUME_TALK));
		
		ChangeToStandardFaction(oMyArrowhawk1, STANDARD_FACTION_HOSTILE);
		ChangeToStandardFaction(oMyArrowhawk2, STANDARD_FACTION_HOSTILE);
		ChangeToStandardFaction(oMyArrowhawk3, STANDARD_FACTION_HOSTILE);
		ChangeToStandardFaction(oMyArrowhawk4, STANDARD_FACTION_HOSTILE);
		ChangeToStandardFaction(oMyArrowhawk5, STANDARD_FACTION_HOSTILE);
		ChangeToStandardFaction(oMyArrowhawk6, STANDARD_FACTION_HOSTILE);
		}

		
if(((GetTag(OBJECT_SELF) == "vala_sphinx") || (GetTag(OBJECT_SELF) == "slv_vala_bookcase_sphinx")) && (GetInventoryDisturbType() == INVENTORY_DISTURB_TYPE_ADDED))
	{if(FindSubString(GetTag(oItem), "slv_deansphinx_", 0) != -1)
		{object oItemOne = GetFirstItemInInventory(OBJECT_SELF);
		 while (oItemOne != OBJECT_INVALID)
		 	{string sItemOne = GetTag(oItemOne);
			 object oItemNext = GetFirstItemInInventory(OBJECT_SELF);
			 while (oItemNext != OBJECT_INVALID)
			 	{
				 string sItemNext = GetTag(oItemNext);
				 if((sItemOne == sItemNext + "_essence") || (sItemNext == sItemOne + "_essence")) 
					 {ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGlimmer, OBJECT_SELF, 10.0);
	                  DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSoothing, OBJECT_SELF, 10.0));
					  
					  if(FindSubString(sItemOne, "_essence", 0) != -1)
					  	{//object oEssence = oItemOne;
						 string sEssenceName = GetName(oItemOne);
						 //object oBook = oItemNext;
						 string sBookName = GetName(oItemNext);
						 string sQuestAlpha = GetStringLeft(sBookName,1);
						 string sBookDescription = GetDescription(oItemNext);
						 string sQuest = "slv_deansphinx_" + GetStringLowerCase(sQuestAlpha);
						 ActionSpeakString(sBookName + " essence has been appended to the draft page for " + sBookName + ". This revision completes this entry.", TALKVOLUME_TALK);
						 SetDescription(oItemNext, "This is the final draft of the '" + sQuestAlpha + "'Entry of the 'Bestiary of the Marches'. It carries the shimmering image of a " +sBookName + ".          " + sBookDescription);
						 int nEnd;
						 if((sQuestAlpha == "A") || (sQuestAlpha == "B")|| (sQuestAlpha == "C")|| (sQuestAlpha == "D")|| (sQuestAlpha == "F")|| (sQuestAlpha == "H")|| (sQuestAlpha == "I")|| (sQuestAlpha == "W")|| (sQuestAlpha == "X"))
						 	{nEnd = 9;}
						 if((sQuestAlpha == "E")|| (sQuestAlpha == "M"))
						 	{nEnd = 5;}
						 if((sQuestAlpha == "G") || (sQuestAlpha == "N")|| (sQuestAlpha == "O")|| (sQuestAlpha == "Q")|| (sQuestAlpha == "R")|| (sQuestAlpha == "S"))
						 	{nEnd = 7;}
						 if(sQuestAlpha == "J")
						 	{nEnd = 11;}
						 if(sQuestAlpha == "L")
						 	{nEnd = 10;}
						 if((sQuestAlpha == "P") || (sQuestAlpha == "Y") || (sQuestAlpha == "Z"))
						 	{nEnd = 4;}
						 if(sQuestAlpha == "T")
						 	{nEnd = 3;}
						 if(sQuestAlpha == "U")
						 	{nEnd = 6;}
						 
						if(ACR_RetrieveQuestState(sQuest, oUser)< nEnd)
						 	{int nXP= GetJournalQuestExperience(sQuest); 
							 ACR_AddPersistentJournalQuestEntry(sQuest, nEnd, oUser, TRUE, FALSE, FALSE, nXP);
							 }
					 }
						
					  if(FindSubString(sItemNext, "_essence", 0) != -1)
					   {//object oEssence = oItemNext;
						//object oBook = oItemOne;
						string sBookName = GetName(oItemOne);
						string sEssenceName = GetName(oItemNext);
						string sQuestAlpha = GetStringLeft(sBookName,1);
						string sBookDescription = GetDescription(oItemOne);
						string sQuest = "slv_deansphinx_" + sQuestAlpha;
						ActionSpeakString(sEssenceName + " has been appended to the draft page for " + sBookName + ". This revision completes this entry.", TALKVOLUME_TALK);
						SetDescription(oItemOne, "This is the final draft of the '" + sQuestAlpha + "'Entry of the 'Bestiary of the Marches'. It carries the shimmering image of a " +sBookName + ".          " + sBookDescription);
						 int nEnd;
						 if((sQuestAlpha == "A") || (sQuestAlpha == "B")|| (sQuestAlpha == "C")|| (sQuestAlpha == "D")|| (sQuestAlpha == "F")|| (sQuestAlpha == "H")|| (sQuestAlpha == "I")|| (sQuestAlpha == "W")|| (sQuestAlpha == "X"))
						 	{nEnd = 9;}
						 if((sQuestAlpha == "E")|| (sQuestAlpha == "M"))
						 	{nEnd = 5;}
						 if((sQuestAlpha == "G") || (sQuestAlpha == "N")|| (sQuestAlpha == "O")|| (sQuestAlpha == "Q")|| (sQuestAlpha == "R")|| (sQuestAlpha == "S"))
						 	{nEnd = 7;}
						 if(sQuestAlpha == "J")
						 	{nEnd = 11;}
						 if(sQuestAlpha == "L")
						 	{nEnd = 10;}
						 if((sQuestAlpha == "P") || (sQuestAlpha == "Y") || (sQuestAlpha == "Z"))
						 	{nEnd = 4;}
						 if(sQuestAlpha == "T")
						 	{nEnd = 3;}
						 if(sQuestAlpha == "U")
						 	{nEnd = 6;}
						 
						if(ACR_RetrieveQuestState(sQuest, oUser)< nEnd)
						 	{int nXP= GetJournalQuestExperience(sQuest); 
							 ACR_AddPersistentJournalQuestEntry(sQuest, nEnd, oUser, TRUE, FALSE, FALSE, nXP);
							 }
						}
					 }
				 oItemNext = GetNextItemInInventory(OBJECT_SELF);
				 }
			 oItemOne = GetNextItemInInventory(OBJECT_SELF);
			 }
		}
	 else {ActionSpeakString("This item is not part of any oracular divination.", TALKVOLUME_TALK);}
	}		

}