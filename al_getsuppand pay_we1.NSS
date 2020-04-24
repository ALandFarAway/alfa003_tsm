// Argent Legion Supply Quest to Winter's Edge, pay and exp
#include "acr_db_persist_i"
#include "acr_xp_i"
void main()
{   
    object oSupply;
	object oPC = GetPCSpeaker(); 
    if(GetItemPossessedBy(oPC, "militarysupplieswe") != OBJECT_INVALID)
    {
       int nRepeat = ACR_GetPersistentInt(GetPCSpeaker(), "we_supply");
	   if(nRepeat == 0)
	   		{nRepeat = 1;}
		else
			{nRepeat = nRepeat + 1;}
	   
	   ACR_SetPersistentInt(GetPCSpeaker(), "we_supply", nRepeat);
	   oSupply = GetItemPossessedBy(oPC, "militarysupplieswe");
	   GiveGoldToCreature(oPC, 50);
	   ACR_AwardStaticQuestXP(oPC, "003_argntlgn_wesupply", 50/nRepeat);
	   DestroyObject( oSupply);
	   ACR_SetPersistentInt(GetPCSpeaker(), "alsupply", 0);
    }	
}	
 