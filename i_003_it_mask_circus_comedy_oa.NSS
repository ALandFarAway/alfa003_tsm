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
	object oTaker = GetItemPossessor(GetObjectByTag("003_it_mask_circus_comedy"));
         
	
	
		 SendMessageToPC(oAcquirer, "As your fingers close around this mask, a ripple of conflicting emotions goes through you, half a desire to burst into laughter and half a need to weep.");
		 if(GetLocalInt(OBJECT_SELF, "Charmed") == 0) {
		 if(WillSave(oAcquirer, 18, SAVING_THROW_TYPE_MIND_SPELLS, OBJECT_SELF) > 0)
		 	{DelayCommand(5.0, SendMessageToPC(oAcquirer, "The emotions fade."));
			 SendMessageToAllDMs(GetName(oAcquirer) + " made the will save and was not charmed by the mask.");
			 }
		 else	 	
		 	{DelayCommand(4.0, AssignCommand(oAcquirer, ActionEquipItem(oItem, INVENTORY_SLOT_HEAD)));
		 	 DelayCommand(5.0, SendMessageToPC(oAcquirer, "You feel compelled to fasten the mask across your face, and to say NOTHING of that compulsion."));
			 DelayCommand(15.0, SendMessageToPC(oAcquirer, "You hear a voice in your head, a deep, resonant voice that rolls within you and touches your heart. You know this person is a friend, and you are sorrowful that this, your great friend, is not here with you, but joyful to hear his words:"));
			 DelayCommand(20.0, AssignCommand(oAcquirer, ActionCastSpellAtObject(VFX_DUR_SPELL_CHARM_PERSON, oTaker, METAMAGIC_NONE, TRUE, 8, PROJECTILE_PATH_TYPE_DEFAULT, TRUE))); 
			 DelayCommand(25.0, SendMessageToPC(oAcquirer, "Life's but a walking shadow; a poor player, that struts and frets his hour upon the stage, and then is heard no more: it is a tale told by an idiot, full of sound and fury, signifying nothing."));
			 DelayCommand(35.0, SendMessageToPC(oAcquirer, "The voice continues, in a soft, friendly tone: 'You will forget you heard from me, but remember our friendship later.' Your memory of anything unusual since you acquired the mask blurs, then fades."));
			 SendMessageToAllDMs(GetName(oAcquirer) + " failed the will save and was charmed by the mask.");
			 SetLocalInt(OBJECT_SELF, "Charmed", 1);
			 
		 	}
		 }
		 	
		 
		 
					

}			  