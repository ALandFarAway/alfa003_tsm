
#include "acr_placeable_i"
#include "dmfi_inc_langexe" 
#include "acr_quest_i"
#include "x0_i0_position"

////////////////////////////////////////////////////////////////////////////////
// Constants ///////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

const float NUMBER_OF_COMPASS_DIRECTIONS = 16.0;
const float HALF_COMPASS_ANGLE = 360.0/(NUMBER_OF_COMPASS_DIRECTIONS * 2.0);

string GetCompassDirectionOfBearing(float fDegrees);
string GetCompassDirectionOfAngle(float fAngle);

////////////////////////////////////////////////////////////////////////////////
// Function Definitions ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

string GetCompassDirectionOfBearing(float fDegrees)
{
    /* Takes a bearing from degrees (0.0 -> 360.0)
     * where 0.0 is North and 90.0 is West and
     * returns its corresponding compass direction
     */

    // Handle cases when the caller is lazy
    while (fDegrees < 0.0) {
        fDegrees += 360.0;
    }
    while (fDegrees > 360.0) {
        fDegrees -= 360.0;
    }

    // Do the mapping
    if (fDegrees < HALF_COMPASS_ANGLE || fDegrees > HALF_COMPASS_ANGLE * 31) {
        return "north";
    }
    else if (fDegrees < HALF_COMPASS_ANGLE * 3) {
        return "north-northeast";
    }
    else if (fDegrees < HALF_COMPASS_ANGLE * 5) {
        return "northeast";
    }
    else if (fDegrees < HALF_COMPASS_ANGLE * 7) {
        return "east-northeast";
    }
    else if (fDegrees < HALF_COMPASS_ANGLE * 9) {
        return "east";
    }
    else if (fDegrees < HALF_COMPASS_ANGLE * 11) {
        return "east-southeast";
    }
    else if (fDegrees < HALF_COMPASS_ANGLE * 13) {
        return "southeast";
    }
    else if (fDegrees < HALF_COMPASS_ANGLE * 15) {
        return "south-southeast";
    }
    else if (fDegrees < HALF_COMPASS_ANGLE * 17) {
        return "south";
    }
    else if (fDegrees < HALF_COMPASS_ANGLE * 19) {
        return "south-southwest";
    }
    else if (fDegrees < HALF_COMPASS_ANGLE * 21) {
        return "southwest";
    }
    else if (fDegrees < HALF_COMPASS_ANGLE * 23) {
        return "west-southwest";
    }
    else if (fDegrees < HALF_COMPASS_ANGLE * 25) {
        return "west";
    }
    else if (fDegrees < HALF_COMPASS_ANGLE * 27) {
        return "west-northwest";
    }
    else if (fDegrees < HALF_COMPASS_ANGLE * 29) {
        return "northwest";
    }
    return "north-northwest";
}


string GetCompassDirectionOfAngle(float fAngle)
{
    /* Takes an angle from degrees (0.0 -> 360.0)
     * where 0.0 is the positive X-axis and 90.0
     * is the positive Y-axis and returns its
     * corresponding compass direction
     */
    return GetCompassDirectionOfBearing(-fAngle + 90.0);
}

