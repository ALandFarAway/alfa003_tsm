//This script will cause anyone standing in it to have the door they touch be unlocked
void main()
{
    object oDoor;
    location here;
	string sKey;
	string sKeyTwo;
	object oKey;
    object oKeyTwo;
    here = GetLocation(GetEnteringObject());
    oDoor = GetNearestObject(OBJECT_TYPE_DOOR);
	sKey = GetLocalString(oDoor, "sKey");
	sKeyTwo = GetLocalString(oDoor, "sKeyTwo");
	oKey = GetItemPossessedBy(GetEnteringObject(), sKey);
	oKeyTwo = GetItemPossessedBy(GetEnteringObject(), sKeyTwo);
	if((oKey != OBJECT_INVALID)|| (oKeyTwo != OBJECT_INVALID)) {
    	SetLocked(oDoor, FALSE);
		}

}