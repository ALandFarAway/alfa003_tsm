//Silvy Uni Trigger OnExit
//Wynna September 2007


#include "silvy_univ_inc"
#include "silvy_univ_func"
#include "acr_trigger_i"
#include "acr_spawn_i"
#include "acr_tools_i"

void main()
{
	ACR_TriggerOnExit();
    object oArea = GetArea(OBJECT_SELF);
	object oStudent = GetExitingObject();
    object oMyDoorTrig=GetNearestObjectByTag("slv_dorm", oStudent, 1);
	object oMyDoor=GetObjectByTag(GetName(oMyDoorTrig)  + "_Door", 0);
	object oJacob=GetObjectByTag(GetName(oMyDoorTrig) + "_JacobsLadder", 0);
	
	
	// Enchantment NPC
					
				if(((GetTag(OBJECT_SELF) == "Enchantment2_trig") || (GetTag(OBJECT_SELF) == "Enchantment3_trig")) && (GetTag(oStudent) == "003_cr_slv_enc100giant"))
						{int nSchool = GetSilvyUniversitySchool(OBJECT_SELF);
						 string sSchool = SchoolToString(nSchool);
						 string sPrefix = GetStringLeft(sSchool, 3);
						 string sLevel = "200";
						 object oMyTrigAll = GetLocalObject(OBJECT_SELF, "Enc_All");
						 if(oMyTrigAll == OBJECT_INVALID)
							{oMyTrigAll = GetNearestObjectByTag("slv_in22.00", OBJECT_SELF, 1);
							 SetLocalObject(OBJECT_SELF, "Enc_All", oMyTrigAll);
						    }
						 object oMyTrig2 = GetLocalObject(OBJECT_SELF, sSchool + "2_trig");
						 if (oMyTrig2 == OBJECT_INVALID)
							{oMyTrig2 = GetObjectByTag( sSchool + "2_trig");
							 SetLocalObject(OBJECT_SELF,  sSchool + "2_trig", oMyTrig2);
							 }
						 object oMyTrig3 = GetLocalObject(OBJECT_SELF, sSchool + "3_trig");
						 if (oMyTrig3 == OBJECT_INVALID)
							{oMyTrig3 = GetObjectByTag( sSchool + "3_trig");
							 SetLocalObject(OBJECT_SELF,  sSchool + "3_trig", oMyTrig3);
							 }
						 object oMyCollBox2WP = GetLocalObject(OBJECT_SELF, "oMyCollBox2WP");
						 if (oMyCollBox2WP == OBJECT_INVALID)
							{oMyCollBox2WP = GetWaypointByTag("Enchantment2_trig_CollBox_WP");
							 SetLocalObject(OBJECT_SELF, "oMyCollBox2WP", oMyCollBox2WP);
							 }
						 object oMyCollBox3WP = GetLocalObject(OBJECT_SELF,"oMyCollBox3WP");
						 if (oMyCollBox3WP == OBJECT_INVALID)
							{oMyCollBox3WP = GetObjectByTag("Enchantment3_trig_CollBox_WP");
							 SetLocalObject(OBJECT_SELF, "oMyCollBox3WP", oMyCollBox3WP);
							 }
						 object oMyCollBox2 = GetLocalObject(OBJECT_SELF, "oMyCollBox2");
						 if (oMyCollBox2 == OBJECT_INVALID)
							{oMyCollBox2 = GetObjectByTag(sSchool + "2_trig_CollBox200");
							 if((oMyCollBox2 == OBJECT_INVALID) && (GetTag(OBJECT_SELF) == "Enchantment2_trig"))
							 	{oMyCollBox2 = CreateObject(OBJECT_TYPE_PLACEABLE, "slv_collbox2", GetLocation(oMyCollBox2WP), FALSE, GetTag(OBJECT_SELF) + "_CollBox200");
						 		 SetLocalObject(OBJECT_SELF, "oMyCollBox2", oMyCollBox2);
							 	 SetLocalObject(OBJECT_SELF, "oMyCollBox", oMyCollBox2);
							 	 SetLocalObject(oMyTrig3, "oMyCollBox2", oMyCollBox2);
						 		SetLocalObject(oMyTrigAll, "oMyCollBox2", oMyCollBox2);
						 		}
							 }
						 object oMyCollBox3 = GetLocalObject(OBJECT_SELF, "oMyCollBox3");
						 if (oMyCollBox3 == OBJECT_INVALID)
							{oMyCollBox3 = GetObjectByTag(sSchool + "3_trig_CollBox300");
							 if((oMyCollBox3 == OBJECT_INVALID) && (GetTag(OBJECT_SELF) == "Enchantment3_trig"))
							 	{oMyCollBox3 = CreateObject(OBJECT_TYPE_PLACEABLE, "slv_collbox2", GetLocation(oMyCollBox2WP), FALSE, GetTag(OBJECT_SELF) + "_CollBox300");
						 		 SetLocalObject(OBJECT_SELF, "oMyCollBox3", oMyCollBox3);
							 	 SetLocalObject(OBJECT_SELF, "oMyCollBox", oMyCollBox3);
							 	 SetLocalObject(oMyTrig2, "oMyCollBox3", oMyCollBox3);
						 		SetLocalObject(oMyTrigAll, "oMyCollBox3", oMyCollBox3);
						 		}
							 }
						 }
						
	
	// Illusion NPC
					
				if((GetTag(OBJECT_SELF) == "Ill_Boy_Destroy")  && (GetTag(oStudent) == "003_cr_slv_ill100boy"))
						{int nSchool = GetSilvyUniversitySchool(OBJECT_SELF);
						 string sSchool = SchoolToString(nSchool);
						 string sPrefix = GetStringLeft(sSchool, 3);
						 string sLevel = "200";
						 object oMyTrigAll = GetLocalObject(OBJECT_SELF, "Ill_All");
						 if(oMyTrigAll == OBJECT_INVALID)
							{oMyTrigAll = GetNearestObjectByTag("slv_in22.00", OBJECT_SELF, 1);
							 SetLocalObject(OBJECT_SELF, "Ill_All", oMyTrigAll);
						    }
						 object oMyTrig2 = GetLocalObject(OBJECT_SELF, "oMyTrig2");
						 if (oMyTrig2 == OBJECT_INVALID)
							{oMyTrig2 = GetObjectByTag( sSchool + "2_trig");
							 SetLocalObject(OBJECT_SELF,  "oMyTrig2", oMyTrig2);
							 }
						 object oMyTrig3 = GetLocalObject(OBJECT_SELF, "oMyTrig3");
						 if (oMyTrig3 == OBJECT_INVALID)
							{oMyTrig3 = GetObjectByTag( sSchool + "3_trig");
							 SetLocalObject(OBJECT_SELF,  "oMyTrig3", oMyTrig3);
							 }
						 object oMyForcewall03 = GetLocalObject(oMyTrigAll, "oMyForcewall03");
						 if (oMyForcewall03 == OBJECT_INVALID)
								{oMyForcewall03 = GetObjectByTag("Ill2_Forcewall03");
								 SetLocalObject(oMyTrigAll, "oMyForcewall03", oMyForcewall03);
								  }
						  object oMyBear = GetLocalObject(oMyTrigAll, "oMyBear");
						 if (oMyBear == OBJECT_INVALID)
							{oMyBear = GetObjectByTag("003_cr_slv_ill100cub");
						 	 SetLocalObject(oMyTrigAll, "oMyBear", oMyBear);
							 }
						 object oMyCollBox2WP = GetLocalObject(OBJECT_SELF, "oMyCollBox2WP");
						 if (oMyCollBox2WP == OBJECT_INVALID)
							{oMyCollBox2WP = GetWaypointByTag("Illusion2_trig_CollBox_WP");
							 SetLocalObject(OBJECT_SELF, "oMyCollBox2WP", oMyCollBox2WP);
							 }
						 object oMyCollBox2 = GetLocalObject(oMyTrigAll, "oMyCollBox2");
						 if (oMyCollBox2 == OBJECT_INVALID)
							{oMyCollBox2 = GetObjectByTag(sSchool + "2_trig_CollBox200");
							 if(oMyCollBox2 == OBJECT_INVALID)  
							 	{oMyCollBox2 = CreateObject(OBJECT_TYPE_PLACEABLE, "slv_collbox2", GetLocation(oMyCollBox2WP), FALSE, "Illusion2_trig_CollBox200");
						 		}
							 }
						 SetLocalObject(oMyTrigAll, "oMyCollBox2", oMyCollBox2);
						 SetLocalObject(oMyTrig2, "oMyCollBox", oMyCollBox2);
						 SetLocalObject(oMyTrig2, "oMyCollBox2", oMyCollBox2);
						 SetLocalObject(oMyTrig3, "oMyCollBox2", oMyCollBox2);
						 AssignCommand(oStudent, ActionForceMoveToObject(oMyForcewall03, TRUE, 0.0));
		 				 AssignCommand(oMyBear, ActionForceMoveToObject(oMyForcewall03, TRUE, 0.0));
		 				  }
						 
if((GetIsPC(oStudent) != TRUE) && (GetIsDMPossessed(oStudent) != TRUE))
		{return;}
	

if((GetTag(OBJECT_SELF) == "slv_dorm_in") || (GetTag(OBJECT_SELF) == "slv_dorm_master_in"))
	 {
	  object oMyArmoire=GetLocalObject(oMyDoorTrig, GetName(oMyDoorTrig) + "_Armoire");
	  object oMyBench=GetLocalObject(oMyDoorTrig, GetName(oMyDoorTrig) + "_Bench");
	  object oMyBookshelf=GetLocalObject(oMyDoorTrig, GetName(oMyDoorTrig) + "_Bookshelf");
	  object oMyChair=GetLocalObject(oMyDoorTrig, GetName(oMyDoorTrig) + "_Chair");
	  object oMyChair2=GetLocalObject(oMyDoorTrig, GetName(oMyDoorTrig) + "_Chair2");
	  object oMyChest=GetLocalObject(oMyDoorTrig, GetName(oMyDoorTrig) + "_Chest");
	  object oMyCurtainPull=GetLocalObject(oMyDoorTrig, GetName(oMyDoorTrig) + "_CurtainPull");
	  object oMyDesk=GetLocalObject(oMyDoorTrig, GetName(oMyDoorTrig) + "_Desk");
	  object oMyFireStarter=GetLocalObject(oMyDoorTrig, GetName(oMyDoorTrig) + "_Firestarter");
	  object oMyStool=GetLocalObject(oMyDoorTrig, GetName(oMyDoorTrig) + "_Stool");
	  object oMySofa=GetLocalObject(oMyDoorTrig, GetName(oMyDoorTrig) + "_Sofa");
	  object oMySofa2=GetLocalObject(oMyDoorTrig, GetName(oMyDoorTrig) + "_Sofa2");
	  object oMyCenterWP=GetWaypointByTag(GetName(oMyDoorTrig) + "_Center_WP");
	  object oMyStudyWP=GetLocalObject(oMyDoorTrig, GetName(oMyDoorTrig) + "_Study_WP");
	  object oMyBedroomWP=GetLocalObject(oMyDoorTrig, GetName(oMyDoorTrig) + "_Bedroom_WP");
	  object oNearestCreatureCenter=GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, oMyCenterWP, 1);
	  object oNearestCreatureStudy=GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, oMyStudyWP, 1);
	  object oNearestCreatureBedroom=GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, oMyBedroomWP, 1);
	  if(oNearestCreatureCenter == OBJECT_INVALID)
	  	{oNearestCreatureCenter = oStudent;}	
	
	  if(((GetDistanceBetween(oMyCenterWP, oNearestCreatureCenter) > 6.15) && (GetDistanceBetween(oMyStudyWP, oNearestCreatureStudy) > 2.5) && (GetDistanceBetween(oMyBedroomWP, oNearestCreatureBedroom) > 3.15)))
	  
	 	{object oMyArmoireStatic = CreateObject(OBJECT_TYPE_PLACEABLE, "slv_armoire2", GetLocation(oMyArmoire), FALSE, GetName(oMyDoorTrig) + "_Armoire_Static");
		 object oMyChestStatic = CreateObject(OBJECT_TYPE_PLACEABLE, "slv_chest2", GetLocation(oMyChest), FALSE, GetName(oMyDoorTrig) + "_Chest_Static");
		 object oMyRoof = CreateObject(OBJECT_TYPE_PLACEABLE, "slv_towerroof",  GetLocation(GetLocalObject(oMyDoorTrig, GetName(oMyDoorTrig) + "_Roof_WP")), FALSE, GetName(oMyDoorTrig) + "_Roof");
         SetLocalObject(oMyDoorTrig, GetName(oMyDoorTrig) + "_Armoire_Static", oMyArmoireStatic);
		 SetLocalObject(oMyDoorTrig, GetName(oMyDoorTrig) + "_Chest_Static", oMyChestStatic);
		 SetLocalObject(oMyDoorTrig, GetName(oMyDoorTrig) + "_Roof", oMyRoof);
		 ACR_SetIsSpawnPointEnabled(GetLocalObject(oMyDoorTrig, "MasterSpawn"), FALSE, TRUE);
		 }
		 
	 if ((GetTag(oArea) == "6d_int_silvy_ladycol_master_lvl") && (GetDistanceBetween(oNearestCreatureCenter, oMyCenterWP)> 12.0))
		{object oMyArmoireStatic = CreateObject(OBJECT_TYPE_PLACEABLE, "slv_armoire2", GetLocation(oMyArmoire), FALSE, GetName(oMyDoorTrig) + "_Armoire_Static");
		 object oMyChestStatic = CreateObject(OBJECT_TYPE_PLACEABLE, "slv_chest2", GetLocation(oMyChest), FALSE, GetName(oMyDoorTrig) + "_Chest_Static");
		 SetLocalObject(oMyDoorTrig, GetName(oMyDoorTrig) + "_Armoire_Static", oMyArmoireStatic);
		 SetLocalObject(oMyDoorTrig, GetName(oMyDoorTrig) + "_Chest_Static", oMyChestStatic);
		 ACR_SetIsSpawnPointEnabled(GetLocalObject(oMyDoorTrig, "MasterSpawn"), FALSE, TRUE);
		}
	}
