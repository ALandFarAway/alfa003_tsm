#include "acr_scry_i"
#include "acr_vanity_i"
#include "nwnx_objectattributes_include"

void ActionCreateWynPlace(string sPlace, location lLocPlace)
{
    CreateObject(OBJECT_TYPE_PLACEABLE, sPlace, lLocPlace);
}

string XPObjectAttributesGetHairVariation(object Creature)

{
	string sHairVar = 	NWNXGetString(
						"OBJECTATTRIBUTES",
						"SetHairVariation",
						"",
						ObjectToInt( Creature ));
	return sHairVar;	
}


void main()
{
    object oScryer = GetItemActivator();
	string sScryer = GetName(oScryer);
	object oTarget = GetItemActivatedTarget();
	string sTarget = GetName(oTarget);
	object oKit = GetItemActivated();
	object oToken;
	string sHairVar = XPObjectAttributesGetHairVariation(oScryer);
	string sNatHair = GetNaturalHairColor(oScryer);
	string sRawHair = GetRawHairTintSet(oScryer);
	SendMessageToPC(oScryer, "Object to String = " + ObjectToString(oScryer));
	SendMessageToPC(oScryer, "Object to Int = " + IntToString(ObjectToInt(oScryer)));
	SendMessageToPC(oScryer, "sNatHair = " + sNatHair);
	SendMessageToPC(oScryer, "sRawHair = " + sRawHair);
	int nHairStyle = GetLocalInt(oScryer, "ACR_APP_TYPE");
	SendMessageToPC(oScryer, "sHairVar = " + sHairVar);
	SendMessageToPC(oScryer, "nHairStyle = " + IntToString(nHairStyle));
	//Bald Dwarf = 17, Facial Hair 0;
	//Bald Human = 17, Facial Hair 0;
	if(oScryer == oTarget) {
		oToken = CreateItemOnObject("abr_it_scry_body", oScryer, 1);
		SendMessageToPC(oScryer, "A brief shimmer envelopes your hand and the " + GetName(oToken));
		SetFirstName(oToken, GetName(oScryer) + "'s Body Part");
		}
		
	else if((oScryer != oTarget) && (GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)) {
		int nPickDC = 20;
		if(GetIsEnemy(oScryer, oTarget)) {
			nPickDC = 30;
		}
		
		int nSleightRank = GetSkillRank(SKILL_SLEIGHT_OF_HAND, oScryer, FALSE);
			
		if(nSleightRank > 0) {
			int nSleightRoll = d20(1);
			int nSleightCheck = nSleightRoll + nSleightRank;
			string sSuccess = "success";
			if (nSleightCheck < nPickDC) {
				sSuccess = "failure";
				}
				
			SendMessageToPC(oScryer,  "<color=cyan>" + GetName(oScryer) + ":</color> <color=lightblue>Sleight of Hand: *" + sSuccess + "*: " + IntToString(nSleightRoll) + " + " + IntToString(nSleightRank) + " = " + IntToString(nSleightCheck) + " vs DC" + IntToString(nPickDC) + "</color>");
			
			if(nSleightCheck >= nPickDC + 5) {
				oToken = CreateItemOnObject("abr_it_scry_body", oScryer, 1);
				SendMessageToPC(oScryer, "You snip a lock of hair from " + GetName(oTarget) + ". A brief shimmer envelopes your hand and the lock of hair.");
				SetFirstName(oToken, "Lock of " + GetName(oTarget) + "'s Hair");
				SetStolenFlag(oToken, TRUE);
				DelayCommand(1.0, SendMessageToPC(oTarget, "You catch a brief shimmer near your head out of the corner of your eye."));
				}
			else if(nSleightCheck >= nPickDC) {
				DelayCommand(1.0, SendMessageToPC(oTarget, "A brief shimmer near your gear catches your eye."));
				object oInventory = GetFirstItemInInventory(oTarget);
				int nPickable = 0;
				while (oInventory != OBJECT_INVALID) {
				if(GetPickpocketableFlag(oInventory) == TRUE) {
					nPickable++;
					}
				oInventory = GetNextItemInInventory(oTarget);
				}
				
				if(nPickable > 0) {
					int nPickRand = Random(nPickable);
					int nPickCount = 0;
					object oPickInventory = GetFirstItemInInventory(oTarget);
					string sPickInventory = GetName(oPickInventory);
					while (oPickInventory != OBJECT_INVALID) {
					if(GetPickpocketableFlag(oPickInventory) == TRUE) {
						nPickCount++;
						if(nPickCount == nPickRand) {
							break;
							}
						}
					oPickInventory = GetNextItemInInventory(oTarget);
					}
					
					sPickInventory = GetName(oPickInventory);
					SendMessageToPC(oScryer, "You snip " + sPickInventory + " from " + GetName(oTarget) + ". A brief shimmer envelopes your hand and the " + sPickInventory + ".");
					oToken = CopyObject(oPickInventory, GetLocation(oScryer), oScryer, "abr_it_scry_possess");
					SetFirstName(oToken, GetName(oTarget) + "'s " + sPickInventory);
					SetStolenFlag(oToken, TRUE);
					DestroyObject(oPickInventory);
					}
					
				else {
					SendMessageToPC(oScryer, "You snip away a fragment of clothing from " + GetName(oTarget) + ".");
					oToken = CreateItemOnObject("abr_it_scry_possess", oScryer, 1);
					SetFirstName(oToken, "Fragment of " + GetName(oTarget) + "'s Clothing.");
					SetStolenFlag(oToken, TRUE);
					}
				}
				 
			int nSpotBonus = 0;
			if(nSleightRoll == 1) 	{
				nSpotBonus = 5;
				}
			int nSpotRank = GetSkillRank(SKILL_SPOT, oTarget, FALSE);
			int nSpotCheck = d20(1) + nSpotRank + nSpotBonus;
			if(nSpotCheck >= nSleightCheck) {
				int nRace = GetRacialType(oScryer);
				string sRace = "human";
				if(nRace == RACIAL_TYPE_DWARF) {
					sRace = "dwarf";
					}
				if(nRace == RACIAL_TYPE_ELF) {
					sRace = "elf";
					}
				if(nRace == RACIAL_TYPE_GNOME) {
					sRace = "gnome";
					}
				if(nRace == RACIAL_TYPE_HALFELF) {
					sRace = "half elf";
					}
				if(nRace == RACIAL_TYPE_HALFLING) {
					sRace = "halfling";
					}
				if(nRace == RACIAL_TYPE_HALFORC) {
					sRace = "half orc";
					}
				
				int nGender = GetGender(oScryer);
				string sGender = "male";
				if(nGender == GENDER_FEMALE) {
					sGender = "female";
					}
				SendMessageToPC(oScryer, "You have been detected!");
				SendMessageToPC(oTarget, "You detect a " +sGender + " " + sRace + " trying to steal from you!");
				if(GetIsPC(oTarget) == FALSE) {
					AssignCommand(oTarget, ActionSpeakString("Thief!", TALKVOLUME_TALK));
					if(GetStealthMode(oScryer) == STEALTH_MODE_DISABLED) {
						AssignCommand(oTarget, ActionAttack(oScryer));
						}
					}
				}
			}
			
		else {
			SendMessageToPC(oScryer, "Snipping a purse takes skill. Snipping a body part takes even more skill. If the target won't give a personal token to you out of friendship, you'll need those skills to get it otherwise.");
		}
		
		SignalEvent(oTarget, EventUserDefined(EVENT_DISTURBED));
		}
	
	if(GetObjectType(oTarget) == OBJECT_TYPE_ITEM) {
		oToken = CreateItemOnObject("abr_it_scry_possess", oScryer, 1);
		SendMessageToPC(oScryer, "A brief shimmer envelopes your hand and the " + GetName(oTarget));
		SetFirstName(oToken, GetName(oScryer) + "'s " + GetName(oTarget));
		DestroyObject(oTarget);
		}
		
	ACR_SetPersistentString(oToken, "sPScryerName", sScryer);
	ACR_SetPersistentString(oToken, "sPTargetName", sTarget);
									
}