//OnSpellCastAt for all Silvy Uni placeables
//Wynna February 2008


#include "acr_placeable_i"
#include "acr_db_persist_i"
#include "acr_tools_i"
#include "acr_quest_i"

void main()
{
	ACR_PlaceableOnSpellCastAt();
    object oStudent = GetLastSpellCaster();
    object oArea = GetArea(OBJECT_SELF);
	effect eCutDamage = EffectDamage(1, DAMAGE_TYPE_SLASHING, DAMAGE_POWER_NORMAL);
    effect eSplatDamage = EffectDamage(2, DAMAGE_TYPE_FIRE, DAMAGE_POWER_NORMAL);
    effect eColderDamage = EffectDamage(Random(6), DAMAGE_TYPE_COLD, DAMAGE_POWER_NORMAL);
    effect ePoison = EffectDamage(1, DAMAGE_TYPE_ACID, DAMAGE_POWER_NORMAL);
    effect eGas = EffectVisualEffect(VFX_COM_CHUNK_GREEN_SMALL);
    
	
	
	//Standard Conjuration
	 if((GetTag(OBJECT_SELF) == "slv_con200_lever") && (GetLastSpell() == 66 ))
	 	{if(GetLocalInt(oStudent, "Greased") != 1)
			{SendMessageToPC(oStudent, "The area is slippery and dripping with grease.");
			 SetLocalInt(oStudent, "Greased", 1);
			 DelayCommand(60.0, SetLocalInt(oStudent, "Greased", 0));
			  }
		}
	
	//Elementary Divination
	
	 if((GetTag(OBJECT_SELF) == "slv_div100_sigil") &&  (GetIsPC(oStudent)) && (GetLastSpell() == SPELL_IDENTIFY))
       {
	   SetCampaignString("SLV_UNI", "Elementary Divination", "Elementary Divination", oStudent);
       object PCScroll = CreateItemOnObject("slv_div100_scroll_id", oStudent, 1);
       DelayCommand( 2.0, SendMessageToPC(oStudent, "Suddenly, without seeing it arrive, you are holding a scroll in your hand."));
      if(ACR_RetrieveQuestState("slv_div100", oStudent) == 1)
		{DelayCommand(15.0, ACR_AddPersistentJournalQuestEntry("slv_div100", 2, oStudent, 0, 0, 0, 0));
		}
		}
	  //Elementary Evocation

     if((GetTag(OBJECT_SELF) == "slv_evo100_crystalball") &&  (GetIsPC(oStudent)) && (GetLastSpell() == SPELL_SHOCKING_GRASP))
       {object oMech = GetLocalObject(OBJECT_SELF, "oMech");
	   	if(oMech == OBJECT_INVALID)
			{oMech = GetObjectByTag("slv_evo100_mech");
			 SetLocalObject(OBJECT_SELF, "oMech", oMech);
			 }
	    object oCrystal1 = GetLocalObject(OBJECT_SELF, "oCrystal1");
	   	if(oCrystal1 == OBJECT_INVALID)
			{oCrystal1 = GetObjectByTag("slv_evo100_crystal1");
			 SetLocalObject(OBJECT_SELF, "oCrystal1", oCrystal1);
			 }
	    object oCrystal2 = GetLocalObject(OBJECT_SELF, "oCrystal2");
	   	if(oCrystal2 == OBJECT_INVALID)
			{oCrystal2 = GetObjectByTag("slv_evo100_crystal2");
			 SetLocalObject(OBJECT_SELF, "oCrystal2", oCrystal2);
			 }
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_GLOW_WHITE, FALSE), OBJECT_SELF, 600.0);
        if((GetIsObjectValid(oMech)) && (GetIsObjectValid(oCrystal1)) && (GetIsObjectValid(oCrystal2)))
           {DelayCommand( 2.0, AssignCommand(oMech, PlaySound("as_cv_boilergrn1")));
            DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectBeam(VFX_BEAM_LIGHTNING, OBJECT_SELF, BODY_NODE_CHEST, FALSE), oCrystal1, 10.0));
            DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectBeam(VFX_BEAM_LIGHTNING, OBJECT_SELF, BODY_NODE_CHEST, FALSE), oCrystal2, 10.0));
            AssignCommand(oCrystal1, DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectBeam(VFX_BEAM_LIGHTNING, OBJECT_SELF, BODY_NODE_CHEST, FALSE), oCrystal2, 10.0)));
            DelayCommand( 11.0, AssignCommand(oMech, PlaySound("pipeflushes")));
            DelayCommand( 12.0, SendMessageToPC(oStudent, "The contraption clanks to life!  A pump gurgles.  Steaming liquid cascades from the mouth of a tube into a cup. When the groaning machine stills, a fragrant cup of what smells like chai awaits you."));
            SetCampaignString("SLV_UNI", "Elementary Evocation", "Elementary Evocation", oStudent);
            CreateItemOnObject("slv_evo100_chai", oMech, 1);
            if(ACR_RetrieveQuestState("slv_evo100", oStudent) == 1)
				{DelayCommand(15.0, ACR_AddPersistentJournalQuestEntry("slv_evo100", 2, oStudent, 0, 0, 0, 0));
				}
			}
            else
            {DelayCommand( 2.0, SendMessageToPC(oStudent, "The crystal ball lights and an electric hum fills the room...but dies away, powerless."));
            }
        }

        if((GetTag(OBJECT_SELF) == "slv_evo100_crystal") &&  (GetIsPC(oStudent)) && ((GetLastSpell() == SPELL_MAGIC_MISSILE) || (GetLastSpell() == SPELL_HORIZIKAULS_BOOM) || (GetLastSpell() == SPELL_RAY_OF_FROST)))
         {DelayCommand( 1.0, PlaySound("as_cv_glasbreak2"));
          DelayCommand( 1.5, SendMessageToPC(oStudent, "The crystal ball vaporises in a cloud of glass dust and shards."));
          if(ReflexSave(oStudent, 10, SAVING_THROW_TYPE_NONE, OBJECT_SELF) == 1)
             {DelayCommand(2.0, SendMessageToPC(oStudent, "Luckily, you were far enough away to avoid flying glass."));}
             else
             {DelayCommand(2.0, SendMessageToPC(oStudent, "You are cut by flying glass!"));
              DelayCommand(2.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eCutDamage, oStudent));
              }
           DelayCommand( 3.5, SendMessageToPC(oStudent, "You have destroyed one of the objects in the room.  No doubt all of them were meant to serve a purpose in the test."));
           DelayCommand( 4.0, DestroyObject(OBJECT_SELF));
           }
           {}

        if((GetTag(OBJECT_SELF) == "slv_evo100_crystal") &&  (GetIsPC(oStudent)) && (GetLastSpell() != SPELL_MAGIC_MISSILE) && (GetLastSpell() != SPELL_HORIZIKAULS_BOOM) && (GetLastSpell() != SPELL_ELECTRIC_JOLT) && (GetLastSpell() != SPELL_RAY_OF_FROST))
          {DelayCommand(2.0, SendMessageToPC(oStudent, "Nothing happens.  The crystal orb remains dim."));}
           {}

        if((GetTag(OBJECT_SELF) == "slv_evo100_mech") &&  (GetLastSpell() == SPELL_ELECTRIC_JOLT))
            {DelayCommand( 2.0, SendMessageToPC(oStudent, "The metal crackles with blue sparks...but the charge drains away, undirected."));
            }


    //Standard Evocation

      if(GetTag(OBJECT_SELF) == "slv_evo200_bellows2") 
		   {object oWindowWP = GetLocalObject(OBJECT_SELF, "oWindowWP");
		    if(oWindowWP == OBJECT_INVALID)
			   {oWindowWP = GetWaypointByTag("Evo_All_Quests_Window_WP");
				SetLocalObject(OBJECT_SELF, "oWindowWP", oWindowWP);
				}
		    object oMyWindow = GetLocalObject(OBJECT_SELF, "oMyWindow");
		    if(oMyWindow == OBJECT_INVALID)
			   {oMyWindow = GetObjectByTag("slv_evo200_window");
				SetLocalObject(OBJECT_SELF, "oMyWindow", oMyWindow);
				}
		    object oMyIncinder = GetLocalObject(OBJECT_SELF, "oMyIncinder");
		    if (oMyIncinder == OBJECT_INVALID)
				{oMyIncinder = GetObjectByTag("003_cr_slv_incinder");
				 SetLocalObject(OBJECT_SELF, "oMyIncinder", oMyIncinder);
				}
			object oMyPoisonCircle = GetLocalObject(OBJECT_SELF, "oMyPoisonCircle");
			if(oMyPoisonCircle == OBJECT_INVALID)
			   	{oMyPoisonCircle = GetObjectByTag("slv_evo200_poisoncircle");
				 SetLocalObject(OBJECT_SELF, "oMyPoisonCircle", oMyPoisonCircle);
				}
			object oMyCurtainPull = GetLocalObject(OBJECT_SELF, "oMyCurtainPull");
			 if (oMyCurtainPull == OBJECT_INVALID)
				{oMyCurtainPull = GetObjectByTag("slv_evo200_curtainpull");
				SetLocalObject(OBJECT_SELF, "oMyCurtainPull", oMyCurtainPull);
				 }
			 if((GetLastSpell() == SPELL_LESSER_ORB_OF_ELECTRICITY) || (GetLastSpell() == SPELL_GEDLEES_ELECTRIC_LOOP) || (GetLastSpell() == SPELL_CALL_LIGHTNING) || (GetLastSpell() == SPELL_LIGHTNING_BOLT))
		          {SetLocalInt(oStudent, "slv_evo200_Emulsion", 1);
		           SendMessageToPC(oStudent, "A crackling in the air rapidly becomes a storm of lightning, caught up by the magical conductor and zipping through the wires to the wall behind the window. The entire wall glows electric blue.");
		           DelayCommand(1.0, SendMessageToPC(oStudent, "The panes of glass in the Kossuthian window shatter, spraying shards and oily liquid across the area!"));
		           object oMyEmulsion = CreateObject(OBJECT_TYPE_PLACEABLE, "slv_enc200_emulsion", GetLocation(oWindowWP));
				   SetLocalObject(oMyCurtainPull, "oMyEmulsion", oMyEmulsion);
				   ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_COM_CHUNK_YELLOW_SMALL), GetLocation(oWindowWP), 2.0);
		           DelayCommand(0.5, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_IMP_DUST_EXPLOSION),  GetLocation(oWindowWP), 5.0));
		           DelayCommand(1.0, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_NATURE),  GetLocation(oWindowWP), 5.0));
		           DelayCommand(1.5, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_NATURE),  GetLocation(oWindowWP), 5.0));
		           DelayCommand(2.0, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_NATURE),  GetLocation(oWindowWP), 5.0));
		           DelayCommand(2.5, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_NATURE),  GetLocation(oWindowWP), 5.0));
		           DelayCommand(3.0, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_NATURE),  GetLocation(oWindowWP), 5.0));
		           DelayCommand(3.5, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_NATURE),  GetLocation(oWindowWP), 5.0));
		           DelayCommand(3.8, SendMessageToPC(oStudent, "A mottled sheet of blank parchment is revealed, now coated with oily liquid that glistens in the red light of the room."));
		           if(GetDistanceBetween(oMyPoisonCircle, oStudent) < 0.75)
		                {DelayCommand(2.0, SendMessageToPC(oStudent, "Luckily you stand near a symbol of Talona, and a cloud of poisonous vapor seems to pass you by harmlessly."));
		                 DelayCommand(2.1, AssignCommand(oMyIncinder, SpeakString("Not sssso sssstupid.  Readssss poissssson protectionsssss well.", TALKVOLUME_TALK)));
		             	}
		             else {DelayCommand(2.0, SendMessageToPC(oStudent, "A cloud of vapor swirls through the entire room, parting around the symbol of protection on the floor but clinging to exposed face and skin.  It burns!"));
		                   ApplyEffectToObject(DURATION_TYPE_INSTANT, ePoison, oStudent);
		                   DelayCommand(2.1, AssignCommand(oMyIncinder, SpeakString("Ssssssss!   *hiss of laughter*  Readssss poissssson protectionsss better next time!", TALKVOLUME_TALK)));
		            		}
		           DelayCommand(4.8, AssignCommand(oMyIncinder, SpeakString("Ssssurvivessss firsssst ssstep.  *Mutters, seemingly disappointed*  Issss only firssssst.  What doessss meat do next?", TALKVOLUME_TALK)));
				   SetUseableFlag(oMyPoisonCircle, TRUE);		         
				  }
				  
				  
	      else if ((GetLastSpell() == SPELL_MAGIC_MISSILE)  || (GetLastSpell() == SPELL_ACID_SPLASH)|| (GetLastSpell() == SPELL_BALAGARNSIRONHORN)||  (GetLastSpell() == SPELL_FIREBALL)|| (GetLastSpell() == SPELL_FIREBURST)|| (GetLastSpell() == SPELL_MELFS_ACID_ARROW)|| (GetLastSpell() == SPELL_SOUND_BURST)|| (GetLastSpell() == SPELL_LESSER_ORB_OF_ACID)|| (GetLastSpell() == SPELL_LESSER_ORB_OF_SOUND))
	         {SetLocalInt(oStudent, "slv_evo200_Emulsion", 2);
	           object oEmulsion = CreateObject(OBJECT_TYPE_PLACEABLE, "slv_enc200_emulsion", GetLocation(oWindowWP));
			   SendMessageToPC(oStudent, "The wires seem to catch and multiply the spell's power, hurling it along the cables at the wall. The fragile sheet of glass bubbles fractures unevenly.  The windows drop to the floor before shattering, spraying shards and oily liquid across the room.");
	           ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_COM_CHUNK_YELLOW_SMALL), GetLocation(GetObjectByTag("slv_evo200_man", 0)), 2.0);
	           DelayCommand(0.5, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_IMP_DUST_EXPLOSION), GetLocation(GetObjectByTag("slv_evo200_wom", 0)), 5.0));
	           DelayCommand(1.0, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_NATURE), GetLocation(GetObjectByTag("slv_evo200_man", 0)), 5.0));
	           DelayCommand(1.0, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_NATURE), GetLocation(GetObjectByTag("slv_evo200_wom", 0)), 5.0));
	           if(GetDistanceBetween(oMyPoisonCircle, oStudent) < 0.75)
	                {DelayCommand(2.0, SendMessageToPC(oStudent, "Luckily you stand on the symbol of protection, and a cloud of poisonous vapor seems to pass you by harmlessly."));
	                }
	             else {DelayCommand(2.0, SendMessageToPC(oStudent, "A cloud of poisonous vapor swirls through the entire room, parting around the symbol of Talona but clinging to exposed face and skin.  It burns!"));
	                   ApplyEffectToObject(DURATION_TYPE_INSTANT, ePoison, oStudent);
	                  }
	           DelayCommand(3.8, AssignCommand(oMyIncinder, SpeakString("Ssstupid!  Breakssss wrong! Can't be sssound attack! Breaksss glasss too early. Can't be acid or fire or force attack! Powersss from such spells weakens glasss so it breaks unevenly!", TALKVOLUME_TALK)));
	           DelayCommand(3.8, SendMessageToPC(oStudent, "A mottled sheet of blank parchment is revealed, spotted unevenly with oily liquid from inside the broken windows of glass bubbles."));
	           DestroyObject(oMyWindow, 4.0);
			   }
			 else
			 {SendMessageToPC(oStudent, "Nothing happens. The coils begin to glow, but fade again.");}
          
		}

     if(GetTag(OBJECT_SELF) == "slv_evo200_poisoncircle")
         {if((GetLastSpell() == SPELL_LIGHT)|| (GetLastSpell() == SPELL_FLARE)) 
		 	{object oWindowWP = GetLocalObject(OBJECT_SELF, "oWindowWP");
		    if(oWindowWP == OBJECT_INVALID)
			   {oWindowWP = GetWaypointByTag("Evo_All_Quests_Window_WP");
				SetLocalObject(OBJECT_SELF, "oWindowWP", oWindowWP);
				}
		    object oPictureWP = GetLocalObject(OBJECT_SELF, "oPictureWP");
		    if(oPictureWP == OBJECT_INVALID)
			   {oPictureWP = GetWaypointByTag("Evo_All_Quests_Picture_WP");
				SetLocalObject(OBJECT_SELF, "oPictureWP", oPictureWP);
				}
		    object oMyIncinder = GetLocalObject(OBJECT_SELF, "oMyIncinder");
		    if (oMyIncinder == OBJECT_INVALID)
				{oMyIncinder = GetObjectByTag("003_cr_slv_incinder");
				 SetLocalObject(OBJECT_SELF, "oMyIncinder", oMyIncinder);
				}
			object oMirror1 = GetLocalObject(OBJECT_SELF, "oMirror1");
		   if(oMirror1 == OBJECT_INVALID)
		   		{oMirror1 = GetObjectByTag("slv_evo200_mirror1");
				 SetLocalObject(OBJECT_SELF, "oMirror1", oMirror1);
				 }
		   object oMirror2 = GetLocalObject(OBJECT_SELF, "oMirror2");
		   if(oMirror2 == OBJECT_INVALID)
		   		{oMirror2 = GetWaypointByTag("slv_evo200_mirror2");
				 SetLocalObject(OBJECT_SELF, "oMirror2", oMirror2);
				 }
		 	string sGender = "slv_evo200_man";
		   string sGenderPLC = "slv_evo200_plc_man";
		   if(GetGender(oStudent) != GENDER_MALE)
				{sGender = "slv_evo200_woman";
				 sGenderPLC = "slv_evo200_plc_woman";
				 }
		  SendMessageToPC(oStudent, "The metal inlaid symbol of protection beneath your feet reflects with a brilliant flash.");
          DelayCommand(2.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_FNF_ELECTRIC_EXPLOSION), oStudent, 3.0));
          DelayCommand(2.5, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_FNF_ELECTRIC_EXPLOSION), oMirror1, 3.0));
          DelayCommand(2.5, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_FNF_ELECTRIC_EXPLOSION), oMirror2, 3.0));
          DelayCommand(2.8, AssignCommand(oMyIncinder, SpeakString("*Screeches in happiness*  Lovesss thissssss part!", TALKVOLUME_TALK)));
          DelayCommand(2.9, AssignCommand(oMirror1, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectBeam(VFX_BEAM_LIGHTNING, OBJECT_SELF, BODY_NODE_CHEST, FALSE), oWindowWP, 5.0)));
          DelayCommand(2.9, AssignCommand(oMirror2, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectBeam(VFX_BEAM_COLD, OBJECT_SELF, BODY_NODE_CHEST, FALSE), oWindowWP, 5.0)));
          DelayCommand(3.0, SendMessageToPC(oStudent, "The light is taken up by the mirrors and amplified, and magnified beams leap from the mirrors to the oily parchment before you."));
          DelayCommand(5.0, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_FNF_DISPEL_GREATER), GetLocation(oWindowWP), 5.0));
          DelayCommand(6.0, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD), GetLocation(oWindowWP), 5.0));
          object oPLC = CreateObject(OBJECT_TYPE_PLACEABLE, sGenderPLC, GetLocation(oPictureWP), FALSE);
	            object oImage = CreateObject(OBJECT_TYPE_ITEM, sGender, GetLocation(OBJECT_SELF), FALSE);
	            SetDescription(oImage, "An image of " + GetName(oStudent) + " against a background of flames.");
				DelayCommand(2.0, AssignCommand(oMyIncinder, ActionCastSpellAtObject(SPELL_DISPEL_MAGIC, OBJECT_SELF, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE )));
	            DelayCommand(5.0, ActionCastSpellAtObject(SPELL_DISPEL_MAGIC, OBJECT_SELF, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE ));
	            DelayCommand(9.0, SendMessageToPC(oStudent, "When the dazzle clears from your sight and the smoke from the room, you are left looking at an image in black and white where the Kossuthian window had been....of your own face, startled by the flash."));
	            DelayCommand(10.0, SetCampaignString("SLV_UNI","Standard Evocation", "Standard Evocation", oStudent));
	            if(ACR_RetrieveQuestState("slv_evo200", oStudent) == 1)
					{DelayCommand(10.1, ACR_AddPersistentJournalQuestEntry("slv_evo200", 2, oStudent, 0, 0, 0, 0));
					}
			    DelayCommand(10.5, SetLocalInt(oStudent, "slv_evo200_", 1)); 
	            DelayCommand(11.0, AssignCommand(oMyIncinder, SpeakString("Sssssurprise. Good expossssure. Take pieccccce of sssshadow to Massssster.  *Points to center of protection circle which holds  a smaller image like a lesser copy of the larger on the window.*", TALKVOLUME_TALK)));
	            DestroyObject(oMyIncinder, 16.0);
	            DestroyObject(oPLC, 30.0);
	           if(GetDistanceBetween(oStudent, GetObjectByTag("slv_evo200_poisoncircle", 0)) < 15.0)
	                { DelayCommand(30.0, SendMessageToPC(oStudent, "The large image fades.  Only wet parchment speckled with glass remains on the wall."));
	                }
	           SetUseableFlag(OBJECT_SELF, FALSE);
          		}      
	     	}	
			
	
        	
		 
	//Standard Illusion
    if((GetTag(OBJECT_SELF) == "slv_ill200_mirrorblack") || (GetTag(OBJECT_SELF) == "slv_ill200_mirrorwhite"))  
        {string sClue = "Really old yellow gold brings intentions violent.";
		 if (GetTag(OBJECT_SELF) == "slv_ill200_mirrorblack")
		 	{sClue = "Rabid ogre, yipping goblin, biting inside victims.";
			}
		 object oBoyLeave2WP = GetLocalObject(OBJECT_SELF, "oBoyLeave2WP");
				if (oBoyLeave2WP == OBJECT_INVALID)
					{oBoyLeave2WP = GetWaypointByTag("Ill_All_Quests_BoyLeave2_WP");
					SetLocalObject(OBJECT_SELF, "oBoyLeave2WP", oBoyLeave2WP);
					}
		 object oBoy = GetLocalObject(OBJECT_SELF, "oBoy");
         if(oBoy == OBJECT_INVALID)
					{oBoy = GetObjectByTag("003_cr_slv_ill100boy");
					 if(oBoy == OBJECT_INVALID)
						{oBoy = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_slv_ill100boy", GetLocation(oBoyLeave2WP));
						}
					 }
		 SetLocalObject(OBJECT_SELF, "oBoy", oBoy);
								
		 if(WillSave(oStudent, 18, SAVING_THROW_TYPE_MIND_SPELLS, oStudent))
                  {DelayCommand(1.0, SendMessageToPC(oStudent, "The spell that springs from your hands goes right through the mirror."));
                   DelayCommand(2.0, AssignCommand(oBoy, SpeakString("*Giggle* Mirror, mirror on the floor, lucky you walks out the door...unless you wish to try some more?", TALKVOLUME_TALK)));
                  }
				 else
                  {DelayCommand(1.0, SendMessageToPC(oStudent, "The spell that sprays from your hands reflect off the mirror and springs back at YOU as a blast of colored lights, a moment before the mirror itself vanishes!  You hear a giggle and applause as you are sprayed with dazzling lights."));
                   DelayCommand(2.0, ActionCastSpellAtObject(SPELL_COLOR_SPRAY, oStudent, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
                   }

          if(WillSave(oStudent, 18, SAVING_THROW_TYPE_MIND_SPELLS, OBJECT_SELF))
                {DelayCommand(4.0, SendMessageToPC(oStudent, "The figure of a small humanoid seems to shimmer into view from a state of invisibility.  It darts into the mirrored maze and is gone."));
                 AssignCommand(oBoy, ActionJumpToObject(oStudent, TRUE));
				 AssignCommand(oBoy, ActionForceMoveToObject(oBoyLeave2WP, TRUE, 0.0));
				 }
                else
                {DelayCommand(4.0, SendMessageToPC(oStudent, "A small invisible force hurtles into you and careens off, and then is gone."));
                }
		  DestroyObject(oBoy, 6.0);
		  DelayCommand(2.0, SpeakString(sClue, TALKVOLUME_TALK));
          DestroyObject(OBJECT_SELF, 6.6);
         }
      


     if(GetTag(OBJECT_SELF) == "slv_ill200_mirrorprism") 
	 	{object oBoyLeave2WP = GetLocalObject(OBJECT_SELF, "oBoyLeave2WP");
		 if (oBoyLeave2WP == OBJECT_INVALID)
					{oBoyLeave2WP = GetWaypointByTag("Ill_All_Quests_BoyLeave2_WP");
					SetLocalObject(OBJECT_SELF, "oBoyLeave2WP", oBoyLeave2WP);
					}
		 object oBoy = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_slv_ill100boy", GetLocation(oBoyLeave2WP));
		 DestroyObject(oBoy, 10.0);			
		 object oBear = GetObjectByTag("003_cr_slv_ill100cub");	
		 DestroyObject(oBear, 10.0);		 
		 if(GetLastSpell() == SPELL_COLOR_SPRAY)
           {SetCampaignString("SLV_UNI", "Standard Illusion", "Standard Illusion", oStudent);
            ACR_AddPersistentJournalQuestEntry("slv_ill200", 2, oStudent, 0, 0, 0, 0);
			DelayCommand(1.0, SendMessageToPC(oStudent, "The lights that spring from your hands seem to catch in the mirror and swirl into a coloured halo around your reflection.  After a small pause, as if from a far distance or as if learning how to, your reflection...speaks."));
            DelayCommand(5.0, SpeakString("You who stand there looking in, old or young or fat or thin, in real glass may give a grin, for this class may count a win!", TALKVOLUME_TALK));
            CreateItemOnObject("slv_ill200_rod", oStudent, 1);
			if(WillSave(oStudent, 18, SAVING_THROW_TYPE_MIND_SPELLS, OBJECT_SELF))
                {DelayCommand(7.0, SendMessageToPC(oStudent, "With the words, your reflection shimmers away and a small humanoid seems to melt into view from a state of invisibility.  For an instant you see young Jack Preston, who shoves a small item into your hand, then ducks behind the mirror and is gone."));
                }
                else
                {DelayCommand(7.0, SendMessageToPC(oStudent, "Your reflection steps out of the mirror and past you with a bow and into one of the mirrored walls, walking into an angle within the reflection there and vanishing.  At the same time, a small invisible force hurtles into you as if from behind the mirror, thrusts an item into your hand, careens off, and then is gone."));
                 }
            }
		 else if (GetLastSpell() != SPELL_COLOR_SPRAY)
			{DelayCommand(2.0, SpeakString("Recognizing obvious yields gets best Illusion victory.", TALKVOLUME_TALK));
          	}
           } 
		   
 
    //Elementary Necromancy

     if((GetTag(OBJECT_SELF) == "slv_nec100_corpse")  && ((GetLastSpell() == SPELL_TOUCH_OF_FATIGUE) || (GetLastSpell() == SPELL_GHOUL_TOUCH)) && (GetLocalInt(oStudent, "Wash") == 1) && (GetLocalInt(oStudent, "Embalm") == 1))
       {SendMessageToPC(oStudent, "Slowly, the clenched fingers of the corpse open to lie flat.  A chill steals across your skin.  An invisible gong booms, echoing through the room.");
        DelayCommand( 3.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_IMP_PULSE_NEGATIVE, FALSE), OBJECT_SELF));
        DelayCommand( 4.0, PlaySound("as_cv_gongring3"));
        DelayCommand( 5.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_IMP_PULSE_NEGATIVE, FALSE), OBJECT_SELF));
        SetCampaignString("SLV_UNI", "Elementary Necromancy", "Elementary Necromancy", oStudent);
        if(ACR_RetrieveQuestState("slv_nec100", oStudent) == 1)
				{DelayCommand(10.0, ACR_AddPersistentJournalQuestEntry("slv_nec100", 2, oStudent, 0, 0, 0, 0));
				}
		DelayCommand(7.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_GLOW_RED, FALSE), OBJECT_SELF, 1.0));
        DelayCommand(7.5, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_BEAM_ODD, FALSE), OBJECT_SELF, 10.0));
        DelayCommand(8.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_GHOSTLY_PULSE, FALSE), OBJECT_SELF, 6.0));
        DelayCommand(9.0, PlaySound("as_na_steamlong2"));
        DelayCommand(9.5, SendMessageToPC(oStudent, "A sigh pushes out from the corpse's lips.  The hiss sounds eerily like....'Classsss...dis...miss...ed...."));
        }
       {}

    if((GetTag(OBJECT_SELF) == "slv_nec100_corpse") &&  (GetIsPC(oStudent)) && (GetLastSpell() != SPELL_TOUCH_OF_FATIGUE)&& (GetLastSpell() != SPELL_GHOUL_TOUCH))
       {DelayCommand(2.0, SendMessageToPC(oStudent, "Nothing happens.  The body just lies there."));
	   }
       
        //Standard Transmutation

        if(GetTag(OBJECT_SELF) == "slv_tra200_forge")
         {SetLocalObject(OBJECT_SELF, "oStudent", oStudent);
		  object oMyTrigAll = GetLocalObject(OBJECT_SELF, "oMyTrigAll");
		  if(oMyTrigAll == OBJECT_INVALID)
		  	{oMyTrigAll = GetNearestObjectByTag("slv_22.00", OBJECT_SELF);
			 SetLocalObject(OBJECT_SELF, "oMyTrigAll", oMyTrigAll);
			 }
		  object oMyFlameWP = GetLocalObject(OBJECT_SELF, "oMyFlameWP");
		  if (oMyFlameWP == OBJECT_INVALID)
			 {oMyFlameWP = GetWaypointByTag("Tra_All_Quests_Fire3_WP");
			  SetLocalObject(OBJECT_SELF, "oMyFlameWP", oMyFlameWP);
			 }
		  object oMySteelWP = GetLocalObject(OBJECT_SELF, "oMySteelWP");
		  if (oMySteelWP == OBJECT_INVALID)
			 {oMySteelWP = GetWaypointByTag("Tra_All_Quests_Steel_WP");
			  SetLocalObject(OBJECT_SELF, "oMySteelWP", oMySteelWP);
			 }
		  object oMyTrough = GetLocalObject(OBJECT_SELF, "oMyTrough");
		  if (oMyTrough == OBJECT_INVALID)
			 {oMyTrough = GetObjectByTag("slv_tra200_trough");
			  SetLocalObject(OBJECT_SELF, "oMyTrough", oMyTrough);
			}
		  object oMySteamWP = GetLocalObject(OBJECT_SELF, "oMySteamWP");
		  if (oMySteamWP == OBJECT_INVALID)
			 {oMySteamWP = GetWaypointByTag("Tra_All_Quests_Steam2_WP");
			  SetLocalObject(OBJECT_SELF, "oMySteamWP", oMySteamWP);
			 }
		  effect eSplatDamage = EffectDamage(Random(5), DAMAGE_TYPE_FIRE, DAMAGE_POWER_NORMAL);
		  object oMyFlame = CreateObject(OBJECT_TYPE_PLACEABLE, "slv_fire", GetLocation(oMyFlameWP));
		  SetLocalObject(oMyTrigAll, "oMyFlame", oMyFlame);
		  SetLocalObject(OBJECT_SELF, "oMyFlame", oMyFlame);
		  SendMessageToPC(oStudent, "The forge roars to life.");
		  DelayCommand( 1.0, AssignCommand(oMyFlame, PlaySound("furnace")));
          if(GetFirstItemInInventory(OBJECT_SELF) != OBJECT_INVALID)
            {int nCount = 0;
			 int nAlloy = 0;
			 int nDagger = 0;
			 int nOther = 0;
		     object oOre = GetFirstItemInInventory(OBJECT_SELF);
		     while (GetIsObjectValid(oOre))
		
		           {if(GetTag(oOre) == "slv_tra200_iron")
			            {nCount = nCount +1;
			             DestroyObject(oOre);
						 oOre = GetNextItemInInventory(OBJECT_SELF);
			             DelayCommand(IntToFloat(nCount * 3), SendMessageToPC(oStudent, "The number " + IntToString(nCount) +" chunk of iron ore melts away."));
			             }
			        else if(GetTag(oOre) == "slv_tra200_alloy")
				         {nAlloy = nAlloy +1;
				          DestroyObject(oOre);
						  oOre = GetNextItemInInventory(OBJECT_SELF);
				          DelayCommand(IntToFloat(nAlloy * 3), SendMessageToPC(oStudent, "Alloy melts, adding its properties to the molten liquid."));
				          }
					else if(GetTag(oOre) == "slv_tra200_rustydagger")
			            {nDagger = nDagger +1;
				         DelayCommand(IntToFloat(nAlloy * 3), SendMessageToPC(oStudent, "Corrosion burns off the rusty dagger, revealing silver below, until it melts into the molten liquid."));
				         DestroyObject(oOre);
						 oOre = GetNextItemInInventory(OBJECT_SELF);
			             }
					else 
			            {nOther = nOther +1;
			             DestroyObject(oOre);
						 oOre = GetNextItemInInventory(OBJECT_SELF);
			             DelayCommand(IntToFloat(nOther * 7), SendMessageToPC(oStudent, "An unspecified material adds an impurity to the mix!"));
			             } 
				     }
		       
				DelayCommand(15.0, SendMessageToPC(oStudent, "A sluice opens up on the side of the forge and molten metal pours out into the shaping trough."));
			    DestroyInventory(OBJECT_SELF);
			    DelayCommand(15.0, AssignCommand(oMyTrough, PlaySound("steamlarge")));
			    DelayCommand(16.0, ExecuteScript("slv_plc_execute", OBJECT_SELF));
			      
			     DelayCommand(18.0, SendMessageToPC(oStudent, "When the shaping trough is full, the forge sluice closes and the molten steel settles, forming a skin as it starts to harden into a large ingot."));
			     DelayCommand(20.5, AssignCommand(oMyTrough, PlaySound("waterpump")));
			     DelayCommand(21.0, SendMessageToPC(oStudent, "Cooling water pours into the shaping trough."));
			     DelayCommand(30.0, DestroyObject(oMyFlame));
			             
				 if((nCount == 3) && (nAlloy == 1)&& (nDagger == 1) && (nOther == 0))
						{DelayCommand(25.0, SetLocalInt(OBJECT_SELF, "Steel", 1));
						 DelayCommand(30.0, ExecuteScript("slv_plc_execute", OBJECT_SELF));
			             if(GetCampaignString("SLV_UNI", "Elementary Transmutation", oStudent) == "Elementary Transmutation")
						 	{SetCampaignString("SLV_UNI", "Standard Transmutation", "Standard Transmutation", oStudent);
							}
			             if(ACR_RetrieveQuestState("slv_tra200", oStudent) == 1)
								{ACR_AddPersistentJournalQuestEntry("slv_tra200", 2, oStudent, 0, 0, 0, 0);
								}
							DelayCommand(31.0, SendMessageToPC(oStudent, "The trough now holds a recognizable bar of steel, cooling rapidly."));
					     }
					
			else if((nCount != 3) || (nAlloy != 1) || (nOther != 0))
						{DelayCommand(30.0, SetUseableFlag(oMyTrough, TRUE));
						 DelayCommand(31.0, SendMessageToPC(oStudent, "The trough now holds an amorphous blob of slag.  Something must have gone wrong with the transmutation!"));
					     CreateItemOnObject("slv_tra200_slag", oMyTrough, 1);
					  	}
			}
             else
             {DelayCommand(2.0, SendMessageToPC(oStudent, "There is nothing in the forge."));
              DelayCommand(30.0, DestroyObject(oMyFlame));
             }
          }
		  
	
}