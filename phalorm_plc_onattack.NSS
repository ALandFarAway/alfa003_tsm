
//Wynna August 2020


#include "acr_placeable_i"
#include "acr_xp_i"
#include "acr_quest_i"
#include "acr_i"

void main()
{
	ACR_PlaceableOnPhysicalAttacked();

	object oAttacker = GetLastAttacker();
	object oBow = GetLastWeaponUsed(oAttacker);
	SendMessageToAllDMs("oAttacker = " + GetName(oAttacker) + "; oBow = " + GetName(oBow));
	if((FindSubString(GetName(oAttacker), "Nio") != -1) && (GetWeaponRanged(oBow)) && (GetLocalInt(OBJECT_SELF, "Marked") != 1)) {
		SetLocalInt(OBJECT_SELF, "Marked", 1);
		object oMark = CreateObject(OBJECT_TYPE_PLACEABLE, "abr_plc_arc_mark_wall", GetLocation(OBJECT_SELF), TRUE);
		object oMarkB = CreateObject(OBJECT_TYPE_PLACEABLE, "abr_plc_arc_mark_flr", GetLocation(OBJECT_SELF), TRUE);
		SendMessageToAllDMs("Arrow of Mark creating marks at location of " + GetName(OBJECT_SELF));
		}
}	