//onexit for all placeables triggers outside of dorms.
	
if((GetStringLeft(GetTag(OBJECT_SELF), 6) == "slv_in") && (GetTag(oStudent) != "slv_bookwyrm"))
     {float fDistance;
	  string sUsable;
	  string sUsable2;
	  string sUsable3;
	  string sUsable4;
	  string sCreate;
	  string sCreate2;
	  string sCreate3;
	  string sCreate4;
	  if(GetName(OBJECT_SELF) == "Dean")
	 	{fDistance = 9.5;
		 sUsable = "_Box";
		 sCreate = "slv_lbox";
		}
	  if(GetName(OBJECT_SELF) == "Registrar")
	  	{fDistance = 5.3;
		 sUsable = "_Box";
		 sUsable2 = "_Armoire";
		 sCreate = "slv_lbox";
		 sCreate2 = "slv_armoire2";
		 }
	  if(GetName(OBJECT_SELF) == "Records")
	  	{fDistance = 5.5;
		 sUsable = "_Treant";
		 }
	  if(GetName(OBJECT_SELF) == "Entry_NE")
	  	{fDistance = 4.9;
		 sUsable = "_Armoire";
		 sCreate = "slv_armoire2";
		}
	 if(GetName(OBJECT_SELF) == "Entry_NW")
	  	{fDistance = 4.9;
		 }
	 if(GetName(OBJECT_SELF) == "Scribery_All")
	  	{fDistance = 19.5;
		  }
	 if(GetName(OBJECT_SELF) == "Scribery_Center")
	  	{fDistance = 9.5;
		  }
	if(GetName(OBJECT_SELF) == "Scribery_S")
	  	{fDistance = 4.4;
		 }
 	 if(GetName(OBJECT_SELF) == "Scribery_E")
	  	{fDistance = 4.9;
		 sCreate = "slv_chest2";
		 sUsable = "_Chest";
		}
	 if(GetName(OBJECT_SELF) == "Aerasume")
	  	{fDistance = 4.5;
		 } 
	if(GetName(OBJECT_SELF) == "Library_All")
	  	{fDistance = 29.5;
		 }
	if(GetName(OBJECT_SELF) == "Library_SW")
	  	{fDistance = 4.5;
		 }
	 if(GetName(OBJECT_SELF) == "Library_SE")
	  	{fDistance = 4.5;
		 }
	 if(GetName(OBJECT_SELF) == "Library_NE")
	  	{fDistance = 4.5;
		 }
	 if(GetName(OBJECT_SELF) == "Library_NW")
	  	{fDistance = 4.5;
		 }
	 if(GetName(OBJECT_SELF) == "Library_Stairs")
	  	{fDistance = 9.5;
		 }
	if(GetName(OBJECT_SELF) == "Kitchen")
	  	{fDistance = 11.5;
		 }
	if(GetName(OBJECT_SELF) == "Kitchen_Table_1")
	  	{fDistance = 4.5;
		 }
	if(GetName(OBJECT_SELF) == "Kitchen_Table_2")
	  	{fDistance = 4.5;
		}
	if(GetName(OBJECT_SELF) == "Kitchen_Table_3")
	  	{fDistance = 4.5;
		 }	
	if(GetName(OBJECT_SELF) == "Kitchen_Stools_1")
	  	{fDistance = 2.45;
		 }	
	if(GetName(OBJECT_SELF) == "Kitchen_Stools_2")
	  	{fDistance = 2.45;
		 }	
	if(GetName(OBJECT_SELF) == "LadyHall")
	  	{fDistance = 4.5;
		 }
	if(GetName(OBJECT_SELF) == "Hornblade_Table1")
	  	{fDistance = 4.5;
		 }
	if(GetName(OBJECT_SELF) == "Hornblade_Table2")
	  	{fDistance = 4.5;
		 }	 
	if(GetName(OBJECT_SELF) == "Valamaradace")
	  	{fDistance = 4.5;
		 }	 
	if(GetName(OBJECT_SELF) == "Supplies")
	  	{fDistance = 4.3;
		 }	 
	if(GetName(OBJECT_SELF) == "Restricted")
	  	{fDistance = 4.4;
		 }	
	if(GetName(OBJECT_SELF) == "Entry_SW")
	  	{fDistance = 4.9;
		 }	
	if(GetName(OBJECT_SELF) == "Entry_SE")
	  	{fDistance = 4.9;
		 }		 
	if(GetName(OBJECT_SELF) == "ComW_Set1")
	  	{fDistance = 4.9;
		 }		 
	if(GetName(OBJECT_SELF) == "ComW_Set2")
	  	{fDistance = 4.9;
		 }		 
	if(GetName(OBJECT_SELF) == "ComW_Set3")
	  	{fDistance = 4.9;
		 }		 
	if(GetName(OBJECT_SELF) == "ComW_Set4")
	  	{fDistance = 1.75;
		 }			 	  	 	 		 		 	   	 	 	 	 
	if(GetName(OBJECT_SELF) == "ComW_Fireplace1")
	  	{fDistance = 2.0;
		 }			 	  	 	 		 		 	   	 	 	 	 
	if(GetName(OBJECT_SELF) == "ComW_Fireplace2")
	  	{fDistance = 2.0;
		 }			 	  	 	 		 		 	   	 	 	 	 
	if(GetName(OBJECT_SELF) == "ComW_Sundial")
	  	{fDistance = 2.0;
		 }			 	  	 	 		 		 	   	 	 	 	 
	if(GetName(OBJECT_SELF) == "ComE_Set1")
	  	{fDistance = 4.9;
		 }		 
	if(GetName(OBJECT_SELF) == "ComE_Set2")
	  	{fDistance = 4.9;
		 }		 
	if(GetName(OBJECT_SELF) == "ComE_Set3")
	  	{fDistance = 4.9;
		 }		 
	if(GetName(OBJECT_SELF) == "ComE_Set4")
	  	{fDistance = 1.75;
		 }			 	  	 	 		 		 	   	 	 	 	 
	if(GetName(OBJECT_SELF) == "ComE_Fireplace1")
	  	{fDistance = 2.0;
		 }			 	  	 	 		 		 	   	 	 	 	 
	if(GetName(OBJECT_SELF) == "ComE_Fireplace2")
	  	{fDistance = 2.0;
		 }			 	  	 	 		 		 	   	 	 	 	 
	if(GetName(OBJECT_SELF) == "ComE_Sundial")
	  	{fDistance = 2.0;
		 }
	if(GetName(OBJECT_SELF) == "Entry_BBS1")
	  	{fDistance = 4.9;
		 }
 	if(GetName(OBJECT_SELF) == "Entry_BBS2")
 	  	{fDistance = 4.9;
 		 }	 	 		 		  		 				
	if(GetName(OBJECT_SELF) == "Lobby_BBS1")
	  	{fDistance = 4.9;
		 }
 	if(GetName(OBJECT_SELF) == "Lobby_BBS2")
 	  	{fDistance = 4.9;
 		 }	 	 		 		  		 				
	if(GetName(OBJECT_SELF) == "Lobby1")
	  	{fDistance = 4.0;
		 } 
	if(GetName(OBJECT_SELF) == "Lobby2")
	  	{fDistance = 4.0;
		 } 
	if(GetName(OBJECT_SELF) == "Lobby3")
	  	{fDistance = 4.0;
		 } 
	if((GetName(OBJECT_SELF) == "MT4_Dorm_1") || (GetName(OBJECT_SELF) == "MT3_Dorm_1"))
	  	{fDistance = 5.0;
		 sUsable = "_Armoire1";
		 sUsable2 = "_Armoire2";
		 sUsable3 = "_Chest1";
		 sUsable4 = "_Chest2";
		 sCreate = "slv_armoire2";
		 sCreate2 = "slv_armoire2";
		 sCreate3 = "slv_chest2";
		 sCreate4 = "slv_chest2";
		 } 

		 
	  string sStatic = sUsable + "_Static";
	  string sStatic2 = sUsable2 + "_Static";
	  string sStatic3 = sUsable3 + "_Static";
	  string sStatic4 = sUsable4 + "_Static";
	  object oMyUsable=GetLocalObject(OBJECT_SELF, GetName(OBJECT_SELF) + sUsable);
	  object oMyUsable2=GetLocalObject(OBJECT_SELF, GetName(OBJECT_SELF) + sUsable2);
	  object oMyUsable3=GetLocalObject(OBJECT_SELF, GetName(OBJECT_SELF) + sUsable3);
	  object oMyUsable4=GetLocalObject(OBJECT_SELF, GetName(OBJECT_SELF) + sUsable4);
	  object oMyCenterWP=GetLocalObject(OBJECT_SELF, GetName(OBJECT_SELF) + "_Center_WP");
	  object oNearestCreatureCenter=GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, oMyCenterWP, 1);
	  
	  if((GetDistanceBetween(oMyCenterWP, oNearestCreatureCenter) > fDistance) || (GetIsDMPossessed(oStudent)))
	  
	 	{object oMyStatic = CreateObject(OBJECT_TYPE_PLACEABLE, sCreate, GetLocation(oMyUsable), FALSE, GetName(OBJECT_SELF) + sUsable);
		 object oMyStatic2 = CreateObject(OBJECT_TYPE_PLACEABLE, sCreate2, GetLocation(oMyUsable2), FALSE, GetName(OBJECT_SELF) + sUsable2);
		 object oMyStatic3 = CreateObject(OBJECT_TYPE_PLACEABLE, sCreate3, GetLocation(oMyUsable3), FALSE, GetName(OBJECT_SELF) + sUsable3);
		 object oMyStatic4 = CreateObject(OBJECT_TYPE_PLACEABLE, sCreate4, GetLocation(oMyUsable4), FALSE, GetName(OBJECT_SELF) + sUsable4);
		 SetLocalObject(OBJECT_SELF, GetName(OBJECT_SELF) + sStatic, oMyStatic);
		 SetLocalObject(OBJECT_SELF, GetName(OBJECT_SELF) + sStatic2, oMyStatic2);
		 SetLocalObject(OBJECT_SELF, GetName(OBJECT_SELF) + sStatic3, oMyStatic3);
		 SetLocalObject(OBJECT_SELF, GetName(OBJECT_SELF) + sStatic4, oMyStatic4);
		 ACR_SetIsSpawnPointEnabled(GetLocalObject(OBJECT_SELF, "MasterSpawn"), FALSE, TRUE);
		 if((GetName(OBJECT_SELF) == "MT4_Dorm_1") || (GetName(OBJECT_SELF) == "MT3_Dorm_1") || (GetName(OBJECT_SELF) == "MT4_Dorm_2") || (GetName(OBJECT_SELF) == "MT3_Dorm_2"))
			  	{object oMyRoof1WP = GetLocalObject(OBJECT_SELF, "oMyRoof1WP");
				 if(oMyRoof1WP == OBJECT_INVALID)
					 {oMyRoof1WP = GetObjectByTag(GetName(OBJECT_SELF) + "_Roof1_WP");
					}
			     SetLocalObject(OBJECT_SELF, "oMyRoof1WP", oMyRoof1WP);
				 object oMyRoof2WP = GetLocalObject(OBJECT_SELF, "oMyRoof2WP");
				 if(oMyRoof2WP == OBJECT_INVALID)
					{oMyRoof2WP = GetObjectByTag(GetName(OBJECT_SELF) + "_Roof2_WP");
				    }
				 SetLocalObject(OBJECT_SELF, "oMyRoof2WP", oMyRoof2WP);
				 object oMyRoof1 = GetLocalObject(OBJECT_SELF, "oMyRoof1");
				 if(oMyRoof1 == OBJECT_INVALID)
					 {oMyRoof1 = CreateObject(OBJECT_TYPE_PLACEABLE, "slv_towerroof2", GetLocation(oMyRoof1WP), FALSE, GetName(OBJECT_SELF) + "_Roof1");
			     	 }
				 object oMyRoof2 = GetLocalObject(OBJECT_SELF, "oMyRoof2");
				 if(oMyRoof2 == OBJECT_INVALID)
					{oMyRoof2 = CreateObject(OBJECT_TYPE_PLACEABLE, "slv_roof_square_sm", GetLocation(oMyRoof2WP), FALSE, GetName(OBJECT_SELF) + "_Roof2");
			        }
				 SetLocalObject(OBJECT_SELF, "oMyRoof1", oMyRoof1);
				 SetLocalObject(OBJECT_SELF, "oMyRoof2", oMyRoof2);
				}
		 }
	}
