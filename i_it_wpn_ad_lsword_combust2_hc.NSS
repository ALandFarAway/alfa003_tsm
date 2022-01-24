//TSM individual item onHit cast.
// Saaz  2022

/* i_03_it_wpn_ad_lsword_hc

    On hit to mimic combut at caster level two in one out of three hits.
*/

#include "x2_I0_SPELLS"
#include "x2_inc_toollib"
#include "acr_spawn_i"
#include "x2_inc_spellhook"


void main() {
  //SendMessageToPC(OBJECT_SELF,GetTag(OBJECT_SELF) + " onhit cast fired.");
        
    if (!Random(3)) {// random 3 returned 0, 1 in 3 chance
        object oTarget = GetSpellTargetObject();
        int nDamage = d8(2);

        effect eDam      = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
        effect eVis      = EffectVisualEffect(VFX_HIT_SPELL_FIRE);
        effect eHit = EffectLinkEffects(eDam, eVis);

        AddItemProperty(DURATION_TYPE_TEMPORARY,ItemPropertyVisualEffect(ITEM_VISUAL_FIRE),OBJECT_SELF,6.0);
        int nSRResult = MyResistSpell(OBJECT_SELF, oTarget);
        //SendMessageToPC(OBJECT_SELF,"SR result is "+IntToString(nSRResult));
        if(nSRResult<1) {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eHit, oTarget);
            TLVFXPillar(VFX_HIT_SPELL_EVOCATION, GetLocation(oTarget), 5, 0.1f,0.0f, 2.0f);
        }
    }
}