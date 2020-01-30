//OnUse for all Dean's Exam (deandragon) placeables 
//Wynna February 2009


#include "acr_placeable_i"
#include "acr_xp_i"
#include "acr_quest_i"
#include "acr_spawn_i"


object oPC = GetLastOpenedBy();



void main()
{
	ACR_PlaceableOnOpen();

	    
	//deandragon_d dragon berry harvesting
	if((GetTag(OBJECT_SELF) == "deandragon_d_dragonberry1") || (GetTag(OBJECT_SELF) == "deandragon_d_dragonberry2")|| (GetTag(OBJECT_SELF) == "deandragon_d_dragonberry3"))
	   {object oQuester = GetLocalObject(OBJECT_SELF, "oQuester");
		if(oQuester == OBJECT_INVALID)
			{oQuester = GetLastOpenedBy();}
		object oKnife = GetItemPossessedBy(oQuester, "003_it_wpn_dragontalon");
		
		if((oKnife == OBJECT_INVALID) && (GetLocalInt(OBJECT_SELF, "Frozen") != 1))
			{SendMessageToPC(oQuester, "The delicate clusters of fruit have thick, fibrous stems. While attempting to snap some free, they bruise, the rich red juice dripping like blood onto the ground.  The berries drain to nothing but empty, withered skin. You will need something exceptionally sharp to cut these stems without bruising the next bunch of fruit...whenever that ripens.");
			 DestroyInventory(OBJECT_SELF);
			 DestroyObject(OBJECT_SELF);
			 }
		if((oKnife == OBJECT_INVALID) && (GetLocalInt(OBJECT_SELF, "Frozen") == 1))
			{SendMessageToPC(oQuester, "The frozen clusters of fruit have thick, fibrous stems. While attempting to snap some free, the warmth from your hand thaws the berries and they bruise. Rich red juice drips onto the ground. The berries drain to nothing but empty, withered skin. You will need something exceptionally sharp to cut these stems without bruising the next bunch of fruit...whenever that ripens.");
			 DestroyInventory(OBJECT_SELF);
			 DestroyObject(OBJECT_SELF);
			 }	
		if((oKnife != OBJECT_INVALID) && (GetLocalInt(OBJECT_SELF, "Frozen") != 1)&& (GetLocalInt(oQuester, "BlessedWeapon") == 1))
			{SendMessageToPC(oQuester, "You use a surgically sharp knife to slice the delicate clusters of fruit from the bush, but the fruit is so delicate that the pressure of your hand bruises it.  For a moment they seem fine, but the instant the blessed blade is no longer in contact with the stem, the berries drain to nothing but empty, withered skin, clearly useless. Frozen berries would not have been so delicate.");
			 DestroyInventory(OBJECT_SELF);
			 DestroyObject(OBJECT_SELF);
			 }	
		if((oKnife != OBJECT_INVALID) && (GetLocalInt(OBJECT_SELF, "Frozen") != 1)&& (GetLocalInt(oQuester, "BlessedWeapon") != 1))
			{SendMessageToPC(oQuester, "You use a surgically sharp knife to slice the delicate clusters of fruit from the bush, but the fruit is so delicate that the pressure of your hand bruises it.  The berries drain to nothing but empty, withered skin, clearly useless. Frozen berries would not have been so delicate.");
			 DestroyInventory(OBJECT_SELF);
			 DestroyObject(OBJECT_SELF);
			 }	
		if((oKnife != OBJECT_INVALID) && (GetLocalInt(OBJECT_SELF, "Frozen") == 1)&& (GetLocalInt(oQuester, "BlessedWeapon") != 1))
			{SendMessageToPC(oQuester, "You use a surgically sharp knife to slice the frozen clusters of fruit from the bush, but the fruit is so delicate that the warmth of your hand melts away the frost and bruises the berries.  They drain to nothing but empty, withered skin, clearly useless.");
			 DestroyInventory(OBJECT_SELF);
			 DestroyObject(OBJECT_SELF);
			 }	
		if((oKnife != OBJECT_INVALID) && (GetLocalInt(OBJECT_SELF, "Frozen") == 1) && (GetLocalInt(oQuester, "BlessedWeapon") == 1))
			{SendMessageToPC(oQuester, "You use a surgically sharp, blessed knife to slice the frozen clusters of fruit from the bush. The berries actually seem to plump up beneath the frost at the touch of the blade.");
			 int nRandom = Random(4);
			 object oBerries = CreateItemOnObject("003_it_food_dragonberry", OBJECT_SELF, nRandom);
			 SetLocalObject(oQuester, GetTag(OBJECT_SELF) + "_berries", oBerries);
			 }
		SetUseableFlag(OBJECT_SELF, FALSE);
		}
		
		
	//Deansphinx e air ice boulder with arrowhawk eggs
	if(GetTag(OBJECT_SELF) == "slv_deandragon_e_ice") 
	   {object oMyArrowhawk1 = GetNearestObjectByTag("003_slv_dq_a_creature", oPC, 1);
		object oMyArrowhawk2 = GetNearestObjectByTag("003_slv_dq_a_creature", oPC, 2);
		object oMyArrowhawk3 = GetNearestObjectByTag("003_slv_dq_a_creature", oPC, 3);
		object oMyArrowhawk4 = GetNearestObjectByTag("003_slv_dq_a_creature", oPC, 4);
		AssignCommand(oMyArrowhawk1, ActionSpeakString("*Shrieks a warning cry*", TALKVOLUME_TALK));
		AssignCommand(oMyArrowhawk1, ActionMoveToLocation(GetLocation(oPC), TRUE));
		AssignCommand(oMyArrowhawk2, ActionMoveToLocation(GetLocation(oPC), TRUE));
		AssignCommand(oMyArrowhawk3, ActionMoveToLocation(GetLocation(oPC), TRUE));
		AssignCommand(oMyArrowhawk4, ActionMoveToLocation(GetLocation(oPC), TRUE));
		
		if(ReflexSave(oPC, 15, SAVING_THROW_TYPE_NONE, OBJECT_SELF))
			{SendMessageToPC(oPC, "Your sharp reflexes allow you to climb up close enough to reach for an egg before they are blown away.");
			}
		else 
			{SendMessageToPC(oPC, "You slip on the icy boulder, clambering after the eggs. Some of them blow away!");
			 DestroyObject(GetFirstItemInInventory(OBJECT_SELF), 2.0);
			}
		}

		
//deandragon_e_fire trap disabling and container unlocking
	if(GetTag(OBJECT_SELF) == "slv_deandragon_e_firetrap") 
		   {SendMessageToPC(GetLastOpenedBy(), "A mephit darts out of the jaws of the fire trap!");
		    CreateObject(OBJECT_TYPE_CREATURE, "003_cr_mephit_fire", GetLocation(GetLastOpenedBy()));
			}
			
//deandragon k leomund secure shelter doors
	SpeakString("Called Open", TALKVOLUME_TALK);
	
	if(GetTag(OBJECT_SELF) == "leomund_shelter_door")
		{SpeakString("Tagged Open", TALKVOLUME_TALK);
	     object oCollBox = GetLocalObject(OBJECT_SELF, "MyCollBox");
		 DestroyObject(oCollBox);
		 	
		if(GetLocalInt(OBJECT_SELF, "Spawned") != 1)
			{SpeakString("Spawned Open", TALKVOLUME_TALK);
	        string sSpawn;
			int iSpawn = Random(5) + 1;
			SendMessageToPC(GetEnteringObject(), "Creatures come boiling out the door!");
			if((iSpawn >= 1) && (iSpawn <=3))
				{CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_hu_koboldfighter02", GetLocation(OBJECT_SELF));
				CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_hu_koboldfighter04", GetLocation(OBJECT_SELF));
				CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_hu_koboldscout01", GetLocation(OBJECT_SELF));
				CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_hu_koboldscout01", GetLocation(OBJECT_SELF));
				CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_hu_koboldcaptain", GetLocation(OBJECT_SELF));
				}
			else if(iSpawn == 4)
				{CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_hu_koboldelite01", GetLocation(OBJECT_SELF));
				CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_hu_koboldfighter03", GetLocation(OBJECT_SELF));
				CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_hu_koboldfighter04", GetLocation(OBJECT_SELF));
				CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_hu_koboldscout01", GetLocation(OBJECT_SELF));
				CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_hu_koboldscout01", GetLocation(OBJECT_SELF));
				CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_hu_koboldscout01", GetLocation(OBJECT_SELF));
				CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_hu_koboldcaptain", GetLocation(OBJECT_SELF));
				}
			else if(iSpawn == 5)
				{CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_hu_koboldshaman", GetLocation(OBJECT_SELF));
				CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_hu_koboldcaptain", GetLocation(OBJECT_SELF));
				CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_hu_koboldscout01", GetLocation(OBJECT_SELF));
				CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_hu_koboldscout01", GetLocation(OBJECT_SELF));
				CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_hu_koboldfighter04", GetLocation(OBJECT_SELF));
				CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_hu_koboldscout01", GetLocation(OBJECT_SELF));
				}
			}	
		DestroyObject(OBJECT_SELF, 2.0);
		}			
			
}