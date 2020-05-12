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
	object oTaker = GetItemPossessor(GetObjectByTag("abr_it_auril_hs_cursed"));
         
	
	
		 SendMessageToPC(oTaker, "Taker: As your fingers close around this symbol, a cold shock goes through your palm.");
		 SendMessageToPC(oAcquirer, "Acquirer: As your fingers close around this symbol, a cold shock goes through your palm.");
		 
		 if(WillSave(oTaker, 15, SAVING_THROW_TYPE_MIND_SPELLS, OBJECT_SELF))
		 {DelayCommand(5.0, SendMessageToPC(oTaker, "You feel as if a cold wind had passed through you, leaving you shaken but uneffected. The holy symbol glitters malevolently."));
			 }
		 else	 	
		 	{DelayCommand(4.0, AssignCommand(oTaker, ActionEquipItem(oItem, INVENTORY_SLOT_NECK)));
		 	 DelayCommand(5.0, SendMessageToPC(oTaker, "You feel compelled to fasten the holy symbol around your neck."));
			 DelayCommand(10.0, SendMessageToPC(oTaker, "The cold spreads up your arm and lances into your head. You feel your mouth opening and hear words emerge that are not your own."));
			 DelayCommand(15.0, AssignCommand(oTaker, ActionSpeakString("Auril is displeased with the incursion of air upon the ice.", TALKVOLUME_TALK))); 
			 DelayCommand(20.0, AssignCommand(oTaker, ActionCastSpellAtObject(SPELL_BESTOW_CURSE, oTaker, METAMAGIC_NONE, TRUE, 6, PROJECTILE_PATH_TYPE_DEFAULT, TRUE))); 
			}
		 
		 	
		 
		 
					

}			  