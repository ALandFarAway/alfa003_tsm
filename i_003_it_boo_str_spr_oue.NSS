
//Wynna November 2020

 
#include "acr_items_i"
#include "x2_inc_itemprop"

void main()
{	
	object oItem = GetPCItemLastUnequipped();
 	object oPC = GetPCItemLastUnequippedBy();
	effect eSpeedChange = EffectMovementSpeedDecrease(33);
			 
		ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSpeedChange, oPC);
	    	 
}			  