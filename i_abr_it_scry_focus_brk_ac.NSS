//
//  System Name : Scrying
//     Filename : i_abr_scry_focus_brk_ac
//      Version : 0.1
//         Date : 7/8/22
//       Author : Wynna
//
//  Description
//  This script handles the on activate actions for a mirror of reflection shard
//   
//	It is not updated in ACR updates.
//
//  Revision History
////////////////////////////////////////////////////////////////////////////////

//	Wynna - 4/8/2023

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////

#include "acr_scry_i"
#include "x0_i0_stringlib"
 
void main()
{
    object oPC = GetItemActivator();
	
	if((GetIsPC(oPC)) || (GetIsDMPossessed(oPC))) {
		SendMessageToPC(oPC, "Your reflection steps out of the mirror!");
		object oEvilMe = CreateObject(OBJECT_TYPE_CREATURE, "003_pc_jhessi_dupe", GetLocation(oPC));
		int nGold = GetGold(oEvilMe);
		//ChangeToStandardFaction(oEvilMe, STANDARD_FACTION_HOSTILE);
		//SetSubRace(oEvilMe, RACIAL_SUBTYPE_INCORPOREAL);
		TakeGoldFromCreature(nGold, oEvilMe, TRUE, FALSE);
		SendMessageToAllDMs(GetName(oPC) + " has been copied by a Mirror of Reflection Shard in " + GetName(GetArea(oPC)));
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