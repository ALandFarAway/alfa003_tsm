/* i_nw_it_boots_spring_eq

    Equip script to add speed effect for boots of striding and springing.

    Khaevil 20 Jan 2022
*/

const int SPELLID_STRIDING_SPRINGING = 1777;

void main()
{   
    object oPC      = GetPCItemLastEquippedBy();
    object oItem    = GetPCItemLastEquipped();
	SendMessageToAllDMs(GetName(oPC) + " put on " + GetName(oItem));
    

    effect eFast = EffectMovementSpeedIncrease(30);

    effect eDur = EffectVisualEffect( VFX_DUR_SPELL_EXPEDITIOUS_RETREAT );    // NWN2 VFX

    effect eLink = EffectLinkEffects(eFast, eDur);

    effect eSpell = SetEffectSpellId(eLink, SPELLID_STRIDING_SPRINGING);

    effect eSuper = SupernaturalEffect(eSpell);

    SendMessageToPC(oPC,"Applying supernatural speed effect.");
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSuper, oPC);
}