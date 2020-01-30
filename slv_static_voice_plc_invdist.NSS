//Wynna September 2009


#include "acr_placeable_i"

void main()
{
	ACR_PlaceableOnDisturbed();
    object oItem = GetInventoryDisturbItem();
	object oUser = GetLastDisturbed();
		
	
		 
if((GetTag(OBJECT_SELF) == "slv_deandragon_e_ice") && (GetInventoryDisturbType() == INVENTORY_DISTURB_TYPE_REMOVED))
	   {object oMyArrowhawk1 = GetNearestObjectByTag("003_slv_dq_a_creature", oUser, 1);
		object oMyArrowhawk2 = GetNearestObjectByTag("003_slv_dq_a_creature", oUser, 2);
		object oMyArrowhawk3 = GetNearestObjectByTag("003_slv_dq_a_creature", oUser, 3);
		object oMyArrowhawk4 = GetNearestObjectByTag("003_slv_dq_a_creature", oUser, 4);
	    object oMyArrowhawk5 = GetNearestObjectByTag("003_slv_dq_a_creature", oUser, 5);
		object oMyArrowhawk6 = GetNearestObjectByTag("003_slv_dq_a_creature", oUser, 6);
	    AssignCommand(oMyArrowhawk1, ActionSpeakString("*As soon as the eggs are touched, an arrowhawk hurtles from out of the sky!", TALKVOLUME_TALK));
		
		ChangeToStandardFaction(oMyArrowhawk1, STANDARD_FACTION_HOSTILE);
		ChangeToStandardFaction(oMyArrowhawk2, STANDARD_FACTION_HOSTILE);
		ChangeToStandardFaction(oMyArrowhawk3, STANDARD_FACTION_HOSTILE);
		ChangeToStandardFaction(oMyArrowhawk4, STANDARD_FACTION_HOSTILE);
		ChangeToStandardFaction(oMyArrowhawk5, STANDARD_FACTION_HOSTILE);
		ChangeToStandardFaction(oMyArrowhawk6, STANDARD_FACTION_HOSTILE);
		}
}