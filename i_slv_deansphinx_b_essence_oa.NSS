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
	
	if((GetTag(oItem) == "slv_deansphinx_b_essence") && (GetIsPC(oTaker)))
        {if((ACR_RetrieveQuestState("slv_deansphinx_b", oTaker) >= 1) && (ACR_RetrieveQuestState("slv_deansphinx_b", oTaker) <= 7))
				{ACR_AddPersistentJournalQuestEntry("slv_deansphinx_b", 7, oTaker);
				}
			
		  }
					

}			  