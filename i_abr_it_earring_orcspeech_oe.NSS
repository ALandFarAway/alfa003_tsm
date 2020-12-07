
//Wynna November 2020

 
#include "acr_items_i"
#include "acr_db_persist_i"
#include "acr_quest_i"
#include "dmfi_inc_langexe" 
#include "x2_inc_itemprop"	

void main()
{	
	object oItem = GetPCItemLastEquipped();
 	object oPC = GetPCItemLastEquippedBy();
			
	object oTool=DMFI_GetTool(oPC);
	string sLang = "orc";
		 SendMessageToPC(oPC, "Equipped " + GetName(oItem));
		 if (DMFI_IsLanguageKnown(oPC, sLang) == FALSE)
				{DMFI_GrantLanguage(oPC, sLang);
				 SetLocalInt(oItem, "DMFI_TemporaryOrc", 1);
				 }
			
					 
}			  