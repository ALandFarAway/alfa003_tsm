#include "acr_area_i"
#include "003_silverymoon_i"
#include "acr_db_persist_i"

void main() {
	// Get our entering object.
	object oPC = GetEnteringObject();

	// Hook our ACR area enter script.
	ACR_AreaOnEnter();

	// Remove Silverymoon's wards.
	RemoveSilverymoonWards( oPC );
	
	string sTag = GetTag(OBJECT_SELF);
	if(ACR_GetPersistentInt(GetEnteringObject(), GetTag(OBJECT_SELF) + " XP") == 0) {
		ACR_SetPersistentInt(GetEnteringObject(), GetTag(OBJECT_SELF) + " XP", 10);
		GiveXPToCreature(GetEnteringObject(), 10);
		SendMessageToPC(GetEnteringObject(), "Congratulations on exploring a new area!");
		}
	
}