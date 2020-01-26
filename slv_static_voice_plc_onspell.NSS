//OnUse for all Dean's Exam (deandragon) placeables 
//Wynna February 2009


#include "acr_placeable_i"
#include "acr_xp_i"
#include "acr_quest_i"






void main()
{
	ACR_PlaceableOnSpellCastAt();
    
	 
	//deandragon_d dragon berry harvesting
	if(FindSubString(GetTag(OBJECT_SELF), "dragonberry") != -1)
		{int iSpell = GetLastSpell();
		 object oQuester = GetLocalObject(OBJECT_SELF, "oQuester");
		 if(oQuester == OBJECT_INVALID)
			{oQuester = GetLastSpellCaster();}
		 if((iSpell == SPELL_RAY_OF_FROST) || (iSpell == SPELL_CONE_OF_COLD)|| (iSpell == SPELL_LESSER_ORB_OF_COLD)|| (iSpell == SPELL_ICE_DAGGER) )
			{SetLocalInt(OBJECT_SELF, "Frozen", 1);
			 SendMessageToPC(oQuester, "The fruit gleams, immediately crystalized in a casing of ice.");
			 }
		 else{SendMessageToPC(oQuester, "The fruit withers away, too delicate for the touch of all but the gentlest cold-based magic.");
			  DestroyInventory(OBJECT_SELF);
			  DestroyObject(OBJECT_SELF);
		 	 }	 
	    }
		
}