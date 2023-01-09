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
	AssignCommand(oStudent, ActionSpeakString("*Audible laughter suddenly rolls in the air around all present* Ladies and gentlemen! Children of all ages! Welcome to the spectacle! *Changes to a confiding stage whisper* My new bobcat sends his regards. Now. ON WITH THE SHOW!", TALKVOLUME_TALK));	 
	SendMessageToPC(oStudent, "The whistle you just blew seems to cut through your brain, echoing, jangling your nerves.");
	DelayCommand(90.0, SendMessageToPC(oStudent, "A jangling in your nerves grows worse. You feel a sense of oncoming dread, and hear a distant clamor of many female voices, shrieking in the back of your mind."));	  
	
	DelayCommand(399.0, SetLocalInt(oStudent, "HarpyMsg", 2));
	DelayCommand(300.0, ExecuteScript("slv_static_voice_harpy_create", oStudent));
	
	DelayCommand(549.0, SetLocalInt(oStudent, "HarpyMsg", 3));
	DelayCommand(550.0, ExecuteScript("slv_static_voice_harpy_create", oStudent));
	
	DelayCommand(799.0, SetLocalInt(oStudent, "HarpyMsg", 4));
	DelayCommand(800.0, ExecuteScript("slv_static_voice_harpy_create", oStudent));
	
	DelayCommand(899.0, SetLocalInt(oStudent, "HarpyMsg", 5));
	DelayCommand(900.0, ExecuteScript("slv_static_voice_harpy_create", oStudent));
	
	
	}				

}			  