void main() {
 

	//
	// GetLastUsedBy must not be called if OBJECT_SELF has been deleted.  If we
	// are called by a DelayCommand / ExecuteScript continuation then it is
	// possible that the object has been deleted in the mean time.
	//
	// The test for OBJECT_SELF being invalid has to be done before calling the
	// ACR hook.
	//

	if (!GetIsObjectValid(OBJECT_SELF))
		return;

	ACR_PlaceableOnUsed();


	if(FindSubString(GetTag(OBJECT_SELF), "_scry") != -1)
	{object oUser = GetLastUsedBy();
	 object oScryListen = GetLocalObject(OBJECT_SELF, "oScryListen");
	 object oScryer = GetLocalObject(OBJECT_SELF, "oScryer");
	 object oScrySend = GetLocalObject(OBJECT_SELF, "oScrySend");
			
	 string sSpeak = GetLocalString(OBJECT_SELF, "SCRY_SPEAK");
	 	   if(GetLocalInt(OBJECT_SELF, "SCRY_ACTIVE") == 0) {
			SendMessageToPC(oUser, "The scrying object requires the casting of the Scry spell.");
		}
		if((GetLocalInt(OBJECT_SELF, "SCRY_ACTIVE") == 1) && (oUser != oScryer)) {
			SendMessageToPC(oUser, sSpeak);
			SendMessageToPC(oUser, "The scrying object is under the command of someone else.");
		}
		if((GetLocalInt(OBJECT_SELF, "SCRY_ACTIVE") == 1) && (oUser == oScryer)) {
			SendMessageToPC(oUser, sSpeak);
			
			object oPC = GetLocalObject(OBJECT_SELF, "oScried");
			object oArea = GetArea(oPC);
			string sSubjectArea = GetName(oArea);
			string sAreaTag = GetTag(oArea);
			int nWeatherRain = GetWeather(oArea, WEATHER_TYPE_RAIN);
			int nWeatherSnow = GetWeather(oArea, WEATHER_TYPE_SNOW);
			string sFacing = GetCompassDirectionOfAngle(GetFacing(oPC));
			location lStart = GetLocalLocation(OBJECT_SELF, "lScryStart");
								
			string sGenderNoun = "He";
			string sGenderAdj = "him";
			if(GetGender(oPC) == GENDER_FEMALE) {
				sGenderNoun = "She";
				sGenderAdj = "her";
				}
								
			SendMessageToPC(oScryer, "" );
			SendMessageToPC(oScryer, "********************" );
			SendMessageToPC(oScryer, GetName(oPC) + " is in " + sSubjectArea + ". Rain is " + IntToString(nWeatherRain) + ". Snow is " + IntToString(nWeatherSnow) + ". " + sGenderNoun + " is facing " + sFacing + "." );
								 	
			object oObject = GetFirstObjectInShape(SHAPE_SPHERE, 10.0, GetLocation(oPC), FALSE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_ITEM | OBJECT_TYPE_PLACED_EFFECT | OBJECT_TYPE_DOOR);
			string sObjectName = GetName(oObject);
			float fDistance = GetDistanceBetween(oPC, oObject);
			int nInc = 1;
			while ((oObject != OBJECT_INVALID) && (nInc <= 12)){
					string sObjectPrevious = GetName(oObject);
					oObject = GetNextObjectInShape(SHAPE_SPHERE, 10.0, GetLocation(oPC), FALSE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_ITEM | OBJECT_TYPE_PLACED_EFFECT | OBJECT_TYPE_DOOR);
					sObjectName = GetName(oObject);
					fDistance = GetDistanceBetween(oPC, oObject);
					if((sObjectName != GetName(oPC)) && (sObjectName != "") && (sObjectName != sObjectPrevious)) {
						SendMessageToPC(oScryer, sObjectName + " is " + FloatToString(fDistance, 2, 0) + " feet to the " + GetCompassDirectionOfAngle(GetAngleBetweenObjects(oPC, oObject)) + ".");
						}
					nInc++;
				}
			
			SetLocalLocation(OBJECT_SELF, "lNew", GetLocation(oPC));
			location lNew = GetLocalLocation(OBJECT_SELF, "lNew");
			float fDistanceMoved = GetDistanceBetweenLocations(lStart, lNew);
			SendMessageToPC(oScryer, "Distance between start and new is " + FloatToString(fDistanceMoved, 2, 0));
			string sMoving = "standing still.";
			string sDirection = GetCompassDirectionOfAngle(GetAngleBetweenLocations(lStart, lNew));
			if(fDistanceMoved != 0.0) {
					sMoving = "moving " + sDirection + ".";
				}
			SendMessageToPC(oScryer, GetName(oPC) + " is " + sMoving);
			
			SendMessageToPC(oScryer, "********************" );
			SendMessageToPC(oScryer, "" );
			
			
		}	
	}
		
}