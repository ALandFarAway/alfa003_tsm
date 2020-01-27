//OnUse for all Dean's Exam (deandragon) placeables 
//Wynna February 2009


#include "acr_placeable_i"
#include "acr_xp_i"
#include "acr_quest_i"






void main()
{
	ACR_PlaceableOnClick();

	object oUser = GetClickingObject();
	
   
	//deansphinx_Z crystal ball
   if((GetTag(OBJECT_SELF) == "slv_maze_crystal") && (ACR_RetrieveQuestState("slv_deansphinx_z", oUser) == 2))
      	{ActionSpeakString("Congratulations! *A thin and quavering voice, sounding aged and somewhat querulous despite the words delivered* You have successfully marched to the end of the research stage of your campaign for knowledge.", TALKVOLUME_TALK);
		 DelayCommand(10.0, ActionSpeakString("As you are standing here, you have worked out the complete key phrase that you are to give to the gatekeeper, along with a complete set of keyed draft pages, each revised with the essence of one animal of the Marches.", TALKVOLUME_TALK));
		 DelayCommand(20.0, ActionSpeakString("You may march on now in Oghma's vanguard to the fieldwork stage of your quest, or you may provision and seek your own way to the gatekeeper at a later time.", TALKVOLUME_TALK));
		 DelayCommand(30.0, ActionSpeakString("It is Lhaeo's tome we seek to rebind, but revised for the Silver Marches. This goal does encourage haste, despite an old man's growing need...to bring this project to completion.", TALKVOLUME_TALK));
		 DelayCommand(40.0, ActionSpeakString("My colleague, Mamid Gasen, conceived this goal decades past, and roped me in but lately, but I am now as enmeshed in this project as any, by means of oracular insight. The same oracular insights that you have followed through this maze today.", TALKVOLUME_TALK));
		 DelayCommand(50.0, ActionSpeakString("The gods of knowledge have provided this path, and we may only follow it where they have led. Your final task  is to carry the complete A - Z set of revised draft pages through the unmarked door out of this room. Oghma willing, success shall be on the other side to greet you. Be prepared, warriors of knowledge, for soon you charge the barricades of ignorance!", TALKVOLUME_TALK));
		 DelayCommand(50.0, ACR_AddPersistentJournalQuestEntry("slv_deansphinx_z", 3,oUser,  FALSE, FALSE, FALSE, FALSE));
		}

}