// Bookwyrms never leave the Great Library with this script.

	if(GetTag(OBJECT_SELF) == "Library_All")
		{if(GetLocalInt(OBJECT_SELF, "Localized") != 1)
			{SetLocalObject(OBJECT_SELF, "Center", GetWaypointByTag("Library_Stairs_Center_WP"));
			}
			{}
		 if(GetTag(oStudent) == "slv_bookwyrm")
			{object oCenter = GetLocalObject(OBJECT_SELF, "Center");
		 	 location lInward = GetLocation(oCenter);
		 	 AssignCommand(oStudent, ClearAllActions(TRUE));
			 DelayCommand(2.0, AssignCommand(oStudent, ActionForceMoveToLocation(lInward, TRUE, 15.0)));
			 DelayCommand(20.0, AssignCommand(oStudent, ActionRandomWalk()));
			 
			 }
		}
		
//Destroys Dean's Secret Bookshelf to those with the dragon key

	if((GetTag(OBJECT_SELF) == "slv_vala_secret") && ((GetIsPC(oStudent)) || (GetIsDMPossessed(oStudent))))
		{object oBookcase = GetLocalObject(OBJECT_SELF, "oBookcase");
		 if(oBookcase == OBJECT_INVALID)
		 	{oBookcase = GetObjectByTag("slv_vala_bookcase");
			 SetLocalObject(OBJECT_SELF, "oBookcase", oBookcase);
			 }
		int nUseable = GetUseableFlag(oBookcase);
		if(nUseable == TRUE)
			{if(GetItemPossessedBy(oStudent, "slv_deandragon") != OBJECT_INVALID)
				{if(GetIsOpen(oBookcase) == FALSE)
					{SetUseableFlag(oBookcase, FALSE);
					}
				 else
				 	{DelayCommand(600.0, SetUseableFlag(oBookcase, FALSE));
					}
				}
			}
		}
		
 if((GetTag(OBJECT_SELF) == "slv_vala_secret_phoenix") && ((GetIsPC(oStudent)) || (GetIsDMPossessed(oStudent))))
		{object oBookcase = GetLocalObject(OBJECT_SELF, "oBookcase");
		 if(oBookcase == OBJECT_INVALID)
		 	{oBookcase = GetObjectByTag("slv_vala_bookcase_phoenix");
			 SetLocalObject(OBJECT_SELF, "oBookcase", oBookcase);
			 }
		int nUseable = GetUseableFlag(oBookcase);
		if(nUseable == TRUE)
			{if(GetItemPossessedBy(oStudent, "slv_deanphoenix") != OBJECT_INVALID)
				{if(GetIsOpen(oBookcase) == FALSE)
					{SetUseableFlag(oBookcase, FALSE);
					}
				 else
				 	{DelayCommand(600.0, SetUseableFlag(oBookcase, FALSE));
					}
				}
			}
		}

		
		if((GetTag(OBJECT_SELF) == "slv_vala_secret_sphinx") && ((GetIsPC(oStudent)) || (GetIsDMPossessed(oStudent))))
		{object oBookcase = GetLocalObject(OBJECT_SELF, "oBookcase");
		 if(oBookcase == OBJECT_INVALID)
		 	{oBookcase = GetObjectByTag("slv_vala_bookcase_sphinx");
			 SetLocalObject(OBJECT_SELF, "oBookcase", oBookcase);
			 }
		 object oSphinxBust = GetLocalObject(OBJECT_SELF, "oSphinxBust");
			 if(oSphinxBust == OBJECT_INVALID)
			 	{oSphinxBust = GetObjectByTag("vala_sphinx");
				 SetLocalObject(OBJECT_SELF, "oSphinxBust", oSphinxBust);
				 }
		int nUseable = GetUseableFlag(oBookcase);
		if(nUseable == TRUE)
			{if(GetItemPossessedBy(oStudent, "slv_deansphinx") != OBJECT_INVALID)
				{if(GetIsOpen(oBookcase) == FALSE)
					{SetUseableFlag(oBookcase, FALSE);
					SetUseableFlag(oSphinxBust, FALSE);
					}
				 else
				 	{DelayCommand(600.0, SetUseableFlag(oBookcase, FALSE));
					}
				}
			}
		}

