#include "silvy_univ_inc"
#include "silvy_univ_func"
#include "acr_quest_i"



void main()
{
    object oDM = GetItemActivator();
	if(oDM == OBJECT_INVALID)
		{oDM = OBJECT_SELF;
		}
    
    object oStudent = GetItemActivatedTarget();
	location lCreate = GetItemActivatedTargetLocation();
    string sResRefAlpha = GetLocalString(oDM, "Sphinx_Alpha");
	string sResRefItem = GetLocalString(oDM, "Sphinx_Item");
	string sResRefCreature = GetLocalString(oDM, "Sphinx_Creature");
	

    //University Rod Create Quest Creature/Book/Essence/Item
	
	

 if((GetIsDM(oDM)) || (GetIsDMPossessed(oDM)) || (FindSubString(GetName(oDM), "Wynna", 0) != -1) )
	{
	if(GetIsLocationValid(lCreate) == TRUE)
		{if(sResRefItem != "")
		 	{if(sResRefItem == "All")
			 	{object oCreateBook = CreateObject(OBJECT_TYPE_ITEM, "slv_deansphinx_" + sResRefAlpha, lCreate, FALSE);
				 object oCreateEssence = CreateObject(OBJECT_TYPE_ITEM, "slv_deansphinx_" + sResRefAlpha + "_essence", lCreate, FALSE);
				 object oCreateItem = CreateObject(OBJECT_TYPE_ITEM, "slv_deansphinx_" + sResRefAlpha + "_item", lCreate, FALSE);
				 SendMessageToPC(oDM, GetTag(oCreateBook) + " created on " + GetName(oStudent) + " or at lCreate");
				 SendMessageToPC(oDM, GetTag(oCreateEssence) + " created on " + GetName(oStudent) + " or at lCreate");
				 SendMessageToPC(oDM, GetTag(oCreateItem) + " created on " + GetName(oStudent) + " or at lCreate");
				}
			 else if(sResRefItem == "Book")
			 	{object oCreate = CreateObject(OBJECT_TYPE_ITEM, "slv_deansphinx_" + sResRefAlpha, lCreate, FALSE);
				 SendMessageToPC(oDM, GetTag(oCreate) + " created on " + GetName(oStudent) + " or at lCreate");
				}
			 else 
			 	{object oCreate = CreateObject(OBJECT_TYPE_ITEM, "slv_deansphinx_" + sResRefAlpha + sResRefItem, lCreate, FALSE);
				 SendMessageToPC(oDM, GetTag(oCreate) + " created on " + GetName(oStudent) + " or at lCreate");
				}
			SetLocalString(oDM, "Sphinx_Alpha", "");
			SetLocalString(oDM, "Sphinx_Item", "");
			}	
			
		if(sResRefCreature == "Creature")
		 	{string sResRefCreateCreature = "003_slv_dq_" + sResRefAlpha + "_creature";
			 object oCreateCreature = CreateObject(OBJECT_TYPE_CREATURE, sResRefCreateCreature, lCreate, 0);
			 DelayCommand(1.0, SendMessageToPC(oDM, GetName(oCreateCreature) + " " + GetTag(oCreateCreature) + " created and will self-destroy in 2 hours."));
			 DelayCommand(7200.0, SendMessageToPC(oDM, GetName(oCreateCreature) + " " + GetTag(oCreateCreature) + " will self-destroy in 1 minute."));
			 DestroyObject(oCreateCreature, 7260.0);
			 }
		}
	}
  
}