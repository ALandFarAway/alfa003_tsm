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
	   
	   
	   //if (GetIsObjectValid(oItem))
	    object oMark = CreateObject(OBJECT_TYPE_PLACEABLE, "abr_plc_arc_mark_wall", GetLocation(oTarget), TRUE);
		object oMarkB = CreateObject(OBJECT_TYPE_PLACEABLE, "abr_plc_arc_mark_flr", GetLocation(oTarget), TRUE);
		SendMessageToAllDMs("Arrow of Mark creating marks at location of " + GetName(oTarget));
}			  		  