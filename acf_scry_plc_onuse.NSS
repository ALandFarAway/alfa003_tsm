//
//  System Name : Scrying
//     Filename : acf_scry_plc_onspellcastat
//      Version : 0.1
//         Date : 7/8/22
//       Author : Wynna
//
//  Description
//  This script handles on use actions of placeables used in the scrying system. 
//  It provides a spoken update by the scrying object to the scryer on the scrying target.
//  This should be in the On Use Script slot of placeables in the _ALFA_Scrying Category: 
//	Mirror
//	Holy Water Font
//	Natural Pool of Water
//	It is not updated in ACR updates.
//
//  Revision History
////////////////////////////////////////////////////////////////////////////////

//	Wynna - 7/8/2022

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
#include "acr_placeable_i"
#include "acr_scry_i"

////////////////////////////////////////////////////////////////////////////////
// Constants ///////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Function Definitions ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

void main() {
 	if (!GetIsObjectValid(OBJECT_SELF))
		return;

	ACR_PlaceableOnUsed();
	//Get oUser and existing local objects
 	object oUser = GetLastUsedBy();
	object oScrySpeak = GetLocalObject(OBJECT_SELF, "oScrySpeak");
	object oScryer = GetLocalObject(OBJECT_SELF, "oScryer");
	object oScrySend = GetLocalObject(OBJECT_SELF, "oScrySend");
	int nSecret = GetLocalInt(OBJECT_SELF, "SCRY_SECRET");			
	//Has Scry been successfully cast?
	if((nSecret == 0) && ((GetLocalInt(OBJECT_SELF, "nScryActive") == 0)  || (GetName(GetLocalObject(OBJECT_SELF, "oScried")) == ""))) {
			SendMessageToPC(oUser, "The scrying object requires the casting of the Scry spell.");
		}
	//If so, was it cast by oUser?
	if((GetLocalInt(OBJECT_SELF, "nScryActive") == 1) && (oUser != oScryer) && (!GetIsDM(oUser))&& (!GetIsDMPossessed(oUser))) {
		SendMessageToPC(oUser, "The scrying object is under the command of someone else.");
		}
		
	//If Scry has been successfully cast, then oScried exists	
	if((GetLocalInt(OBJECT_SELF, "nScryActive") == 1) && (GetName(GetLocalObject(OBJECT_SELF, "oScried")) != "") && ((oUser == oScryer) || (GetIsDM(oUser)) || (GetIsDMPossessed(oUser)))) {
	object oScried = GetLocalObject(OBJECT_SELF, "oScried");
	//Check area information about oScried
	object oArea = GetArea(oScried);
	string sSubjectArea = GetName(oArea);
	string sAreaTag = GetTag(oArea);
	
			//General area descriptors
			if(FindSubString(sAreaTag, "caravan", 0) != -1) 
				{sSubjectArea = "inside a caravan.";}
			else if(FindSubString(sAreaTag, "ferry", 0) != -1)
				{sSubjectArea = "on a ferry.";}
			else if((FindSubString(sAreaTag, "cave", 0) != -1) || (FindSubString(sAreaTag, "cavern", 0) != -1))
				{sSubjectArea = "inside a natural cave.";}
			else if((FindSubString(sAreaTag, "tavern", 0) != -1) || (FindSubString(sAreaTag, "brightblade", 0) != -1) || (FindSubString(sAreaTag, "angler", 0) != -1)  || (FindSubString(sAreaTag, "flagon", 0) != -1) )
				{sSubjectArea = "inside a tavern, tables and a long bar visible.";}
			else if((FindSubString(sAreaTag, "crypt", 0) != -1) || (FindSubString(sAreaTag, "mausoleum", 0) != -1)  || (FindSubString(sAreaTag, "tomb", 0) != -1)|| (FindSubString(sAreaTag, "catacomb", 0) != -1) )
				{sSubjectArea = "inside a crypt, surrounded by the bones of the dead.";}
			else if(FindSubString(sAreaTag, "mine", 0) != -1)
				{sSubjectArea = "inside hand-carved tunnels, with the tracks of a minecart visible.";}
			else if(FindSubString(sAreaTag, "ruins", 0) != -1)
				{sSubjectArea = "inside crumbling ruins.";}
			else if(FindSubString(sAreaTag, "sewer", 0) != -1)
				{sSubjectArea = "inside a fetid sewer.";}
			else if(FindSubString(sAreaTag, "stable", 0) != -1)
				{sSubjectArea = "inside a stable, horses in their stalls.";}
			else if((FindSubString(sAreaTag, "ext_highway", 0) != -1) || (FindSubString(sAreaTag, "ext_river_road", 0) != -1))
				{sSubjectArea = "outside, on a well-travelled highway beside a major river.";}
			else if((FindSubString(sAreaTag, "temple", 0) != -1) || (FindSubString(sAreaTag, "chapel", 0) != -1)  || (FindSubString(sAreaTag, "lathander", 0) != -1))
				{sSubjectArea = "inside a temple, judging by the decor and the sound of prayer.";}
			else if((FindSubString(sAreaTag, "_inn", 0) != -1) || (FindSubString(sAreaTag, "griffon_up", 0) != -1) || (FindSubString(sAreaTag, "troll", 0) != -1))
				{sSubjectArea = "inside a cosy inn room.";}
			else if((FindSubString(sAreaTag, "_int_", 0) != -1) && (FindSubString(sAreaTag, "interior", 0) != -1)) 
				{sSubjectArea = "inside, though nothing uniquely identifiable is visible.";}
			else if(FindSubString(sAreaTag, "_ext_", 0) != -1)
				{sSubjectArea = "outside, though nothing uniquely identifiable is visible.";}
			else {sSubjectArea = "somewhere where you can see no identifying details of the surroundings.";}	
				
		
			//Check weather information in oScried's area				
			int nWeatherRain = GetWeather(oArea, WEATHER_TYPE_RAIN);
			string sWeatherRain = "";
			int nWeatherSnow = GetWeather(oArea, WEATHER_TYPE_SNOW);
			string sWeatherSnow = "";
								
			if(FindSubString(sAreaTag, "ext", 1) != -1)
				{if(nWeatherSnow < 1) {
					if(nWeatherRain == 0)  
						{sWeatherRain = "The sun is shining. ";}
					if(nWeatherRain == 1)  
						{sWeatherRain = "It is drizzling rain. ";}
					if(nWeatherRain == 2)  
						{sWeatherRain = "It is raining lightly. ";}
					if(nWeatherRain == 3)  
						{sWeatherRain = "Rain is falling. ";}
					if(nWeatherRain == 4)  
						{sWeatherRain = "Rain is pouring down. ";}
					if(nWeatherRain == 5)  
						{sWeatherRain = "A storm rages. ";}
				}						
				 
				if(nWeatherSnow == 0)  
					{sWeatherSnow = "The sky is clear. ";}
				if(nWeatherSnow == 1)  
					{sWeatherSnow = "A few flakes of snow are falling. ";}
				if(nWeatherSnow == 2)  
					{sWeatherSnow = "It is snowing lightly. ";}
				if(nWeatherSnow == 3)  
					{sWeatherSnow = "Snow is falling. ";}
				if(nWeatherSnow == 4)  
					{sWeatherSnow = "Snow is falling heavily. ";}
				if(nWeatherSnow == 5)  
					{sWeatherSnow = "A blizzard rages. ";}
				}
			
			string sGenderNoun = "He";
			string sGenderAdj = "him";
			if(GetGender(oScried) == GENDER_FEMALE) {
				sGenderNoun = "She";
				sGenderAdj = "her";
				}
				
			//Speak area and weather info  	
			ActionSpeakString( "", TALKVOLUME_TALK);
			ActionSpeakString( "********************", TALKVOLUME_TALK);
			ActionSpeakString("The " + GetName(OBJECT_SELF) + " shows that " + GetName(oScried) + " is " + sSubjectArea + " " + sWeatherRain + sWeatherSnow, TALKVOLUME_TALK);
			
			//Speak oScried's detailed object information 					 	
			object oObject = GetFirstObjectInShape(SHAPE_SPHERE, 10.0, GetLocation(oScried), FALSE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_ITEM | OBJECT_TYPE_PLACED_EFFECT | OBJECT_TYPE_DOOR);
			if(oObject != OBJECT_INVALID) {
				ActionSpeakString("The " + GetName(OBJECT_SELF) + " also shows that: ", TALKVOLUME_TALK); 
				string sObjectName = GetName(oObject);
				float fDistance = GetDistanceBetween(oScried, oObject);
				int nInc = 1;
				while ((oObject != OBJECT_INVALID) && (nInc <= 12)){
						string sObjectPrevious = GetName(oObject);
						oObject = GetNextObjectInShape(SHAPE_SPHERE, 10.0, GetLocation(oScried), FALSE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_ITEM | OBJECT_TYPE_PLACED_EFFECT | OBJECT_TYPE_DOOR);
						sObjectName = GetName(oObject);
						fDistance = GetDistanceBetween(oScried, oObject);
						if((sObjectName != GetName(oScried)) && (sObjectName != "") && (sObjectName != sObjectPrevious)) {
							ActionSpeakString(sObjectName + " is " + FloatToString(fDistance, 2, 0) + " feet away.");
							}
						nInc++;
					}
				}
				
			ActionSpeakString( "********************", TALKVOLUME_TALK);
			ActionSpeakString( "", TALKVOLUME_TALK);
		}	
}