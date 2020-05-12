
#include "acr_spawn_i"
#include "acr_db_persist_i"

void main()
{
             
//OnActivate Script for the quest curse Auril Holy Symbol for Wynna's Dean Sphinx quest of 2020
    object oUser = GetItemActivator();
	object oTarget = GetItemActivatedTarget();
    
	if(oTarget!= OBJECT_INVALID){
	if(WillSave(oUser, 18, SAVING_THROW_TYPE_MIND_SPELLS, OBJECT_SELF) > 0)
		 {DelayCommand(5.0, SendMessageToPC(oUser, "You feel as if a cold wind had passed through you, leaving you shaken but uneffected. The holy symbol glitters malevolently."));
			 }
		 else	 	
		 	{AssignCommand(oUser, ActionCastSpellAtObject(SPELL_CREEPING_COLD, oTarget, METAMAGIC_NONE, TRUE, 8, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)); 
			 }
 
      }   
   
		  
}