//Change NPCs in the area to Defender Faction
//Wynna February 2021


#include "acr_creature_i"
#include "acr_xp_i"
#include "acr_quest_i"


void main()
  { object oNPC = GetItemActivatedTarget();
    ChangeToStandardFaction(oNPC, STANDARD_FACTION_DEFENDER);
  	int nLoop = 1;
	object oNPCArea = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC, oNPC, nLoop);
	while((oNPCArea != OBJECT_INVALID) && (nLoop < 50)) {
		ChangeToStandardFaction(oNPCArea, STANDARD_FACTION_DEFENDER);
	  	nLoop = nLoop + 1;
		oNPCArea = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC, oNPC, nLoop);
	}
  
  }