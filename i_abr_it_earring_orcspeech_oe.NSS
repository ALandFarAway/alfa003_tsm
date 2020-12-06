
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
			
	SendMessageToPC(oPC, "Languags Known = " + IntToString(ACR_GetLangagesKnown( oPC )));
	
	SendMessageToPC(oPC, "Language Index 0 = " + ACR_GetLanguageAtIndex( oPC, 0));
	SendMessageToPC(oPC, "Language Index 1 = " + ACR_GetLanguageAtIndex( oPC, 1));
	SendMessageToPC(oPC, "Language Index 2 = " + ACR_GetLanguageAtIndex( oPC, 2));
	SendMessageToPC(oPC, "Language Index 3 = " + ACR_GetLanguageAtIndex( oPC, 3));
	SendMessageToPC(oPC, "Language Index 4 = " + ACR_GetLanguageAtIndex( oPC, 4));
	
	object oTool=DMFI_GetTool(oPC);
	string sLang = "lng_orc";
		 SendMessageToPC(oPC, "Equipped " + GetName(oItem));
		 if (DMFI_IsLanguageKnown(oPC, sLang) == FALSE)
				{DMFI_GrantLanguage(oPC, sLang);
				 SetLocalInt(oItem, "DMFI_TemporaryOrc", 1);
				}
			
					 
}			  