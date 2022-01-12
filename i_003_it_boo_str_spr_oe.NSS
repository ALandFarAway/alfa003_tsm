//Wynna Jan 2022

 
#include "acr_items_i"
#include "x2_inc_itemprop"

void main()
{	
	object oItem = GetPCItemLastEquipped();
 	object oPC = GetPCItemLastEquippedBy();
	effect eSpeedChange = EffectMovementSpeedIncrease(33);
	
	SendMessageToPC(oPC, "Equipped");
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSpeedChange, oPC);
	SendMessageToPC(oPC, "Increased");
	
	}


