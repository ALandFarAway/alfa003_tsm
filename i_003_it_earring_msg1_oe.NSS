
//Wynna April 2021

 
#include "acr_items_i"
#include "acr_db_persist_i"
#include "acr_quest_i"
#include "dmfi_inc_langexe" 
#include "x2_inc_itemprop"	

void main()
{	
	object oItem = GetPCItemLastEquipped();
 	object oPC = GetPCItemLastEquippedBy();
			
	object oTool=DMFI_GetTool(oPC);
	SendMessageToPC(oPC, "*A deep, resonant voice speaks into your ear in common, a short and compelling command.*  Listen and do as I direct.");
	if(WillSave(oPC, 19, SAVING_THROW_TYPE_MIND_SPELLS, OBJECT_SELF) < 1) {
		DelayCommand(6.0, SendMessageToPC(oPC, "*You feel fully invested in listening and following whatever his commands will be.*"));
		SendMessageToAllDMs(GetName(oPC) + " has been dominated by a DC 19 Dominate Person imbued by Circus Ringmaster Xavier into an earring of command tuned with an enchantment shard. The PC will receive the following message: '*You feel fully invested in listening and following whatever his commands will be.*");
		SendMessageToAllDMs("I have two tasks for you, both dangerous, and best not left to chance. For the first, I send you a young dedicated and other mine orcs. Loose them on the dwarves. The time is right to take another load of ore. The many-toed pretender to your seelie court grows fractious.");
		SendMessageToAllDMs("For the second, take your dead master's shard that sings the song of cold to the Aurilite. She has agreed, finally. You will want to be more careful than was your master. The diviner claims to not forsee whether the growing feebleness from which the incautious summoner suffered could afflict your usefulness as it did his.");
		}
	else {DelayCommand(6.0, SendMessageToPC(oPC, "*You feel the power of the voice almost overcoming your willpower, but shake it off. You sense that you can listen without falling under its sway, or remove the earring.*"));
		}	
	DelayCommand(12.0, SendMessageToPC(oPC, "I have two tasks for you, both dangerous, and best not left to chance. For the first, I send you a young dedicated and other mine orcs. Loose them on the dwarves. The time is right to take another load of ore. The many-toed pretender to your seelie court grows fractious."));
	DelayCommand(18.0, SendMessageToPC(oPC, "For the second, take your dead master's shard that sings the song of cold to the Aurilite. She has agreed, finally. You will want to be more careful than was your master. The diviner claims to not forsee whether the growing feebleness from which the incautious summoner suffered could afflict your usefulness as it did his."));
	DelayCommand(24.0, SendMessageToPC(oPC, "*The voice ends, releasing you from its mesmerizing quality."));
			 
					 
}			  