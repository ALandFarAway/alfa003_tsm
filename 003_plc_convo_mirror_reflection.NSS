//Conversation driven Mirror of Reflection 
//Wynna November 2020


#include "acr_creature_i"
#include "acr_quest_i"

void main()
{
	object oPC = GetPCSpeaker();
	string sCopyWP = GetLocalString(OBJECT_SELF, "MIRROR_REF_TARGET");
	object oCopyWP = GetWaypointByTag(sCopyWP);
	location lCopyWP = GetLocation(oCopyWP);
	
	if((GetIsPC(oPC)) || (GetIsDMPossessed(oPC))) {
		object oEvilMe = CopyObject(oPC, lCopyWP, OBJECT_INVALID);
		ChangeToStandardFaction(oEvilMe, STANDARD_FACTION_HOSTILE);
		SendMessageToAllDMs(GetName(oPC) + " has been copied by a Mirror of Reflection.");
		SendMessageToPC(oPC, "Your reflection steps out of the mirror!");
		}
	else {SendMessageToAllDMs(GetName(oPC) + " is a DM avatar and can't be copied.");
		}
	
	
    
}			 			 