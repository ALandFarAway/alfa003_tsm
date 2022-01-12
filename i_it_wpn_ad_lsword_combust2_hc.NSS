//TSM individual item onHit cast.  
// Wynna /  Arri 2022

#include "x2_inc_toollib"
#include "acr_spells_i"

void main() {
    if (!Random(3)) {// random 3 returned 0, 1 in 3 chance
        object oTarget = GetSpellTargetObject();
        GetSpellTargetObject();
        int nDamage = d8(2);

        effect eDam      = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
        effect eVis      = EffectVisualEffect(VFX_HIT_SPELL_FIRE);
        effect eHit = EffectLinkEffects(eDam, eVis);

        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));

       //-----------------------------------------------------------------------
       // Check SR
       //-----------------------------------------------------------------------
        if(!MyResistSpell(OBJECT_SELF, oTarget))
        {
           //-------------------------------------------------------------------
           // Apply VFX
           //-------------------------------------------------------------------
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eHit, oTarget);
            //ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis2, oTarget, RoundsToSeconds(nDuration));
            TLVFXPillar(VFX_HIT_SPELL_EVOCATION, GetLocation(oTarget), 5, 0.1f,0.0f, 2.0f);
        }
    }
}