////////////////////////////////////////////////////////////////////////////////
//
//    Filename : npc_onperception_nymph
//    Date:: 2022-12-12  
//    Author : Wynna
//
//   
//  Description: Put this in the nymph's onperception slot. Fill in the quasit's tag in line 18 below
// 

#include "acr_creature_i"
 
void main()
{
    ACR_CreatureOnPerception();
	object oPerceived = GetLastPerceived();
	object oNymph = OBJECT_SELF;
	object oQuasit = GetNearestObjectByTag("QUASIT_TAG", OBJECT_SELF, 1);
	string n1 = "Oh, thank goodness you’ve come! Please free me! I’ve been trapped here for centuries!";
	string q1 = "Don’t listen to her! She’s evil! Free me and I’ll tell you how to escape!";
	string n2 = "Please save me! You don’t know what it’s been like in this tower with this – this – this fiend for all these years!";
	string q2 = "She’s lying! She’ll lead you to a trap! Let me free!";
	string n3 = "See the control panel? Push the far left button. It will free me. I will reward you if you free me!";
	string q3 = "NO! Don’t listen to her! She’ll trap you! Push the middle button. All the others are traps!";
	string n4 = "No, they’re not traps! The right button lifts the cage on the stairs, and the left button frees me. You can pass up the stairs if you’d like. But please, free me first!";
	string q4 = "Don’t fall for it! She’s evil! Only the middle button isn’t a trap!";
	
	if((GetLocalInt(OBJECT_SELF, "Fired") == 0) && (GetLastPerceptionSeen()))
		{SetLocalInt(OBJECT_SELF, "Fired", 1);
		 ClearAllActions(TRUE);
		 AssignCommand(oQuasit, ClearAllActions(TRUE));
		 ActionSpeakString(n1, TALKVOLUME_TALK);
		 DelayCommand(6.0, AssignCommand(oQuasit, ActionSpeakString(q1, TALKVOLUME_TALK)));
		 DelayCommand(12.0, ActionSpeakString(n2, TALKVOLUME_TALK));
		 DelayCommand(18.0, AssignCommand(oQuasit, ActionSpeakString(q2, TALKVOLUME_TALK)));
		 DelayCommand(24.0, ActionSpeakString(n3, TALKVOLUME_TALK));
		 DelayCommand(30.0, AssignCommand(oQuasit, ActionSpeakString(q3, TALKVOLUME_TALK)));
		 DelayCommand(36.0, ActionSpeakString(n4, TALKVOLUME_TALK));
		 DelayCommand(42.0, AssignCommand(oQuasit, ActionSpeakString(q4, TALKVOLUME_TALK)));
		 }
}