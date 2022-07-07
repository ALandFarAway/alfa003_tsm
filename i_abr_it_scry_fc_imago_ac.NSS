#include "acr_scry_i"

void main()
{
             
    object oScryer = GetItemActivator();
	string sScryerName = GetName(oScryer);
	object oTarget = GetItemActivatedTarget();
	string sTargetName = GetName(oTarget);
	object oFocus = GetItemActivated();
	string sFocusName = GetFirstName(oFocus);
	string sFocusType = "Shard";
	if(FindSubString(sFocusName, "Droplet", 0) != -1) {
		sFocusType = "Droplet";
	}
	string sPTargetRes = ACR_GetPersistentString(oFocus, "sPTargetRes");
	string sPTargetName = ACR_GetPersistentString(oFocus, "sPTargetName");
	string sPScryerName = ACR_GetPersistentString(oFocus, "sPScryerName");
	string sTargetNick = GetLocalString(oTarget, sPTargetRes);
	
	int nDCRoll = 10+ d10(1);
	float fDCAbility = (GetAbilityModifier(ABILITY_CHARISMA, oTarget) + GetAbilityModifier(ABILITY_CONSTITUTION, oTarget) + GetAbilityModifier(ABILITY_DEXTERITY, oTarget) + GetAbilityModifier(ABILITY_INTELLIGENCE, oTarget) + GetAbilityModifier(ABILITY_STRENGTH, oTarget) + GetAbilityModifier(ABILITY_WISDOM, oTarget))/6.0 ;
	fDCAbility = pow(fDCAbility, 2.0);
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
	int nDC = nDCRoll + nDCAbility;
		
	int nScryer = 0;
	if(sScryerName == sPScryerName) {
		nScryer = 1;
		}
	
	if((FindSubString(GetTag(oTarget), "_SCRY") != -1) && (GetObjectType(oTarget) == OBJECT_TYPE_PLACEABLE) && (sPTargetRes != "")) {
		
			if(nScryer == 1) {
				SendMessageToPC(oScryer, "A lifelike, animated image of " + sPTargetName + " appears in the " + sTargetName);
				SendMessageToPC(oScryer, "You feel the match of your arcane signature resonate back from this Scrying " + sFocusType + ", as its creator.  Future scrying of this subject will benefit from the familiarity imbued herewith.");	
			}
			if(nScryer == 0) {
				SendMessageToPC(oScryer, "A nearly translucent, roughly sketched image of " + sPTargetName + " appears in the " + sTargetName);
				SendMessageToPC(oScryer, "The arcane signature of this Scrying " + sFocusType + " and its holder are not a match. Future scrying of this subject will be at secondhand knowledge only.");	
			}
			
			if(sTargetNick != "") {
				SendMessageToPC(oScryer, sPTargetName + "'s identity is already imbued into this " + sTargetName + " under the nickname " + sTargetNick);	
			}
			
			else if(sTargetNick == "") {
				//Create undetectable OOC Scrying Namer at location of Scrying Object to receive nickname for stored scrying target
			    object oScryNamer = GetLocalObject(oTarget, "oScryNamer");
				if(oScryNamer == OBJECT_INVALID) {
					oScryNamer = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_scry_namer", GetLocation(oTarget));
		            SetLocalObject(oScryNamer, "oScryer", oScryer);
					SetLocalObject(oScryNamer, "oTarget", oTarget);
					SetLocalString(oScryNamer, "sPTargetRes", sPTargetRes);
					}
					
				DelayCommand(4.0, AssignCommand(oTarget, ActionSpeakString("Please speak a name for this potential scrying subject.", TALKVOLUME_TALK)));	
			} 
		}
		
	if((GetObjectType(oTarget) == OBJECT_TYPE_CREATURE) && (sTargetName != sPTargetName)) {
		 SendMessageToPC(oScryer, "This imago is of somebody other than the person you just attempted to commit to it. That won't work. Besides, you cannot improve further on your knowledge of " + sPTargetName + ".");
		 return;
		 }
	 
	else if(GetObjectType(oTarget) == OBJECT_TYPE_CREATURE) {
		SendMessageToPC(oScryer, "You cannot improve further on your knowledge of " + sPTargetName + ". This is as good as it gets.");
		}
}