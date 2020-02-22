//Conversation driven for all 1gp circus acts  
//Wynna May 2015


#include "acr_creature_i"


void ActionCreateWynPlace(string sPlace, location lLocPlace)
{
    CreateObject(OBJECT_TYPE_PLACEABLE, sPlace, lLocPlace);
}


void ReallyPlayCustomAnimation(object oObject, string sAnimationName, int nLooping, float fSpeed = 1.0f)
 {
    PlayCustomAnimation(oObject, sAnimationName, nLooping, fSpeed);
 }
 
void main()
{
	object oPC = GetPCSpeaker();
		 
	if(GetLocalInt(OBJECT_SELF, "nIncrement") < 1)
			{int nPerformRandom = Random(20) + 1;
			 ActionSpeakString("*OOC: The performer rolls " + IntToString(nPerformRandom) + " on a Perform Check for this performance.*", TALKVOLUME_TALK);
			}
	
	// Fire Breather	
	if(GetTag(OBJECT_SELF) == "003_cr_circus_fire_breath")
		{location lFireCast=GetLocation(GetWaypointByTag("fire_cast_wp"));
		 location lFireStart=GetLocation(GetWaypointByTag("fire_start_wp"));
		 object oBrazier = GetNearestObjectByTag("003_plc_brazier", OBJECT_SELF, 1);
		 object oBrazierLit = GetNearestObjectByTag("003_plc_brazier_lit", oBrazier, 1);
		 location lBrazier = GetLocation(oBrazier);
		 object oTorch = GetNearestObjectByTag("003_plc_torch", OBJECT_SELF, 1);
		 object oTorchLit = GetNearestObjectByTag("003_plc_torch_lit", oTorch, 1);
		 location lTorch = GetLocation(oTorch);
		 object oCandle = GetNearestObjectByTag("003_plc_candle", OBJECT_SELF, 1);
		 object oCandleLit = GetNearestObjectByTag("003_plc_candle_lit", oCandle, 1);
		 location lCandle = GetLocation(oCandle);
		 object oCandle2 = GetNearestObjectByTag("003_plc_candle", OBJECT_SELF, 2);
		 object oCandleLit2 = GetNearestObjectByTag("003_plc_candle_lit", oCandle2, 2);
		 location lCandle2 = GetLocation(oCandle2);
		 object oCandle3 = GetNearestObjectByTag("003_plc_candle", OBJECT_SELF, 3);
		 object oCandleLit3 = GetNearestObjectByTag("003_plc_candle_lit", oCandle3, 3);
		 location lCandle3 = GetLocation(oCandle3);
		 object oCandle4 = GetNearestObjectByTag("003_plc_candle", OBJECT_SELF, 4);
		 object oCandleLit4 = GetNearestObjectByTag("003_plc_candle_lit", oCandle4, 4);
		 location lCandle4 = GetLocation(oCandle4);
		 object oCandle5 = GetNearestObjectByTag("003_plc_candle", OBJECT_SELF, 5);
		 object oCandleLit5 = GetNearestObjectByTag("003_plc_candle_lit", oCandle5, 5);
		 location lCandle5 = GetLocation(oCandle5);
		 DestroyObject(oBrazierLit);
		 DestroyObject(oTorchLit);
		 DestroyObject(oCandleLit);
		 DestroyObject(oCandleLit2);
		 DestroyObject(oCandleLit3);
		 DestroyObject(oCandleLit4);
		 DestroyObject(oCandleLit5);
		 
		 int nSpell=10;
 		 int nIncrement= GetLocalInt(OBJECT_SELF, "nIncrement");
		 
		 if(nIncrement==0) 
			 {ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK, 1.0, 2.0);
			 ActionMoveToLocation(lFireCast, FALSE);
			 DestroyObject(oBrazierLit);
			 DestroyObject(oTorchLit);
			 DestroyObject(oCandleLit);
			 DestroyObject(oCandleLit2);
			 DestroyObject(oCandleLit3);
			 DestroyObject(oCandleLit4);
			 DestroyObject(oCandleLit5);
			 DelayCommand(4.0, ActionCastSpellAtObject(nSpell, oBrazier, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
			 DelayCommand(5.0, ActionCreateWynPlace("003_plc_brazier_lit" , GetLocation(oBrazier)));
			 DelayCommand(7.0, ActionCastSpellAtObject(nSpell, oTorch, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
			 DelayCommand(8.0, ActionCreateWynPlace("003_plc_torch_lit" , GetLocation(oTorch)));
			 DelayCommand(10.0, ActionCastSpellAtObject(nSpell, oCandle, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
			 DelayCommand(11.0, ActionCreateWynPlace("003_plc_candle_lit" , GetLocation(oCandle)));
			 DelayCommand(13.0, ActionCastSpellAtObject(nSpell, oCandle2, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
			 DelayCommand(14.0, ActionCreateWynPlace("003_plc_candle_lit" , GetLocation(oCandle2)));
			 DelayCommand(16.0, ActionCastSpellAtObject(nSpell, oCandle3, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
			 DelayCommand(17.0, ActionCreateWynPlace("003_plc_candle_lit" , GetLocation(oCandle3)));
			 DelayCommand(19.0, ActionCastSpellAtObject(nSpell, oCandle4, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
			 DelayCommand(20.0, ActionCreateWynPlace("003_plc_candle_lit" , GetLocation(oCandle4)));
			 DelayCommand(22.0, ActionCastSpellAtObject(nSpell, oCandle5, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
			 DelayCommand(23.0, ActionCreateWynPlace("003_plc_candle_lit" , GetLocation(oCandle5)));
			 DelayCommand(25.0, AssignCommand(OBJECT_SELF, ActionPlayAnimation(ANIMATION_FIREFORGET_BOW, 1.0, 5.0)));
			 DelayCommand(26.0, ActionSpeakString("*Offers a wordless bow, coughing up smoke*", TALKVOLUME_TALK));
			 DelayCommand(28.0, ActionMoveToLocation(lFireStart, FALSE));
			 SetLocalInt(OBJECT_SELF, "nIncrement", 1);
			 DelayCommand(30.0, ExecuteScript("circus_npc_conv_execute1", OBJECT_SELF));
			 }
			 
		 if(nIncrement==1)
		 	{SetLocalInt(OBJECT_SELF, "nIncrement", 0);
			 }
		}
		
	// Dagger Thrower	
	if(GetTag(OBJECT_SELF) == "003_cr_circus_dagger_throw")
		{location lDaggerThrow=GetLocation(GetWaypointByTag("dagger_throw_wp"));
		 location lDaggerStart=GetLocation(GetWaypointByTag("dagger_start_wp"));
		 location lBeardedStart=GetLocation(GetWaypointByTag("bearded_start_wp"));
		 location lDagger;
		 object oDagger1WP = GetWaypointByTag("circus_dagger1_wp");
		 location lDagger1 = GetLocation(oDagger1WP);
		 object oDagger2WP = GetWaypointByTag("circus_dagger2_wp");
		 location lDagger2 = GetLocation(oDagger2WP);
		 object oDagger3WP = GetWaypointByTag("circus_dagger3_wp");
		 location lDagger3 = GetLocation(oDagger3WP);
		 object oDagger4WP = GetWaypointByTag("circus_dagger4_wp");
		 location lDagger4 = GetLocation(oDagger4WP);
		 object oDagger5WP = GetWaypointByTag("circus_dagger5_wp");
		 location lDagger5 = GetLocation(oDagger1WP);
		 object oDagger6WP = GetWaypointByTag("circus_dagger6_wp");
		 location lDagger6 = GetLocation(oDagger6WP);
		 object oDagger7WP = GetWaypointByTag("circus_dagger7_wp");
		 location lDagger7 = GetLocation(oDagger7WP);
		 object oDagger8WP = GetWaypointByTag("circus_dagger8_wp");
		 location lDagger8 = GetLocation(oDagger8WP);
		 object oDagger9WP = GetWaypointByTag("circus_dagger9_wp");
		 location lDagger9 = GetLocation(oDagger9WP);
		  
		 object oDaggerTarget = GetObjectByTag("003_plc_circus_target_dagger", 0);
		 object oBeardedLady = GetObjectByTag("003_cr_circus_bearded_lady", 0);
		 int nIncrement= GetLocalInt(OBJECT_SELF, "nIncrement");
		 
		if(nIncrement == 0) {
			 ActionMoveToLocation(lDaggerThrow, FALSE);
			 DelayCommand(1.0, ActionSpeakString("Are you ready, my dear?", TALKVOLUME_TALK));
		     DelayCommand(5.0, AssignCommand(oBeardedLady, ActionSpeakString("Ready!", TALKVOLUME_TALK)));
		      
			 DelayCommand(6.0, ActionMoveToLocation(lDaggerThrow, FALSE));
			 DelayCommand(8.0, SetFacing(315.0, FALSE));
			 DelayCommand(6.0, AssignCommand(oBeardedLady, ActionMoveToLocation(lBeardedStart, FALSE)));
			 DelayCommand(8.0, AssignCommand(oBeardedLady, SetFacing(135.0, FALSE)));
			 DelayCommand(10.0, ActionSpeakString("Hurls daggers one by one, outlining the bearded lady in wicked steel blades.", TALKVOLUME_TALK));
		     
			 DelayCommand(10.0, ReallyPlayCustomAnimation(OBJECT_SELF, "*1attack01", 0, 1.0f));
			 DelayCommand(11.0,  ActionCreateWynPlace("003_plc_circus_dagger" , lDagger1));
			 DelayCommand(15.0, ReallyPlayCustomAnimation(OBJECT_SELF, "*1attack01", 0, 1.0f));
			 DelayCommand(16.0, ActionCreateWynPlace("003_plc_circus_dagger" , lDagger2));
			 DelayCommand(20.0, ReallyPlayCustomAnimation(OBJECT_SELF, "*1attack01", 0, 1.0f));
			 DelayCommand(21.0, ActionCreateWynPlace("003_plc_circus_dagger" , lDagger3));
			 DelayCommand(25.0, ReallyPlayCustomAnimation(OBJECT_SELF, "*1attack01", 0, 1.0f));
			 DelayCommand(26.0, ActionCreateWynPlace("003_plc_circus_dagger" , lDagger4));
			 DelayCommand(30.0, ReallyPlayCustomAnimation(OBJECT_SELF, "*1attack01", 0, 1.0f));
			 DelayCommand(31.0, ActionCreateWynPlace("003_plc_circus_dagger" , lDagger5));
			 DelayCommand(35.0, ReallyPlayCustomAnimation(OBJECT_SELF, "*1attack01", 0, 1.0f));
			 DelayCommand(36.0, ActionCreateWynPlace("003_plc_circus_dagger" , lDagger6));
			 DelayCommand(40.0, ReallyPlayCustomAnimation(OBJECT_SELF, "*1attack01", 0, 1.0f));
			 DelayCommand(41.0, ActionCreateWynPlace("003_plc_circus_dagger" , lDagger7));
			 DelayCommand(45.0, ReallyPlayCustomAnimation(OBJECT_SELF, "*1attack01", 0, 1.0f));
			 DelayCommand(46.0, ActionCreateWynPlace("003_plc_circus_dagger" , lDagger8));
			 SetLocalInt(OBJECT_SELF, "nIncrement", 1);
			 DelayCommand(50.0, ExecuteScript("circus_npc_conv_execute1", OBJECT_SELF));
			 }
		
		if(nIncrement==1)
			{DelayCommand(1.0, ActionPlayAnimation(ANIMATION_FIREFORGET_BOW, 1.0, 1.0));
		  	 DelayCommand(1.5, AssignCommand(oBeardedLady, ActionPlayAnimation(ANIMATION_FIREFORGET_BOW, 1.0, 1.0)));
		  	 DelayCommand(2.0, ActionSpeakString("Not a scratch on her, nor a hair shaved!", TALKVOLUME_TALK));
		     DelayCommand(4.0, ActionForceMoveToObject(oDaggerTarget, FALSE, 1.0));
			 SetLocalInt(OBJECT_SELF, "nIncrement", 0);
			 DestroyObject(GetNearestObjectToLocation(OBJECT_TYPE_PLACEABLE, lDagger1, 1 ));
			 DestroyObject(GetNearestObjectToLocation(OBJECT_TYPE_PLACEABLE, lDagger2, 1 ));
			 DestroyObject(GetNearestObjectToLocation(OBJECT_TYPE_PLACEABLE, lDagger3, 1 ));
			 DestroyObject(GetNearestObjectToLocation(OBJECT_TYPE_PLACEABLE, lDagger4, 1 ));
			 DestroyObject(GetNearestObjectToLocation(OBJECT_TYPE_PLACEABLE, lDagger5, 1 ));
			 DestroyObject(GetNearestObjectToLocation(OBJECT_TYPE_PLACEABLE, lDagger6, 1 ));
			 DestroyObject(GetNearestObjectToLocation(OBJECT_TYPE_PLACEABLE, lDagger7, 1 ));
			 DestroyObject(GetNearestObjectToLocation(OBJECT_TYPE_PLACEABLE, lDagger8, 1 ));
			 SetLocalInt(OBJECT_SELF, "nIncrement", 0);
		 	 DelayCommand(10.0, ActionMoveToLocation(lDaggerStart, FALSE));
			 }
		}
			
	//Fortune Teller
    if(GetTag(OBJECT_SELF) == "003_cr_circus_waterweird")
        {if(GetLocalString(GetArea(OBJECT_SELF), GetName(oPC)) != GetName(oPC))
			{SetLocalString(GetArea(OBJECT_SELF), GetName(oPC), GetName(oPC));
		 	 string sDie = "a peaceful death in your old age, surrounded by loved ones.";
			 int nDie = Random(21);
			 
			 if(nDie==1)
			 	{sDie="in battle, winning glory for your cause.";}
			 if(nDie==2)
			 	{sDie="a poor man's death, choking on not enough to eat and buried in a paupers grave.";}
			 if(nDie==3)
			 	{sDie="to a bandit's blade in your heart on a dark country road.";}
			 if(nDie==4)
			 	{sDie="by a thief's blade across your throat in a fetid alley of a crowded city.";}
			 if(nDie==5)
			 	{sDie="of a broken heart, wasting away for love unrequited.";}
			 if(nDie==6)
			 	{sDie="a gruesome death of decapitation, with your head mounted on a pike above enemy gates.";}
			 if(nDie==7)
			 	{sDie="in a cannibal's cookpot, with tribal shamen dancing around the flames.";}
			 if(nDie==8)
			 	{sDie="by an act of a deity to whom you gave your faith.";}
			 if(nDie==9)
			 	{sDie="by treachery, from betrayal unlooked for.";}
			 if(nDie==10)
			 	{sDie="by hanging, stretching your neck on a magistrate's rope.";}
			 if(nDie==11)
			 	{sDie="in a fall, plummeting from a height to your death on rocks below.";}
			 if(nDie==12)
			 	{sDie="by drowning, choking on seawater while Umberlee laughs and the wreckage of a ship sinks beneath the waves.";}
			 if(nDie==13)
			 	{sDie="by fire, skin charring, fat melting, bones cracking in the heat before blessed oblivion claims you.";}
			 if(nDie==14)
			 	{sDie="only to rise again, cursed undead for your acts.";}
			 if(nDie==15)
			 	{sDie="lost and alone, with no one to mark your passing, nor bury your remains.";}
			 if(nDie==16)
			 	{sDie="by freezing, shivering your last on a floe of ice as your blood congeals and frost forms on your eyes.";}
			 if(nDie==17)
			 	{sDie="by quicksand, sinking into the shifting sands as they close overhead, with your struggles only serving to bring the sands pouring onto your head.";}
			 if(nDie==18)
			 	{sDie="of disease, coughing up blood and covered in festering boils.";}
			 if(nDie==19)
			 	{sDie="by poison, delivered in a draught by the hand of one you thought a friend.";}
			 if(nDie==20)
			 	{sDie="to hungry nature, your flesh feeding the flesh of creatures less civilized.";}
			 
			 DelayCommand(2.0, ActionSpeakString("Let me gaze into the waters of your soul.", TALKVOLUME_TALK));
			 DelayCommand(4.0, ActionSpeakString("I see death. Death comes to all, but to some sooner than others. You shall die...", TALKVOLUME_TALK));
			 DelayCommand(8.0, ActionSpeakString(sDie, TALKVOLUME_TALK));
		  }
		 else
		 	{DelayCommand(2.0, ActionSpeakString("I cannot change the fate I have already seen for you.", TALKVOLUME_TALK));}
		}
 
	// Juggler	
	if(GetTag(OBJECT_SELF) == "003_cr_circus_juggler")
		{location lJuggle;
		 object oJuggle1=GetWaypointByTag("circus_juggle1");
		 location lJuggle1=GetLocation(oJuggle1);
		 object oJuggle2=GetWaypointByTag("circus_juggle2");
		 location lJuggle2=GetLocation(oJuggle2);
		 object oJuggle3=GetWaypointByTag("circus_juggle3");
		 location lJuggle3=GetLocation(oJuggle3);
		 object oJuggle4=GetWaypointByTag("circus_juggle4");
		 location lJuggle4=GetLocation(oJuggle4);
		 object oJuggle5=GetWaypointByTag("circus_juggle5");
		 location lJuggle5=GetLocation(oJuggle5);
		 object oJuggle6=GetWaypointByTag("circus_juggle6");
		 location lJuggle6=GetLocation(oJuggle6);
		 
		 location lJuggleb;
		 object oJuggle1b=GetWaypointByTag("circus_juggle1b");
		 location lJuggle1b=GetLocation(oJuggle1b);
		 object oJuggle2b=GetWaypointByTag("circus_juggle2b");
		 location lJuggle2b=GetLocation(oJuggle2b);
		 object oJuggle3b=GetWaypointByTag("circus_juggle3b");
		 location lJuggle3b=GetLocation(oJuggle3b);
		 object oJuggle4b=GetWaypointByTag("circus_juggle4b");
		 location lJuggle4b=GetLocation(oJuggle4b);
		 object oJuggle5b=GetWaypointByTag("circus_juggle5b");
		 location lJuggle5b=GetLocation(oJuggle5b);
		 object oJuggle6b=GetWaypointByTag("circus_juggle6b");
		 location lJuggle6b=GetLocation(oJuggle6b);
		 int nIncrement= 1 + GetLocalInt(OBJECT_SELF, "nIncrement");
		 if(nIncrement==20)
			 	{SpeakString("*Tosses sparking bottles and burning plates back and forth to his partner.*", TALKVOLUME_TALK);}
		    
		 object oJuggler2 = GetNearestObjectByTag(GetTag(OBJECT_SELF), OBJECT_SELF, 1);
		 
		 
		 SetLocalInt(OBJECT_SELF, "nIncrement", nIncrement);
		 DestroyObject(GetObjectByTag("circus_juggle_bottle", 0));
		 DestroyObject(GetObjectByTag("circus_juggle_plate", 0));
		 DestroyObject(GetObjectByTag("circus_juggle_pitcher", 0));
		 DestroyObject(GetObjectByTag("circus_juggle_bottle", 1));
		 DestroyObject(GetObjectByTag("circus_juggle_plate", 1));
		 DestroyObject(GetObjectByTag("circus_juggle_pitcher", 1));
		 
		 string sCreate="circus_juggle_bottle";
		 if(nIncrement < 31)
		 	{if((nIncrement==1)||(nIncrement==7)||(nIncrement==13)||(nIncrement==19)||(nIncrement==25))
				{lJuggle=lJuggle1;
				 lJuggleb=lJuggle1b;
				 PlayAnimation(ANIMATION_LOOPING_DANCE03, 1.0, 3.0);
				 ActionWait(3.0);
				 AssignCommand(oJuggler2, PlayAnimation(ANIMATION_LOOPING_DANCE03, 1.0, 3.0));
				 }
			 if((nIncrement==2)||(nIncrement==8)||(nIncrement==14)||(nIncrement==20)||(nIncrement==26))
				{lJuggle=lJuggle2;
				 lJuggleb=lJuggle2b;
				 }
			 if((nIncrement==3)||(nIncrement==9) ||(nIncrement==15)||(nIncrement==21)||(nIncrement==27))
				{lJuggle=lJuggle3;
				 lJuggleb=lJuggle3b;
				}
			 if((nIncrement==4)||(nIncrement==10)||(nIncrement==16)||(nIncrement==22)||(nIncrement==28))
				{lJuggle=lJuggle4;
				 lJuggleb=lJuggle4b;
				}
			 if((nIncrement==5)||(nIncrement==11)||(nIncrement==17)||(nIncrement==23)||(nIncrement==29))
				{lJuggle=lJuggle5;
				 lJuggleb=lJuggle5b;
				}
			 if((nIncrement==6)||(nIncrement==12)||(nIncrement==18)||(nIncrement==24)||(nIncrement==30))
				{lJuggle=lJuggle6;
				 lJuggleb=lJuggle6b;
				}
			 if((nIncrement==13)|| (nIncrement==15) || (nIncrement==17)|| (nIncrement==19)|| (nIncrement==21)|| (nIncrement==23)|| (nIncrement==25)|| (nIncrement==27)|| (nIncrement==29)|| (nIncrement==33)|| (nIncrement==36)|| (nIncrement==39)|| (nIncrement==42)|| (nIncrement==45)|| (nIncrement==48))
				{sCreate="circus_juggle_plate";}
			 if((nIncrement==13)|| (nIncrement==28) || (nIncrement==31)|| (nIncrement==34)|| (nIncrement==37)|| (nIncrement==40)|| (nIncrement==43)|| (nIncrement==46)|| (nIncrement==49))
				{sCreate="circus_juggle_pitcher";}
			 
			 	
			 ActionCreateWynPlace(sCreate, lJuggle);
			 ActionCreateWynPlace(sCreate, lJuggleb);
			 DelayCommand(1.0, ExecuteScript("circus_npc_conv_execute1", OBJECT_SELF));
			 }
		else
			{SetLocalInt(OBJECT_SELF, "nIncrement", 0);
			PlayAnimation(ANIMATION_FIREFORGET_BOW, 1.0, 5.0);
		 	SpeakString("Thank you, kind audience!", TALKVOLUME_TALK);
		    DelayCommand(1.0, AssignCommand(oJuggler2, ActionSpeakString("*Catches the crockery, landing bottle in pitcher and pitcher on plate, and bows over it.*", TALKVOLUME_TALK)));
		    }
		
		}			
		

	//Dancing Bear
    if(GetTag(OBJECT_SELF) == "003_cr_circus_master_bears")
        {string sCreature = GetLocalString(OBJECT_SELF, "circus_master");
		 object oBear = GetNearestObjectByTag(sCreature, OBJECT_SELF, 1);
		 object oBearWP1 = GetWaypointByTag("dancing_bear1_wp");
		 object oBearWP2 = GetWaypointByTag("dancing_bear2_wp");
		 object oBearWP3 = GetWaypointByTag("dancing_bear3_wp");
		 object oBearWP4 = GetWaypointByTag("dancing_bear4_wp");
		 object oBearWP5 = GetWaypointByTag("dancing_bear5_wp");
		 DelayCommand(1.0, AssignCommand(OBJECT_SELF, ActionPlayAnimation(ANIMATION_LOOPING_GUITARPLAY, 1.0, 2.0)));
		 DelayCommand(1.0, AssignCommand(OBJECT_SELF, PlaySound("as_cv_lute1", FALSE)));
		 
		 DelayCommand(2.0, AssignCommand(oBear, ActionMoveToObject(oBearWP2, FALSE, 1.0)));
		 DelayCommand(3.0, AssignCommand(oBear, ActionMoveToObject(oBearWP3, FALSE, 1.0)));
		 DelayCommand(4.0, AssignCommand(oBear, ActionMoveToObject(oBearWP4, FALSE, 1.0)));
		 DelayCommand(5.0, AssignCommand(oBear, ActionMoveToObject(oBearWP5, FALSE, 1.0)));
		 DelayCommand(6.0, AssignCommand(oBear, ActionMoveToObject(oBearWP3, FALSE, 1.0)));
		 DelayCommand(7.0, AssignCommand(oBear, ActionAttack(oBearWP3)));
		 DelayCommand(8.0, AssignCommand(oBear, ActionMoveToObject(oBearWP1, FALSE, 1.0)));
		 DelayCommand(10.0, AssignCommand(oBear, ActionMoveToObject(OBJECT_SELF, FALSE, 1.0)));
		 DelayCommand(11.0, AssignCommand(oBear, SetFacing(DIRECTION_SOUTH, FALSE)));
		 
		 DelayCommand(2.0, AssignCommand(OBJECT_SELF, ActionMoveToObject(oBearWP4, FALSE, 1.0)));
		 DelayCommand(3.0, AssignCommand(OBJECT_SELF, ActionMoveToObject(oBearWP3, FALSE, 1.0)));
		 DelayCommand(4.0, AssignCommand(OBJECT_SELF, ActionMoveToObject(oBearWP2, FALSE, 1.0)));
		 DelayCommand(5.0, AssignCommand(OBJECT_SELF, ActionMoveToObject(oBearWP5, FALSE, 1.0)));
		 DelayCommand(6.0, AssignCommand(OBJECT_SELF, ActionMoveToObject(oBearWP3, FALSE, 1.0)));
		 DelayCommand(7.0, AssignCommand(OBJECT_SELF, ActionAttack(oBearWP3)));
		 DelayCommand(10.0, AssignCommand(OBJECT_SELF, ActionMoveToObject(oBearWP3, FALSE, 1.0)));
		 DelayCommand(11.0, AssignCommand(OBJECT_SELF, SetFacing(DIRECTION_NORTH, FALSE)));
		 DelayCommand(12.0, AssignCommand(OBJECT_SELF, ActionPlayAnimation(ANIMATION_LOOPING_GUITARPLAY, 1.0, 5.0)));
		 DelayCommand(12.0, AssignCommand(OBJECT_SELF, PlaySound("as_cv_lute1", FALSE)));
		 
		 DelayCommand(12.0, AssignCommand(oBear, ActionPlayAnimation(ANIMATION_FIREFORGET_DODGE_DUCK, 1.0, 2.0)));
		 DelayCommand(13.0, AssignCommand(oBear, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT, 1.0, 2.0)));
		 DelayCommand(15.0, AssignCommand(oBear, ActionPlayAnimation(ANIMATION_FIREFORGET_DODGE_DUCK, 1.0, 2.0)));
		 DelayCommand(16.0, AssignCommand(oBear, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT, 1.0, 2.0)));
		 DelayCommand(17.0, AssignCommand(oBear, ActionPlayAnimation(ANIMATION_FIREFORGET_DODGE_DUCK, 1.0, 2.0)));
		 DelayCommand(18.0, AssignCommand(oBear, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT, 1.0, 2.0)));
		 DelayCommand(19.0, AssignCommand(oBear, ActionPlayAnimation(ANIMATION_FIREFORGET_DODGE_DUCK, 1.0, 2.0)));
		 
		 DelayCommand(20.0, AssignCommand(oBear, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT, 1.0, 2.0)));
		 DelayCommand(20.0, AssignCommand(OBJECT_SELF, ActionPlayAnimation(ANIMATION_LOOPING_DANCE03, 1.0, 2.0)));
		 
		 DelayCommand(21.0, AssignCommand(oBear, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT, 1.0, 2.0)));
		 DelayCommand(21.0, AssignCommand(OBJECT_SELF, ActionPlayAnimation(ANIMATION_FIREFORGET_BARDSONG, 1.0, 2.0)));
		 
		 DelayCommand(22.0, AssignCommand(oBear, ActionPlayAnimation(ANIMATION_FIREFORGET_DODGE_DUCK, 1.0, 2.0)));
		 DelayCommand(22.0, AssignCommand(OBJECT_SELF, ActionPlayAnimation(ANIMATION_FIREFORGET_KNEELTALK, 1.0, 2.0)));
		 
		 DelayCommand(23.0, AssignCommand(oBear, ActionPlayAnimation(ANIMATION_FIREFORGET_DODGE_DUCK, 1.0, 2.0)));
		 DelayCommand(23.0, AssignCommand(OBJECT_SELF, ActionPlayAnimation(ANIMATION_LOOPING_DANCE03, 1.0, 2.0)));
		 
		 DelayCommand(24.0, AssignCommand(oBear, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT, 1.0, 2.0)));
		 DelayCommand(24.0, AssignCommand(OBJECT_SELF, ActionPlayAnimation(ANIMATION_FIREFORGET_BARDSONG, 1.0, 2.0)));
		 
		 DelayCommand(25.0, AssignCommand(oBear, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT, 1.0, 2.0)));
		 DelayCommand(25.0, AssignCommand(OBJECT_SELF, ActionPlayAnimation(ANIMATION_LOOPING_DANCE03, 1.0, 2.0)));
		 DelayCommand(25.0, AssignCommand(OBJECT_SELF, PlaySound("as_cv_lute1", FALSE)));
		 
		 DelayCommand(26.0, AssignCommand(OBJECT_SELF, ActionMoveToObject(oBearWP2, FALSE, 1.0)));
		 DelayCommand(28.0, AssignCommand(OBJECT_SELF, ActionMoveToObject(oBearWP3, FALSE, 1.0)));
		 DelayCommand(30.0, AssignCommand(OBJECT_SELF, ActionMoveToObject(oBearWP4, FALSE, 1.0)));
		 DelayCommand(32.0, AssignCommand(OBJECT_SELF, ActionMoveToObject(oBearWP5, FALSE, 1.0)));
		 DelayCommand(34.0, AssignCommand(OBJECT_SELF, ActionMoveToObject(oBear, FALSE, 1.0)));
		 DelayCommand(36.0, AssignCommand(OBJECT_SELF, ActionAttack(oBearWP3)));
		 DelayCommand(41.0, AssignCommand(OBJECT_SELF, SetFacing(DIRECTION_SOUTH, FALSE)));
		 DelayCommand(42.0, AssignCommand(OBJECT_SELF, ActionPlayAnimation(ANIMATION_LOOPING_GUITARPLAY, 1.0, 5.0)));
		 DelayCommand(42.0, AssignCommand(OBJECT_SELF, PlaySound("as_cv_lute1", FALSE)));
		 
		 DelayCommand(26.0, AssignCommand(oBear, ActionMoveToObject(oBearWP4, FALSE, 1.0)));
		 DelayCommand(28.0, AssignCommand(oBear, ActionMoveToObject(oBearWP3, FALSE, 1.0)));
		 DelayCommand(30.0, AssignCommand(oBear, ActionMoveToObject(oBearWP2, FALSE, 1.0)));
		 DelayCommand(32.0, AssignCommand(oBear, ActionMoveToObject(oBearWP5, FALSE, 1.0)));
		 DelayCommand(34.0, AssignCommand(oBear, ActionMoveToObject(OBJECT_SELF, FALSE, 1.0)));
		 DelayCommand(36.0, AssignCommand(oBear, ActionAttack(oBearWP3)));
		 DelayCommand(38.0, AssignCommand(oBear, ActionMoveToObject(oBearWP3, FALSE, 1.0)));
		 DelayCommand(40.0, AssignCommand(oBear, ActionMoveToObject(OBJECT_SELF, FALSE, 1.0)));
		 DelayCommand(41.0, AssignCommand(oBear, SetFacing(DIRECTION_NORTH, FALSE)));
		 
		 DelayCommand(44.0, AssignCommand(oBear, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT, 1.0, 2.0)));
		 DelayCommand(44.0, AssignCommand(OBJECT_SELF, ActionPlayAnimation(ANIMATION_LOOPING_DANCE03, 1.0, 2.0)));
		 
		 DelayCommand(45.0, AssignCommand(oBear, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT, 1.0, 2.0)));
		 DelayCommand(45.0, AssignCommand(OBJECT_SELF, ActionPlayAnimation(ANIMATION_FIREFORGET_BARDSONG, 1.0, 2.0)));
		 
		 DelayCommand(46.0, AssignCommand(oBear, ActionPlayAnimation(ANIMATION_FIREFORGET_DODGE_DUCK, 1.0, 2.0)));
		 DelayCommand(46.0, AssignCommand(OBJECT_SELF, ActionPlayAnimation(ANIMATION_FIREFORGET_KNEELTALK, 1.0, 2.0)));
		 
		 DelayCommand(47.0, AssignCommand(oBear, ActionPlayAnimation(ANIMATION_FIREFORGET_DODGE_DUCK, 1.0, 2.0)));
		 DelayCommand(47.0, AssignCommand(OBJECT_SELF, ActionPlayAnimation(ANIMATION_LOOPING_DANCE03, 1.0, 2.0)));
		 
		 DelayCommand(48.0, AssignCommand(oBear, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT, 1.0, 2.0)));
		 DelayCommand(48.0, AssignCommand(OBJECT_SELF, ActionPlayAnimation(ANIMATION_FIREFORGET_BARDSONG, 1.0, 2.0)));
		 
		 DelayCommand(49.0, AssignCommand(oBear, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT, 1.0, 2.0)));
		 DelayCommand(49.0, AssignCommand(OBJECT_SELF, ActionPlayAnimation(ANIMATION_LOOPING_DANCE03, 1.0, 2.0)));
		 
		 DelayCommand(50.0, AssignCommand(OBJECT_SELF, PlaySound("as_cv_lute1", FALSE)));
		 DelayCommand(50.0, AssignCommand(oBear, ActionMoveToObject(oBearWP2, FALSE, 1.0)));
		 DelayCommand(52.0, AssignCommand(oBear, ActionMoveToObject(oBearWP3, FALSE, 1.0)));
		 DelayCommand(54.0, AssignCommand(oBear, ActionMoveToObject(oBearWP4, FALSE, 1.0)));
		 DelayCommand(56.0, AssignCommand(oBear, ActionMoveToObject(oBearWP5, FALSE, 1.0)));
		 DelayCommand(58.0, AssignCommand(oBear, ActionMoveToObject(OBJECT_SELF, FALSE, 1.0)));
		 DelayCommand(60.0, AssignCommand(oBear, ActionAttack(oBearWP3)));
		 DelayCommand(62.0, AssignCommand(oBear, ActionMoveToObject(oBearWP1, FALSE, 1.0)));
		 DelayCommand(63.0, AssignCommand(oBear, SetFacing(DIRECTION_SOUTH, FALSE)));
		 
		 DelayCommand(50.0, AssignCommand(OBJECT_SELF, ActionMoveToObject(oBearWP4, FALSE, 1.0)));
		 DelayCommand(52.0, AssignCommand(OBJECT_SELF, ActionMoveToObject(oBearWP3, FALSE, 1.0)));
		 DelayCommand(54.0, AssignCommand(OBJECT_SELF, ActionMoveToObject(oBearWP2, FALSE, 1.0)));
		 DelayCommand(56.0, AssignCommand(OBJECT_SELF, ActionMoveToObject(oBearWP5, FALSE, 1.0)));
		 DelayCommand(58.0, AssignCommand(OBJECT_SELF, ActionMoveToObject(oBear, FALSE, 1.0)));
		 DelayCommand(60.0, AssignCommand(OBJECT_SELF, ActionAttack(oBearWP3)));
		 DelayCommand(62.0, AssignCommand(OBJECT_SELF, ActionMoveToObject(oBearWP3, FALSE, 1.0)));
		 DelayCommand(63.0, AssignCommand(OBJECT_SELF, SetFacing(DIRECTION_SOUTH, FALSE)));
		 DelayCommand(64.0, AssignCommand(OBJECT_SELF, ActionPlayAnimation(ANIMATION_LOOPING_GUITARPLAY, 1.0, 2.0)));
		 DelayCommand(64.0, AssignCommand(OBJECT_SELF, PlaySound("as_cv_lute1", FALSE)));
		 
		 DelayCommand(66.0, AssignCommand(OBJECT_SELF, ActionPlayAnimation(ANIMATION_FIREFORGET_BOW, 1.0, 5.0)));
		 DelayCommand(67.0, ActionSpeakString("Our waltz is over; our dance card empty. Another coin buys another dance!", TALKVOLUME_TALK));
		 }
	
		
	//Snake Charmer
	if(GetTag(OBJECT_SELF) == "003_cr_circus_master_snakes")
		{string sCreature = GetLocalString(OBJECT_SELF, "circus_master");
		 string sCreature2 = GetLocalString(OBJECT_SELF, "circus_master2");
		 location lCreate = GetLocation(GetWaypointByTag(sCreature + "_create"));
		 object oSnake=CreateObject(OBJECT_TYPE_CREATURE, sCreature, lCreate);
		 object oSnake2=CreateObject(OBJECT_TYPE_CREATURE, sCreature2, lCreate);
		 DelayCommand(2.0, ActionSpeakString("Dance, my pets.", TALKVOLUME_TALK));
		 DelayCommand(3.0, PlayAnimation(ANIMATION_LOOPING_FLUTEPLAY, 1.0, 3.0));
		 DelayCommand(3.0, AssignCommand(OBJECT_SELF, PlaySound("as_cv_flute1", FALSE)));
		 
		 DelayCommand(5.0, AssignCommand(oSnake, ActionAttack(oSnake2)));
		 DelayCommand(6.0, AssignCommand(oSnake2, ActionAttack(oSnake)));
		 DelayCommand(7.0, AssignCommand(oSnake, ActionAttack(oSnake2)));
		 DelayCommand(8.0, AssignCommand(oSnake2, ActionAttack(oSnake)));
		 DelayCommand(9.0, AssignCommand(oSnake, ActionAttack(oSnake2)));
		 DelayCommand(10.0, AssignCommand(oSnake2, ActionAttack(oSnake)));
		 DelayCommand(11.0, PlayAnimation(ANIMATION_LOOPING_FLUTEPLAY, 1.0, 3.0));
		 DelayCommand(12.0, AssignCommand(OBJECT_SELF, PlaySound("as_cv_flute1", FALSE)));
		 
		 DelayCommand(23.0, PlayAnimation(ANIMATION_LOOPING_FLUTEPLAY, 1.0, 3.0));
		 DelayCommand(24.0, AssignCommand(OBJECT_SELF, PlaySound("as_cv_flute1", FALSE)));
		 DelayCommand(25.0, AssignCommand(oSnake, ActionAttack(oSnake2)));
		 DelayCommand(26.0, AssignCommand(oSnake2, ActionAttack(oSnake)));
		 DelayCommand(27.0, AssignCommand(oSnake, ActionAttack(oSnake2)));
		 DelayCommand(28.0, AssignCommand(oSnake2, ActionAttack(oSnake)));
		 DelayCommand(29.0, AssignCommand(oSnake, ActionAttack(oSnake2)));
		 DelayCommand(30.0, AssignCommand(oSnake2, ActionAttack(oSnake)));
		 DelayCommand(30.0, PlayAnimation(ANIMATION_LOOPING_FLUTEPLAY, 1.0, 3.0));
		 DelayCommand(31.0, AssignCommand(OBJECT_SELF, PlaySound("as_cv_flute1", FALSE)));
		 
		 DelayCommand(31.0, AssignCommand(oSnake, ActionForceMoveToLocation(lCreate, FALSE, 30.0)));
		 DelayCommand(31.5, AssignCommand(oSnake2, ActionForceMoveToLocation(lCreate, FALSE, 30.0)));
		 
		 
		 DestroyObject(oSnake, 35.0);
		 DestroyObject(oSnake2, 35.0);
		 DelayCommand(31.0, ActionSpeakString("*Perhaps for more gold they might dance longer. *Unctuous grin with hand held out.*", TALKVOLUME_TALK));
		 }
		

	//Sword Swallower
   	if(GetTag(OBJECT_SELF) == "003_cr_circus_sw_swallow")
		{ActionPlayAnimation(ANIMATION_LOOPING_WORSHIP, 1.0, 1.0);
		 location lStart=GetLocation(GetWaypointByTag("swordswallow_start"));
		 location lSword;
		 object oSword1=GetWaypointByTag("circus_sword1");
		 location lSword1=GetLocation(oSword1);
		 object oSword2=GetWaypointByTag("circus_sword2");
		 location lSword2=GetLocation(oSword2);
		 object oSword3=GetWaypointByTag("circus_sword3");
		 location lSword3=GetLocation(oSword3);
		 object oSword4=GetWaypointByTag("circus_sword4");
		 location lSword4=GetLocation(oSword4);
		 object oSword5=GetWaypointByTag("circus_sword5");
		 location lSword5=GetLocation(oSword5);
		 int nIncrement= 1 + GetLocalInt(OBJECT_SELF, "nIncrement");
		 SetLocalInt(OBJECT_SELF, "nIncrement", nIncrement);
		 DestroyObject(GetObjectByTag("circus_sword_swallow_plc", 0));
		 object oSwordInv=GetItemPossessedBy(OBJECT_SELF, "abr_it_wpn_scimitar");
			  
		  
		 if(nIncrement == 1)
			 {ActionForceMoveToLocation(lStart, FALSE);
		 	  DelayCommand(1.0, ActionJumpToLocation(lStart));
		 	  DelayCommand(2.0, ActionUnequipItem(oSwordInv));
			  DelayCommand(3.0, SetFacing(DIRECTION_NORTH));
		 	  DelayCommand(4.0, ActionPlayAnimation(ANIMATION_LOOPING_WORSHIP, 1.0, 1.0));
		      DelayCommand(5.0, ExecuteScript("circus_npc_conv_execute1", OBJECT_SELF));
			 }
		 else if((nIncrement < 11) && (nIncrement > 1))
		 	{if((nIncrement==2)||(nIncrement==10))
				{lSword=lSword1;}
			 if((nIncrement==3)||(nIncrement==9))
				{lSword=lSword2;}
			 if((nIncrement==4)||(nIncrement==8))
				{lSword=lSword3;}
			 if((nIncrement==5)||(nIncrement==7))
				{lSword=lSword4;}
			 if(nIncrement==6)
				{lSword=lSword5;}
			 PlayAnimation(ANIMATION_LOOPING_WORSHIP, 1.0, 2.0);
			 ActionWait(2.0);
			 ActionCreateWynPlace("circus_sword_swallow_plc", lSword);
			 DelayCommand(2.0, ExecuteScript("circus_npc_conv_execute1", OBJECT_SELF));
			 }
		else if(nIncrement == 11)
			{SetLocalInt(OBJECT_SELF, "nIncrement", 0);
			 SpeakString("*Bending backwards, inserts sword blade into mouth, carefully, the shiny blade descending an astonishing distance. Pulls it free, unbloodied, and sheathes it with a flourish.", TALKVOLUME_TALK);
		 	 ActionEquipItem(oSwordInv, INVENTORY_SLOT_RIGHTHAND);
			 PlayAnimation(ANIMATION_FIREFORGET_SALUTE, 1.0, 1.0);
		         
			}
		}
	
	
}			 			 