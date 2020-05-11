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
	object oBox = GetModuleItemLostBy();
	object oArea = GetArea(oTaker);
	
	if((GetTag(oItem) == "auril_it_aurilhs_cursed") && ((GetIsPC(oTaker)) || (GetIsDMPossessed(oTaker))))
        {SendMessageToPC(oTaker, "As your hand closed around this symbol, a cold shock goes through your hand.");
		 DelayCommand(10.0, SendMessageToPC(oTaker, "The cold spreads up your arm and lances into your head. You feel your mouth opening and hear words emerge that are not your own."));
		 DelayCommand(15.0, AssignCommand(oTaker, ActionSpeakString("Auril is displeased with the incursion of air upon the ice.", TALKVOLUME_TALK))); 
		 DelayCommand(20.0, AssignCommand(oTaker, ActionCastSpellAtObject(SPELL_BESTOW_CURSE, oTaker, METAMAGIC_NONE, TRUE, 6, PROJECTILE_PATH_TYPE_DEFAULT, TRUE))); 
		}
					

}			  