#include "silvy_univ_inc"
#include "silvy_univ_func"
#include "acr_placeable_i"
#include "acr_spawn_i"
#include "acr_tools_i"
#include "acr_quest_i"


    //OnClose actions for Silvy secretary desk for advanced coursework


void main()

{
    object oStudent = GetLastClosedBy();
    object oDesk = OBJECT_SELF;
    object oRegistrarLockBox = GetLocalObject(OBJECT_SELF, "RegistrarLockBox");
	if(oRegistrarLockBox == OBJECT_INVALID)
		{oRegistrarLockBox = GetObjectByTag("slv_registrar_lockbox_plc");
		 SetLocalObject(OBJECT_SELF, "RegistrarLockBox", oRegistrarLockBox);
		 }
	 
	int nSchool = GetSilvyUniversitySchool(oDesk);
    string sSchool = SchoolToString(nSchool);
	string sCurrentCourse = GetSilvyUniversityCurrentSchoolRegistration(oStudent, nSchool);
    string sJournal = SchoolToString(nSchool);
    int nLevel = GetSilvyUniversitySchoolLevel(oStudent, nSchool);
    string sLevel = IntToString(nLevel);
    string sProctor1 = "Proctor1";  
    string sProctor2 = "Proctor2";  
    string sProctor3 = "Proctor3"; 
    object oTest = GetItemPossessedBy(oDesk, "slv_test");
    string sQuestion = GetLocalString(oTest, "#T");
    string sTest = GetLocalString(oTest, "#M");
    string sName = GetLocalString(oTest, "#N");
	string sClasswork = sSchool + " 300";
	string s1a;
    string s1b;
    string s1c;
    string s1d;
    string s1e;
    string s2a;
    string s2b;
    string s2c;
    string s2d;
    string s2e;
    string s2f;
    string s2g;
    string s2h;
    string s2i;
    string s2j;
    string s3a;
    string s3b;
    string s3c;
    string s3d;
    string s3e;
    string sNum1;
    string sNum2;
    string sNum3;
    string sProc1Type;
    string sProc2Type;
    string sProc3Type;
    string sProc3Extra;
    string sTeach;
	string sPrefix;
	
	//Antidisestablishmentarianism pads the answer sets for those questions with fewer answers. 
	//I tried "None" first, but somebody stumbled across it and used it in a test for credit.

	if(GetSilvyUniversitySchool(oDesk) == SilvyUniversitySchoolAbjuration)
        {s1a = "Medium";
         s1b = "Verbal";
         s1c = "Somatic";
         s1d = "Instant";
		 s1e = "Antidisestablishmentarianism";
		 s2a = "Resistance";
         s2b = "Protection from Arrows";
         s2c = "Shield";
         s2d = "Protection from Alignment";
         s2e = "Resist Energy";
         s2f = "Endure Elements";
         s2g = "Lesser Dispel";
         s2h = "Antidisestablishmentarianism";
		 s2i = "Antidisestablishmentarianism";
		 s2j = "Antidisestablishmentarianism";
		 s3a = "Endure Elements";
         s3b = "Resist Energy";
         s3c = "Protection from Energy";
         s3d = "Energy Immunity";
         s3e = "Antidisestablishmentarianism";
         sNum1 = "three";
         sNum2 = "seven";
         sNum3 = "four";
         sProc1Type = "the elf";
         sProc2Type = "the jealous old biddy";
         sProc3Extra = "Hells!  You got it right.  Sparky's going to roar.  Nothing he can do, though. You found him and passed his question.";
         sTeach = "Mistress Melindia";
		 sPrefix = "abj";
        
		}
       else if(GetSilvyUniversitySchool(oDesk) == SilvyUniversitySchoolConjuration)
        {s1a = "Acid Splash";
         s1b = "Melf's Acid Arrow";
         s1c = "Mestil's Acid Breath";
         s1d = "Vitriolic Sphere";
		 s1e = "Acid Fog";
		 s2a = "Wolf";
         s2b = "Dire Badger";
         s2c = "Dire Wolf";
         s2d = "Dire Boar";
         s2e = "Shadow Mastiff";
         s2f = "Dire Bear";
         s2g = "Huge Elemental";
         s2h = "Greater Elemental";
         s2i = "Elder Elemental";
         s2j = "Horned Devil";
         s3a = "Lesser Planar Binding";
         s3b = "Planar Binding";
         s3c = "Greater Planar Binding";
         s3d = "Antidisestablishmentarianism";
		 s3e = "Antidisestablishmentarianism";
		 sNum1 = "five";
         sNum2 = "ten";
         sNum3 = "three";
         sProc1Type = "Sergeant Lastima";
         sProc2Type = "the wild half-elf -- or half-human -- whichever you prefer...anyhow, the proctor";
         sProc3Type = "the Master's summon";
         sTeach = "Master Gasen";
		 sPrefix = "con";        
		}
    else if(GetSilvyUniversitySchool(oDesk) == SilvyUniversitySchoolDivination)
        {s1a = "Clairvoyance";
         s1b = "True Seeing";
         s1c = "See Invisibility";
         s1d = "Antidisestablishmentarianism";
		 s1e = "Antidisestablishmentarianism";
		 s2a = "Blind";
         s2b = "Disable";
         s2c = "Maladroit";
         s2d = "Petrify";
         s2e = "Weaken";
         s2f = "Kill";
         s2g = "Stun";
         s2h = "Antidisestablishmentarianism";
		 s2i = "Antidisestablishmentarianism";
		 s2j = "Antidisestablishmentarianism";
		 s3a = "Premonition";
         s3b = "Identify";
         s3c = "Legend Lore";
         s3d = "Antidisestablishmentarianism";
         s3e = "Antidisestablishmentarianism";
         sNum1 = "three";
         sNum2 = "seven";
         sNum3 = "three";
         sProc1Type = "Riverrun";
         sProc2Type = "the Master's pet student";
         sProc3Extra = "Well, break me down for kindling. The Dean had time for you. Or maybe he knew you were going to answer it correctly so he had to ask it. Hmmmm. I must ponder this.";
         sTeach = "Master Clarvue";
		 sPrefix = "div";        
		}
	 else if(GetSilvyUniversitySchool(oDesk) == SilvyUniversitySchoolEnchantment)
        {s1a = "Daze";
         s1b = "Sleep";
         s1c = "Charm Person";
         s1d = "Tasha's Hideous Laughter";
		 s1e = "Touch of Idiocy";
		 s2a = "Charm Person";
         s2b = "Charm Monster";
         s2c = "Hold Person";
         s2d = "Hold Monster";
         s2e = "Dominate Person";
         s2f = "Dominate Monster";
         s2g = "Mass Charm Monster";
         s2h = "Mass Hold Monster";
         s2i = "Mass Hold Person";
         s2j = "Antidisestablishmentarianism";
         s3a = "Sleep";
         s3b = "Deep Slumber";
         s3c = "Hiss of Sleep";
         s3d = "Antidisestablishmentarianism";
         s3e = "Antidisestablishmentarianism";
         sNum1 = "five";
         sNum2 = "nine";
         sNum3 = "three";
         sProc1Type = "Master Snooty Elf";
         sProc2Type = "Tiny";
         sProc3Type = "Mistress Snooty Elf";
         sTeach = "Master Elestari";
		 sPrefix = "enc";        
		}
		
	 else if(GetSilvyUniversitySchool(oDesk) == SilvyUniversitySchoolEvocation)
        {s1a = "Bigby's Interposing Hand";
         s1b = "Bigby's Forceful Hand";
         s1c = "Bigby's Grasping Hand";
         s1d = "Bigby's Clenched Fist";
		 s1e = "Bigby's Crushing Hand";
		 s2a = "Burst of Glacial Wrath";
         s2b = "Cone of Cold";
         s2c = "Elemental Shield";
         s2d = "Ice Storm";
         s2e = "Polar Ray";
         s2f = "Antidisestablishmentarianism";
         s2g = "Antidisestablishmentarianism";
         s2h = "Antidisestablishmentarianism";
         s2i = "Antidisestablishmentarianism";
         s2j = "Antidisestablishmentarianism";
         s3a = "Chain Lightning";
         s3b = "Gedlee's Electric Loop";
         s3c = "Lightning Bolt";
         s3d = "Scintillating Sphere";
         s3e = "Shocking Grasp";
         sNum1 = "five";
         sNum2 = "five";
         sNum3 = "five";
         sProc1Type = "the gnome";
         sProc2Type = "the Kossuthian student";
         sProc3Type = "the Evocation-School-graduate-turned-Registrar";
         sTeach = "Master Arcadavera";
		 sPrefix = "evo";        
		}
		
	 else if(GetSilvyUniversitySchool(oDesk) == SilvyUniversitySchoolIllusion)
        {s1a = "Blindness";
         s1b = "Mass Blindness";
         s1c = "Color Spray";
         s1d = "Antidisestablishmentarianism";
         s1e = "Antidisestablishmentarianism";
         s2a = "Invisibility";
         s2b = "Invisibility Sphere";
         s2c = "Greater Invisibility";
         s2d = "Shadow Conjuration";
         s2e = "Antidisestablishmentarianism";
         s2f = "Antidisestablishmentarianism";
         s2g = "Antidisestablishmentarianism";
         s2h = "Antidisestablishmentarianism";
         s2i = "Antidisestablishmentarianism";
         s2j = "Antidisestablishmentarianism";
         s3a = "Ethereal Visage";
         s3b = "Ghostly Visage";
         s3c = "Antidisestablishmentarianism";
         s3d = "Antidisestablishmentarianism";
         s3e = "Antidisestablishmentarianism";
         sNum1 = "three";
         sNum2 = "four";
         sNum3 = "two";
         sProc1Type = "the gnome";
         sProc2Type = " -- and I use this term loosely -- the boy";
         sProc3Type = "the bear";
         sTeach = "Master Volebane";
		 sPrefix = "ill";        
		}
	 else if(GetSilvyUniversitySchool(oDesk) == SilvyUniversitySchoolNecromancy)
        {s1a = "Vampiric Touch";
         s1b = "Antidisestablishmentarianism";
         s1c = "Antidisestablishmentarianism";
         s1d = "Antidisestablishmentarianism";
         s1e = "Antidisestablishmentarianism";
         s2a = "Animate Dead";
         s2b = "Avasculate";
         s2c = "Circle of Death";
         s2d = "Create Greater Undead";
         s2e = "Create Undead";
         s2f = "Finger of Death";
         s2g = "Horrid Wilting";
         s2h = "Wail of the Banshee";
         s2i = "Antidisestablishmentarianism";
         s2j = "Antidisestablishmentarianism";
         s3a = "Animate Dead";
         s3b = "Create Greater Undead";
         s3c = "Create Undead";
         s3d = "Control Undead";
         s3e = "Undeath to Death";
		 sNum1 = "one";
         sNum2 = "nine";
         sNum3 = "five";
         sProc1Type = "the altogether too cheerful elf";
         sProc2Type = "the old undead killer";
         sProc3Extra = "So you were able to get to the zombie and away safely. Must've carried a big stick. You've gotten the answer right, though.";
         sTeach = "Mistress Ostelle";
		 sPrefix = "nec";        
		}
		
	 else if(GetSilvyUniversitySchool(oDesk) == SilvyUniversitySchoolTransmutation)
        {s1a = "Greater Stoneskin";
         s1b = "Antidisestablishmentarianism";
         s1c = "Antidisestablishmentarianism";
         s1d = "Antidisestablishmentarianism";
         s1e = "Antidisestablishmentarianism";
         s2a = "Bear's Endurance";
         s2b = "Bull's Strength";
         s2c = "Cat's Grace";
         s2d = "Eagle's Splendor";
         s2e = "Fox's Cunning";
         s2f = "Owl's Wisdom";
         s2g = "Antidisestablishmentarianism";
         s2h = "Antidisestablishmentarianism";
         s2i = "Antidisestablishmentarianism";
         s2j = "Antidisestablishmentarianism";
         s3a = "Keen Edge";
         s3b = "Magic Weapon";
         s3c = "Antidisestablishmentarianism";
         s3d = "Antidisestablishmentarianism";
         s3e = "Antidisestablishmentarianism";
         sNum1 = "one";
         sNum2 = "six";
         sNum3 = "two";
         sProc1Type = "the proctor";
         sProc2Type = "the disfigured elf";
         sProc3Extra = "Aha! So you found what retired transmuters do. You've heard of stone to flesh spells? You should taste what he can do with the proper spices. You've answered this one right. Go get a cookie.";
         sTeach = "Master Auroneus";
 		 sPrefix = "tra";       
		}
    //Advanced Coursework
   //If the student has already completed this advanced coursework in this school
  
    if((GetCampaignString("SLV_UNI", sCurrentCourse, oStudent) == sCurrentCourse) && (sCurrentCourse != ""))
	    {SpeakString("You have already passed this class.  Get outta here.", TALKVOLUME_TALK);
	     DestroyInventory(OBJECT_SELF);
		 return;
	    }

	//Puts more than one thing in the drawer
    object oItem = GetFirstItemInInventory(oDesk);
	int nItem = 0;
	while(oItem != OBJECT_INVALID)
		{nItem = nItem + 1;
		 if(nItem >= 2)
	        {SpeakString("Shiver me timbers!  I can only check one thing at a time.  You'll have to redo your work. I warned you I would consume anything put in here.", TALKVOLUME_TALK);
	         DestroyInventory(OBJECT_SELF);
	         return;
		    }
		 oItem = GetNextItemInInventory(oDesk);
		 }
	
	DestroyInventory(OBJECT_SELF);
	
	//On putting something into the drawer that is not a test at all
     if((GetItemPossessedBy(OBJECT_SELF, "slv_test") == OBJECT_INVALID) && (GetFirstItemInInventory(oDesk) != OBJECT_INVALID))
		  {SpeakString("Numbskull.  I promised I'd be polite but c'mon.  Hello!  I said put a test in the drawer, not whatever cast-off rubbish that is!", TALKVOLUME_TALK);
		     	  return;
		    	}
					
    //On putting a test into the drawer that is not the student's test
     if(GetItemPossessedBy(OBJECT_SELF, "slv_test") != OBJECT_INVALID) 
		 {if((sName != GetName(oStudent)) && (sName != ""))
	 		{SpeakString("That's a test, but by the arcane signature, it's not yours. I'm cut from the same wood as the door of the owner of that test, and both you and the owner have been reported to the Registrar for investigation.", TALKVOLUME_TALK);
		     CopyItem(GetFirstItemInInventory(oDesk), oRegistrarLockBox, TRUE);
			 return;}
		   if((sName != GetName(oStudent)) && (sName == ""))
	 		{SpeakString("I'm sorry, that test is no longer valid. The question asked may have changed since it was written.", TALKVOLUME_TALK);
		     return;}
			}
	
		 
  
	 //Said this paper has answers to questions from the wrong school(s)
      if(GetItemPossessedBy(OBJECT_SELF, "slv_test") != OBJECT_INVALID) 
	  		{if(FindSubString(sQuestion, sSchool) == -1)
		  		{if((FindSubString(sQuestion, "Abjuration") != -1) || (FindSubString(sQuestion, "Conjuration") != -1) || (FindSubString(sQuestion, "Divination") != -1) || (FindSubString(sQuestion, "Enchantment") != -1) || (FindSubString(sQuestion, "Evocation") != -1) || (FindSubString(sQuestion, "Illusion") != -1) || (FindSubString(sQuestion, "Necromancy") != -1) || (FindSubString(sQuestion, "Transmutation") != -1))
		     		{SpeakString("Thick as a board. This is the " + sSchool + " room, but you seem to be guessing at that. If this is truly a test for another secretary desk in another school's classroom, take it there, but don't bother me with it.", TALKVOLUME_TALK);
	            	 return;
		    		}
				 else {SpeakString("Look, that's really studious of you and all, but what in the Nine Hells am I supposed to be checking...since you haven't confirmed for me what school this is for?  Leave your mother's laundry list, knothead, and check the next one for spelling!", TALKVOLUME_TALK);
	            	return;
		    		}
				}
			if(FindSubString(sQuestion, sSchool) != -1)
		  		{if(((FindSubString(sQuestion, "Abjuration") != -1) && (sSchool != "Abjuration")) || ((FindSubString(sQuestion, "Conjuration") != -1) && (sSchool != "Conjuration")) || ((FindSubString(sQuestion, "Divination") != -1) && (sSchool != "Divination")) || ((FindSubString(sQuestion, "Enchantment") != -1) && (sSchool != "Enchantment")) || ((FindSubString(sQuestion, "Evocation") != -1) && (sSchool != "Evocation")) || ((FindSubString(sQuestion, "Illusion") != -1) && (sSchool != "Illusion")) || ((FindSubString(sQuestion, "Necromancy") != -1) && (sSchool != "Necromancy"))|| ((FindSubString(sQuestion, "Transmutation") != -1)&& (sSchool != "Transmutation")))
		     		{SpeakString("Saw me and shape me! This is the " + sSchool + " room, but you seem uncertain of that at best. You can't answer two school's questions on one paper!", TALKVOLUME_TALK);
	            	 return;
		    		}
				}
			}	
   //On putting in a test paper without the right format number in the title 
     if((GetItemPossessedBy(OBJECT_SELF, "slv_test") != OBJECT_INVALID) && (FindSubString(sQuestion, "1") == -1) && (FindSubString(sQuestion, "2") == -1)&& (FindSubString(sQuestion, "3") == -1))
	     {SpeakString("I don't think you can be saved if you can't follow directions. How can I grade it if I don't know what I'm grading? Choose question '1', question '2' or question '3', and begin your test with only one of those numbers -- NOT the written out word for the number -- in the title along with the school's name, so I know what I'm supposed to be grading.  Try again.", TALKVOLUME_TALK);
	      return;
	    }
 
	//Said this paper has answers to more than one question
      if((GetItemPossessedBy(OBJECT_SELF, "slv_test") != OBJECT_INVALID) && ((FindSubString(sQuestion, "1") != -1) && ((FindSubString(sQuestion, "2") != -1) || (FindSubString(sQuestion, "3") != -1))) || ((FindSubString(sQuestion, "2") != -1) && (FindSubString(sQuestion, "3") != -1)))
            {SpeakString("The sap must be frozen in your head.  You've titled this as more than one of the answers.  Choose question '1', question '2' or question '3'.", TALKVOLUME_TALK);
            return;
	    	}

 
    //Grading process begins
        //Proctor1
	 if((GetItemPossessedBy(OBJECT_SELF, "slv_test") != OBJECT_INVALID) && (GetCampaignString("SLV_UNI", sSchool + "300" + sProctor1, oStudent) == sSchool + "300" + sProctor1) && (FindSubString(sQuestion, "1") != -1))
             {SpeakString("What do you think?  I'm blind cuz I'm made out of wood?  You've already completed this question.  Nice try.  Go get a new question.", TALKVOLUME_TALK);
              return;
			  }
       
     else if((GetItemPossessedBy(OBJECT_SELF, "slv_test") != OBJECT_INVALID)  && (FindSubString(sQuestion, "1") != -1) && (FindSubString(sTest, s1a) != -1) && ((s1b == "Antidisestablishmentarianism") || (FindSubString(sTest, s1b) != -1)) && ((s1c == "Antidisestablishmentarianism") || (FindSubString(sTest, s1c) != -1)) && ((s1d == "Antidisestablishmentarianism") || (FindSubString(sTest, s1d) != -1)) && ((s1e == "Antidisestablishmentarianism") || (FindSubString(sTest, s1e) != -1)))
           {SpeakString("So you found the first question. Hard to believe, but you've answered " + sProc1Type + "'s question right.", TALKVOLUME_TALK);
                    SetCampaignString("SLV_UNI", sSchool + "300" + sProctor1, sSchool + "300" + sProctor1, oStudent);
                    SetCampaignString("SLV_UNI", sCurrentCourse, sCurrentCourse + "One", oStudent);
                    if(ACR_RetrieveQuestState("slv_" + sPrefix + "300_1", oStudent) == 1)
						{ACR_AddPersistentJournalQuestEntry("slv_" + sPrefix + "300_1", 2, oStudent, 0, 0, 0, 0);
						}
					if((GetCampaignString("SLV_UNI", sSchool + "300" + sProctor2, oStudent) == sSchool + "300" + sProctor2) && (GetCampaignString("SLV_UNI", sSchool + "300" + sProctor3, oStudent) == sSchool + "300" + sProctor3))
                        {DelayCommand(4.0, SpeakString("Even more incredible, you've answered all three and passed " + sClasswork + "!  "  + sTeach + " will be pleased.  I'm just surprised.", TALKVOLUME_TALK));
                        SetCampaignString("SLV_UNI", sCurrentCourse, sCurrentCourse, oStudent);
                        if(ACR_RetrieveQuestState("slv_" + sPrefix + "300", oStudent) > 0)
							{ACR_AddPersistentJournalQuestEntry("slv_" + sPrefix + "300", 3, oStudent, 0, 0, 0, 0);
							}
						}
                    else if((GetCampaignString("SLV_UNI", sSchool + "300" + sProctor2, oStudent) == sSchool + "300" + sProctor2) || (GetCampaignString("SLV_UNI", sSchool + "300" + sProctor3, oStudent) == sSchool + "300" + sProctor3))
                        {DelayCommand(4.0, SpeakString("That makes two out of three.  You've got one more question to find and answer for this class.", TALKVOLUME_TALK));
                        SetCampaignString("SLV_UNI", sCurrentCourse, sCurrentCourse + "Two", oStudent);
                        }
                    else
                        {DelayCommand(4.0, SpeakString("What, you've put down roots?  Go get another question. You've got two more to complete!", TALKVOLUME_TALK));
                        }
             }
        else if((GetItemPossessedBy(OBJECT_SELF, "slv_test") != OBJECT_INVALID) && (FindSubString(sQuestion, "1") != -1) && ((FindSubString(sTest, s1a) == -1) || ((s1b != "Antidisestablishmentarianism") && (FindSubString(sTest, s1b) == -1)) || ((s1c != "Antidisestablishmentarianism") && (FindSubString(sTest, s1c) == -1)) || ((s1d != "Antidisestablishmentarianism") && (FindSubString(sTest, s1d) == -1)) || ((s1e != "Antidisestablishmentarianism") && (FindSubString(sTest, s1e) == -1))))
            {SpeakString("Wrong, wrong, wrong!  I've done you a favor and absorbed that piece of trash you called a test. Try again.  I bet we know each other real well by the time you get it right.", TALKVOLUME_TALK);
            DelayCommand(2.0, SpeakString("I pity you, so I'll tell you what you managed to get right.", TALKVOLUME_TALK));
                         if((GetItemPossessedBy(OBJECT_SELF, "slv_test") != OBJECT_INVALID) && (FindSubString(sTest, s1a) == -1) && (FindSubString(sTest, s1b) == -1) && (FindSubString(sTest, s1c) == -1)&& (FindSubString(sTest, s1d) == -1)&& (FindSubString(sTest, s1e) == -1))
                            {DelayCommand(4.0, SpeakString("Nuthin, absolutely nothing, sap.  You got none of the " + sNum1 + " answers right.", TALKVOLUME_TALK));
                            }
                         if((GetItemPossessedBy(OBJECT_SELF, "slv_test") != OBJECT_INVALID)  && (s1a != "") && (FindSubString(sTest, s1a) != -1))
                            {DelayCommand(4.0, SpeakString("You got " + s1a + " right.", TALKVOLUME_TALK));
                            }
                         if((GetItemPossessedBy(OBJECT_SELF, "slv_test") != OBJECT_INVALID)  && (s1b != "")&& (FindSubString(sTest, s1b) != -1))
                            {DelayCommand(6.0, SpeakString("You got " + s1b + " right.", TALKVOLUME_TALK));
                             }
                            if((GetItemPossessedBy(OBJECT_SELF, "slv_test") != OBJECT_INVALID)  && (s1c != "")&& (FindSubString(sTest, s1c) != -1))
                            {DelayCommand(8.0, SpeakString("You got " + s1c + " right.", TALKVOLUME_TALK));
                             }
                         if((GetItemPossessedBy(OBJECT_SELF, "slv_test") != OBJECT_INVALID)  && (s1d != "")&& (FindSubString(sTest, s1d) != -1))
                            {DelayCommand(8.0, SpeakString("You got " + s1d + " right.", TALKVOLUME_TALK));
                             }
						 if((GetItemPossessedBy(OBJECT_SELF, "slv_test") != OBJECT_INVALID)  && (s1e != "")&& (FindSubString(sTest, s1e) != -1))
                            {DelayCommand(8.0, SpeakString("You got " + s1e + " right.", TALKVOLUME_TALK));
                             }
           }

       //Proctor2
 	    if((GetItemPossessedBy(OBJECT_SELF, "slv_test") != OBJECT_INVALID) && (GetCampaignString("SLV_UNI", sSchool + "300" + sProctor2, oStudent) == sSchool + "300" + sProctor2)  && (FindSubString(sQuestion, "2") != -1))
                 {SpeakString("What do you think?  I'm blind cuz I'm made out of wood?  You've already completed this question.  Nice try.  Go get a new question.", TALKVOLUME_TALK);
                 }

        
        else if((GetItemPossessedBy(OBJECT_SELF, "slv_test") != OBJECT_INVALID) && (FindSubString(sQuestion, "2") != -1) && (FindSubString(sTest, s2a) != -1) && ((s2b == "Antidisestablishmentarianism") || (FindSubString(sTest, s2b) != -1)) && ((s2c == "Antidisestablishmentarianism") || (FindSubString(sTest, s2c)) != -1) && ((s2d == "Antidisestablishmentarianism") || (FindSubString(sTest, s2d) != -1)) && ((s2e == "Antidisestablishmentarianism") || (FindSubString(sTest, s2e) != -1)) && ((s2f == "Antidisestablishmentarianism") || (FindSubString(sTest, s2f) != -1)) &&  ((s2g == "Antidisestablishmentarianism") || (FindSubString(sTest, s2g) != -1)) &&  ((s2h == "Antidisestablishmentarianism") || (FindSubString(sTest, s2h)) != -1) &&  ((s2i == "Antidisestablishmentarianism") || (FindSubString(sTest, s2i) != -1)) &&  ((s2j == "Antidisestablishmentarianism") || (FindSubString(sTest, s2j) != -1)))
                {SpeakString("Well, well, well.  You passed " + sProc2Type + "'s question.", TALKVOLUME_TALK);
                    if(ACR_RetrieveQuestState("slv_" + sPrefix + "300_2", oStudent) == 1)
						{ACR_AddPersistentJournalQuestEntry("slv_" + sPrefix + "300_2", 2, oStudent, 0, 0, 0, 0);
						}
					SetCampaignString("SLV_UNI", sSchool + "300" + sProctor2, sSchool + "300" + sProctor2, oStudent);
                    SetCampaignString("SLV_UNI", sCurrentCourse, sCurrentCourse + "One", oStudent);
                    if((GetCampaignString("SLV_UNI", sSchool + "300" + sProctor1, oStudent) == sSchool + "300" + sProctor1) && (GetCampaignString("SLV_UNI", sSchool + "300" + sProctor3, oStudent) == sSchool + "300" + sProctor3))
                        {DelayCommand(4.0, SpeakString("Even more incredible, you've answered all three and passed " + sClasswork + "!  Looks like " + sTeach + "'s lessons haven't been entirely wasted. Go see the professor." , TALKVOLUME_TALK));
                        SetCampaignString("SLV_UNI", sCurrentCourse, sCurrentCourse, oStudent);
                        if(ACR_RetrieveQuestState("slv_" + sPrefix + "300", oStudent) > 0)
							{ACR_AddPersistentJournalQuestEntry("slv_" + sPrefix + "300", 3, oStudent, 0, 0, 0, 0);
							}
						}
                    else if((GetCampaignString("SLV_UNI", sSchool + "300" + sProctor1, oStudent) == sSchool + "300" + sProctor1) || (GetCampaignString("SLV_UNI", sSchool + "300" + sProctor3, oStudent) == sSchool + "300" + sProctor3))
                        {DelayCommand(4.0, SpeakString("That makes two out of three.  You've got one more question for this classroom to find and answer.", TALKVOLUME_TALK));
                        SetCampaignString("SLV_UNI", sCurrentCourse, sCurrentCourse + "Two", oStudent);
                        }
                    else
                       {DelayCommand(4.0, SpeakString("What, you've put down roots?  Go get another question. You've got two more to complete!", TALKVOLUME_TALK));
                        }
                 }
         else if((GetItemPossessedBy(OBJECT_SELF, "slv_test") != OBJECT_INVALID) && (FindSubString(sQuestion, "2") != -1) && ((FindSubString(sTest, s2a) == -1) || ((s2b != "Antidisestablishmentarianism") && (FindSubString(sTest, s2b) == -1)) || ((s2c != "Antidisestablishmentarianism") && (FindSubString(sTest, s2c) == -1)) || ((s2d != "Antidisestablishmentarianism") && (FindSubString(sTest, s2d) == -1)) || ((s2e != "Antidisestablishmentarianism") && (FindSubString(sTest, s2e) == -1)) || ((s2f != "Antidisestablishmentarianism") && (FindSubString(sTest, s2f) == -1)) || ((s2g != "Antidisestablishmentarianism") && (FindSubString(sTest, s2g) == -1)) || ((s2h != "Antidisestablishmentarianism") && (FindSubString(sTest, s2h) == -1)) || ((s2i != "Antidisestablishmentarianism") && (FindSubString(sTest, s2i)) == -1) || ((s2j != "Antidisestablishmentarianism") && (FindSubString(sTest, s2j) == -1))))
                 {SpeakString("Wrong, wrong, wrong!  I've done you a favor and absorbed that piece of trash you called a test. Try again.  I bet we know each other real well by the time you get it right.", TALKVOLUME_TALK);
                         DelayCommand(2.0, SpeakString("I pity you, so I'll tell you what you managed to get right.", TALKVOLUME_TALK));
                         if((GetItemPossessedBy(OBJECT_SELF, "slv_test") != OBJECT_INVALID) && ((FindSubString(sTest, s2a) == -1) && (FindSubString(sTest, s2b) == -1) && (FindSubString(sTest, s2c) == -1) && (FindSubString(sTest, s2d) == -1) && (FindSubString(sTest, s2e) == -1) && (FindSubString(sTest, s2f) == -1) && (FindSubString(sTest, s2g) == -1) && (FindSubString(sTest, s2h) == -1) && (FindSubString(sTest, s2i) == -1) && (FindSubString(sTest, s2j) == -1)))
                            {DelayCommand(4.0, SpeakString("Nuthin, absolutely nothing, sap.  You got none of the " + sNum2 + " answers right.", TALKVOLUME_TALK));
                            }
                         if((GetItemPossessedBy(OBJECT_SELF, "slv_test") != OBJECT_INVALID)  && (FindSubString(sTest, s2a) != -1))
                            {DelayCommand(4.0, SpeakString("You got " + s2a + " right.", TALKVOLUME_TALK));
                            }
                        if((GetItemPossessedBy(OBJECT_SELF, "slv_test") != OBJECT_INVALID)  && (FindSubString(sTest, s2b) != -1))
                            {DelayCommand(6.0, SpeakString("You got " + s2b + " right.", TALKVOLUME_TALK));
                             }
                         if((GetItemPossessedBy(OBJECT_SELF, "slv_test") != OBJECT_INVALID) && (FindSubString(sTest, s2f) != -1))
                             {DelayCommand(8.0, SpeakString("You got " + s2f + " right.", TALKVOLUME_TALK));
                             }
                         if((GetItemPossessedBy(OBJECT_SELF, "slv_test") != OBJECT_INVALID)  && (FindSubString(sTest, s2d) != -1))
                             {DelayCommand(10.0, SpeakString("You got " + s2d + " right.", TALKVOLUME_TALK));
                              }
                         if((GetItemPossessedBy(OBJECT_SELF, "slv_test") != OBJECT_INVALID) && (FindSubString(sTest, s2c) != -1))
                              {DelayCommand(12.0, SpeakString("You got " + s2c + " right.", TALKVOLUME_TALK));
                               }
                        if((GetItemPossessedBy(OBJECT_SELF, "slv_test") != OBJECT_INVALID) && (FindSubString(sTest, s2g) != -1))
                              {DelayCommand(14.0, SpeakString("You got " + s2g + " right.", TALKVOLUME_TALK));
                               }
                         if((GetItemPossessedBy(OBJECT_SELF, "slv_test") != OBJECT_INVALID) && (FindSubString(sTest, s2e) != -1))
                             {DelayCommand(16.0, SpeakString("You got " + s2e + " right.", TALKVOLUME_TALK));
                             }
                         if((GetItemPossessedBy(OBJECT_SELF, "slv_test") != OBJECT_INVALID) && (FindSubString(sTest, s2h) != -1))
                             {DelayCommand(16.0, SpeakString("You got " + s2h + " right.", TALKVOLUME_TALK));
                             }
                         if((GetItemPossessedBy(OBJECT_SELF, "slv_test") != OBJECT_INVALID) && (FindSubString(sTest, s2i) != -1))
                             {DelayCommand(16.0, SpeakString("You got " + s2i + " right.", TALKVOLUME_TALK));
                             }
						 if((GetItemPossessedBy(OBJECT_SELF, "slv_test") != OBJECT_INVALID) && (FindSubString(sTest, s2j) != -1))
                             {DelayCommand(16.0, SpeakString("You got " + s2j + " right.", TALKVOLUME_TALK));
                             }
                         }


           //Proctor3
		   if((GetItemPossessedBy(OBJECT_SELF, "slv_test") != OBJECT_INVALID) && (GetCampaignString("SLV_UNI", sSchool + "300" + sProctor3, oStudent) == sSchool + "300" + sProctor3) && (FindSubString(sQuestion, "3") != -1))
                    {SpeakString("What do you think?  I'm blind cuz I'm made out of wood?  You've already completed this question.  Nice try.  Go get a new question.", TALKVOLUME_TALK);
                    }
            
           else if((GetItemPossessedBy(OBJECT_SELF, "slv_test") != OBJECT_INVALID) && (FindSubString(sQuestion, "3") != -1) && (FindSubString(sTest, s3a) != -1) && ((s3b == "Antidisestablishmentarianism") || (FindSubString(sTest, s3b)) != -1)  && ((s3c == "Antidisestablishmentarianism") || (FindSubString(sTest, s3c) != -1))  && ((s3d == "Antidisestablishmentarianism") || (FindSubString(sTest, s3d) != -1)) && ((s3e == "Antidisestablishmentarianism") || (FindSubString(sTest, s3e) != -1)))
                   {if(ACR_RetrieveQuestState("slv_" + sPrefix + "300_3", oStudent) == 1)
						{ACR_AddPersistentJournalQuestEntry("slv_" + sPrefix + "300_3", 2, oStudent, 0, 0, 0, 0);
						}
					if((sSchool == "Abjuration") || (sSchool == "Divination") ||(sSchool == "Necromancy"))
                       {SpeakString(sProc3Extra, TALKVOLUME_TALK);}
                       else
                       {SpeakString("Surprisingly enough, you've answered " + sProc3Type + "'s question right.  If I'm nice I won't switch it with the paper of the knothead student who failed out yesterday.", TALKVOLUME_TALK);
                       }
                    SetCampaignString("SLV_UNI", sSchool + "300" + sProctor3, sSchool + "300" + sProctor3, oStudent);
                    SetCampaignString("SLV_UNI", sCurrentCourse, sCurrentCourse + "One", oStudent);
                    if((GetCampaignString("SLV_UNI", sSchool + "300" + sProctor1, oStudent) == sSchool + "300" + sProctor1) && (GetCampaignString("SLV_UNI", sSchool + "300" + sProctor2, oStudent) == sSchool + "300" + sProctor2))
                        {DelayCommand(4.0, SpeakString("Even more incredible, you've answered all three and passed " + sClasswork + "!  Looks like " + sTeach + "'s lessons haven't been entirely wasted. Go see the professor." , TALKVOLUME_TALK));
                        SetCampaignString("SLV_UNI", sCurrentCourse, sCurrentCourse, oStudent);
                        if(ACR_RetrieveQuestState("slv_" + sPrefix + "300", oStudent) > 0)
							{ACR_AddPersistentJournalQuestEntry("slv_" + sPrefix + "300", 3, oStudent, 0, 0, 0, 0);
							}
						}
                    else if((GetCampaignString("SLV_UNI", sSchool + "300" + sProctor1, oStudent) == sSchool + "300" + sProctor1) || (GetCampaignString("SLV_UNI", sSchool + "300" + sProctor2, oStudent) == sSchool + "300" + sProctor2))
                        {DelayCommand(4.0, SpeakString("That makes two out of three.  You've got one more question for this school to find and answer.", TALKVOLUME_TALK));
                        SetCampaignString("SLV_UNI", sCurrentCourse, sCurrentCourse + "Two", oStudent);
                        }
                    else
                        {DelayCommand(4.0, SpeakString("What, you've put down roots?  Go get another question. You've got two more to complete!", TALKVOLUME_TALK));
                        }
                    }
           else if((GetItemPossessedBy(OBJECT_SELF, "slv_test") != OBJECT_INVALID) && (FindSubString(sQuestion, "3") != -1) && ((FindSubString(sTest, s3a) == -1) || ((s3b != "Antidisestablishmentarianism") && (FindSubString(sTest, s3b) == -1))  || ((s3c != "Antidisestablishmentarianism") &&(FindSubString(sTest, s3c) == -1)) ||((s3d != "Antidisestablishmentarianism") && (FindSubString(sTest, s3d) == -1))|| ((s3e != "Antidisestablishmentarianism") && (FindSubString(sTest, s3e) == -1))))
                    {SpeakString("Wrong, wrong, wrong!  I've done you a favor and absorbed that piece of trash you called a test. Try again.  I bet we know each other real well by the time you get it right.", TALKVOLUME_TALK);
                     DelayCommand(2.0, SpeakString("I pity you, so I'll tell you what you managed to get right.", TALKVOLUME_TALK));
                      if((GetItemPossessedBy(OBJECT_SELF, "slv_test") != OBJECT_INVALID)  && ((FindSubString(sTest, s3a) == -1) && (FindSubString(sTest, s3b) == -1) && (FindSubString(sTest, s3c) == -1) && (FindSubString(sTest, s3d) == -1) && (FindSubString(sTest, s3e) == -1) ))
                        {DelayCommand(4.0, SpeakString("Nuthin, absolutely nothing.  You got none of the " + sNum3 + "answers right.", TALKVOLUME_TALK));
                        }
                      if((GetItemPossessedBy(OBJECT_SELF, "slv_test") != OBJECT_INVALID)  && (FindSubString(sTest, s3a) != -1))
                        {DelayCommand(4.0, SpeakString("You got " + s3a + " right.", TALKVOLUME_TALK));
                        }
                     if((GetItemPossessedBy(OBJECT_SELF, "slv_test") != OBJECT_INVALID) && (FindSubString(sTest, s3b) != -1))
                        {DelayCommand(6.0, SpeakString("You got " + s3b + " right.", TALKVOLUME_TALK));
                         }
                     if((GetItemPossessedBy(OBJECT_SELF, "slv_test") != OBJECT_INVALID) && (FindSubString(sTest, s3c) != -1))
                         {DelayCommand(8.0, SpeakString("You got " + s3c + " right.", TALKVOLUME_TALK));
                          }
                     if((GetItemPossessedBy(OBJECT_SELF, "slv_test") != OBJECT_INVALID) && (FindSubString(sTest, s3d) != -1))
                         {DelayCommand(10.0, SpeakString("You got " + s3d + " right.", TALKVOLUME_TALK));
                         }
                      if((GetItemPossessedBy(OBJECT_SELF, "slv_test") != OBJECT_INVALID) && (FindSubString(sTest, s3e) != -1))
                         {DelayCommand(10.0, SpeakString("You got " + s3e + " right.", TALKVOLUME_TALK));
                         }
                      }
						 
}