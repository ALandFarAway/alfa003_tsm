//Silvy Uni Item onAcquire.  
//Wynna February 2008


#include "acr_items_i"
#include "acr_spawn_i"
#include "acr_tools_i"
#include "acr_db_persist_i"
#include "acr_quest_i"


void main()
{	object oAcquirer = GetModuleItemAcquiredBy();
	object oItem = GetModuleItemAcquired();
	object oBook = GetObjectByTag("skng_gl_tablet_plc", 0); 
	
	
	if(oBook != OBJECT_INVALID) {
		DestroyObject(oBook,1.0);
		}
		 
		 	
		 
		 
					

}			  