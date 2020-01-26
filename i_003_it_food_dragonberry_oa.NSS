//Silvy Uni Item onAcquire.  
//Wynna February 2008


#include "acr_items_i"
#include "acr_spawn_i"
#include "acr_tools_i"
#include "acr_db_persist_i"
#include "acr_quest_i"


void main()
{	object oTaker = GetModuleItemAcquiredBy();
	object oItem = GetModuleItemAcquired();
	object oArea = GetArea(oTaker);
	
	if((GetTag(oItem) == "003_it_food_dragonberry") && (GetIsPC(oTaker)))
        {int iFrozen = GetLocalInt(OBJECT_SELF, "Frozen");
		 object oMyBush = GetLocalObject(OBJECT_SELF, "oMyBush");
		 if(iFrozen == 1)
		 	{SendMessageToPC(oTaker, "The berry appears frozen solid. The magic spell has interacted with the berry to create an effect that won't thaw for hours or days.");
			}
		  if(ACR_RetrieveQuestState("slv_deandragon_d", oTaker) == 6)
				{ACR_AddPersistentJournalQuestEntry("slv_deandragon_d", 7, oTaker);
				}
		 if(ACR_RetrieveQuestState("slv_dragonberry", oTaker) == 3)
				{ACR_AddPersistentJournalQuestEntry("slv_dragonberry", 4, oTaker);
				}
			
		  }
					

}			  