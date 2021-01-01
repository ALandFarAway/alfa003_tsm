//Secondary script for all tsm execute scripts
//Wynna February 2009


#include "acr_creature_i"
#include "acr_xp_i"
#include "acr_quest_i"


void main()
{ object oWyvern = GetObjectByTag("abr_cr_dragon_wyvern_twisted_lg", 0);
  object oMarp = GetObjectByTag("abr_cr_hu_marpenoth", 0);
  object oMin = GetObjectByTag("flbtr_plc_minotaur_statue", 0);
  AssignCommand(oWyvern, ActionJumpToObject(GetWaypointByTag("WP_wyvern_lg_01"), TRUE));
  AssignCommand(oMarp, ActionJumpToObject(GetWaypointByTag("WP_wyvern_lg_01"), TRUE));
  AssignCommand(oMarp, ActionSpeakString("*Grabs a spine on the wyvern's back and hauls himself up onto its back.", TALKVOLUME_TALK));
  //DelayCommand(2.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_01"), TRUE)));
  //DelayCommand(4.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_02"), TRUE)));
  DelayCommand(2.0, AssignCommand(oWyvern, ActionSpeakString("*orc* I ascend, as Gruumsh said that I would! */orc*", TALKVOLUME_TALK)));
  DelayCommand(6.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_03"), TRUE)));
  DelayCommand(6.0, AssignCommand(oMarp, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_03"), TRUE)));
  //DelayCommand(8.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_04"), TRUE)));
  //DelayCommand(10.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_05"), TRUE)));
  DelayCommand(12.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_06"), TRUE)));
  DelayCommand(12.0, AssignCommand(oMarp, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_06"), TRUE)));
  //DelayCommand(14.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_07"), TRUE)));
  //DelayCommand(16.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_08"), TRUE)));
  DelayCommand(17.0, AssignCommand(oWyvern, ActionSpeakString("*Launches into the sky.", TALKVOLUME_TALK)));
  DelayCommand(18.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_09"), TRUE)));
  DelayCommand(18.0, AssignCommand(oMarp, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_09"), TRUE)));
  DelayCommand(20.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_10"), TRUE)));
  DelayCommand(20.0, AssignCommand(oMarp, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_10"), TRUE)));
  DelayCommand(22.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_11"), TRUE)));
  DelayCommand(22.0, AssignCommand(oMarp, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_11"), TRUE)));
  DelayCommand(24.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_12"), TRUE)));
  DelayCommand(24.0, AssignCommand(oMarp, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_12"), TRUE)));
  DelayCommand(25.0, AssignCommand(oMin, ActionSpeakString("*The wyvern's wings buffet the air.", TALKVOLUME_TALK)));
  DelayCommand(26.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_13"), TRUE)));
  DelayCommand(26.0, AssignCommand(oMarp, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_13"), TRUE)));
  DelayCommand(28.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_14"), TRUE)));
  DelayCommand(28.0, AssignCommand(oMarp, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_14"), TRUE)));
  DelayCommand(30.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_15"), TRUE)));
  DelayCommand(30.0, AssignCommand(oMarp, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_15"), TRUE)));
  DelayCommand(32.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_16"), TRUE)));
  DelayCommand(32.0, AssignCommand(oMarp, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_16"), TRUE)));
  DelayCommand(34.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_17"), TRUE)));
  DelayCommand(34.0, AssignCommand(oMarp, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_17"), TRUE)));
  DelayCommand(36.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_18"), TRUE)));
  DelayCommand(36.0, AssignCommand(oMarp, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_18"), TRUE)));
  DelayCommand(37.0, AssignCommand(oMin, ActionSpeakString("*The wyvern plummets, spiraling out of sight beneath the rim of the plateau.", TALKVOLUME_TALK)));
  DelayCommand(44.0, AssignCommand(oWyvern, ActionJumpToObject(GetWaypointByTag("WP_wyvern_lg_19"), TRUE)));
  DelayCommand(44.0, AssignCommand(oMarp, ActionJumpToObject(GetWaypointByTag("WP_wyvern_lg_19"), TRUE)));
  DelayCommand(45.0, AssignCommand(oWyvern, ActionSpeakString("*Wings beating, the wyvern lunges into view on the other side of the plateau, climbing higher.", TALKVOLUME_TALK)));
  DelayCommand(46.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_20"), TRUE)));
  DelayCommand(46.0, AssignCommand(oMarp, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_20"), TRUE)));
  DelayCommand(48.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_21"), TRUE)));
  DelayCommand(48.0, AssignCommand(oMarp, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_21"), TRUE)));
  DelayCommand(50.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_22"), TRUE)));
  DelayCommand(50.0, AssignCommand(oMarp, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_22"), TRUE)));
  DelayCommand(52.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_23"), TRUE)));
  DelayCommand(52.0, AssignCommand(oMarp, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_23"), TRUE)));
  DelayCommand(53.0, AssignCommand(oMin, ActionSpeakString("*The huge orc bellow in orcish: *orc* Descend, beast! Take me down! */orc*", TALKVOLUME_TALK)));
  DelayCommand(54.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_24"), TRUE)));
  DelayCommand(54.0, AssignCommand(oMarp, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_24"), TRUE)));
  DelayCommand(56.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_25"), TRUE)));
  DelayCommand(56.0, AssignCommand(oMarp, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_25"), TRUE)));
  DelayCommand(58.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_26"), TRUE)));
  DelayCommand(58.0, AssignCommand(oMarp, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_26"), TRUE)));
  DelayCommand(60.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_27"), TRUE)));
  DelayCommand(60.0, AssignCommand(oMarp, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_27"), TRUE)));
  DelayCommand(62.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_28"), TRUE)));
  DelayCommand(62.0, AssignCommand(oMarp, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_28"), TRUE)));
  DelayCommand(64.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_29"), TRUE)));
  DelayCommand(64.0, AssignCommand(oMarp, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_29"), TRUE)));
  DelayCommand(66.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_30"), TRUE)));
  DelayCommand(66.0, AssignCommand(oMarp, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_30"), TRUE)));
  DelayCommand(68.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_31"), TRUE)));
  DelayCommand(68.0, AssignCommand(oMarp, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_31"), TRUE)));
  DelayCommand(69.0, AssignCommand(oMin, ActionSpeakString("*The wyvern and rider clinging to it somewhat desperately dwindle rapidly in the distance, arrowing off to the northwest.", TALKVOLUME_TALK)));
  DelayCommand(70.0, AssignCommand(oMin, ActionSpeakString("*An orcish shout drifts back to you: *orc* Take...me...baaaaackkkk! */orc*", TALKVOLUME_TALK)));
  DelayCommand(72.0, DestroyObject(oWyvern));
  DelayCommand(72.0, DestroyObject(oMarp));

}