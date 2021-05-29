// ga_destroy_item
/*
    This takes an item from a player
        sItemTag    = This is the string name of the item's tag
        nQuantity   = The number of items to destroy. -1 is all of the Player's items of that tag.
        nPCFaction  = Take from the whole PC faction
*/
// FAB 9/30
// DBR 8/10/6

#include "nw_i0_plot"
#include "acr_xp_i"

#define CR_XP_SCALE 1.0f

int Ggold = 0;

void DestroyItems(object oTarget,string sItem,int nNumItems,int gold,int xp)
{
    int nCount = 0;
    int Gxp = 0;
    float cr = 0.0f;
    object oItem = GetFirstItemInInventory(oTarget);

    cr = xp/CR_XP_SCALE;

    while (GetIsObjectValid(oItem) == TRUE && nCount < nNumItems)
    {
        if (GetTag(oItem) == sItem)
        {
			int nStack = GetItemStackSize(oItem);	
			DestroyObject(oItem,0.0f);
			Gxp += xp * nStack;
			Ggold += gold * nStack;
        	nCount++;
        }
        oItem = GetNextItemInInventory(oTarget);
    }

    ACR_AwardStaticQuestXP(oTarget,"Collected: RatTails "+sItem, Gxp, cr); 
}


void main(string sItemTag)
{
    int nTotalItem;
    object oPC = GetPCSpeaker();
    object oItem;       // Items in inventory


	nTotalItem = GetNumStackedItems(GetItemPossessedBy( oPC,"003_it_harvest_rat_tail" ));
    DestroyItems( oPC,"003_it_harvest_rat_tail",nTotalItem,2,2 );

	nTotalItem = GetNumStackedItems(GetItemPossessedBy( oPC,"003_it_harvest_rat_tail_dsd" ));
    DestroyItems( oPC,"003_it_harvest_rat_tail_dsd",nTotalItem,5,5 );
	
	
	GiveGoldToCreature(oPC,Ggold);
}