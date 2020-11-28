
//Wynna November 2020

 
#include "acr_items_i"
#include "acr_db_persist_i"
#include "acr_quest_i"
#include "dmfi_inc_langexe" 


void main()
{	
	object oItem = GetPCItemLastEquipped();
 	object oPC = GetPCItemLastEquippedBy();
			 
	object oTool=DMFI_GetTool(oPC);
	string sLang = "LNG_ORC";
	
		 if (DMFI_IsLanguageKnown(oPC, sLang) == FALSE)
				{DMFI_GrantLanguage(oPC, sLang);
				 SetLocalInt(oPC, "DMFI_TemporaryOrc", 1);
				}
			
					 
}			  