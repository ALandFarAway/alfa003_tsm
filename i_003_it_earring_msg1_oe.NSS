
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
	
	
	SendMessageToAllDMs(GetName(oPC) + " equipped a message earring and is receiving a message:");
	SendMessageToAllDMs("*A deep, resonant voice speaks into your ear in common.*  Amusing. As promised, these crystals create playthings, depite their drawbacks.");
	SendMessageToAllDMs("I have two tasks for you, both dangerous, and best not left to chance. For the first, I send you a young dedicated and other mine orcs. Loose them on the dwarves. The time is right to take another load of ore. The many-toed pretender to your seelie court grows fractious.");
	SendMessageToAllDMs("For the second, take your dead master's shard that sings the song of cold to the Aurilite. She has agreed, finally. Be more careful than he was, or I'll return you to your kin in a cage of cold iron and have them save me the time of waiting on another arcanist to wither and die.");		 
			
	SendMessageToPC(oPC, "*A deep, resonant voice speaks into your ear in common.");
	//DelayCommand(6.0, SendMessageToPC(oPC, "I have two tasks for you, both dangerous, and best not left to chance. For the first, I send you a young dedicated and other mine orcs. Loose them on the dwarves. The time is right to take another load of ore. The many-toed pretender to your seelie court grows fractious."));
	DelayCommand(6.0, SendMessageToPC(oPC, "I have a single task for you, as two have proved too much for others like you. "));
	DelayCommand(12.0, SendMessageToPC(oPC, "Fetch your dead master's shard that sings the song of cold to the Aurilite. She awaits, impatiently. Be more careful than your predecessor was, or I'll allow your kin to keep you, and save me the time."));		 
					 
}			  