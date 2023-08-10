#include "acr_spawn_i"

void main()
{   object oLintel = GetObjectByTag("5f_plc_mdr2_cave_in", 0);
	int nMatch = GetListenPatternNumber();
	        
		if(nMatch == 4000) {
			SetFirstName(OBJECT_SELF, "Lintel");
			SetLastName(OBJECT_SELF, "");
			ActionSpeakString("*Dark occlusions and shadows on the face of the cliff shift, what had suggested an orcish profile now crawling apart then back together, becoming runes.", TALKVOLUME_TALK);
			DelayCommand(5.0, ActionSpeakString("*The runes are orcish, and read 'The Khan's Way'.", TALKVOLUME_TALK));
			DelayCommand(6.0, SetLocked(oLintel, FALSE));
			DestroyObject(OBJECT_SELF, 10.0);
			}
		
	}