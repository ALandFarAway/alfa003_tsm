
//Wynna November 2020

 
#include "acr_items_i"
#include "acr_db_persist_i"
#include "acr_quest_i"
#include "dmfi_inc_langexe" 
#include "x2_inc_itemprop"

void main()
{	
	object oItem = GetPCItemLastUnequipped();
 	object oPC = GetPCItemLastUnequippedBy();
			 
	object oTool=DMFI_GetTool(oPC);
	string sLang = "orc";
		
	SendMessageToPC(oPC, "Unequipped " + GetName(oItem));
		 
	 if ((DMFI_IsLanguageKnown(oPC, sLang) == TRUE) && (GetLocalInt(oItem, "DMFI_TemporaryOrc") == 1));
						
				{SendMessageToPC(oPC, "You have lost the ability to speak " + sLang);
				 DMFI_RemoveLanguage(oPC, sLang);
				 SetLocalInt(oItem, "DMFI_TemporaryOrc",0);	
				}
						
					
			 
			
			
			
					 
}			  