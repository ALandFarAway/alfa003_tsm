//Secondary script for all tsm execute scripts
//Wynna February 2009


#include "acr_creature_i"
#include "acr_xp_i"
#include "acr_quest_i"









void main()
{ object oWyvern = GetObjectByTag("abr_cr_dragon_wyvern_twisted_lg", 0);
  AssignCommand(oWyvern, ActionJumpToObject(GetWaypointByTag("WP_wyvern_lg_01"), TRUE));
  DelayCommand(2.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_01"), TRUE)));
  DelayCommand(4.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_02"), TRUE)));
  DelayCommand(6.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_03"), TRUE)));
  DelayCommand(8.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_04"), TRUE)));
  DelayCommand(10.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_05"), TRUE)));
  DelayCommand(12.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_06"), TRUE)));
  DelayCommand(14.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_07"), TRUE)));
  DelayCommand(16.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_08"), TRUE)));
  DelayCommand(18.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_09"), TRUE)));
  DelayCommand(20.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_10"), TRUE)));
  DelayCommand(22.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_11"), TRUE)));
  DelayCommand(24.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_12"), TRUE)));
  DelayCommand(26.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_13"), TRUE)));
  DelayCommand(28.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_14"), TRUE)));
  DelayCommand(30.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_15"), TRUE)));
  DelayCommand(32.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_16"), TRUE)));
  DelayCommand(34.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_17"), TRUE)));
  DelayCommand(36.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_18"), TRUE)));
  DelayCommand(38.0, AssignCommand(oWyvern, ActionJumpToObject(GetWaypointByTag("WP_wyvern_lg_19"), TRUE)));
  DelayCommand(40.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_20"), TRUE)));
  DelayCommand(42.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_21"), TRUE)));
  DelayCommand(44.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_22"), TRUE)));
  DelayCommand(46.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_23"), TRUE)));
  DelayCommand(48.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_24"), TRUE)));
  DelayCommand(50.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_25"), TRUE)));
  DelayCommand(52.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_26"), TRUE)));
  DelayCommand(54.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_27"), TRUE)));
  DelayCommand(56.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_28"), TRUE)));
  DelayCommand(58.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_29"), TRUE)));
  DelayCommand(60.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_30"), TRUE)));
  DelayCommand(62.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_31"), TRUE)));
  

}