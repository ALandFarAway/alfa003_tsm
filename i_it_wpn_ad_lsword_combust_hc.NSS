//TSM individual item onHit cast.  
// Wynna /  Arri 2022

 #include "acr_spawn_i"
 #include "x2_inc_spellhook"


void main()
	{  
	   object oTarget; // On a weapon: The one being hit. On an armor: The one hitting the armor
	   object oItem        = GetSpellCastItem();    // The item casting that triggered this spellscript
   	   object oSpellOrigin = OBJECT_SELF ;
	   object oSpellTarget = GetSpellTargetObject();
	   object oPossessor   = GetItemPossessor(oItem);  //On a weapon: The one wielding the weapon. On an armor: The one wearing an armor
	   int nCombust     = Random(20);
	   effect eFireDmg = EffectDamage(d6(2), DAMAGE_TYPE_FIRE, DAMAGE_POWER_NORMAL, FALSE);
	   effect eFireHit = EffectVisualEffect(VFX_COM_HIT_FIRE, FALSE);
	   effect eFireAura = EffectVisualEffect(VFX_DUR_AURA_FIRE, FALSE);
	   effect eFireSpell = EffectVisualEffect(VFX_HIT_SPELL_FIRE, FALSE);
	   effect eFireBlade = EffectVisualEffect(ITEM_VISUAL_FIRE, FALSE);
	   SendMessageToPC(oPossessor, IntToString(nCombust));
	
	   if(nCombust>=0){	
	   
	    SendMessageToPC(oPossessor, "Fire");
		//AddItemProperty(DURATION_TYPE_TEMPORARY, ITEM_PROPERTY_VISUALEFFECT, oItem, 6.0);
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFireBlade, oItem, 10.0);
		ApplyEffectToObject(DURATION_TYPE_INSTANT, eFireDmg, oTarget);
	    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFireHit, oTarget, 1.0);
	    DelayCommand(2.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFireSpell, oTarget, 3.0));
	    DelayCommand(6.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFireAura, oTarget, 6.0));
	    //AssignCommand(oPossessor, ClearAllActions(TRUE));
		//DelayCommand(1.0, ActionCastSpellAtObject(SPELL_COMBUST, oSpellTarget, METAMAGIC_NONE, TRUE, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
	  	//DelayCommand(7.0, ActionCastSpellAtObject(SPELL_COMBUST, oTarget, METAMAGIC_NONE, TRUE, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
	  	//DelayCommand(3.0, AssignCommand(oPossessor, ActionAttack(oSpellTarget)));
		SendMessageToPC(oPossessor, "After Fire");
	    }		
}			  		  