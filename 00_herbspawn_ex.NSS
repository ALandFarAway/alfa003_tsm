void spawn_group(string resref, float prob=1.0)
{
	float f = ACR_RandomFloat();
	object o = OBJECT_INVALID;
	
	if (f <= prob) {
		ACR_SpawnGroup(resref);
	}
}

void spawn_placeable(string resref, float prob=1.0, float deg=0.0, float deg2=180.0, float dist = 6.0)
{
	float f = (Random(1000)*1.0)/1000;
	object o = OBJECT_INVALID;
	location loc;
		
	if (f <= prob) {
		loc = ACR_GetSpawnLocationFromDirectionAndFacing(deg,dist,deg2+deg);
		
		o = CreateObject(OBJECT_TYPE_CREATURE, "c_faction_pig", loc);
		
		loc = GetLocation(o);
		
		DestroyObject(o);
		
		o = ACR_SpawnObjectAtLocation(resref, OBJECT_TYPE_PLACEABLE, loc);
		
		/* Generic placeables with inventories (chests), lock them */
		if (GetHasInventory(o) && (FindSubString(GetTag(o),"phat_lewt") == -1)) {
			SetEventHandler(o, SCRIPT_PLACEABLE_ON_OPEN, "acf_plc_onopen");
			SetPlotFlag(o,1);
			SetLocked(o,1);
			SetLockUnlockDC(o, 20+Random(11));
			SetLocalInt(o,"ACR_SPAWN_JUNK",1);
		}
		}
		}