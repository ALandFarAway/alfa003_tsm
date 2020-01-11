#include "silvy_univ_inc"
#include "acr_spawn_i"
#include "acr_db_persist_i"
#include "silvy_univ_func"


void main()
{   object oVoice = OBJECT_SELF;
    object oStudent = GetLocalObject(OBJECT_SELF, "oStudent");
	object oSphinx = GetLocalObject(OBJECT_SELF, "oSphinx");
    object oCabinetStatic = GetLocalObject(OBJECT_SELF, "oCabinetStatic");
	object oCabinet = GetLocalObject(OBJECT_SELF, "oCabinet");
	object oCollBox = GetLocalObject(OBJECT_SELF, "oCollBox");
	location lCabinet = GetLocalLocation(OBJECT_SELF, "lCabinet");
	string sCampaignGreeted = GetLocalString(oStudent, "sDeanSphinxGreeted");
	if(sCampaignGreeted == "")
		{sCampaignGreeted = GetCampaignString("SLV_UNI", "DeanSphinxGreeted" + GetName(oStudent), oStudent);
		 SetLocalString(oStudent, "sDeanSphinxGreeted", sCampaignGreeted);
		 }
	string sCampaignNamed = GetLocalString(oStudent, "sDeanSphinxNamed");
	if(sCampaignNamed == "")
		{sCampaignNamed = GetCampaignString("SLV_UNI", "DeanSphinxNamed" + GetName(oStudent), oStudent);
		 SetLocalString(oStudent, "sDeanSphinxNamed", sCampaignNamed);
		 }
	string sCampaignExplained = GetLocalString(oStudent, "sDeanSphinxExplained");
	if(sCampaignExplained == "")
		{sCampaignExplained = GetCampaignString("SLV_UNI", "DeanSphinxExplained" + GetName(oStudent), oStudent);
		 SetLocalString(oStudent, "sDeanSphinxExplained", sCampaignExplained);
		 }
	string sNameGivenSphinx = GetLocalString(oStudent, "sNameGivenSphinx");
	if(sNameGivenSphinx == "")
		{sNameGivenSphinx = GetCampaignString("SLV_UNI", "sNameGivenSphinx", oStudent);
		 SetLocalString(oStudent, "sNameGivenSphinx", sNameGivenSphinx);
		 }
    string sGreeting;
    string sGenderPronoun;
    string sGenderMaster;
    string sGenderJack;
    string sFullName = GetName(oStudent);
    string sRace;
    string sAge;
    string sClass;
    string sAlignment;
    string sDeity = GetDeity(oStudent);
    string sDay;

 
    if(GetIsDay())
        {sDay = "day";}
        else
        {sDay = "night";}

    // Break the Full Name into First, Middle and Last Names

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



    //Set Gender related strings
    if(GetGender(oStudent) == GENDER_FEMALE) 
       {sGenderPronoun = "her";
        sGenderMaster = "Mistress";
        sGenderJack = " Jill";
       }
       else
       {sGenderPronoun = "him";
        sGenderMaster = "Master";
        sGenderJack = " Jack";
        }
        

     //Set Race and race related age strings
    if(GetRacialType(oStudent) == RACIAL_TYPE_DWARF)
       {sRace = " Dwarf";
        if(GetAge(oStudent) < 50)
            {sAge = "young";
            }
            else if(GetAge(oStudent) > 200)
            {sAge = "venerable";
            }
            else {sAge = "stout";
            }

       }
       

    else if(GetRacialType(oStudent) == RACIAL_TYPE_ELF) 
       {sRace = " Elf";
        if(GetAge(oStudent) < 110)
            {sAge = "young";
            }
            else if(GetAge(oStudent) > 200)
                {sAge = "venerable";
                }
            else
            {sAge = "not-so-young";
            }
       }
       

   else if(GetRacialType(oStudent) == RACIAL_TYPE_GNOME)
       {sRace = " Gnome";
         if(GetAge(oStudent) < 40)
            {sAge = "young";
            }
            else if(GetAge(oStudent) > 150)
                {sAge = "venerable";
                }
            else
            {sAge = "";
            }
       }
       

     else if(GetRacialType(oStudent) == RACIAL_TYPE_HALFELF)
       {sRace = " Half-blood";
          if(GetAge(oStudent) < 20)
            {sAge = "young";
            }
            else if(GetAge(oStudent) > 100)
                {sAge = "venerable";
                }
            else
            {sAge = "";
            }
       }
       

     else if(GetRacialType(oStudent) == RACIAL_TYPE_HALFLING)
       {sRace = " Halfling";
          if(GetAge(oStudent) < 25)
            {sAge = "young";
            }
            else if(GetAge(oStudent) > 80)
                {sAge = "venerable";
                }
            else
            {sAge = "";
            }
       }
       

     else if(GetRacialType(oStudent) == RACIAL_TYPE_HALFORC)
       {sRace = " Half-orc";
          if(GetAge(oStudent) < 20)
            {sAge = "cub";
            }
            else if(GetAge(oStudent) > 50)
                {sAge = "venerable";
                }
            else
            {sAge = "";
            }
       }
       

     else if(GetRacialType(oStudent) == RACIAL_TYPE_HUMAN)  
       {sRace = "";
        if((GetAge(oStudent) < 25) && (GetGender(oStudent) == GENDER_FEMALE))
            {sAge = "young lady";
            }
            else if((GetAge(oStudent) > 80)&& (GetGender(oStudent) == GENDER_FEMALE))
                {sAge = "venerable lady";
                }
            else if((GetAge(oStudent) < 25)&& (GetGender(oStudent) == GENDER_MALE))
                {sAge = "young sir";
                }
            else if((GetAge(oStudent) > 80)&& (GetGender(oStudent) == GENDER_MALE))
                {sAge = "venerable sir";
                }
            else if(GetGender(oStudent) == GENDER_FEMALE)
            {sAge = "not-so-young madame";

            }
            else if(GetGender(oStudent) == GENDER_MALE)
            {sAge = "not-so-young sir";
            }
       }
	  
	  else 
       {sRace = " Exotic Race";
          if(GetAge(oStudent) < 20)
            {sAge = "stripling";
            }
            else if(GetAge(oStudent) > 50)
                {sAge = "hopefully learned";
                }
            else
            {sAge = "";
            }
       }
       

    //Set Class related strings and generate the initial greeting the mouth gives to oStudent, based on visible clues and the emanation of power from the student
    if((GetClassByPosition(1, oStudent) == CLASS_TYPE_WIZARD) || (GetClassByPosition(2, oStudent) == CLASS_TYPE_WIZARD) || (GetClassByPosition(3, oStudent) == CLASS_TYPE_WIZARD))
       {sClass = "Wizard";
        if(Random(2) == 0)
            {sGreeting = "By the pricking of my thumbs...something with a touch of the arcane about " + sGenderPronoun + " comes.  Do you have a name for my Master, " + sAge + sRace + "?";
            }
            else if(Random(2) == 0)
            {sGreeting = "Ding dong dell, arcane power I do smell.  I'd ask if we'd met but I know we haven't.  What name should I give to my Master for you, " + sAge + " " + sClass + "?";
            }
            else if(Random(2) ==  0)
            {sGreeting = "Hark, hark, the dogs do bark, the beggars come to town.  Some in rags and some in jags and one in a wizard's gown.  Wizards are my Master's business, and he likes to know their names.  What is yours?";
            }
            else
            {sGreeting = "See saw, Marjery Daw, so you've come to see my Master?  You shall have to take a test and study all the faster.  I'll need to know your name before we go any farther, " + sGenderMaster + sRace + ".";
            }
        }
        

      else if((GetClassByPosition(1, oStudent) == CLASS_TYPE_SORCERER) || (GetClassByPosition(2, oStudent) == CLASS_TYPE_SORCERER)|| (GetClassByPosition(3, oStudent) == CLASS_TYPE_SORCERER))
       {sClass = "Sorceror";
        if(Random(2) == 0)
            {sGreeting = "Double, double toil and trouble. Fire burn, and cauldron bubble.  If you can control the power I sense innate within you, my Master says such as you are welcome to study here.  What should he call you, " +sGenderMaster + sRace + "?";
            }
            else
            {sGreeting = "Which one of these is not like the others?  Do you ever feel out of place in these halls of books and learned power, " + sGenderMaster + " of the inborn talents?  And what should my Master call you?";
            }

        }
        
	  else if((GetClassByPosition(1, oStudent) == CLASS_TYPE_WARLOCK) || (GetClassByPosition(2, oStudent) == CLASS_TYPE_WARLOCK)|| (GetClassByPosition(3, oStudent) == CLASS_TYPE_WARLOCK))
       {sClass = "Warlock";
        if(Random(2) == 0)
            {sGreeting = "Double, double toil and trouble. Fire burn, and cauldron bubble.  A power non-arcane I sense within you.  What should my Master call you, " +sGenderMaster + sRace + "?";
            }
            else
            {sGreeting = "Goodness, I'll wager you draw a few stares and baleful looks in this place, " + sGenderMaster + " of the eldritch powers.  And what should my Master call you?";
            }

        }
		
 	  else if((GetClassByPosition(1, oStudent) == CLASS_TYPE_SPIRIT_SHAMAN) || (GetClassByPosition(2, oStudent) == CLASS_TYPE_SPIRIT_SHAMAN)|| (GetClassByPosition(3, oStudent) == CLASS_TYPE_SPIRIT_SHAMAN))
       {sClass = "Spirit Shaman";
        if(Random(2) == 0)
            {sGreeting = "Witchery and wode! Spirits walk with you unseen by all but me.  What should my Master call you, " +sGenderMaster + sRace + "?";
            }
            else
            {sGreeting = "Do be careful not to howl and chant too loudly for your spirit guide in these halls of study, " + sGenderMaster + ".  Do you have a pronounceable name for my Master to call you by?";
            }

        }
     else if((GetClassByPosition(1, oStudent) == CLASS_TYPE_CLERIC)|| (GetClassByPosition(2, oStudent) == CLASS_TYPE_CLERIC) || (GetClassByPosition(3, oStudent) == CLASS_TYPE_CLERIC))
       {sClass = "Cleric";
            if(sDeity == "Azuth")
            {sGreeting = "Star light, star bright, the divine power of your god gleams like the candle of knowledge, a candle my own Master burns.  Will you honor my Master with your name, friend " + sRace + "?";
            }
            
            if(sDeity == "Mystra")
            {sGreeting = "Here is the church and here is the steeple, I feel in you the divinity revered by many a wizardly people.  By what name shall my Master welcome you to these halls of magic?";
            }
            
            if((sDeity != "Mystra") && (sDeity != "Azuth"))
            {sGreeting = "A tisket, a tasket, divinity you can't mask it.  I feel the divine within the room.  Not my Master's usual student, but interesting.  By what name does your god call you?";
            }
            
         }
         

      else if ((GetClassByPosition(1, oStudent) == CLASS_TYPE_BARD) || (GetClassByPosition(2, oStudent) == CLASS_TYPE_BARD) || (GetClassByPosition(3, oStudent) == CLASS_TYPE_BARD))
       {sClass = "Bard";
        sGreeting = "Tom, Tom, the piper's son, stole a pig and away he run.  There's a hodge-podge of power within you, " + sGenderMaster + sGenderJack + "-of-all-trades-" + sGenderMaster + "-of-none.  Do you have a name to give my Master?  And not a stage name, mind you.";
        }
        

       else if ((GetClassByPosition(1, oStudent) == CLASS_TYPE_DRUID) || (GetClassByPosition(2, oStudent) == CLASS_TYPE_DRUID)|| (GetClassByPosition(3, oStudent) == CLASS_TYPE_DRUID))
       {sClass = "Druid";
        sGreeting = "A man in the wilderness asked this of me, how many strawberries grow in the sea?  I answered him as I thought good, as many red herrings as swim in the wood.  Which is precisely as many as we see here of your green divinity, " + sGenderMaster + ".  I sense the power of nature in my Master's bookish halls.  What is your name?";
        }
        

       else if ((GetClassByPosition(1, oStudent) == CLASS_TYPE_RANGER)  || (GetClassByPosition(2, oStudent) == CLASS_TYPE_RANGER) || (GetClassByPosition(3, oStudent) == CLASS_TYPE_RANGER))
       {sClass = "Woodsman";
        sGreeting = "Over the river and through the woods I'm quite sure you've come.  There's a breath of fresh air about the hint of power that lingers on you.  If you know not of what I speak...you will.  Who comes knocking at my Master's door?";
        }
        

       else if ((GetClassByPosition(1, oStudent) == CLASS_TYPE_PALADIN)  || (GetClassByPosition(2, oStudent) == CLASS_TYPE_PALADIN)|| (GetClassByPosition(3, oStudent) == CLASS_TYPE_PALADIN))
       {sClass = "Divine Warrior";
        sGreeting = "All the gods' horses and all the gods' men!  You fairly shine with godly rectitude. What name do I give to my Master for you, " + sClass + "?";
        }
        

       else 
	   {sClass = "No Power";
        sGreeting = "Nary a trace of power, divine or arcane, structured or untutored, do I taste about you, stranger.  Who are you?";
        }
        



      // After the student has responded to the greeting, the script is executed by slv_convo to see if the student gave their real name, and appropriate strings are generated until the student has given an appropriate name, FullName, FirstName or LastName

 
      //Definitions end, Magic Voice's conversation commands begin

      //Check to see if Student has completed all 26 quests. If so, give entry.  If not, begin quest conversation tree.

      int iABC = 0;
      string sCapitals = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
      string sQuestLetter = GetSubString(sCapitals, iABC, 1);
      string sQuestComplete = GetLocalString(oStudent, "SphinxQuest" + sQuestLetter);
           {while(iABC < 27)
              if(sQuestComplete == "Graded")
                {if(sQuestLetter == "Z")
                        {SetCampaignString("SLV_UNI", "26QuestsSphinx", "Yes", oStudent);
                         SpeakString("Good " + sDay + ", " + sNameGivenSphinx + ".  You may enter by speaking the word 'Flit'.", TALKVOLUME_TALK);
                         if(GetIsObjectValid(oCabinet) == FALSE)
						 	{object oCabinet = CreateObject(OBJECT_TYPE_PLACEABLE, "slv_wardrobe_large", lCabinet, FALSE, "vala_cabinet");
							 DelayCommand(2.0, SetLocked(oCabinet, FALSE));
	 						 SetLocalObject(oCabinet, "oStatic", oCabinetStatic);
                 			 SetLocalObject(oCabinet, "oCollBox", oCollBox);
                 			}
							
						 return;
                        }
                 else
                        {iABC++;
                         sQuestLetter = GetSubString(sCapitals, iABC, 1);
                         sQuestComplete = GetLocalString(oStudent, "SphinxQuest" + sQuestLetter);

                         }


                 }
                 else break;

            }

      //begin quest conversation tree
        //The greetings for students who have been there before, been Greeted and Named and Explained to

       if (sCampaignExplained == "Yes")
            {if(GetLocalInt(oStudent, "DeanSphinxConversation") == 0)
                 {SetLocalInt(oStudent, "DeanSphinxConversation", 1);
                    if(Random(2) == 0)
                    {DelayCommand(2.0, AssignCommand(oSphinx, SpeakString("Very nice to see you again, " + sNameGivenSphinx + ".", TALKVOLUME_TALK)));
                    }
                    else if(Random(2) == 0)
                    {DelayCommand(2.0, AssignCommand(oSphinx, SpeakString("What a surprising surprise, " + sGenderMaster + " " + sClass + ".", TALKVOLUME_TALK)));
                    }
                    else if(Random(2) == 0)
                    {DelayCommand(2.0, AssignCommand(oSphinx, SpeakString("Back again, eh?  I suppose it's important, " + sNameGivenSphinx + ".", TALKVOLUME_TALK)));
                    }
                    else
                    {DelayCommand(2.0, AssignCommand(oSphinx, SpeakString("Oh, hello.  Back for more games, " + sGenderMaster + sRace + "?", TALKVOLUME_TALK)));
                    }
              
                  DelayCommand(5.0, ExecuteScript("slv_static_voicequests_sphinx", OBJECT_SELF));
                 }
                
             }
     //The first-time explanation of what's going on 
				
		  if ((sCampaignNamed == "Yes")&& (sCampaignExplained != "Yes"))
                 {SetCampaignString("SLV_UNI", "DeanSphinxExplained" + GetName(oStudent), "Yes", oStudent);
                  DelayCommand(2.0, AssignCommand(oSphinx, SpeakString("Research is the answer...to almost anything, but certainly here.  My Master has been involved in a very exciting research project for years and it approaches presentation stage.  All students need be grounded in that research thus far, and any significant tidbits found on the way might even call forth dual authorship on the paper he is writing.", TALKVOLUME_TALK)));
                  DelayCommand(14.0, AssignCommand(oSphinx, SpeakString("To that end, select any text in the shelf below to your left as you face me.  Hold it tightly and speak the title.  A task or a question will be assigned.  When you have completed said task or question, provide proof of completion to me, to gain entry to restricted areas, including both my Master's office and the Dean's Library Stacks.", TALKVOLUME_TALK)));
                  DelayCommand(26.0, AssignCommand(oSphinx, SpeakString("Although I hardly expect such devotion to my Master's project from anyone but Imogene, any pre-proctor who answers all 26 tasks will receive free passage through this door whenever he, she or it wishes.  Are you ready?  Yes or no?", TALKVOLUME_TALK)));
                  }
               
// Get the name of the PC
			     
      if ((sCampaignGreeted == "Yes")&& (sCampaignNamed != "Yes"))
             {
                if((GetLocalInt(oStudent, sFullName) != 1) && (GetLocalInt(oStudent, "GaveName") == 2))
                 {DelayCommand(2.0, AssignCommand(oSphinx, SpeakString("Third time asking not the charm, and charms an integral part of what they do here?  I will speak no more until you provide me a name.", TALKVOLUME_TALK)));
                  SetLocalInt(oStudent, "GaveName", 3);
                  }
                else if((GetLocalInt(oStudent, sFullName) != 1) && (GetLocalInt(oStudent, "GaveName") == 1))
                 {DelayCommand(2.0, AssignCommand(oSphinx, SpeakString("Is that your some diminutive, because that is not your TRUE name.  My master is a very fine Diviner; I know these things, " + sGenderMaster + sRace + ".", TALKVOLUME_TALK)));
                  SetLocalInt(oStudent, "GaveName", 2);
                  }
                else if((GetLocalInt(oStudent, sFullName) != 1) && (GetLocalInt(oStudent, "GaveName") == 0))
                 {DelayCommand(2.0, AssignCommand(oSphinx, SpeakString("Before I even consider admitting you, I must have your name for my Master.", TALKVOLUME_TALK)));
                  SetLocalInt(oStudent, "GaveName", 1);
                  }

                else if(GetLocalInt(oStudent, sFullName) == 1) 
                 {SetCampaignString("SLV_UNI", "DeanSphinxNamed" + GetName(oStudent), "Yes", oStudent);
                  SetLocalInt(oStudent, sFullName, 2);
                  DelayCommand(2.0, AssignCommand(oSphinx, SpeakString("Thank you.  True names are very important, and as my Master is also your Master here, he deals only with those who give them.", TALKVOLUME_TALK)));
                  DelayCommand(7.0, AssignCommand(oSphinx, SpeakString("Now, let's get down to business.  You wouldn't be here unless a teacher had sent you for some extra training. Say 'yes' and I will go on.  Say 'no' and I'll bid you good " + sDay + ".", TALKVOLUME_TALK)));
                  }
                }
		
	  
// Speak the greeting and mark the student as permanently greeted
      if ((sCampaignGreeted != "Yes")&& (sCampaignNamed != "Yes"))

            {DelayCommand(2.0, AssignCommand(oSphinx, SpeakString(sGreeting, TALKVOLUME_TALK)));
             SetCampaignString("SLV_UNI", "DeanSphinxGreeted" + GetName(oStudent), "Yes", oStudent);
             }
			 
		
               




            

        DelayCommand(1800.00, SetLocalInt(oStudent, "DeanSphinxConversation", 0));
        DelayCommand(1800.00, DestroyObject(OBJECT_SELF));
		
			
}