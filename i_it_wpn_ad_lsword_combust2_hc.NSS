//TSM individual item onHit cast.
// Wynna /  Arri  / Saaz  2022

#include "x2_inc_toollib"
#include "acr_spells_i"

void main() {
    if (!Random(3)) {// random 3 returned 0, 1 in 3 chance
        object oTarget = GetSpellTargetObject();
        int nDamage = d8(2);

        effect eDam      = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
        effect eVis      = EffectVisualEffect(VFX_HIT_SPELL_FIRE);
        effect eHit = EffectLinkEffects(eDam, eVis);

        AddItemProperty(DURATION_TYPE_TEMPORARY,ItemPropertyVisualEffect(ITEM_VISUAL_FIRE),OBJECT_SELF,6.0);
        if(!MyResistSpell(OBJECT_SELF, oTarget))
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eHit, oTarget);
            TLVFXPillar(VFX_HIT_SPELL_EVOCATION, GetLocation(oTarget), 5, 0.1f,0.0f, 2.0f);
        }
    }
}