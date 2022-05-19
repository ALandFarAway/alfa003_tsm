#include "acr_quest_i"
#include "acr_creature_i"


void main()
{   ACR_CreatureOnConversation();
 

    object oPC = GetLastSpeaker();


    if(GetTag(OBJECT_SELF) == "003_cr_lath_cyrthol") 
			   {int nMatch = GetListenPatternNumber();
			    object oCollWP = GetLocalObject(OBJECT_SELF, "oCollWP");
				if(oCollWP == OBJECT_INVALID)
					 	{oCollWP = GetObjectByTag("003_door_sylune_collwp");
						 SetLocalObject(OBJECT_SELF, "oCollWP", oCollWP);
						}
				object oStatue = GetLocalObject(OBJECT_SELF, "oStatue");
			    if(oStatue == OBJECT_INVALID)
					 	{oStatue = GetObjectByTag("003_door_sylune_statue");
						 SetLocalObject(OBJECT_SELF, "oStatue", oStatue);
						}
				location lStatueWP = GetLocalLocation(OBJECT_SELF, "lStatueWP");
			    if(GetLocalInt(OBJECT_SELF, "lStatueWP") == 0)
					 	{lStatueWP = GetLocation(oStatue);
						 SetLocalLocation(OBJECT_SELF, "lStatueWP", lStatueWP);
						}
				object oStatueWP2 = GetLocalObject(OBJECT_SELF, "oStatueWP2");
			    if(oStatueWP2 == OBJECT_INVALID)
					 	{oStatueWP2 = GetObjectByTag("003_door_sylune_WP2");
						 SetLocalObject(OBJECT_SELF, "oStatueWP2", oStatueWP2);
						}
				object oWall= GetLocalObject(OBJECT_SELF, "oWall");
			    if(oWall == OBJECT_INVALID)
					 	{oWall = GetObjectByTag("003_door_sylune_wall");
						 SetLocalObject(OBJECT_SELF, "oWall", oWall);
						}
			    object oMyCollisionBox = GetLocalObject(OBJECT_SELF, "oMyCollisionBox");
				if(oMyCollisionBox == OBJECT_INVALID)
					 	{oMyCollisionBox = GetObjectByTag("003_door_sylune_collbox");
						 SetLocalObject(OBJECT_SELF, "oMyCollisionBox", oMyCollisionBox);
						}
				
			if((nMatch == 6001)  && (GetLocalInt(OBJECT_SELF, "SyluneOpen") == 0) )
					{SetLocalInt(OBJECT_SELF, "SyluneOpen", 1);
					 DestroyObject(oMyCollisionBox);
					 SetLocalObject(OBJECT_SELF, "oMyCollisionBox", OBJECT_INVALID);
					 DestroyObject(oWall);
					 SetLocalObject(OBJECT_SELF, "oWall", OBJECT_INVALID);
					 DestroyObject(oStatue);
					 SetLocalObject(OBJECT_SELF, "oStatue", OBJECT_INVALID);
					 oStatue = CreateObject(OBJECT_TYPE_PLACEABLE, "003_door_sylune_statue", GetLocation(oStatueWP2));
					 SetLocalObject(OBJECT_SELF, "oStatue", oStatue);
					 SendMessageToPC(oPC, "The statue silently slides sideways and the wall section before you drops into the floor.");
					 DelayCommand(59.0, SetLocalInt(OBJECT_SELF, "SyluneOpen", 2));
					 DelayCommand(60.0, ExecuteScript("tsm_npc_conversation", OBJECT_SELF));
					 }
					
			else if (GetLocalInt(OBJECT_SELF, "SyluneOpen")== 2)
				   	{SetLocalInt(OBJECT_SELF, "SyluneOpen", 0);
					 oMyCollisionBox = CreateObject(OBJECT_TYPE_PLACEABLE, "003_door_sylune_collbox", GetLocation(oCollWP));
					 SetLocalObject(OBJECT_SELF, "oMyCollisionBox", oMyCollisionBox);
					 oWall = CreateObject(OBJECT_TYPE_PLACEABLE, "003_door_sylune_wall", GetLocation(oCollWP));
					 SetLocalObject(OBJECT_SELF, "oWall", oWall);
					 DestroyObject(oStatue);
					 SetLocalObject(OBJECT_SELF, "oStatue", OBJECT_INVALID);
				 	 oStatue = CreateObject(OBJECT_TYPE_PLACEABLE, "003_door_sylune_statue", lStatueWP);
					 SetLocalObject(OBJECT_SELF, "oStatue", oStatue);
					  }
		 }
	
	if((GetTag(OBJECT_SELF)== "003_cr_scry_send") && (GetLastPerceived() != OBJECT_SELF)  && (GetTag(GetLastPerceived()) != "003_cr_scry_listen")) {
		object oScryListen = GetLocalObject(OBJECT_SELF, "oScryListen");	 
		int nMatch = GetListenPatternNumber();
		if(nMatch == 6031) {
			string sSpokenBy = GetName(GetLastPerceived());
			string sRelay = GetMatchedSubstring(1);
			AssignCommand(oScryListen, ActionSpeakString(sSpokenBy + ": " + sRelay, TALKVOLUME_TALK));
		    
		}
	}	 
	
	ActionSpeakString("oScryer= " + GetName(GetLocalObject(OBJECT_SELF, "oScryer")));
	object oHeard;
	ActionSpeakString("LastPerceived= " + GetName(GetLastPerceived()));
	
	if(GetLastPerceptionHeard()== 1) {
	oHeard = GetLastPerceived();
	ActionSpeakString("LastPerceptionHeard = " + GetName(oHeard));	 
	}	 
	if((GetTag(OBJECT_SELF)== "003_cr_scry_listen") && (GetLastPerceived() != OBJECT_SELF) && (GetLastPerceptionHeard())) {
		 	 
		int nMatch = GetListenPatternNumber();
		if(nMatch >= 6010) {
		 	string sMatch = GetMatchedSubstring(1);
			object oScryer = GetLocalObject(OBJECT_SELF, "oScryer");
			int nKnowledge;
			int nConnection;
			
			if((nMatch >= 6010) && (nMatch <= 6013)) {
				if(nMatch == 6010) {
				 	nKnowledge = -10;
				}
				if(nMatch == 6011) {
				 	nKnowledge = -5;
				}
				if(nMatch == 6012) {
				 	nKnowledge = 0;
				}
				if(nMatch == 6013) {
				 	nKnowledge = 5;
				}
				
				SetLocalInt(OBJECT_SELF, "nScryKnowledge", nKnowledge);
				SendMessageToPC(oScryer, "Your knowledge of the subject is: " + GetMatchedSubstring(1));
			}
			
			if((nMatch >= 6014) && (nMatch <= 6017)) {
				if(nMatch == 6014) {
			 	nConnection = 0;
				}
				if(nMatch == 6015) {
			 	nConnection = 2;
				}
				if(nMatch == 6016) {
				 	nConnection = 4;
				}
				if(nMatch == 6017) {
				 	nConnection = 10;
				}
				
				SetLocalInt(OBJECT_SELF, "nScryConnection", nConnection);
				SendMessageToPC(oScryer, "Your connection to the subject is: " + GetMatchedSubstring(1));
			}
			
			int nDC = GetLocalInt(OBJECT_SELF, "nScryDC") + GetLocalInt(OBJECT_SELF, "nScryKnowledge") + GetLocalInt(OBJECT_SELF, "nScryConnection");
			SendMessageToPC(oScryer, "DC = " + IntToString(nDC));
			
			if(nMatch >= 6020) {
				int nListenPattern = 6020;
	         	object oPC = GetFirstPC(FALSE);
				while ((oPC != OBJECT_INVALID) && (nListenPattern < 6030)) {
					 string sPCName = GetName(oPC);
					 if(TestStringAgainstPattern("**" + sPCName + "**", GetMatchedSubstring(1)))
						{if(WillSave(oPC, nDC, SAVING_THROW_TYPE_MIND_SPELLS, oScryer)) {
						 	SendMessageToPC(oPC, "You have a momentary sense of being watched...but it passes.");
						 	if(GetLocalInt(OBJECT_SELF, "nScryKnowledge") > 0) {
								SendMessageToPC(oScryer, "The passing sensation had a familiar presence to it, as if you had heard " + GetName(oScryer) + " call your name." );
								SendMessageToAllDMs(GetName(oPC) + " WillSaved DC " + IntToString(nDC) + " against " + GetName(oScryer) + " scrying them."); }
							}
						 else {
						 	float fScryActive = GetLocalFloat(OBJECT_SELF, "SCRY_TIMER");
						 	SetLocalInt(oPC, "SCRY_ACTIVE", 1);
							SendMessageToAllDMs(GetName(oPC) + " failed a WillSave DC " + IntToString(nDC) + " and is being scried by " + GetName(oScryer) + " for the next " + FloatToString(fScryActive, 2, 0) + " seconds."); 
							location lThere = GetLocation(oPC);
							object oScrySend = GetLocalObject(OBJECT_SELF, "oScrySend");
							if(oScrySend == OBJECT_INVALID) {
								oScrySend = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_scry_send", lThere);
				            	SetLocalObject(OBJECT_SELF, "oScrySend", oScrySend);
								SetLocalObject(oScrySend, "oScryListen", OBJECT_SELF);
								SetFirstName(oScrySend, "Scrying Sensor");
								DelayCommand(2.0, AssignCommand(oScrySend, ActionForceFollowObject(oPC, 0.5f, 0)));
								DestroyObject(oScrySend, fScryActive); 
								DelayCommand(fScryActive, SetLocalObject(OBJECT_SELF, "oScrySend", OBJECT_INVALID));
								}
							
							string sSubjectArea = GetName(GetArea(oPC));
							string sGenderNoun = "He";
							string sGenderAdj = "him";
							if(GetGender(oPC) == GENDER_FEMALE) {
								sGenderNoun = "She";
								sGenderAdj = "her";
							}
							
							
							
							SendMessageToPC(oScryer, GetName(oPC) + " is in " + sSubjectArea + ". These objects are around " + sGenderAdj + " within 10 feet:" );
							DelayCommand(fScryActive, SetLocalInt(oPC, "SCRY_ACTIVE", 0));
							 	
							object oObject = GetFirstObjectInShape(SHAPE_SPHERE, 10.0, GetLocation(oPC), FALSE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_ITEM | OBJECT_TYPE_PLACED_EFFECT | OBJECT_TYPE_DOOR);
							string sObjectName = GetName(oObject);
							float fDistance = GetDistanceBetween(oPC, oObject);
							int nInc = 1;
							while ((oObject != OBJECT_INVALID) && (nInc <= 10)){
								oObject = GetNextObjectInShape(SHAPE_SPHERE, 10.0, GetLocation(oPC), FALSE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_ITEM | OBJECT_TYPE_PLACED_EFFECT | OBJECT_TYPE_DOOR);
							    sObjectName = GetName(oObject);
								fDistance = GetDistanceBetween(oPC, oObject);
								if(sObjectName != GetName(oPC)) {
							    	SendMessageToPC(oScryer, sObjectName + " is " + FloatToString(fDistance, 2, 0) + " feet away from " + sGenderAdj + ".");
								}
								nInc++;
								}
							}
						 break;
						 }
					 nListenPattern++;
					 oPC = GetNextPC(FALSE);
					 if(oPC == OBJECT_INVALID) {
					 	SendMessageToPC(oScryer, "Your scrying spell fails to show you the one you seek.");
					 }	
				 }	
			}	
		} 	
	}	 
	
		 
	if(GetTag(OBJECT_SELF) == "003_cr_voice") 
		{int nMatch = GetListenPatternNumber();
		 string sArea = "_palace";
		 if(GetTag(GetArea(OBJECT_SELF)) == "6d_int_silvy_catacombs_1")
				{sArea = "_catacombs";
				}
		 object oMyTrigger = GetLocalObject(OBJECT_SELF, "oMyTrigger");
		 object oMyHeadstone = GetLocalObject(OBJECT_SELF, "oMyHeadstone");
		 if(oMyHeadstone == OBJECT_INVALID)
		 	{oMyHeadstone = GetObjectByTag(GetTag(oMyTrigger) + sArea);
			 SetLocalObject(OBJECT_SELF, "oMyHeadstone", oMyHeadstone);
			     if(oMyHeadstone == OBJECT_INVALID)
			 	{oMyHeadstone = GetObjectByTag("sm_sylune_listener_catacombs");
				 SetLocalObject(OBJECT_SELF, "oMyHeadstone", oMyHeadstone);
				 }
			}
		 		 			 
		 if(nMatch == 6009)
				 {if((GetItemPossessedBy(GetPCSpeaker(), "003_it_ward_adrath") == OBJECT_INVALID)&&(GetItemPossessedBy(GetPCSpeaker(), "003_it_ward_duraph") == OBJECT_INVALID)&&(GetItemPossessedBy(GetPCSpeaker(), "003_it_ward_lauthal") == OBJECT_INVALID)&&(GetItemPossessedBy(GetPCSpeaker(), "003_it_ward_thelbane") == OBJECT_INVALID))
						{SpeakString("That avenue is barred to those who are not Ward Initiates.", TALKVOLUME_TALK);
						}
				}
		 if((nMatch > 6001) && (nMatch < 6009))
			 {string sName = "Alustriel";
			  if(nMatch == 6003)
					{sName = "Dove";
					}
			  if(nMatch == 6004)
					{sName = "Storm";
					}
			  if(nMatch == 6005)
					{sName = "Laeral";
					}
			  if(nMatch == 6006)
					{sName = "Simbul";
					}
			  if(nMatch == 6007)
					{sName = "Alassra";
					}
			  if(nMatch == 6008)
					{sName = "Qilue";
					}
			  object oPortalTo = GetLocalObject(OBJECT_SELF, "oPortalTo");
			  if(oPortalTo == OBJECT_INVALID)
					 {oPortalTo = GetWaypointByTag(sName + "_Sylune_Portal_WP");
					  SetLocalObject(OBJECT_SELF, "oPortalTo", oPortalTo);
					  SetLocalObject(oMyHeadstone, "oPortalTo", oPortalTo);
					 }
			  DelayCommand(60.0, SetLocalObject(oMyHeadstone, "oPortalTo", OBJECT_INVALID));
			  SpeakString(sName + ".", TALKVOLUME_TALK);
			  DelayCommand(5.0, SpeakString(sName + " declines. Your signature has been noted.", TALKVOLUME_TALK));
			  if(((nMatch == 6002) || (nMatch == 6004)) && (ACR_RetrieveQuestState("slv_deandragon_h", oPC) >= 4) && (ACR_RetrieveQuestState("slv_deandragon_h", oPC) <= 5))
				 	{DelayCommand(7.5, SpeakString("*A new voice speaks, more feminine, and somehow more 'real'.", TALKVOLUME_TALK));
					 DelayCommand(10.0, SpeakString("One-time passage is granted, I think, to those who wish it. All aspects of the traveller will be noted: divine signature of deific powers and arcane signature of all Weave contact. Recent memories will be divined. If you accept these terms and wish to travel, touch the Headstone within one minute.", TALKVOLUME_TALK));
					 SetLocalInt(oMyHeadstone, "Active", 1);
					 DelayCommand(60.0, SetLocalInt(oMyHeadstone, "Active", 0));
					 }  
				
			if(((nMatch == 6002) || (nMatch == 6004)) && (ACR_RetrieveQuestState("slv_deansphinx_h", oPC) >= 5))
				 	{DelayCommand(7.5, SpeakString("*A new voice speaks, more feminine, and somehow more 'real'.", TALKVOLUME_TALK));
					 DelayCommand(10.0, SpeakString("One-time passage is granted, I think, to those who wish it. All aspects of the traveller will be noted: divine signature of deific powers and arcane signature of all Weave contact. Recent memories will be divined. If you accept these terms and wish to travel, touch the Headstone within one minute.", TALKVOLUME_TALK));
					 SetLocalInt(oMyHeadstone, "Active", 1);
					 DelayCommand(60.0, SetLocalInt(oMyHeadstone, "Active", 0));
					 }  
				}
					
			  if((nMatch == 6001)&& (GetTag(GetArea(OBJECT_SELF)) == "6d_int_silvy_catacombs_1")&& (GetLocalInt(OBJECT_SELF, "SyluneShow") != 1))
				 	{ object oSyluneGhost = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_silverhand_sylune", GetLocation(oMyHeadstone));
					  SetLocalObject(OBJECT_SELF, "oSyluneGhost", oSyluneGhost);
					  AssignCommand(oSyluneGhost, SpeakString("Sylune.", TALKVOLUME_TALK));
					  DelayCommand(5.0, AssignCommand(oSyluneGhost, SpeakString("Sylune, beloved sister.", TALKVOLUME_TALK)));
					  DelayCommand(10.0, AssignCommand(oSyluneGhost, SpeakString("Sylune is no more. That avenue is forever closed.", TALKVOLUME_TALK)));
					  SetLocalInt(OBJECT_SELF, "SyluneShow", 1);
					  DelayCommand(200.0, SetLocalInt(OBJECT_SELF, "SyluneShow", 0));
					         location lGoTo2 = GetLocalLocation(oMyHeadstone, "lGoTo2");
							 location lGoTo3 = GetLocalLocation(oMyHeadstone, "lGoTo3");
							 location lGoTo4 = GetLocalLocation(oMyHeadstone, "lGoTo4");
							 effect eKnockdown = EffectKnockdown();
							 effect eRippleExplode = EffectVisualEffect(507, FALSE);
							 effect eGlobeInvuln = EffectVisualEffect(512, FALSE);
							 effect ePrismatic = EffectVisualEffect(607, FALSE);
							 effect eRedGroundCircle = EffectVisualEffect(496, FALSE);
							 effect eGround1 = EffectVisualEffect(554, FALSE);
							 effect eGround2 = EffectVisualEffect(555, FALSE);
							 effect eGround3 = EffectVisualEffect(556, FALSE);
							 effect eFireExplosion = EffectVisualEffect(564, FALSE);
							 effect eSteamExplosion = EffectVisualEffect(569, FALSE);
							 effect eElectric = EffectVisualEffect(74, FALSE);
							 effect eDarkness = EffectVisualEffect(886, FALSE);
							 effect eFireCone = EffectVisualEffect(871, FALSE);
							 effect eFilaments = EffectVisualEffect(729, FALSE);
							 effect eHeal = EffectVisualEffect(70, FALSE);
							 effect ePestilence = EffectVisualEffect(538, FALSE);
							 effect eSongRunes = EffectVisualEffect(631, FALSE);
							 effect eHolyStrike = EffectVisualEffect(626, FALSE);
							 effect eRevolving = EffectVisualEffect(553, FALSE);
							 effect eCircle = EffectVisualEffect(700, FALSE);
							 effect eQuake = EffectVisualEffect(VFX_SPELL_HIT_EARTHQUAKE, FALSE);
							 effect eExpanding = EffectVisualEffect(552, FALSE);
							 effect eImplode = EffectVisualEffect(736, FALSE);
							 effect ePillar = EffectVisualEffect(999, FALSE);
							 effect eRipple = EffectVisualEffect(1045, FALSE);
							 effect eSonicImplode = EffectVisualEffect(1009, FALSE);
							 effect eRing = EffectVisualEffect(1010, FALSE);
							 effect eWhiteOut = EffectVisualEffect(778, FALSE);
							 object oSylune = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_deandragon_h_sylune", lGoTo4);
					  		 object oDragon = CreateObject(OBJECT_TYPE_CREATURE, "003_cr_deandragon_h_dragon", lGoTo2);
					  		 SetLocalObject(OBJECT_SELF, "oSylune", oSylune);
							 SetLocalObject(OBJECT_SELF, "oRedDragon", oDragon);
							 DelayCommand(15.0, AssignCommand(oSyluneGhost, ActionSpeakString("Sylune died in the Year of Rogue Dragons.", TALKVOLUME_TALK)));
							 DelayCommand(23.0, AssignCommand(oSyluneGhost, ActionSpeakString("While Silverymoon dealt with a flight of dragons at its walls, far away Sylune had not the walls nor the resources of Silverymoon. When the dragons appeared in her skies, there was only her.", TALKVOLUME_TALK)));
							 DelayCommand(30.0, AssignCommand(oSyluneGhost, ActionSpeakString("And so she went to meet them.", TALKVOLUME_TALK)));
							 DelayCommand(37.0, AssignCommand(oSyluneGhost, ActionSpeakString("There was one great red dragon whom she could neither force nor threaten away.", TALKVOLUME_TALK)));
							 DelayCommand(37.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGround1, oDragon, 3.0));
							 DelayCommand(44.0, AssignCommand(oSyluneGhost, ActionSpeakString("Again and again she tried to turn him back with words.", TALKVOLUME_TALK)));
							 DelayCommand(46.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGround2, oDragon, 3.0));
							 DelayCommand(49.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGlobeInvuln, oDragon, 40.0));
							 DelayCommand(52.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRedGroundCircle, oDragon, 3.0));
							 DelayCommand(56.0, AssignCommand(oSyluneGhost, ActionSpeakString("He but used the time to prepare. His evil and his intentions apparent, she raised protections.", TALKVOLUME_TALK)));
							 DelayCommand(58.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGlobeInvuln, oSylune, 5.0));
							 DelayCommand(63.0, AssignCommand(oSyluneGhost, ActionSpeakString("But too late. The dragon attacked, ripping away those protections.", TALKVOLUME_TALK)));
							 DelayCommand(67.5, AssignCommand(oDragon,  ActionCastFakeSpellAtObject(IP_CONST_CASTSPELL_DRAGON_BREATH_FIRE_10, oDragon, PROJECTILE_PATH_TYPE_DEFAULT)));
							 DelayCommand(68.0, AssignCommand(oDragon, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFireCone, oSylune, 3.0)));
							 DelayCommand(69.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFireExplosion, oSylune, 5.0));
							 DelayCommand(72.0, AssignCommand(oDragon, ActionAttack(oSylune)));
							 DelayCommand(73.0, AssignCommand(oSylune, ClearAllActions(TRUE)));
							 DelayCommand(74.0, AssignCommand(oSylune, ActionForceMoveToLocation(lGoTo2)));
							 DelayCommand(78.0, AssignCommand(oSylune, SetFacingPoint(GetPositionFromLocation(GetLocation(oDragon)), FALSE)));
							 DelayCommand(78.5, AssignCommand(oDragon, ClearAllActions(TRUE)));
							 DelayCommand(79.0, AssignCommand(oDragon, SetFacingPoint(GetPositionFromLocation(GetLocation(oSylune)), FALSE)));
							 DelayCommand(79.0, AssignCommand(oSyluneGhost, ActionSpeakString("Stung, she cast a mild warning spell at it before attempting to resume peaceful persuasion.", TALKVOLUME_TALK)));
							 DelayCommand(79.5, AssignCommand(oSylune,  ActionCastFakeSpellAtObject(SPELL_MAGIC_MISSILE, oDragon, PROJECTILE_PATH_TYPE_DEFAULT)));
							 DelayCommand(81.0, AssignCommand(oSylune, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eElectric, oDragon, 3.0)));
							 DelayCommand(83.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eElectric, oDragon, 3.0));
							 DelayCommand(86.0, AssignCommand(oSyluneGhost, ActionSpeakString("Rather than parley, though, the unsubtle creature threw the full force of fang and spell at her. The battle was unavoidably joined!", TALKVOLUME_TALK)));
							 DelayCommand(88.5, AssignCommand(oDragon,  ActionCastFakeSpellAtObject(IP_CONST_CASTSPELL_DRAGON_BREATH_FIRE_10, oDragon, PROJECTILE_PATH_TYPE_DEFAULT)));
							 DelayCommand(89.0, AssignCommand(oDragon, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFireCone, oSylune, 3.0)));
							 DelayCommand(90.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFireExplosion, oSylune, 5.0));
							 DelayCommand(93.0, AssignCommand(oDragon, ActionAttack(oSylune)));
							 DelayCommand(93.5, AssignCommand(oSylune,  ActionCastFakeSpellAtObject(SPELL_SOUND_BURST, oDragon, PROJECTILE_PATH_TYPE_DEFAULT)));
							 DelayCommand(94.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eCircle, oDragon, 3.0));
							 DelayCommand(94.0, AssignCommand(oSylune, ClearAllActions(TRUE)));
							 DelayCommand(94.5, AssignCommand(oSylune, ClearAllActions(TRUE)));
							 DelayCommand(95.0, AssignCommand(oSylune, ActionForceMoveToLocation(lGoTo3)));
							 DelayCommand(99.0, AssignCommand(oSylune, SetFacingPoint(GetPositionFromLocation(GetLocation(oSylune)), FALSE)));
							 DelayCommand(100.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eExpanding, oSylune, 3.0));
							 DelayCommand(102.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHeal, oSylune, 3.0));
							 DelayCommand(105.5, AssignCommand(oSylune,  ActionCastFakeSpellAtObject(SPELL_SONG_OF_DISCORD, oDragon, PROJECTILE_PATH_TYPE_DEFAULT)));
							 DelayCommand(107.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSteamExplosion, oDragon, 3.0));
							 DelayCommand(109.0, AssignCommand(oSylune, ClearAllActions(TRUE)));
							 DelayCommand(109.5, AssignCommand(oSylune, ClearAllActions(TRUE)));
							 DelayCommand(110.0, AssignCommand(oSylune, ActionForceMoveToLocation(lGoTo3)));
							 DelayCommand(114.0, AssignCommand(oSylune, SetFacingPoint(GetPositionFromLocation(GetLocation(oDragon)), FALSE)));
							 DelayCommand(114.5, AssignCommand(oDragon, SetFacingPoint(GetPositionFromLocation(GetLocation(oSylune)), FALSE)));
							 DelayCommand(115.5, AssignCommand(oSylune,  ActionCastFakeSpellAtObject(SPELL_SYMBOL_OF_DEATH, oDragon, PROJECTILE_PATH_TYPE_DEFAULT)));
							 DelayCommand(118.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHeal, oDragon, 3.0));
							 DelayCommand(119.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePestilence, oSylune, 5.0));
							 DelayCommand(119.5, AssignCommand(oSyluneGhost, ActionSpeakString("To negate his natural advantages, she polymorphed into a silver dragon.", TALKVOLUME_TALK)));
							 DelayCommand(120.0, SetLocalInt(OBJECT_SELF, "Stage", 1));
							 DelayCommand(123.5, ExecuteScript("tsm_npc_execute", OBJECT_SELF));
							 DelayCommand(124.0, AssignCommand(oDragon, ClearAllActions(TRUE)));
							 
							 
							 
					  if(ACR_RetrieveQuestState("slv_deandragon_h", oPC) == 4)
								{DelayCommand(195.0, ACR_AddPersistentJournalQuestEntry("slv_deandragon_h", 5, oPC));
								}
					  if(ACR_RetrieveQuestState("slv_deansphinx_h", oPC) == 4)
								{ACR_AddPersistentJournalQuestEntry("slv_deansphinx_h", 5, oPC);
								}
					}
			}
				 
				 
				 
	//slv_deandragon_l 
    if(GetTag(OBJECT_SELF) == "003_cr_dr_nephos") 
			   {DelayCommand(10.0, ChangeToStandardFaction(OBJECT_SELF, STANDARD_FACTION_HOSTILE));
			   }
			 
			   	//slv_deandragon_x 
    if(GetTag(OBJECT_SELF) == "003_cr_slv_procenc2") 
			   {CreateObject(OBJECT_TYPE_PLACEABLE, "slv_deandragon_x_gem_plc", GetLocation(GetWaypointByTag("slv_deandragon_x_alastrarra")));
			   }
	   	 
}