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
		//SendMessageToAllDMs("sCopy WP = " + sCopyWP);
		SendMessageToPC(oPC, "Your reflection steps out of the mirror!");
		//SendMessageToPC(oPC, "sCopy WP = " + sCopyWP);
		object oEvilMe = CopyObject(oPC, lCopyWP, OBJECT_INVALID);
		int nGold = GetGold(oEvilMe);
		ChangeToStandardFaction(oEvilMe, STANDARD_FACTION_HOSTILE);
		TakeGoldFromCreature(nGold, oEvilMe, TRUE, FALSE);
		SendMessageToPC(oPC, "nGold = " +IntToString(nGold));
		SendMessageToAllDMs(GetName(oPC) + " has been copied by a Mirror of Reflection.  " + IntToString(nGold) + " gold was removed.");
		object oInventory = GetFirstItemInInventory(oEvilMe);
		while (oInventory != OBJECT_INVALID) {
			SetDroppableFlag(oInventory, FALSE);
			SendMessageToPC(oPC, "oInventory = " +GetName(oInventory));
		    oInventory = GetNextItemInInventory(oEvilMe);
			}
		int nEquipped = 0;
		while (nEquipped <18) {
			object oEquipped = GetItemInSlot(nEquipped, oEvilMe);
		    SendMessageToPC(oPC, "oEquipped = " +GetName(oEquipped));
		    SetDroppableFlag(oEquipped, FALSE);
			nEquipped++;
			 }
		
		}
	else {SendMessageToAllDMs(GetName(oPC) + " is a DM avatar and can't be copied.");
		}
	
	
    
}			 			 