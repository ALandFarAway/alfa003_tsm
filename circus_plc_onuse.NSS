//OnUse for all Circus placeables 
//Wynna May 2015


#include "acr_placeable_i"

const int SwimmingWaterGenasi=3520; 

void main()
{
	ACR_PlaceableOnUsed();
     object oPC = GetLastUsedBy();
	 
	 
	if(FindSubString(GetTag(OBJECT_SELF), "circus_ladder", 0) != -1)
		{location lClimb = GetLocation(GetWaypointByTag(GetTag(OBJECT_SELF) + "_WP"));
		 string sDown="";
		 if(FindSubString(GetTag(OBJECT_SELF), "_dn", 0) != -1)
		 	{sDown="down ";}
		 SpeakString("You climb " + sDown + "the ladder", TALKVOLUME_TALK);
		 DelayCommand(1.0, AssignCommand(oPC, ActionJumpToLocation(lClimb)));
		}
		
	if(FindSubString(GetTag(OBJECT_SELF), "xyz_mirror", 0) != -1)
		{//SendMessageToPC(oPC, "Mytag=" + GetTag(OBJECT_SELF));
		 object oGo = GetWaypointByTag(GetTag(OBJECT_SELF) + "_wp");
		 location lGo = GetLocation(oGo);
		 //SendMessageToPC(oPC, "Desttag=" + GetTag(oGo));
		 DelayCommand(1.0, AssignCommand(oPC, ActionJumpToLocation(lGo)));
		}
	
	if(FindSubString(GetTag(OBJECT_SELF), "standard_animation", 0) != -1)
		{ActionSpeakString("Ready?", TALKVOLUME_TALK);
		 AssignCommand(oPC, ActionSpeakString("Yes."));
		 int nAnimation;
		 if(GetTag(OBJECT_SELF) == "standard_animation_up")
		 	{nAnimation = GetLocalInt(oPC, "nAnimation") + 1;}
		 if(GetTag(OBJECT_SELF) == "standard_animation_down")
		 	{nAnimation = GetLocalInt(oPC, "nAnimation") - 1;}
		 SetLocalInt(oPC, "nAnimation", nAnimation);
		 AssignCommand(oPC, ActionSpeakString("Animation " + IntToString(nAnimation)));
		 int nConstant=0;
		 if(nAnimation == 1)
		 	{nConstant = ANIMATION_FIREFORGET_ACTIVATE;}
		 else if(nAnimation == 2)
		 	{nConstant = ANIMATION_FIREFORGET_BARDSONG;}
		 else if(nAnimation == 3)
		 	{nConstant = ANIMATION_FIREFORGET_BOW;}
		 else if(nAnimation == 4)
		 	{nConstant = ANIMATION_FIREFORGET_CHUCKLE;}
		 else if(nAnimation == 5)
		 	{nConstant = ANIMATION_FIREFORGET_COLLAPSE;}
		 else if(nAnimation == 6)
		 	{nConstant = ANIMATION_FIREFORGET_DODGE_DUCK;}
		 else if(nAnimation == 7)
		 	{nConstant = ANIMATION_FIREFORGET_DODGE_SIDE;}
		 else if(nAnimation == 8)
		 	{nConstant = ANIMATION_FIREFORGET_DRINK;}
		 else if(nAnimation == 9)
		 	{nConstant = ANIMATION_FIREFORGET_DRUMIDLEFIDGET;}
		 else if(nAnimation == 10)
		 	{nConstant = ANIMATION_FIREFORGET_FLUTEIDLEFIDGET;}
		 else if(nAnimation == 11)
		 	{nConstant = ANIMATION_FIREFORGET_GREETING;}
		 else if(nAnimation == 12)
		 	{nConstant = ANIMATION_FIREFORGET_GUITARIDLEFIDGET;}
		 else if(nAnimation == 13)
		 	{nConstant = ANIMATION_FIREFORGET_HEAD_TURN_LEFT;}
		 else if(nAnimation == 14)
		 	{nConstant = ANIMATION_FIREFORGET_HEAD_TURN_RIGHT;}
		 else if(nAnimation == 15)
		 	{nConstant = ANIMATION_FIREFORGET_INTIMIDATE;}
		 else if(nAnimation == 16)
		 	{nConstant = ANIMATION_FIREFORGET_KNEELDAMAGE;}
		 else if(nAnimation == 17)
		 	{nConstant = ANIMATION_FIREFORGET_KNEELDEATH;}
		 else if(nAnimation == 18)
		 	{nConstant = ANIMATION_FIREFORGET_KNEELFIDGET;}
		 else if(nAnimation == 19)
		 	{nConstant = ANIMATION_FIREFORGET_KNEELTALK;}
		 else if(nAnimation == 20)
		 	{nConstant = ANIMATION_FIREFORGET_KNEELTALK;}
		 else if(nAnimation == 21)
		 	{nConstant = ANIMATION_FIREFORGET_LAYDOWN;}
		 else if(nAnimation == 22)
		 	{nConstant = ANIMATION_FIREFORGET_PAUSE_BORED;}
		 else if(nAnimation == 23)
		 	{nConstant = ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD;}
		 else if(nAnimation == 24)
		 	{nConstant = ANIMATION_FIREFORGET_READ;}
		 else if(nAnimation == 25)
		 	{nConstant = ANIMATION_FIREFORGET_SALUTE;}
		 else if(nAnimation == 26)
		 	{nConstant = ANIMATION_FIREFORGET_SEARCH;}
		 else if(nAnimation == 27)
		 	{nConstant = ANIMATION_FIREFORGET_SPASM;}
		 else if(nAnimation == 28)
		 	{nConstant = ANIMATION_LOOPING_SIT_CROSS;}
		 else if(nAnimation == 29)
		 	{nConstant = ANIMATION_FIREFORGET_STANDUP;}
		 else if(nAnimation == 30)
		 	{nConstant = ANIMATION_FIREFORGET_STEAL;}
		 else if(nAnimation == 31)
		 	{nConstant = ANIMATION_FIREFORGET_TAUNT;}
		 else if(nAnimation == 32)
		 	{nConstant = ANIMATION_FIREFORGET_USEITEM;}
		 else if(nAnimation == 33)
		 	{nConstant = ANIMATION_FIREFORGET_VICTORY1;}
		 else if(nAnimation == 34)
		 	{nConstant = ANIMATION_FIREFORGET_VICTORY2;}
		 else if(nAnimation == 35)
		 	{nConstant = ANIMATION_FIREFORGET_VICTORY3;}
		 else if(nAnimation == 36)
		 	{nConstant = ANIMATION_FIREFORGET_WILDSHAPE;}
		 else if(nAnimation == 37)
		 	{nConstant = ANIMATION_LOOPING_BOXCARRY;}
		 else if(nAnimation == 38)
		 	{nConstant = ANIMATION_LOOPING_BOXHURRIED;}
		 else if(nAnimation == 39)
		 	{nConstant = ANIMATION_LOOPING_BOXIDLE;}
		 else if(nAnimation == 40)
		 	{nConstant = ANIMATION_LOOPING_CAST1;}
		 else if(nAnimation == 41)
		 	{nConstant = ANIMATION_LOOPING_CONJURE1;}
		 else if(nAnimation == 42)
		 	{nConstant = ANIMATION_LOOPING_CONJURE2;}
		 else if(nAnimation == 43)
		 	{nConstant = ANIMATION_LOOPING_COOK01;}
		 else if(nAnimation == 44)
		 	{nConstant = ANIMATION_LOOPING_COOK02;}
		 else if(nAnimation == 45)
		 	{nConstant = ANIMATION_LOOPING_CRAFT01;}
		 else if(nAnimation == 46)
		 	{nConstant = ANIMATION_LOOPING_DANCE01;}
		 else if(nAnimation == 47)
		 	{nConstant = ANIMATION_LOOPING_DANCE02;}
		 else if(nAnimation == 48)
		 	{nConstant = ANIMATION_LOOPING_DANCE03;}
		 else if(nAnimation == 49)
		 	{nConstant = ANIMATION_LOOPING_DEAD_BACK;}
		 else if(nAnimation == 50)
		 	{nConstant = ANIMATION_LOOPING_DEAD_FRONT;}
		 else if(nAnimation == 51)
		 	{nConstant = ANIMATION_LOOPING_DRUMIDLE;}
		 else if(nAnimation == 52)
		 	{nConstant = ANIMATION_LOOPING_DRUMPLAY;}
		 else if(nAnimation == 53)
		 	{nConstant = ANIMATION_LOOPING_FLUTEIDLE;}
		 else if(nAnimation == 54)
		 	{nConstant = ANIMATION_LOOPING_FLUTEPLAY;}
		 else if(nAnimation == 55)
		 	{nConstant = ANIMATION_LOOPING_FORGE01;}
		 else if(nAnimation == 56)
		 	{nConstant = ANIMATION_LOOPING_GET_LOW;}
		 else if(nAnimation == 57)
		 	{nConstant = ANIMATION_LOOPING_GET_MID;}
		 else if(nAnimation == 58)
		 	{nConstant = ANIMATION_LOOPING_GUITARIDLE;}
		 else if(nAnimation == 59)
		 	{nConstant = ANIMATION_LOOPING_GUITARPLAY;}
		 else if(nAnimation == 60)
		 	{nConstant = ANIMATION_LOOPING_INJURED;}
		 else if(nAnimation == 61)
		 	{nConstant = ANIMATION_LOOPING_KNEELIDLE;}
		 else if(nAnimation == 62)
		 	{nConstant = ANIMATION_LOOPING_LISTEN;}
		 else if(nAnimation == 63)
		 	{nConstant = ANIMATION_LOOPING_LOOK_FAR;}
		 else if(nAnimation == 64)
		 	{nConstant = ANIMATION_LOOPING_LOOKDOWN;}
		 else if(nAnimation == 65)
		 	{nConstant = ANIMATION_LOOPING_LOOKLEFT;}
		 else if(nAnimation == 66)
		 	{nConstant = ANIMATION_LOOPING_LOOKRIGHT;}
		 else if(nAnimation == 67)
		 	{nConstant = ANIMATION_LOOPING_LOOKUP;}
		 else if(nAnimation == 68)
		 	{nConstant = ANIMATION_LOOPING_MEDITATE;}
		 else if(nAnimation == 69)
		 	{nConstant = ANIMATION_LOOPING_PAUSE;}
		 else if(nAnimation == 70)
		 	{nConstant = ANIMATION_LOOPING_PAUSE_DRUNK;}
		 else if(nAnimation == 71)
		 	{nConstant = ANIMATION_LOOPING_PAUSE_TIRED;}
		 else if(nAnimation == 72)
		 	{nConstant = ANIMATION_LOOPING_PAUSE2;}
		 else if(nAnimation == 73)
		 	{nConstant = ANIMATION_LOOPING_PRONE;}
		 else if(nAnimation == 74)
		 	{nConstant = ANIMATION_LOOPING_SHOVELING;}
		 else if(nAnimation == 75)
		 	{nConstant = ANIMATION_LOOPING_SIT_CHAIR;}
		 else if(nAnimation == 76)
		 	{nConstant = ANIMATION_LOOPING_TALK_FORCEFUL;}
		 else if(nAnimation == 77)
		 	{nConstant = ANIMATION_LOOPING_TALK_LAUGHING;}
		 else if(nAnimation == 78)
		 	{nConstant = ANIMATION_LOOPING_TALK_NORMAL;}
		 else if(nAnimation == 79)
		 	{nConstant = ANIMATION_LOOPING_TALK_PLEADING;}
		 else if(nAnimation == 80)
		 	{nConstant = ANIMATION_LOOPING_WORSHIP;}
		 	
		 AssignCommand(oPC, ActionPlayAnimation(nConstant, 1.0, 5.0));
		}

		 
}