//Conversation driven Mirror of Reflection 
//Wynna November 2020


#include "acr_creature_i"
#include "acr_quest_i"

void main()
{
	object oPC = GetPCSpeaker();
	string sCopyWP = GetLocalString(OBJECT_SELF, "MIRROR_REF_TARGET");
	object oCopyWP = GetNearestObjectByTag(sCopyWP, oPC, 1);
	location lCopyWP = GetLocation(oCopyWP);
	
	if((GetIsPC(oPC)) || (GetIsDMPossessed(oPC))) {
		SendMessageToPC(oPC, "Your reflection steps out of the mirror!");
		object oEvilMe = CopyObject(oPC, lCopyWP, OBJECT_INVALID);
		int nGold = GetGold(oEvilMe);
		ChangeToStandardFaction(oEvilMe, STANDARD_FACTION_HOSTILE);
		TakeGoldFromCreature(nGold, oEvilMe, TRUE, FALSE);
		SendMessageToAllDMs(GetName(oPC) + " has been copied by a Mirror of Reflection in " + GetName(GetArea(oPC)));
		object oInventory = GetFirstItemInInventory(oEvilMe);
		while (oInventory != OBJECT_INVALID) {
			SetDroppableFlag(oInventory, FALSE);
			oInventory = GetNextItemInInventory(oEvilMe);
			}
		int nEquipped = 0;
		while (nEquipped <18) {
			object oEquipped = GetItemInSlot(nEquipped, oEvilMe);
		    SetDroppableFlag(oEquipped, FALSE);
			nEquipped++;
			 }	
		}
}			 			 