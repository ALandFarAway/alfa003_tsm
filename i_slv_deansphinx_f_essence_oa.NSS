//Silvy Uni Item onAcquire.  
//Wynna February 2020


#include "acr_items_i"
#include "acr_spawn_i"
#include "acr_tools_i"
#include "acr_db_persist_i"
#include "acr_quest_i"


void main()
{	object oTaker = GetModuleItemAcquiredBy();
	object oItem = GetModuleItemAcquired();
	object oArea = GetArea(oTaker);
	
	if((GetTag(oItem) == "slv_deansphinx_f_essence") && (GetIsPC(oTaker)))
        {if((ACR_RetrieveQuestState("slv_deansphinx_f", oTaker) >= 1) && (ACR_RetrieveQuestState("slv_deansphinx_f", oTaker) <= 7))
				{ACR_AddPersistentJournalQuestEntry("slv_deansphinx_f", 7, oTaker);
				}
		 if((ACR_RetrieveQuestState("slv_deansphinx_e_fire", oTaker) >= 1) && (ACR_RetrieveQuestState("slv_deansphinx_e_fire", oTaker) <= 3))
				{ACR_AddPersistentJournalQuestEntry("slv_deansphinx_e_fire", 3, oTaker);
				}
		 if((ACR_RetrieveQuestState("slv_deansphinx_e_air", oTaker) == 3) && (ACR_RetrieveQuestState("slv_deansphinx_e_earth", oTaker) == 3) && (ACR_RetrieveQuestState("slv_deansphinx_e_fire", oTaker) == 3) && (ACR_RetrieveQuestState("slv_deansphinx_e_water", oTaker) == 3))
				{ACR_AddPersistentJournalQuestEntry("slv_deansphinx_e", 3, oTaker);
				}	
		 	
		  }
					

}			  