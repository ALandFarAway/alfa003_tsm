
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
	SendMessageToAllDMs("Bring me what the dead shaped with these delightfully dangerous crystals. We will find the methods the fallen used to tame them. The lord of mazes will reward you if you bring the means to reverse the damage done to a foolish wizard.");
			
	SendMessageToPC(oPC, "*A deep, resonant voice speaks into your ear in common.*  Amusing. As promised, these crystals create playthings, depite their drawbacks.");
	SendMessageToPC(oPC, "Bring me what the dead shaped with these delightfully dangerous crystals. We will find the methods the fallen used to tame them. The lord of mazes will reward you if you bring the means to reverse the damage done to a foolish wizard.");
		  		 
					 
}			  