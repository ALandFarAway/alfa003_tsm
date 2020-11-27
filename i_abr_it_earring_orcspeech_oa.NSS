
//Wynna November 2020

 
#include "acr_items_i"
#include "acr_db_persist_i"
#include "acr_quest_i"
#include "dmfi_inc_langexe" 


void main()
{	
	object oItem = GetModuleItemAcquired();
 	object oPC = GetModuleItemAcquiredBy();
	effect eSymbol = EffectVisualEffect(VFX_DUR_SPELL_SYMBOL_OF_DEATH, FALSE);
	effect ePurge = EffectVisualEffect(VFX_AOE_ETHEREAL_PURGE, FALSE);
			 
	object oTool=DMFI_GetTool(oPC);
	string sLang = "LNG_ORC";
	string sSuccess = "You speak " + sLang;
	string sFail = "You don't speak " + sLang;
	int nMod = GetAbilityModifier(ABILITY_INTELLIGENCE, oPC);
	int nLangs = GetSkillRank(SKILL_SPEAK_LANGUAGE, oPC, TRUE);
	
	int nBonus = GetLocalInt(oTool, "ACR_LANG_BONUSLANGUAGES");
	int nIntBonus = GetLocalInt(oTool, "ACR_LANG_INT_BONUS");
	 
	SendMessageToPC(oPC, "ACR_LANG_BONUSLANGUAGES=" + IntToString(nBonus));
	SendMessageToPC(oPC, "ACR_LANG_INT_BONUS=" + IntToString(nIntBonus));
	SendText(oPC, "SendText = " + PRM_ + TXT_TRANSLATED + DMFI_CapitalizeWord(sLang), FALSE, COLOR_GREY);
		

		 if (DMFI_IsLanguageKnown(oPC, sLang) == TRUE)
			{SendMessageToPC(oPC, sSuccess);
			}
			else
			{SendMessageToPC(oPC, sFail);
			
				if (DMFI_IsLanguageUnderstood( oPC, sLang))
				    {SendMessageToPC(oPC, "You UNDERSTAND " + sLang);}
				else {
			 	
					
			
					 DMFI_GrantLanguage(oPC, sLang);
					 if (DMFI_IsLanguageKnown(oPC, sLang) == TRUE)
						{SetLocalInt(oPC, "DMFI_TemporaryOrc", 1);
						 SendMessageToPC(oPC, "You have been temporarily GRANTED " + sLang);
						}
						else
						{SendMessageToPC(oPC, "Temporarily GRANTING " + sLang + " didn't grant.");
						}
						
					}
			 
			}
			
			
					 
}			  