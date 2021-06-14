#include "acr_area_i"
#include "003_silverymoon_i"
#include "acr_db_persist_i"


void main() {
	// Get our entering object.
	object oPC = GetEnteringObject();

	// Hook our ACR area enter script.
	ACR_AreaOnEnter();

	// Apply Silverymoon's wards.
	ApplySilverymoonWards( oPC );
	
	string sTag = GetTag(OBJECT_SELF);
	if(FindSubString(sTag, "ext", 0) != -1) {
	int nXP = 25;
	if(((FindSubString(sTag, "6b_", 0) != -1) && (FindSubString(sTag, "evermoor_", 0) == -1)) || (FindSubString(sTag, "6c_", 0) != -1) || (FindSubString(sTag, "6d_", 0) != -1)) {
		nXP = 10;
		}
	if(ACR_GetPersistentInt(GetEnteringObject(), GetTag(OBJECT_SELF) + " XP") == 0) {
		ACR_SetPersistentInt(GetEnteringObject(), GetTag(OBJECT_SELF) + " XP", nXP);
		GiveXPToCreature(GetEnteringObject(), nXP);
		SendMessageToPC(GetEnteringObject(), "Congratulations on exploring a new area!");
		}
	}
}