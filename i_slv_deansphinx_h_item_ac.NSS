//Silvy Uni Item onactivate
//Wynna February 2020


#include "acr_items_i"
#include "acr_spawn_i"
#include "acr_tools_i"
#include "acr_db_persist_i"
#include "acr_quest_i"


void main()
{	object oItem = GetItemActivated();
 	object oStudent = GetItemActivator();
	string sName = GetName(oStudent);
	object oArea = GetArea(oStudent);
	location lStudent = GetLocation(oStudent);
	object oWhistle = OBJECT_SELF;
	
	 if((FindSubString(GetTag(oArea), "6d_int_silvy") != -1) || (GetLocalInt(oArea, "IS_SILVERYMOON_EXT"))) 
		{AssignCommand(oStudent, ActionSpeakString(sName + " tries to blow a silver whistle, but no sound comes out.*", TALKVOLUME_TALK));	 
	}
		
	else {
	SetLocalObject(oStudent, "oWhistle", oWhistle);
	SendMessageToAllDMs(sName + " just used the Whistle of Discord to summon harpies in area " + GetName(oArea));					 
    AssignCommand(oStudent, ActionSpeakString(sName + " blows a shrieking, discordant blast on the whistle. It sets teeth on edge and grates in your bones. Somewhere, in the back of your mind, you seem to hear a startled squawk, and then an inaudible blast of pure rage.", TALKVOLUME_TALK));	 
	AssignCommand(oStudent, ActionSpeakString("*Audible laughter suddenly rolls in the air around all present* Ladies and gentlemen! Children of all ages! Welcome to the spectacle! *Changes to a confiding stage whisper* You really shouldn't believe everything you read. Now. ON WITH THE SHOW!", TALKVOLUME_TALK));	 
	SendMessageToPC(oStudent, "The whistle you just blew seems to cut through your brain, echoing, jangling your nerves. You continue to hear it for five minutes.");
	DelayCommand(300.0, SendMessageToPC(oStudent, "A jangling in your nerves grows worse. You feel a sense of oncoming dread, and hear a distant clamor of many female voices, shrieking in the wind."));	  
	DelayCommand(600.0, SendMessageToPC(oStudent, "The sense of coming doom continues to grow. You feel marked. Far, far off over the northern horizon, specks pepper the sky. Too small for even the best eyes to make out, perhaps even your imagination."));	  
	DelayCommand(750.0, SendMessageToPC(oStudent, "Those specks are not your imagination. They are growing, clearly winged figues too large for birds, a flock of something speeding in your direction. How many is hard to tell. A handful? Less than five. They come from the northeast, but they could swoop in from any direction."));	  
	DelayCommand(900.0, SendMessageToPC(oStudent, "The enraged shrieking of the flying creatures is audible. At their speed, they will be here in less than a minute."));	  
	if(GetIsSkillSuccessful(OBJECT_SELF, SKILL_SPOT,10,TRUE)) {
		DelayCommand(930.0, SendMessageToPC(oStudent, "The oncoming creatures are close enough that you can count them, and see what you are about to face. Harpies. Four of them."));	  
	}
	
	DelayCommand(960.0, ExecuteScript("slv_static_voice_harpy_create", oStudent));
	}				

}			  