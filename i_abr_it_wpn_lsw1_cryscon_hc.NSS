//Silvy Uni Item onAcquire.  
//Wynna February 2008


#include "acr_items_i"
#include "acr_spawn_i"
#include "acr_tools_i"
#include "acr_db_persist_i"
#include "acr_quest_i"


void main()
	{  object oItem;        // The item casting triggering this spellscript
	   object oSpellTarget; // On a weapon: The one being hit. On an armor: The one hitting the armor
	   object oWielder; // On a weapon: The one wielding the weapon. On an armor: The one wearing an armor

	  if(Random(20)==1)	{
	  ActionCastSpellAtLocation(SPELL_SUMMON_CREATURE_I, GetLocation(oWielder), METAMAGIC_NONE, TRUE, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
	  }		

}			  