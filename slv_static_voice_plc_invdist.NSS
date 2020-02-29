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

		
if((GetTag(OBJECT_SELF) == "vala_sphinx")  && (GetInventoryDisturbType() == INVENTORY_DISTURB_TYPE_ADDED))
	{if(FindSubString(GetTag(oItem), "slv_deansphinx_", 0) != -1)
		{object oItemOne = GetFirstItemInInventory(OBJECT_SELF);
		 string sItemOneName = GetName(oItemOne);
		 string sItemOne = GetTag(oItemOne);
		 //ActionSpeakString("sItemOneName = "  + sItemOneName, TALKVOLUME_TALK);
		 while (oItemOne != OBJECT_INVALID)
		 	{object oItemNext = GetFirstItemInInventory(OBJECT_SELF);
			 while (oItemNext != OBJECT_INVALID)
			 	{string sItemNextName = GetName(oItemNext);
				 //ActionSpeakString("sItemNextName = "  + sItemNextName, TALKVOLUME_TALK);
		         string sItemNext = GetTag(oItemNext);
				 if((sItemOne == sItemNext + "_essence") || (sItemNext == sItemOne + "_essence")) 
					 {ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGlimmer, OBJECT_SELF, 10.0);
	                  DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSoothing, OBJECT_SELF, 10.0));
					  
					  if(FindSubString(sItemOne, "_essence", 0) != -1)
					  	{//ActionSpeakString("ItemOne is the essence and its tag = "  + sItemOne, TALKVOLUME_TALK);
						//object oEssence = oItemOne;
						 string sEssenceName = GetName(oItemOne);
						 //object oBook = oItemNext;
						 string sBookName = GetName(oItemNext);
						 string sQuestAlpha = GetStringLeft(sBookName,1);
						 string sBookDescription = GetDescription(oItemNext);
						 string sQuest = "slv_deansphinx_" + GetStringLowerCase(sQuestAlpha);
						 string sPreposition = "";
						 if((sQuestAlpha == "A") || (sQuestAlpha == "E") || (sQuestAlpha == "I")|| (sQuestAlpha == "O")|| (sQuestAlpha == "U"))
						 	{sPreposition = "n";}
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
						 
						string sKeyword = "";				
						if(sQuestAlpha == "A")
						 	{sKeyword = "Archival";}
						 if(sQuestAlpha == "B")
						 	{sKeyword = "Bindings";}
						 if(sQuestAlpha == "C")
						 	{sKeyword = "Concluded";}
						 if(sQuestAlpha == "D")
						 	{sKeyword = "Defines";}
						 if(sQuestAlpha == "E")
						 	{sKeyword = "Essences";}
						 if(sQuestAlpha == "F")
						 	{sKeyword = "Favoring";}
						 if(sQuestAlpha == "G")
						 	{sKeyword = "Grand";}
						 if(sQuestAlpha == "H")
						 	{sKeyword = "Harmonious";}
						 if(sQuestAlpha == "I")
						 	{sKeyword = "Insights";}
						 if(sQuestAlpha == "J")
						 	{sKeyword = "Joining";}
						 if(sQuestAlpha == "K")
						 	{sKeyword = "Keyed";}
						 if(sQuestAlpha == "L")
						 	{sKeyword = "Lives";}
						 if(sQuestAlpha == "M")
						 	{sKeyword = "Monstrous";}
						 if(sQuestAlpha == "N")
						 	{sKeyword = "Name";}
						 if(sQuestAlpha == "O")
						 	{sKeyword = "Opens";}
						 if(sQuestAlpha == "P")
						 	{sKeyword = "Pyramid";}
						 if(sQuestAlpha == "Q")
						 	{sKeyword = "Quest";}
						 if(sQuestAlpha == "R")
						 	{sKeyword = "Reveals";}
						 if(sQuestAlpha == "S")
						 	{sKeyword = "Sphinx";}
						 if(sQuestAlpha == "T")
						 	{sKeyword = "Tomb";}
						 if(sQuestAlpha == "U")
						 	{sKeyword = "Undergrads";}
						 if(sQuestAlpha == "V")
						 	{sKeyword = "Venture";}
						 if(sQuestAlpha == "W")
						 	{sKeyword = "Wildly";}
						 if(sQuestAlpha == "X")
						 	{sKeyword = "Xavier's";}
						 if(sQuestAlpha == "Y")
						 	{sKeyword = "Yard";}
						 if(sQuestAlpha == "Z")
						 	{sKeyword = "Zoological";}
						 	
						/*if(ACR_RetrieveQuestState(sQuest, oUser)< nEnd -1 )
						 	{int nXP= GetJournalQuestExperience(sQuest); 
							 ACR_AddPersistentJournalQuestEntry(sQuest, nEnd -1, oUser, TRUE, FALSE, FALSE, 0);
							 }
						*/
						if(ACR_RetrieveQuestState(sQuest, oUser)< nEnd)
						 	{//int nXP= GetJournalQuestExperience(sQuest); 
							 ACR_AddPersistentJournalQuestEntry(sQuest, nEnd, oUser, TRUE, FALSE, FALSE, 100);
							 SendMessageToPC(oUser, "You hear a voice speak directly into your mind. It whispers a single word.");
							 SendMessageToPC(oUser, "The word is: " +sKeyword + ".");
							 }
					 }
						
					  if(FindSubString(sItemNext, "_essence", 0) != -1)
					   {//object oEssence = oItemNext;
						//object oBook = oItemOne;
						//ActionSpeakString("ItemNext is the essence and its tag = "  + sItemNext, TALKVOLUME_TALK);
						string sBookName = GetName(oItemOne);
						string sEssenceName = GetName(oItemNext);
						string sQuestAlpha = GetStringLeft(sBookName,1);
						string sBookDescription = GetDescription(oItemOne);
						string sQuest = "slv_deansphinx_" + sQuestAlpha;
						string sPreposition = "";
						if((sQuestAlpha == "A") || (sQuestAlpha == "E") || (sQuestAlpha == "I")|| (sQuestAlpha == "O")|| (sQuestAlpha == "U"))
						 	{sPreposition = "n";}
						 ActionSpeakString(sEssenceName + " has been appended to the draft page for " + sBookName + ". This revision completes this entry.", TALKVOLUME_TALK);
						 SetDescription(oItemOne, "This is the final draft of the '" + sQuestAlpha + "'Entry of the 'Bestiary of the Marches'. It carries the shimmering image of a " + sPreposition + " " +sBookName + ".          " + sBookDescription);
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
						 
						string sKeyword = "";				
						if(sQuestAlpha == "A")
						 	{sKeyword = "Archival";}
						 if(sQuestAlpha == "B")
						 	{sKeyword = "Bindings";}
						 if(sQuestAlpha == "C")
						 	{sKeyword = "Concluded";}
						 if(sQuestAlpha == "D")
						 	{sKeyword = "Defines";}
						 if(sQuestAlpha == "E")
						 	{sKeyword = "Essences";}
						 if(sQuestAlpha == "F")
						 	{sKeyword = "Favoring";}
						 if(sQuestAlpha == "G")
						 	{sKeyword = "Grand";}
						 if(sQuestAlpha == "H")
						 	{sKeyword = "Harmonious";}
						 if(sQuestAlpha == "I")
						 	{sKeyword = "Insights";}
						 if(sQuestAlpha == "J")
						 	{sKeyword = "Joining";}
						 if(sQuestAlpha == "K")
						 	{sKeyword = "Keyed";}
						 if(sQuestAlpha == "L")
						 	{sKeyword = "Lives";}
						 if(sQuestAlpha == "M")
						 	{sKeyword = "Monstrous";}
						 if(sQuestAlpha == "N")
						 	{sKeyword = "Name";}
						 if(sQuestAlpha == "O")
						 	{sKeyword = "Opens";}
						 if(sQuestAlpha == "P")
						 	{sKeyword = "Pyramid";}
						 if(sQuestAlpha == "Q")
						 	{sKeyword = "Quest";}
						 if(sQuestAlpha == "R")
						 	{sKeyword = "Reveals";}
						 if(sQuestAlpha == "S")
						 	{sKeyword = "Sphinx";}
						 if(sQuestAlpha == "T")
						 	{sKeyword = "Tomb";}
						 if(sQuestAlpha == "U")
						 	{sKeyword = "Undergrads";}
						 if(sQuestAlpha == "V")
						 	{sKeyword = "Venture";}
						 if(sQuestAlpha == "W")
						 	{sKeyword = "Wildly";}
						 if(sQuestAlpha == "X")
						 	{sKeyword = "Xavier's";}
						 if(sQuestAlpha == "Y")
						 	{sKeyword = "Yard";}
						 if(sQuestAlpha == "Z")
						 	{sKeyword = "Zoological";}
						 	
						/*if(ACR_RetrieveQuestState(sQuest, oUser)< nEnd -1 )
						 	{int nXP= GetJournalQuestExperience(sQuest); 
							 ACR_AddPersistentJournalQuestEntry(sQuest, nEnd -1, oUser, TRUE, FALSE, FALSE, 0);
							 }
						*/
						if(ACR_RetrieveQuestState(sQuest, oUser)< nEnd)
						 	{ACR_AddPersistentJournalQuestEntry(sQuest, nEnd, oUser, TRUE, FALSE, FALSE, 100);
							 SendMessageToPC(oUser, "You hear a voice speak directly into your mind. It whispers a single word.");
							 SendMessageToPC(oUser, "The word is: " +sKeyword + ".");
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