#include "acr_scry_i"

void main()
{
    object oScryer = GetItemActivator();
	object oTarget = GetItemActivatedTarget();
	object oKit = GetItemActivated();
	
	if(oScryer == oTarget) {
		object oToken = CreateItemOnObject("abr_it_scry_body", oScryer, 1, "abr_it_scry_b_" + GetStringRight(GetName(oScryer), 15));
		SetFirstName(oToken, GetName(oScryer) + "'s Body Part");
		}
	
	if(GetObjectType(oTarget) == OBJECT_TYPE_ITEM) {
		object oToken = CreateItemOnObject("abr_it_scry_possess", oScryer, 1, "abr_it_scry_p_" + GetStringRight(GetName(oScryer), 15));
		SetFirstName(oToken, GetName(oScryer) + "'s Possession");
		
		}
}