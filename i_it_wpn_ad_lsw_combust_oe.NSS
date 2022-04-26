//TSM individual item onEquip.
// Saaz  2022

/* i_03_it_wpn_ad_lsword_oe
    Add on hit cast item property when equipped as workaround for removal of said property when subdual mode is deactivated.
*/

void main() {
    object oItem = GetPCItemLastEquipped();
    itemproperty ip = GetFirstItemProperty(oItem);

    // check all existing properties to ensure item doesn't already have on hit cast spell unique
    while(GetIsItemPropertyValid(ip))
    {
        if (GetItemPropertyType(ip)==ITEM_PROPERTY_ONHITCASTSPELL && GetItemPropertySubType(ip)==IP_CONST_ONHIT_CASTSPELL_ONHIT_UNIQUEPOWER)
            return; // halt if on hit cast spell unique found
        ip = GetNextItemProperty(oItem);
    }

    // on hit cast spell unique wasn't found, so add it
    ip = ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_ONHIT_UNIQUEPOWER,2);
    AddItemProperty(DURATION_TYPE_PERMANENT,ip,oItem);
}