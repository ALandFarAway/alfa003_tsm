//Silvy Uni Item onAcquire.  
//Wynna April 2015


#include "acr_items_i"
#include "acr_spawn_i"
#include "acr_tools_i"
#include "acr_db_persist_i"
#include "acr_quest_i"


void main()
{	object oTaker = GetModuleItemAcquiredBy();
	object oItem = GetModuleItemAcquired();
	object oBox = GetModuleItemLostBy();
	object oArea = GetArea(oTaker);
	
	if((GetTag(oItem) == "slv_deandragon_l_bg_asx") && (ACR_RetrieveQuestState("slv_deansphinx_l", oTaker) >= 5) && (ACR_RetrieveQuestState("slv_deansphinx_l", oTaker) <= 6) && ((GetIsPC(oTaker)) || (GetIsDMPossessed(oTaker))))
       {if(GetTag(GetModuleItemLostBy())=="slv_plc_skel_deandragon_l")
			{SendMessageToPC(oTaker, "You have found a hollow wooden rod inscribed with wavy lines on this body.");}
		if(ACR_RetrieveQuestState("slv_deansphinx_l", oTaker) == 6)
			{DelayCommand(20.0, ACR_AddPersistentJournalQuestEntry("slv_deansphinx_l", 7, oTaker, FALSE, FALSE, FALSE, FALSE));}
		object oGhostOld = GetObjectByTag("003_cr_un_doomguide",0);
		DestroyObject(oGhostOld);
		object oGhost = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_un_doomguide", GetLocation(oTaker));
		DelayCommand(3.9, AssignCommand(oGhost, ClearAllActions(TRUE)));
	    DelayCommand(4.0, AssignCommand(oGhost, ActionForceMoveToLocation(GetLocation(oTaker))));
		DelayCommand(5.0, SetPlotFlag(oGhost, FALSE));
		DelayCommand(5.9, AssignCommand(oGhost, ClearAllActions(TRUE)));
	    DelayCommand(6.0, AssignCommand(oGhost, ActionSpeakString("*Looses hands from throat to reach one of them out to point at the hollow wooden rod taken from the skeleton on the ground. He coughs and rasps out two words.*  Found.... Use.... *", TALKVOLUME_TALK)));
		}
}			  