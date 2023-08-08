#include "acr_spawn_i"
#include "silvy_univ_inc"
#include "acr_db_persist_i"
#include "silvy_univ_func"
 
void main()
{

         
	if((GetTag(OBJECT_SELF)== "003_cr_slv_deanvoice") || (GetTag(OBJECT_SELF)== "003_cr_slv_deanvoice_phoenix")  || (GetTag(OBJECT_SELF)== "003_cr_slv_deanvoice_sphinx"))
        {object oStudent = GetLocalObject(OBJECT_SELF, "oStudent");
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
                                if(GetStringRight(sMiddleName2, 1) == ",")
                                   {sMiddleName2 = GetStringLeft(sMiddleName2, GetStringLength(sMiddleName2) - 1);
                                   }
                                   {}
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

		string sDeity = GetDeity(oStudent);
		
				 
			 
         AssignCommand(OBJECT_SELF, ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectTrueSeeing(),OBJECT_SELF));
        // SetListeningPatterns();
		if(GetTag(OBJECT_SELF)== "003_cr_slv_deanvoice")
	         {SetListenPattern(OBJECT_SELF, sFullName, 4999);
	         SetListenPattern(OBJECT_SELF, sFirstName, 5000);
	         SetListenPattern(OBJECT_SELF, sMiddleName, 5001);
	         SetListenPattern(OBJECT_SELF, sMiddleName2, 5002);
	         SetListenPattern(OBJECT_SELF, sLastName, 5003);
	         SetListenPattern(OBJECT_SELF, "**reschedule**", 5004);
	         SetListenPattern(OBJECT_SELF, "**submit**", 5005);
	         SetListenPattern(OBJECT_SELF, "**receive**", 5006);
	         SetListenPattern(OBJECT_SELF, "**enter**", 5007);
	         SetListenPattern(OBJECT_SELF, "**Alustriel**", 5008);
	         SetListenPattern(OBJECT_SELF, "**Barbarous Ways**", 5009);
	         SetListenPattern(OBJECT_SELF, "**Crown Wars**", 5010);
	         SetListenPattern(OBJECT_SELF, "**Deszeldaryndun**", 5011);
	         SetListenPattern(OBJECT_SELF, "**Elestar**", 5012);
	         SetListenPattern(OBJECT_SELF, "**Felbar**", 5013);
	         SetListenPattern(OBJECT_SELF, "**Gond**", 5014);
	         SetListenPattern(OBJECT_SELF, "**Hornblade**", 5015);
	         SetListenPattern(OBJECT_SELF, "**Imvaernarho**", 5016);
	         SetListenPattern(OBJECT_SELF, "**Jotun Dictionary**", 5017);
	         SetListenPattern(OBJECT_SELF, "**Kiira**", 5018);
	         SetListenPattern(OBJECT_SELF, "**Labelas**", 5019);
	         SetListenPattern(OBJECT_SELF, "**Mythal**", 5020);
	         SetListenPattern(OBJECT_SELF, "**Null**", 5021);
	         SetListenPattern(OBJECT_SELF, "**On the Rise and Fall**", 5022);
	         SetListenPattern(OBJECT_SELF, "**Peers of the Realm**", 5023);
	         SetListenPattern(OBJECT_SELF, "**Quills and Quests**", 5024);
	         SetListenPattern(OBJECT_SELF, "**Rage of Dragons**", 5025);
	         SetListenPattern(OBJECT_SELF, "**Sundered World**", 5026);
	         SetListenPattern(OBJECT_SELF, "**Time's Witness**", 5027);
	         SetListenPattern(OBJECT_SELF, "**Uthgar's Legacy**", 5028);
	         SetListenPattern(OBJECT_SELF, "**Valamaradace**", 5029);
	         SetListenPattern(OBJECT_SELF, "**Wearers of Purple**", 5030);
	         SetListenPattern(OBJECT_SELF, "**Xorn**", 5031);
	         SetListenPattern(OBJECT_SELF, "**Yalathanil**", 5032);
	         SetListenPattern(OBJECT_SELF, "**Zombies, Skeletons, Ghosts and Wights**", 5033);
	         SetListenPattern(OBJECT_SELF, "**Academic**", 5034);
	         SetListenPattern(OBJECT_SELF, "**Bridge**", 5035);
	         SetListenPattern(OBJECT_SELF, "**Crossings**", 5036);
	         SetListenPattern(OBJECT_SELF, "**Distinguish**", 5037);
	         SetListenPattern(OBJECT_SELF, "**Educated**", 5038);
	         SetListenPattern(OBJECT_SELF, "**Futures**", 5039);
	         SetListenPattern(OBJECT_SELF, "**Goal**", 5040);
	         SetListenPattern(OBJECT_SELF, "**Harvest**", 5041);
	         SetListenPattern(OBJECT_SELF, "**Intertemporal**", 5042);
	         SetListenPattern(OBJECT_SELF, "**Journey**", 5043);
	         SetListenPattern(OBJECT_SELF, "**Knowledge**", 5044);
	         SetListenPattern(OBJECT_SELF, "**Location**", 5045);
	         SetListenPattern(OBJECT_SELF, "**Miles**", 5046);
	         SetListenPattern(OBJECT_SELF, "**Neath**", 5047);
	         SetListenPattern(OBJECT_SELF, "**Occidian**", 5048);
	         SetListenPattern(OBJECT_SELF, "**Passage**", 5049);
	         SetListenPattern(OBJECT_SELF, "**Questers**", 5050);
	         SetListenPattern(OBJECT_SELF, "**Return**", 5051);
	         SetListenPattern(OBJECT_SELF, "**Serves**", 5052);
	         SetListenPattern(OBJECT_SELF, "**Time's**", 5053);
	         SetListenPattern(OBJECT_SELF, "**Ultimate**", 5054);
	         SetListenPattern(OBJECT_SELF, "**Victory**", 5055);
	         SetListenPattern(OBJECT_SELF, "**While**", 5056);
	         SetListenPattern(OBJECT_SELF, "**eXtracting**", 5057);
	         SetListenPattern(OBJECT_SELF, "**Youthful**", 5058);
	         SetListenPattern(OBJECT_SELF, "**Zeal**", 5059);
	         SetListenPattern(OBJECT_SELF, "**academic bridge crossings distinguish educated futures goal harvest intertemporal journey knowledge location miles neath occidian passage questers return serves times ultimate victory while extracting youthful zeal**", 5060);
	         SetListenPattern(OBJECT_SELF, sDeity, 5061);
	         SetListenPattern(OBJECT_SELF, "**Auril**", 5062);
	         SetListenPattern(OBJECT_SELF, "**Mystra**", 5063);
	         SetListenPattern(OBJECT_SELF, "**Flit**", 5064);
	         SetListenPattern(OBJECT_SELF, "**Academic Bridge Crossings Distinguish Educated Futures Goal Harvest Intertemporal Journey Knowledge Location Miles Neath Occidian Passage Questers Return Serves Times Ultimate Victory While Extracting Youthful Zeal**", 5065);
	         SetListenPattern(OBJECT_SELF, "**Yes**", 5998);
	         SetListenPattern(OBJECT_SELF, "**No**", 5999);
	         SetListenPattern(OBJECT_SELF, "**", 6000);
	         SetListening(OBJECT_SELF, TRUE);
	         DestroyObject(OBJECT_SELF, 1800.0);
	         }
			 
		if(GetTag(OBJECT_SELF)== "003_cr_slv_deanvoice_phoenix")
	         {SetListenPattern(OBJECT_SELF, sFullName, 4999);
	         SetListenPattern(OBJECT_SELF, sFirstName, 5000);
	         SetListenPattern(OBJECT_SELF, sMiddleName, 5001);
	         SetListenPattern(OBJECT_SELF, sMiddleName2, 5002);
	         SetListenPattern(OBJECT_SELF, sLastName, 5003);
	         SetListenPattern(OBJECT_SELF, "**reschedule**", 5004);
	         SetListenPattern(OBJECT_SELF, "**submit**", 5005);
	         SetListenPattern(OBJECT_SELF, "**receive**", 5006);
	         SetListenPattern(OBJECT_SELF, "**enter**", 5007);
	         SetListenPattern(OBJECT_SELF, "**Air Elementals**", 5008);
	         SetListenPattern(OBJECT_SELF, "**Beryls**", 5009);
	         SetListenPattern(OBJECT_SELF, "**Coulrophobia**", 5010);
	         SetListenPattern(OBJECT_SELF, "**Deszeldaryndun**", 5011);
	         SetListenPattern(OBJECT_SELF, "**Escape from the Everfire**", 5012);
	         SetListenPattern(OBJECT_SELF, "**Fire Tales**", 5013);
	         SetListenPattern(OBJECT_SELF, "**Genasi vs. Mephit**", 5014);
	         SetListenPattern(OBJECT_SELF, "**Hornblade**", 5015);
	         SetListenPattern(OBJECT_SELF, "**Ignan Vocabulary**", 5016);
	         SetListenPattern(OBJECT_SELF, "**Jermlaine**", 5017);
	         SetListenPattern(OBJECT_SELF, "**K Elemental Deities**", 5018);
	         SetListenPattern(OBJECT_SELF, "**L Morninglord Rising**", 5019);
	         SetListenPattern(OBJECT_SELF, "**Mythal**", 5020);
	         SetListenPattern(OBJECT_SELF, "**Newly Made**", 5021);
	         SetListenPattern(OBJECT_SELF, "**Oxo Softfoot's Class**", 5022);
	         SetListenPattern(OBJECT_SELF, "**Phoenix**", 5023);
	         SetListenPattern(OBJECT_SELF, "**Quills and Quests**", 5024);
	         SetListenPattern(OBJECT_SELF, "**Reliquaries**", 5025);
	         SetListenPattern(OBJECT_SELF, "**Sundabar**", 5026);
	         SetListenPattern(OBJECT_SELF, "**Testament**", 5027);
	         SetListenPattern(OBJECT_SELF, "**Uthgar**", 5028);
	         SetListenPattern(OBJECT_SELF, "**Valamaradace**", 5029);
	         SetListenPattern(OBJECT_SELF, "**Watery Weirdness**", 5030);
	         SetListenPattern(OBJECT_SELF, "**Xorn**", 5031);
	         SetListenPattern(OBJECT_SELF, "**Y'tellarien**", 5032);
	         SetListenPattern(OBJECT_SELF, "**Ziggurats**", 5033);
	         SetListenPattern(OBJECT_SELF, "**Alive**", 5034);
	         SetListenPattern(OBJECT_SELF, "**But Bearing**", 5035);
	         SetListenPattern(OBJECT_SELF, "**Curse**", 5036);
	         SetListenPattern(OBJECT_SELF, "**Death**", 5037);
	         SetListenPattern(OBJECT_SELF, "**Escapes**", 5038);
	         SetListenPattern(OBJECT_SELF, "**Flame**", 5039);
	         SetListenPattern(OBJECT_SELF, "**Geased**", 5040);
	         SetListenPattern(OBJECT_SELF, "**Handle**", 5041);
	         SetListenPattern(OBJECT_SELF, "**Immolation**", 5042);
	         SetListenPattern(OBJECT_SELF, "**Jewel**", 5043);
	         SetListenPattern(OBJECT_SELF, "**Kossoth**", 5044);
	         SetListenPattern(OBJECT_SELF, "**Lathander**", 5045);
	         SetListenPattern(OBJECT_SELF, "**Must**", 5046);
	         SetListenPattern(OBJECT_SELF, "**Negate**", 5047);
	         SetListenPattern(OBJECT_SELF, "**Occult**", 5048);
	         SetListenPattern(OBJECT_SELF, "**Paradox**", 5049);
	         SetListenPattern(OBJECT_SELF, "**Quandary**", 5050);
	         SetListenPattern(OBJECT_SELF, "**Renewing**", 5051);
	         SetListenPattern(OBJECT_SELF, "**Sunbird**", 5052);
	         SetListenPattern(OBJECT_SELF, "**Teaches**", 5053);
	         SetListenPattern(OBJECT_SELF, "**Undergrads**", 5054);
	         SetListenPattern(OBJECT_SELF, "**Valuable**", 5055);
	         SetListenPattern(OBJECT_SELF, "**Workings**", 5056);
	         SetListenPattern(OBJECT_SELF, "**Xavier's**", 5057);
	         SetListenPattern(OBJECT_SELF, "**Yard**", 5058);
	         SetListenPattern(OBJECT_SELF, "**Zoological**", 5059);
	         SetListenPattern(OBJECT_SELF, "**alive but bearing curse death escapes flame geased handle immolation jewel kelemvor lathander must negate occult phoenix quandary renewing sunbird teaches undergrads valuable workings xavier’s yard zoological**", 5060);
	         SetListenPattern(OBJECT_SELF, sDeity, 5061);
	         SetListenPattern(OBJECT_SELF, "**Auril**", 5062);
	         SetListenPattern(OBJECT_SELF, "**Mystra**", 5063);
	         SetListenPattern(OBJECT_SELF, "**Flit**", 5064);
	         SetListenPattern(OBJECT_SELF, "**Alive But Bearing Curse Death Escapes Flame Geased Handle Immolation Jewel Kelemvor Lathander Must Negate Occult Phoenix Quandary Renewing Sunbird Teaches Undergrads Valuable Workings. Xavier’s Yard Zoological**", 5065);
	         SetListenPattern(OBJECT_SELF, "**Yes**", 5998);
	         SetListenPattern(OBJECT_SELF, "**No**", 5999);
	         SetListenPattern(OBJECT_SELF, "**", 6000);
	         SetListening(OBJECT_SELF, TRUE);
	         DestroyObject(OBJECT_SELF, 1800.0);
	         }
			 
			if(GetTag(OBJECT_SELF)== "003_cr_slv_deanvoice_sphinx")
	         {SetListenPattern(OBJECT_SELF, sFullName, 4999);
	         SetListenPattern(OBJECT_SELF, sFirstName, 5000);
	         SetListenPattern(OBJECT_SELF, sMiddleName, 5001);
	         SetListenPattern(OBJECT_SELF, sMiddleName2, 5002);
	         SetListenPattern(OBJECT_SELF, sLastName, 5003);
	         SetListenPattern(OBJECT_SELF, "**reschedule**", 5004);
	         SetListenPattern(OBJECT_SELF, "**submit**", 5005);
	         SetListenPattern(OBJECT_SELF, "**receive**", 5006);
	         SetListenPattern(OBJECT_SELF, "**enter**", 5007);
	         SetListenPattern(OBJECT_SELF, "**Arrowhawk**", 5008);
	         SetListenPattern(OBJECT_SELF, "**Brownie**", 5009);
	         SetListenPattern(OBJECT_SELF, "**Centaur**", 5010);
	         SetListenPattern(OBJECT_SELF, "**Dragon**", 5011);
	         SetListenPattern(OBJECT_SELF, "**Elemental**", 5012);
	         SetListenPattern(OBJECT_SELF, "**Fire Mephit**", 5013);
	         SetListenPattern(OBJECT_SELF, "**Golem**", 5014);
	         SetListenPattern(OBJECT_SELF, "**Harpy**", 5015);
	         SetListenPattern(OBJECT_SELF, "**Imp**", 5016);
	         SetListenPattern(OBJECT_SELF, "**Jann**", 5017);
	         SetListenPattern(OBJECT_SELF, "**Kobold**", 5018);
	         SetListenPattern(OBJECT_SELF, "**Lycanthrope**", 5019);
	         SetListenPattern(OBJECT_SELF, "**Minotaur**", 5020);
	         SetListenPattern(OBJECT_SELF, "**Nixie**", 5021);
	         SetListenPattern(OBJECT_SELF, "**Orc**", 5022);
	         SetListenPattern(OBJECT_SELF, "**Phoenix**", 5023);
	         SetListenPattern(OBJECT_SELF, "**Quasit**", 5024);
	         SetListenPattern(OBJECT_SELF, "**Ravid**", 5025);
	         SetListenPattern(OBJECT_SELF, "**Sphinx**", 5026);
	         SetListenPattern(OBJECT_SELF, "**Treant**", 5027);
	         SetListenPattern(OBJECT_SELF, "**Unicorn**", 5028);
	         SetListenPattern(OBJECT_SELF, "**Vargouille**", 5029);
	         SetListenPattern(OBJECT_SELF, "**Water Weird**", 5030);
	         SetListenPattern(OBJECT_SELF, "**Xorn**", 5031);
	         SetListenPattern(OBJECT_SELF, "**Yrthak**", 5032);
	         SetListenPattern(OBJECT_SELF, "**Zombie**", 5033);
	         SetListenPattern(OBJECT_SELF, "**Archival**", 5034);
	         SetListenPattern(OBJECT_SELF, "**Bindings**", 5035);
	         SetListenPattern(OBJECT_SELF, "**Concluded**", 5036);
	         SetListenPattern(OBJECT_SELF, "**Defines**", 5037);
	         SetListenPattern(OBJECT_SELF, "**Essences**", 5038);
	         SetListenPattern(OBJECT_SELF, "**Favoring**", 5039);
	         SetListenPattern(OBJECT_SELF, "**Grand**", 5040);
	         SetListenPattern(OBJECT_SELF, "**Harmonious**", 5041);
	         SetListenPattern(OBJECT_SELF, "**Insights**", 5042);
	         SetListenPattern(OBJECT_SELF, "**Joining**", 5043);
	         SetListenPattern(OBJECT_SELF, "**Keyed**", 5044);
	         SetListenPattern(OBJECT_SELF, "**Lives**", 5045);
	         SetListenPattern(OBJECT_SELF, "**Monstrous**", 5046);
	         SetListenPattern(OBJECT_SELF, "**Name**", 5047);
	         SetListenPattern(OBJECT_SELF, "**Opens**", 5048);
	         SetListenPattern(OBJECT_SELF, "**Pyramid**", 5049);
	         SetListenPattern(OBJECT_SELF, "**Quest**", 5050);
	         SetListenPattern(OBJECT_SELF, "**Reveals**", 5051);
	         SetListenPattern(OBJECT_SELF, "**Sphinx**", 5052);
	         SetListenPattern(OBJECT_SELF, "**Tomb**", 5053);
	         SetListenPattern(OBJECT_SELF, "**Undergrads**", 5054);
	         SetListenPattern(OBJECT_SELF, "**Venture**", 5055);
	         SetListenPattern(OBJECT_SELF, "**Wildly**", 5056);
	         SetListenPattern(OBJECT_SELF, "**Xavier's**", 5057);
	         SetListenPattern(OBJECT_SELF, "**Yard**", 5058);
	         SetListenPattern(OBJECT_SELF, "**Zoological**", 5059);
	         SetListenPattern(OBJECT_SELF, "**archival binding concluded defines essences for grand harmonious insights joyfully knowing life monstrous name opens pyramid quest reveals sphinx tomb undergrads venture wildly nix yard zoological**", 5060);
	         SetListenPattern(OBJECT_SELF, "**Archival Binding Concluded Defines Essences For Grand Harmonious Insights Joyfully Knowing Life Monstrous Name Opens Pyramid Quest Reveals Sphinx Tomb Undergrads Venture Wildly Nix Yard Zoological**", 5061);
	         SetListenPattern(OBJECT_SELF, "**Flit**", 5062);
	         SetListenPattern(OBJECT_SELF, sDeity, 5063);
	         SetListenPattern(OBJECT_SELF, "**Auril**", 5064);
	         SetListenPattern(OBJECT_SELF, "**Mystra**", 5065);
	         SetListenPattern(OBJECT_SELF, "**Feather Fall**", 5066);
	         SetListenPattern(OBJECT_SELF, "**feather fall**", 5067);
	         SetListenPattern(OBJECT_SELF, "**Feather fall**", 5068);
			 SetListenPattern(OBJECT_SELF, "**recieve**", 5069);
	         SetListenPattern(OBJECT_SELF, "**Yes**", 5998);
	         SetListenPattern(OBJECT_SELF, "**No**", 5999);
	         SetListenPattern(OBJECT_SELF, "**", 6000);
	         SetListening(OBJECT_SELF, TRUE);
	         DestroyObject(OBJECT_SELF, 1800.0);
	         }
		 }
		 
		if((GetTag(OBJECT_SELF)== "003_cr_slv_deandragon_golem") || (GetTag(OBJECT_SELF)== "003_slv_dq_g_creature"))
        	{int iInc = GetLocalInt(OBJECT_SELF, "iInc");
			 if(iInc == 0)
			 	{iInc = 1;}
			 else
			 	{iInc ++;}
			if(iInc < 12)
				{SetLocalInt(OBJECT_SELF, "iInc", iInc);
				 iInc = GetLocalInt(OBJECT_SELF, "iInc");
				 object oWaypoint = GetWaypointByTag("WP_003_cr_slv_deandragon_golem_" + IntToString(iInc));
				 ClearAllActions(TRUE);
				 if(iInc > 9)
				 	{ActionJumpToLocation(GetLocation(oWaypoint));} 
				 else
				 	{ActionForceMoveToObject(oWaypoint, TRUE, 0.5);}
			  	  
				if(iInc==1)
					{DelayCommand(3.0, ExecuteScript("slv_static_voicespawn", OBJECT_SELF));}
				else 
					{DelayCommand(10.0, ExecuteScript("slv_static_voicespawn", OBJECT_SELF));}
				 }
			 }
         
		 if(GetTag(OBJECT_SELF)== "003_cr_slv_chest_walk") 
        	{int iInc = GetLocalInt(OBJECT_SELF, "iInc");
			 if(iInc == 0)
			 	{iInc = 1;}
			 else
			 	{iInc ++;}
			if(iInc < 23)
				{SetLocalInt(OBJECT_SELF, "iInc", iInc);
				 iInc = GetLocalInt(OBJECT_SELF, "iInc");
				 object oWaypoint = GetWaypointByTag("WP_003_cr_slv_chest_" + IntToString(iInc));
				 ClearAllActions(TRUE);
				 if(((iInc >= 11) && (iInc <= 13)) || ((iInc >= 15) && (iInc <= 17)))
				 	{ActionJumpToLocation(GetLocation(oWaypoint));} 
				 else
				 	{ActionForceMoveToObject(oWaypoint, TRUE, 0.5);}
			  	  
				DelayCommand(5.0, ExecuteScript("slv_static_voicespawn", OBJECT_SELF));
				 }
			 }
        }