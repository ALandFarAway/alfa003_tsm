#include "acr_spawn_i"

void main()
{   object oLintel = GetObjectByTag("5f_plc_mdr2_cave_in", 0);
	int nMatch = GetListenPatternNumber();
	        
		if(nMatch == 4000) {
			SetLocked(oLintel, FALSE);
			DestroyObject(OBJECT_SELF, 10.0);
			}
		
	}