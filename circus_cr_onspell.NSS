//OnSpellCastAt for circus creatures
//Wynna May 2015


#include "acr_creature_i"
#include "acr_db_persist_i"
#include "acr_quest_i"
#include "003_silverymoon_i"
					
					
void main()
{
	ACR_CreatureOnSpellCastAt();
    object oPC = GetLastSpellCaster();
	int nSpell=GetLastSpell();
    	
	 
			string sRealResRef=GetLocalString(OBJECT_SELF, "menagerie_real_resref");
			 string sReveal = GetLocalString(OBJECT_SELF, "menagerie_real_animal");
			 object oRealSelf = CreateObject(OBJECT_TYPE_CREATURE, sRealResRef, GetLocation(OBJECT_SELF));
			 ActionSpeakString(sReveal, TALKVOLUME_TALK);
			 DestroyObject(OBJECT_SELF, 3.0);
			 
		

       	   	  
}