#include "acr_scry_i"

void main()
{
    object oScryer = GetItemActivator();
	string sScryer = GetName(oScryer);
	object oTarget = GetItemActivatedTarget();
	string sTarget = GetName(oTarget);
	object oKit = GetItemActivated();
	object oToken;
	
	if(oScryer == oTarget) {
		oToken = CreateItemOnObject("abr_it_scry_body", oScryer, 1);
		SetFirstName(oToken, GetName(oScryer) + "'s Body Part");
		}
		
	else if((oScryer != oTarget) && (GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)) {
		oToken = CreateItemOnObject("abr_it_scry_body", oScryer, 1);
		SetFirstName(oToken, GetName(oTarget) + "'s Body Part");
		}
	
	if(GetObjectType(oTarget) == OBJECT_TYPE_ITEM) {
		oToken = CreateItemOnObject("abr_it_scry_possess", oScryer, 1);
		SetFirstName(oToken, GetName(oScryer) + "'s Possession");
		}
		
	ACR_SetPersistentString(oToken, "sPScryerName", sScryer);
	ACR_SetPersistentString(oToken, "sPTargetName", sTarget);
									
}