#include "silvy_univ_inc"
#include "silvy_univ_func"
#include "003_silverymoon_i"
#include "acr_quest_i"
#include "acr_placeable_i"

  //Created by Wynna; 5/3/21

void ActionCreateWynCreature(string sCreature, location lLocCreature)
{
    CreateObject(OBJECT_TYPE_CREATURE, sCreature, lLocCreature);
}

void main()
{
    object oItem = GetItemActivated();
    object oUser = GetItemActivator();
	object oPanel = GetItemActivatedTarget();
	string sGoTo = GetLocalString(oPanel, "Destination");
    object oGoTo = GetWaypointByTag(sGoTo);
	location lGoTo = GetLocation(oGoTo);
	  
	
	if(GetTag(oPanel) == "phalorm_rauvin_panel") {
 		SpeakString("You press the signet into the symbol of the sphinx.", TALKVOLUME_TALK);
		ActionCreateWynCreature("003_cr_deanphoenix_air", GetLocation(oUser));
		}
	
	else {SpeakString("Nothing happens", TALKVOLUME_TALK);
	}

 
}