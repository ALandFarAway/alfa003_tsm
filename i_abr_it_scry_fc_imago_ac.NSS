//
//  System Name : Scrying
//     Filename : i_abr_scry_fc_imago_ac
//      Version : 0.1
//         Date : 7/8/22
//       Author : Wynna
//
//  Description
//  This script handles the on activate actions for a scrying imago used in the scrying system. 
//	The imago will be created in a caster's inventory upon a successful Concentration check when 
//   using a previous image on a creature.
//  Hold the imago in inventory when casting a scry spell to apply bonuses to the chances of a successful scry.
//  This item enhances Knowledge of a target to "familiar" and Connection to "minor".
//	Use the imago on a scrying object to imbue a scrying nickname into the object. Use that nickname 
//   to call up a potential scrying target's identity in future.
//   
//	It is not updated in ACR updates.
//
//  Revision History
////////////////////////////////////////////////////////////////////////////////

//	Wynna - 7/8/2022

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////

#include "acr_scry_i"
#include "x0_i0_stringlib"

void main()
{
             
    object oScryer = GetItemActivator();
	string sScryerName = GetName(oScryer);
	object oTarget = GetItemActivatedTarget();
	object oArea = GetArea(oScryer);
	string sTriggerTag;
		if(oTarget == OBJECT_INVALID) {
		location lTarget = GetLocation(oScryer);
		object oScry = GetFirstObjectInShape(SHAPE_SPHERE, 5.0, lTarget, FALSE, OBJECT_TYPE_TRIGGER);
		while(oScry != OBJECT_INVALID) {
			sTriggerTag = GetTag(oScry);
			//SendMessageToPC(oScryer, "Imago. oScry Name = " + GetName(oScry));
			//SendMessageToPC(oScryer, "Imago. sTriggerTag = " + sTriggerTag);
			if(FindSubString(sTriggerTag, "_SCRY_") != -1) {
				SetLocalObject(oArea, "oScry", oScry);
				}
			oScry = GetNextObjectInShape(SHAPE_SPHERE, 5.0, lTarget, FALSE, OBJECT_TYPE_TRIGGER);
			}
		
		oTarget = GetLocalObject(oArea, "oScry");
	}
	string sTargetName = GetName(oTarget);
	
	string sPrep = ReplaceAllSubStrings(sTargetName, "'", "" );
	SendMessageToPC(oScryer, "sPrep " + sPrep);
	ACR_SetPersistentString(GetItemActivated(), "sPPrep", ReplaceAllSubStrings(sPrep, "'", "" ));
	string sPPrep = ACR_GetPersistentString(GetItemActivated(), "sPPrep"); 
	SendMessageToPC(oScryer, "sPrep " + sPrep);
				
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
	
	if((FindSubString(GetTag(oTarget), "_SCRY") != -1) && ((GetObjectType(oTarget) == OBJECT_TYPE_PLACEABLE) || (GetObjectType(oTarget) == OBJECT_TYPE_TRIGGER))) {
		
			if(nScryer == 1) {
				AssignCommand(oTarget, ActionSpeakString("*A lifelike, animated image of " + sPTargetName + " appears in the " + sTargetName, TALKVOLUME_TALK));
				SendMessageToPC(oScryer, "You feel the match of your arcane signature resonate back from this Scrying " + sFocusType + ", as its creator.  Future scrying of this subject will benefit from the familiarity imbued herewith.");	
			}
			if(nScryer == 0) {
				AssignCommand(oTarget, ActionSpeakString("*A nearly translucent, roughly sketched image of " + sPTargetName + " appears in the " + sTargetName, TALKVOLUME_TALK));
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
					SetLocalObject(oScryNamer, "oFocus", oFocus);
					SetLocalObject(oScryNamer, "oTarget", oTarget);
					SetLocalString(oScryNamer, "sPTargetRes", sPTargetRes);
					SetLocalString(oScryNamer, "sPTargetName", sPTargetName);
					}
					
				DelayCommand(2.0, SendMessageToPC(oScryer, "You must speak a name for this potential scrying subject."));	
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