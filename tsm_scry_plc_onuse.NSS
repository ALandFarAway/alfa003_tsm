
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
	//Get oUser and existing local objects
 	object oUser = GetLastUsedBy();
	object oScryListen = GetLocalObject(OBJECT_SELF, "oScryListen");
	object oScryer = GetLocalObject(OBJECT_SELF, "oScryer");
	object oScrySend = GetLocalObject(OBJECT_SELF, "oScrySend");
				
	string sSpeak = GetLocalString(OBJECT_SELF, "SCRY_SPEAK");
	//Has Scry been successfully cast?
	if(GetLocalInt(OBJECT_SELF, "nScryActive") == 0) {
			SendMessageToPC(oUser, "The scrying object requires the casting of the Scry spell.");
		}
	//If so, was it cast by oUser?
	if((GetLocalInt(OBJECT_SELF, "nScryActive") == 1) && (oUser != oScryer) && (!GetIsDM(oUser))&& (!GetIsDMPossessed(oUser))) {
		SendMessageToPC(oUser, "nScryActive = " + IntToString(GetLocalInt(OBJECT_SELF, "nScryActive")));	
		SendMessageToPC(oUser, "oScryer = " + GetName(oScryer));
		SendMessageToPC(oUser, "The scrying object is under the command of someone else.");
		}
		
	//If Scry has been successfully cast, then oScried exists	
	if((GetLocalInt(OBJECT_SELF, "nScryActive") == 1) && ((oUser == oScryer) || (GetIsDM(oUser)) || (GetIsDMPossessed(oUser)))) {
	object oScried = GetLocalObject(OBJECT_SELF, "oScried");
	//Check area information about oScried
	object oArea = GetArea(oScried);
	string sSubjectArea = GetName(oArea);
	string sAreaTag = GetTag(oArea);
	
			if(FindSubString(sAreaTag, "caravan", 0) != -1) 
				{sSubjectArea = "inside a caravan.";}
			else if(FindSubString(sAreaTag, "ferry", 0) != -1)
				{sSubjectArea = "on a ferry.";}
			else if(FindSubString(sAreaTag, "int_highforest_cave_aq", 0) != -1)
				{sSubjectArea = "inside a darkened ruin in which the sound of water runs all around.";}
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
			else if(FindSubString(sAreaTag, "_argent", 0) != -1)
				{sSubjectArea = "inside an argent legion outpost, the arms and insignia of the military all around.";}
			else if(FindSubString(sAreaTag, "circus", 0) != -1)
				{sSubjectArea = "outside, within site of circus exhibits.";}
			else if(FindSubString(sAreaTag, "bigtp", 0) != -1)
				{sSubjectArea = "inside a circus big top tent.";}
			else if(FindSubString(sAreaTag, "int_cards", 0) != -1)
				{sSubjectArea = "inside a tent, with card tables visible.";}
			else if(FindSubString(sAreaTag, "int_mirror", 0) != -1)
				{sSubjectArea = "inside a tent, with many mirrors seemingly on display.";}
			else if(FindSubString(sAreaTag, "4c_ext", 0) != -1)
				{sSubjectArea = "outside, beside the bank of a mighty river flowing through an icy alpine evergreen forest.";}
			else if(FindSubString(sAreaTag, "ext_frosthills", 0) != -1)
				{sSubjectArea = "outside, with the peaks of the Frost Hills rising all around.";
					if(FindSubString(sAreaTag, "fourth", 0) != -1)
						{sSubjectArea = sSubjectArea + " The fort of Fourthpeak is visible commanding the heights.";}
					else if(FindSubString(sAreaTag, "lake", 0) != -1)
						{sSubjectArea = sSubjectArea + " A deep alpine lake shimmers nearby.";}
					else if(FindSubString(sAreaTag, "glacier_tr", 0) != -1)
						{sSubjectArea = sSubjectArea + " A trail winds up into the frozen heights of a glacier.";}
					else if((FindSubString(sAreaTag, "glacier_settle", 0) != -1) || (FindSubString(sAreaTag, "settlestone", 0) != -1))
						{sSubjectArea = sSubjectArea + " Narrow walls enclose a small settlement.";}
					else if(FindSubString(sAreaTag, "glacier_keeper", 0) != -1)
						{sSubjectArea = sSubjectArea + " A forbidding pair of gates inscribed with dwarven runes blocks the way ahead.";}
					else if(FindSubString(sAreaTag, "glacier", 0) != -1)
						{sSubjectArea = sSubjectArea + " A glacial waste of icy and snow stretches in all directions.";}
					else if(FindSubString(sAreaTag, "road", 0) != -1)
						{sSubjectArea = sSubjectArea + " A road wends ahead beside a massive stone cliff, as far as can be seen.";}
				}
			else if(FindSubString(sAreaTag, "int_fourthpeak", 0) != -1) 
				{sSubjectArea = "inside a rocky cave.";}
			else if(FindSubString(sAreaTag, "int_frosthills_glacier_plat", 0) != -1) 
				{sSubjectArea = "enclosed by walls of ice-shrouded marble.";}
			else if(FindSubString(sAreaTag, "int_frosthills_glacier_snkg", 0) != -1) 
				{sSubjectArea = "inside dark ruins with icicles hanging from the ceiling.";}
			else if(FindSubString(sAreaTag, "int_frosthills_glacier_tr", 0) != -1) 
				{sSubjectArea = "within a natural cave of ice and snow-covered rock.";}
			else if(FindSubString(sAreaTag, "int_frosthills_mh1", 0) != -1) 
				{sSubjectArea = "sheltered by ponderous stone walls inscribed with dwarven runes. Armored dwarves pass within view.";}
			else if(FindSubString(sAreaTag, "int_settlestone_dotr", 0) != -1)
				{sSubjectArea = "inside some ancient dungeon.";}
			else if((FindSubString(sAreaTag, "int_frosthills_settlestone", 0) != -1) || (FindSubString(sAreaTag, "int_settlestone", 0) != -1)) 
				{sSubjectArea = "inside, but through a window may be seen the ruined walls of Settlestone.";}
			else if(FindSubString(sAreaTag, "ext_moonwood_winter", 0) != -1)
				{sSubjectArea = "on the fringe of a forest of evergreen trees, with the palisade of Winter Edge visible.";}
			else if(FindSubString(sAreaTag, "ext_moonwood_quaer", 0) != -1)
				{sSubjectArea = "on the edge of an ancient forest, with the walls and guards of Quaervarr in sight.";}
			else if(FindSubString(sAreaTag, "ext_moonwood", 0) != -1) 
				{sSubjectArea = "within a deep forest of evergreen trees.";}
			else if(FindSubString(sAreaTag, "ext_surbin", 0) != -1) 
				{sSubjectArea = "in rolling hills with a broad river in sight.";}
			else if(FindSubString(sAreaTag, "int_herald", 0) != -1) 
				{sSubjectArea = "inside, with beautiful furnishings and shelves of books visible.";}
			else if((FindSubString(sAreaTag, "int_we_", 0) != -1) || (FindSubString(sAreaTag, "int_wintedge_", 0) != -1))
				{sSubjectArea = "inside a rustic building, with the top of Winter Edge's pallisade visible through a window.";}
			else if(FindSubString(sAreaTag, "treecity", 0) != -1)
				{sSubjectArea = "within a structure that appears to be carved inside curving walls of oakwood.";}
			else if(FindSubString(sAreaTag, "int_quaer", 0) != -1)
				{sSubjectArea = "inside a rustic structure with the pallisade walls of Quaervarr visible through a window.";}
			else if(FindSubString(sAreaTag, "5f_ext_nether", 0) != -1)
				{sSubjectArea = "outside, in mountainous terrain, with immensely tall peaks rising all around.";}
			else if(FindSubString(sAreaTag, "int_nether_dt", 0) != -1)
				{sSubjectArea = "inside a gloomy ruin.";}
			else if(FindSubString(sAreaTag, "ext_fellbar", 0) != -1)
				{sSubjectArea = "outside in icy heights, among the dwarven bastions of Felbarr.";}
			else if(FindSubString(sAreaTag, "ext_silvypass_east_auv", 0) != -1)
				{sSubjectArea = "outside, with a mountain road winding up to the walls of Auvendell visible.";}
			else if(FindSubString(sAreaTag, "ext_silvypass_east_sund", 0) != -1)
				{sSubjectArea = "outside, on a road surrounded by mountains, with road cairns labeled with the distance to Sundabar and Citadel Felbarr.";}
			else if(FindSubString(sAreaTag, "int_auvandell", 0) != -1)
				{sSubjectArea = "inside stone walls, with the gates of Auvandell visible through a window.";}
			else if(FindSubString(sAreaTag, "int_felbarr_lowroad", 0) != -1)
				{sSubjectArea = "inside a gloomy subterranean passage, with dwarven archways and the marks of dwarven axes visible, but not fresh.";}
			else if(FindSubString(sAreaTag, "int_felbarr", 0) != -1)
				{sSubjectArea = "inside stone walls of obvious dwarven engineering, thickly inscribed with dwarven runes.";}
			else if(FindSubString(sAreaTag, "ext_sundabar", 0) != -1)
				{sSubjectArea = "outside, on the busy streets of Sundabar.";}
			else if(FindSubString(sAreaTag, "int_sundabar_everfire", 0) != -1)
				{sSubjectArea = "inside a chamber where blindingly bright lava flows.";}
			else if(FindSubString(sAreaTag, "int_sundabar_lava", 0) != -1)
				{sSubjectArea = "inside a dark tunnel, its walls made of blackened, cooled lava.";}
			else if(FindSubString(sAreaTag, "int_sundabar", 0) != -1)
				{sSubjectArea = "inside a building, near a window showing the busy streets of Sundabar.";}
			else if(FindSubString(sAreaTag, "ext_evermoors", 0) != -1)
				{sSubjectArea = "outside, surrounded by the endless horizon of a swampy marshland.";}
			else if(FindSubString(sAreaTag, "ext_rivmoot", 0) != -1)
				{sSubjectArea = "in the immediately recognizable vicinity of Rivermoot.";}
			else if(FindSubString(sAreaTag, "int_rivmoot", 0) != -1)
				{sSubjectArea = "in a rustic structure, with the protected main courtyard of Rivermoot visible through a window.";}
			else if(FindSubString(sAreaTag, "ext_highhold", 0) != -1)
				{sSubjectArea = "outside, with the riverbank and the well-guarded entrance to High Hold visible.";}
			else if(FindSubString(sAreaTag, "int_clock", 0) != -1)
				{sSubjectArea = "inside what seems to be a tower room scattered with goods of obviously gnomish make.";}
			else if(FindSubString(sAreaTag, "int_hh_", 0) != -1)
				{sSubjectArea = "inside rough stone walls, with the torchlit entrance to High Hold visible through a nearby window.";}
			else if(FindSubString(sAreaTag, "ext_north_road", 0) != -1)
				{sSubjectArea = "outside, on a bleak highway through stony land.";}
			else if(FindSubString(sAreaTag, "ext_rauvenwatch", 0) != -1)
				{sSubjectArea = "outside, with the imposing walls of Rauvenwatch Keep visible.";}
			else if(FindSubString(sAreaTag, "moon_mielikki", 0) != -1)
				{sSubjectArea = "outside, in the peace of Mielikki's Grove in Silverymoon";}
			else if(FindSubString(sAreaTag, "silverymoon_surround", 0) != -1)
				{sSubjectArea = "outside the walls of Silverymoon.";}
			else if(FindSubString(sAreaTag, "ext_silvery", 0) != -1)
				{sSubjectArea = "outside, on busy streets that could only belong to Silverymoon.";}
			else if(FindSubString(sAreaTag, "ext_silvy_ladycol", 0) != -1)
				{sSubjectArea = "outside, on an expansive rooftop overlooking the city of Silverymoon.";}
			else if(FindSubString(sAreaTag, "int_rwkeep", 0) != -1)
				{sSubjectArea = "inside thick stone walls, with a window showing the courtyard of Rauvenwatch Keep.";}
			else if(FindSubString(sAreaTag, "int_silvy_constab", 0) != -1)
				{sSubjectArea = "inside a constabulary.";}
			else if(FindSubString(sAreaTag, "int_silvy_everdusk", 0) != -1)
				{sSubjectArea = "inside a building of quiet beauty, marble carved into the shapes of trees, with the sound of running water and elven voices praising the Seldarine.";}
			else if(FindSubString(sAreaTag, "int_silvy_foch", 0) != -1)
				{sSubjectArea = "inside a tall dim building, with the pennants of dramatic performances overhanging stage and walls, with a background of bardsong and the sound of clapping audiences.";}
			else if(FindSubString(sAreaTag, "int_silvy_ladycol_grd", 0) != -1)
				{sSubjectArea = "inside, with a huge library and wings off to dormitory towers.";}
			else if(FindSubString(sAreaTag, "int_silvy_ladycol_class", 0) != -1)
				{sSubjectArea = "inside, with the doors to classrooms opening and closing for robed masters and students.";}
			else if((FindSubString(sAreaTag, "int_silvy_ladycol", 0) != -1) || (FindSubString(sAreaTag, "int_silvy_palace", 0) != -1) || (FindSubString(sAreaTag, "derochelle", 0) != -1) )
				{sSubjectArea = "inside walls...but the details are blurred, as if you are denied seeing them.";}
			else if((FindSubString(sAreaTag, "int_silvy_vault", 0) != -1) || (FindSubString(sAreaTag, "int_silvy_palace", 0) != -1) )
				{sSubjectArea = "inside, surrounded by walls of floor to ceiling bookshelves.";}
			else if(FindSubString(sAreaTag, "int_silvy", 0) != -1)
				{sSubjectArea = "inside, with a window showing the busy streets that could only belong to Silverymoon.";}
			else if(FindSubString(sAreaTag, "ext_khelb", 0) != -1)
				{sSubjectArea = "outside, with the walls of Khelb visible.";}
			else if(FindSubString(sAreaTag, "int_silvypass_central", 0) != -1)
				{sSubjectArea = "outside, amid rarified peaks of ice and snow.";}
			else if((FindSubString(sAreaTag, "ext_silvypass", 0) != -1) || (FindSubString(sAreaTag, "ext_nether", 0) != -1))
				{sSubjectArea = "outside, on a wide and icy mountain highway between high peaks.";}
			else if(FindSubString(sAreaTag, "int_khelb", 0) != -1)
				{sSubjectArea = "inside, with the walls of Khelb visible through a window.";}
			else if(FindSubString(sAreaTag, "int_nether_flying", 0) != -1)
				{sSubjectArea = "inside a tavern, with a window showing a busy highway and a stable.";}
			else if(FindSubString(sAreaTag, "int_silvypass_hkn", 0) != -1)
				{sSubjectArea = "inside a cramped fort, filled with weapons racks and bunks.";}
			else if(FindSubString(sAreaTag, "int_silvypass_crystal", 0) != -1)
				{sSubjectArea = "inside a ruin filled with crystal outcroppings.";}
			else if((FindSubString(sAreaTag, "int_silvypass_delzo", 0) != -1) || (FindSubString(sAreaTag, "int_silvypass_path", 0) != -1) || (FindSubString(sAreaTag, "int_silvypass_spider", 0) != -1))
				{sSubjectArea = "inside, with rocky walls, cobwebs and ruined dwarven tunnels all visible.";}
			else if(FindSubString(sAreaTag, "int_silvypass", 0) != -1)
				{sSubjectArea = "inside, surrounded by stone and the signs of dwarven occupancy.";}
			else if(FindSubString(sAreaTag, "ext_rauvin", 0) != -1)
				{sSubjectArea = "outside, beneath trees overlooking a river valley.";}
			else if(FindSubString(sAreaTag, "ext_silverwood", 0) != -1)
				{sSubjectArea = "outside, with only trees visible in all directions.";}
			else if(FindSubString(sAreaTag, "ext_highforest_olostin", 0) != -1)
				{sSubjectArea = "outside, with the keep of Olostin's Hold visible on its high plateau.";}
			else if(FindSubString(sAreaTag, "int_highforest_cw_rillifane", 0) != -1)
				{sSubjectArea = "inside a dimly lit cavern filled with plantlife and the ripple of running water.";}
			else if(FindSubString(sAreaTag, "int_highforest_north_tree", 0) != -1)
				{sSubjectArea = "inside a huge hollow tree, judging by the look of the curving walls.";}
			else if(FindSubString(sAreaTag, "int_highforest_olostin", 0) != -1)
				{sSubjectArea = "inside a richly-appointed but martial keep.";}
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
			
			string sFacing = GetCompassDirectionOfAngle(GetFacing(oScried));
			string sGenderNoun = "He";
			string sGenderAdj = "him";
			if(GetGender(oScried) == GENDER_FEMALE) {
				sGenderNoun = "She";
				sGenderAdj = "her";
				}
				
			//Send area and weather info to oScryer 	
			ActionSpeakString( "", TALKVOLUME_TALK);
			ActionSpeakString( "********************", TALKVOLUME_TALK);
			ActionSpeakString(GetName(oScried) + " is " + sSubjectArea + " " + sWeatherRain + sWeatherSnow, TALKVOLUME_TALK);
			
			//Send oScried's detailed object information to oScryer					 	
			object oObject = GetFirstObjectInShape(SHAPE_SPHERE, 10.0, GetLocation(oScried), FALSE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_ITEM | OBJECT_TYPE_PLACED_EFFECT | OBJECT_TYPE_DOOR);
			string sObjectName = GetName(oObject);
			float fDistance = GetDistanceBetween(oScried, oObject);
			int nInc = 1;
			while ((oObject != OBJECT_INVALID) && (nInc <= 12)){
					string sObjectPrevious = GetName(oObject);
					oObject = GetNextObjectInShape(SHAPE_SPHERE, 10.0, GetLocation(oScried), FALSE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_ITEM | OBJECT_TYPE_PLACED_EFFECT | OBJECT_TYPE_DOOR);
					sObjectName = GetName(oObject);
					fDistance = GetDistanceBetween(oScried, oObject);
					if((sObjectName != GetName(oScried)) && (sObjectName != "") && (sObjectName != sObjectPrevious)) {
						ActionSpeakString(sObjectName + " is " + FloatToString(fDistance, 2, 0) + " feet to the " + GetCompassDirectionOfAngle(GetAngleBetweenObjects(oScried, oObject)) + ".", TALKVOLUME_TALK);
						}
					nInc++;
				}
			
			//Is oScried on the move?
			location lStart = GetLocalLocation(oScryListen, "lScryStart");
			SetLocalLocation(oScryListen, "lNew", GetLocation(oScried));
			location lNew = GetLocalLocation(oScryListen, "lNew");
			float fDistanceMoved = GetDistanceBetweenLocations(lStart, lNew);
			//SendMessageToPC(oScryer, "Distance between start and new is " + FloatToString(fDistanceMoved, 2, 0));
			string sMoving = "standing still.";
			string sDirection = GetCompassDirectionOfAngle(GetAngleBetweenLocations(lStart, lNew));
			if(fDistanceMoved != 0.0) {
					sMoving = "moving " + sDirection + ".";
				}
			ActionSpeakString(GetName(oScried) + " is " + sMoving, TALKVOLUME_TALK);
			
			ActionSpeakString( "********************", TALKVOLUME_TALK);
			ActionSpeakString( "", TALKVOLUME_TALK);
			
			//if Scrying Sensor has not ATd but oScried has, make Scrying Sensor jump to oScried
			if(GetArea(oScrySend) != GetArea(oScried)) {
				AssignCommand(oScrySend, ActionJumpToObject(oScried, TRUE));
			}
			 
		}	
	
		
}