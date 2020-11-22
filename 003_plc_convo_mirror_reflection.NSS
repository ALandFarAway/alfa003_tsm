//Conversation driven Mirror of Reflection 
//Wynna November 2020


#include "acr_creature_i"
#include "acr_quest_i"

void main()
{
	object oPC = GetPCSpeaker();
	string sCopyWP = GetLocalString(OBJECT_SELF, "COPY_WP");
	object oCopyWP = GetWaypointByTag(sCopyWP);
	location lCopyWP = GetLocation(oCopyWP);
	
	object oEvilMe = CopyObject(oPC, lCopyWP, OBJECT_INVALID);
	ChangeToStandardFaction(oEvilMe, STANDARD_FACTION_HOSTILE);
	
	
	
    
}			 			 