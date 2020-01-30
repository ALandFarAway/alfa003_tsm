#include "silvy_univ_inc"
#include "silvy_univ_func"
#include "003_silverymoon_i"
#include "acr_quest_i"
#include "acr_placeable_i"

  //Created by Wynna; Jan 27, 2020


void main()
{
   object oItem;        // The item casting triggering this spellscript
   object oSpellTarget; // On a weapon: The one being hit. On an armor: The one hitting the armor
   object oSpellOrigin; // On a weapon: The one wielding the weapon. On an armor: The one wearing an armor

   // fill the variables
   oSpellOrigin = OBJECT_SELF;
   oSpellTarget = GetSpellTargetObject();
   oItem        =  GetSpellCastItem();

  
		 SendMessageToPC(oSpellTarget, "You feel a tingling burst of energy!");
		 AssignCommand(oSpellOrigin,SpeakString("*Lashes out with its tail*", TALKVOLUME_TALK)); 
		 AssignCommand(oSpellOrigin, ActionCastSpellAtObject(SPELL_CURE_LIGHT_WOUNDS, oSpellTarget, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
		  
  
	
	 
}