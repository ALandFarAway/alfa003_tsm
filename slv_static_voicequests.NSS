 #include "silvy_univ_inc"
#include "acr_db_persist_i"
#include "acr_spawn_i"
#include "silvy_univ_func"
#include "acr_quest_i"
#include "acr_i"

 

void main()
{   object oMouth = OBJECT_SELF;
    object oStudent = GetLocalObject(OBJECT_SELF, "oStudent");
    object oDragon = GetLocalObject(OBJECT_SELF, "oDragon");
    object oCabinetStatic = GetLocalObject(OBJECT_SELF, "oCabinetStatic");
	object oCabinet = GetLocalObject(OBJECT_SELF, "oCabinet");
	object oCollBox = GetLocalObject(OBJECT_SELF, "oCollBox");
	location lCabinet = GetLocalLocation(OBJECT_SELF, "lCabinet");
	string sGreeting;
    string sGenderPronoun;
    string sGenderMaster;
    string sGenderJack;
    string sNamed;
    string sDeity = GetDeity(oStudent);
    string sDay;
    effect eGlimmer = EffectVisualEffect(VFX_DUR_PIXIEDUST, FALSE);
    
    // Set time of day strings
     if(GetIsDay())
        {sDay = "day";}
        else
        {sDay = "night";}

    // Break the Full Name into First, Middle and Last Names

         string sFullName = GetName(oStudent);
         string sFirstName;
         string sLastName;
         string sMiddleName;
         string sMiddleName2;
         int nSpace = FindSubString(sFullName, " ");
         if (nSpace > -1)
            {
            sFirstName = GetStringLeft(sFullName, nSpace);
            sLastName = GetStringRight(sFullName, GetStringLength(sFullName) - nSpace);
            if(GetStringLeft(sLastName, 1) == " ")
                {sLastName = GetStringRight(sLastName, GetStringLength(sLastName) - 1);
                }
                {}
                int nSpace2 = FindSubString(sLastName, " ");
                if(nSpace2 > -1)
                        {sMiddleName = GetStringLeft(sLastName, nSpace2);
                         sLastName = GetStringRight(sLastName, GetStringLength(sLastName) - nSpace2);
                         if(GetStringLeft(sLastName, 1) == " ")
                            {sLastName = GetStringRight(sLastName, GetStringLength(sLastName) - 1);
                            }
                            {}
                            int nSpace3 = FindSubString(sLastName, " ");
                            if(nSpace3 > -1)
                                {sMiddleName2 = GetStringLeft(sLastName, nSpace3);
                                 sLastName = GetStringRight(sLastName, GetStringLength(sLastName) - nSpace3);
                                if(GetStringLeft(sLastName, 1) == " ")
                                   {sLastName = GetStringRight(sLastName, GetStringLength(sLastName) - 1);
                                    }
                                    {}
                                }
                                {}
                          }
                         {}
             }
            else
            {sFirstName = GetName(oStudent);
             sLastName = GetName(oStudent);
             sFullName = GetName(oStudent);
             sMiddleName = GetName(oStudent);
             sMiddleName2 = GetName(oStudent);
             }



//  Definitions End, quests begin
//  ******************************************************************************



string sTryAgain = " Do you wish to receive an assignment? Speak the word 'receive'. You may also at any time use the word 'reschedule' to end our conversation.";

      if((GetLocalInt(oStudent, "DeanDragonConversation") == 1) && (GetLocalInt(oStudent, "QuestAssignmentOpen") < 1) )
         {AssignCommand(oDragon, SpeakString("The key to this door is knowledge.  Do you wish to receive an assignment? Speak the word 'receive'.", TALKVOLUME_TALK));
          }

     else if((GetLocalInt(oStudent, "DeanDragonConversation") == 2) && (GetLocalInt(oStudent, "QuestAssignmentOpen") < 1) && ((GetLocalString(OBJECT_SELF, "QuestSubmitAssignString") == "receive") || (GetLocalString(OBJECT_SELF, "QuestSubmitAssignString") == "Receive")))
         {
          AssignCommand(oDragon, SpeakString("Very well.  Choose one text on which to be tested, and hold it tightly.  When you are ready to begin, speak the title.", TALKVOLUME_TALK));
          SetLocalInt(oStudent, "QuestAssignmentOpen", 1);
          }

     else if((GetLocalInt(oStudent, "DeanDragonConversation") == 2) && (GetLocalInt(oStudent, "QuestAssignmentOpen") < 1) && ((GetLocalString(OBJECT_SELF, "QuestSubmitAssignString") == "submit")||(GetLocalString(OBJECT_SELF, "QuestSubmitAssignString") == "Submit")))
         {
          AssignCommand(oDragon, SpeakString("Very well.  Which assignment have you completed?", TALKVOLUME_TALK));
          SetLocalInt(oStudent, "QuestAssignmentOpen", 2);
          }

      else if((GetLocalInt(oStudent, "DeanDragonConversation") == 2) && (GetLocalInt(oStudent, "QuestAssignmentOpen") < 1) && ((GetLocalString(OBJECT_SELF, "QuestSubmitAssignString") == "enter")||(GetLocalString(OBJECT_SELF, "QuestSubmitAssignString") == "Enter")))
         {
          AssignCommand(oDragon, SpeakString("Very well.  Which assignment have you completed to earn entry?", TALKVOLUME_TALK));
          SetLocalInt(oStudent, "QuestAssignmentOpen", 3);
          }

      else if((GetLocalInt(oStudent, "DeanDragonConversation") == 3) && (GetLocalInt(oStudent, "QuestAssignmentOpen") == 1))
          {
           string sQuest = GetLocalString(OBJECT_SELF, "Quest");
           string sTitle = GetLocalString(OBJECT_SELF, "Title");
           string sDragonQuest = GetCampaignString("SLV_UNI", "DragonQuest" + GetStringUpperCase(sQuest), oStudent);
		   //8XAdvanced courses, 12xElemental, 2xNegative, 2xPositive, 6xAnimal/Vegetable/Mineral, 8xElf,Dwarf,Gnome,Hin,Orc,Human,Fey,Celestial,Infernal,Undead,Goblin,Gnoll, 8xWiz,Sor,Cle,Bg,SS,Dr,Wl,Brd
		   if(sDragonQuest == "")
              {SetLocalInt(oStudent, "Improper", 0);
               if (((sQuest == "A") || (sQuest == "a")) && (GetItemPossessedBy(oStudent, "slv_deanbooka") != OBJECT_INVALID))
                    {DelayCommand(5.0, AssignCommand(oDragon, SpeakString("'A'...'A'...what begins with 'A'?  'Acrostic' and 'apple for the teacher' both begin that way.  Why don't you go visit the charming Melindia, in Abjuration, and discuss with her her hopes for a practioner of the art of Abjuration?", TALKVOLUME_TALK)));
                     //Abjuration, Elemental(Ice, Fire)
					}
               else if (((sQuest == "B") || (sQuest == "b")) && (GetItemPossessedBy(oStudent, "slv_deanbookb") != OBJECT_INVALID))
                    {DelayCommand(3.0, AssignCommand(oDragon, SpeakString("Belad and biscuits seem like a good place to start.  Go see the former and return with the latter.  And while you're there, help that excellent elvish refectory proprietor with any task he needs done, Beshaba permitting.", TALKVOLUME_TALK)));
                    }
               else if (((sQuest == "C") || (sQuest == "c")) && (GetItemPossessedBy(oStudent, "slv_deanbookc") != OBJECT_INVALID))
                    {DelayCommand(3.0, AssignCommand(oDragon, SpeakString("If Conjuration is your school then by his art you're made no fool. Master Gasen has come far to teach here, but many of his animal friends come farther. Go see if you can conjure a keyword for 'C' from him.", TALKVOLUME_TALK)));
                    }
               else if (((sQuest == "D") || (sQuest == "d")) && (GetItemPossessedBy(oStudent, "slv_deanbookd") != OBJECT_INVALID))
                    {DelayCommand(3.0, AssignCommand(oDragon, SpeakString("My favorite, for obvious reasons.  I do believe the good doctor, Doctor Augustine, will have a task for you. Complete it to gain the keyword for my Exam D. She is usually in her office on the Master's Level.", TALKVOLUME_TALK)));
                    }
               else if (((sQuest == "E") || (sQuest == "e"))&& (GetItemPossessedBy(oStudent, "slv_deanbooke") != OBJECT_INVALID))
                    {DelayCommand(3.0, AssignCommand(oDragon, SpeakString("Eccentric Evoker? Perhaps not, as I would hate for you to experience electricity first hand.  Elvish Enchanter?  No, exposure to elvish superiority complexes might drive away otherwise promising proctors.  Instead, I think it shall be Elementary Elementalism 101. Go to the elemental shrines in the Master's Hall. Someone there will tell you more.", TALKVOLUME_TALK)));
                    }
               else if (((sQuest == "F") || (sQuest == "f"))&& (GetItemPossessedBy(oStudent, "slv_deanbookf") != OBJECT_INVALID))
                    {DelayCommand(3.0, AssignCommand(oDragon, SpeakString("Ah, 'F'.  It's time for you to meet an old friend.  Go to the Fochlucan and find the author of the history you hold.", TALKVOLUME_TALK)));
                    }
               else if (((sQuest == "G") || (sQuest == "g")) && (GetItemPossessedBy(oStudent, "slv_deanbookg") != OBJECT_INVALID))
                    {DelayCommand(3.0, AssignCommand(oDragon, SpeakString("Goats and glabrezu and greataxes! No, wait, that's the graduate course. For you, it's: gnomes and Gond and gears! Go get a little gizmo for me from the Wonderbringer in the tower north of High Hold. Take it to Imogene for your keyword.", TALKVOLUME_TALK)));
                    }
               else if (((sQuest == "H") || (sQuest == "h")) && (GetItemPossessedBy(oStudent, "slv_deanbookh") != OBJECT_INVALID))
                    {DelayCommand(3.0, AssignCommand(oDragon, SpeakString("A hero's headstone awaits you. I do hope it's not your own. Hunt down our halfling loremaster to hear more.", TALKVOLUME_TALK)));
                    }
               else if (((sQuest == "I") || (sQuest == "i")) && (GetItemPossessedBy(oStudent, "slv_deanbooki") != OBJECT_INVALID))
                    {DelayCommand(3.0, AssignCommand(oDragon, SpeakString("Allow the good Master Volebane to illuminate you on matters of Illusion, and the 'I' keyword.", TALKVOLUME_TALK)));
                    }
               else if (((sQuest == "J") || (sQuest == "j")) && (GetItemPossessedBy(oStudent, "slv_deanbookj") != OBJECT_INVALID))
                    {DelayCommand(3.0, AssignCommand(oDragon, SpeakString("Just a journey. A couple of them, in fact, but a small one first to gain this keyword. You will require the Jotun Dictionary. Take it with you. On the high trail to Felbarr, you will meet your guide. Trust her. She will take you to the one you must meet next. Jump to it!", TALKVOLUME_TALK)));
                    }
               else if (((sQuest == "K") || (sQuest == "k")) && (GetItemPossessedBy(oStudent, "slv_deanbookk") != OBJECT_INVALID))
                    {DelayCommand(3.0, AssignCommand(oDragon, SpeakString("K is for 'keys', which come in many shapes, and not all of them that of a keyhole. For instance, you are to collect a key from a friend of mine, who bears it hence as a keepsake from a friend of his by name of Kara. I've asked him to meet you at Khelb. Take the item to Imogene.", TALKVOLUME_TALK)));
                    }
               else if (((sQuest == "L") || (sQuest == "l")) && (GetItemPossessedBy(oStudent, "slv_deanbookl") != OBJECT_INVALID))
                    {DelayCommand(3.0, AssignCommand(oDragon, SpeakString("Languages! Lots of them, but let's begin with Loross. Labelas is fitting, as well, as the last native speaker of Loross around these parts died 2000 years ago. You can speak to him about his death in the Tower of the Star. See our local loremaster, Librarian Oakroot, first, for more information.", TALKVOLUME_TALK)));
                    }
               else if (((sQuest == "M") || (sQuest == "m")) && (GetItemPossessedBy(oStudent, "slv_deanbookm") != OBJECT_INVALID))
                    {DelayCommand(3.0, AssignCommand(oDragon, SpeakString("May Mystra guide you swiftly to Magus Miresk.   A mightier mage you're unlikely to meet no matter how widely you travel. And travel you will in search of this keyword and this component. Move along now.", TALKVOLUME_TALK)));
                    }
               else if (((sQuest == "N") || (sQuest == "n")) && (GetItemPossessedBy(oStudent, "slv_deanbookn") != OBJECT_INVALID))
                    {DelayCommand(3.0, AssignCommand(oDragon, SpeakString("Necromancy is hardly a topic for the squeamish, but if our Mistress of Necromancy has ever had an emotion at all, I've missed it. Go learn from her, both her nerveless calm and the keyword for the 'N' quest.", TALKVOLUME_TALK)));
                    }
               else if (((sQuest == "O") || (sQuest == "o")) && (GetItemPossessedBy(oStudent, "slv_deanbooko") != OBJECT_INVALID))
                    {DelayCommand(3.0, AssignCommand(oDragon, SpeakString("In honor of Oghmanic esoterica, I require information on...observation. No one observes more than a diviner, so go interview Master Clarvue and receive his opinion on the 'O' keyword.", TALKVOLUME_TALK)));
                    }
               else if (((sQuest == "P") || (sQuest == "p")) && (GetItemPossessedBy(oStudent, "slv_deanbookp") != OBJECT_INVALID))
                    {DelayCommand(3.0, AssignCommand(oDragon, SpeakString("Pantheons of deities have panoplies of priests, but I won't expect you to go meet one of each deity.  Indeed, one will suffice, and perhaps more than suffice after you've met the motherly Doctor Augustine, currently seeing patients in the Master's Level.  She will have something for you...other than her chatty manner.", TALKVOLUME_TALK)));
                    }
               else if (((sQuest == "Q") || (sQuest == "q")) && (GetItemPossessedBy(oStudent, "slv_deanbookq") != OBJECT_INVALID))
                    {DelayCommand(3.0, AssignCommand(oDragon, SpeakString("'Q' is for 'questions', of course, and also for 'quarrel'.  I believe I shall send you to our quarrelsome Master Scribe, in the Scribery.", TALKVOLUME_TALK)));
                    }
               else if (((sQuest == "R") || (sQuest == "r"))&& (GetItemPossessedBy(oStudent, "slv_deanbookr") != OBJECT_INVALID))
                    {DelayCommand(3.0, AssignCommand(oDragon, SpeakString("Ah yes.  Revery and the Retreat. There are times I wish our good Enchantment master's self-regard would partake more of one or the other. Go recover the 'R' keyword from Master Silverbrook.", TALKVOLUME_TALK)));
                    }
               else if (((sQuest == "S") || (sQuest == "s")) && (GetItemPossessedBy(oStudent, "slv_deanbooks") != OBJECT_INVALID))
                    {DelayCommand(3.0, AssignCommand(oDragon, SpeakString("Sanity is in question but sparks not so much in the Master of Evocation's spellwork. Go see if Master Arcadavera can evoke a keyword for the 'S' quest without singing you.", TALKVOLUME_TALK)));
                    }
               else if (((sQuest == "T") || (sQuest == "t")) && (GetItemPossessedBy(oStudent, "slv_deanbookt") != OBJECT_INVALID))
                    {DelayCommand(3.0, AssignCommand(oDragon, SpeakString("Terrific.  It's about time, I might add.  No, literally. Master of Transmutation Auroneous has some materials for a temporal device, my own...unique...instrument which was designed by mad Arcadavera and built by Auroneous.  These parts must be collected by you and taken to Imogene so that she can prepare them for imminent departure.  Imogene will pay you for your transport services with a keyword for 'T'.", TALKVOLUME_TALK)));
                    }
               else if (((sQuest == "U") || (sQuest == "u")) && (GetItemPossessedBy(oStudent, "slv_deanbooku") != OBJECT_INVALID))
                    {DelayCommand(3.0, AssignCommand(oDragon, SpeakString("Up then under are for you, new dimensions of the 'U'. Identify my friendships true; most familiar has the clue. Friends you'll slumber or subdue; other creatures blast to goo. (In your pocket's something new.)", TALKVOLUME_TALK)));
                     CreateItemOnObject("slv_key_roof", oStudent, 1);
					 }
               else if (((sQuest == "V") || (sQuest == "v")) && (GetItemPossessedBy(oStudent, "slv_deanbookv") != OBJECT_INVALID))
                    {DelayCommand(3.0, AssignCommand(oDragon, SpeakString("Verily, to the vault of knowledge go.  For the keyword search high, search low.", TALKVOLUME_TALK)));
                    }
               else if (((sQuest == "W") || (sQuest == "w")) && (GetItemPossessedBy(oStudent, "slv_deanbookw") != OBJECT_INVALID))
                    {DelayCommand(3.0, AssignCommand(oDragon, SpeakString("'Where', 'when', 'what' and 'who', all begin with 'W'. Professor Auroneous is the master of employing these to produce a 'how'. Wander up there and request the keyword for my 'W' quest.", TALKVOLUME_TALK)));
                    }
               else if (((sQuest == "X") || (sQuest == "x")) && (GetItemPossessedBy(oStudent, "slv_deanbookx") != OBJECT_INVALID))
                    {DelayCommand(3.0, AssignCommand(oDragon, SpeakString("X marks the spot indeed, and so we come to the crux.  Find the X in the Master's Hall and there you should have the inheritrix of an enchanter's tricks.", TALKVOLUME_TALK)));
                    }
               else if (((sQuest == "Y") || (sQuest == "y")) && (GetItemPossessedBy(oStudent, "slv_deanbooky") != OBJECT_INVALID))
                    {DelayCommand(3.0, AssignCommand(oDragon, SpeakString("Yes, 'Y'.  Why you?  Yearn for the answer as I do, and seek it in your yesteryears. You will find a good vantage point for review on the roof.", TALKVOLUME_TALK)));
                     CreateItemOnObject("slv_key_roof", oStudent, 1);
					 }
               else if (((sQuest == "Z") || (sQuest == "z")) && (GetItemPossessedBy(oStudent, "slv_deanbookz") != OBJECT_INVALID))
                    {DelayCommand(3.0, AssignCommand(oDragon, SpeakString("Zealously pursuing your studies, eh? For this one, you will need to zip up to the Master's Hall Portal. It is ready for you. Merely stepping onto it will transport your whole party to the next test, so be ready before you do so.", TALKVOLUME_TALK)));
                    }
               else {DelayCommand(3.0, AssignCommand(oDragon, SpeakString("Proper preparation is the first step in any research project.  Did you follow intructions?  Do you wish to receive or submit a project?", TALKVOLUME_TALK)));
                     SetLocalInt(oStudent, "Improper", 1);
                    }

				
				
              if(GetLocalInt(oStudent, "Improper") != 1)
                    {SetCampaignString("SLV_UNI", "DragonQuest" + GetStringUpperCase(sQuest), "Open", oStudent);
                     ACR_AddPersistentJournalQuestEntry("slv_deandragon_" + GetStringLowerCase(sQuest), 1, oStudent, FALSE, FALSE, FALSE, 0);
					 DelayCommand(10.0, AssignCommand(oDragon, SpeakString("Farewell for now. I look forward to hearing the keyword upon completion of your task.", TALKVOLUME_TALK)));
                     DelayCommand(30.0, AssignCommand(oDragon, SpeakString("I will become inanimate in 10 seconds.  I look forward to speaking to you about what you learn.", TALKVOLUME_TALK)));
                     DelayCommand(40.0, SetLocalInt(oStudent, "QuestAssignmentOpen", 0));
                     DelayCommand(40.0, SetLocalInt(oStudent, "DeanDragonConversation", 0));
                     DelayCommand(40.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGlimmer, oDragon, 10.0));
                     DestroyObject(OBJECT_SELF, 40.5);
                     }
                  else
                    {SetLocalInt(oStudent, "QuestAssignmentOpen", 0);
                     SetLocalInt(oStudent, "DeanDragonConversation", 1);
                     }

              }
           else if(sDragonQuest == "Open")
              {AssignCommand(oDragon, SpeakString("Actually, I show the task relating to this book as assigned to you and incomplete.  You may take your time with it, but if you wish me to give you a new task, both tasks -- and any others already assigned -- will be regarded as assigned to you and currently incomplete.", TALKVOLUME_TALK));
               DelayCommand(5.0, SpeakString(sTryAgain, TALKVOLUME_TALK));
               SetLocalInt(oStudent, "QuestAssignmentOpen", 0);
               SetLocalInt(oStudent, "DeanDragonConversation", 1);
                }
           else if(sDragonQuest == "Completed")
              {AssignCommand(oDragon, SpeakString("Curious.  I show the task relating to this book as already completed and submitted, but you have not used the keyword to enter.  Perhaps you didn't have time before?  You may enter now, if you wish, by speaking the word 'enter'.", TALKVOLUME_TALK));
               SetLocalInt(oStudent, "QuestAssignmentOpen", 0);
               SetLocalInt(oStudent, "DeanDragonConversation", 1);
                }
           else if(sDragonQuest == "Graded")
              {AssignCommand(oDragon, SpeakString("How forgetful of you.  You have already completed this task and used the keyword to enter the restricted areas.", TALKVOLUME_TALK));
               DelayCommand(5.0, AssignCommand(oDragon, SpeakString(sTryAgain, TALKVOLUME_TALK)));
               SetLocalInt(oStudent, "QuestAssignmentOpen", 0);
               SetLocalInt(oStudent, "DeanDragonConversation", 1);
                }

           }

     else if((GetLocalInt(oStudent, "DeanDragonConversation") == 3) && (GetLocalInt(oStudent, "QuestAssignmentOpen") == 2))
          {string sQuest = GetLocalString(OBJECT_SELF, "Quest");
           string sTitle = GetLocalString(OBJECT_SELF, "Title");
           string sDragonQuest = GetCampaignString("SLV_UNI", "DragonQuest" + GetStringUpperCase(sQuest), oStudent);
		   if(sDragonQuest == "")
              {AssignCommand(oDragon, SpeakString("I think you must be mistaken.  I know I am not, when I say that you have not even been given this task, much less completed it.",  TALKVOLUME_TALK));
               DelayCommand(5.0, AssignCommand(oDragon, SpeakString(sTryAgain, TALKVOLUME_TALK)));
               SetLocalInt(oStudent, "QuestAssignmentOpen", 0);
               SetLocalInt(oStudent, "DeanDragonConversation", 1);
               }

           else if(sDragonQuest == "Open")
              {AssignCommand(oDragon, SpeakString("Very well.  Show that you have finished the task on " + sTitle + ".  I believe you should have a keyword to prove completion? Speak it.", TALKVOLUME_TALK));
               }

           else if(sDragonQuest == "Completed")
              {AssignCommand(oDragon, SpeakString("Curious.  I show the task relating to this book as already completed and submitted, but the keyword has not been used for entry to the restricted areas.  Perhaps you didn't have time before?  You may enter now, if you wish, by speaking the word 'enter'.", TALKVOLUME_TALK));
               SetLocalInt(oStudent, "QuestAssignmentOpen", 0);
               SetLocalInt(oStudent, "DeanDragonConversation", 1);
               }
           else if(sDragonQuest == "Graded")
              {AssignCommand(oDragon, SpeakString("How forgetful of you.  You have already completed this task and used the keyword for it to enter the restricted areas.", TALKVOLUME_TALK));
               DelayCommand(5.0, AssignCommand(oDragon, SpeakString(sTryAgain, TALKVOLUME_TALK)));
               SetLocalInt(oStudent, "QuestAssignmentOpen", 0);
               SetLocalInt(oStudent, "DeanDragonConversation", 1);
               }

            }

    else if((GetLocalInt(oStudent, "DeanDragonConversation") == 3) && (GetLocalInt(oStudent, "QuestAssignmentOpen") == 3))
          {string sQuest = GetLocalString(OBJECT_SELF, "Quest");
           string sTitle = GetLocalString(OBJECT_SELF, "Title");
           string sDragonQuest = GetCampaignString("SLV_UNI", "DragonQuest" + GetStringUpperCase(sQuest), oStudent);
		   if(sDragonQuest == "")
              {AssignCommand(oDragon, SpeakString("I think you must be mistaken.  I know I am not, when I say that you have neither been given this task, nor completed it.  You are not ready to enter the restricted areas, in any case.",  TALKVOLUME_TALK));
              DelayCommand(5.0, AssignCommand(oDragon, SpeakString(sTryAgain, TALKVOLUME_TALK)));
               SetLocalInt(oStudent, "QuestAssignmentOpen", 0);
               SetLocalInt(oStudent, "DeanDragonConversation", 1);
               }

           else if(sDragonQuest == "Open")
              {AssignCommand(oDragon, SpeakString("In good time.  First you must show me that you have completed the task relating to "  + sTitle + ".  Please tell me the keyword you should have learned.", TALKVOLUME_TALK));
              }

           else if(sDragonQuest == "Graded")
              {AssignCommand(oDragon, SpeakString("How forgetful of you.  You have already completed and used the keyword for this task.", TALKVOLUME_TALK));
               DelayCommand(5.0, AssignCommand(oDragon, SpeakString(sTryAgain, TALKVOLUME_TALK)));
               SetLocalInt(oStudent, "QuestAssignmentOpen", 0);
               SetLocalInt(oStudent, "DeanDragonConversation", 1);
               }

           }

        else if(GetLocalInt(oStudent, "DeanDragonConversation") == 4)
          {string sQuest = GetLocalString(OBJECT_SELF, "Quest");
           string sTitle = GetLocalString(OBJECT_SELF, "Title");
           SetLocalString(oStudent, "DragonQuest" + sQuest, "Completed");
           AssignCommand(oDragon, SpeakString("If you would like to enter the restricted areas now, please use the word 'enter' in your reply.  If you wish to receive or submit another assignment, you must first end this conversation with the word 'reschedule' and then begin a new one.  Otherwise, I shall become inanimate at the end of my allotted time.", TALKVOLUME_TALK));

          }

	

}