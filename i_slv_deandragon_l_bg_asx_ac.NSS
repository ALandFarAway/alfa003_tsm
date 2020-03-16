
//Wynna April 2015

 
#include "acr_items_i"
#include "acr_db_persist_i"
#include "acr_quest_i"
#include "acr_trigger_i"


void ACR_ApplyNLDDamageToCreature(object oTarget, int nSubdualDamage)
{
    int nNLDTotal = _GetNLDTotal(oTarget);
    int nHPMax = GetMaxHitPoints(oTarget);
    int nCap = nHPMax + 10;
    nNLDTotal = ((nNLDTotal + nSubdualDamage) > nCap) ? nCap :
            nNLDTotal + nSubdualDamage;
    _SetNLDTotal(oTarget, nNLDTotal);
    ACR_ApplyNLDEffects(oTarget, nNLDTotal);
}

void main()
{	
	object oItem = GetItemActivated();
 	object oStudent = GetItemActivator();
	object oTarget = GetItemActivatedTarget();
	effect eParalyze = EffectParalyze(30, SAVING_THROW_WILL, FALSE);
	effect eSymbol = EffectVisualEffect(VFX_DUR_SPELL_SYMBOL_OF_DEATH, FALSE);
	effect ePurge = EffectVisualEffect(VFX_AOE_ETHEREAL_PURGE, FALSE);
	effect eKnockdown = EffectKnockdown();
			 
	if(GetTag(oTarget)=="003_cr_un_doomguide")
		{SetPlotFlag(oTarget, FALSE);
		 if((ACR_RetrieveQuestState("slv_deansphinx_l", oStudent) == 7)|| (GetIsDMPossessed(oStudent)))
			{ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eParalyze, oTarget, 18.0);
			ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSymbol, oTarget, 18.0);
			ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePurge, oTarget, 25.0);
			AssignCommand(oTarget, ActionSpeakString("*The ghost of Doomguide Rafel Longtongue is flung back by the gentlest of drafts from the mouth of the wooden rod.", TALKVOLUME_TALK));
			DelayCommand(5.0, AssignCommand(oTarget, ActionSpeakString("*Battling what feels to you to be a tiny breeze, hunching into it as into a gale, the ghost forges upright, losing bits of ectoplasm to the storm that touches only it.", TALKVOLUME_TALK)));
			DelayCommand(10.0, AssignCommand(oTarget, ActionSpeakString("*Tattering, beginning to fade already, it slowly removes its hands from around its throat.", TALKVOLUME_TALK)));
			DelayCommand(15.0, AssignCommand(oTarget, ActionSpeakString("*In a voice that all present hear in their own language, it speaks.* THANK YOU. I AM FREE TO GO HOME.", TALKVOLUME_TALK)));
			DelayCommand(20.0, AssignCommand(oTarget, ActionSpeakString("*It shreds in the wind, and blows away.*", TALKVOLUME_TALK)));
			if(ACR_RetrieveQuestState("slv_deansphinx_l", oStudent) == 7)
				{DelayCommand(20.0, ACR_AddPersistentJournalQuestEntry("slv_deansphinx_l", 8, oStudent, FALSE, FALSE, FALSE, FALSE));}
		 	DestroyObject(oTarget, 22.0);
			}
		}
	
	
	else if((GetObjectType(oTarget) == OBJECT_TYPE_PLACEABLE) && ((GetTag(oTarget)== "HSS_CAMPFIRE_01") ||(FindSubString(GetTag(oTarget), "CAMPFIRE") != -1)||(FindSubString(GetTag(oTarget), "BONFIRE") != -1)))
			{SetPlotFlag(oTarget, FALSE);
			 DestroyObject(oTarget, 22.0);
			}
		
		
    else if((GetTag(oTarget) == "slv_firestarter") && (GetObjectType(oTarget) == OBJECT_TYPE_PLACEABLE))
			{object oMyFire = GetNearestObjectByTag("slv_firestarter_Fire", oTarget, 1);
			 object oFireSound = GetNearestObjectByTag("Campfire");
			 if(GetDistanceBetween(oMyFire, oTarget) < 10.0)
				{DestroyObject(oMyFire);
				 SoundObjectStop(oFireSound);	
				}
			}
	else
	   {int nSubdue=3*(Random(8) +1);
	    AssignCommand(oStudent, ActionCastSpellAtObject(SPELL_GUST_OF_WIND, oTarget, METAMAGIC_NONE, 1, 3, PROJECTILE_PATH_TYPE_DEFAULT, 1));
				 
		if((GetCreatureSize(oTarget) == CREATURE_SIZE_SMALL) ||(GetCreatureSize(oTarget) == CREATURE_SIZE_TINY)  || (GetTag(oTarget) == "003_cr_deanphoenix_air_marly") || (GetTag(oTarget) == "003_cr_circus_pegasus") || (GetTag(oTarget) == "003_cr_deanphoenix_air") || (GetTag(oTarget) == "abr_cr_el_airweird") || (GetTag(oTarget) == "003_cr_el_air"))
			{if(Random(4)<2)
				{ACR_ApplyNLDDamageToCreature(oTarget, nSubdue);
				 ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnockdown, oTarget, 3.0);
				 }
			}
		
		else if((GetSubRace(oTarget)==RACIAL_SUBTYPE_FIRE_GENASI)  || (GetTag(oTarget) == "003_cr_deanphoenix_fire")|| (GetTag(oTarget) == "abr_cr_mb_phoenix")|| (GetTag(oTarget) == "003_cr_mephit_fire")  || (GetTag(oTarget) == "003_cr_slv_incinder") || (GetTag(oTarget) == "003_cr_el_fire") || (GetTag(oTarget) == "c_firemephit") || (GetTag(oTarget) == "003_cr_mystra_firewd") || (GetTag(oTarget) == "003_cr_mystra_fireel") || (GetTag(oTarget) == "abr_cr_el_firebat")  || (GetTag(oTarget) == "abr_cr_el_fireweird") || (GetTag(oTarget) == "c_impfire"))
			{if(Random(4)<1)
				{ACR_ApplyNLDDamageToCreature(oTarget, nSubdue);
				 ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnockdown, oTarget, 3.0);
				 int nSuffocate = Random(8) + 1;
				 effect eSuffocate = EffectDamage(nSuffocate, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_NORMAL, FALSE);
				 }
			}
		
		if((GetTag(oTarget) == "003_cr_el_air")|| (GetTag(oTarget) == "c_elmair"))
			{int iRandom = Random(4);
			 if(iRandom==1)
			 	{effect eParalyze = EffectMovementSpeedDecrease(75);
				SendMessageToPC(oStudent, "The air elemental slows.");
			 	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eParalyze, oTarget, 10.0);
			 	DelayCommand(10.0, RemoveEffect(oTarget, eParalyze));
			 	}
			 else if(iRandom==2)
			 	{SendMessageToPC(oStudent, "The air elemental stops.");
			 	 AssignCommand(oTarget, ClearAllActions(TRUE));
				 }
			 else
			 	{SendMessageToPC(oStudent, "The air elemental swerves.");
			     AssignCommand(oTarget, ActionMoveAwayFromObject(oStudent, TRUE, 15.0f));
				 }
			 
			}
			
			
		
			
	 }
			
					 
}			  