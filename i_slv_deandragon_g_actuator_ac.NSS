#include "silvy_univ_inc"
#include "acr_spawn_i"
#include "acr_db_persist_i"
#include "silvy_univ_func"
#include "acr_quest_i"

void main()
{
             
//OnActivate Script  
	object oItem = GetItemActivated();
    object oUser = GetItemActivator();
    object oTarget = GetItemActivatedTarget();
	object oWP11 = GetWaypointByTag("WP_003_cr_slv_deandragon_golem_11");
	object oWP10 = GetWaypointByTag("WP_003_cr_slv_deandragon_golem_10");
	object oWP9 = GetWaypointByTag("WP_003_cr_slv_deandragon_golem_9");
	object oWP8 = GetWaypointByTag("WP_003_cr_slv_deandragon_golem_8");
	object oWP7 = GetWaypointByTag("WP_003_cr_slv_deandragon_golem_7");
	object oWP6 = GetWaypointByTag("WP_003_cr_slv_deandragon_golem_6");
	object oWP5 = GetWaypointByTag("WP_003_cr_slv_deandragon_golem_5");
	object oWP4 = GetWaypointByTag("WP_003_cr_slv_deandragon_golem_4");
	object oWP3 = GetWaypointByTag("WP_003_cr_slv_deandragon_golem_3");
	object oWP2 = GetWaypointByTag("WP_003_cr_slv_deandragon_golem_2");
	object oWP1 = GetWaypointByTag("WP_003_cr_slv_deandragon_golem_1");
	object oWP7b = GetWaypointByTag("slv_deandragon_g_7");
	object oWP6b = GetWaypointByTag("slv_deandragon_g_6");
	object oWP5b = GetWaypointByTag("slv_deandragon_g_5");
	object oWP4b = GetWaypointByTag("slv_deandragon_g_4");
	object oWP3b = GetWaypointByTag("slv_deandragon_g_3");
	object oWP2b = GetWaypointByTag("slv_deandragon_g_2");
	object oWP1b = GetWaypointByTag("slv_deandragon_g_1");
	
	if(((GetTag(oTarget) == "003_cr_slv_deandragon_golem")|| (GetTag(oTarget) == "003_slv_dq_g_creature")) && (GetDistanceBetween(oUser, oTarget) <= 5.0))
	   {if(ACR_RetrieveQuestState("slv_deandragon_g", oUser) == 2)
				{ACR_AddPersistentJournalQuestEntry("slv_deandragon_g", 3, oUser, 0, 0, 0, 0);
				}
		if(ACR_RetrieveQuestState("slv_deansphinx_g", oUser) == 2)
				{ACR_AddPersistentJournalQuestEntry("slv_deansphinx_g", 3, oUser, 0, 0, 0, 0);
				}
		AssignCommand(oTarget, ActionSpeakString("Actuator detected. Minimum usage distance compliance. Command valid. Return to creator.", TALKVOLUME_TALK));
		AssignCommand(oTarget, ActionJumpToLocation(GetLocation(oWP11)));
		DelayCommand(5.0, AssignCommand(oTarget, ActionSpeakString("Return to creator.", TALKVOLUME_TALK)));
		DelayCommand(5.0, AssignCommand(oTarget, ClearAllActions(TRUE)));
		DelayCommand(5.5, AssignCommand(oTarget, ActionJumpToLocation(GetLocation(oWP10))));
		DelayCommand(10.5, AssignCommand(oTarget, ClearAllActions(TRUE)));
		DelayCommand(11.0, AssignCommand(oTarget, ActionForceMoveToObject(oWP9, TRUE, 1.0)));
		DelayCommand(15.0, AssignCommand(oTarget, ActionSpeakString("Return to creator.", TALKVOLUME_TALK)));
		DelayCommand(16.0, AssignCommand(oTarget, ClearAllActions(TRUE)));
		DelayCommand(16.5, AssignCommand(oTarget, ActionForceMoveToObject(oWP8, TRUE, 1.0)));
		DelayCommand(21.5, AssignCommand(oTarget, ClearAllActions(TRUE)));
		DelayCommand(22.0, AssignCommand(oTarget, ActionForceMoveToObject(oWP7, TRUE, 1.0)));
		DelayCommand(25.0, AssignCommand(oTarget, ActionSpeakString("Return to creator.", TALKVOLUME_TALK)));
		DelayCommand(27.0, AssignCommand(oTarget, ClearAllActions(TRUE)));
		DelayCommand(27.5, AssignCommand(oTarget, ActionForceMoveToObject(oWP6, TRUE, 1.0)));
		DelayCommand(32.5, AssignCommand(oTarget, ClearAllActions(TRUE)));
		DelayCommand(33.0, AssignCommand(oTarget, ActionForceMoveToObject(oWP5, TRUE, 1.0)));
		DelayCommand(35.0, AssignCommand(oTarget, ActionSpeakString("Return to creator.", TALKVOLUME_TALK)));
		DelayCommand(38.0, AssignCommand(oTarget, ClearAllActions(TRUE)));
		DelayCommand(38.5, AssignCommand(oTarget, ActionForceMoveToObject(oWP4, TRUE, 1.0)));
		DelayCommand(43.5, AssignCommand(oTarget, ClearAllActions(TRUE)));
		DelayCommand(45.0, AssignCommand(oTarget, ActionSpeakString("Return to creator.", TALKVOLUME_TALK)));
		DelayCommand(45.5, AssignCommand(oTarget, ActionForceMoveToObject(oWP3, TRUE, 1.0)));
		DelayCommand(48.5, AssignCommand(oTarget, ClearAllActions(TRUE)));
		DelayCommand(50.0, AssignCommand(oTarget, ActionSpeakString("Return to creator.", TALKVOLUME_TALK)));
		DelayCommand(50.5, AssignCommand(oTarget, ActionForceMoveToObject(oWP2, TRUE, 1.0)));
		DelayCommand(54.0, AssignCommand(oTarget, ClearAllActions(TRUE)));
		DelayCommand(55.0, AssignCommand(oTarget, ActionSpeakString("Return to creator.", TALKVOLUME_TALK)));
		DelayCommand(56.5, AssignCommand(oTarget, ActionForceMoveToObject(oWP1, TRUE, 1.0)));
		DelayCommand(60.0, AssignCommand(oTarget, ClearAllActions(TRUE)));
		DelayCommand(61.0, AssignCommand(oTarget, ActionSpeakString("Return to creator.", TALKVOLUME_TALK)));
		DelayCommand(61.5, AssignCommand(oTarget, ActionJumpToLocation(GetLocation(oWP7b))));
		DelayCommand(62.0, AssignCommand(oTarget, ClearAllActions(TRUE)));
		DelayCommand(62.5, AssignCommand(oTarget, ActionSpeakString("Return to creator.", TALKVOLUME_TALK)));
		DelayCommand(65.5, AssignCommand(oTarget, ActionJumpToLocation(GetLocation(oWP6b))));
		DelayCommand(66.0, AssignCommand(oTarget, ClearAllActions(TRUE)));
		DelayCommand(66.5, AssignCommand(oTarget, ActionSpeakString("Return to creator.", TALKVOLUME_TALK)));
		DelayCommand(70.0, AssignCommand(oTarget, ActionJumpToLocation(GetLocation(oWP5b))));
		DelayCommand(70.5, AssignCommand(oTarget, ClearAllActions(TRUE)));
		DelayCommand(71.0, AssignCommand(oTarget, ActionSpeakString("Return to creator.", TALKVOLUME_TALK)));
		DelayCommand(74.5, AssignCommand(oTarget, ActionForceMoveToObject(oWP4b, TRUE, 1.0)));
		DelayCommand(78.0, AssignCommand(oTarget, ClearAllActions(TRUE)));
		DelayCommand(80.0, AssignCommand(oTarget, ActionSpeakString("Return to creator.", TALKVOLUME_TALK)));
		DelayCommand(83.5, AssignCommand(oTarget, ActionForceMoveToObject(oWP3b, TRUE, 1.0)));
		DelayCommand(84.0, AssignCommand(oTarget, ClearAllActions(TRUE)));
		DelayCommand(85.0, AssignCommand(oTarget, ActionSpeakString("Return to creator.", TALKVOLUME_TALK)));
		DelayCommand(88.5, AssignCommand(oTarget, ActionForceMoveToObject(oWP2b, TRUE, 1.0)));
		DelayCommand(90.0, AssignCommand(oTarget, ClearAllActions(TRUE)));
		DelayCommand(91.0, AssignCommand(oTarget, ActionSpeakString("Return to creator.", TALKVOLUME_TALK)));
		DelayCommand(93.5, AssignCommand(oTarget, ActionForceMoveToObject(oWP1b, TRUE, 1.0)));
		DelayCommand(98.0, AssignCommand(oTarget, ClearAllActions(TRUE)));
		DelayCommand(99.0, AssignCommand(oTarget, ActionSpeakString("Return to creator.", TALKVOLUME_TALK)));
		DestroyObject(oTarget, 100.0);
		}
	else if(((GetTag(oTarget) == "003_cr_slv_deandragon_golem")|| (GetTag(oTarget) == "003_slv_dq_g_creature")) && (GetDistanceBetween(oUser, oTarget) > 5.0))
	    {AssignCommand(oTarget, ActionSpeakString("Actuator detected. Minimum usage distance exceeded. Command invalid.", TALKVOLUME_TALK));
		}

}