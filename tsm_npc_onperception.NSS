////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ACR Configuration File
//     Filename : acf_cre_onperception
//    $Revision:: 280        $ current version of the file
//        $Date:: 2007-03-20#$ date the file was created or modified
//       Author : Cipher
//
//    Var Prefix:
//  Dependencies:
//
//  Description
//  This script calls the ACR's OnPerception event handler for creatures
//  and any custom code a server may need. It is not updated in ACR updates.
//
//  Revision History
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Constants ///////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Structures //////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Global Variables ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Function Prototypes /////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Function Definitions ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#include "acr_creature_i"
#include "acr_quest_i"


 
void main()
{
    ACR_CreatureOnPerception();
	object oPerceived = GetLastPerceived();
	
	if((GetTag(OBJECT_SELF) == "abr_cr_hu_duergarsap_03") || (GetTag(OBJECT_SELF) == "abr_cr_hu_duergarsap_03b"))  {
		//SendMessageToAllDMs("Debug: Duergar Sapper = " + GetTag(OBJECT_SELF));
		object oBomb = GetItemPossessedBy(OBJECT_SELF, "abr_it_msc_firebomb");
		object oAlchFire = GetItemPossessedBy(OBJECT_SELF, "abr_it_msc_alchfire");
	    if(((GetIsPC(oPerceived) || (GetIsDMPossessed(oPerceived))))  && (GetLocalString(OBJECT_SELF, GetName(oPerceived)) != "Bombed")) {
			SetLocalString(OBJECT_SELF, GetName(oPerceived), "Bombed");
			//SendMessageToAllDMs("Debug: " + GetTag(OBJECT_SELF) + " perceives " + GetName(oPerceived));
		    if(oBomb != OBJECT_INVALID) {
			    //SendMessageToAllDMs("Debug: " + GetTag(OBJECT_SELF) + " has bomb ");
				DelayCommand(1.0, SpawnSpellProjectile(OBJECT_SELF, oPerceived, GetLocation(OBJECT_SELF), GetLocation(oPerceived), 744, PROJECTILE_PATH_TYPE_DEFAULT));
				DelayCommand(3.0, DoGrenade(d6(10),1, VFX_IMP_FLAME_M, VFX_FNF_FIREBALL,DAMAGE_TYPE_FIRE,RADIUS_SIZE_HUGE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE));
	            DelayCommand(3.0, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectAreaOfEffect(AOE_PER_FOGFIRE), GetLocation(oPerceived), RoundsToSeconds(5)));
	    		DestroyObject(oBomb);
				}
			else if(oAlchFire != OBJECT_INVALID) {
				//SendMessageToAllDMs("Debug: " + GetTag(OBJECT_SELF) + " has alchemist's fire ");
				DelayCommand(1.0, SpawnSpellProjectile(OBJECT_SELF, oPerceived, GetLocation(OBJECT_SELF), GetLocation(oPerceived), 744, PROJECTILE_PATH_TYPE_DEFAULT));
				DelayCommand(3.0, DoGrenade(d6(2),1, VFX_IMP_FLAME_M, VFX_FNF_FIREBALL,DAMAGE_TYPE_FIRE,RADIUS_SIZE_HUGE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE));
	            DelayCommand(3.0, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectAreaOfEffect(AOE_PER_FOGFIRE), GetLocation(oPerceived), RoundsToSeconds(5)));
	    		DestroyObject(oAlchFire);
				}
			}
		}
	
	
		//KiS Static_03		 
		if(GetTag(OBJECT_SELF) == "003_cr_kis_atarms_parade") 
			{if((GetIsPC(GetLastPerceived())) && (ACR_RetrieveQuestState("kis_combat_03", GetLastPerceived()) == 2))
				{object oSubdue = GetLastPerceived();
				 ActionForceMoveToObject(oSubdue, TRUE, 0.0);
				 if(_GetNLDMode(OBJECT_SELF) == FALSE)
				 	{ACR_ToggleNLDMode(OBJECT_SELF);
					 }
			 if((_GetNLDState(oSubdue) != 2) && (GetLocalInt(oSubdue, "kis_combat_03_win") < 5))
				  	{ActionMoveToObject(oSubdue, TRUE, 1.0);
					 ActionAttack(oSubdue, FALSE);
					 }
				}
			 
			else
				{if(GetIsEnemy(GetLastPerceived()))
					{ClearAllActions(FALSE);
					 object oEnemy = GetLastPerceived();
					 if(_GetNLDMode(OBJECT_SELF) == FALSE)
					 	{ACR_ToggleNLDMode(OBJECT_SELF);
						 }
			 		ActionAttack(oEnemy, FALSE);
					 }
				}
			}
	
 if((Random(10)==1) && ((FindSubString(GetTag(OBJECT_SELF), "deneir") != -1) || (FindSubString(GetTag(OBJECT_SELF), "vos_scribe") != -1)) && (GetIsEnemy(oPerceived)) && (GetIsPC(oPerceived))) 
	{string sLibrary = "";
	 int nRandLib = Random(4);
	 if(nRandLib == 1) {
	  	sLibrary = "Shhhh!";
		}
	 else if(nRandLib == 2) {
	  	sLibrary = "You have overdue scribing fees!";
		}
	 else if(nRandLib == 3) {
	  	sLibrary = "No materials may be taken from the Vault!";
		}
	  else if(nRandLib == 4) {
	  	sLibrary = "I said, keep your voice down!";
		}
	
	}			
			
			
  if((Random(3)==1) && (GetLocalInt(oPerceived, "Perceived" + GetTag(OBJECT_SELF)) != 1) && (FindSubString(GetTag(OBJECT_SELF), "03_silvy_commoner") != -1) && (GetIsPC(oPerceived))) 
	{
	
	object oNearest = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC, OBJECT_SELF, 1);
	 if((!GetIsDM(oNearest)) && (!GetIsPC(oNearest)) &&(GetDistanceBetween(OBJECT_SELF, oNearest) < 20.0 ) )
		 {ActionForceMoveToObject(oNearest, FALSE, 1.0, 30.0);
		  DelayCommand(3.0, AssignCommand(oNearest, SetFacingPoint(GetPositionFromLocation(GetLocation(OBJECT_SELF)))));
		  DelayCommand(3.2, SetFacingPoint(GetPositionFromLocation(GetLocation(oNearest))));
	      DelayCommand(10.0, AssignCommand(oNearest, SetFacingPoint(GetPositionFromLocation(GetLocation(OBJECT_SELF)))));
		  DelayCommand(10.2, SetFacingPoint(GetPositionFromLocation(GetLocation(oNearest))));
	      DelayCommand(11.0, ActionWait(30.0));
		  }
		int nRandomPerception = Random(200);
		string sDay;
	    if(GetIsDay())
	     {sDay = "day.";}
	    else
	     {sDay = "evening.";}
    	
		string sHeardFrom = "He";
		int nRandomHeardFrom = Random(21);
		if(nRandomHeardFrom == 1)
			{sHeardFrom = "She";}
		if(nRandomHeardFrom == 2)
			{sHeardFrom = "My son";}
		if(nRandomHeardFrom == 3)
			{sHeardFrom = "My daughter";}
		if(nRandomHeardFrom == 4)
			{sHeardFrom = "My sister";}
		if(nRandomHeardFrom == 5)
			{sHeardFrom = "My brother";}
		if(nRandomHeardFrom == 6)
			{sHeardFrom = "My mother";}
		if(nRandomHeardFrom == 7)
			{sHeardFrom = "My father";}
		if(nRandomHeardFrom == 8)
			{sHeardFrom = "My grandmother";}
		if(nRandomHeardFrom == 9)
			{sHeardFrom = "My grandfather";}
		if(nRandomHeardFrom == 10)
			{sHeardFrom = "My children";}
		if(nRandomHeardFrom == 11)
			{sHeardFrom = "The constables";}
		if(nRandomHeardFrom == 12)
			{sHeardFrom = "A Knight in Silver";}
		if(nRandomHeardFrom == 13)
			{sHeardFrom = "A spellguard";}
		if(nRandomHeardFrom == 14)
			{sHeardFrom = "A shopkeeper";}
		if(nRandomHeardFrom == 15)
			{sHeardFrom = "Katrinia";}
		if(nRandomHeardFrom == 16)
			{sHeardFrom = "Myra";}
		if(nRandomHeardFrom == 17)
			{sHeardFrom = "A scribe at the Vault of Sages";}
		if(nRandomHeardFrom == 18)
			{sHeardFrom = "A student at the Lady's College";}
		if(nRandomHeardFrom == 19)
			{sHeardFrom = "Someone who works at the Palace";}
		if(nRandomHeardFrom == 20)
			{sHeardFrom = "A guard at the city gate over there";}
		
		string sRandomMonster = "monsters";
		int nRandomMonster = Random(20);
		if(nRandomMonster == 1)
			{sRandomMonster = "orcs";}
		if(nRandomMonster == 2)
			{sRandomMonster = "kobolds";}
		if(nRandomMonster == 3)
			{sRandomMonster = "goblins";}
		if(nRandomMonster == 4)
			{sRandomMonster = "wolves";}
		if(nRandomMonster == 5)
			{sRandomMonster = "little devils";}
		if(nRandomMonster == 6)
			{sRandomMonster = "little demons";}
		if(nRandomMonster == 7)
			{sRandomMonster = "a dragon";}
		if(nRandomMonster == 8)
			{sRandomMonster = "a man that was half horse";}
		if(nRandomMonster == 9)
			{sRandomMonster = "something that was half bull";}
		if(nRandomMonster == 10)
			{sRandomMonster = "drow";}
		if(nRandomMonster == 11)
			{sRandomMonster = "a bloody great tree that could walk";}
		if(nRandomMonster == 12)
			{sRandomMonster = "werewolves";}
		if(nRandomMonster == 13)
			{sRandomMonster = "little winged people";}
		if(nRandomMonster == 14)
			{sRandomMonster = "something made of water";}
		if(nRandomMonster == 15)
			{sRandomMonster = "something that healed him";}
		if(nRandomMonster == 16)
			{sRandomMonster = "gigantic winged women";}
		if(nRandomMonster == 17)
			{sRandomMonster = "a unicorn";}
		if(nRandomMonster == 18)
			{sRandomMonster = "something that shrieked so loud the blood ran cold and froze anybody in hearing";}
		if(nRandomMonster == 19)
			{sRandomMonster = "a bird made of fire";}
		if(nRandomMonster == 20)
			{sRandomMonster = "something made entirely of stone, but moving";}
		
		string sRandomCity = "Silverymoon";
		int nRandomCity = Random(20);
		if(nRandomCity == 1)
			{sRandomCity = "the Mulgate";}
		if(nRandomCity == 2)
			{sRandomCity = "the Blacklar Gate";}
		if(nRandomCity == 3)
			{sRandomCity = "the Moorgate";}
		if(nRandomCity == 4)
			{sRandomCity = "Rivermoot";}
		if(nRandomCity == 5)
			{sRandomCity = "High Hold";}
		if(nRandomCity == 6)
			{sRandomCity = "Sundabar";}
		if(nRandomCity == 7)
			{sRandomCity = "Everlund";}
		if(nRandomCity == 8)
			{sRandomCity = "the Evermoors";}
		if(nRandomCity == 9)
			{sRandomCity = "Quaervar";}
		if(nRandomCity == 10)
			{sRandomCity = "the edge of the High Forest";}
		if(nRandomCity == 11)
			{sRandomCity = "the lake in the Moonwood";}
		if(nRandomCity == 12)
			{sRandomCity = "Winter's Edge";}
		if(nRandomCity == 13)
			{sRandomCity = "Settlestone";}
		if(nRandomCity == 14)
			{sRandomCity = "Fourthpeak";}
		if(nRandomCity == 15)
			{sRandomCity = "Citadel Felbarr";}
		if(nRandomCity == 16)
			{sRandomCity = "the north part of the Moonwood";}
		if(nRandomCity == 17)
			{sRandomCity = "the Silverwood";}
		if(nRandomCity == 18)
			{sRandomCity = "Khelb";}
		if(nRandomCity == 19)
			{sRandomCity = "Silverymoon Pass";}
		if(nRandomCity == 20)
			{sRandomCity = "the high peaks of the Nether Mountains";}
		
		if(nRandomPerception < 69) {
			SetLocalInt(oPerceived, "Perceived" + GetTag(OBJECT_SELF), 1);
			if(nRandomPerception < 10)
				{ActionPlayAnimation(ANIMATION_FIREFORGET_GREETING, 1.0);
				 }
			else if(nRandomPerception < 30)
				{DelayCommand(IntToFloat(Random(5)), ActionSpeakString("Hello.", TALKVOLUME_TALK));
				 }
			else if(nRandomPerception < 50)
				{DelayCommand(IntToFloat(Random(5)), ActionSpeakString("Good " + sDay + ".", TALKVOLUME_TALK));
				 }
			else if(nRandomPerception < 55)
				{DelayCommand(IntToFloat(Random(5)), ActionSpeakString("Did you hear? " + sHeardFrom + " said somebody saw " + sRandomMonster + " near " + sRandomCity, TALKVOLUME_TALK));
				 }
			else if(nRandomPerception < 60)
				{DelayCommand(IntToFloat(Random(5)), ActionSpeakString(sHeardFrom + " got hired on at the circus.", TALKVOLUME_TALK));
				 }
			else if(nRandomPerception < 65)
				{DelayCommand(IntToFloat(Random(5)), ActionSpeakString(sHeardFrom + " saw some of those acts when it was passing through " + sRandomCity + ".", TALKVOLUME_TALK));
				 }
			else if(nRandomPerception < 67)
				{DelayCommand(IntToFloat(Random(5)), ActionSpeakString("I heard an imp escaped from the circus last night and is loose in the city!", TALKVOLUME_TALK));
				 }
			else if(nRandomPerception < 69)
				{DelayCommand(IntToFloat(Random(5)), ActionSpeakString(sHeardFrom + " said that the Palace sent investigators to the circus for some reason!", TALKVOLUME_TALK));
				 }
			} 
		
	}			
		
	if((Random(3)==1) && (GetLocalInt(OBJECT_SELF, "Singing") != 1) && (FindSubString(GetTag(OBJECT_SELF), "003_npc_bard") != -1) && ((GetIsPC(oPerceived)) || (GetIsDMPossessed(oPerceived)))) 
		{SetLocalInt(OBJECT_SELF, "Singing", 1);
		 DelayCommand(600.00, SetLocalInt(OBJECT_SELF, "Singing", 0));
		 
		 string sVerseA = "";
		 string sVerseB = "";
		 string sVerseC = "";
		 string sVerseD = "";
		 string sVerseE = "";
		 string sVerseF = "";
		 string sVerseG = "";
		 string sVerseH = "";
		 string sVerseI = "";
		 string sVerseJ = "";
		 string sVerseK = "";
		 string sVerseL = "";
		 string sVerseM = "";
		 string sVerseN = "";
		 string sVerseO = "";
		 string sVerseP = "";
		 string sVerseQ = "";
		 string sVerseR = "";
		 string sVerseS = "";
		 string sVerseT = "";
		 string sVerseU = "";
		 string sVerseV = "";
		 string sVerseW = "";
		 string sVerseX = "";
		 string sVerseY = "";
		 string sVerseZ = "";
		 string sVerseAA = "";
		 string sVerseAB = "";
		 string sVerseAC = "";
		 string sVerseAD = "";
		 string sVerseAE = "";
		 string sVerseAF = "";
		 string sVerseAG = "";
		 string sVerseAH = "";
		 string sVerseAI = "";
		 string sVerseAJ = "";
		 string sVerseAK = "";
		 string sVerseAL = "";
		 string sVerseAM = "";
		 string sVerseAN = "";
		 string sVerseAO = "";
		 string sVerseAP = "";
		 string sVerseAQ = "";
		 string sVerseAR = "";
		 string sVerseAS = "";
		 string sVerseAT = "";
		 string sVerseAU = "";
		 string sVerseAV = "";
		 string sVerseAW = "";
		 string sVerseAX = "";
		 string sVerseAY = "";
		 
		 
		 
		switch(Random(20)) {
        case 0:
				
			sVerseA = "What I feel like singing mostly";
			sVerseB = "Are songs that are dark and ghostly.";
			sVerseC = "So, gather round while there's no sun";
			sVerseD = "I think I'd like to sing you one.";
			sVerseE = "This tale begins as these tales do,";
			sVerseF = "Except for just a very few,";
			
			sVerseG = "With a good couple's country life";
			sVerseH = "And ending with a murdered wife.";
			sVerseI = "She nagged her man all day and night";
			sVerseJ = "And gave him quite a nasty fright.";
			sVerseK = "All this before he rose from bed.";
			sVerseL = "All this before he made her dead.";
			
			sVerseM = "Now gone, her spirits onward living";
			sVerseN = "And firm lectures she's still giving.";
			sVerseO = "Now husband heeds her more than before";
			sVerseP = "Cause she can pass through walls and floor.";
			sVerseQ = "He can't escape her as he'd thought.";
			sVerseR = "His evil action was for naught.";
			
			sVerseS = "So now he ponders on his wife";
			sVerseT = "And wishes she were back to life.";
			sVerseU = "At least then she would have to sleep";
			sVerseV = "And he could then through the doors creep,";
			sVerseW = "Hark back to when he'd drink some ale";
			sVerseX = "And he, not her, would moan and wail.";
			
			break;
			
        case 1:
	        sVerseA = "A lovely miss, the robust sort,";
			sVerseB = "Came struttin’ past the tavern’s guests";
			sVerseC = "And when she caught some doltish boor";
			sVerseD = "Staring at her breasts,";
			
			sVerseE = "She sighed and approached him, oh, so wantonly";
			
			sVerseF = "And . . .";
			
			sVerseG = "kneed him in the stones!";
			
			sVerseH = "She kneed him in the stones!";
			sVerseI = "Oh, my word";
			sVerseJ = "You should have heard";
			sVerseK = "The curses and the groans.";
			sVerseL = "She used her natural armament";
			sVerseM = "And kneed him in the stones!";
			
			sVerseN = "A tenday thence, upon the road,";
			sVerseO = "Where trees and men were sparse,";
			sVerseP = "She noticed an ogling traveler";
			sVerseQ = "Staring at her arse.";
			
			sVerseR = "She sighed and approached him, oh, so tauntingly";
			
			sVerseS = "And . . .";
			
			sVerseT = "Kneed him in the crotch!";
			
			sVerseU = "She kneed him in the crotch!";
			sVerseV = "Oh, my queen";
			sVerseW = "You should have seen";
			sVerseX = "The delivery – top notch.";
			sVerseY = "She used what Sune had given her";
			sVerseZ = "And kneed him in the crotch!";
			
			sVerseAA = "It wasn’t long - her fame had spread -";
			sVerseAB = "The king, though slightly cuckoo,";
			sVerseAC = "Summoned her forth, but couldn’t help";
			sVerseAD = "Just staring at her hoo hoo.";
			
			sVerseAE = "She sighed again, our lovely miss,";
			sVerseAF = "But this time, oh, so flirtatiously,";
			sVerseAG = "Approached his royal highness";
			sVerseAH = "And . . . 	";
			
			sVerseAI = "Kneed him in the pickle!";
			
			sVerseAJ = "She kneed him in the pickle!";
			sVerseAK = "The rudest kiss,";
			sVerseAL = "She didn’t miss.";
			sVerseAM = "It wasn’t meant to tickle.";
			sVerseAN = "To hell with courtly dignity!";
			sVerseAO = "She kneed him in the pickle!";
            break;
			
        case 2:
			sVerseA = "Nine were conveyed to a land made of ice";
			sVerseB = "Tasked to retrieve a rare, orb-like device";
			sVerseC = "One, as he stepped through the magical gate,";
			sVerseD = "Tripped as it shuttered and then there were eight.";
			
			sVerseE = "Eight steadfast arrived in a land made of ice";
			sVerseF = "And though she was warned not just once but twice –";
			sVerseG = "We’ll miss that dear rogue for now she’s in heav’n –";
			sVerseH = "She slipped on the edge and now there were sev’n.";
			
			sVerseI = "Seven, more cautious, in a land made of ice,";
			sVerseJ = "All concluding, ‘this is no paradise,’";
			sVerseK = "Ambushed, they were, by three hungry frost ticks.";
			sVerseL = "Of one, they made lunch, and now there were six.";
			
			sVerseM = "Six found a door, in a land made of ice –";
			sVerseN = "A temple discovered, they moved in a thrice.";
			sVerseO = "They didn’t quite notice – in hopes they’d survive –";
			sVerseP = "The trap that exploded, and then there were five.";
			
			sVerseQ = "Five entered the gloom in the land made of ice,";
			sVerseR = "Careful to follow their map, made precise.";
			sVerseS = "Appeared then a demon; they all did implore,";
			sVerseT = "‘Please spare us.’ He didn’t and now there were four.";
			
			sVerseU = "Four stalwart seekers in a land made of ice";
			sVerseV = "Forged ever onward as one gave advice,";
			sVerseW = "‘keep your eyes focused, there’s falling debris.’";
			sVerseX = "Impaled by an icicle, now there were three.";
			
			sVerseY = "Three then came upon, in a land made of ice,";
			sVerseZ = "That fortune they’d sought – the orb-like device.";
			sVerseAA = "But lightning erupted and death traveled through";
			sVerseAB = "The first one to touch it and now there were two.";
			
			sVerseAC = "Two stared at the orb in a land made of ice.";
			sVerseAD = "‘It better be worth it, we’ve paid a steep price.’";
			sVerseAE = "Orb wrapped in a cloth, they took off at a run.";
			sVerseAF = "Swift guardians gave chase, and then there was one.";
			
			sVerseAG = "One’s all that escaped from a land made of ice.";
			sVerseAH = "The moral’s complex, but I’ll keep it concise.";
			sVerseAI = "If you dare embark on adventurous trails";
			sVerseAJ = "Make sure the bard lives so he’ll tell your tales.";
			break;
			
        case 3:
            sVerseA = "Two dragons were having a night on the town,";
			sVerseB = "By living it up and by burning it down,";
			sVerseC = "One turned to the other and, taking a chance,";
			sVerseD = "Posed, 'Have a date yet for the big, formal dance?";
			
			sVerseE = "The other one sighed as he belched flame about,";
			sVerseF = "'The good ones are taken. I’ll sit this one out.'";
			sVerseG = "Then, dolefully, as o’er the village they flew,";
			sVerseH = "Said, 'and I have laundry and homework to do.'";
			
			sVerseI = "'Nonsense,' said the first, 'you don’t need a dozen.";
			sVerseJ = "I’ll set you up with my out-of-town cousin.";
			sVerseK = "She’s vulgar, disgusting, and wretchedly green";
			sVerseL = "And perfect for you, if you know what I mean.'";
			
			sVerseM = "'I guess I’ll accept, though I’m slightly inclined";
			sVerseN = "To flatly refuse for I’m going in blind.'";
			sVerseO = "As both flew toward home, the first shouted out, 'Great,";
			sVerseP = "I’ll tell her to stop by your cavern at eight.'";
			
			sVerseQ = "The night of the dance, he had polished his scales";
			sVerseR = "And sharpened the ridges on both of his tails.";
			sVerseS = "But, though he envisioned a fun night ahead,";
			sVerseT = "He couldn’t quite shake off a lingering dread.";
			
			sVerseU = "Outside a disturbance, a fearsome uproar,";
			sVerseV = "Foretold her arrival beyond the front door.";
			sVerseW = "He ran to discover, his angst to control,";
			sVerseX = "And beamed at her visage for she was a troll!";
			
			sVerseY = "Her posture was stooped, she had long, grisly nails,";
			sVerseZ = "And dragging behind her, she, too, had two tails.";
			sVerseAA = "A single, dark brow and severe underbite –";
			sVerseAB = "A vision of beauty – t’was love at first sight";
			
			sVerseAC = "Though she had grown out just half of a moustache,";
			sVerseAD = "The passion within him grew hot in a flash.";
			sVerseAE = "His mouth, with a smile, parted slight – just a crack –";
			sVerseAF = "Flames ushering forth, singed the hair on her back.";
			
			sVerseAG = "He stared as she panicked and rolled on the ground";
			sVerseAH = "Then, smoking, arose, pounded toward him and frowned.";
			sVerseAI = "'We’re finished,' she snarled, tossing a burnt bouquet";
			sVerseAJ = "Then spun on bare heels and swift rumbled away.";
			
			sVerseAK = "He begged her forgiveness, no, pled with his heart";
			sVerseAL = "That they could forget and pursue a fresh start.";
			sVerseAM = "Too late, she was gone, and had spurned his desire";
			sVerseAN = "For no one had told him: trolls do not like fire!";
			break;
			
			case 4:
            sVerseA = "Patrolling, I was unfulfilled so I took a sabbatical.";
			sVerseB = "I found the stage and tried my hand at theater, dramatical.";
			sVerseC = "But opportunities to ply my trade were quite sporadical.";
			sVerseD = "So I went to the Dragon Isles to seek a life piratical.";
			
			sVerseE = "Though you may not see at first glance – I’m really quite the radical.";
			sVerseF = "In truth you’ll never chance upon a fellow so dogmatical";
			sVerseG = "Regarding actions merciless and information nautical.";
			sVerseH = "And so I think I’ve found the perfect job – a life piratical.";
			
			sVerseI = "I’ll edify the crew with speeches vivid and grammatical –";
			sVerseJ = "Inspiring them to vict’ry with my presence charismatical.";
			sVerseK = "Just never mind my quirks – they’re simply idiosyncratical.";
			sVerseL = "It’s time to seize the moment, boys, and start a life piratical";
			
			sVerseM = "Don’t hesitate to take a leap, my counsel is pragmatical.";
			sVerseN = "Though if employment offered seems a bit too enigmatical";
			sVerseO = "Recall that life, just like the seas, is hardly hydrostatical";
			sVerseP = "Come join with me and you’ll enjoy a rousing life piratical.";
			
			sVerseQ = "In your pursuit of fame and fortune, be naught but fanatical";
			sVerseR = "And legendary bards will mark your deeds in verse ecstatical.";
			sVerseS = "You’ll quickly be a specialist in all things numismatical.";
			sVerseT = "Oh there’s no life – no other life – for me but life piratical.";
			break;
			
			case 5:
			sVerseA = "A cheerful, young minstrel was ambling along";
			sVerseB = "And, whilst in a crowd, he was piping a song.";
			sVerseC = "He glanced at the sky then knew something was wrong –";
			sVerseD = "He’d tripped on a cask and fell into the throng.";
			
			sVerseE = "'I meant to do that,' he cried from the earth –";
			sVerseF = "That clumsy young piper who stumbled from birth.";
			sVerseG = "He dusted his clothes and he shook out his hat";
			sVerseH = "And stood as he mumbled, 'I meant to do that.'";
			
			sVerseI = "He next found his way to a droll jubilee";
			sVerseJ = "Held out on the wharf where the sailors would be.";
			sVerseK = "While glancing at ships, he thought, 'that life’s for me'";
			sVerseL = "Then slipped on the pier and went into the sea.";
			
			sVerseM = "'I meant to do that,' he cried from the drink -";
			sVerseN = "That clumsy young piper who lived on the brink.";
			sVerseO = "He waded ashore as he kicked at a rat";
			sVerseP = "And shivering, mumbled, 'I meant to do that.'";
			
			sVerseQ = "The last he was seen was out on a high bluff";
			sVerseR = "Both singing and dancing – he can’t get enough.";
			sVerseS = "One moment he stood there and then, near the edge,";
			sVerseT = "Apparently tumbling, went over the ledge.";
			
			sVerseU = "'I meant to do that,' he was heard to exclaim –";
			sVerseV = "That clumsy young piper whose feet were his bane.";
			sVerseW = "He’s likely now flat as a reed-woven mat";
			sVerseX = "And no longer mumbling, 'I meant to do that.'";
			
			break;
			
			case 6:
			
			sVerseA = "I met a lass, when last we docked";
			sVerseB = "Upon the yonder quay";
			sVerseC = "And though I’d loved the sea so long";
			sVerseD = "The lass begged me to stay.";
			
			sVerseE = "I rushed to find my bosom mates";
			sVerseF = "All drinking ale inside.";
			sVerseG = "I stated my predicament";
			sVerseH = "And this is what they cried . . .";
			
			sVerseI = "You’ve one foot in the boat, my boy";
			sVerseJ = "And one foot on the shore.";
			sVerseK = "Now do you stay or do you go?";
			sVerseL = "Bah, come let’s go explore.";
			
			sVerseM = "Back to the lass I hurried then";
			sVerseN = "To have another glance –";
			sVerseO = "To hear again that honeyed voice";
			sVerseP = "And share a final dance.";
			
			sVerseQ = "The bosun’s rung the bell, my dear";
			sVerseR = "The time to part is nigh";
			sVerseS = "She held me tight with her embrace";
			sVerseT = "And whispered with a sigh . . .";
			
			sVerseU = "You’ve one foot in the boat, my dear,";
			sVerseV = "And one foot on the shore.";
			sVerseW = "I plead that you would stay, not go.";
			sVerseX = "Alas, please sail away no more.";
			
			sVerseY = "I fled the lass and wandered ‘round";
			sVerseZ = "And came upon a church";
			sVerseAA = "Within a cleric did I glimpse";
			sVerseAB = "Engaged in his research.";
			
			sVerseAC = "I pondered on the treach’rous sea";
			sVerseAD = "And woman’s false allure";
			sVerseAE = "Then sang aloud as I discerned";
			sVerseAF = "The path I should secure . . .";
			
			sVerseAG = "I’ve one foot in the boat, my lads,";
			sVerseAH = "And one foot on the shore,";
			sVerseAI = "But now I’ve found a simpler path . . .";
			sVerseAJ = "I’m needing one foot more.";
			
			sVerseAK = "Oh, despite the lass, despite the sea";
			sVerseAL = "A cautious life convinces me –";
			sVerseAM = "To lose all doubt and be set free . . .";
			sVerseAN = "I’m needing one . . . foot . . . moooooooore.";
			break;
			
			case 7:
			sVerseA = "On Rauvin’s southbank, hearsay abounded";
			sVerseB = "Commoners, nobles and knights were astounded";
			sVerseC = "It could not be true – seemed like a child’s wishing –";
			sVerseD = "Someone had spotted a white dragon fishing.";
			
			sVerseE = "'Used pole and a line,' a dockman contended,";
			sVerseF = "'And that’s not where all of the oddities ended.";
			sVerseG = "It had a lunch basket, took bait from a can,";
			sVerseH = "And, curious thing, was the size of a man.'";
			
			sVerseI = "'Not so,' then corrected a merchant of glass,";
			sVerseJ = "'You’ve far understated the beast’s proper mass.";
			sVerseK = "Though I wouldn’t saddle and ride one, of course,";
			sVerseL = "The dragon, to me, seemed as big as a horse.'";
			
			sVerseM = "Another cried, 'I, overhead, the skies searched";
			sVerseN = "And spied, on the Moonbridge, the great dragon perched";
			sVerseO = "And though I don’t mean your view to disparage";
			sVerseP = "The creature was equal the size of a carriage.'";
			
			sVerseQ = "'As big as a shoppe,' yet another proclaimed";
			sVerseR = "Before many others took turns, unashamed.";
			sVerseS = "'It rose like a ship from the river itself.'";
			sVerseT = "'Much more like a bridge, please examine yourself!'";
			
			sVerseU = "Unearthing the truth is now quite the hassle.";
			sVerseV = "Last one that I heard - it was big as a castle.";
			sVerseW = "There’s one thing alone that I know I am wishing";
			sVerseX = "That I could have spotted that white dragon fishing.";
			break;
			
			
			case 8:
			sVerseA = "A mounted lord once chanced upon";
			sVerseB = "A woman sowing wheat.";
			sVerseC = "With scorn he cast his eyes on her";
			sVerseD = "And vaulted from his seat.";
			
			sVerseE = "'Old hag,' he cried and bared his chest,";
			sVerseF = "'For you these wounds I’ve gained";
			sVerseG = "In battling ogres, orcs and gnolls,";
			sVerseH = "Protecting the untrained.'";
			
			sVerseI = "'While you, in safety, have done naught,";
			sVerseJ = "I’ve risked my life each day";
			sVerseK = "Driving pure evil from the land.";
			sVerseL = "Now, what have you to say?'";
			
			sVerseM = "The woman took the young lord’s hand";
			sVerseN = "And led him to a knoll.";
			sVerseO = "'Behold,' she said, 'the trees and grain.";
			sVerseP = "‘Tis Faerun’s very soul.'";
			
			sVerseQ = "The lord, entranced, stood marveling at";
			sVerseR = "The wonders of the world";
			sVerseS = "And, turning, saw no withered hag";
			sVerseT = "But Chauntea unfurled.";
			
			sVerseU = "Three seeds she placed within his palm –";
			sVerseV = "A flower, grain and tree.";
			sVerseW = "'Your eyes have awakened and";
			sVerseX = "You shall be truly free.'";
			
			sVerseY = "'Plant oak for strength and rose for peace";
			sVerseZ = "And wheat to sustain life.";
			sVerseAA = "Renounce your injudicious ways,";
			sVerseAB = "Till earth and take a wife.'";
			
			sVerseAC = "The lord obeyed – in fresh tilled fields";
			sVerseAD = "His wedding night was spent –";
			sVerseAE = "And he lived, pleased with all sixteen";
			sVerseAF = "Girls that Chauntea sent.";
			break;
			
			case 9:
			sVerseA = "A seeming tumult woke me from";
			sVerseB = "My long, unnatural slumber.";
			sVerseC = "A rusted sword I wield, and shield -";
			sVerseD = "Though, now just rotting lumber.";
			
			sVerseE = "I rise from murky shallows and";
			sVerseF = "Attach my severed head.";
			sVerseG = "This intruder would soon be slain";
			sVerseH = "For I was the undead.";
			
			sVerseI = "Bemoaning my own wretched state,";
			sVerseJ = "I fix upon my foe,";
			sVerseK = "Then lurching stiffly, shuffle forth,";
			sVerseL = "Wet, noxious weeds in tow.";
			
			sVerseM = "With gnashing teeth, I close to maim,";
			sVerseN = "My visage surely dire";
			sVerseO = "Yet unmoved he did calm remain,";
			sVerseP = "Just standing in the mire.";
			
			sVerseQ = "I roar and tear a loosened rib";
			sVerseR = "And pitch it at the fellow";
			sVerseS = "Who with a wave and proffered hand,";
			sVerseT = "Responds with but a 'Hello.'";
			
			sVerseU = "Deep within the Mere of Dead Men?";
			sVerseV = "Did I hear him rightly?";
			sVerseW = "Was he trying to befriend me –";
			sVerseX = "A creature so unsightly?";
			
			sVerseY = "Collapsing, quite despondent, and";
			sVerseZ = "Not knowing where I erred,";
			sVerseAA = "I pondered in my fetid pool –";
			sVerseAB = "He wasn’t even scared.";
			
			sVerseAC = "'You needn’t be ashamed, old chap,'";
			sVerseAD = "He offered with a pat.";
			sVerseAE = "'You’re really quite a sight, you see,";
			sVerseAF = "Rank, ghastly and all that.'";
			
			sVerseAG = "'But I have been around Faerun,";
			sVerseAH = "From Luskan to Skull Crag.";
			sVerseAI = "I’ve battled trolls in Evermoor,";
			sVerseAJ = "In Cormyr – slew a hag.'";
			
			sVerseAK = "'It’s quite a lovely spot you’ve here";
			sVerseAL = "Compared to what I’ve seen";
			sVerseAM = "And, fearsome though you seem to be,";
			sVerseAN = "You don’t come off as mean.'";
			
			sVerseAO = "He turned and voiced a final thought,";
			sVerseAP = "Ensuring I could hear,";
			sVerseAQ = "'You see, most of Faerun scares me so . . .";
			sVerseAR = "I holiday in the Mere.'";
			break;
			
			case 10:
			sVerseA = "We gazed into the moonlit skies";
			sVerseB = "And giggled at the kobold’s cries";
			sVerseC = "When tramping through the Silverywood late one summer’s eve.";
			
			sVerseD = "We carried military goods";
			sVerseE = "And even dragged them through the woods";
			sVerseF = "If we were but together, at least that’s what I believed.";
			
			sVerseG = "For like great text the end must come";
			sVerseH = "And even though you’re feeling numb";
			sVerseI = "You’ve got to forge ahead though you just really want to heave.";
			
			sVerseJ = "And that’s why . . .";
			
			sVerseK = "I’m on a ship to Mikona";
			sVerseL = "With a heart that is blown a . . .";
			sVerseM = "part, because my gal has left me for a mage.";
			
			sVerseN = "Just like this ol’ vessel’s reeling";
			sVerseO = "I’ve an unsteady feeling";
			sVerseP = "That our love is at the end of the page.";
			
			sVerseQ = "She was my finest ever fling,";
			sVerseR = "Felling orcs with every swing,";
			sVerseS = "And downing dwarven ale as if the tap would soon run dry.";
			
			sVerseT = "We delved together into caves,";
			sVerseU = "Held hands and dug up several graves,";
			sVerseV = "And every time I think of her it makes me want to cry.";
			
			sVerseW = "For like good text the end has come.";
			sVerseX = "I’ve gone from glee to purest glum.";
			sVerseY = "Yet still I’ve got to forge ahead and hold my chin up high.";
			
			sVerseZ = "And that’s why . . .";
			
			sVerseAA = "I’m on a ship to Mikona";
			sVerseAB = "With a heart that is blown a . . .";
			sVerseAC = "part, because my gal has left me for a mage.";
			
			sVerseAD = "Just like this ol’ vessel’s reeling";
			sVerseAE = "I’ve an unsteady feeling";
			sVerseAF = "That our love is at the end of the page.";
			
			sVerseAG = "When I debark what do I hope";
			sVerseAH = "Will help this poor, sad minstrel cope";
			sVerseAI = "With all the troubles that I’ve seen and give me some support?";
			
			sVerseAJ = "Should I, a hermit, then become?";
			sVerseAK = "Or drown my sorrows in some rum?";
			sVerseAL = "Why heck no! I’m going to look for a new female escort!";
			sVerseAM = "Better than the last one, too!";
			
			sVerseAN = "And that’s why . . .";
			
			sVerseAO = "I’m on a ship to Mikona";
			sVerseAP = "With a heart that is blown a . . .";
			sVerseAQ = "Part, because my gal has left me for a mage.";
			
			sVerseAR = "Just like this ol’ vessel’s reeling";
			sVerseAS = "I’ve an unsteady feeling";
			sVerseAT = "That our love is at the end of the page.";
			
			sVerseAU = "And thank Mielikki";
			
			sVerseAV = "Our love is at the end of the page.";
			
			sVerseAW = "She was ready for commitment. Not me.";
			
			sVerseAX = "Our love is finally and decisively . . .";
			sVerseAY = "at the end of the page.";
			break;
			
			case 11:
			sVerseA = "I’ve pondered something many days,";
			sVerseB = "It’s time to just be blunt.";
			sVerseC = "When venturing in unknown lands";
			sVerseD = "Why not the bard out front?";
			
			sVerseE = "He’s weak, you’ll say, and, truth be told,";
			sVerseF = "He tends to lose his place.";
			sVerseG = "But ere this notion’s flat dismissed,";
			sVerseH = "I plead you’ll hear my case.";
			
			sVerseI = "Imagine if we stumbled on";
			sVerseJ = "What seemed a frightful foe";
			sVerseK = "And they were greeted, not with swords,";
			sVerseL = "But a zany puppet show!";
			
			sVerseM = "Instead of shouts to, 'draw and charge!'";
			sVerseN = "Perhaps we’d join in song";
			sVerseO = "And dance a merry jig or two.";
			sVerseP = "I ask, 'what could go wrong?'";
			
			sVerseQ = "The spectacle that they would view,";
			sVerseR = "At first, with a bard ahead –";
			sVerseS = "Not cheerless greys of iron and steel,";
			sVerseT = "But brilliant hues instead.";
			
			sVerseU = "With saffron hats and pants of teal";
			sVerseV = "And cloaks of laurel green,";
			sVerseW = "They’d be so shocked, they’d not resist";
			sVerseX = "Such an enchanting scene.";
			
			sVerseY = "So I put forth, again, if we";
			sVerseZ = "Wish to avoid affront";
			sVerseAA = "When venturing in unknown lands,";
			sVerseAB = "Why not the bard out front?";
			break;
			
			case 12:
			sVerseA = "A cheerful, young wizard was stirring a brew";
			sVerseB = "And hoping to chance on a major breakthrough.";
			sVerseC = "He stepped in the pot and felt something askew –";
			sVerseD = "The potion exploded and caused a to-do.";
			
			sVerseE = "'I meant to do that,' he cried from the ground –";
			sVerseF = "That clumsy young wizard who bumbled around.";
			sVerseG = "He dusted his robes and he shook out his hat";
			sVerseH = "And stood as he mumbled, 'I meant to do that.'";
			
			sVerseI = "That cheerful, young wizard was next at the faire,";
			sVerseJ = "Exhibiting spells to the attendees there,";
			sVerseK = "When he stumbled backwards and tripped on a chair";
			sVerseL = "And turned a poor peasant into a brown bear";
			
			sVerseM = "'I meant to do that,' he cried as he fled –";
			sVerseN = "That clumsy young wizard’s repute was widespread.";
			sVerseO = "He ducked down an alley, passing a stray cat,";
			sVerseP = "And all heard his echo, 'I meant to do that.'";
			
			sVerseQ = "The cheerful, young wizard, last seen in the fen";
			sVerseR = "Was seeking to best a dragon in its den.";
			sVerseS = "He readied a wand but he stumbled again";
			sVerseT = "And was swallowed whole like ten previous men.";
			
			sVerseU = "'I meant to do that,' he was heard to exclaim";
			sVerseV = "That clumsy young wizard whose feet were to blame.";
			sVerseW = "In half a ten day he’ll be nothing but scat";
			sVerseX = "And no longer mumbling, 'I meant to do that.'";
			break;
			
			case 13:
			
			sVerseA = "Great hordes of brutal, savage orcs";
			sVerseB = "Swept down from on the rise";
			sVerseC = "And tried to drive us from the pass";
			sVerseD = "With their atrocious cries.";
			
			sVerseE = "Our hearts held firm, as did our line";
			sVerseF = "As we prepared to fall.";
			sVerseG = "We’d take a score or more along";
			sVerseH = "With us to Mithral’s Hall.";
			
			sVerseI = "Our arrows streaked into their ranks";
			sVerseJ = "Along with arcane might";
			sVerseK = "And as the beasts began to fall,";
			sVerseL = "We knew we’d win the fight!";
			
			sVerseM = "With drawn blades we then boldly strode";
			sVerseN = "Into their teeming pack,";
			sVerseO = "Which reeled and wavered in the face";
			sVerseP = "Of our intense attack.";
			
			sVerseQ = "An orcish druid and his dire wolf";
			sVerseR = "Spurred the remaining band";
			sVerseS = "Before they, too, took fatal blows";
			sVerseT = "And died there on the land.";
			
			sVerseU = "The last orc, from a final stroke";
			sVerseV = "Fell to the valley’s floor.";
			sVerseW = "To our surprise the death toll came";
			sVerseX = "To seven and three score.";
			
			sVerseY = "Though wounded, all, our mood was light –";
			sVerseZ = "We’d quite surpassed our skill.";
			sVerseAA = "At Silverymoon Pass the day was won";
			sVerseAB = "Through daring and sheer will.";
			break;
			
			case 14:
			sVerseJ = "*Strums a lute, without singing.";
			sVerseAD = "*Watches the audience, smiling.";
			break;
			
			case 15:
			sVerseE = "*Toe taps to the rhythm of the music.";
			sVerseW = "*Swings into a jaunty road song.";
			sVerseAY = "Thank you! I'm here all tenday!";
			break;
			
			case 16:
			sVerseS = "*Performs a sweet ballad.";
			sVerseAB= "*Runs fingers along strings in a set of scales.";
			break;
			
			case 17:
			sVerseA = "Thank you. Gonna take a little break now. Tip your waitress!";
			sVerseZ = "*Idly plucks chords.";
			sVerseAY = "*Sits up and swings lute to the front, tuning it as if break over.";
			break;
			
			case 18:
			sVerseH = "*Plays a sea shanty.";
			sVerseAB= "*Sings a comedic love song.";
			break;
			
			case 19:
			sVerseE = "*Sings a haunting love song.";
			sVerseW = "*Plucks soft notes as background music.";
			sVerseAY = "*Hums a tune, sometimes adding a bit of verse.";
			break;
			}	
		 
		 ActionPlayAnimation(ANIMATION_FIREFORGET_BOW, 1.0, 2.0);
		 DelayCommand(1.0, PlaySound("as_cv_lute1", FALSE));
		 if(sVerseA != "") {DelayCommand(2.0, ActionSpeakString(sVerseA, TALKVOLUME_TALK));}
         if(sVerseB != "") {DelayCommand(10.0, ActionSpeakString(sVerseB, TALKVOLUME_TALK));}
         if(sVerseC != "") {DelayCommand(15.0, ActionSpeakString(sVerseC, TALKVOLUME_TALK));}
         if(sVerseD != "") {DelayCommand(20.0, ActionSpeakString(sVerseD, TALKVOLUME_TALK));}
         if(sVerseE != "") {DelayCommand(25.0, ActionSpeakString(sVerseE, TALKVOLUME_TALK));}
         if(sVerseF != "") {DelayCommand(30.0, ActionSpeakString(sVerseF, TALKVOLUME_TALK));}
         if(sVerseG != "") {DelayCommand(35.0, ActionSpeakString(sVerseG, TALKVOLUME_TALK));}
         if(sVerseH != "") {DelayCommand(40.0, ActionSpeakString(sVerseH, TALKVOLUME_TALK));}
         if(sVerseI != "") {DelayCommand(45.0, ActionSpeakString(sVerseI, TALKVOLUME_TALK));}
         if(sVerseJ != "") {DelayCommand(50.0, ActionSpeakString(sVerseJ, TALKVOLUME_TALK));}
         if(sVerseK != "") {DelayCommand(55.0, ActionSpeakString(sVerseK, TALKVOLUME_TALK));}
         if(sVerseL != "") {DelayCommand(60.0, ActionSpeakString(sVerseL, TALKVOLUME_TALK));}
         if(sVerseM != "") {DelayCommand(65.0, ActionSpeakString(sVerseM, TALKVOLUME_TALK));}
         if(sVerseN != "") {DelayCommand(70.0, ActionSpeakString(sVerseN, TALKVOLUME_TALK));}
         if(sVerseO != "") {DelayCommand(75.0, ActionSpeakString(sVerseO, TALKVOLUME_TALK));}
         if(sVerseP != "") {DelayCommand(80.0, ActionSpeakString(sVerseP, TALKVOLUME_TALK));}
         if(sVerseQ != "") {DelayCommand(85.0, ActionSpeakString(sVerseQ, TALKVOLUME_TALK));}
         if(sVerseR != "") {DelayCommand(90.0, ActionSpeakString(sVerseR, TALKVOLUME_TALK));}
         if(sVerseS != "") {DelayCommand(95.0, ActionSpeakString(sVerseS, TALKVOLUME_TALK));}
         if(sVerseT != "") {DelayCommand(100.0, ActionSpeakString(sVerseT, TALKVOLUME_TALK));}
         if(sVerseU != "") {DelayCommand(105.0, ActionSpeakString(sVerseU, TALKVOLUME_TALK));}
         if(sVerseV != "") {DelayCommand(110.0, ActionSpeakString(sVerseV, TALKVOLUME_TALK));}
         if(sVerseW != "") {DelayCommand(115.0, ActionSpeakString(sVerseW, TALKVOLUME_TALK));}
         if(sVerseX != "") {DelayCommand(120.0, ActionSpeakString(sVerseX, TALKVOLUME_TALK));}
         if(sVerseY != "") {DelayCommand(125.0, ActionSpeakString(sVerseY, TALKVOLUME_TALK));}
         if(sVerseZ != "") {DelayCommand(130.0, ActionSpeakString(sVerseZ, TALKVOLUME_TALK));}
         if(sVerseAA != "") {DelayCommand(135.0, ActionSpeakString(sVerseAA, TALKVOLUME_TALK));}
         if(sVerseAB != "") {DelayCommand(140.0, ActionSpeakString(sVerseAB, TALKVOLUME_TALK));}
         if(sVerseAC != "") {DelayCommand(145.0, ActionSpeakString(sVerseAC, TALKVOLUME_TALK));}
         if(sVerseAD != "") {DelayCommand(150.0, ActionSpeakString(sVerseAD, TALKVOLUME_TALK));}
         if(sVerseAE != "") {DelayCommand(155.0, ActionSpeakString(sVerseAE, TALKVOLUME_TALK));}
         if(sVerseAF != "") {DelayCommand(160.0, ActionSpeakString(sVerseAF, TALKVOLUME_TALK));}
         if(sVerseAG != "") {DelayCommand(165.0, ActionSpeakString(sVerseAG, TALKVOLUME_TALK));}
         if(sVerseAH != "") {DelayCommand(170.0, ActionSpeakString(sVerseAH, TALKVOLUME_TALK));}
         if(sVerseAI != "") {DelayCommand(175.0, ActionSpeakString(sVerseAI, TALKVOLUME_TALK));}
         if(sVerseAJ != "") {DelayCommand(180.0, ActionSpeakString(sVerseAJ, TALKVOLUME_TALK));}
         if(sVerseAK != "") {DelayCommand(185.0, ActionSpeakString(sVerseAK, TALKVOLUME_TALK));}
         if(sVerseAL != "") {DelayCommand(190.0, ActionSpeakString(sVerseAL, TALKVOLUME_TALK));}
         if(sVerseAM != "") {DelayCommand(195.0, ActionSpeakString(sVerseAM, TALKVOLUME_TALK));}
         if(sVerseAN != "") {DelayCommand(200.0, ActionSpeakString(sVerseAN, TALKVOLUME_TALK));}
         if(sVerseAO != "") {DelayCommand(205.0, ActionSpeakString(sVerseAO, TALKVOLUME_TALK));}
         if(sVerseAP != "") {DelayCommand(210.0, ActionSpeakString(sVerseAP, TALKVOLUME_TALK));}
         if(sVerseAQ != "") {DelayCommand(215.0, ActionSpeakString(sVerseAQ, TALKVOLUME_TALK));}
         if(sVerseAR != "") {DelayCommand(220.0, ActionSpeakString(sVerseAR, TALKVOLUME_TALK));}
         if(sVerseAS != "") {DelayCommand(225.0, ActionSpeakString(sVerseAS, TALKVOLUME_TALK));}
         if(sVerseAT != "") {DelayCommand(230.0, ActionSpeakString(sVerseAT, TALKVOLUME_TALK));}
         if(sVerseAU != "") {DelayCommand(235.0, ActionSpeakString(sVerseAU, TALKVOLUME_TALK));}
         if(sVerseAV != "") {DelayCommand(240.0, ActionSpeakString(sVerseAV, TALKVOLUME_TALK));}
         if(sVerseAW != "") {DelayCommand(245.0, ActionSpeakString(sVerseAW, TALKVOLUME_TALK));}
         if(sVerseAX != "") {DelayCommand(250.0, ActionSpeakString(sVerseAX, TALKVOLUME_TALK));}
         if(sVerseAY != "") {DelayCommand(255.0, ActionSpeakString(sVerseAY, TALKVOLUME_TALK));}
         
		 }
		
}