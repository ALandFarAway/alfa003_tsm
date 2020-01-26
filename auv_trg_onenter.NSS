//Silvy Uni Trigger OnEnter. All triggers.
//Wynna September 2007


#include "silvy_univ_inc"
#include "silvy_univ_func"
#include "acr_trigger_i"
#include "acr_spawn_i"
#include "acr_tools_i"
#include "acr_quest_i"
 
void main()
{	
	ACR_TriggerOnEnter();
	object oHarvester = GetEnteringObject();
    object oMod = GetModule();
	

 if((GetIsPC(oHarvester) != TRUE) && (GetIsDMPossessed(oHarvester) != TRUE))
		{return;}
		
	

				     				     		
			  //Thorns
			    if((GetTag(OBJECT_SELF) == "deandragon_d_thorns") && (GetLocalString(oHarvester, "Thorns") != "Out"))
					{if(ACR_RetrieveQuestState("slv_deandragon_d", oHarvester) == 5)
						{ACR_AddPersistentJournalQuestEntry("slv_deandragon_d", 6, oHarvester);
						}
					if(ACR_RetrieveQuestState("slv_dragonberry", oHarvester) == 2)
						{ACR_AddPersistentJournalQuestEntry("slv_dragonberry", 3, oHarvester);
						}
					SetLocalString(oHarvester, "Thorns", "In");
					 if(GetLocalString(oHarvester, "Thorns") == "In")	 
					 	{if(GetHasSpellEffect(SPELL_MAGE_ARMOR, oHarvester)) 
						        {SendMessageToPC(oHarvester, "The thorns and spines seem to deflect, miss or simply fail to pierce your flesh.");
					         }
						 else if (!GetHasSpellEffect(SPELL_MAGE_ARMOR, oHarvester))
					         {effect eThorns = EffectDamage(1, DAMAGE_TYPE_PIERCING, DAMAGE_POWER_NORMAL);
		    				  SendMessageToPC(oHarvester, "Thorns and spines threaten to pierce your flesh with every movement, somehow finding their way around armor and clothing to whatever flesh is exposed.");
					               if(Random(10) < 5)
					                  {ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eThorns, oHarvester);
					                   SendMessageToPC(oHarvester, "A thorn is driven deep into your flesh.");
					                  }
					         }
						DelayCommand(5.0, ExecuteScript("auv_trg_onenter", oHarvester));
						}
					}
   
}