//Closes Dean's Secret Door only to Dean & Registrar Serapheena & DM
		
	if((GetTag(OBJECT_SELF) == "dean_secret") && ((GetTag(GetEnteringObject()) == "003_cr_slv_dean") ||(GetTag(GetEnteringObject()) == "003_cr_slv_registrar")  || (GetIsDMPossessed(oStudent)) || GetIsDM(GetEnteringObject())))
			{object oDoor = GetLocalObject(OBJECT_SELF, "oDoor");
			 if(oDoor == OBJECT_INVALID)
			 	{oDoor = GetObjectByTag("Dean_Secret_Door");}
				{}
			 object oDoorClosedWP = GetLocalObject(OBJECT_SELF, "oDoorClosedWP");
			 if(oDoorClosedWP == OBJECT_INVALID)
			 	{oDoorClosedWP = GetObjectByTag("dean_secret_closed_WP");
				 SetLocalObject(OBJECT_SELF, "oDoorClosedWP", oDoorClosedWP);
			    }
				{}
			 object oCollBox = GetLocalObject(OBJECT_SELF, "oCollBox");
			 if(oCollBox == OBJECT_INVALID)
			 	{oCollBox = GetObjectByTag("dean_CollBox");
				 }
				{}	
			 
			location lDeanCollBox = GetLocation(GetWaypointByTag("dean_collbox_WP"));
				 object oCollBoxNew= CreateObject(OBJECT_TYPE_PLACEABLE, "slv_dean_collision", lDeanCollBox, FALSE, "dean_CollBox");
				 SetLocalObject(OBJECT_SELF, "oCollBox", oCollBoxNew);
				 DestroyObject(oDoor);
			 	 SetLocalObject(OBJECT_SELF, "oDoor", OBJECT_INVALID);
				 object oDoorClosed = CreateObject(OBJECT_TYPE_PLACEABLE, "slv_bookshelf_estate_narrow", GetLocation(oDoorClosedWP), FALSE, "Dean_Secret_Door");
			 }
	//Deactivates usable 300 level desk & quill on departure	
		 
	if((GetTag(OBJECT_SELF) == "slv_300_trig") && ((GetIsPC(oStudent))|| (GetIsDMPossessed(oStudent))))
	  	{object oQuill = GetLocalObject(OBJECT_SELF, "oQuill");
 		 SetUseableFlag(oQuill, FALSE);
		 object oDesk = GetLocalObject(OBJECT_SELF, "oDesk");
 		 SetUseableFlag(oDesk, FALSE);
		 object oChair = GetLocalObject(OBJECT_SELF, "oChair");
 		 SetUseableFlag(oChair, FALSE);
		 }	 	
	//Deactivates usable bookorder quill on departure	
		 
	if((GetTag(OBJECT_SELF) == "slv_bookorder_quill") && ((GetIsPC(oStudent))|| (GetIsDMPossessed(oStudent))))
	  	{object oQuill = GetLocalObject(OBJECT_SELF, "oQuill");
 		 SetUseableFlag(oQuill, FALSE);
		 }	 	
	//Deactivates usable scribing quill on departure	
		 
	if((GetTag(OBJECT_SELF) == "slv_scribing_station") && ((GetIsPC(oStudent))|| (GetIsDMPossessed(oStudent))))
	  	{object oQuill = GetLocalObject(OBJECT_SELF, "oQuill");
 		 SetUseableFlag(oQuill, FALSE);
		 }	 	

	//Destroys usable trashcans on departure	
		 
	if((GetTag(OBJECT_SELF) == "slv_trashcan") && ((GetIsPC(oStudent))|| (GetIsDMPossessed(oStudent))))
	  	{object oTrashcan = GetLocalObject(OBJECT_SELF, "Trashcan");
 		 DestroyObject(oTrashcan);
		 }	 	

			 
	//Destroys usable sundials on departure	
		 
	if((GetTag(OBJECT_SELF) == "slv_sundial") && ((GetIsPC(oStudent))|| (GetIsDMPossessed(oStudent))))
	  	{object oSundial = GetLocalObject(OBJECT_SELF, "Sundial");
 		 DestroyObject(oSundial);
		 }	 	
	
	//Destroys usable maps on departure	
		 
	if((GetTag(OBJECT_SELF) == "slv_map") && ((GetIsPC(oStudent))|| (GetIsDMPossessed(oStudent))))
	  	{object oMap = GetLocalObject(OBJECT_SELF, "Map");
 		 DestroyObject(oMap);
		 }	 	
