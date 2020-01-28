//Wynna September 2009


#include "acr_placeable_i"

void main()
{
	ACR_PlaceableOnDisturbed();
    object oItem = GetInventoryDisturbItem();
	object oUser = GetLastDisturbed();
		
	
		 
if((GetTag(OBJECT_SELF) == "slv_deandragon_e_ice") && (GetInventoryDisturbType() == INVENTORY_DISTURB_TYPE_REMOVED))
	   {object oMyArrowhawk1 = GetNearestObjectByTag("003_slv_dq_a_creature", GetEnteringObject(),1);
		object oMyArrowhawk2 = GetNearestObjectByTag("003_slv_dq_a_creature", GetEnteringObject(),2);
		object oMyArrowhawk3 = GetNearestObjectByTag("003_slv_dq_a_creature", GetEnteringObject(),3);
		object oMyArrowhawk4 = GetNearestObjectByTag("003_slv_dq_a_creature", GetEnteringObject(),4);
	    AssignCommand(oMyArrowhawk1, ActionSpeakString("*As soon as the eggs are touched, an arrowhawk hurtles from out of the sky!", TALKVOLUME_TALK));
		if(ReflexSave(oUser, 15, SAVING_THROW_TYPE_TRAP, OBJECT_SELF))
			{SendMessageToPC(oUser, "Your sharp reflexes allow you to snag an egg before they are blown away.");
			}
		else 
			{SendMessageToPC(oUser, "You slip on the icy boulder, clambering after the eggs. Some of them blow away!");
			 DestroyObject(oItem, 2.0);
			}
		
		ChangeToStandardFaction(oMyArrowhawk1, STANDARD_FACTION_HOSTILE);
		ChangeToStandardFaction(oMyArrowhawk2, STANDARD_FACTION_HOSTILE);
		ChangeToStandardFaction(oMyArrowhawk3, STANDARD_FACTION_HOSTILE);
		ChangeToStandardFaction(oMyArrowhawk4, STANDARD_FACTION_HOSTILE);
		}
}