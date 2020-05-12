//Silvy Uni Item onAcquire.  
//Wynna February 2008


#include "acr_items_i"
#include "acr_spawn_i"
#include "acr_tools_i"
#include "acr_db_persist_i"
#include "acr_quest_i"


void main()
{	object oAcquirer = GetModuleItemAcquiredBy();
	object oItem = GetModuleItemAcquired();
	object oTaker = GetItemPossessor(GetObjectByTag("abr_it_auril_hs_curse"));
         
	
	
		 SendMessageToPC(oAcquirer, "As your fingers close around this symbol, a cold shock goes through your palm.");
		  
		 if(WillSave(oAcquirer, 18, SAVING_THROW_TYPE_MIND_SPELLS, OBJECT_SELF) > 0)
		 {DelayCommand(5.0, SendMessageToPC(oAcquirer, "You feel as if a cold wind had passed through you, leaving you shaken but uneffected. The holy symbol glitters malevolently."));
			 }
		 else	 	
		 	{DelayCommand(4.0, AssignCommand(oAcquirer, ActionEquipItem(oItem, INVENTORY_SLOT_NECK)));
		 	 DelayCommand(5.0, SendMessageToPC(oAcquirer, "You feel compelled to fasten the holy symbol around your neck."));
			 DelayCommand(15.0, SendMessageToPC(oAcquirer, "The cold spreads up your arm and lances into your head. You feel your mouth opening and hear words emerge that are not your own."));
			 DelayCommand(25.0, AssignCommand(oAcquirer, ActionSpeakString("Auril is displeased with the incursion of air upon the ice.", TALKVOLUME_TALK))); 
			 DelayCommand(20.0, AssignCommand(oAcquirer, ActionCastSpellAtObject(SPELL_BESTOW_CURSE, oTaker, METAMAGIC_NONE, TRUE, 8, PROJECTILE_PATH_TYPE_DEFAULT, TRUE))); 
			}
		 
		 	
		 
		 
					

}			  