//Classroom onexit trigger functions

 if((FindSubString(GetName(OBJECT_SELF), "_All") != -1) && (FindSubString(GetTag(oStudent), "proc") != -1))
 	{SetLocalInt(oStudent, "InClass", 0);
	 SetLocalString(oStudent, "sSchool", "");
	}

 if((FindSubString(GetName(OBJECT_SELF), "Abj") != -1) || (FindSubString(GetName(OBJECT_SELF), "Con") != -1) ||(FindSubString(GetName(OBJECT_SELF), "Div") != -1) ||(FindSubString(GetName(OBJECT_SELF), "Enc") != -1) 
 	|| (FindSubString(GetName(OBJECT_SELF), "Evo") != -1) ||(FindSubString(GetName(OBJECT_SELF), "Ill") != -1) ||(FindSubString(GetName(OBJECT_SELF), "Nec") != -1) ||(FindSubString(GetName(OBJECT_SELF), "Tra") != -1))
		   {int nSchool = GetSilvyUniversitySchool(OBJECT_SELF);
			string sCurrentCourse = GetSilvyUniversityCurrentSchoolRegistration(oStudent, nSchool);
			string sSchool = SchoolToString(nSchool);
		 	int nLevel = GetSilvyUniversitySchoolLevel(oStudent, nSchool);
			object oMyDesk = GetLocalObject(OBJECT_SELF, "Desk");
	
			
	//Classroom Roofs && CollBoxes 
	if((FindSubString(GetName(OBJECT_SELF), "All") != -1) && (GetIsPC(oStudent)))
		{SetLocalObject(oStudent, "LastTrig", OBJECT_INVALID);
	     int nSchool = GetSilvyUniversitySchool(OBJECT_SELF);
		 string sSchool = SchoolToString(nSchool);
		 string sPrefix = GetStringLeft(GetName(OBJECT_SELF), 3);
		 object oMyRoof1WP = GetLocalObject(OBJECT_SELF, "oMyRoof1WP");
		 if (oMyRoof1WP == OBJECT_INVALID)
			{oMyRoof1WP = GetWaypointByTag(sPrefix + "_All_Quests_Roof1_WP");
			 SetLocalObject(OBJECT_SELF, "oMyRoof1WP", oMyRoof1WP);
			 }
		 object oMyRoof1 = GetLocalObject(OBJECT_SELF, "oMyRoof1");
		 if(oMyRoof1 == OBJECT_INVALID)
		 	{oMyRoof1 = CreateObject(OBJECT_TYPE_PLACEABLE, "slv_roof_square_sm", GetLocation(oMyRoof1WP), FALSE, sSchool + "_Roof1");
			 SetLocalObject(OBJECT_SELF, "oMyRoof1", oMyRoof1);
			 }
		 object oMyRoof2WP = GetLocalObject(OBJECT_SELF, "oMyRoof2WP");
		 if (oMyRoof2WP == OBJECT_INVALID)
			{oMyRoof2WP = GetWaypointByTag(sPrefix + "_All_Quests_Roof2_WP");
			 SetLocalObject(OBJECT_SELF, "oMyRoof2WP", oMyRoof2WP);
			 }
		 object oMyRoof2 = GetLocalObject(OBJECT_SELF, "oMyRoof2");
		 if(oMyRoof2 == OBJECT_INVALID)
		 	{oMyRoof2 = CreateObject(OBJECT_TYPE_PLACEABLE, "slv_roof_square_lg", GetLocation(oMyRoof2WP), FALSE, sSchool + "_Roof2");
			 SetLocalObject(OBJECT_SELF, "oMyRoof2", oMyRoof2);
			 }
		 object oMyRoof3WP = GetLocalObject(OBJECT_SELF, "oMyRoof3WP");
		 if (oMyRoof3WP == OBJECT_INVALID)
			{oMyRoof3WP = GetWaypointByTag(sPrefix + "_All_Quests_Roof3_WP");
			 SetLocalObject(OBJECT_SELF, "oMyRoof3WP", oMyRoof3WP);
			 }
		 object oMyRoof3 = GetLocalObject(OBJECT_SELF, "oMyRoof3");
		 if(oMyRoof3 == OBJECT_INVALID)
		 	{oMyRoof3 = CreateObject(OBJECT_TYPE_PLACEABLE, "slv_roof_square_sm", GetLocation(oMyRoof3WP), FALSE, sSchool + "_Roof3");
			 SetLocalObject(OBJECT_SELF, "oMyRoof3", oMyRoof3);
			 }
		 object oMyTrig1 = GetLocalObject(OBJECT_SELF, sSchool + "1_trig");
		 if (oMyTrig1 == OBJECT_INVALID)
			{oMyTrig1 = GetObjectByTag( sSchool + "1_trig");
			 SetLocalObject(OBJECT_SELF,  sSchool + "1_trig", oMyTrig1);
			 SetLocalObject(oMyTrig1,  "oMyTrigAll", OBJECT_SELF);
			}
		 object oMyTrig2 = GetLocalObject(OBJECT_SELF, "oMyTrig2");
		 if (oMyTrig2 == OBJECT_INVALID)
			{oMyTrig2 = GetObjectByTag( sSchool + "2_trig");
			 SetLocalObject(OBJECT_SELF,  "oMyTrig2", oMyTrig2);
			 }
		 object oMyTrig3 = GetLocalObject(OBJECT_SELF, "oMyTrig3");
		 if (oMyTrig3 == OBJECT_INVALID)
			{oMyTrig3 = GetObjectByTag( sSchool + "3_trig");
			SetLocalObject(OBJECT_SELF,  "oMyTrig3", oMyTrig3);
			}
		 object oMyCollBox2 = GetLocalObject(OBJECT_SELF, "oMyCollBox2");
		 if(oMyCollBox2 == OBJECT_INVALID)
			{oMyCollBox2 = GetObjectByTag(sSchool + "2_trig_CollBox200");
			 SetLocalObject(OBJECT_SELF, "oMyCollBox2", oMyCollBox2);
			}
		 object oMyCollBox3 = GetLocalObject(OBJECT_SELF, "oMyCollBox3");
		 if(oMyCollBox3 == OBJECT_INVALID)
			{oMyCollBox3 = GetObjectByTag(sSchool + "3_trig_CollBox300");
			 SetLocalObject(OBJECT_SELF, "oMyCollBox3", oMyCollBox3);
			}
		 DestroyObject(oMyCollBox2);
		 SetLocalObject(OBJECT_SELF, "oMyCollBox2", OBJECT_INVALID);
		 SetLocalObject(oMyTrig1, "oMyCollBox2", OBJECT_INVALID);
		 SetLocalObject(oMyTrig2, "oMyCollBox2", OBJECT_INVALID);
		 SetLocalObject(oMyTrig3, "oMyCollBox2", OBJECT_INVALID);
		 DestroyObject(oMyCollBox3);
		 SetLocalObject(OBJECT_SELF, "oMyCollBox3", OBJECT_INVALID);
		 SetLocalObject(oMyTrig1, "oMyCollBox3", OBJECT_INVALID);
		 SetLocalObject(oMyTrig2, "oMyCollBox3", OBJECT_INVALID);
		 SetLocalObject(oMyTrig3, "oMyCollBox3", OBJECT_INVALID);
						  					 
		}
//Abjuration:
		    if(GetName(OBJECT_SELF) == "Abj_All")
				      {object oMyChest = GetLocalObject(OBJECT_SELF, "oMyChest");
					   if (oMyChest == OBJECT_INVALID)
							{oMyChest = GetObjectByTag("slv_abj100_chest");
							 SetLocalObject(OBJECT_SELF, "oMyChest", oMyChest);
							 }
						SetUseableFlag(oMyChest, FALSE);
						object oMyHBPLC = GetLocalObject(OBJECT_SELF, "oMyHBPLC");
					    if (oMyHBPLC == OBJECT_INVALID)
							{oMyHBPLC = GetObjectByTag("slv_abj100_hb_plc");
							 SetLocalObject(OBJECT_SELF, "oMyHBPLC", oMyHBPLC);
							 }
						DestroyObject(oMyHBPLC);
						SetLocalObject(OBJECT_SELF, "oMyHBPLC", OBJECT_INVALID);
						object oMySword = GetLocalObject(OBJECT_SELF, "oMySword");
					    if (oMySword == OBJECT_INVALID)
							{oMySword = GetObjectByTag("slv_abj200_plc_sword");
							 }
						DestroyObject(oMySword);
						SetLocalObject(OBJECT_SELF, "oMySword", OBJECT_INVALID);
						object oMyShield = GetLocalObject(OBJECT_SELF, "oMyShield");
					    if (oMyShield == OBJECT_INVALID)
							{oMyShield = GetObjectByTag("slv_abj200_shield");
							 }
						DestroyObject(oMyShield);
						SetLocalObject(OBJECT_SELF, "oMyShield", OBJECT_INVALID);
						object oMySkull = GetLocalObject(OBJECT_SELF, "oMySkull");
					    if (oMySkull == OBJECT_INVALID)
							{oMySkull = GetObjectByTag("slv_abj100_plc_skull");
							 }
						DestroyObject(oMySkull);
						SetLocalObject(OBJECT_SELF, "oMySkull", OBJECT_INVALID);
						
					}	
					
			//Elementary Abjuration
			
			if(GetTag(OBJECT_SELF) == "Abjuration1_trig") 
				{SetLocalObject(OBJECT_SELF, "oInside", OBJECT_INVALID);
				}
						 
			//Standard Abjuration	
			 if((GetTag(OBJECT_SELF) == "Abjuration2_trig") && (GetCampaignString("SLV_UNI", "Standard Abjuration", oStudent) == "Standard Abjuration")&& (GetHasSpellEffect(SPELL_SHIELD, oStudent)) && (GetCampaignString("SLV_UNI", "Abj200MM", oStudent) != "Done"))
				{AssignCommand(GetObjectByTag("slv_abj100_chest"), ActionCastSpellAtObject(SPELL_MAGIC_MISSILE, oStudent, METAMAGIC_SILENT, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
				 DelayCommand(3.0, SendMessageToPC(oStudent, "The magical missiles slams into the shield, leaving you shaken but unharmed."));
				 SetCampaignString("SLV_UNI", "Abj200MM", "Done", oStudent);
				}
								   
			//Advanced Abjuration:
		 	if(oMyDesk == OBJECT_INVALID)
				  {oMyDesk = GetObjectByTag(GetTag(OBJECT_SELF) + "_Desk");
				   SetLocalObject(OBJECT_SELF, "Desk", oMyDesk);
				  }
			if(GetTag(OBJECT_SELF) == "Abjuration3_trig") 
				{SetUseableFlag(oMyDesk, FALSE);
				}
	
//Conjuration:
		    if(GetName(OBJECT_SELF) == "Con_All")
				      {object Conjuration1_trig = GetLocalObject(OBJECT_SELF, "Conjuration1_trig");
					   if (Conjuration1_trig == OBJECT_INVALID)
							{Conjuration1_trig = GetObjectByTag("Conjuration1_trig");
							 SetLocalObject(OBJECT_SELF, "Conjuration1_trig", Conjuration1_trig);
							 }
						SetLocalObject(Conjuration1_trig, "oMyConAll", OBJECT_SELF);
					    object oMyWolf = GetLocalObject(OBJECT_SELF, "oMyWolf");
					    if(oMyWolf == OBJECT_INVALID)
							{oMyWolf = GetObjectByTag("003_cr_slv_celestwolf");
							SetLocalObject(OBJECT_SELF, "oMyWolf", oMyWolf);
							}
					    DestroyObject(oMyWolf);
						SetLocalObject(OBJECT_SELF, "oMyWolf", OBJECT_INVALID);
					    object oMyGate = GetLocalObject(OBJECT_SELF, "oMyGate");
					    if(oMyGate == OBJECT_INVALID)
							{oMyGate = GetObjectByTag("slv_con100_gate");
							SetLocalObject(OBJECT_SELF, "oMyGate", oMyGate);
							}
					    DestroyObject(oMyGate);
						SetLocalObject(OBJECT_SELF, "oMyGate", OBJECT_INVALID);
					    object oMyCollGate1 = GetLocalObject(Conjuration1_trig, "oMyCollGate1");
					    if(oMyCollGate1 == OBJECT_INVALID)
							{oMyCollGate1 = GetObjectByTag("slv_con100_collbox1");
							SetLocalObject(OBJECT_SELF, "oMyCollGate1", oMyCollGate1);
							}
					    DestroyObject(oMyCollGate1);
						SetLocalObject(OBJECT_SELF, "oMyCollGate1", OBJECT_INVALID);
					    object oMyCollGate2 = GetLocalObject(Conjuration1_trig, "oMyCollGate2");
					    if(oMyCollGate2 == OBJECT_INVALID)
							{oMyCollGate2 = GetObjectByTag("slv_con100_collbox2");
							SetLocalObject(OBJECT_SELF, "oMyCollGate2", oMyCollGate2);
							}
					    DestroyObject(oMyCollGate2);
						SetLocalObject(OBJECT_SELF, "oMyCollGate2", OBJECT_INVALID);
					}
	//Elementary Conjuration:
			
			 if((GetTag(OBJECT_SELF) == "Conjuration1_trig") && (GetIsPC(oStudent)) && (!GetIsPossessedFamiliar(oStudent) && (GetLocalInt(oStudent, "ConjPlateUp") != 1)))
			    {SetLocalInt(oStudent, "ConjPlateUp", 1);
			     SetCampaignString("SLV_UNI", "Elementary Conjuration", "Elementary Conjuration", oStudent);
				 SendMessageToPC(oStudent, "The pressure plate rises back to floor level.  A soft voice speaks from everywhere and nowhere in the room, echoing around you.");
			     DelayCommand(2.0, FloatingTextStringOnCreature("'Conjuring done by this world's son makes heavy work resolved.'", oStudent, TRUE));
			     DelayCommand(4.0, FloatingTextStringOnCreature("'Expended spell, now off to tell, of weight displacement solved.'", oStudent, TRUE));
			     }
			  //StandardConjuration
			    if((GetName(OBJECT_SELF) == "ConjurationTrees_trig") && (GetHasSpellEffect(SPELL_MAGE_ARMOR, oStudent)))
			        {SendMessageToPC(oStudent, "The thorns and spines seem to deflect, miss or simply fail to pierce your flesh.");
			         }
			         else if (GetName(OBJECT_SELF) == "ConjurationTrees_trig")
			         {effect eThorns = EffectDamage(1, DAMAGE_TYPE_PIERCING, DAMAGE_POWER_NORMAL);
    				  SendMessageToPC(oStudent, "Thorns and spines threaten to pierce your flesh with every movement.");
			               if(Random(10) < 5)
			                  {ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eThorns, oStudent);
			                   SendMessageToPC(oStudent, "A thorn is driven deep into your flesh.");
			                  }
			         }
			         
        		//Divination
				
				    if(GetName(OBJECT_SELF) == "Div_All") 
					    {object oMySigil = GetLocalObject(OBJECT_SELF, "oMySigil");
						 if (oMySigil == OBJECT_INVALID)
								{oMySigil = GetObjectByTag("slv_div100_sigil");
								 SetLocalObject(OBJECT_SELF, "oMySigil", oMySigil);
								 }
						 SetUseableFlag(oMySigil, FALSE);
						 }	
						 
			// Enchantment
			
			if(GetName(OBJECT_SELF) == "Enc_All") 
					    {SetLocalInt(oStudent, "AngryMessage", 0);
						 object oMyProctor2 = GetLocalObject(OBJECT_SELF, "oMyProctor2");
						 object oMyMirror = GetLocalObject(OBJECT_SELF, "oMyMirror");
						 object oMyGiant = GetLocalObject(OBJECT_SELF, "oMyGiant");
						 object oMyGiant2 = GetLocalObject(OBJECT_SELF, "oMyGiant2");
						 object oMyEye1 = GetLocalObject(OBJECT_SELF, "oMyEye1");
						 object oMyEye2 = GetLocalObject(OBJECT_SELF, "oMyEye2");
						 object oMyEye3 = GetLocalObject(OBJECT_SELF, "oMyEye3");
						 object oMyEye4 = GetLocalObject(OBJECT_SELF, "oMyEye4");
						 object oMyEye5 = GetLocalObject(OBJECT_SELF, "oMyEye5");
						 DestroyObject(oMyGiant);					
						 SetLocalObject(OBJECT_SELF, "oMyGiant", OBJECT_INVALID);
						 DestroyObject(oMyGiant2);					
						 SetLocalObject(OBJECT_SELF, "oMyGiant2", OBJECT_INVALID);
						 DestroyObject(oMyEye1);					
						 SetLocalObject(OBJECT_SELF, "oMyEye1", OBJECT_INVALID);
						 DestroyObject(oMyEye2);					
						 SetLocalObject(OBJECT_SELF, "oMyEye2", OBJECT_INVALID);
						 DestroyObject(oMyEye3);					
						 SetLocalObject(OBJECT_SELF, "oMyEye3", OBJECT_INVALID);
						 DestroyObject(oMyEye4);					
						 SetLocalObject(OBJECT_SELF, "oMyEye4", OBJECT_INVALID);
						 DestroyObject(oMyEye5);					
						 SetLocalObject(OBJECT_SELF, "oMyEye5", OBJECT_INVALID);
						 DestroyObject(oMyMirror);					
						 SetLocalObject(OBJECT_SELF, "oMyMirror", OBJECT_INVALID);
						 SetLocalObject(GetArea(oMyMirror), "oMirror", OBJECT_INVALID);
						 DestroyObject(oMyProctor2);
						 SetLocalObject(OBJECT_SELF, "oMyProctor2", OBJECT_INVALID);
							 }		
						
			
	
			// Evocation
					if(GetName(OBJECT_SELF) == "Evo_All") 
					    {object oMyCurtainPull = GetLocalObject(OBJECT_SELF, "oMyCurtainPull");
						 if (oMyCurtainPull == OBJECT_INVALID)
								{oMyCurtainPull = GetObjectByTag("slv_evo200_curtainpull");
								SetLocalObject(OBJECT_SELF, "oMyCurtainPull", oMyCurtainPull);
								 }
						 SetUseableFlag(oMyCurtainPull, FALSE);	
						 object oMyIncinder = GetLocalObject(OBJECT_SELF, "oMyIncinder");
						 DestroyObject(oMyIncinder);					
						SetLocalObject(OBJECT_SELF, "oMyIncinder", OBJECT_INVALID);
						object oMyEmulsion = GetLocalObject(oMyCurtainPull, "oMyEmulsion");
						DestroyObject(oMyEmulsion);	
						 
						}
		    
			//Illusion
				if(GetName(OBJECT_SELF) == "Ill_All") 
					    {SetLocalInt(oStudent, "Change1", 0);
						 SetLocalInt(oStudent, "Change2", 0);
						 object oMyPixie = GetLocalObject(OBJECT_SELF, "oMyPixie");
						 if (oMyPixie == OBJECT_INVALID)
								{oMyPixie = GetObjectByTag("003_cr_slv_ill100pixie");
								SetLocalObject(OBJECT_SELF, "oMyPixie", oMyPixie);
								 }
						object oMyImp = GetLocalObject(OBJECT_SELF, "oMyImp");
						 if (oMyImp == OBJECT_INVALID)
								{oMyImp = GetObjectByTag("003_cr_slv_ill100imp");
								SetLocalObject(OBJECT_SELF, "oMyImp", oMyImp);
								 }
						 object oMyButterflies = GetLocalObject(OBJECT_SELF, "oMyButterflies");
						 if (oMyButterflies == OBJECT_INVALID)
								{oMyButterflies = GetObjectByTag("003_cr_slv_ill100butterflies");
								SetLocalObject(OBJECT_SELF, "oMyButterflies", oMyButterflies);
								 }
						 object oMyBoy = GetLocalObject(OBJECT_SELF, "oMyBoy");
						 if (oMyBoy == OBJECT_INVALID)
							{oMyBoy = GetObjectByTag("003_cr_slv_ill100boy");
						 	 SetLocalObject(OBJECT_SELF, "oMyBoy", oMyBoy);
							 }
						 object oMyBear = GetLocalObject(OBJECT_SELF, "oMyBear");
						 if (oMyBear == OBJECT_INVALID)
							{oMyBear = GetObjectByTag("003_cr_slv_ill100cub");
						 	 SetLocalObject(OBJECT_SELF, "oMyBear", oMyBear);
							 }
						 object oMyMirrorWhite = GetLocalObject(OBJECT_SELF, "oMyMirrorWhite");
						 if (oMyMirrorWhite == OBJECT_INVALID)
							{oMyMirrorWhite = GetObjectByTag("slv_ill200_mirrorwhite");
						 	 SetLocalObject(OBJECT_SELF, "oMyMirrorWhite", oMyMirrorWhite);
							 }
						 object oMyMirrorBlack = GetLocalObject(OBJECT_SELF, "oMyMirrorBlack");
						 if (oMyMirrorBlack == OBJECT_INVALID)
							{oMyMirrorBlack = GetObjectByTag("slv_ill200_mirrorblack");
						 	 SetLocalObject(OBJECT_SELF, "oMyMirrorBlack", oMyMirrorBlack);
							 }
						 object oMyMirrorPrism = GetLocalObject(OBJECT_SELF, "oMyMirrorPrism");
						 if (oMyMirrorPrism == OBJECT_INVALID)
							{oMyMirrorPrism = GetObjectByTag("slv_ill200_mirrorprism");
						 	 SetLocalObject(OBJECT_SELF, "oMyMirrorPrism", oMyMirrorPrism);
							 }
						 DestroyObject(oMyButterflies);
						 SetLocalObject(OBJECT_SELF, "oMyButterflies", OBJECT_INVALID);
						 DestroyObject(oMyPixie);
						 SetLocalObject(OBJECT_SELF, "oMyPixie", OBJECT_INVALID);
						 DestroyObject(oMyImp);
						 SetLocalObject(OBJECT_SELF, "oMyImp", OBJECT_INVALID);
						 DestroyObject(oMyBoy);
						 SetLocalObject(OBJECT_SELF, "oMyBoy", OBJECT_INVALID);
						 DestroyObject(oMyBear);
						 SetLocalObject(OBJECT_SELF, "oMyBear", OBJECT_INVALID);
							
						 object oMyForcewall01 = GetLocalObject(OBJECT_SELF, "oMyForcewall01");
						 object oMyForcewall02 = GetLocalObject(OBJECT_SELF, "oMyForcewall02");
						 object oMyForcewall03 = GetLocalObject(OBJECT_SELF, "oMyForcewall03");
						 object oMyForcewall04 = GetLocalObject(OBJECT_SELF, "oMyForcewall04");
						 object oMyForcewall05 = GetLocalObject(OBJECT_SELF, "oMyForcewall05");
						 object oMyForcewall06 = GetLocalObject(OBJECT_SELF, "oMyForcewall06");
						 object oMyForcewall07 = GetLocalObject(OBJECT_SELF, "oMyForcewall07");
						 object oMyForcewall08 = GetLocalObject(OBJECT_SELF, "oMyForcewall08");
						 object oMyForcewall09 = GetLocalObject(OBJECT_SELF, "oMyForcewall09");
						 object oMyForcewall10 = GetLocalObject(OBJECT_SELF, "oMyForcewall10");
						 object oMyForcewall11 = GetLocalObject(OBJECT_SELF, "oMyForcewall11");
						 object oMyForcewall12 = GetLocalObject(OBJECT_SELF, "oMyForcewall12");
						 object oMyForcewall13 = GetLocalObject(OBJECT_SELF, "oMyForcewall13");
						 object oMyForcewall14 = GetLocalObject(OBJECT_SELF, "oMyForcewall14");
						 object oMyForcewall15 = GetLocalObject(OBJECT_SELF, "oMyForcewall15");
						  DestroyObject(oMyForcewall01);
						 SetLocalObject(OBJECT_SELF, "oMyForcewall01", OBJECT_INVALID);
						 DestroyObject(oMyForcewall02);
						 SetLocalObject(OBJECT_SELF, "oMyForcewall02", OBJECT_INVALID);
						 DestroyObject(oMyForcewall03);
						 SetLocalObject(OBJECT_SELF, "oMyForcewall03", OBJECT_INVALID);
						 DestroyObject(oMyForcewall04);
						 SetLocalObject(OBJECT_SELF, "oMyForcewall04", OBJECT_INVALID);
						 DestroyObject(oMyForcewall05);
						 SetLocalObject(OBJECT_SELF, "oMyForcewall05", OBJECT_INVALID);
						 DestroyObject(oMyForcewall06);
						 SetLocalObject(OBJECT_SELF, "oMyForcewall06", OBJECT_INVALID);
						 DestroyObject(oMyForcewall07);
						 SetLocalObject(OBJECT_SELF, "oMyForcewall07", OBJECT_INVALID);
						 DestroyObject(oMyForcewall08);
						 SetLocalObject(OBJECT_SELF, "oMyForcewall08", OBJECT_INVALID);
						 DestroyObject(oMyForcewall09);
						 SetLocalObject(OBJECT_SELF, "oMyForcewall09", OBJECT_INVALID);
						 DestroyObject(oMyForcewall10);
						 SetLocalObject(OBJECT_SELF, "oMyForcewall10", OBJECT_INVALID);
						 DestroyObject(oMyForcewall11);
						 SetLocalObject(OBJECT_SELF, "oMyForcewall11", OBJECT_INVALID);
						 DestroyObject(oMyForcewall12);
						 SetLocalObject(OBJECT_SELF, "oMyForcewall12", OBJECT_INVALID);
						 DestroyObject(oMyForcewall13);
						 SetLocalObject(OBJECT_SELF, "oMyForcewall13", OBJECT_INVALID);
						 DestroyObject(oMyForcewall14);
						 SetLocalObject(OBJECT_SELF, "oMyForcewall14", OBJECT_INVALID);
						 DestroyObject(oMyForcewall15);
						 SetLocalObject(OBJECT_SELF, "oMyForcewall15", OBJECT_INVALID);
						 DestroyObject(oMyMirrorPrism);
						 SetLocalObject(OBJECT_SELF, "oMyMirrorPrism", OBJECT_INVALID);
						 DestroyObject(oMyMirrorBlack);
						 SetLocalObject(OBJECT_SELF, "oMyMirrorBlack", OBJECT_INVALID);
						 DestroyObject(oMyMirrorWhite);
						 SetLocalObject(OBJECT_SELF, "oMyMirrorWhite", OBJECT_INVALID);
						}
				}
				
			if(GetTag(OBJECT_SELF) == "Illusion1")
				{object oMyTrigAll = GetLocalObject(OBJECT_SELF, "Ill_All");
					if(oMyTrigAll == OBJECT_INVALID)
					{oMyTrigAll = GetNearestObjectByTag("slv_in22.00", OBJECT_SELF, 1);
					 SetLocalObject(OBJECT_SELF, "Ill_All", oMyTrigAll);
						  }
				object oMyPixie = GetLocalObject(OBJECT_SELF, "oMyPixie");
				if (oMyPixie == OBJECT_INVALID)
					{oMyPixie = GetObjectByTag("003_cr_slv_ill100pixie");
					SetLocalObject(OBJECT_SELF, "oMyPixie", oMyPixie);
					 }
				object oMyImp = GetLocalObject(OBJECT_SELF, "oMyImp");
				if (oMyImp == OBJECT_INVALID)
					{oMyImp = GetObjectByTag("003_cr_slv_ill100imp");
					SetLocalObject(OBJECT_SELF, "oMyImp", oMyImp);
					}
				object oMyBoy = GetLocalObject(oMyTrigAll, "oMyBoy");
			    if (oMyBoy == OBJECT_INVALID)
					{oMyBoy = GetObjectByTag("003_cr_slv_ill100boy");
					 SetLocalObject(oMyTrigAll, "oMyBoy", oMyBoy);
					}
				if((GetLocalInt(oStudent, "IllChair2") >=1) && (GetLocalInt(oStudent, "IllChair1") >=1))
			        {object oMyBearWP = GetLocalObject(oMyTrigAll, "oMyBearWP");
					 if (oMyBearWP == OBJECT_INVALID)
						{oMyBearWP = GetWaypointByTag("Ill_All_Quests_Bear_WP");
						 SetLocalObject(oMyTrigAll, "oMyBearWP", oMyBearWP);
						 }
					 object oMyBearskin = GetLocalObject(oMyTrigAll, "oMyBearskin");
					 if (oMyBearskin == OBJECT_INVALID)
						{oMyBearskin = GetObjectByTag("slv_ill100_bearskin");
						SetLocalObject(oMyTrigAll, "oMyBearskin", oMyBearskin);
						 }
				     object oMyBear = GetLocalObject(oMyTrigAll, "oMyBear");
					 if (oMyBear == OBJECT_INVALID)
						{oMyBear = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_slv_ill100cub", GetLocation(oMyBearWP));
					 	 SetLocalObject(oMyTrigAll, "oMyBear", oMyBear);
						 }
					 object oMyCollBox2 = GetLocalObject(oMyTrigAll, "oMyCollBox2");
					 if(oMyCollBox2 == OBJECT_INVALID)
							{oMyCollBox2 = GetObjectByTag("Illusion2_trig_CollBox200");
							}
					 
				if((GetLocalString(oStudent, GetTag(oMyPixie)) == GetTag(oMyPixie)) && (GetLocalString(oStudent, GetTag(oMyImp)) == GetTag(oMyImp)))
			        	{DelayCommand(1.0, AssignCommand(oMyBoy, SpeakString("You did it!  This one's smarter than most of them, Snout, but we'll get'm next time!  You can't catch me! *claps hands*  Hey, Presto! *Darts off through a mirrored wall as if it wasn't there.", TALKVOLUME_TALK)));
			         	 ACR_SetPersistentString(oStudent, "Elementary Illusion", "Elementary Illusion");
			         	}
					 else
						 {DelayCommand(1.0, AssignCommand(oMyBoy, SpeakString("Stupid old people! You'll never get it!  You can't catch me! *claps hands*  Hey, Presto! *Darts off through a mirrored wall as if it wasn't there.", TALKVOLUME_TALK)));
				         }
					 DestroyObject(oMyBearskin, 1.5);
			         SetLocalObject(oMyTrigAll, "oMyBearskin", OBJECT_INVALID);
					 DelayCommand(1.5, AssignCommand(oMyBoy, ActionForceMoveToObject(oMyBear, TRUE, 0.0)));
					 DelayCommand(2.0, SendMessageToPC(oStudent, "The bearskin rug on the ground rises up, shakes off, yawns a mighty yawn...and is revealed as a real bear cub, previously under an illusion."));
				     }  
				}
				
				if(GetName(OBJECT_SELF) == "Illusion2") 
					    {SetLocalInt(oStudent, "Change2", 0);
						 }					
						 
			//Necromancy
		if(GetName(OBJECT_SELF) == "Nec_All") 
					    {object oMyCorpse = GetLocalObject(OBJECT_SELF, "oMyCorpse");
						 DestroyObject(oMyCorpse);
						 SetLocalObject(OBJECT_SELF, "oMyCorpse", OBJECT_INVALID);
						 object oMyCabinet = GetLocalObject(OBJECT_SELF, "oMyCabinet");
						 SetUseableFlag(oMyCabinet, FALSE);		 
						 object oMyCrank = GetLocalObject(OBJECT_SELF, "oMyCrank");
						 SetUseableFlag(oMyCrank, FALSE);		 
						 object oMyFluid = GetLocalObject(OBJECT_SELF, "oMyFluid");
						 DestroyObject(oMyFluid);
						 SetLocalObject(OBJECT_SELF, "oMyFluid", OBJECT_INVALID);
						 object oMyKey = GetLocalObject(OBJECT_SELF, "oMyKey");
						 DestroyObject(oMyKey);
						 SetLocalObject(OBJECT_SELF, "oMyKey", OBJECT_INVALID);
						  object oMyLever1 = GetLocalObject(OBJECT_SELF, "oMyLever1");
						 SetUseableFlag(oMyLever1, FALSE);
						 object oMyLever2a = GetLocalObject(OBJECT_SELF, "oMyLever2a");
						 SetUseableFlag(oMyLever2a, FALSE);
						 object oMyLever2b = GetLocalObject(OBJECT_SELF, "oMyLever2b");
						 SetUseableFlag(oMyLever2b, FALSE);
						 object oMyLever3 = GetLocalObject(OBJECT_SELF, "oMyLever3");
						 SetUseableFlag(oMyLever3, FALSE);
						 object oMyGate1 = GetLocalObject(OBJECT_SELF, "oMyGate1");
						 DestroyObject(oMyGate1);
						 SetLocalObject(OBJECT_SELF, "oMyGate1", OBJECT_INVALID);
						 SetLocalObject(oMyLever1, "oMyGate", OBJECT_INVALID);
						 object oMyGate2 = GetLocalObject(OBJECT_SELF, "oMyGate2");
						 DestroyObject(oMyGate2);
						 SetLocalObject(OBJECT_SELF, "oMyGate2", OBJECT_INVALID);
						 SetLocalObject(oMyLever2a, "oMyGate", OBJECT_INVALID);
						 SetLocalObject(oMyLever2b, "oMyGate", OBJECT_INVALID);
						 object oMyGate3 = GetLocalObject(OBJECT_SELF, "oMyGate3");
						 DestroyObject(oMyGate3);
						 SetLocalObject(OBJECT_SELF, "oMyGate3", OBJECT_INVALID);
						 SetLocalObject(oMyLever3, "oMyGate", OBJECT_INVALID);
						 object oMyNec2Trig = GetLocalObject(OBJECT_SELF, "oMyNec2Trig");
						 if(oMyNec2Trig == OBJECT_INVALID)
						 	{oMyNec2Trig = GetObjectByTag("Necromancy2_trig");
							 SetLocalObject(OBJECT_SELF, "oMyNec2Trig", oMyNec2Trig);
							}
						 object oMyZombie = GetLocalObject(OBJECT_SELF, "oMyZombie");
						 DestroyObject(oMyZombie);
						 SetLocalObject(OBJECT_SELF, "oMyZombie", OBJECT_INVALID);
						 SetLocalObject(oMyNec2Trig, "oMyZombie", OBJECT_INVALID);
						 object oMyCorpseDown = GetLocalObject(oMyZombie, "oMyCorpseDown"); 
						 DestroyObject(oMyCorpseDown);
						 SetLocalObject(OBJECT_SELF, "oMyCorpseDown", OBJECT_INVALID);
						 object oMyRat = GetLocalObject(OBJECT_SELF, "oMyRat");
						 DestroyObject(oMyRat);
						 SetLocalObject(OBJECT_SELF, "oMyRat", OBJECT_INVALID);
						 object oMySkull = GetLocalObject(OBJECT_SELF, "oMySkull");
						 DestroyInventory(oMySkull);
						 DestroyObject(oMySkull);
						 SetLocalObject(OBJECT_SELF, "oMySkull", OBJECT_INVALID);
						 SetLocalInt(oStudent, "Embalm", 0);
						 SetLocalInt(oStudent, "Wash", 0);
						 
						 }	
						 
			
				  
		//Transmutation
		if(GetName(OBJECT_SELF) == "Tra_All") 
					    {object oMyBucket = GetLocalObject(OBJECT_SELF, "oMyBucket");
						 object oMySmoke = GetLocalObject(OBJECT_SELF, "oMySmoke");
						 object oMyFire1 = GetLocalObject(OBJECT_SELF, "oMyFire1");
						 object oMyFire2 = GetLocalObject(OBJECT_SELF, "oMyFire2");
						 object oMyFountain = GetLocalObject(OBJECT_SELF, "oMyFountain");
				 		 if (oMyFountain == OBJECT_INVALID)
					 			{oMyFountain = GetObjectByTag("slv_tra100_fountain");
					  			 SetLocalObject(OBJECT_SELF, "oMyFountain", oMyFountain);
					 			}
				 		 SetUseableFlag(oMyFountain, FALSE);	
				 		 object oMyBrazier = GetLocalObject(OBJECT_SELF, "oMyBrazier");
				 		 if (oMyBrazier == OBJECT_INVALID)
					 		{oMyBrazier = GetObjectByTag("slv_tra100_brazier");
					  		 SetLocalObject(OBJECT_SELF, "oMyBrazier", oMyBrazier);
					 		}
				         DestroyObject(oMyBucket);
						 SetLocalObject(OBJECT_SELF, "oMyBucket", OBJECT_INVALID);
						 DestroyObject(oMySmoke);
						 SetLocalObject(OBJECT_SELF, "oMySmoke", OBJECT_INVALID);
						 DestroyObject(oMyFire1);
						 SetLocalObject(OBJECT_SELF, "oMyFire1", OBJECT_INVALID);
						 DestroyObject(oMyFire2);
						 SetLocalObject(OBJECT_SELF, "oMyFire2", OBJECT_INVALID);
						 SetUseableFlag(oMyBrazier, FALSE);	
						 object oMyHumanStool = GetLocalObject(OBJECT_SELF, "oMyHumanStool");
						  if (oMyHumanStool == OBJECT_INVALID)
							 {oMyHumanStool = GetObjectByTag("slv_tra200_stool_human");
							  SetLocalObject(OBJECT_SELF, "oMyHumanStool", oMyHumanStool);
							  }
						  SetUseableFlag(oMyHumanStool, FALSE);
						  object oMyElfStool = GetLocalObject(OBJECT_SELF, "oMyElfStool");
						  if (oMyElfStool == OBJECT_INVALID)
							 {oMyElfStool = GetObjectByTag("slv_tra200_stool_elf");
							  SetLocalObject(OBJECT_SELF, "oMyElfStool", oMyElfStool);
							 }
						  SetUseableFlag(oMyElfStool, FALSE);
						  object oMyDwarfStool = GetLocalObject(OBJECT_SELF, "oMyDwarfStool");
						  if (oMyDwarfStool == OBJECT_INVALID)
							 {oMyDwarfStool = GetObjectByTag("slv_tra200_stool_dwarf");
							  SetLocalObject(OBJECT_SELF, "oMyDwarfStool", oMyDwarfStool);
							 }
						  SetUseableFlag(oMyDwarfStool, FALSE);
						  object oMyGnomeStool = GetLocalObject(OBJECT_SELF, "oMyGnomeStool");
						  if (oMyGnomeStool == OBJECT_INVALID)
							 {oMyGnomeStool = GetObjectByTag("slv_tra200_stool_gnome");
							  SetLocalObject(OBJECT_SELF, "oMyGnomeStool", oMyGnomeStool);
							 }
						  SetUseableFlag(oMyGnomeStool, FALSE);
						  object oMyHalflingStool = GetLocalObject(OBJECT_SELF, "oMyHalflingStool");
						  if (oMyHalflingStool == OBJECT_INVALID)
							 {oMyHalflingStool = GetObjectByTag("slv_tra200_stool_halfling");
							  SetLocalObject(OBJECT_SELF, "oMyHalflingStool", oMyHalflingStool);
							 }
						  SetUseableFlag(oMyHalflingStool, FALSE);
						  object oMyForge = GetLocalObject(OBJECT_SELF, "oMyForge");
						  if (oMyForge == OBJECT_INVALID)
							 {oMyForge = GetObjectByTag("slv_tra200_forge");
							  SetLocalObject(OBJECT_SELF, "oMyForge", oMyForge);
							 }
						  SetUseableFlag(oMyForge, FALSE);
						  object oMyCauldron = GetLocalObject(OBJECT_SELF, "oMyCauldron");
						  if (oMyCauldron == OBJECT_INVALID)
							 {oMyCauldron = GetObjectByTag("slv_tra200_cauldron");
							  SetLocalObject(OBJECT_SELF, "oMyCauldron", oMyCauldron);
							 }
						  SetUseableFlag(oMyCauldron, FALSE);
						  object oMyTrough = GetLocalObject(OBJECT_SELF, "oMyTrough");
						  if (oMyTrough == OBJECT_INVALID)
							 {oMyTrough = GetObjectByTag("slv_tra200_trough");
							  SetLocalObject(OBJECT_SELF, "oMyTrough", oMyTrough);
							 }
						  SetUseableFlag(oMyTrough, FALSE);
						  object oIron1 = GetLocalObject(OBJECT_SELF, "oIron1");
						  object oIron2 = GetLocalObject(OBJECT_SELF, "oIron1");
						  object oIron3 = GetLocalObject(OBJECT_SELF, "oIron1");
						  object oIron4 = GetLocalObject(OBJECT_SELF, "oIron1");
						  object oAlloy1 = GetLocalObject(OBJECT_SELF, "oAlloy1");
						  if(oAlloy1 == OBJECT_INVALID)
						  	{oAlloy1 = GetObjectByTag("slv_tra200_ingot_alloy");
							}
						  DestroyObject(oIron1);
						  SetLocalObject(OBJECT_SELF, "oIron1", OBJECT_INVALID);
						  DestroyObject(oIron2);
						  SetLocalObject(OBJECT_SELF, "oIron2", OBJECT_INVALID);
						  DestroyObject(oIron3);
						  SetLocalObject(OBJECT_SELF, "oIron3", OBJECT_INVALID);
						  DestroyObject(oIron4);
						  SetLocalObject(OBJECT_SELF, "oIron4", OBJECT_INVALID);
						  DestroyObject(oAlloy1);
						  SetLocalObject(OBJECT_SELF, "oAlloy1", OBJECT_INVALID);
						   	  
						 }	 
						  	
	 if((GetTag(OBJECT_SELF) == "MH_Earth") && ((GetIsPC(oStudent))|| (GetIsDMPossessed(oStudent))) && (ACR_RetrieveQuestState("slv_deansphinx_e", oStudent) > 0))
	  		{object oTeleport = GetLocalObject(OBJECT_SELF, "oTeleport");
			 if(oTeleport == OBJECT_INVALID)
			 	{oTeleport = GetObjectByTag("slv_el_earth");
				 SetLocalObject(OBJECT_SELF, "oTeleport", oTeleport);
				 }
			DelayCommand(30.0,  SetUseableFlag(oTeleport, FALSE));
			 }
	if((GetTag(OBJECT_SELF) == "MH_Air") && ((GetIsPC(oStudent))|| (GetIsDMPossessed(oStudent)))&& (ACR_RetrieveQuestState("slv_deansphinx_e", oStudent) > 0))
	  		{object oTeleport = GetLocalObject(OBJECT_SELF, "oTeleport");
			 if(oTeleport == OBJECT_INVALID)
			 	{oTeleport = GetObjectByTag("slv_el_air");
				 SetLocalObject(OBJECT_SELF, "oTeleport", oTeleport);
				 }
			 DelayCommand(30.0, SetUseableFlag(oTeleport, FALSE));
			 }
			
		if((GetTag(OBJECT_SELF) == "MH_Fire") && ((GetIsPC(oStudent))|| (GetIsDMPossessed(oStudent)))&& (ACR_RetrieveQuestState("slv_deansphinx_e", oStudent) > 0))
	  		{object oTeleport = GetLocalObject(OBJECT_SELF, "oTeleport");
			 if(oTeleport == OBJECT_INVALID)
			 	{oTeleport = GetObjectByTag("slv_el_fire");
				 SetLocalObject(OBJECT_SELF, "oTeleport", oTeleport);
				 }
			 DelayCommand(30.0, SetUseableFlag(oTeleport, FALSE));
			}
			
		if((GetTag(OBJECT_SELF) == "MH_Water") && ((GetIsPC(oStudent))|| (GetIsDMPossessed(oStudent)))&& (ACR_RetrieveQuestState("slv_deansphinx_e", oStudent) > 0))
	  		{object oTeleport = GetLocalObject(OBJECT_SELF, "oTeleport");
			 if(oTeleport == OBJECT_INVALID)
			 	{oTeleport = GetObjectByTag("slv_el_water");
				 SetLocalObject(OBJECT_SELF, "oTeleport", oTeleport);
				 }
			 DelayCommand(30.0, SetUseableFlag(oTeleport, FALSE));
			 }
									
}