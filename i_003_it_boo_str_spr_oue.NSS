/* i_nw_it_boots_spring_ue

    Unequip script to remove speed effect for boots of striding and springing.

    Khaevil 20 Jan 2022
*/

const int SPELLID_STRIDING_SPRINGING = 1777;

void main()
{
    // * This code runs when the item is unequipped
    object oPC      = GetPCItemLastUnequippedBy();
//    object oItem    = GetPCItemLastUnequipped();

    effect eTest = GetFirstEffect(oPC);
    while (GetIsEffectValid(eTest)) {
        if (GetEffectSpellId(eTest) == SPELLID_STRIDING_SPRINGING)
        {
//            SendMessageToPC(oPC,"Removing speed effect.");
             RemoveEffect(oPC, eTest);
            return;
        }
        eTest = GetNextEffect(oPC);
    }
//    SendMessageToPC(oPC,"Speed effect not found.");


}  