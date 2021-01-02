//Secondary script for all tsm execute scripts
//Wynna February 2009


#include "acr_creature_i"
#include "acr_xp_i"
#include "acr_quest_i"


void main()
{ object oWyvern = GetObjectByTag("abr_cr_dragon_wyvern_twisted_lg", 0);
  object oMarp = GetObjectByTag("abr_cr_hu_marpenoth", 0);
  object oMin = GetObjectByTag("flbtr_plc_minotaur_statue", 0);
  object oStart = GetWaypointByTag("WP_wyvern_lg_01");
  object oAmnestria = GetObjectByTag("003_cr_elf_sun_amnestria", 0);
	object oRobed = GetObjectByTag("003_cr_circus_magician", 0);
	object oHalfOrcCleric = GetObjectByTag("003_cr_halforc_male", 0);
	object oCleric = GetObjectByTag("abr_cr_hu_orcclericheal", 0);
	object oClericTwo = GetObjectByTag("abr_cr_hu_orcclerichealTwo", 0);
	object oBattlePriest = GetObjectByTag("abr_cr_hu_orcbattlepriestOne", 0);
	object oBattlePriestTwo = GetObjectByTag("abr_cr_hu_orcbattlepriestTwo", 0);
	object oChieftain = GetObjectByTag("abr_cr_hu_orcchieftainOne", 0);
	object oBerserker = GetObjectByTag("abr_cr_hu_orcberserkerOne", 0);
	object oBerserkerTwo = GetObjectByTag("abr_cr_hu_orcberserkerTwo", 0);
	object oBerserkerThree = GetObjectByTag("abr_cr_hu_orcberserkerThree", 0);
	object oCaptain = GetObjectByTag("003_orc_captainOne", 0);
	object oCaptainTwo = GetObjectByTag("003_orc_captainTwo", 0);
	
  AssignCommand(oRobed, ActionMoveAwayFromObject(oStart, TRUE, 5.0));
  AssignCommand(oCleric, ActionMoveAwayFromObject(oStart, TRUE, 5.0));
  AssignCommand(oClericTwo, ActionMoveAwayFromObject(oStart, TRUE, 5.0));
  AssignCommand(oBattlePriest, ActionMoveAwayFromObject(oStart, TRUE, 5.0));
  AssignCommand(oBattlePriestTwo, ActionMoveAwayFromObject(oStart, TRUE, 2.0));
  AssignCommand(oChieftain, ActionMoveAwayFromObject(oStart, TRUE, 5.0));
  AssignCommand(oBerserker, ActionMoveAwayFromObject(oStart, TRUE, 5.0));
  AssignCommand(oBerserkerTwo, ActionMoveAwayFromObject(oStart, TRUE, 5.0));
  AssignCommand(oBerserkerThree, ActionMoveAwayFromObject(oStart, TRUE, 5.0));
  AssignCommand(oCaptain, ActionMoveAwayFromObject(oStart, TRUE, 5.0));
  AssignCommand(oCaptainTwo, ActionMoveAwayFromObject(oStart, TRUE, 5.0));
  
  AssignCommand(oWyvern, ActionJumpToObject(GetWaypointByTag("WP_wyvern_lg_01"), TRUE));
  DelayCommand(1.0, AssignCommand(oMarp, ActionJumpToObject(GetWaypointByTag("WP_wyvern_lg_01"), TRUE)));
  AssignCommand(oMarp, ActionSpeakString("*Grabs a spine on the wyvern's back and hauls himself up onto its back.", TALKVOLUME_TALK));
  //DelayCommand(2.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_01"), TRUE)));
  //DelayCommand(4.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_02"), TRUE)));
  DelayCommand(2.0, AssignCommand(oMarp, ActionSpeakString("*orc* I ascend, as Gruumsh said that I would! */orc*", TALKVOLUME_TALK)));
  DelayCommand(6.0, AssignCommand(oWyvern, ActionJumpToObject(GetWaypointByTag("WP_wyvern_lg_03"), TRUE)));
  DelayCommand(6.5, AssignCommand(oMarp, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_03"), TRUE)));
  //DelayCommand(8.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_04"), TRUE)));
  //DelayCommand(10.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_05"), TRUE)));
  DelayCommand(12.0, AssignCommand(oWyvern, ActionJumpToObject(GetWaypointByTag("WP_wyvern_lg_06"), TRUE)));
  DelayCommand(12.5, AssignCommand(oMarp, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_06"), TRUE)));
  //DelayCommand(14.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_07"), TRUE)));
  //DelayCommand(16.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_08"), TRUE)));
  DelayCommand(17.0, AssignCommand(oWyvern, ActionSpeakString("*Launches into the sky.", TALKVOLUME_TALK)));
  DelayCommand(18.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_09"), TRUE)));
  DelayCommand(18.5, AssignCommand(oMarp, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_09"), TRUE)));;
  DelayCommand(19.0, AssignCommand(oMarp, ActionSpeakString("*Lurches, fighting to hang on.", TALKVOLUME_TALK)));
  DelayCommand(18.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_10"), TRUE)));
  DelayCommand(20.5, AssignCommand(oMarp, ActionJumpToObject(oWyvern, TRUE)));
  DelayCommand(22.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_11"), TRUE)));
  DelayCommand(22.5, AssignCommand(oMarp, ActionJumpToObject(oWyvern, TRUE)));
  DelayCommand(24.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_12"), TRUE)));
  DelayCommand(24.5, AssignCommand(oMarp, ActionJumpToObject(oWyvern, TRUE)));
  DelayCommand(25.0, AssignCommand(oMin, ActionSpeakString("*The wyvern's wings buffet the air.", TALKVOLUME_TALK)));
  DelayCommand(26.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_13"), TRUE)));
  DelayCommand(26.5, AssignCommand(oMarp, ActionJumpToObject(oWyvern, TRUE)));
  DelayCommand(28.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_14"), TRUE)));
  DelayCommand(28.5, AssignCommand(oMarp, ActionJumpToObject(oWyvern, TRUE)));
  DelayCommand(30.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_15"), TRUE)));
  DelayCommand(30.5, AssignCommand(oMarp, ActionJumpToObject(oWyvern, TRUE)));
  DelayCommand(32.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_16"), TRUE)));
  DelayCommand(32.5, AssignCommand(oMarp, ActionJumpToObject(oWyvern, TRUE)));
  DelayCommand(34.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_17"), TRUE)));
  DelayCommand(34.5, AssignCommand(oMarp, ActionJumpToObject(oWyvern, TRUE)));
  DelayCommand(36.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_18"), TRUE)));
  DelayCommand(36.5, AssignCommand(oMarp, ActionJumpToObject(oWyvern, TRUE)));
  DelayCommand(37.0, AssignCommand(oMin, ActionSpeakString("*The wyvern plummets, spiraling out of sight beneath the rim of the plateau.", TALKVOLUME_TALK)));
  DelayCommand(44.0, AssignCommand(oWyvern, ActionJumpToObject(GetWaypointByTag("WP_wyvern_lg_19"), TRUE)));
  DelayCommand(44.5, AssignCommand(oMarp, ActionJumpToObject(oWyvern, TRUE)));
  DelayCommand(45.0, AssignCommand(oMin, ActionSpeakString("*Wings beating, the wyvern lunges into view on the other side of the plateau, climbing higher.", TALKVOLUME_TALK)));
  DelayCommand(46.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_20"), TRUE)));
  DelayCommand(46.5, AssignCommand(oMarp, ActionJumpToObject(oWyvern, TRUE)));
  DelayCommand(48.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_21"), TRUE)));
  DelayCommand(48.5, AssignCommand(oMarp, ActionJumpToObject(oWyvern, TRUE)));
  DelayCommand(50.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_22"), TRUE)));
  DelayCommand(50.5, AssignCommand(oMarp, ActionJumpToObject(oWyvern, TRUE)));
  DelayCommand(52.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_23"), TRUE)));
  DelayCommand(52.5, AssignCommand(oMarp, ActionJumpToObject(oWyvern, TRUE)));
  DelayCommand(53.0, AssignCommand(oMin, ActionSpeakString("*The huge orc bellow in orcish: *orc* Descend, beast! Take me down! */orc*", TALKVOLUME_TALK)));
  DelayCommand(54.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_24"), TRUE)));
  DelayCommand(54.5, AssignCommand(oMarp, ActionJumpToObject(oWyvern, TRUE)));
  DelayCommand(56.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_25"), TRUE)));
  DelayCommand(56.5, AssignCommand(oMarp, ActionJumpToObject(oWyvern, TRUE)));
  DelayCommand(58.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_26"), TRUE)));
  DelayCommand(58.5, AssignCommand(oMarp, ActionJumpToObject(oWyvern, TRUE)));
  DelayCommand(60.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_27"), TRUE)));
  DelayCommand(60.5, AssignCommand(oMarp, ActionJumpToObject(oWyvern, TRUE)));
  DelayCommand(62.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_28"), TRUE)));
  DelayCommand(62.5, AssignCommand(oMarp, ActionJumpToObject(oWyvern, TRUE)));
  DelayCommand(64.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_29"), TRUE)));
  DelayCommand(64.5, AssignCommand(oMarp, ActionJumpToObject(oWyvern, TRUE)));
  DelayCommand(66.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_30"), TRUE)));
  DelayCommand(66.5, AssignCommand(oMarp, ActionJumpToObject(oWyvern, TRUE)));
  DelayCommand(68.0, AssignCommand(oWyvern, ActionForceMoveToObject(GetWaypointByTag("WP_wyvern_lg_31"), TRUE)));
  DelayCommand(68.0, AssignCommand(oMarp, ActionJumpToObject(oWyvern, TRUE)));
  DelayCommand(69.5, AssignCommand(oMin, ActionSpeakString("*The wyvern and rider clinging to it somewhat desperately dwindle rapidly in the distance, arrowing off to the northwest.", TALKVOLUME_TALK)));
  DelayCommand(70.0, AssignCommand(oMin, ActionSpeakString("*An orcish shout drifts back to you: *orc* Take...me...baaaaackkkk! */orc*", TALKVOLUME_TALK)));
  DelayCommand(72.0, DestroyObject(oWyvern));
  DelayCommand(72.0, DestroyObject(oMarp));

}