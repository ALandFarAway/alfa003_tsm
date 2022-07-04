#include "acr_scry_i"
#include "acr_db_persist_i"

void main()
{
    object oScryer = GetItemActivator();
	string sScryerName = GetName(oScryer);
	object oTarget = GetItemActivatedTarget();
	object oFocus = GetItemActivated();
	string sPTargetRes = ACR_GetPersistentString(oFocus, "sPTargetRes");
	string sPTargetName = ACR_GetPersistentString(oFocus, "sPTargetName");
	string sPScryerName = ACR_GetPersistentString(oFocus, "sPScryerName");
	int nDCRoll = 10+ d10(1);
	//SendMessageToPC(oScryer, "nDCRoll = " + IntToString(nDCRoll));
	float fDCAbility = (GetAbilityModifier(ABILITY_CHARISMA, oTarget) + GetAbilityModifier(ABILITY_CONSTITUTION, oTarget) + GetAbilityModifier(ABILITY_DEXTERITY, oTarget) + GetAbilityModifier(ABILITY_INTELLIGENCE, oTarget) + GetAbilityModifier(ABILITY_STRENGTH, oTarget) + GetAbilityModifier(ABILITY_WISDOM, oTarget))/6.0 ;
	//SendMessageToPC(oScryer, "fDCAbility = " + FloatToString(fDCAbility));
	fDCAbility = pow(fDCAbility, 2.0);
	//SendMessageToPC(oScryer, "fDCAbility = " + FloatToString(fDCAbility));
	int nDCAbility = 0; 
	if(fDCAbility < 1.5)
		{nDCAbility = 1;}
	else if(fDCAbility < 2.5)
		{nDCAbility = 2;}
	else if(fDCAbility < 3.5)
		{nDCAbility = 3;}
	else if(fDCAbility < 4.5)
		{nDCAbility = 4;}
	else if(fDCAbility < 5.5)
		{nDCAbility = 5;}
	//SendMessageToPC(oScryer, "nDCAbility = " + IntToString(nDCAbility));
	int nDC = nDCRoll + nDCAbility;
	//SendMessageToPC(oScryer, "nDC = " + IntToString(nDC));
		
	if(GetObjectType(oTarget) == OBJECT_TYPE_PLACEABLE) {
		SendMessageToPC(oScryer, "This shard has not been imbued.");
		return;
		}
		
	if((GetObjectType(oTarget) == OBJECT_TYPE_CREATURE) && (ACR_GetPersistentString(oFocus, "sTargetRes") == "")) {
		if((GetLocalInt(oTarget, "Focus_" + sScryerName) == 0) || (GetIsDMPossessed(oScryer))) {
			DelayCommand(900.0, SetLocalInt(oTarget, "Focus_" + GetName(oScryer), 0));
			if(GetIsSkillSuccessful(oScryer, SKILL_CONCENTRATION, nDC, TRUE)) {
				SetLocalInt(oTarget, "Focus_" + sScryerName, 1);
				SendMessageToPC(oScryer, "You memorize the defining characteristics of " + GetName(oTarget) + " and focus your perception of them into the scrying shard. The image of " + GetName(oTarget) + " shimmers into the shard and remains fixed there faintly, unmoving.");
				object oImage = CreateItemOnObject("abr_it_scry_sh_image", oScryer, 1);
				SetFirstName(oImage, "Scrying Image: " + GetName(oTarget));
				SetDescription(oImage, "A scrying shard showing a still reflection of " + GetName(oTarget) + ". This shard was created by " + GetName(oScryer) + " and establishes firsthand knowledge of " + GetName(oTarget) + " for " + GetName(oScryer) + " or secondhand knowledge for anybody else who holds it.");
				ACR_SetPersistentString(oImage, "sPTargetName", GetName(oTarget));
				ACR_SetPersistentString(oImage, "sPScryerName", GetName(oScryer));
				if(GetIsPC(oTarget) == FALSE) {
					ACR_SetPersistentString(oImage, "sPTargetRes", GetResRef(oTarget));
					}
				else if(GetIsPC(oTarget) == TRUE) {
					ACR_SetPersistentString(oImage, "sPTargetRes", GetName(oTarget));
					}
				DestroyObject(oFocus);
				}
			else {
				 SetLocalInt(oTarget, "Focus_" + sScryerName, 2);
				 SendMessageToPC(oScryer, "You are unable to concentrate enough to memorize the constantly changing expressions, postures, gait, and other defining details of " + GetName(oTarget) + " and focus them into the shard. You will have to try again another time.");
				}
			}
		else if(GetLocalInt(oTarget, "Focus_" + sScryerName) == 2) {
			SendMessageToPC(oScryer, "You have already tried and failed to memorize the constantly changing expressions, postures, gait, and other defining details of " + GetName(oTarget) + " and focus them into the shard. You will have to try again at a later time.");
		}
	}
}