////////////////////////////////////////////////////////////////////////////////
//
//     Filename : slv_uni_spawn
//      Version : 1.1
//         Date : 2008-2-4
//       Author : Wynna
//
//  Description
//  

////////////////////////////////////////////////////////////////////////////////
#include "acr_db_persist_i"
#include "silvy_univ_func"
#include "silvy_univ_inc"
#include "acr_spawn_i"

void main()
{
	
	SetActionMode(OBJECT_SELF, ACTION_MODE_DETECT, TRUE);	

	object oArea = GetArea(OBJECT_SELF);
	int nAreaPC = GetLocalInt(oArea, "oPC");
	object oAreaPC = GetLocalObject(OBJECT_SELF, "oAreaPC");
	if((oAreaPC == OBJECT_INVALID) && (nAreaPC == 1))
		{oAreaPC = GetFirstPC(TRUE);
		 while(oAreaPC != OBJECT_INVALID)
			{if(GetArea(oAreaPC) == (GetArea(OBJECT_SELF)))
			 	{SetLocalObject(OBJECT_SELF, "oAreaPC", oAreaPC);
				 }
			  oAreaPC = GetNextPC(TRUE);
			}
	  }

SetLocalString(OBJECT_SELF, "MyTag", GetTag(OBJECT_SELF));		 

if((GetTag(OBJECT_SELF) != "003_cr_slv_registrar") && (GetTag(OBJECT_SELF) != "003_cr_slv_librarian") && (GetTag(OBJECT_SELF) != "003_cr_slv_belad")&& (FindSubString(GetTag(OBJECT_SELF), "_Wand") == -1))
	
	 {if(GetObjectByTag(GetTag(OBJECT_SELF), 1) != OBJECT_INVALID)
	 	{DestroyObject(OBJECT_SELF);
		}
	 
	} 
	
 if((FindSubString(GetTag(OBJECT_SELF), "_Wand") != -1)|| (FindSubString(GetTag(OBJECT_SELF), "_NoWalk") != -1))
 	{ClearAllActions(TRUE);
	 return;
	}	
	  
		
		if(IsStudentEnrolledInSilvyUniversity(OBJECT_SELF) == FALSE)
			{EnrollSilvyUniversityStudent(OBJECT_SELF);}
		
  	string sSchool;
	int nSchool;
			
	struct SilvyUniversityCourseInfo sInfo;
		 
	if((GetTag(OBJECT_SELF) == "003_cr_slv_registrar") || (GetIsDM(OBJECT_SELF)) || (GetIsDMPossessed(OBJECT_SELF))  || (FindSubString(GetName(OBJECT_SELF), "Wynna", 0) != -1))
		{sSchool = GetLocalString(OBJECT_SELF, "sSchool");
		 if(sSchool == "Abjuration")
		 	{SetSilvyUniversitySchool(SilvyUniversitySchoolAbjuration);
   		     }
	     if(sSchool == "Conjuration")
		 	{SetSilvyUniversitySchool(SilvyUniversitySchoolConjuration);
   		     }
	     if(sSchool == "Divination")
		 	{SetSilvyUniversitySchool(SilvyUniversitySchoolDivination);
   		     }
	     if(sSchool == "Enchantment")
		 	{SetSilvyUniversitySchool(SilvyUniversitySchoolEnchantment);
   		     }
	     if(sSchool == "Evocation")
		 	{SetSilvyUniversitySchool(SilvyUniversitySchoolEvocation);
   		     }
	     if(sSchool == "Illusion")
		 	{SetSilvyUniversitySchool(SilvyUniversitySchoolIllusion);
   		   	 }
	     if(sSchool == "Necromancy")
		 	{SetSilvyUniversitySchool(SilvyUniversitySchoolNecromancy);
   		     }
	     if(sSchool == "Transmutation")
		 	{SetSilvyUniversitySchool(SilvyUniversitySchoolTransmutation);
   		     }
		 
			object oStudent = GetPCSpeaker();
		    object oProfessor = OBJECT_SELF;
		    string sCurrentCourse;
		
		    int nSchool = GetSilvyUniversitySchool(oProfessor);
		    SetCustomToken(SilvyUniversitySchoolToken, SchoolToString(nSchool));
	        sCurrentCourse = GetSilvyUniversityCurrentSchoolRegistration(oStudent,
		        nSchool);
		
		    if (sCurrentCourse != "")
		    {
		        SetCustomToken(SilvyUniversityCourseNameToken, sCurrentCourse);
		    }

		}  	 
		
	
    // Specify the magic school for this creature.  Constants are in
    // silvy_univ_inc

		object oCurrent = GetNearestObject(OBJECT_TYPE_WAYPOINT, OBJECT_SELF, 1);
		object oClass = GetWaypointByTag(GetTag(OBJECT_SELF) + "_Class");
		object oStairs;
		object oClassLevel;
		object oMastersUp = GetWaypointByTag("GL3_Up_AT");
		object oMastersDown = GetWaypointByTag("GL3_Down_AT");
		object oMastersDowned = GetWaypointByTag("GL3_Down_AT_WP");
		object oLibraryUp = GetWaypointByTag("GL1_Up_AT");
		object oLibraryUpped = GetWaypointByTag("GL1_Up_AT_WP");
		object oSpawn = GetNearestObject(OBJECT_TYPE_WAYPOINT, OBJECT_SELF, 1);
		object oGoTo = GetNearestObject(OBJECT_TYPE_WAYPOINT, OBJECT_SELF, Random(100) + 5);
		if((GetTag(OBJECT_SELF) == "003_cr_slv_dean") || (GetTag(OBJECT_SELF) == "003_cr_slv_arken") ||(GetTag(OBJECT_SELF) == "003_cr_slv_miresk"))
			{oGoTo = GetNearestObject(OBJECT_TYPE_WAYPOINT, OBJECT_SELF, Random(10) + 1);
			} 
		object oDown;
		object oDowned;
		object oLobby;
		object oHome;
		int nTime100;
		int nTime200;
		int nTime300;
		int nTime400;
		int nTimeRandom = Random(24);
		int nHour = GetTimeHour(); 
		int nMinute = GetTimeMinute();
		int nHome;
		float fTime = 90.0;
		float fTime2 = IntToFloat(Random(200) + 100);
		

    
	 
	if(FindSubString(GetTag(OBJECT_SELF), "abj") != -1)
		{sSchool = "Abjuration";
		 oDown = GetWaypointByTag("Abjuration2_Down_AT");
		 oDowned = GetWaypointByTag("Abjuration2_Down_AT_WP");
		//Proc/Prof spawn in at 8; Stud 9
		 nTime100 = 9;
		 nTime200 = 13;
		 nTime300 = 17;
		 nTime400 = 0;
		 nHome = 1;
		//Proc/Prof/spawn out at 2; stud at 20
    	 SetSilvyUniversitySchool(SilvyUniversitySchoolAbjuration);
   		 }
		 
	if((FindSubString(GetTag(OBJECT_SELF), "con") != -1) || (GetTag(OBJECT_SELF) == "003_cr_slv_miresk")|| (GetTag(OBJECT_SELF) == "003_cr_slv_scribe"))
		{sSchool = "Conjuration";
		 oDown = GetWaypointByTag("Conjuration2_Down_AT");
		 oDowned = GetWaypointByTag("Conjuration2_Down_AT_WP");
		//Proc/Prof spawn in at 5
		 nTime100 = 6;
		 nTime200 = 8;
		 nTime300 = 10;
		 nTime400 = 12;
		 nHome = 14;
		//Proc/Prof spawn out at 23/15
		 SetSilvyUniversitySchool(SilvyUniversitySchoolConjuration);
  		}
		 
	if((FindSubString(GetTag(OBJECT_SELF), "div") != -1) || (GetTag(OBJECT_SELF) == "003_cr_slv_dean")  || (GetTag(OBJECT_SELF) == "slv_proc_arizmazul"))
		{sSchool = "Divination";
		 oDown = GetWaypointByTag("Divination2_Down_AT");
		 oDowned = GetWaypointByTag("Divination2_Down_AT_WP");
		//Proc/Prof spawn in at 8; stud at 9
		 nTime100 = 10;
		 nTime200 = 12;
		 nTime300 = 14;
		 nTime400 = 0;
		 nHome = 1;
		//Proc/Prof/spawn out at 2; stud at 20
		 SetSilvyUniversitySchool(SilvyUniversitySchoolDivination);
  		 }
		 
	if(FindSubString(GetTag(OBJECT_SELF), "enc") != -1)
		{sSchool = "Enchantment";
		 oDown = GetWaypointByTag("Enchantment2_Down_AT");
		 oDowned = GetWaypointByTag("Enchantment2_Down_AT_WP");
		//Proc/Prof/Stud spawn in at 1/23/9
		 nTime100 = 19;
		 nTime200 = 9;
		 nTime300 = 6;
		 nTime400 = 3;
		 nHome = 20;
		//Proc/Prof/spawn out at 21; stud at 20
		 SetSilvyUniversitySchool(SilvyUniversitySchoolEnchantment);
  		 }
		 
	if((FindSubString(GetTag(OBJECT_SELF), "evo") != -1) || (GetTag(OBJECT_SELF) == "003_cr_slv_arken"))
		{sSchool = "Evocation";
		 oDown = GetWaypointByTag("Evocation2_Down_AT");
		 oDowned = GetWaypointByTag("Evocation2_Down_AT_WP");
		//Proc/Prof spawn in at 6
		 nTime100 = Random(24);
		 nTime200 = Random(24);
		 nTime300 = Random(24);
		 nTime400 = Random(24);
		 nHome = 23;
		//Proc/Prof/spawn out at 1
		 SetSilvyUniversitySchool(SilvyUniversitySchoolEvocation);
  		 }
		 
	if(FindSubString(GetTag(OBJECT_SELF), "ill") != -1)
		{sSchool = "Illusion";
		 oDown = GetWaypointByTag("Illusion2_Down_AT");
		 oDowned = GetWaypointByTag("Illusion2_Down_AT_WP");
		//Proc/Prof spawn in at 10
		 nTime100 = 20;
		 nTime200 = 16;
		 nTime300 = 14;
		 nTime400 = 12;
		 nHome = 1;
		//Proc/Prof/spawn out at 2
		 SetSilvyUniversitySchool(SilvyUniversitySchoolIllusion);
  		 }
		 	
    if(FindSubString(GetTag(OBJECT_SELF), "nec") != -1)
		{sSchool = "Necromancy";
		 oDown = GetWaypointByTag("Necromancy2_Down_AT");
		 oDowned = GetWaypointByTag("Necromancy2_Down_AT_WP");
		//Proc/Prof spawn in at 17; stud at 12
		 nTime100 = 12;
		 nTime200 = 6;
		 nTime300 = 18;
	     nTime400 = 0;
	     nHome = 8;
		//Proc/Prof/stud spawn out at 8/16/20
		 SetSilvyUniversitySchool(SilvyUniversitySchoolNecromancy);
  		 }
		
	if(((FindSubString(GetTag(OBJECT_SELF), "tra") != -1) || (GetTag(OBJECT_SELF) == "003_cr_slv_belad")) && (GetTag(OBJECT_SELF) != "003_cr_slv_registrar"))
		{sSchool = "Transmutation";
		 oDown = GetWaypointByTag("Transmutation2_Down_AT");
		 oDowned = GetWaypointByTag("Transmutation2_Down_AT_WP");
		//Proc/Prof/Stud spawn in at 7/8/12
		 nTime100 = 13;
		 nTime200 = 14;
		 nTime300 = 15;
		 nTime400 = 16;
		 nHome = 20;
		//Proc/Prof/spawn out at 21; stud at 20
		 SetSilvyUniversitySchool(SilvyUniversitySchoolTransmutation);
  		 }
	
	if((FindSubString(GetTag(OBJECT_SELF), "gen") != -1) || (GetTag(OBJECT_SELF) == "003_cr_slv_librarian")|| (GetTag(OBJECT_SELF) == "003_cr_slv_librarian2")|| (GetTag(OBJECT_SELF) == "003_cr_slv_Spellguard")|| (GetTag(OBJECT_SELF) == "003_cr_slv_augustine"))
		{sSchool = "General";
		 oDown = GetWaypointByTag("GL2_Down_AT");
		 oDowned = GetWaypointByTag("GL2_Down_AT_WP");
		 nTime100 = Random(24);
		 nTime200 = Random(24);
		 nTime300 = Random(24);
		 nTime400 = Random(24);
		 nHome = Random(24);
		 SetSilvyUniversitySchool(SilvyUniversitySchoolUndefined);
  		}		
		
		 SetLocalString(OBJECT_SELF, sSchool, sSchool);
		 SetSilvyUniversityCourse("Elementary " + sSchool, 100, 50, "slv_100classes", 50, (nTime100), "" );
	     SetSilvyUniversityCourse("Standard " + sSchool, 200, 100, "slv_200classes", 100, (nTime200), ""  );
	     SetSilvyUniversityCourse("Advanced " + sSchool, 300, 200, "slv_300classes", 200, (nTime300), "" );
	     SetSilvyUniversityCourse("Senior " + sSchool, 400, 250, "slv_400classes",   250, (nTime400), ""  );
		 SetSilvyUniversityFinal(250, 15, 250, 0, "" );  
		 // DC no longer used for final exams. Used to offer choice of dice roll or quest. Now all quest.
		 
			 					
			if((FindSubString(GetName(oGoTo), "Proc") != -1) ||(FindSubString(GetName(oGoTo), "Library_Stairs_Chair") != -1) ||(FindSubString(GetName(oGoTo), "Secret") != -1) ||(FindSubString(GetName(oGoTo), "Dean") != -1) 
		   		|| (FindSubString(GetName(oGoTo), "Library_All_Librarian") != -1) ||(FindSubString(GetName(oGoTo), "Random") != -1)||(FindSubString(GetName(oGoTo), "Quest") != -1)||(FindSubString(GetName(oGoTo), "CollBox") != -1)
				|| (FindSubString(GetName(oGoTo), "Center") != -1) ||(FindSubString(GetName(oGoTo), "Entry_North_AT") != -1) ||(FindSubString(GetName(oGoTo), "LadyHall") != -1)||(FindSubString(GetName(oGoTo), "Dorm_1") != -1)
				|| (FindSubString(GetName(oGoTo), "Dorm_3") != -1) || (FindSubString(GetName(oGoTo), "MH") != -1) || (FindSubString(GetName(oGoTo), "MT") != -1) 
				|| ((FindSubString(GetName(oGoTo), "Dorm_2") != -1) && (GetStringLeft(GetName(OBJECT_SELF), 3) != GetStringLeft(GetName(oGoTo), 3))))
				 			 { oGoTo = GetNearestObject(OBJECT_TYPE_WAYPOINT, OBJECT_SELF, Random(50) + 5);
							   if((FindSubString(GetName(oGoTo), "Proc") != -1) ||(FindSubString(GetName(oGoTo), "Library_Stairs_Chair") != -1) ||(FindSubString(GetName(oGoTo), "Secret") != -1) ||(FindSubString(GetName(oGoTo), "Dean") != -1) 
						   		|| (FindSubString(GetName(oGoTo), "Library_All_Librarian") != -1) ||(FindSubString(GetName(oGoTo), "Random") != -1)||(FindSubString(GetName(oGoTo), "Quest") != -1)||(FindSubString(GetName(oGoTo), "CollBox") != -1)
								|| (FindSubString(GetName(oGoTo), "Center") != -1) ||(FindSubString(GetName(oGoTo), "Entry_North_AT") != -1) ||(FindSubString(GetName(oGoTo), "LadyHall") != -1)||(FindSubString(GetName(oGoTo), "Dorm_1") != -1)
								|| (FindSubString(GetName(oGoTo), "Dorm_3") != -1) || (FindSubString(GetName(oGoTo), "MH") != -1) || (FindSubString(GetName(oGoTo), "MT") != -1) 
								|| ((FindSubString(GetName(oGoTo), "Dorm_2") != -1) && (GetStringLeft(GetName(OBJECT_SELF), 3) != GetStringLeft(GetName(oGoTo), 3))))
						 			   {oGoTo = GetNearestObject(OBJECT_TYPE_WAYPOINT, OBJECT_SELF, Random(50) + 5);
									    if((FindSubString(GetName(oGoTo), "Proc") != -1) ||(FindSubString(GetName(oGoTo), "Library_Stairs_Chair") != -1) ||(FindSubString(GetName(oGoTo), "Secret") != -1) ||(FindSubString(GetName(oGoTo), "Dean") != -1) 
									   		|| (FindSubString(GetName(oGoTo), "Library_All_Librarian") != -1) ||(FindSubString(GetName(oGoTo), "Random") != -1)||(FindSubString(GetName(oGoTo), "Quest") != -1)||(FindSubString(GetName(oGoTo), "CollBox") != -1)
											|| (FindSubString(GetName(oGoTo), "Center") != -1) ||(FindSubString(GetName(oGoTo), "Entry_North_AT") != -1) ||(FindSubString(GetName(oGoTo), "LadyHall") != -1)||(FindSubString(GetName(oGoTo), "Dorm_1") != -1)
											|| (FindSubString(GetName(oGoTo), "Dorm_3") != -1) || (FindSubString(GetName(oGoTo), "MH") != -1) || (FindSubString(GetName(oGoTo), "MT") != -1) 
											|| ((FindSubString(GetName(oGoTo), "Dorm_2") != -1) && (GetStringLeft(GetName(OBJECT_SELF), 3) != GetStringLeft(GetName(oGoTo), 3))))
									 			   {oGoTo = oClass;
												   PlayAnimation(ANIMATION_FIREFORGET_READ, 1.0);
												   DelayCommand(fTime2/3,  PlayAnimation(ANIMATION_FIREFORGET_READ, 1.0));
												   DelayCommand(fTime2/2,  PlayAnimation(ANIMATION_FIREFORGET_READ, 1.0));
												   DelayCommand(fTime2 - 10.0,  PlayAnimation(ANIMATION_FIREFORGET_READ, 1.0));
							     				   }
										}
							}			
				 
	if((FindSubString(GetName(oGoTo), "Chair") != -1) || (FindSubString(GetName(oGoTo), "Bench") != -1) || (FindSubString(GetName(oGoTo), "Stool") != -1)|| (FindSubString(GetName(oGoTo), "Sofa") != -1)|| (FindSubString(GetName(oGoTo), "Cushion") != -1))
				{if((((GetCreatureSize(OBJECT_SELF) == CREATURE_SIZE_MEDIUM) && (FindSubString(GetName(oGoTo), "Low") != -1)) || ((GetCreatureSize(OBJECT_SELF) == CREATURE_SIZE_SMALL) && (FindSubString(GetName(oGoTo), "Low") == -1)))	
				 	 || (GetName(oGoTo) == "ComE_Set1_Chair1_WP") || (GetName(oGoTo) == "ComE_Set1_Chair2_WP") || (GetName(oGoTo) == "ComE_Set1_Low_Chair3_WP")	)
					 				   {oGoTo = GetNearestObject(OBJECT_TYPE_WAYPOINT, OBJECT_SELF, Random(50) + 5);
							   			if((FindSubString(GetName(oGoTo), "Chair") != -1) || (FindSubString(GetName(oGoTo), "Bench") != -1) || (FindSubString(GetName(oGoTo), "Stool") != -1)|| (FindSubString(GetName(oGoTo), "Sofa") != -1)|| (FindSubString(GetName(oGoTo), "Cushion") != -1))
										{if((((GetCreatureSize(OBJECT_SELF) == CREATURE_SIZE_MEDIUM) && (FindSubString(GetName(oGoTo), "Low") != -1)) || ((GetCreatureSize(OBJECT_SELF) == CREATURE_SIZE_SMALL) && (FindSubString(GetName(oGoTo), "Low") == -1)))	
										 	 || (GetName(oGoTo) == "ComE_Set1_Chair1_WP") || (GetName(oGoTo) == "ComE_Set1_Chair2_WP") || (GetName(oGoTo) == "ComE_Set1_Low_Chair3_WP")	)
							 				   {oGoTo = oClass;
									   			PlayAnimation(ANIMATION_FIREFORGET_READ, 1.0);
												DelayCommand(fTime2/3,  PlayAnimation(ANIMATION_FIREFORGET_READ, 1.0));
											    DelayCommand(fTime2/2,  PlayAnimation(ANIMATION_FIREFORGET_READ, 1.0));
											    DelayCommand(fTime2 - 10.0,  PlayAnimation(ANIMATION_FIREFORGET_READ, 1.0));
											 	}
										 	
											}
									  }	
						}	
		
		if(FindSubString(GetName(oGoTo), "_AT") != -1)
				{object oWentTo = GetWaypointByTag(GetTag(oGoTo) + "_WP");
				 DelayCommand(5.0, ActionForceMoveToObject(oGoTo, FALSE, 0.0, 60.0));
				 DelayCommand(35.0, ActionJumpToObject(oWentTo, TRUE));
				 }
					
					
	if (FindSubString(GetTag(OBJECT_SELF), "stud") != -1) 
		{ nHome = Random(24);
		  nSchool = GetSilvyUniversitySchool(OBJECT_SELF);
          if(GetSilvyUniversitySchoolLevel(OBJECT_SELF, nSchool) == 0)
		  	{ sInfo = GetSilvyUniversityNextSchoolCourse(OBJECT_SELF, OBJECT_SELF);
	          RegisterSilvyUniversityStudent(OBJECT_SELF, sInfo);
	      	}
		  	if((GetTag(oArea) == "6d_int_silvy_ladycol_class_lvl") && (nHour == nTime100))
					{oLobby = GetNearestObject(OBJECT_TYPE_WAYPOINT, oLibraryUpped, Random(10));
					 oGoTo = oLobby;
					 DelayCommand(10.0, ActionForceMoveToObject(oLibraryUp, FALSE, 0.0, 60.0));
					 DelayCommand(45.0, ActionJumpToObject(oLibraryUpped, TRUE));
					 DelayCommand(55.0, ActionForceMoveToObject(oLobby, FALSE, 0.0, 60.0));
					 DelayCommand(90.0, ActionJumpToObject(oLobby, TRUE));
					}
			   else if((GetTag(oArea) == "6d_int_silvy_ladycol_grd_lvl") && (nHour == nTime100))
					{oLobby = GetNearestObject(OBJECT_TYPE_WAYPOINT, oLibraryUpped, Random(10));
					 oGoTo = oLobby;
					 DelayCommand(10.0, ActionForceMoveToObject(oLobby, FALSE, 0.5, 60.0));
					 }		
				 }
		  
    if (FindSubString(GetTag(OBJECT_SELF), "proc") != -1) 
		 {nSchool = GetSilvyUniversitySchool(OBJECT_SELF);
          if(GetSilvyUniversitySchoolLevel(OBJECT_SELF, nSchool) < 400)
		  	{ sInfo = GetSilvyUniversityNextSchoolCourse(OBJECT_SELF, OBJECT_SELF);
	          RegisterSilvyUniversityStudent(OBJECT_SELF, sInfo);
	      	  if(GetSilvyUniversitySchoolLevel(OBJECT_SELF, nSchool) < 400)
			  	{ sInfo = GetSilvyUniversityNextSchoolCourse(OBJECT_SELF, OBJECT_SELF);
		          RegisterSilvyUniversityStudent(OBJECT_SELF, sInfo);
		      	  if(GetSilvyUniversitySchoolLevel(OBJECT_SELF, nSchool) < 400)
				  	{ sInfo = GetSilvyUniversityNextSchoolCourse(OBJECT_SELF, OBJECT_SELF);
			          RegisterSilvyUniversityStudent(OBJECT_SELF, sInfo);
			      	  if(GetSilvyUniversitySchoolLevel(OBJECT_SELF, nSchool) < 400)
					  	{ sInfo = GetSilvyUniversityNextSchoolCourse(OBJECT_SELF, OBJECT_SELF);
				          RegisterSilvyUniversityStudent(OBJECT_SELF, sInfo);
				      	}
					}
				}
			  }
		  	if((GetTag(oArea) == "6d_int_silvy_ladycol_class_lvl") && ((nHour == nTime300) || (nHour == nTime400)))
					{oGoTo = oClass;
					 DelayCommand(10.0, ActionForceMoveToObject(oLibraryUp, FALSE, 0.0, 60.0));
					 DelayCommand(45.0, ActionJumpToObject(oLibraryUpped, TRUE));
					 DelayCommand(55.0, ActionForceMoveToObject(oClass, FALSE, 0.0, 60.0));
					 DelayCommand(90.0, ActionJumpToObject(oClass, TRUE));
					}
				  else if((GetTag(oArea) == "6d_int_silvy_ladycol_grd_lvl")&& ((nHour == nTime300) || (nHour == nTime400)))
					{oGoTo = oClass;
					 DelayCommand(10.0, ActionForceMoveToObject(oClass, FALSE, 0.0, 60.0));
					 DelayCommand(45.0, ActionJumpToObject(oClass, TRUE));
					 }	
				
		 }
		 
	if ((FindSubString(GetTag(OBJECT_SELF), "prof") != -1) || (FindSubString(GetTag(OBJECT_SELF), "belad") != -1)  
		||(FindSubString(GetTag(OBJECT_SELF), "librarian") != -1) ||(FindSubString(GetTag(OBJECT_SELF), "registrar") != -1)) 
		{nSchool = GetSilvyUniversitySchool(OBJECT_SELF);
          if(GetSilvyUniversitySchoolLevel(OBJECT_SELF, nSchool) < 500)
		  	{ sInfo = GetSilvyUniversityNextSchoolCourse(OBJECT_SELF, OBJECT_SELF);
	          RegisterSilvyUniversityStudent(OBJECT_SELF, sInfo);
	      	  if(GetSilvyUniversitySchoolLevel(OBJECT_SELF, nSchool) < 500)
			  	{ sInfo = GetSilvyUniversityNextSchoolCourse(OBJECT_SELF, OBJECT_SELF);
		          RegisterSilvyUniversityStudent(OBJECT_SELF, sInfo);
		      	  if(GetSilvyUniversitySchoolLevel(OBJECT_SELF, nSchool) < 500)
				  	{ sInfo = GetSilvyUniversityNextSchoolCourse(OBJECT_SELF, OBJECT_SELF);
			          RegisterSilvyUniversityStudent(OBJECT_SELF, sInfo);
			      	  if(GetSilvyUniversitySchoolLevel(OBJECT_SELF, nSchool) < 500)
					  	{ sInfo = GetSilvyUniversityNextSchoolCourse(OBJECT_SELF, OBJECT_SELF);
				          RegisterSilvyUniversityStudent(OBJECT_SELF, sInfo);
				      	  if(GetSilvyUniversitySchoolLevel(OBJECT_SELF, nSchool) < 500)
						  	{ sInfo = GetSilvyUniversityNextSchoolCourse(OBJECT_SELF, OBJECT_SELF);
					          RegisterSilvyUniversityStudent(OBJECT_SELF, sInfo);
					      	}
						}
					}
				}
			}
				
			
	if(GetTag(OBJECT_SELF) == "003_cr_slv_registrar")
		{SetLocalInt(OBJECT_SELF, "Walk_Off", 1);
		 ClearAllActions(TRUE);
		 return;
		 }

			if(((((GetTag(oArea) == "6d_int_silvy_ladycol_grd_lvl")||(GetTag(oArea) == "6d_int_silvy_ladycol_master_lvl")) && ((nHour == nTime100) || (nHour == nTime200)|| (nHour == nTime300) || (nHour == nTime400)))) || (oGoTo == oClass))
					{if((oGoTo != oClass) && (GetTag(OBJECT_SELF) != "003_cr_slv_arken") && (GetTag(OBJECT_SELF) != "003_cr_slv_miresk")&& (GetTag(OBJECT_SELF) != "003_cr_slv_dean"))
						{SpeakString("Excuse me, I need to get to class.", TALKVOLUME_TALK);
						}
						if(oClass != OBJECT_INVALID)
						 	{oGoTo = oClass;
							}
						else
							{oGoTo = GetNearestObject(OBJECT_TYPE_PLACEABLE, OBJECT_SELF, Random(5));
					 		}
					 if(GetTag(oArea) == "6d_int_silvy_ladycol_grd_lvl")
					 	{oStairs = GetWaypointByTag("GL1_Up_AT");
						 oClassLevel = GetWaypointByTag("GL1_Up_AT_WP");;
						}
					 if(GetTag(oArea) == "6d_int_silvy_ladycol_master_lvl")
					 	{oStairs = GetWaypointByTag("GL3_Down_AT");
						 oClassLevel = GetWaypointByTag("GL3_Down_AT_WP");
						 }
					  if(GetObjectType(oGoTo) == OBJECT_TYPE_WAYPOINT) 
						  {DelayCommand(5.0, ActionMoveToObject(oStairs, FALSE, 0.0));
						  DelayCommand(35.0, ActionJumpToObject(oClassLevel, TRUE));
						  DelayCommand(45.0, ActionMoveToObject(oClass, FALSE, 0.0));
						  DelayCommand(60.0, ActionJumpToObject(oClass, TRUE));
					 	 }
					 }
				 else if((GetTag(oArea) == "6d_int_silvy_ladycol_class_lvl")&& ((nHour == nTime100) || (nHour == nTime200)|| (nHour == nTime300) || (nHour == nTime400)))
					{oGoTo = oClass;
					 DelayCommand(5.0, ActionMoveToObject(oClass, FALSE, 0.0));
					 DelayCommand(35.0, ActionJumpToObject(oClass, TRUE));
					 }
				
		  }

		if ((FindSubString(GetTag(OBJECT_SELF), "dean") != -1)|| (FindSubString(GetTag(OBJECT_SELF), "Spellguard") != -1)||(FindSubString(GetTag(OBJECT_SELF), "arken") != -1) ||(FindSubString(GetTag(OBJECT_SELF), "miresk") != -1))
		 {nSchool = SilvyUniversitySchoolUndefined;
          if(GetSilvyUniversitySchoolLevel(OBJECT_SELF, nSchool) < 500)
		  	{ sInfo = GetSilvyUniversityNextSchoolCourse(OBJECT_SELF, OBJECT_SELF);
	          RegisterSilvyUniversityStudent(OBJECT_SELF, sInfo);
	      	  if(GetSilvyUniversitySchoolLevel(OBJECT_SELF, nSchool) < 500)
			  	{ sInfo = GetSilvyUniversityNextSchoolCourse(OBJECT_SELF, OBJECT_SELF);
		          RegisterSilvyUniversityStudent(OBJECT_SELF, sInfo);
		      	  if(GetSilvyUniversitySchoolLevel(OBJECT_SELF, nSchool) < 500)
				  	{ sInfo = GetSilvyUniversityNextSchoolCourse(OBJECT_SELF, OBJECT_SELF);
			          RegisterSilvyUniversityStudent(OBJECT_SELF, sInfo);
			      	  if(GetSilvyUniversitySchoolLevel(OBJECT_SELF, nSchool) < 500)
					  	{ sInfo = GetSilvyUniversityNextSchoolCourse(OBJECT_SELF, OBJECT_SELF);
				          RegisterSilvyUniversityStudent(OBJECT_SELF, sInfo);
				      	  if(GetSilvyUniversitySchoolLevel(OBJECT_SELF, nSchool) < 500)
						  	{ sInfo = GetSilvyUniversityNextSchoolCourse(OBJECT_SELF, OBJECT_SELF);
					          RegisterSilvyUniversityStudent(OBJECT_SELF, sInfo);
					      	}
						}
					}
				}
			}
			
		   {if((nHour >= nTimeRandom) && (nHour <= nTimeRandom + 3))
			{if(GetTag(oArea) == "6d_int_silvy_ladycol_grd_lvl")
					 	{oStairs = GetWaypointByTag("GL1_Up_AT");
						 oClassLevel = GetWaypointByTag("GL1_Up_AT_WP");;
						 DelayCommand(5.0, ActionMoveToObject(oStairs, FALSE, 0.0));
					     DelayCommand(35.0, ActionJumpToObject(oClassLevel, TRUE));
					     }
					if(GetTag(oArea) == "6d_int_silvy_ladycol_class_lvl")
					 	{oStairs = GetWaypointByTag("GL1_Down_AT");
						 oClassLevel = GetWaypointByTag("GL1_Down_AT_WP");;
						 DelayCommand(5.0, ActionMoveToObject(oStairs, FALSE, 0.0));
					     DelayCommand(35.0, ActionJumpToObject(oClassLevel, TRUE));
					     }
					 if(GetTag(oArea) == "6d_int_silvy_ladycol_master_lvl")
					 	{oStairs = GetWaypointByTag("GL3_Down_AT");
						 oClassLevel = GetWaypointByTag("GL3_Down_AT_WP");
						 DelayCommand(5.0, ActionMoveToObject(oStairs, FALSE, 0.0));
					     DelayCommand(35.0, ActionJumpToObject(oClassLevel, TRUE));
					     }
					  
					  oGoTo = GetNearestObject(OBJECT_TYPE_WAYPOINT, oClassLevel, Random(100));
					  DelayCommand(55.0, ActionMoveToObject(oGoTo, FALSE, 0.0));
					  
			  } 
			  if(nHour >= 21)		
					  {if(GetTag(oArea) == "6d_int_silvy_ladycol_grd_lvl")
					 	{oStairs = GetWaypointByTag("GL1_Up_AT");
						 oClassLevel = GetWaypointByTag("GL1_Up_AT_WP");;
						 DelayCommand(5.0, ActionMoveToObject(oStairs, FALSE, 0.0));
					     DelayCommand(35.0, ActionJumpToObject(oClassLevel, TRUE));
					     }
					if(GetTag(oArea) == "6d_int_silvy_ladycol_class_lvl")
					 	{oStairs = GetWaypointByTag("GL3_Up_AT");
						 oClassLevel = GetWaypointByTag("GL3_Up_AT_WP");;
						 DelayCommand(5.0, ActionMoveToObject(oStairs, FALSE, 0.0));
					     DelayCommand(35.0, ActionJumpToObject(oClassLevel, TRUE));
					     }
					  
					   object oGoToSameArea = GetNearestObject(OBJECT_TYPE_WAYPOINT, OBJECT_SELF, Random(10));
					   DelayCommand(45.0, ActionMoveToObject(oGoToSameArea, FALSE, 0.0));
					   }
				 }	
		  
				 	
		  }	
		  		 
 if ((GetTag(OBJECT_SELF) == "003_cr_slv_enc100giant") || (GetTag(OBJECT_SELF) == "003_cr_slv_ill100boy"))
		 {nSchool = GetSilvyUniversitySchool(OBJECT_SELF);
          if(GetSilvyUniversitySchoolLevel(OBJECT_SELF, nSchool) < 400)
		  	{ sInfo = GetSilvyUniversityNextSchoolCourse(OBJECT_SELF, OBJECT_SELF);
	          RegisterSilvyUniversityStudent(OBJECT_SELF, sInfo);
	      	  if(GetSilvyUniversitySchoolLevel(OBJECT_SELF, nSchool) < 400)
			  	{ sInfo = GetSilvyUniversityNextSchoolCourse(OBJECT_SELF, OBJECT_SELF);
		          RegisterSilvyUniversityStudent(OBJECT_SELF, sInfo);
		      	  if(GetSilvyUniversitySchoolLevel(OBJECT_SELF, nSchool) < 400)
				  	{ sInfo = GetSilvyUniversityNextSchoolCourse(OBJECT_SELF, OBJECT_SELF);
			          RegisterSilvyUniversityStudent(OBJECT_SELF, sInfo);
			      	  if(GetSilvyUniversitySchoolLevel(OBJECT_SELF, nSchool) < 400)
					  	{ sInfo = GetSilvyUniversityNextSchoolCourse(OBJECT_SELF, OBJECT_SELF);
				          RegisterSilvyUniversityStudent(OBJECT_SELF, sInfo);
				      	}
					}
				}
			  }
			 ClearAllActions();
			 return;
		}	 
		 
if(GetTag(OBJECT_SELF) == "003_cr_slv_procenc2")
  { if(GetObjectByTag(GetTag(OBJECT_SELF), 1) != OBJECT_INVALID)
  	{object oOtherSelf = (GetObjectByTag(GetTag(OBJECT_SELF), 1));
	 oGoTo = GetLocalObject(oOtherSelf, "Down");
	 AssignCommand(oOtherSelf, ClearAllActions(FALSE));
	 AssignCommand(oOtherSelf, SpeakString("Excuse me. I'm better than you and I really must go.", TALKVOLUME_TALK));
	 AssignCommand(oOtherSelf, ActionForceMoveToObject(oGoTo, FALSE, 0.0));
	 DestroyObject(oOtherSelf, 20.0);
	 }     
   }
   
  
	SetLocalInt(OBJECT_SELF, "Time100", nTime100);
	SetLocalInt(OBJECT_SELF, "Time200", nTime200);
	SetLocalInt(OBJECT_SELF, "Time300", nTime300);
	SetLocalInt(OBJECT_SELF, "Time400", nTime400);
	SetLocalInt(OBJECT_SELF, "TimeRandom", nTimeRandom);
	SetLocalInt(OBJECT_SELF, "Home", nHome);
	SetLocalObject(OBJECT_SELF, "Home", oSpawn);
	SetLocalString(OBJECT_SELF, GetTag(GetArea(oSpawn)), GetTag(GetArea(oSpawn)));
	SetLocalObject(OBJECT_SELF, "Down", oDown);
	SetLocalObject(OBJECT_SELF, "Downed", oDowned);
	SetLocalObject(OBJECT_SELF, "MastersUp", oMastersUp);
	SetLocalObject(OBJECT_SELF, "MastersDown", oMastersDown);
	SetLocalObject(OBJECT_SELF, "MastersDowned", oMastersDowned);
	SetLocalObject(OBJECT_SELF, "LibraryUp", oLibraryUp);
	SetLocalObject(OBJECT_SELF, "LibraryUpped", oLibraryUpped);
	SetLocalObject(OBJECT_SELF, "Class", oClass);
	SetLocalObject(OBJECT_SELF, "GoTo", oGoTo);


if(oGoTo != oClass)
	{DelayCommand(5.0, ActionMoveToObject(oGoTo, FALSE, 0.0));	
	}
	
if((FindSubString(GetName(oGoTo), "Chair") != -1) || (FindSubString(GetName(oGoTo), "Bench") != -1) || (FindSubString(GetName(oGoTo), "Stool") != -1)|| (FindSubString(GetName(oGoTo), "Sofa") != -1)|| (FindSubString(GetName(oGoTo), "Cushion") != -1))
		{string sSit = "slv_mid_sitbox";
		if(GetCreatureSize(OBJECT_SELF) == CREATURE_SIZE_SMALL)
			{sSit = "slv_low_sitbox";}
		object oSit = CreateObject(OBJECT_TYPE_PLACEABLE, sSit, GetLocation(oGoTo));
		SetLocalObject(OBJECT_SELF, "oSit", oSit);
		DelayCommand(fTime, DoPlaceableObjectAction(oSit, PLACEABLE_ACTION_USE));
		}		
		

if(FindSubString(GetName(oGoTo), "Middle") != -1) 
		{if(GetCreatureSize(OBJECT_SELF) == CREATURE_SIZE_MEDIUM)
			{DelayCommand(fTime, DoPlaceableObjectAction(oGoTo, PLACEABLE_ACTION_USE));
			}		
		}	
		
if(FindSubString(GetName(oGoTo), "Low Box") != -1) 
		{if(GetCreatureSize(OBJECT_SELF) == CREATURE_SIZE_SMALL)
			{DelayCommand(fTime, DoPlaceableObjectAction(oGoTo, PLACEABLE_ACTION_USE));
			}		
		}	
							
if((FindSubString(GetTag(OBJECT_SELF), "_Wand") == -1)	&& 	(FindSubString(GetTag(OBJECT_SELF), "_NoWalk") == -1))			
	{if((FindSubString(GetTag(OBJECT_SELF), "pro") != -1) || (FindSubString(GetTag(OBJECT_SELF), "stud") != -1)|| (FindSubString(GetTag(OBJECT_SELF), "Spellguard") != -1)|| (FindSubString(GetTag(OBJECT_SELF), "augustine") != -1)
	|| (FindSubString(GetTag(OBJECT_SELF), "dean") != -1)|| (FindSubString(GetTag(OBJECT_SELF), "arken") != -1)|| (FindSubString(GetTag(OBJECT_SELF), "miresk") != -1))				 			  	
		  { DelayCommand(fTime2, ExecuteScript("slv_uni_walk", OBJECT_SELF));
	   		}
	 }  
 	
	 

	
}