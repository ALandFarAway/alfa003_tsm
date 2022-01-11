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
	   int nCastSummon     = Random(20);
	   
	   SendMessageToPC(oPossessor, "Hit"); //Debug
	   SendMessageToPC(oPossessor, IntToString(nCastSummon));//Debug
	   
	   //if (GetIsObjectValid(oItem))
	   if(nCastSummon<=10){	
	    SendMessageToPC(oPossessor, "Inside If Statement."); //Debug
	    AssignCommand(oPossessor, ClearAllActions(TRUE));
		DelayCommand(3.0, ActionCastSpellAtLocation(SPELL_SUMMON_CREATURE_I, GetLocation(oPossessor), METAMAGIC_NONE, TRUE, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
	  	SendMessageToPC(oPossessor, "After spells cast."); //Debug
	    }		
}			  		  