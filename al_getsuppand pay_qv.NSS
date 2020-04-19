// Argent Legion Supply Quest to Quaervarr, pay and exp
#include "acr_db_persist_i"
#include "acr_xp_i"
void main()
{   
    object oSupply; 
	object oPC = GetPCSpeaker();
    if(GetItemPossessedBy(oPC, "militarysuppliesqv") != OBJECT_INVALID)
    {
       int nRepeat = ACR_GetPersistentInt(GetPCSpeaker(), "qv_supply");
	   if(nRepeat == 0)
	   		{nRepeat = 1;}
		else
			{nRepeat = nRepeat + 1;}
	   
	   ACR_SetPersistentInt(GetPCSpeaker(), "qv_supply", nRepeat);
	   oSupply = GetItemPossessedBy(oPC, "militarysuppliesqv");
	   GiveGoldToCreature(oPC, 75);
	   ACR_AwardStaticQuestXP(oPC, "003_argntlgn_qvsupply", 75/nRepeat);
	   DestroyObject( oSupply);
	   ACR_SetPersistentInt(GetPCSpeaker(), "alsupply", 0);
    }	
}	
 