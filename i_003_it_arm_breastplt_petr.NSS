//TSM individual item onHit cast.  
//Wynna November 2021


#include "acr_items_i"
#include "acr_spawn_i"
#include "acr_tools_i"
#include "acr_db_persist_i"
#include "acr_quest_i"


void main()
	{  object oItem;        // The item casting triggering this spellscript
	   object oSpellTarget; // On a weapon: The one being hit. On an armor: The one hitting the armor
	   object oWearer; // On a weapon: The one wielding the weapon. On an armor: The one wearing an armor
	  
	   SendMessageToPC(oWearer, "Hit");
	   int nCastSize = Random(20);
	   SendMessageToPC(oWearer, IntToString(nCastSize));
	   if(nCastSize==1)	{
		  ActionCastSpellAtObject(SPELL_REDUCE_PERSON, oWearer, METAMAGIC_NONE, TRUE, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
		  }		
		else if(nCastSize==2)	{
		ActionCastSpellAtObject(SPELL_ENLARGE_PERSON, oWearer, METAMAGIC_NONE, TRUE, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
		  }
}			  