#include "acr_quest_i"
#include "acr_creature_i"


void main()
{   ACR_CreatureOnConversation();
 

    object oPC = GetLastSpeaker();
	
	ActionForceFollowObject(oPC, 1.0);

   
	   	 
}