#include "silvy_univ_inc"
#include "acr_db_persist_i"
#include "acr_spawn_i"
#include "silvy_univ_func"
#include "acr_quest_i"
#include "acr_i"

 

void main()
{   object oMouth = OBJECT_SELF;
    object oStudent = GetLocalObject(OBJECT_SELF, "oStudent");
    object oSphinx = GetLocalObject(OBJECT_SELF, "oSphinx");
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

      if((GetLocalInt(oStudent, "DeanSphinxConversation") == 1) && (GetLocalInt(oStudent, "QuestAssignmentOpen") < 1) )
         {AssignCommand(oSphinx, SpeakString("The key to this door is knowledge.  Do you wish to receive an assignment?", TALKVOLUME_TALK));
          }

     else if((GetLocalInt(oStudent, "DeanSphinxConversation") == 2) && (GetLocalInt(oStudent, "QuestAssignmentOpen") < 1) && ((GetLocalString(OBJECT_SELF, "QuestSubmitAssignString") == "receive") || (GetLocalString(OBJECT_SELF, "QuestSubmitAssignString") == "Receive") || (GetLocalString(OBJECT_SELF, "QuestSubmitAssignString") == "recieve")|| (GetLocalString(OBJECT_SELF, "QuestSubmitAssignString") == "Recieve")))
         {
          AssignCommand(oSphinx, SpeakString("Very well.  Choose one text on which to be tested, and hold it tightly.  When you are ready to begin, speak the title.", TALKVOLUME_TALK));
          SetLocalInt(oStudent, "QuestAssignmentOpen", 1);
          }

     else if((GetLocalInt(oStudent, "DeanSphinxConversation") == 2) && (GetLocalInt(oStudent, "QuestAssignmentOpen") < 1) && ((GetLocalString(OBJECT_SELF, "QuestSubmitAssignString") == "submit")||(GetLocalString(OBJECT_SELF, "QuestSubmitAssignString") == "Submit")))
         {
          AssignCommand(oSphinx, SpeakString("Very well.  Which assignment have you completed?", TALKVOLUME_TALK));
          SetLocalInt(oStudent, "QuestAssignmentOpen", 2);
          }

      else if((GetLocalInt(oStudent, "DeanSphinxConversation") == 2) && (GetLocalInt(oStudent, "QuestAssignmentOpen") < 1) && ((GetLocalString(OBJECT_SELF, "QuestSubmitAssignString") == "enter")||(GetLocalString(OBJECT_SELF, "QuestSubmitAssignString") == "Enter")))
         {
          AssignCommand(oSphinx, SpeakString("Very well.  Which assignment have you completed to earn entry?", TALKVOLUME_TALK));
          SetLocalInt(oStudent, "QuestAssignmentOpen", 3);
          }

      else if((GetLocalInt(oStudent, "DeanSphinxConversation") == 3) && (GetLocalInt(oStudent, "QuestAssignmentOpen") == 1))
          {
           string sQuest = GetLocalString(OBJECT_SELF, "Quest");
           string sTitle = GetLocalString(OBJECT_SELF, "Title");
           string sSphinxQuest = GetCampaignString("SLV_UNI", "SphinxQuest" + GetStringUpperCase(sQuest), oStudent);
		   //8XAdvanced courses, 12xElemental, 2xNegative, 2xPositive, 6xAnimal/Vegetable/Mineral, 8xElf,Dwarf,Gnome,Hin,Orc,Human,Fey,Celestial,Infernal,Undead,Goblin,Gnoll, 8xWiz,Sor,Cle,Bg,SS,Dr,Wl,Brd
		   if(sSphinxQuest == "")
              {SetLocalInt(oStudent, "Improper", 0);
               if (((sQuest == "A") || (sQuest == "a")) && (GetItemPossessedBy(oStudent, "slv_deansphinx_a") != OBJECT_INVALID))
                    {DelayCommand(5.0, AssignCommand(oSphinx, SpeakString("With a sincere heart and unfeigned faith, I abjure, curse, and detest the said errors and heresies, and generally every other error and sect contrary to Lathander’s Light; and I swear that I will never more in future say or assert anything verbally, or in writing, which may give rise to a similar suspicion of me.", TALKVOLUME_TALK)));
                     //Abjuration, Elemental(Ice, Fire)
					}
               else if (((sQuest == "B") || (sQuest == "b")) && (GetItemPossessedBy(oStudent, "slv_deansphinx_b") != OBJECT_INVALID))
                    {DelayCommand(3.0, AssignCommand(oSphinx, SpeakString("I know that I am mortal by nature, and ephemeral; but when I trace at my pleasure the windings to and fro of the heavenly bodies I no longer touch earth with my feet: I stand in the presence of Ao himself and take my fill of ambrosia, food of the gods.", TALKVOLUME_TALK)));
                    }
               else if (((sQuest == "C") || (sQuest == "c")) && (GetItemPossessedBy(oStudent, "slv_deansphinx_c") != OBJECT_INVALID))
                    {DelayCommand(3.0, AssignCommand(oSphinx, SpeakString("Nor did his beauty ransom the centaur Cyllarus, fighting that day, if hybrids such as he be granted beauty.", TALKVOLUME_TALK)));
                    }
               else if (((sQuest == "D") || (sQuest == "d")) && (GetItemPossessedBy(oStudent, "slv_deansphinx_d") != OBJECT_INVALID))
                    {DelayCommand(3.0, AssignCommand(oSphinx, SpeakString("Silverwing is sometimes called the Kindly Dragon in the lore of the North, because he so often aids humanoids.", TALKVOLUME_TALK)));
                    }
               else if (((sQuest == "E") || (sQuest == "e"))&& (GetItemPossessedBy(oStudent, "slv_deansphinx_e") != OBJECT_INVALID))
                    {DelayCommand(3.0, AssignCommand(oSphinx, SpeakString("Man is a microcosm, or a little world, because he is an extract from all the stars and planets of the whole firmament, from the earth and the elements; and so he is their quintessence.", TALKVOLUME_TALK)));
                    }
               else if (((sQuest == "F") || (sQuest == "f"))&& (GetItemPossessedBy(oStudent, "slv_deansphinx_f") != OBJECT_INVALID))
                    {DelayCommand(3.0, AssignCommand(oSphinx, SpeakString("O! for a muse of fire, that would ascend the brightest heaven of invention.", TALKVOLUME_TALK)));
                    }
               else if (((sQuest == "G") || (sQuest == "g")) && (GetItemPossessedBy(oStudent, "slv_deansphinx_g") != OBJECT_INVALID))
                    {DelayCommand(3.0, AssignCommand(oSphinx, SpeakString("He made a human figure of unliving material, and left a small aperture in the lesser brain in which he laid that which binds all living things. The clod immediately arose and was a man…", TALKVOLUME_TALK)));
                    }
               else if (((sQuest == "H") || (sQuest == "h")) && (GetItemPossessedBy(oStudent, "slv_deansphinx_h") != OBJECT_INVALID))
                    {DelayCommand(3.0, AssignCommand(oSphinx, SpeakString("No monster more baneful than these, no fiercer plague or wrath of the gods ever rose from the waves. Maiden faces have these birds, foulest filth they drop, clawed hands are theirs, and faces ever gaunt with hunger . . .", TALKVOLUME_TALK)));
                    }
               else if (((sQuest == "I") || (sQuest == "i")) && (GetItemPossessedBy(oStudent, "slv_deansphinx_i") != OBJECT_INVALID))
                    {DelayCommand(3.0, AssignCommand(oSphinx, SpeakString("Illusions commend themselves to us because they save us pain and allow us to enjoy pleasure instead. We must therefore accept it without complaint when they sometimes collide with a bit of reality against which they are dashed to pieces.", TALKVOLUME_TALK)));
                    }
               else if (((sQuest == "J") || (sQuest == "j")) && (GetItemPossessedBy(oStudent, "slv_deansphinx_j") != OBJECT_INVALID))
                    {DelayCommand(3.0, AssignCommand(oSphinx, SpeakString("The magician thanked him who spoke, and having seen the palace knew that it had been raised by the jann of the lamp, and became half mad with rage.", TALKVOLUME_TALK)));
                    }
               else if (((sQuest == "K") || (sQuest == "k")) && (GetItemPossessedBy(oStudent, "slv_deansphinx_k") != OBJECT_INVALID))
                    {DelayCommand(3.0, AssignCommand(oSphinx, SpeakString("Old King Kobold was a merry old soul, and a merry old soul was he. He called for his pipe and he called for his drum and he called for his fiddlers three.", TALKVOLUME_TALK)));
                    }
               else if (((sQuest == "L") || (sQuest == "l")) && (GetItemPossessedBy(oStudent, "slv_deansphinx_l") != OBJECT_INVALID))
                    {DelayCommand(3.0, AssignCommand(oSphinx, SpeakString("Fenrir, however, inspired too much fear in them for them to let him out from under their watchful eyes. Only Tyr, the indefatigable upholder of law and honor, dared to approach the werewolf to feed him.", TALKVOLUME_TALK)));
                    }
               else if (((sQuest == "M") || (sQuest == "m")) && (GetItemPossessedBy(oStudent, "slv_deansphinx_m") != OBJECT_INVALID))
                    {DelayCommand(3.0, AssignCommand(oSphinx, SpeakString("Following his instructions, she gave the hero a ball of thread as he entered. He fastened this to the door and let it trail behind him as he went in. He came across the Minotauros in the furthest section of the labyrinth, killed him with jabs of his fist, and then made his way out again by pulling himself along the thread.", TALKVOLUME_TALK)));
                    }
               else if (((sQuest == "N") || (sQuest == "n")) && (GetItemPossessedBy(oStudent, "slv_deansphinx_n") != OBJECT_INVALID))
                    {DelayCommand(3.0, AssignCommand(oSphinx, SpeakString("For this pale, fatal-eyed woman, with the green weeds, looked like a birth from some cold sedgy stream, the daughter of an aged river.", TALKVOLUME_TALK)));
                    }
               else if (((sQuest == "O") || (sQuest == "o")) && (GetItemPossessedBy(oStudent, "slv_deansphinx_o") != OBJECT_INVALID))
                    {DelayCommand(3.0, AssignCommand(oSphinx, SpeakString("The Orcs reeled and screamed and cast aside both sword and spear. Like a black smoke driven by a mounting wind they fled. Wailing they passed under the waiting shadow of the trees; and from that shadow none ever came again.", TALKVOLUME_TALK)));
                    }
               else if (((sQuest == "P") || (sQuest == "p")) && (GetItemPossessedBy(oStudent, "slv_deansphinx_p") != OBJECT_INVALID))
                    {DelayCommand(3.0, AssignCommand(oSphinx, SpeakString("Now the Phoenix's bright eye grows dim and the pupil becomes palsied by the frost of years...", TALKVOLUME_TALK)));
                    }
               else if (((sQuest == "Q") || (sQuest == "q")) && (GetItemPossessedBy(oStudent, "slv_deansphinx_q") != OBJECT_INVALID))
                    {DelayCommand(3.0, AssignCommand(oSphinx, SpeakString("The feather whence the pen was shaped that traced the lives of these good men, dropped from an archon’s wing.", TALKVOLUME_TALK)));
                    }
               else if (((sQuest == "R") || (sQuest == "r"))&& (GetItemPossessedBy(oStudent, "slv_deansphinx_r") != OBJECT_INVALID))
                    {DelayCommand(3.0, AssignCommand(oSphinx, SpeakString("For many hours the immediate vicinity of the low framework upon which I lay, had been literally swarming with rats. They were wild, bold, ravenous; their red eyes glaring upon me as if they waited but for motionlessness on my part to make me their prey.", TALKVOLUME_TALK)));
                    }
               else if (((sQuest == "S") || (sQuest == "s")) && (GetItemPossessedBy(oStudent, "slv_deansphinx_s") != OBJECT_INVALID))
                    {DelayCommand(3.0, AssignCommand(oSphinx, SpeakString("The sage does not hoard. The more he helps others, the more he benefits himself. The more he gives to others, the more he gets himself.", TALKVOLUME_TALK)));
                    }
               else if (((sQuest == "T") || (sQuest == "t")) && (GetItemPossessedBy(oStudent, "slv_deansphinx_t") != OBJECT_INVALID))
                    {DelayCommand(3.0, AssignCommand(oSphinx, SpeakString("Some of my kin look just like trees now, and need something great to rouse them; and they speak only in whispers. But some of my trees are limb-lithe, and many can talk to me.", TALKVOLUME_TALK)));
                    }
               else if (((sQuest == "U") || (sQuest == "u")) && (GetItemPossessedBy(oStudent, "slv_deansphinx_u") != OBJECT_INVALID))
                    {DelayCommand(3.0, AssignCommand(oSphinx, SpeakString("The bridge will only take you halfway there, to those mysterious lands you long to see. Through gypsy camps and swirling Uthgardt fair, and moonlit woods where unicorns run free. So come and walk awhile with me and share the twisting trails and wondrous worlds I've known. But this bridge will only take you halfway there. The last few steps you have to take alone.", TALKVOLUME_TALK)));
                     CreateItemOnObject("slv_key_roof", oStudent, 1);
					 }
               else if (((sQuest == "V") || (sQuest == "v")) && (GetItemPossessedBy(oStudent, "slv_deansphinx_v") != OBJECT_INVALID))
                    {DelayCommand(3.0, AssignCommand(oSphinx, SpeakString("They say sad rivers swelled with their own tears—naiads and dryads with dishevelled hair wore garments of dark color. His torn limbs were scattered in strange places. Rauvin then received his head and harp—and, wonderful! While his loved harp was floating down the stream, it mourned for him beyond my power to tell. His tongue though lifeless, uttered a mournful sound.", TALKVOLUME_TALK)));
                    }
               else if (((sQuest == "W") || (sQuest == "w")) && (GetItemPossessedBy(oStudent, "slv_deansphinx_w") != OBJECT_INVALID))
                    {DelayCommand(3.0, AssignCommand(oSphinx, SpeakString("After these years, a helping hand? O goddess, what guile is hidden here? A raft, you say, to cross the Western Ocean, rough water, and unknown? Seaworthy ships that glory in god's wind will never cross it. I take no raft you grudge me out to sea. Or yield me first a great oath, if I do, to work no more enchantment to my harm.", TALKVOLUME_TALK)));
                    }
               else if (((sQuest == "X") || (sQuest == "x")) && (GetItemPossessedBy(oStudent, "slv_deansphinx_x") != OBJECT_INVALID))
                    {DelayCommand(3.0, AssignCommand(oSphinx, SpeakString("Ashes to ashes. Dust to dust.", TALKVOLUME_TALK)));
                    }
               else if (((sQuest == "Y") || (sQuest == "y")) && (GetItemPossessedBy(oStudent, "slv_deansphinx_y") != OBJECT_INVALID))
                    {DelayCommand(3.0, AssignCommand(oSphinx, SpeakString("Let us beware lest the cursed cur prevent us even from the nethermost hell from delivering the goddess by his furious howling, just as he did when on earth.", TALKVOLUME_TALK)));
                     CreateItemOnObject("slv_key_roof", oStudent, 1);
					 }
               else if (((sQuest == "Z") || (sQuest == "z")) && (GetItemPossessedBy(oStudent, "slv_deansphinx_z") != OBJECT_INVALID))
                    {DelayCommand(3.0, AssignCommand(oSphinx, SpeakString("Their flesh will rot while they are still standing on their feet, their eyes will rot in their sockets, and their tongues will rot in their mouths.", TALKVOLUME_TALK)));
                    }
               else {DelayCommand(3.0, AssignCommand(oSphinx, SpeakString("Proper preparation is the first step in any research project.  Did you follow instructions?  Do you wish to receive a project?", TALKVOLUME_TALK)));
                     SetLocalInt(oStudent, "Improper", 1);
                    }

				
				
              if(GetLocalInt(oStudent, "Improper") != 1)
                    {SetCampaignString("SLV_UNI", "SphinxQuest" + GetStringUpperCase(sQuest), "Open", oStudent);
                     ACR_AddPersistentJournalQuestEntry("slv_deansphinx_" + GetStringLowerCase(sQuest), 1, oStudent, FALSE, FALSE, FALSE, 0);
					 DelayCommand(10.0, AssignCommand(oSphinx, SpeakString("Farewell for now. I look forward to binding the essence to the draft page upon completion of your task.", TALKVOLUME_TALK)));
                     DelayCommand(30.0, AssignCommand(oSphinx, SpeakString("I will become inanimate in 10 seconds.", TALKVOLUME_TALK)));
                     DelayCommand(40.0, SetLocalInt(oStudent, "QuestAssignmentOpen", 0));
                     DelayCommand(40.0, SetLocalInt(oStudent, "DeanSphinxConversation", 0));
                     DelayCommand(40.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGlimmer, oSphinx, 10.0));
                     DestroyObject(OBJECT_SELF, 40.5);
                     }
                  else
                    {SetLocalInt(oStudent, "QuestAssignmentOpen", 0);
                     SetLocalInt(oStudent, "DeanSphinxConversation", 1);
                     }

              }
           else if(sSphinxQuest == "Open")
              {AssignCommand(oSphinx, SpeakString("Actually, I show the task relating to this book as assigned to you and incomplete.  You may take your time with it, but if you wish me to give you a new task, both tasks -- and any others already assigned -- will be regarded as assigned to you and currently incomplete.", TALKVOLUME_TALK));
               DelayCommand(5.0, SpeakString(sTryAgain, TALKVOLUME_TALK));
               SetLocalInt(oStudent, "QuestAssignmentOpen", 0);
               SetLocalInt(oStudent, "DeanSphinxConversation", 1);
                }
           else if(sSphinxQuest == "Completed")
              {AssignCommand(oSphinx, SpeakString("Curious.  I show the task relating to this book as already completed and submitted, but you have not used the keyword to enter.  Perhaps you didn't have time before?  You may enter now, if you wish, by speaking the word 'enter'.", TALKVOLUME_TALK));
               SetLocalInt(oStudent, "QuestAssignmentOpen", 0);
               SetLocalInt(oStudent, "DeanSphinxConversation", 1);
                }
           else if(sSphinxQuest == "Graded")
              {AssignCommand(oSphinx, SpeakString("How forgetful of you.  You have already completed this task and used the keyword to enter the restricted areas.", TALKVOLUME_TALK));
               DelayCommand(5.0, AssignCommand(oSphinx, SpeakString(sTryAgain, TALKVOLUME_TALK)));
               SetLocalInt(oStudent, "QuestAssignmentOpen", 0);
               SetLocalInt(oStudent, "DeanSphinxConversation", 1);
                }

           }

     else if((GetLocalInt(oStudent, "DeanSphinxConversation") == 3) && (GetLocalInt(oStudent, "QuestAssignmentOpen") == 2))
          {string sQuest = GetLocalString(OBJECT_SELF, "Quest");
           string sTitle = GetLocalString(OBJECT_SELF, "Title");
           string sSphinxQuest = GetCampaignString("SLV_UNI", "SphinxQuest" + GetStringUpperCase(sQuest), oStudent);
		   if(sSphinxQuest == "")
              {AssignCommand(oSphinx, SpeakString("I think you must be mistaken.  I know I am not, when I say that you have not even been given this task, much less completed it.",  TALKVOLUME_TALK));
               DelayCommand(5.0, AssignCommand(oSphinx, SpeakString(sTryAgain, TALKVOLUME_TALK)));
               SetLocalInt(oStudent, "QuestAssignmentOpen", 0);
               SetLocalInt(oStudent, "DeanSphinxConversation", 1);
               }

           else if(sSphinxQuest == "Open")
              {AssignCommand(oSphinx, SpeakString("Very well.  Show that you have finished the task on " + sTitle + ".  I believe you should have a keyword to prove completion? Speak it.", TALKVOLUME_TALK));
               }

           else if(sSphinxQuest == "Completed")
              {AssignCommand(oSphinx, SpeakString("Curious.  I show the task relating to this book as already completed and submitted, but the keyword has not been used for entry to the restricted areas.  Perhaps you didn't have time before?  You may enter now, if you wish, by speaking the word 'enter'.", TALKVOLUME_TALK));
               SetLocalInt(oStudent, "QuestAssignmentOpen", 0);
               SetLocalInt(oStudent, "DeanSphinxConversation", 1);
               }
           else if(sSphinxQuest == "Graded")
              {AssignCommand(oSphinx, SpeakString("How forgetful of you.  You have already completed this task and used the keyword for it to enter the restricted areas.", TALKVOLUME_TALK));
               DelayCommand(5.0, AssignCommand(oSphinx, SpeakString(sTryAgain, TALKVOLUME_TALK)));
               SetLocalInt(oStudent, "QuestAssignmentOpen", 0);
               SetLocalInt(oStudent, "DeanSphinxConversation", 1);
               }

            }

    else if((GetLocalInt(oStudent, "DeanSphinxConversation") == 3) && (GetLocalInt(oStudent, "QuestAssignmentOpen") == 3))
          {string sQuest = GetLocalString(OBJECT_SELF, "Quest");
           string sTitle = GetLocalString(OBJECT_SELF, "Title");
           string sSphinxQuest = GetCampaignString("SLV_UNI", "SphinxQuest" + GetStringUpperCase(sQuest), oStudent);
		   if(sSphinxQuest == "")
              {AssignCommand(oSphinx, SpeakString("I think you must be mistaken.  I know I am not, when I say that you have neither been given this task, nor completed it.  You are not ready to enter the restricted areas, in any case.",  TALKVOLUME_TALK));
              DelayCommand(5.0, AssignCommand(oSphinx, SpeakString(sTryAgain, TALKVOLUME_TALK)));
               SetLocalInt(oStudent, "QuestAssignmentOpen", 0);
               SetLocalInt(oStudent, "DeanSphinxConversation", 1);
               }

           else if(sSphinxQuest == "Open")
              {AssignCommand(oSphinx, SpeakString("In good time.  First you must show me that you have completed the task relating to "  + sTitle + ".  Please tell me the keyword you should have learned.", TALKVOLUME_TALK));
              }

           else if(sSphinxQuest == "Graded")
              {AssignCommand(oSphinx, SpeakString("How forgetful of you.  You have already completed and used the keyword for this task.", TALKVOLUME_TALK));
               DelayCommand(5.0, AssignCommand(oSphinx, SpeakString(sTryAgain, TALKVOLUME_TALK)));
               SetLocalInt(oStudent, "QuestAssignmentOpen", 0);
               SetLocalInt(oStudent, "DeanSphinxConversation", 1);
               }

           }

        else if(GetLocalInt(oStudent, "DeanSphinxConversation") == 4)
          {string sQuest = GetLocalString(OBJECT_SELF, "Quest");
           string sTitle = GetLocalString(OBJECT_SELF, "Title");
           SetLocalString(oStudent, "SphinxQuest" + sQuest, "Completed");
           AssignCommand(oSphinx, SpeakString("If you would like to enter the restricted areas now, please use the word 'enter' in your reply.  If you wish to receive or submit another assignment, you must first end this conversation with the word 'reschedule' and then begin a new one.  Otherwise, I shall become inanimate at the end of my allotted time.", TALKVOLUME_TALK));

          }

	

}