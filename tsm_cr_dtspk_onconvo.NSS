#include "acr_spawn_i"

void main()
{   object oLintel = GetObjectByTag("5f_plc_mdr2_cave_in", 0);
	int nMatch = GetListenPatternNumber();
	        
		if(nMatch == 4000) {
			SetFirstName(OBJECT_SELF, "Carved");
			SetLastName(OBJECT_SELF, "Lintel");
			ActionSpeakString("*Dark occlusions and shadows on the face of the cliff shift. What had suggested an orcish profile now crawls apart...then back together, becoming runes equally harsh and brutal.", TALKVOLUME_TALK);
			DelayCommand(6.0, SetLocked(oLintel, FALSE));
			DestroyObject(OBJECT_SELF, 11.0);
			}
		
	}